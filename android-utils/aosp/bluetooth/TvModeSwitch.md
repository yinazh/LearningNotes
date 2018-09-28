#20180801
# To switch Bluetooth Mode  

> AdapterService.setDeviceMode(deviceMode);
```java
/*
* args:
* * true : HEADSET_MODE 1
* * false: DEFAULT_MODE 0
*/
Message msg = mAdapterStateMachine.
             obtainMessage(AdapterState.USER_DEVICE_MODE_SWITCH);
        msg.arg1 = deviceMode;
        mAdapterStateMachine.sendMess--> Adapteage(msg);
```  
> AdapterState  
```java
OnState-->enter()
       -->processMessage()-->transitionTo(mPendingCommandState);
                          -->sendMessage(DEVICE_MODE_DISCONNECT_PROFILES);
```
> PendingCommandState
```java  
PendingCommandState-->enter()  
                   -->processMessage()-->mAdapterService.disconnectDeviceModeProfiles();-->断开所有的蓝牙连接
                                       -->sendMessageDelayed(DEVICE_MODE_CHECK_DISCONNECTED_PROFILES, 300);-->{
                                                    boolean isDisconnected =
                                                            mAdapterService.isDeviceModeProfilesDisconnected();
                                                    mDisconnectCheckCount++;
                                                    if (!isDisconnected &&
                                                            (mDisconnectCheckCount < DEVICE_MODE_SWITCH_DISCONNECT_CHECK_MAX)) {
                                                        Log.d(TAG, "Device mode profile still not disconnected");
                                                        sendMessageDelayed(DEVICE_MODE_CHECK_DISCONNECTED_PROFILES, 300);
                                                    } else {
                                                        Log.d(TAG, "all devices disconnected successful");
                                                        mPendingCommandState.setDeviceModeSwitchTurningOff(true);//模式开关关闭
                                                        sendMessage(DEVICE_MODE_SWITCH_SERVICES_TURN_OFF);
                                                    }  
                                                }-->sendMessage(DEVICE_MODE_SWITCH_SERVICES_TURN_OFF)-->{
                                                        if (AdapterService.HEADSET_MODE == mPendingDeviceModeState) {
                                                             // Turn off Default mode
                                                             if(!mAdapterService.
                                                                 setProfileStateForDeviceModeSwitch(
                                                                     AdapterService.DEFAULT_MODE, false)) {
                                                                 Log.e(TAG, "No services to turn OFF HEADSET_MODE");
                                                                 sendMessage(DEVICE_MODE_SWITCH_SERVICES_TURNED_OFF);
                                                             }
                                                         } else if (AdapterService.DEFAULT_MODE == mPendingDeviceModeState) {
                                                             // Turn off Headset mode
                                                             if(!mAdapterService.
                                                                 setProfileStateForDeviceModeSwitch(
                                                                     AdapterService.HEADSET_MODE, false)) {
                                                                 Log.e(TAG, "No services to turn OFF DEFAULT_MODE");
                                                                 sendMessage(DEVICE_MODE_SWITCH_SERVICES_TURNED_OFF);-->{
                                                                          //对蓝牙模式开关进行置位
                                                                          mIsDeviceModeSwitchTurningOff  = false;
                                                                      }
                                                             }
                                                         }
                                                         mIsDeviceModeSwitchTurningOff = true;
                                                    }-->{
                                                        Class[] supportedProfileServices = ProfileConfig.getSupportedProfiles();
                                                         for (int i=0; i < supportedProfileServices.length;i++) {
                                                             String profileName = supportedProfileServices[i].getName(PendingCommandState);
                                                             if (ProfileConfig.isPhoneModeProfile(profileName)){
                                                                 ProfileConfig.saveProfileSetting(profileName, enable);//配置重置状态，ContentResolver()
                                                                 setProfileState(profileName, enable);//-->{//关于蓝牙的各个服务通知状态
                                                                             intent.putExtra(EXTRA_ACTION,ACTION_SERVICE_STATE_CHANGED);
                                                                             intent.putExtra(BluetoothAdapter.EXTRA_STATE,setEnabled?
                                                                                     BluetoothAdapter.STATE_ON:BluetoothAdapter.STATE_OFF);
                                                                        }-->{ ProfileService.java->onStartCommand()
                                                                            String action = intent.getStringExtra(AdapterService.EXTRA_ACTION);
                                                                             if (AdapterService.ACTION_SERVICE_STATE_CHANGED.equals(action)) {
                                                                                 int state= intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, BluetoothAdapter.ERROR);
                                                                                 if(state==BluetoothAdapter.STATE_OFF) {
                                                                                     Log.d(mName, "Received stop request...Stopping profile...");
                                                                                     doStop(intent);
                                                                                 } else if (state == BluetoothAdapter.STATE_ON) {
                                                                                     Log.d(mName, "Received start request. Starting profile...");
                                                                                     doStart(intent);
                                                                                 }
                                                                             }-->{
                                                                                  notifyProfileServiceStateChanged(BluetoothAdapter.STATE_OFF);
                                                                                  stopSelf();
                                                                             }
                                                                        }
                                                                 if (!profileStateSet)
                                                                     profileStateSet = true;
                                                             } else {
                                                                 Log.w(TAG,"Profile not configured for Device Mode Cfg: "  + profileName);
                                                             }
                                                         }
                                                    }
```
switch Bluetooth mode end

# Open Bluetooth after boot complete
                      　　　　　　　　　　　　　
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
