devcon.exe rescan
devcon.exe remove "usb\vid_5345&pid_1234"
del %SystemRoot%\system32\drivers\Oscilloscopeusb.sys
del %SystemRoot%\system32\drivers\owonhdsusb.sys
del %SystemRoot%\inf\owonhdsusb.Inf
del %SystemRoot%\inf\owonhdsusb.PNF
del %SystemRoot%\system32\drivers\libusb0.sys
del %SystemRoot%\system32\libusb0.dll
if exist %SystemRoot%\system32 copy x86\libusb0_x86.dll %SystemRoot%\system32\libusb0.dll
if exist %SystemRoot%\syswow64 copy x86\libusb0_x86.dll %SystemRoot%\syswow64\libusb0.dll
devcon.exe rescan
rundll32 libusb0.dll,usb_install_driver_np_rundll usb_device.inf
exit