#关于蓝牙扫描部分解析
LocalBluetoothAdapter封装蓝牙部分操作供应用部分及其他模块使用
提供了如下方法：
enable()，　disable()
setScanMode()　设置蓝牙的扫描模式
```java
public void startScanning(boolean){
  　　// Only start if we're not already scanning
     if (!mAdapter.isDiscovering()) {.....}
}
```
```java
public void stopScanning(){
    if (mAdapter.isDiscovering()) {
        mAdapter.cancelDiscovery();
    }
}
```
上面提供的方法，间接调用BluetoothAdapter的方法
(framework/base/core/java/android/bluetooth/BluetoothAdapter.java 提供基础蓝牙操作)
其中对应扫描部分调用到的方法：
```java
@RequiresPermission(Manifest.permission.BLUETOOTH)
   public boolean isDiscovering() {
       if (getState() != STATE_ON) return false;
       try {
           synchronized(mManagerCallback) {
               if (mService != null ) return mService.isDiscovering();
           }
       } catch (RemoteException e) {Log.e(TAG, "", e);}
       return false;
   }
```

```java
@RequiresPermission(Manifest.permission.BLUETOOTH_ADMIN)
  public boolean cancelDiscovery() {
      if (getState() != STATE_ON) return false;
      try {
          synchronized(mManagerCallback) {
              if (mService != null) return mService.cancelDiscovery();
          }
      } catch (RemoteException e) {Log.e(TAG, "", e);}
      return false;
  }
```
```java
//获取BluetoothManagerService的实例对象
IBinder b = ServiceManager.getService(BLUETOOTH_MANAGER_SERVICE);
IBluetoothManager managerService = IBluetoothManager.Stub.asInterface(b);
//根据BluetoothManagerService通过aidl来获取IBluetooth对象
IBluetooth mService = managerService.registerAdapter(mManagerCallback);
```
(framework/base/core/java/android/bluetooth/IBluetooth.aidl）
此aidl的实现类：AdapterServiceBinder(hardware/broadcom/libbt/bluetoothbcm/目录下)
```java
AdapterServiceBinder extends IBluetooth.Stub
```
其控制蓝牙的操作调用AdapterService(hardware/broadcom/libbt/bluetoothbcm/目录下)类实现
在AdapterService方法中，关于扫描操作的调用如下：
```java
startDiscoveryNative();
cancelDiscoveryNative();
```
调到底层com_android_bluetooth_btservice_AdapterService.cpp
底层对于蓝牙的操作已经封装了
