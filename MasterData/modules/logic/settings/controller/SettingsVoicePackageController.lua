-- chunkname: @modules/logic/settings/controller/SettingsVoicePackageController.lua

module("modules.logic.settings.controller.SettingsVoicePackageController", package.seeall)

local SettingsVoicePackageController = class("SettingsVoicePackageController", BaseController)

SettingsVoicePackageController.NotDownload = 1
SettingsVoicePackageController.InDownload = 2
SettingsVoicePackageController.NeedUpdate = 3
SettingsVoicePackageController.AlreadyLatest = 4
SettingsVoicePackageController.DownloadFailedToast = 173
SettingsVoicePackageController.NoEnoughDisk = 5
SettingsVoicePackageController.MD5CheckError = 6

function SettingsVoicePackageController:onInit()
	self._httpGetter = nil
	self._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	self._optionalUpdateInst = self._optionalUpdate.Instance
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	self._statHotUpdatePerList = {}
	self._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	self._statHotUpdatePerList[2] = {
		0.2,
		"20%"
	}
	self._statHotUpdatePerList[3] = {
		0.4,
		"40%"
	}
	self._statHotUpdatePerList[4] = {
		0.6,
		"60%"
	}
	self._statHotUpdatePerList[5] = {
		0.8,
		"80%"
	}
	self._statHotUpdatePerList[6] = {
		1,
		"100%"
	}
	self._statHotUpdatePerNum = 6
	self._nowStatHotUpdatePerIndex = 1
end

function SettingsVoicePackageController:onInitFinish()
	return
end

function SettingsVoicePackageController:addConstEvents()
	if not HotUpdateVoiceMgr then
		return
	end

	if not GameConfig.CanHotUpdate then
		return
	end

	self._optionalUpdateInst:Register(self._optionalUpdate.NotEnoughDiskSpace, self._onNotEnoughDiskSpace, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadStart, self._onDownloadStart, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadProgressRefresh, self._onDownloadProgressRefresh, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadPackFail, self._onDownloadPackFail, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadPackSuccess, self._onDownloadPackSuccess, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.PackUnZipFail, self._onPackUnZipFail, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.PackItemStateChange, self._onPackItemStateChange, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, self._onReconnectSucc, self)
end

function SettingsVoicePackageController:register()
	self._optionalUpdateInst:Register(self._optionalUpdate.NotEnoughDiskSpace, self._onNotEnoughDiskSpace, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadStart, self._onDownloadStart, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadProgressRefresh, self._onDownloadProgressRefresh, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadPackFail, self._onDownloadPackFail, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.DownloadPackSuccess, self._onDownloadPackSuccess, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.PackUnZipFail, self._onPackUnZipFail, self)
	self._optionalUpdateInst:Register(self._optionalUpdate.PackItemStateChange, self._onPackItemStateChange, self)
end

function SettingsVoicePackageController:reInit()
	return
end

function SettingsVoicePackageController:getLocalVersionInt(packName)
	if not GameConfig.CanHotUpdate then
		return 0
	end

	if not self._optionalUpdateInst then
		self._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		self._optionalUpdateInst = self._optionalUpdate.Instance
	end

	local versionStr = self._optionalUpdateInst:GetLocalVersion(packName)

	if not string.nilorempty(versionStr) then
		return tonumber(versionStr)
	end

	return 0
end

function SettingsVoicePackageController:switchVoiceType(voiceType, entrance, auto)
	local oldvoiceType = GameConfig:GetCurVoiceShortcut()
	local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(voiceType)

	PlayerPrefsHelper.setNumber("StoryAudioLanType", lanIndex - 1)
	GameLanguageMgr.instance:setVoiceTypeByStoryIndex(lanIndex)
	PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, voiceType)
	AudioMgr.instance:changeLang(voiceType)
	GameConfig:SetCurVoiceType(voiceType)

	if auto then
		return
	end

	self:dispatchEvent(SettingsEvent.OnChangeVoiceType)

	local data = {}

	data.current_language = GameConfig:GetCurLangShortcut()
	data.entrance = entrance or ""
	data.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList() or {}
	data.current_voice_pack_used = voiceType or ""
	data.voice_pack_before = oldvoiceType or ""

	if entrance == "in_settings" or entrance == "in_voiceview" then
		StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, data)
	else
		SDKDataTrackMgr.instance:trackVoicePackSwitch(data)
	end
end

function SettingsVoicePackageController:openVoicePackageView()
	if not self._httpGetter then
		self._httpGetter = SettingVoiceHttpGetter.New()

		self._httpGetter:start(self._onGetVoiceInfoAndOpenView, self)
	else
		self:_openVoicePackageView()
	end
end

function SettingsVoicePackageController:RequsetVoiceInfo(callback, callbackObj)
	if not ProjBooter.instance:isUseBigZip() then
		if callback then
			callback(callbackObj)
		end
	else
		self._httpGetter = self._httpGetter or SettingVoiceHttpGetter.New()

		self._httpGetter:start(function()
			self:_onGetVoiceInfo()

			if callback then
				callback(callbackObj)
			end
		end, self)
	end
end

function SettingsVoicePackageController:onSettingVoiceDropDown()
	if not self._httpGetter then
		self._httpGetter = SettingVoiceHttpGetter.New()

		self._httpGetter:start(self._onGetVoiceInfo, self)
	end
end

function SettingsVoicePackageController:_onGetVoiceInfo()
	local result = self._httpGetter:getHttpResult()

	for lang, langInfo in pairs(result) do
		local mo = SettingsVoicePackageModel.instance:getPackInfo(lang)

		if mo then
			mo:setLangInfo(langInfo)

			if #mo.downloadResList.names > 0 then
				local res = mo.downloadResList

				self._optionalUpdateInst:InitBreakPointInfo(res.names, res.hashs, res.orders, res.lengths)

				local recvSize = self._optionalUpdateInst:GetRecvSize()

				recvSize = tonumber(recvSize)

				mo:setLocalSize(recvSize)
				self:dispatchEvent(SettingsEvent.OnPackItemStateChange, mo.lang)
			end
		end
	end
end

function SettingsVoicePackageController:_onGetVoiceInfoAndOpenView()
	self:_onGetVoiceInfo()
	self:_openVoicePackageView()
end

function SettingsVoicePackageController:_openVoicePackageView()
	ViewMgr.instance:openView(ViewName.SettingsVoicePackageView)
end

function SettingsVoicePackageController:getHttpResult()
	if self._httpGetter then
		return self._httpGetter:getHttpResult()
	end
end

function SettingsVoicePackageController:getLangSize(lang)
	if self._httpGetter then
		return self._httpGetter:getLangSize(lang)
	end
end

function SettingsVoicePackageController:tryDownload(packInfo, needTip)
	if ViewMgr.instance:isOpen(ViewName.SettingsVoiceDownloadView) then
		return
	end

	if #packInfo.downloadResList.names == 0 and ProjBooter.instance:isUseBigZip() then
		if self._httpGetter then
			self._httpGetter:stop()

			self._httpGetter = nil
		end

		self:openVoicePackageView()

		return
	end

	if needTip then
		local leftSize, size, units = packInfo:getLeftSizeMBorGB()

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DownloadVoicePack, MsgBoxEnum.BoxType.Yes_No, function()
			local data = {}

			data.entrance = "voice_list"
			data.update_amount = packInfo:getLeftSizeMBNum()
			data.download_voice_pack_list = {
				packInfo.lang
			}
			data.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList()
			data.current_language = GameConfig:GetCurLangShortcut()
			data.current_voice_pack_used = GameConfig:GetCurVoiceShortcut()

			StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, data)
			self:startDownload(packInfo)
			ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
				packItemMO = packInfo
			})
		end, function()
			return
		end, nil, nil, nil, nil, luaLang(packInfo.nameLangId), string.format("%.2f%s", leftSize, units))
	else
		self:startDownload(packInfo)
		ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
			packItemMO = packInfo
		})
	end
end

function SettingsVoicePackageController:getPackItemState(lang, latestVersion)
	return self._optionalUpdateInst:GetPackItemState(lang, latestVersion)
end

function SettingsVoicePackageController:startDownload(mo)
	logNormal("startDownload lang = " .. mo.lang .. " version = " .. mo.latestVersion)

	if not ProjBooter.instance:isUseBigZip() then
		OptionPackageDownloadMgr.instance:startDownload(mo.lang, {}, {
			mo.lang
		})
	else
		local res = mo.downloadResList
		local downloadUrl, downloadUrlBak = mo.download_url, mo.download_url_bak

		self._optionalUpdateInst:SetRemoteAssetUrl(downloadUrl, downloadUrlBak)
		self:_setUseReserveUrl()
		self._optionalUpdateInst:StartDownload(mo.lang, res.names, res.hashs, res.orders, res.lengths, mo.latestVersion)
	end

	self:_onDownloadPrepareStart(mo.lang)
end

function SettingsVoicePackageController:stopDownload(resItem)
	if not ProjBooter.instance:isUseBigZip() then
		OptionPackageDownloadMgr.instance:StopDownload()
	else
		self._optionalUpdateInst:StopDownload()
		self._optionalUpdateInst:ClearThread()
	end

	self:dispatchEvent(SettingsEvent.OnDownloadPackFail, resItem.lang)
end

function SettingsVoicePackageController:startDownloadAll()
	local data = SettingsVoicePackageListModel.instance:getList()

	for _, item in pairs(data) do
		local itemStatus = item:getStatus()

		if itemStatus == SettingsVoicePackageController.NotDownload or itemStatus == SettingsVoicePackageController.NeedUpdate then
			self:startDownload(item)
		end
	end
end

function SettingsVoicePackageController:deleteVoicePack(packname)
	local resItem = SettingsVoicePackageModel.instance:getPackInfo(packname)
	local data = {}

	data.current_language = GameConfig:GetCurLangShortcut()
	data.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList()
	data.current_voice_pack_used = GameConfig:GetCurVoiceShortcut()
	data.voice_pack_delete = resItem.lang

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, data)
	resItem:setLocalSize(0)
	self._optionalUpdateInst:RemovePackInfo(packname)

	if packname == "res-HD" then
		local HDdir = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/HD"

		SLFramework.FileHelper.ClearDir(HDdir)
		logNormal("removeVoicePack  hdDir=" .. HDdir)
	else
		for k, packageType in pairs(OptionPackageEnum.Package) do
			local optionPackname = HotUpdateOptionPackageMgr.instance:formatLangPackName(packname, packageType)

			self._optionalUpdateInst:RemovePackInfo(optionPackname)
		end

		local audiosDir = SLFramework.FrameworkSettings.PersistentResRootDir .. "/audios/" .. SLFramework.FrameworkSettings.CurPlatformName .. "/" .. packname

		SLFramework.FileHelper.ClearDir(audiosDir)

		local voideoDir = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/" .. packname

		SLFramework.FileHelper.ClearDir(voideoDir)
		logNormal("removeVoicePack  audiosDir=" .. audiosDir)
		logNormal("removeVoicePack  voideoDir=" .. voideoDir)
	end

	ToastController.instance:showToast(183, luaLang(resItem.nameLangId))
	SettingsVoicePackageModel.instance:onDeleteVoicePack(packname)
	OptionPackageDownloadMgr.instance:deletePack(packname)
	self:dispatchEvent(SettingsEvent.OnPackItemStateChange, packname)

	if self._httpGetter then
		self._httpGetter:stop()

		self._httpGetter = nil
	end

	self:openVoicePackageView()
end

function SettingsVoicePackageController:_onReconnectSucc()
	if self.errorCode then
		local ErrorDefine = SLFramework.GameUpdate.FailError

		if self.errorCode == ErrorDefine.NoEnoughDisk or self.errorCode == ErrorDefine.MD5CheckError then
			self:_cancelDownload()
		else
			self._optionalUpdateInst:RunNextStepAction()
		end

		self.errorCode = nil
	end
end

function SettingsVoicePackageController:_onDownloadPrepareStart(packName)
	logNormal("SettingsVoicePackageController:_onDownloadPrepareStart, packName = " .. packName)
	self:dispatchEvent(SettingsEvent.OnDownloadPrepareStart, packName)
end

function SettingsVoicePackageController:_onDownloadStart(packName, curSize, allSize)
	logNormal("SettingsVoicePackageController:_onDownloadStart, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)
	SettingsVoicePackageModel.instance:setDownloadProgress(packName, curSize, allSize)
	self:dispatchEvent(SettingsEvent.OnDownloadStart, packName, curSize, allSize)

	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(packName)

	self._nowStatHotUpdatePerIndex = 1
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	self:statHotUpdate(curSize / allSize, packInfo)
end

function SettingsVoicePackageController:_onDownloadProgressRefresh(packName, curSize, allSize)
	local progressChanged = not self._prevSize or curSize ~= self._prevSize

	self._prevSize = curSize

	if LoginModel.instance:getFailCount() > 0 and progressChanged then
		LoginModel.instance:resetFailCount()
	end

	logNormal("SettingsVoicePackageController:_onDownloadProgressRefresh, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)
	SettingsVoicePackageModel.instance:setDownloadProgress(packName, curSize, allSize)
	self:dispatchEvent(SettingsEvent.OnDownloadProgressRefresh, packName, curSize, allSize)

	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(packName)

	if self.initFinish == false then
		curSize = string.format("%0.2f", curSize)
		allSize = string.format("%0.2f", allSize)

		local nameLangId = packInfo.nameLangId
		local tag = {
			luaLang(nameLangId),
			curSize,
			allSize
		}
		local text = GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_2"), tag)

		GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, curSize / allSize, text)
	end

	self:statHotUpdate(curSize / allSize, packInfo)
end

function SettingsVoicePackageController:statHotUpdate(percent, packInfo)
	for i = self._nowStatHotUpdatePerIndex, self._statHotUpdatePerNum do
		local v = self._statHotUpdatePerList[i]
		local startPoint = v[1]

		if startPoint <= percent then
			local data = {}

			data.step = v[2]
			data.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - self._downLoadStartTime
			data.update_amount = packInfo:getLeftSizeMBNum()
			data.download_voice_pack_list = {
				packInfo.lang
			}
			data.result_msg = "", StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, data)
			self._nowStatHotUpdatePerIndex = i + 1
		else
			break
		end
	end
end

function SettingsVoicePackageController:_onPackItemStateChange(packName)
	logNormal("SettingsVoicePackageController:_onPackItemStateChange, packName = " .. packName)
	self:dispatchEvent(SettingsEvent.OnPackItemStateChange, packName)
end

function SettingsVoicePackageController:_onDownloadPackSuccess(packName)
	logNormal("SettingsVoicePackageController:_onDownloadPackSuccess, packName = " .. packName)
	SettingsVoicePackageModel.instance:onDownloadSucc(packName)
	self:dispatchEvent(SettingsEvent.OnDownloadPackSuccess, packName)

	if self.initFinish == false and self.needUpdateMODic[packName] then
		self.allUpdateSize = 0
		self.alreadyUpdateSize = self.needUpdateMODic[packName].size
		self.needUpdateMODic[packName] = nil

		for i, v in pairs(self.needUpdateMODic) do
			self.allUpdateSize = self.allUpdateSize + v.size
		end

		self.allUpdateSize = self.allUpdateSize / 1024 / 1024

		if self.allUpdateSize == 0 then
			self:_tryOptionDataInitedCallBack(true)
		end
	end
end

function SettingsVoicePackageController:_setUseReserveUrl()
	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type_OptionalUpdate = typeof(SLFramework.GameUpdate.OptionalUpdate)
	local field_useReserveUrl = tolua.getfield(type_OptionalUpdate, "_useReserveUrl", 36)

	field_useReserveUrl:Set(SLFramework.GameUpdate.OptionalUpdate.Instance, LoginModel.instance:getUseBackup())
end

function SettingsVoicePackageController:_onDownloadPackFail(packName, resUrl, failError, errorMsg)
	logNormal("SettingsVoicePackageController:_onDownloadPackFail, packName = " .. packName .. " resUrl = " .. resUrl .. " failError = " .. failError)
	self:dispatchEvent(SettingsEvent.OnDownloadPackFail, packName, resUrl, failError)

	local langeName = SettingsVoicePackageModel.instance:getPackLangName(packName)

	if failError == 5 then
		self:_onNotEnoughDiskSpace(packName)
	else
		LoginModel.instance:inverseUseBackup()
		self:_setUseReserveUrl()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()

			local tips = self:_getDownloadFailedTip(failError, errorMsg)

			if self.initFinish == false then
				MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
					self._optionalUpdateInst:RunNextStepAction()

					self.errorCode = nil
				end, function()
					ProjBooter.instance:quitGame()
				end, nil, nil, nil, nil, langeName, tips)
			else
				MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", luaLang("cancel"), "CANCEL", function()
					self._optionalUpdateInst:RunNextStepAction()

					self.errorCode = nil
				end, function()
					SettingsVoicePackageModel.instance:clearNeedDownloadSize(packName)
					self:_cancelDownload()
				end, nil, nil, nil, nil, langeName, tips)
			end
		else
			self:_retryDownload()
		end
	end

	local packInfo = SettingsVoicePackageModel.instance:getPackInfo(packName)
	local data = {}

	data.step = ""
	data.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - self._downLoadStartTime
	data.update_amount = packInfo:getLeftSizeMBNum()
	data.download_voice_pack_list = {
		packInfo.lang
	}
	data.result_msg = self:_getDownloadFailedTip(failError, errorMsg)

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, data)
end

function SettingsVoicePackageController:_retryDownload()
	self._optionalUpdateInst:RunNextStepAction()

	self.errorCode = nil
end

function SettingsVoicePackageController:_getDownloadFailedTip(errorCode, errorMsg)
	local ErrorDefine = SLFramework.GameUpdate.FailError

	errorCode = ErrorDefine.IntToEnum(errorCode)
	self.errorCode = errorCode
	errorMsg = errorMsg or ""

	if errorCode == ErrorDefine.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif errorCode == ErrorDefine.NotFound then
		return booterLang("download_fail_not_found")
	elseif errorCode == ErrorDefine.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif errorCode == ErrorDefine.TimeOut then
		return booterLang("download_fail_time_out")
	elseif errorCode == ErrorDefine.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif errorCode == ErrorDefine.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(errorMsg)
	end
end

function SettingsVoicePackageController:_onNotEnoughDiskSpace(packName)
	logNormal("SettingsVoicePackageController:_onNotEnoughDiskSpace, packName = " .. packName)
	self:dispatchEvent(SettingsEvent.OnNotEnoughDiskSpace, packName)

	local langeName = SettingsVoicePackageModel.instance:getPackLangName(packName)
	local tips = self:_getDownloadFailedTip(SettingsVoicePackageController.NoEnoughDisk)

	if self.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
			self._optionalUpdateInst:RunNextStepAction()

			self.errorCode = nil
		end, function()
			ProjBooter.instance:quitGame()
		end, nil, nil, nil, nil, langeName)
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(packName)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes, function()
			self:_cancelDownload()
		end, nil, nil, nil, nil, nil, langeName)
	end
end

function SettingsVoicePackageController:_onPackUnZipFail(packName, failReason)
	logNormal("SettingsVoicePackageController:_onPackUnZipFail, packName = " .. packName .. " failReason = " .. failReason)
	self:dispatchEvent(SettingsEvent.OnPackUnZipFail, packName, failReason)

	local langeName = SettingsVoicePackageModel.instance:getPackLangName(packName)
	local tips = self:_getDownloadFailedTip(SettingsVoicePackageController.MD5CheckError)

	if self.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
			self._optionalUpdateInst:RunNextStepAction()

			self.errorCode = nil
		end, function()
			ProjBooter.instance:quitGame()
		end, nil, nil, nil, nil, langeName)
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(packName)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes, function()
			self:_cancelDownload()
		end, nil, nil, nil, nil, nil, langeName)
	end
end

function SettingsVoicePackageController:_onUnzipProgress(progress)
	logNormal("正在解压资源包，请稍后... progress = " .. progress)

	if tostring(progress) == "nan" then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, progress, luaLang("voice_package_update_unzip"))
	self:dispatchEvent(SettingsEvent.OnUnzipProgressRefresh, progress)
end

function SettingsVoicePackageController:cancelDownload()
	self:_cancelDownload()
end

function SettingsVoicePackageController:_cancelDownload()
	self._optionalUpdateInst:StopDownload()
	self._optionalUpdateInst:ClearThread()
	ViewMgr.instance:closeView(ViewName.SettingsVoiceDownloadView)

	self.errorCode = nil
end

SettingsVoicePackageController.instance = SettingsVoicePackageController.New()

return SettingsVoicePackageController
