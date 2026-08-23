local UpgradeConst = require("upgrade.UpgradeConst")
local UpgradeUtil = require("upgrade.UpgradeUtil")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local var_0_3 = g.core.platform.PlatformProxy
local LangInfoState = class("LangInfoState", require("app.core.fsm.KSSimpleState"))

function LangInfoState:ctor()
	LangInfoState.super.ctor(self)

	self._stUUID = UpgradeConst.EN_FSM_ST.LANG_INFO
	self._nextState = nil
end

function LangInfoState:doBeforeEntering()
	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.LANGVER)
	self:_checkLangInfo()
end

function LangInfoState:doBeforeLeaving()
	return
end

function LangInfoState:doReasonState()
	if self:_isTaskFinish() then
		return self._nextState
	end

	return nil
end

function LangInfoState:_setJumpState(arg_5_1)
	self._nextState = arg_5_1

	self:_setTaskFinish()
end

function LangInfoState:_checkLangInfo()
	local var_6_1 = MultilingualMgr:getLangVersion((MultilingualMgr:getUseLang()))
	local var_6_3 = checknumber((config.PATCH_URL_ENABLED or nil) and self._ownerFSM.versionCfg.lang_version_no) or config.LANG_VERSION_NO

	if var_6_1 < var_6_3 then
		self._ownerFSM.curLangVersion = var_6_1
		self._ownerFSM.upgradeLangVersion = var_6_3

		self:_fetchLangInfo()
	else
		self:_setJumpState(UpgradeConst.EN_FSM_ST.AUTO_LANG)
	end
end

function LangInfoState:_fetchLangInfo()
	local var_7_0 = self._ownerFSM.versionCfg
	local var_7_1 = MultilingualMgr:getUseLang()
	local var_7_3 = self._ownerFSM.versionCfg[var_7_1 .. ((device.isMac() or device.isIOS()) and (not config.USE_CDN_UPGRADE and "_ios_upgrade_config_test" or "_ios_upgrade_config"))]

	if config.PATCH_URL_ENABLED then
		var_7_3 = var_7_0[(device.isMac() or device.isIOS()) and "lang_ios_upgrade_config"]
		var_7_3 = g.core.lang:getByString(var_7_3, {
			lang = var_7_1
		})
	end

	UpgradeUtil.httpGet(var_7_3, handler(self, self._handleFetchLangInfoOK), handler(self, self._handleFetchLangInfoErr))
end

function LangInfoState:_handleFetchLangInfoOK(arg_8_1)
	self._ownerFSM:setLangInfoConfig(arg_8_1)

	local var_8_0 = arg_8_1.version_no or config.LANG_VERSION_NO

	if self._ownerFSM.curLangVersion < var_8_0 then
		self._ownerFSM.upgradeLangVersion = var_8_0

		self:_setJumpState(UpgradeConst.EN_FSM_ST.LANG_DOWN)
	else
		self:_setJumpState(UpgradeConst.EN_FSM_ST.AUTO_LANG)
	end
end

function LangInfoState:_handleFetchLangInfoErr(arg_9_1)
	local var_9_0 = ""

	if arg_9_1.status then
		var_9_0 = "s" .. arg_9_1.status
	elseif arg_9_1.readyState then
		var_9_0 = "r" .. arg_9_1.readyState
	end

	local var_9_1 = var_0_3:hasNetwork()

	if var_9_1 then
		self:_fetchLangInfo()
	else
		local var_9_2 = {}

		var_9_2.text = g.core.lang:get(var_9_1 and 100010 or 100011, {
			errcode = var_9_0
		})
		var_9_2.handler_ok = handler(self, self._fetchLangInfo)
		var_9_2.handler_cancel = handler(self, self._fetchLangInfo)

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_9_2), {
			ignoreTouch = true
		})
	end
end

return LangInfoState
