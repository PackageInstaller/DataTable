-- chunkname: @modules/logic/settings/controller/SettingsController.lua

module("modules.logic.settings.controller.SettingsController", package.seeall)

local SettingsController = class("SettingsController", BaseController)

function SettingsController:openView()
	local data = {}

	data.cateList = SettingsModel.instance:getSettingsCategoryList()

	ViewMgr.instance:openView(ViewName.SettingsView, data)
end

function SettingsController:onInit()
	return
end

function SettingsController:onInitFinish()
	return
end

function SettingsController:addConstEvents()
	AudioMgr.instance:registerCallback(AudioMgr.Evt_ChangeFinish, self._onChangeFinish, self)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, self._onLoginFinish, self)
end

function SettingsController:reInit()
	self:checkRecordLogout()
end

function SettingsController:changeLangTxt()
	UIBlockMgr.instance:startBlock("SettingsController:changeLangTxt")

	self._fontAssetDone = false
	self._changeLangDelaytDone = false

	GameGlobalMgr.instance:getLangFont():changeFontAsset(self._changeLangFontAssetCallBack, self)
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()
	ViewMgr.instance:closeAllViews({
		ViewName.SettingsView,
		ViewName.PlayerIdView,
		ViewName.WaterMarkView
	})
	ViewDestroyMgr.instance:destroyImmediately()
	TaskDispatcher.runDelay(SettingsController._changeLangTxtDelay, self, 0.01)
end

function SettingsController:_changeLangFontAssetCallBack()
	self._fontAssetDone = true

	self:_changeLang2()
end

function SettingsController:_changeLangTxtDelay()
	self._changeLangDelaytDone = true

	self:_changeLang2()
end

function SettingsController:_changeLang2()
	if self._fontAssetDone and self._changeLangDelaytDone then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, self)
		ViewMgr.instance:openView(ViewName.MainView)
		SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeLangTxt)

		local language = GameConfig:GetCurLangType()
		local aihelpKey = LangSettings.aihelpKey[language]

		if aihelpKey then
			if SDKMgr.instance.setLanguage then
				SDKMgr.instance:setLanguage(aihelpKey)
			end
		else
			logError("aihelpKey miss :" .. language)
		end

		UIBlockMgr.instance:endBlock("SettingsController:changeLangTxt")
	end
end

function SettingsController:getStoryVoiceType()
	local curVoiceType = PlayerPrefsHelper.getString(PlayerPrefsKey.VoiceTypeKey_Story)

	if curVoiceType == nil then
		curVoiceType = GameConfig:GetCurVoiceShortcut()

		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, curVoiceType)
	end

	return curVoiceType
end

function SettingsController:checkRecordLogout()
	logNormal("SettingsController:checkRecordLogout()")

	if not SDKMgr.isSupportRecord or not SDKMgr.instance:isSupportRecord() then
		return
	end

	if SDKMgr.instance:isRecording() then
		SDKMgr.instance:stopRecord()
	end

	SDKMgr.instance:hideRecordBubble()
end

function SettingsController:_onLoginFinish()
	logNormal("SettingsController:_onLoginFinish()")

	local isRecordOn = SettingsModel.instance:getRecordVideo()

	if SettingsShowHelper.canShowRecordVideo() and isRecordOn then
		SDKMgr.instance:showRecordBubble()
	end

	if SDKMgr.instance:isEmulator() then
		local num = PlayerPrefsHelper.getNumber(PlayerPrefsKey.EmulatorVideoCompatible, 0)
		local videoCode = 2

		if num ~= videoCode then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.EmulatorVideoCompatible, videoCode)
			SettingsModel.instance:setVideoCompatible(videoCode == 1)
		end
	end

	SettingsVoicePackageModel.instance:updateVoiceList(false)
end

function SettingsController:checkSwitchRecordVideo()
	if SettingsShowHelper.canShowRecordVideo() then
		local isOn = not SettingsModel.instance:getRecordVideo()

		if isOn then
			if BootNativeUtil.isAndroid() then
				SDKMgr.instance:requestReadAndWritePermission()
			end

			SDKMgr.instance:showRecordBubble()
		else
			if SDKMgr.instance:isRecording() then
				GameFacade.showToast(ToastEnum.RecordingVideoSwitchOff)

				return false
			end

			SDKMgr.instance:hideRecordBubble()
		end

		SettingsModel.instance:setRecordVideo(isOn)

		return true
	end

	return false
end

function SettingsController:_onChangeFinish()
	self._inSwitch = false
end

SettingsController.instance = SettingsController.New()

return SettingsController
