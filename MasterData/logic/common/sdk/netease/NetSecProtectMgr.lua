-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/netease/NetSecProtectMgr.lua

module("logic.common.sdk.netease.NetSecProtectMgr", package.seeall)

local NetSecProtectMgr = class("NetSecProtectMgr")
local AndroidSecProtect = NetSecProtect
local WinSecProtect = WinSecProtect
local IOSSecProtect = IOSSecProtect
local AppId = {
	Android = "A004945219",
	Win = "W008926064",
	IOS = "I003947658"
}
local AppKey = {
	Android = "43ac00e17451411592aac0a8a925bfe60a64",
	Win = "1048acace6524e31b3a88f70f858bec53b43",
	IOS = "104d29022a744057a8bcc20edd1061659895"
}
local GameKey = "b1dcbdca9b21a71ece4053fdd6227f35"
local Region = {
	Europe = 4,
	Other = 3,
	Zh = 1,
	Tw = 2
}
local Status = {
	Logout = 2,
	Record = 0,
	Login = 1
}
local NEPStatus = {
	Normal = NLPC.NEPSTATUS.eNEP_Status_Normal,
	NotLoaded = NLPC.NEPSTATUS.eNEP_Status_NotLoaded,
	FileNotFound = NLPC.NEPSTATUS.eNEP_Status_FileNotFount,
	FileModified = NLPC.NEPSTATUS.eNEP_Status_FileModified,
	Suspended = NLPC.NEPSTATUS.eNEP_Status_Suspended,
	TiggerEvent = NLPC.NEPSTATUS.eNEP_Status_TiggerEvent,
	InternalWardenError = NLPC.NEPSTATUS.eNEP_Status_InternalWardenError,
	NetworkError = NLPC.NEPSTATUS.eNEP_Status_NetworkError
}

function NetSecProtectMgr:init()
	if not SdkConfigMgr.Instance.enableYiDunSDK then
		return
	end

	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		AndroidSecProtect.init(AppId.Android, GameKey, Region.Zh)
	elseif Astral.OSDef.RunOS == Astral.OSDef.IOS then
		IOSSecProtect.setServerType(Region.Zh)
		IOSSecProtect.initWithAppId(AppId.IOS)
	elseif Astral.OSDef.RunOS == Astral.OSDef.Win32 and not Astral.OSDef.isEditor then
		WinSecProtect.InstallStatusChecker(self._onStatusCheck, self, 300)
	end

	self._userId = nil
	self._userName = nil
end

function NetSecProtectMgr:setUserInfo(userId, userName, serverName)
	if not SdkConfigMgr.Instance.enableYiDunSDK then
		return
	end

	if not userId then
		printError("userId can't be nil!")

		return
	end

	userName = userName or ""
	serverName = serverName or ""
	self._userId = userId
	self._userName = userName

	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		AndroidSecProtect.setRoleInfo(userId, userName, userName, serverName, 0, "")
	elseif Astral.OSDef.RunOS == Astral.OSDef.IOS then
		IOSSecProtect.setRoleInfo(userId, userName, userName, serverName)
	elseif Astral.OSDef.RunOS == Astral.OSDef.Win32 and not Astral.OSDef.isEditor then
		WinSecProtect.setRoleInfo(userId, userName, serverName, 0, AppId.Win, Status.Login)
	end
end

function NetSecProtectMgr:logout()
	if not SdkConfigMgr.Instance.enableYiDunSDK then
		return
	end

	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		AndroidSecProtect.logOut()
	elseif Astral.OSDef.RunOS == Astral.OSDef.IOS then
		IOSSecProtect.logOut()
	elseif Astral.OSDef.RunOS == Astral.OSDef.Win32 and not Astral.OSDef.isEditor and self._userId then
		WinSecProtect.setRoleInfo(self._userId, self._userName, "", 0, AppId.Win, Status.Logout)
	end

	self._userId = nil
	self._userName = nil
end

function NetSecProtectMgr:_onStatusCheck(status)
	if status == NEPStatus.NotLoaded then
		printWarn("StatusCheck not loaded!")
	elseif status == NEPStatus.FileNotFound then
		printWarn("StatusCheck not found!")
	elseif status == NEPStatus.FileModified or status == NEPStatus.Suspended or status == NEPStatus.TriggerEvent or status == NEPStatus.InternalWardenError then
		printError("StatusCheck abnormal warning!")
		UnityEngine.Application.Quit()
	end
end

function NetSecProtectMgr:ioctl(reqCmdId)
	return
end

function NetSecProtectMgr:sendData()
	return
end

function NetSecProtectMgr:registHeartBeatReceiver()
	return
end

function NetSecProtectMgr:onReceiver()
	return
end

NetSecProtectMgr.instance = NetSecProtectMgr.New()

return NetSecProtectMgr
