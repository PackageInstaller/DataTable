-- chunkname: @IQIGame\\Net\\NetUserResponse.lua

function net_user.validateUUIDResult_delegate(code, roles, recommandJobId)
	NetCommController.Responded()

	LoginModule.IsLogining = false

	if code == 0 then
		if #roles > 0 then
			PlayerModule.PlayerInfo.baseInfo.pName = roles[1].pname

			net_user.chooseRole(roles[1].pid)
		else
			CreateRoleModule.CreateRole()
		end

		SDKLoginModule.Dispose()
	else
		local e = LoginFailedEventArgs()

		e.errorText = getErrorMsg(code)

		if code == 120008 and LoginModule.selectedServerInfo ~= nil and LoginModule.selectedServerInfo.downTimeInfo ~= nil and LoginModule.selectedServerInfo.downTimeInfo ~= "" then
			NoticeModule.ShowNoticeByType(1, LoginModule.selectedServerInfo.downTimeInfo)
		else
			NoticeModule.ShowNoticeByType(1, e.errorText)
		end

		GameEntry.LuaEvent:Fire(net_user, e)
		NetCommController.Responded()
	end
end

function net_user.chooseRoleResult(code)
	net_player.loadPlayer()
end

function net_user.createRoleResult_delegate(code, role)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 11005 then
			NoticeModule.ShowNotice(21045002)
		elseif code == 11002 then
			NoticeModule.ShowNotice(21040123)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	net_user.chooseRole(role.pid)
end

function net_user.pang(serverTime)
	PlayerModule.SyncServerTime(serverTime)
	NetManager.PangStopCheckTimeOut(NetworkChannelName.Game)
end

function net_user.notifyServerStatus(time, rawOffset)
	if LoginModule.ReloadFlag then
		LoginModule.Reload()
	else
		LoginModule.ValidateUUID()
	end

	PlayerModule.TimeZone = rawOffset

	PlayerModule.SyncServerTime(time)
	LuaCodeInterface.SetServerTimeRawOffset(rawOffset)
end

function net_user.notifyError(code, msg)
	NoticeModule.ShowNoticeByType(1, getErrorMsg(code))

	if msg ~= nil and msg ~= "" then
		logError("Server Error : " .. msg)
	end
end

function net_user.notifyMessage(msg, disconnect)
	NoticeModule.ShowNoticeByType(4, msg, function()
		if disconnect then
			LoginModule.Logout(SceneTransferModule.ReturnLogin)
		end
	end)
end

function net_user.logoutResult_delegate(code)
	if LoginModule.LogoutCallBack then
		LoginModule.LogoutCallBack()

		LoginModule.LogoutCallBack = nil
	end
end

function net_user.notifyOffline(type)
	if type == Constant.DisconnectionType.LOGIN then
		NoticeModule.ShowNoticeByType(4, "被踢下线！", function()
			LoginModule.Logout(SceneTransferModule.ReturnLogin)
		end)
	elseif type == Constant.DisconnectionType.SERVER then
		LoginModule.Logout(SceneTransferModule.ReturnLogin)
	elseif type == Constant.DisconnectionType.UPDATE then
		NoticeModule.ShowNoticeByType(4, "有新版本更新！", function()
			LoginModule.Logout(LuaCodeInterface.QuitGame)
		end)
	end
end

function net_user.receiveRebateResult(code, items)
	UserInfoModule.ReceiveReChargeRebateResult(items)
end
