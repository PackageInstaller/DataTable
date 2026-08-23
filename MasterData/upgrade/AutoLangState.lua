local UpgradeConst = require("upgrade.UpgradeConst")
local UpgradeUtil = require("upgrade.UpgradeUtil")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local DownMgr = require("app.core.down.DownMgr")
local var_0_4 = g.core.platform.PlatformProxy
local AutoLangState = class("AutoLangState", require("app.core.fsm.KSSimpleState"))

function AutoLangState:ctor()
	AutoLangState.super.ctor(self)

	self._stUUID = UpgradeConst.EN_FSM_ST.AUTO_LANG
	self._autoLangStorage = nil
	self._destLang = nil
	self._curVersion = nil
	self._newVersion = nil
	self._taskLang = nil
end

function AutoLangState:doBeforeEntering()
	if self._ownerFSM.needReboot then
		self:_setTaskFinish()

		return
	end

	if self:_checkIsFirstStart() then
		self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.AUTOLANG)
		self:waitForInitSDK()
	else
		self:_setTaskFinish()
	end
end

function AutoLangState:doBeforeLeaving()
	return
end

function AutoLangState:doReasonState()
	if self:_isTaskFinish() then
		return UpgradeConst.EN_FSM_ST.FINISHED
	end

	return nil
end

function AutoLangState:_checkIsFirstStart()
	self:_doDeserialize()

	if self._autoLangStorage and self._autoLangStorage.auto_change_fix then
		return false
	end

	return true
end

function AutoLangState:_doSerialize()
	g.core.common.Storage:save("auto_lang_change.json", self._autoLangStorage, false)
end

function AutoLangState:_doDeserialize()
	self._autoLangStorage = g.core.common.Storage:load("auto_lang_change.json", false) or {}
end

function AutoLangState:waitForInitSDK()
	if g.core.platform.PlatformProxy:isInitSdkOK() then
		self:_checkNeedAutoLang()
	else
		g.core.common.Scheduler:newScheduleOnce(handler(self, self.waitForInitSDK), 0.5)
	end
end

function AutoLangState:_checkNeedAutoLang()
	self._destLang = self:_getUserBaseLang()

	if config.GAME_VERSION_NO == 1005074 and (self._destLang == "cn" or self._destLang == "en") then
		self._destLang = nil
	end

	if self._destLang then
		self:_checkLangInfo()
	else
		self:notUseSystemLang()
	end
end

function AutoLangState:_getUserBaseLang()
	local var_10_0 = UpgradeConst.getRealLangName(g.core.platform.PlatformProxy:getLanguage() or "")

	if var_10_0 and not MultilingualMgr:isAllowChangeTo(var_10_0) then
		var_10_0 = nil
	end

	if MultilingualMgr:getUseLang() == var_10_0 then
		return nil
	else
		return var_10_0
	end
end

function AutoLangState:_checkLangInfo()
	local var_11_0 = MultilingualMgr:getLangVersion(self._destLang)
	local var_11_2 = checknumber((config.PATCH_URL_ENABLED or nil) and self._ownerFSM.versionCfg.lang_version_no) or config.LANG_VERSION_NO

	if var_11_0 < var_11_2 then
		self._curVersion = var_11_0
		self._newVersion = var_11_2

		self:_fetchLangInfo()
	else
		self:_showChangeLangTips()
	end
end

function AutoLangState:_fetchLangInfo()
	local var_12_0 = self._ownerFSM.versionCfg
	local var_12_1 = self._destLang
	local var_12_3 = self._ownerFSM.versionCfg[self._destLang .. ((device.isMac() or device.isIOS()) and (not config.USE_CDN_UPGRADE and "_ios_upgrade_config_test" or "_ios_upgrade_config"))]

	if config.PATCH_URL_ENABLED then
		var_12_3 = var_12_0[(device.isMac() or device.isIOS()) and "lang_ios_upgrade_config"]
		var_12_3 = g.core.lang:getByString(var_12_3, {
			lang = var_12_1
		})
	end

	UpgradeUtil.httpGet(var_12_3, handler(self, self._handleFetchLangInfoOK), handler(self, self._handleFetchLangInfoErr))
end

function AutoLangState:_handleFetchLangInfoOK(arg_13_1)
	local var_13_0 = arg_13_1.version_no or config.LANG_VERSION_NO

	if self._curVersion < var_13_0 then
		self._newVersion = var_13_0

		self:_checkLangDownInfo(arg_13_1)
	else
		self:_showChangeLangTips()
	end
end

function AutoLangState:_handleFetchLangInfoErr(arg_14_1)
	local var_14_0 = ""

	if arg_14_1.status then
		var_14_0 = "s" .. arg_14_1.status
	elseif arg_14_1.readyState then
		var_14_0 = "r" .. arg_14_1.readyState
	end

	if var_0_4:hasNetwork() then
		self:_fetchLangInfo()
	else
		local var_14_1 = {}

		var_14_1.text = g.core.lang:get(100011, {
			errcode = var_14_0
		})
		var_14_1.handler_ok = handler(self, self._fetchLangInfo)
		var_14_1.handler_cancel = handler(self, self._fetchLangInfo)

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_14_1), {
			ignoreTouch = true
		})
	end
end

function AutoLangState:_checkLangDownInfo(arg_15_1)
	local var_15_0 = arg_15_1.versions["" .. self._curVersion]

	if not arg_15_1.versions["" .. self._curVersion] then
		local var_15_1 = 999999999

		for iter_15_0, iter_15_1 in pairs(arg_15_1.versions) do
			local var_15_2 = checknumber(iter_15_0)
			local var_15_3

			if 0 < var_15_2 and var_15_2 <= self._curVersion then
				var_15_3 = var_15_2
				var_15_0 = iter_15_1
			end

			if var_15_2 < var_15_1 then
				var_15_1 = var_15_2
			end
		end

		if var_15_0 == nil then
			var_15_0 = arg_15_1.versions[tostring(var_15_1)]
		end
	end

	if var_15_0 and var_15_0.url then
		DownMgr.setDefaultPrefixURL(arg_15_1.upgrade_url .. "/")

		local var_15_4 = DownMgr.createDownTask()

		var_15_4:addDownUnit(var_15_0.url, var_15_0.md5, var_15_0.size)
		var_15_4:registerProgressHandler(handler(self, self._onLangDownProcess))
		var_15_4:registerDownFinishHandler(handler(self, self._onLangDownOK))
		var_15_4:registerUnzipHandler(handler(self, self._onLangUnzipOK))
		var_15_4:registerErrorHandler(handler(self, self._onLangDownError))

		self._taskLang = var_15_4

		self:_startDownLang()
	else
		assert(false, "auto lang download has no packInfo")
		self:_setTaskFinish()
	end
end

function AutoLangState:_startDownLang()
	if self._taskLang ~= nil then
		self._taskLang:resetInfo()
		DownMgr.startDownTask(self._taskLang)
	end
end

function AutoLangState:_onLangDownProcess(arg_17_1, arg_17_2)
	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.LANGPROG, {
		finish = arg_17_1,
		total = arg_17_2
	})
end

function AutoLangState:_onLangDownOK()
	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.UNZIP)
end

function AutoLangState:_onLangUnzipOK()
	MultilingualMgr:setLangVersion(self._destLang, self._newVersion)
	self:_showChangeLangTips()
end

function AutoLangState:_onLangDownError(arg_20_1, arg_20_2)
	if var_0_4:hasNetwork() then
		self:_startDownLang()
	else
		local var_20_0 = require("app.view.base.component.BaseTxtPopComp").new

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new({
			text = g.core.lang:get(100007, {
				errcode = arg_20_1
			}),
			text_ok = g.core.lang:get(100008),
			handler_ok = handler(self, self._startDownLang)
		}), {
			ignoreTouch = true
		})
	end
end

function AutoLangState:_showChangeLangTips()
	local var_21_0 = MultilingualMgr:getLangNameByDesc(self._destLang)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseOperationChoosePop").new({
		titleType = 1,
		hideClose = true,
		title = g.core.lang:get(100044),
		desc = g.core.lang:get(100045, {
			langname = var_21_0
		}),
		operationBtn1Text = var_21_0,
		operationBtn2Text = MultilingualMgr:getLangNameByDesc(MultilingualMgr:getUseLang()),
		operationCallBack1 = handler(self, self.setUseSystemLang),
		operationCallBack2 = handler(self, self.notUseSystemLang)
	}), {
		ignoreTouch = true
	})
end

function AutoLangState:setUseSystemLang()
	self._ownerFSM:setNeedReboot()
	MultilingualMgr:setUseLang(self._destLang)
	self:notUseSystemLang()
end

function AutoLangState:notUseSystemLang()
	self._autoLangStorage.auto_change_fix = true

	self:_doSerialize()
	self:_setTaskFinish()
end

return AutoLangState
