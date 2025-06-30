-- chunkname: @IQIGame\\Net\\NetUserResponse.lua

function net_user.validateUUIDResult_delegate(code, roles, recommandJobId, uid, reconnectToken, testMode)
	NetCommController.Responded()

	LoginModule.IsLogining = false

	if code == 0 then
		LoginModule.Uid = uid
		LoginModule.ServerTestMode = testMode
		LoginModule.ReconnectToken = reconnectToken
		LoginModule.ReadMsgLength = 0
		LoginModule.RecordMsgLength = true

		if #roles > 0 then
			PlayerModule.PlayerInfo.baseInfo.pName = roles[1].pname

			net_user.chooseRole(roles[1].pid)
		elseif PlayerModule.IsPrologueEnabled() then
			CreateRoleModule.StartCreateRole()
		else
			UIModule.Open(Constant.UIControllerName.InputPlayerNameTextUI, Constant.UILayer.UI)
		end

		SDKLoginModule.LogRequestServerState(1)
	else
		local e = LoginFailedEventArgs()

		e.ResponseCode = code
		e.errorText = getErrorMsg(code)

		if code == 120005 then
			NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("VersionTooLowNotice"), function()
				LuaCodeInterface.QuitGame()
			end)
		elseif code == 120008 and LoginModule.selectedServerInfo ~= nil and LoginModule.selectedServerInfo.downTimeInfo ~= nil and LoginModule.selectedServerInfo.downTimeInfo ~= "" then
			NoticeModule.ShowNoticeByType(1, LoginModule.selectedServerInfo.downTimeInfo)
		else
			NoticeModule.ShowNoticeByType(1, e.errorText)
		end

		GameEntry.LuaEvent:Fire(net_user, e)
		SDKLoginModule.LogRequestServerState(2)
	end
end

function net_user.reconnectResult_delegate(code, lastMsgOrder, reconnectToken)
	NetCommController.Responded()

	if code == 0 then
		LoginModule.ReconnectToken = reconnectToken
		LoginModule.ReadMsgLength = 0
		LoginModule.RecordMsgLength = true

		LuaCodeInterface.SendAllFailMsgs(NetworkChannelName.Game, lastMsgOrder)
	else
		PlayerModule.StateLogOut()

		LoginModule.NeedReconnect = false

		if UIModule.canPopTopConfirm then
			UIModule.Open(Constant.UIControllerName.TopConfirmationUI, Constant.UILayer.AboveAll, {
				cid = 21040011,
				confirm = LoginModule.AbandonReconnect
			}, true)
		end
	end
end

function net_user.chooseRoleResult_delegate(code, handselSoulCount, msg)
	NetCommController.Responded()

	if code ~= 0 then
		local showMsg = getErrorMsg(code)

		if msg ~= nil and msg ~= "" then
			showMsg = msg
		end

		NoticeModule.ShowNoticeByType(4, showMsg, ProcedureReset.ResetAndGoToLogin)

		return
	end

	if handselSoulCount >= 1 then
		net_player.loadPlayer()
	elseif PlayerModule.IsPrologueEnabled() then
		CreateRoleModule.ChangeCreateRole(handselSoulCount)
	else
		CreateRoleModule.HandselSoul()
		net_player.loadPlayer()
	end
end

function net_user.createRoleResult_delegate(code, role)
	NetCommController.Responded()

	if code ~= 0 then
		SDKLoginModule.LogCreateRole(3, nil, nil, tostring(code))

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

	if PlayerModule.IsPrologueEnabled() then
		CreateRoleModule.CreateRoleResult(role)
	end

	LoginModule.CreatePlayerResult(role)
	SDKLoginModule.LogCreateRole(2, role.guid, role.pid)
end

function net_user.pang(serverTime)
	PlayerModule.SyncServerTime(serverTime)
	NetManager.PangStopCheckTimeOut(NetworkChannelName.Game)
end

function net_user.notifyServerStatus(time, rawOffset)
	if LoginModule.ReconnectFlag then
		LoginModule.Reconnect()
	else
		LoginModule.ValidateUUID()
	end

	PlayerModule.TimeZone = rawOffset

	PlayerModule.SyncServerTime(time)
	LuaCodeInterface.SetServerTimeRawOffset(rawOffset)
end

function net_user.notifyError(code, msg)
	local showMsg = getErrorMsg(code)

	if msg ~= nil and msg ~= "" then
		showMsg = msg
	end

	NoticeModule.ShowNoticeByType(1, showMsg)
end

function net_user.handselSoulResult(code, handselSoulCount)
	CreateRoleModule.HandselSoulResult(handselSoulCount)
end

function net_user.logoutResult_delegate(code)
	if LoginModule.LogoutCallBack then
		LoginModule.LogoutCallBack()

		LoginModule.LogoutCallBack = nil
	end
end
