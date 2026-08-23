local UpgradeConst = require("upgrade.UpgradeConst")
local UpgradeUtil = require("upgrade.UpgradeUtil")
local UpgradeOut = require("upgrade.UpgradeOut")
local var_0_3 = g.core.platform.PlatformProxy
local VersionState = class("VersionState", require("app.core.fsm.KSSimpleState"))

function VersionState:ctor()
	VersionState.super.ctor(self)

	self._stUUID = UpgradeConst.EN_FSM_ST.VERSION_INFO
	self._nextState = nil
end

function VersionState:doBeforeEntering()
	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.VERSION)
	self:_fetchVersionInfo()
end

function VersionState:doBeforeLeaving()
	return
end

function VersionState:doReasonState()
	if self:_isTaskFinish() then
		return self._nextState
	end

	return nil
end

function VersionState:_setJumpState(arg_5_1)
	self._nextState = arg_5_1

	self:_setTaskFinish()
end

function VersionState:_fetchVersionInfo()
	self._urlIndex = self._urlIndex or 1

	local var_6_0 = config.UPGRADE_URL_TEST .. "?t=" .. os.time()

	if config.PATCH_URL_ENABLED then
		var_6_0 = var_0_3:getPatchUrl(self._urlIndex) .. "/opinfo?opGameId=#opgameid#&opId=#opid#&channel=#channelid#&md5=#md5#"

		local var_6_1 = config.SPECIFIC_CHANNEL_ID or 0

		var_6_0 = g.core.lang:getByString(var_6_0, {
			md5 = "",
			opgameid = var_0_3:getOpGameId(),
			opid = var_0_3:getOpId(),
			channelid = var_6_1
		})
	end

	UpgradeUtil.httpGet(var_6_0, handler(self, self._handleFetchVersionOK), handler(self, self._handleFetchVersionErr))
end

function VersionState:_handleFetchVersionOK(arg_7_1)
	self._urlIndex = 1

	if not arg_7_1 then
		self:_setJumpState(UpgradeConst.EN_FSM_ST.FINISHED)

		return
	end

	var_0_3:_updatePatchMd5(arg_7_1)

	local var_7_0 = arg_7_1.config

	if arg_7_1.config then
		UpgradeOut.MLANG_TOTAL_URL_A = var_7_0.android_mlang_total_config
		UpgradeOut.MLANG_TOTAL_URL_I = var_7_0.ios_mlang_total_config
		UpgradeOut.SILENT_UPGRADE_CONFIG = var_7_0.silent_upgrade_config
		UpgradeOut.SILENT_UPGRADE_CONFIG_TEST = var_7_0.silent_upgrade_config_test
		UpgradeOut.MICRO_UPGRADE_CONFIG = var_7_0.micro_upgrade_config
		UpgradeOut.MICRO_UPGRADE_CONFIG_TEST = var_7_0.micro_upgrade_config_test

		g.core.platform.ServerListProxy:updateServerInfo(var_7_0)

		if var_7_0.open_show_error then
			require("app.view.module.debug.pop.ErrorMessagePop").setAllowShowErrorPop(var_7_0.open_show_error == "1")
		end
	end

	if UpgradeOut.SILENT_UPGRADE_CONFIG == nil then
		UpgradeOut.SILENT_UPGRADE_CONFIG = config.SILENT_UPGRADE_CONFIG
	end

	if UpgradeOut.SILENT_UPGRADE_CONFIG_TEST == nil then
		UpgradeOut.SILENT_UPGRADE_CONFIG_TEST = config.SILENT_UPGRADE_CONFIG_TEST
	end

	if UpgradeOut.MICRO_UPGRADE_CONFIG == nil then
		UpgradeOut.MICRO_UPGRADE_CONFIG = config.MICRO_UPGRADE_CONFIG
	end

	local var_7_1

	if UpgradeOut.MICRO_UPGRADE_CONFIG_TEST == nil then
		UpgradeOut.MICRO_UPGRADE_CONFIG_TEST = config.MICRO_UPGRADE_CONFIG_TEST

		if arg_7_1 then
			var_7_1 = arg_7_1.config or {}
		end
	end

	self:_checkVersionInfo(var_7_1)
end

function VersionState:_handleFetchVersionErr(arg_8_1)
	self._urlIndex = self._urlIndex + 1

	local var_8_0 = ""

	if arg_8_1.status then
		var_8_0 = "s" .. arg_8_1.status
	elseif arg_8_1.readyState then
		var_8_0 = "r" .. arg_8_1.readyState
	end

	if var_0_3:hasNetwork() then
		self:_fetchVersionInfo()
	else
		local var_8_1 = {}

		var_8_1.text = g.core.lang:get(100011, {
			errcode = var_8_0
		})
		var_8_1.handler_ok = handler(self, self._fetchVersionInfo)
		var_8_1.handler_cancel = handler(self, self._fetchVersionInfo)

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_8_1), {
			ignoreTouch = true
		})
	end
end

function VersionState:_checkVersionInfo(arg_9_1)
	self._ownerFSM:setVersionConfig(arg_9_1)

	local var_9_0 = tonumber(arg_9_1.serverList or 0) or 0

	if var_9_0 > 0 and config.GAME_VERSION_NO == var_9_0 then
		self:_setJumpState(UpgradeConst.EN_FSM_ST.FINISHED)

		return
	end

	if self:_checkWholePackUpgrade(arg_9_1) then
		self:_setJumpState(UpgradeConst.EN_FSM_ST.WHOLE_PKG)

		return
	end

	self:_setJumpState(UpgradeConst.EN_FSM_ST.MICRO_CHECK)
end

function VersionState:_checkWholePackUpgrade(arg_10_1)
	if not arg_10_1.whole_upgrade or checknumber(arg_10_1.whole_upgrade) <= self._ownerFSM.curVersion then
		return false
	end

	return true
end

return VersionState
