local UpgradeConst = require("upgrade.UpgradeConst")
local UpgradeOut = require("upgrade.UpgradeOut")
local UpgradeUtil = require("upgrade.UpgradeUtil")
local var_0_3 = g.core.platform.PlatformProxy
local MicroInfoState = class("MicroInfoState", require("app.core.fsm.KSSimpleState"))

function MicroInfoState:ctor()
	MicroInfoState.super.ctor(self)

	self._stUUID = UpgradeConst.EN_FSM_ST.MICRO_CHECK
	self.localMicroStorage = nil
	self.download_packages = nil
	self.download_order = nil
	self._upgrade_url1 = nil
	self._upgrade_url2 = nil
end

function MicroInfoState:doBeforeEntering()
	self.download_packages = {}
	self.download_order = {}

	if config.IS_MICRO_PKG and not self:_checkMicroSynced() then
		local var_2_0 = cc.FileUtils:getInstance()

		if var_2_0:isFileExist(device.obbDirPath) then
			var_2_0:removeDirectory(device.obbDirPath)
		end

		self:_fetchMicroInfo()
	else
		self:_setTaskFinish()
	end
end

function MicroInfoState:doBeforeLeaving()
	return
end

function MicroInfoState:doReasonState()
	if self:_isTaskFinish() then
		return UpgradeConst.EN_FSM_ST.UPGRADE_INFO
	end

	return nil
end

function MicroInfoState:_checkMicroSynced()
	self.localMicroStorage = g.core.common.Storage:load("micro_config.json", false) or {}

	return self.localMicroStorage[UpgradeConst.MICRO_SYNCED_VER] == config.GAME_VERSION_NO
end

function MicroInfoState:_fetchMicroInfo()
	UpgradeUtil.httpGet(string.gsub((not config.USE_CDN_UPGRADE or nil) and UpgradeOut.MICRO_UPGRADE_CONFIG_TEST, "#micro_version#", config.GAME_VERSION_NO) .. "?t=" .. os.time(), handler(self, self._handleFetchMicroInfoOK), handler(self, self._handleFetchMicroInfoErr))
end

function MicroInfoState:_handleFetchMicroInfoOK(arg_7_1)
	if not arg_7_1 then
		self:_handleFetchMicroInfoErr({
			status = "micro response is nil"
		})

		return
	end

	local var_7_0 = tostring(config.GAME_VERSION_NO)

	if not arg_7_1[var_7_0] then
		self:_handleFetchMicroInfoErr({
			status = "micro package is nil"
		})

		return
	end

	self._upgrade_url1 = string.gsub(arg_7_1.upgrade_url, "#micro_version#", var_7_0)
	self._upgrade_url2 = string.gsub(arg_7_1.upgrade_url2, "#micro_version#", var_7_0)

	for iter_7_0, iter_7_1 in ipairs(arg_7_1[var_7_0]) do
		local var_7_1 = {
			url = iter_7_1.name
		}

		var_7_1.md5 = iter_7_1.md5 or ""
		var_7_1.size = iter_7_1.size
		var_7_1.packageKey = var_7_0 .. iter_7_0
		var_7_1.savePath = self._ownerFSM.downloadFolder .. iter_7_1.name
		self.download_packages[var_7_1.packageKey] = {
			finish = 0,
			path = var_7_1,
			total = var_7_1.size,
			md5 = var_7_1.md5
		}

		table.insert(self.download_order, var_7_1.savePath)
	end

	self:_showUpgradeTips()
end

function MicroInfoState:_handleFetchMicroInfoErr(arg_8_1)
	local var_8_0 = ""

	if arg_8_1.status then
		var_8_0 = "s" .. arg_8_1.status
	elseif arg_8_1.readyState then
		var_8_0 = "r" .. arg_8_1.readyState
	end

	if var_0_3:hasNetwork() then
		self:_fetchMicroInfo()
	else
		local var_8_1 = {}

		var_8_1.text = g.core.lang:get(100011, {
			errcode = var_8_0
		})
		var_8_1.handler_ok = handler(self, self._fetchMicroInfo)
		var_8_1.handler_cancel = handler(self, self._fetchMicroInfo)

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_8_1), {
			ignoreTouch = true
		})
	end
end

function MicroInfoState:_showUpgradeTips()
	local var_9_0 = var_0_3:isWIFIState() and g.core.lang:get(100001) or ""
	local var_9_1 = g.core.lang:get(100002, {
		size = g.core.utils.Number.toMemoryShortSize(self:_calcProgressDownData().total),
		wifi = var_9_0
	})
	local var_9_2 = self

	if self._upgrade_url2 and self._upgrade_url2 ~= "" then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseOperationChoosePop").new({
			titleType = 1,
			hideClose = true,
			title = g.core.lang:get(100003),
			desc = var_9_1,
			operationBtn1Text = g.core.lang:get(100004),
			operationBtn2Text = g.core.lang:get(100005),
			operationCallBack1 = function()
				var_9_2:_startPackageDownload(2)
			end,
			operationCallBack2 = function()
				var_9_2:_startPackageDownload(1)
			end
		}), {
			ignoreTouch = true
		})
	else
		local var_9_3 = require("app.view.base.component.BaseAssistPopComp").new

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
			type = 1,
			title = g.core.lang:get(100003),
			text = var_9_1,
			text_cancel = g.core.lang:get(100006),
			handler_cancel = function()
				var_9_2:_startPackageDownload(1)
			end
		}), {
			ignoreTouch = true
		})
	end
end

function MicroInfoState:_startPackageDownload(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.download_packages) do
		iter_13_1.path.url = ((arg_13_1 == 2 or nil) and self._upgrade_url2) .. iter_13_1.path.url

		uf.UpgradeManager:getInstance():addDownloadTask(iter_13_1.path.url, iter_13_1.path.packageKey, handler(self, self._onDownloadEvent), iter_13_1.path.md5 or "", iter_13_1.path.savePath)
	end

	uf.UpgradeManager:getInstance():startDownload()
end

function MicroInfoState:_onDownloadEvent(arg_14_1, arg_14_2)
	if arg_14_1 == uf.UpgradeManager.Event_Start then
		self:_onDownloadStart()
	elseif arg_14_1 == uf.UpgradeManager.Event_Exception then
		self:_onDownloadException(arg_14_2)
	elseif arg_14_1 == uf.UpgradeManager.Event_Progress then
		self:_onDownloadProgress(arg_14_2)
	elseif arg_14_1 == uf.UpgradeManager.Event_Finish then
		self:_onDownloadFinishOne()
	end
end

function MicroInfoState:_onDownloadStart()
	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.START, (self:_calcProgressDownData()))
end

function MicroInfoState:_onDownloadException(arg_16_1)
	local var_16_0 = self
	local var_16_1 = g.core.lang:get(100007, {
		errcode = arg_16_1.err_code
	})
	local var_16_2 = {
		text = var_16_1,
		text_ok = g.core.lang:get(100008),
		handler_ok = function()
			local var_17_0

			if arg_16_1 then
				var_17_0 = arg_16_1.customId or ""
			end

			local var_17_1 = var_16_0.download_packages[var_17_0] or {}
			local var_17_2, var_17_3, var_17_4

			if var_17_1 then
				var_17_2 = var_17_1.path.savePath or ""

				if var_17_1 then
					var_17_3 = var_17_1.path.md5 or ""

					if var_17_1 then
						var_17_4 = var_17_1.path.url or arg_16_1.url
					end
				end
			end

			uf.UpgradeManager:getInstance():addDownloadTask(var_17_4, var_17_0, function()
				var_16_0:_onDownloadEvent(...)
			end, var_17_3 or "", var_17_2)
			uf.UpgradeManager:getInstance():startDownload()
		end
	}

	if var_0_3:hasNetwork() then
		var_16_2.handler_ok()
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_16_2), {
			ignoreTouch = true
		})

		arg_16_1.errorTip = var_16_1

		self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.ERROR, arg_16_1)
	end
end

function MicroInfoState:_onDownloadProgress(arg_19_1)
	local var_19_0, var_19_1

	if arg_19_1 then
		var_19_0 = arg_19_1.customId or nil

		if type(var_19_0) ~= "string" or #var_19_0 < 3 then
			return
		end

		if arg_19_1 then
			var_19_1 = arg_19_1.finish or 0
		end
	end

	local var_19_2 = self.download_packages[var_19_0] or {}
	local var_19_3, var_19_4

	if var_19_2 then
		var_19_3 = var_19_2.finish or 0

		if arg_19_1 then
			var_19_4 = arg_19_1.total or var_19_2.total
		end
	end

	var_19_2.total = var_19_4

	if var_19_1 == var_19_3 then
		return
	end

	var_19_2.finish = var_19_1

	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.PROGRESS, (self:_calcProgressDownData()))
end

function MicroInfoState:_onDownloadFinishOne()
	if not self:_checkAllDownloadFinish() then
		return
	end

	g.core.common.Scheduler:newScheduleOnce(handler(self, self._endPackageDownload), 0.5)
end

function MicroInfoState:_calcProgressDownData()
	local var_21_0 = 0
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in pairs(self.download_packages) do
		var_21_0 = var_21_0 + ((iter_21_1 or nil) and (iter_21_1.total or 0))
		var_21_1 = var_21_1 + ((iter_21_1 or nil) and (iter_21_1.finish or 0))
	end

	return {
		finish = var_21_1,
		total = var_21_0
	}
end

function MicroInfoState:_checkAllDownloadFinish()
	for iter_22_0, iter_22_1 in pairs(self.download_packages) do
		if iter_22_1 then
			if iter_22_1 then
				if (iter_22_1.finish or 0) < (iter_22_1.total or 1) then
					return false
				end
			end
		end
	end

	return true
end

function MicroInfoState:_endPackageDownload()
	if self:_checkFileMD5() then
		self:_startUnzip()
	end
end

function MicroInfoState:_checkFileMD5()
	return true
end

function MicroInfoState:_startUnzip()
	self._ownerFSM:dispatchUIMessage(UpgradeConst.EN_UI_MSG.UNZIP)
	uf.UpgradeManager:getInstance():unzipPackages(self.download_order, handler(self, self._onUnzipEvent), device.obbDirPath)
end

function MicroInfoState:_onUnzipEvent(arg_26_1)
	if arg_26_1.finish then
		self:_setMicroUpgradeEnd()

		return
	end

	if not arg_26_1.ret then
		local var_26_0 = self
		local var_26_1 = {}

		if arg_26_1 then
			var_26_1.filePath = arg_26_1.path or ""
		end

		local var_26_2 = {}

		var_26_2.text = g.core.lang:get(100012, var_26_1)

		function var_26_2.handler_ok()
			var_26_0:_tempErrorProcess()
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_26_2), {
			ignoreTouch = true
		})
	end
end

function MicroInfoState:_startOneUnzip(arg_28_1)
	uf.UpgradeManager:getInstance():unzipPackage(arg_28_1, handler(self, self._onUnzipEvent), device.obbDirPath)
end

function MicroInfoState:_tempErrorProcess()
	if type(__REMOVE_LOCAL_CACHE__) == "function" then
		__REMOVE_LOCAL_CACHE__()
	end

	device.restartGame()
end

function MicroInfoState:_setMicroUpgradeEnd()
	self._ownerFSM:setNeedReboot()

	self.localMicroStorage[UpgradeConst.MICRO_SYNCED_VER] = config.GAME_VERSION_NO

	g.core.common.Storage:save("micro_config.json", self.localMicroStorage, false)
	self:_setTaskFinish()
end

return MicroInfoState
