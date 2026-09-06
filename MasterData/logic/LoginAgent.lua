-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/agent/LoginAgent.lua

module("logic.extensions.login.agent.LoginAgent", package.seeall)

local LoginAgent = class("LoginAgent", BaseAgent)
local json = require("cjson")

function LoginAgent:sendLoginRequest(account, password, isOutside)
	local req = {}

	req.account = account
	req.password = password
	req.connectWay = isOutside and 0 or 1

	NetConnMgr.instance:sendSysMsg(1, req, ConnectionType.Logic)
end

function LoginAgent:handleLoginResponse(status, msg)
	if status == 0 then
		NetConnMgr.instance:resetSeqNo()

		LoginModel.instance.reason = msg.reason
		LoginModel.instance.userId = msg.userId

		RoleModel.instance:setUserId(msg.userId)
		VersionCrtl.instance:setBuglyUserId(msg.userId)
		GlobalDispatcher:dispatch(GlobalNotify.RoleLogined, true)
	else
		local resultCode = checknumber(msg.reason)

		LoginModel.instance.disconnectFlag = resultCode == -107 and GameEnum.DisconnectFlag_LoginRateLimit or resultCode == -106 and GameEnum.DisconnectFlag_ServerFull or resultCode == -105 and GameEnum.DisconnectFlag_ServerNotInService or (resultCode == -100 or resultCode == -111) and GameEnum.DisconnectFlag_AccountNoExisted or resultCode == -102 and GameEnum.DisconnectFlag_AccountLoginTimeout or resultCode == -103 and GameEnum.DisconnectFlag_NoOperationTimeout or resultCode == -104 and GameEnum.DisconnectFlag_DataWritingBack or resultCode == -108 and GameEnum.DisconnectFlag_LoginingOnOtherDevice or resultCode == -112 and GameEnum.DisconnectFlag_ServerNotWorkingThisTime or resultCode == -32005 and GameEnum.DisconnectFlag_LoginingMaxRegisterCount or resultCode == -54 and GameEnum.DisconnectFlag_NetBlock or GameEnum.DisconnectFlag_LoginingServerHot

		printInfo("resultCode:" .. resultCode .. ",Socket Login failed, LoginModel.instance.reason==========" .. msg.reason)
		printInfo("LoginModel.instance.disconnectFlag:" .. LoginModel.instance.disconnectFlag)
		GlobalDispatcher:dispatch(GlobalNotify.RoleLogined, false, resultCode)
	end
end

function LoginAgent:sendGetLostCmdRespRequest(downTag)
	print("sendGetLostCmdRespRequest", downTag)

	local req = {}

	req.downTag = downTag

	NetConnMgr.instance:sendSysMsg(3, req, ConnectionType.Logic)
end

function LoginAgent:handleLeaveResponse(status, msg)
	LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_Kickout
end

function LoginAgent:handleForceLogoutResponse(status, msg)
	if status == -6 then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_ServerShutdown
	elseif status == -5 then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_RepeatLogin
	elseif status == -4 then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_IdleTimeout
	elseif status == -101 then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_LogoutSuccess
	elseif status == -110 then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_Kickout
	elseif status == -113 then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_Anti_Error
		LoginModel.instance.antiReason = GameUtil.jsonToTable(msg.reason)
	else
		LoginModel.instance.disconnectFlag = status == -117 and GameEnum.DisconnectFlag_Qudao_Del_Role or GameEnum.DisconnectFlag_Kickout
	end

	print("ForceLogout,reason=", status, msg.reason)
	print("LoginModel.instance.disconnectFlag:" .. LoginModel.instance.disconnectFlag)
end

function LoginAgent:handleGetLostCmdRespResponse(status, msg)
	print("GetLostCmdRespResponse", msg.canGet)
	GlobalDispatcher:dispatch(GlobalNotify.GetLostCmdEnd, msg)
end

function LoginAgent:handleGetLostCmdRespResponseStartTag(status, msg)
	print("GetLostCmdRespResponseStartTag")
	GlobalDispatcher:dispatch(GlobalNotify.GetLostCmdStart, msg)
end

function LoginAgent:sendHttpWebLoginRequest(btSessionId, clientVersion, sdkType, reverseIndex)
	printInfo("btSessionId = " .. btSessionId .. "  clientVersion = " .. clientVersion .. " sdkType = " .. sdkType)

	local url = BootstrapPjaqGameConfigMgr.getWebLoginUrl(reverseIndex)

	url = checknumber(LoginModel.instance.platformId) >= 0 and url .. "account/login" or url .. "account/straight-login"

	if not string.find(url, "http://") and not string.find(url, "https://") then
		url = "http://" .. url
	end

	printInfo("web login url=" .. url)

	local devInfo = SDKManager.getDevInfoExtWithSessionId(LoginModel.instance.platformId, LoginModel.instance.sessionId)

	printInfo("devInfo:" .. devInfo)

	local form = UnityEngine.WWWForm.New()

	form:AddField("account", btSessionId)
	form:AddField("devInfo", devInfo)
	form:AddField("simulatedIp", LoginModel.instance.simulatedIp or "")

	if checknumber(LoginModel.instance.platformId) < 0 then
		form:AddField("tempAuthCode", LoginModel.instance.tempAuthCode or "")
	end

	Framework.HttpConnnection.Instance:RequestWithForm(url, form, LoginAgent._handleHttpWebLoginResponse, 3)
end

function LoginAgent._handleHttpWebLoginResponse(isSuccess, msg)
	if isSuccess then
		printInfo("============_handleHttpWebLoginResponse info msg=========" .. msg)

		local status, data = pcall(json.decode, msg)

		if status and data and data.resultCode and data.resultCode == 0 then
			if not data.areaStatus or not data.areaStatus.socketAddresses then
				GlobalDispatcher:dispatch(GlobalNotify.GameWebLoginSvrListEmpty)

				return
			end

			LoginModel.instance.socketPassword = data.socketPassword
			LoginModel.instance.gameAccount = data.gameAccount
			LoginModel.instance.curAreaStatus = data.areaStatus

			GlobalDispatcher:dispatch(GlobalNotify.GameWebLoginSuccess)
		else
			printInfo("============_handleHttpWebLoginResponse info msg Failed=========")
			printInfo(msg)
			GlobalDispatcher:dispatch(GlobalNotify.GameWebLoginFail, data)
		end
	else
		printInfo("============_handleHttpWebLoginResponse info msg Failed=========")
		printInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GameWebLoginFail, msg)
	end
end

function LoginAgent:sendHttpWebStartGameRequest(gameAccount, socketPassword, areaId, reverseIndex, cancelCloseUser)
	cancelCloseUser = cancelCloseUser or 0

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)

	local url = BootstrapPjaqGameConfigMgr.getWebLoginUrl(reverseIndex)

	url = url .. "account/startGame"

	if not string.find(url, "http://") and not string.find(url, "https://") then
		url = "http://" .. url
	end

	printInfo("web startGame url=" .. url)

	local devInfo = SDKManager.getDevInfoExt(LoginModel.instance.platformId)

	printInfo("devInfo:" .. devInfo)

	local form = UnityEngine.WWWForm.New()

	form:AddField("gameAccount", gameAccount)
	form:AddField("socketPassword", socketPassword)
	form:AddField("areaId", areaId)
	form:AddField("simulatedIp", LoginModel.instance.simulatedIp or "")
	form:AddField("cancelCloseUser", cancelCloseUser .. "")
	Framework.HttpConnnection.Instance:RequestWithForm(url, form, LoginAgent._handleHttpWebStartGameResponse, 3)
end

function LoginAgent._handleHttpWebStartGameResponse(isSuccess, msg)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	if isSuccess then
		printInfo("============_handleHttpWebStartGameResponse info msg=========" .. msg)

		local status, data = pcall(json.decode, msg)

		if status and data.areaId and data.socketAddresses and #data.socketAddresses > 0 then
			LoginController.instance:setServerListToModel(data.areaId, data.socketAddresses)
		end

		if status and data and data.resultCode and data.resultCode == 0 then
			LoginModel.instance.socketAccount = data.socketAccount

			GlobalDispatcher:dispatch(GlobalNotify.GameWebStartGameSuccess, data)
		else
			printInfo("============_handleHttpWebStartGameResponse info msg Failed=========")
			printInfo(msg)
			GlobalDispatcher:dispatch(GlobalNotify.GameWebLoginFail, data)
		end
	else
		printInfo("============_handleHttpWebStartGameResponse info msg Failed=========")
		printInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GameWebLoginFail, msg)
	end
end

function LoginAgent:sendHttpWebLoadAreaRequest(gameAccount, socketPassword, reverseIndex, callback)
	LoginController.instance.loadAreaCallBack = callback

	local url = BootstrapPjaqGameConfigMgr.getWebLoginUrl(reverseIndex)

	url = url .. "account/loadArea"

	if not string.find(url, "http://") and not string.find(url, "https://") then
		url = "http://" .. url
	end

	printInfo("web startGame url=" .. url)

	local devInfo = SDKManager.getDevInfoExt(LoginModel.instance.platformId)

	printInfo("devInfo:" .. devInfo)

	local form = UnityEngine.WWWForm.New()

	form:AddField("gameAccount", gameAccount)
	form:AddField("socketPassword", socketPassword)
	form:AddField("simulatedIp", LoginModel.instance.simulatedIp or "")
	Framework.HttpConnnection.Instance:RequestWithForm(url, form, function(isSuccess, msg)
		if isSuccess then
			printInfo("============_handleHttpWebLoadAreaResponse info msg=========" .. msg)

			local status, data = pcall(json.decode, msg)

			if status and data and data.resultCode and data.resultCode == 0 then
				GameUtil.callBack(LoginController.instance.loadAreaCallBack, data)
			else
				printInfo("============_handleHttpWebLoadAreaResponse info msg Failed=========")
				printInfo(msg)
				GlobalDispatcher:dispatch(GlobalNotify.GameLoadAreaFailed, data)
			end
		else
			printInfo("============_handleHttpWebLoadAreaResponse info msg Failed=========")
			printInfo(msg)
			GlobalDispatcher:dispatch(GlobalNotify.GameLoadAreaFailed, msg)
		end
	end, 3)
end

function LoginAgent:sendClearAccountDataRequest()
	local url
	local account = Framework.LocalStorage.Instance:GetString("account", "somebody")

	url = "http://10.17.2.37:8080/account/clear?account=" .. account

	Framework.HttpConnnection.Instance:RequestWithForm("http://10.17.2.37:8080/account/clear?account=" .. account, nil, LoginAgent._handleHttpClearAccountResponse)
	Framework.HttpConnnection.Instance:RequestWithForm("http://10.17.2.38:8080/account/clear?account=" .. account, nil, LoginAgent._handleHttpClearAccountResponse)
end

function LoginAgent._handleHttpClearAccountResponse(isSuccess, msg)
	if isSuccess then
		local status, data = pcall(json.decode, msg)

		if status and data and data.resultCode and data.resultCode == 0 then
			FloatWordMgr.instance:show("清空账号数据成功")
		else
			FloatWordMgr.instance:show("清空账号数据失败")
		end
	else
		FloatWordMgr.instance:show("清空账号数据失败")
	end
end

LoginAgent.instance = LoginAgent.New()

return LoginAgent
