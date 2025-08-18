-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\ClientAccount.lua

local ClientEntity = require("Avatar/ClientEntity")
local ClientAvatar = require("Avatar/ClientAvatar")
local ResBeginnerGuideSteps = require("ClientData/ResBeginnerGuideSteps")
local NetService = require("Network/NetService")
local SDKAppUtils = require("SDK/SDKAppUtils")
local LuaToolkit = Framework.Tools.LuaToolkit
local AccountManager = AccountManager
local strClassName = "ClientAccount"
local ClientAccount = Class(strClassName, ClientEntity)

function ClientAccount:ctor()
	RPC.setAgent(self)
	CHATRPC.setAgent(self)

	self.isAccount = true
end

local LONG_DISCONNECT_TIME = 64800

function ClientAccount:onRoleLoginResp(respid, enter_game, reconnect, roomid, freezeInfo, open_zone_time, cur_tick, svrmark_info, all_data_num, create_tick, res_version, notice, switch, objId, current_server_id, time_zone, antiaddiction_data, country)
	ClientUtils.SetServerZone(time_zone)
	NetService.clearReconnectFlag()

	Const.COUNTRY_STR = country
	ClientUtils.openZoneTime = open_zone_time

	if respid == "kRoleLoginErrorNoRole" then
		RPC.roleCreate(nil, nil)
	elseif respid == "kRoleLoginErrorFreeze" then
		local msg = Lang.get(1790)

		if freezeInfo ~= nil then
			if freezeInfo.freeze_time == 0 then
				msg = Lang.get(1791)
			else
				local leftTime = freezeInfo.freeze_time - os.time()

				msg = string.format(Lang.get(1789), leftTime)
			end
		end

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1792), msg)
		AccountManager.logoutGame()
	elseif respid == "kRoleLoginErrorAntAddiction" then
		local msg = "kRoleAntiAddictionReasonNone "

		if antiaddiction_data.antiaddiction_reason == "kRoleAntiAddictionReasonOverTimeNormal" then
			msg = Lang.get(48075)
		elseif antiaddiction_data.antiaddiction_reason == "kRoleAntiAddictionReasonOverTimeHoliday" then
			msg = Lang.get(48076)
		elseif antiaddiction_data.antiaddiction_reason == "kRoleAntiAddictionReasonTimeNotAllow" then
			if antiaddiction_data.age == 4 then
				msg = Lang.get(52069)
			else
				msg = Lang.get(51879)
			end
		end

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), msg)
		AccountManager.logoutGame()
	elseif respid == "kRoleLoginErrorSvrMarkNotMatch" then
		local svrMark = svrmark_info.svrmark
		local hotfixMD5 = svrmark_info.nonbattle_md5
		local SwitchServerHelper = require("Helper/SwitchServerHelper")

		SwitchServerHelper.onSvrMarkMismatch(svrMark, hotfixMD5)

		GameFsm.suppressDisconnectTip = true
	elseif respid == "kRoleLoginErrorClientResVersion" then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), Lang.get(44007), Game.Reload, nil, nil, Lang.get(8), Lang.get(7))

		GameFsm.suppressDisconnectTip = true
	elseif respid == "kRoleLoginErrorReconnectTimeOut" then
		-- block empty
	elseif respid == "kRoleLoginErrorCreateLimit" then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), notice or "", LuaToolkit.QuitApplication, nil, nil, Lang.get(1796), Lang.get(7))
	else
		if not GameFsm.isInState(Const.STATE_LOGIN) then
			if Const.HEART_BEAT_TIME and Time.time - Const.HEART_BEAT_TIME > LONG_DISCONNECT_TIME then
				GameFsm.reconnectFaliedCB()

				return
			end

			local deviceID = SDKAppUtils.getNativeDeviceID()

			if deviceID ~= enter_game.role_data.base.deviceid then
				GameFsm.reconnectFaliedCB()

				return true
			end
		end

		ClientUtils.onSetServerTime(enter_game.time, true)
		ClientUtils.handleStageChannel()

		if CurAvatar then
			CurAvatar:destroy()
		end

		RedDotManager.clearOnLogin()
		ClientAvatar(enter_game, all_data_num, objId)

		CurAvatar.roleCreateTick = create_tick or 0

		GameFsm.onLoginToGameState(reconnect, enter_game)
		AccountManager.onRoleLogin()

		CurAvatar.current_server_id = current_server_id
	end
end

function ClientAccount:onRoleCreateResp(resp_code, uid)
	if resp_code == Const.CREATE_ROLE_NOERROR then
		AccountManager.onRoleCreate()
	end
end

function ClientAccount:onRoleLogoutNotify(reason)
	if reason == "kRoleLogoutReasonRemoteLogin" then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1792), Lang.get(1797))
	elseif reason == "kRoleLogoutReasonClientVersionError" then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), Lang.get(1798))
	elseif reason == "kRoleLogoutReasonAntiAddiction" then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), Lang.get(52070))
	end

	AccountManager.logoutGame()
end

function ClientAccount:onRoleLoginQueueNotify(estimateTime, seatNo, totalLineup)
	local gameFsm = GameFsm

	if not GameFsm.isInState(Const.STATE_LOGIN) then
		gameFsm.translateState(Const.STATE_LOGIN)
		UIManager.getUI("relinkDlg", false, false)
	end

	local loginQueueBox = UIManager.getUI("loginQueueBox", true, true)
	local serverName = SvrListManager.getCurServerName()

	if loginQueueBox then
		loginQueueBox:showQueueInfo(serverName, estimateTime, seatNo, totalLineup)

		NetService.missBeatCount = 0
	end
end

return ClientAccount
