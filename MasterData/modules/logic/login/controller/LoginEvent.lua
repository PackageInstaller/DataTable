-- chunkname: @modules/logic/login/controller/LoginEvent.lua

module("modules.logic.login.controller.LoginEvent", package.seeall)

local LoginEvent = _M

LoginEvent.SelectServerItem = 1
LoginEvent.OnGetInfoFinish = 2
LoginEvent.OnLoginEnterMainScene = 3
LoginEvent.OnLogout = 4
LoginEvent.OnSdkLoginReturn = 5
LoginEvent.SystemLoginFail = 6
LoginEvent.OnBeginLogout = 7
LoginEvent.OnLoginBgLoaded = 8
LoginEvent.OnLoginVideoSwitch = 10001

return LoginEvent
