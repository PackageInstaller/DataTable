-- chunkname: @modules/logic/settings/view/SettingsGraphicsView.lua

module("modules.logic.settings.view.SettingsGraphicsView", package.seeall)

local SettingsGraphicsView = class("SettingsGraphicsView", BaseView)

function SettingsGraphicsView:onInitView()
	self._btnlow = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	self._golowselected = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/preview/#go_lowselected")
	self._golowoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	self._golowon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	self._golowrecommend = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	self._btnmiddle = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	self._gomiddleselected = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/preview/#go_middleselected")
	self._gomiddleoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	self._gomiddleon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	self._gomiddlerecommend = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	self._btnhigh = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	self._gohighselected = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/preview/#go_highselected")
	self._gohighoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	self._gohighon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	self._gohighrecommend = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	self._btnenergy = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn")
	self._goenergyon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/on")
	self._goenergyoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/off")
	self._btnvideo = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn")
	self._govideoon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/on")
	self._govideooff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/off")
	self._videoModeDrop = gohelper.findChildDropdown(self.viewGO, "graphicsScroll/Viewport/Content/videomode/dropvideoswitch")
	self._videoModeDropClick = gohelper.getClick(self._videoModeDrop.gameObject)
	self._videoModeTemplate = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/videomode/dropvideoswitch/Template")
	self._btnEyeProtect = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/protectmode/switch/btn")
	self._eyeProtectOn = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/protectmode/switch/btn/on")
	self._eyeProtectOff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/protectmode/switch/btn/off")
	self._videoHD = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/strength")
	self._btnHdMode = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn")
	self._goHdModeOn = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/on")
	self._goHdModeOff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/off")
	self._golowfps = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	self._gohighfps = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	self._framerate = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate")
	self._goscreen = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen")
	self._btnfullscreenswitch = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/#btn_fullscreenswitch")
	self._gofullscreenon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/#btn_fullscreenswitch/#go_fullscreenon")
	self._gofullscreenoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/#btn_fullscreenswitch/#go_fullscreenoff")
	self._drop = gohelper.findChildDropdown(self.viewGO, "graphicsScroll/Viewport/Content/screen/#dropResolution")
	self._dropClick = gohelper.getClick(self._drop.gameObject)
	self._framerateDrop = gohelper.findChildDropdown(self.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch")
	self._framerateDropClick = gohelper.getClick(self._framerateDrop.gameObject)
	self._frameTemplate = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch/Template")
	self.verticalmode = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/verticalmode")
	self._btnVerticalmode = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn")
	self._goVerticalmodeOn = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/on")
	self._goVerticalmodeOff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/off")
	self._goscreenshot = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/#go_screenshot")
	self._btnshot = gohelper.findChildButtonWithAudio(self._goscreenshot, "switch/btn")
	self._gooffshot = gohelper.findChild(self._goscreenshot, "switch/btn/off")
	self._goonshot = gohelper.findChild(self._goscreenshot, "switch/btn/on")
	self._goline1 = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline1")
	self._goline2 = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline2")

	gohelper.setActive(gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsGraphicsView:addEvents()
	self._btnlow:AddClickListener(self._btnlowOnClick, self)
	self._btnmiddle:AddClickListener(self._btnmiddleOnClick, self)
	self._btnhigh:AddClickListener(self._btnhighOnClick, self)
	self._btnenergy:AddClickListener(self._btnenergyOnClick, self)
	self._btnEyeProtect:AddClickListener(self._btnEyeProtectOnClick, self)
	self._btnvideo:AddClickListener(self._btnvideoOnClick, self)
	self._btnHdMode:AddClickListener(self._btnvideoHDOnClick, self)
	self._btnVerticalmode:AddClickListener(self._btnVerticalmodeClick, self)

	if BootNativeUtil.isWindows() then
		self._btnfullscreenswitch:AddClickListener(self._btnfullscreenswitchOnClick, self)
		self._drop:AddOnValueChanged(self._onValueChanged, self)
		self._dropClick:AddClickListener(function()
			self:_refreshDropdownList()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, self)
	end

	self._framerateDrop:AddOnValueChanged(self._onFrameValueChanged, self)
	self._framerateDropClick:AddClickListener(function()
		self:_refreshTargetFrameRateUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, self)
	self._videoModeDrop:AddOnValueChanged(self._onVideoModeValueChanged, self)
	self._videoModeDropClick:AddClickListener(function()
		self:_refreshVideoUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, self)

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		self._btnshot:AddClickListener(self._btnShotOnClick, self)
	end

	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeHDType, self._refreshVideoUI, self)
end

function SettingsGraphicsView:_btnEyeProtectOnClick()
	EyeProtectionModeMgr.instance:changeEyeModeActive()
	self:_refreshEyeProtectUI()
end

function SettingsGraphicsView:_refreshEyeProtectUI()
	local active = EyeProtectionModeMgr.instance:getEyeModeActive()

	gohelper.setActive(self._eyeProtectOn, active)
	gohelper.setActive(self._eyeProtectOff, not active)
end

function SettingsGraphicsView:_onVideoModeValueChanged(index)
	if index == 0 then
		SettingsModel.instance:setVideoCompatible(false)
		SettingsModel.instance:setUseUnityVideo(false)
	elseif index == 1 then
		SettingsModel.instance:setVideoCompatible(true)
		SettingsModel.instance:setUseUnityVideo(false)
	elseif index == 2 then
		SettingsModel.instance:setUseUnityVideo(true)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function SettingsGraphicsView:removeEvents()
	self._btnlow:RemoveClickListener()
	self._btnmiddle:RemoveClickListener()
	self._btnhigh:RemoveClickListener()
	self._btnenergy:RemoveClickListener()
	self._btnEyeProtect:RemoveClickListener()
	self._btnvideo:RemoveClickListener()
	self._btnHdMode:RemoveClickListener()
	self._btnVerticalmode:RemoveClickListener()

	if BootNativeUtil.isWindows() then
		self._btnfullscreenswitch:RemoveClickListener()
		self._drop:RemoveOnValueChanged()
		self._dropClick:RemoveClickListener()
	end

	self._framerateDrop:RemoveOnValueChanged()
	self._framerateDropClick:RemoveClickListener()
	self._videoModeDrop:RemoveOnValueChanged()
	self._videoModeDropClick:RemoveClickListener()

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		self._btnshot:RemoveClickListener()
	end

	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeHDType, self._refreshVideoUI, self)
end

function SettingsGraphicsView:_btnlowOnClick()
	self:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function SettingsGraphicsView:_btnmiddleOnClick()
	self:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function SettingsGraphicsView:_btnhighOnClick()
	self:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function SettingsGraphicsView:_btnenergyOnClick()
	SettingsModel.instance:changeEnergyMode()
	self:_refreshEnergyUI()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeEnergyMode)
end

function SettingsGraphicsView:_btnvideoOnClick()
	local compatible = SettingsModel.instance:getVideoCompatible()

	if compatible == false and not BootNativeUtil.isMuMu() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function()
			self:_switchVideoCompatible()
		end)
	else
		self:_switchVideoCompatible()
	end
end

function SettingsGraphicsView:_switchVideoCompatible()
	local compatible = SettingsModel.instance:getVideoCompatible()

	SettingsModel.instance:setVideoCompatible(compatible == false)
	self:_refreshVideoUI()
end

function SettingsGraphicsView:_btnvideoHDOnClick()
	local hdMode = SettingsModel.instance:getVideoHDMode()
	local packageinfo = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if not hdMode and packageinfo and packageinfo:needDownload() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoHD, MsgBoxEnum.BoxType.Yes_No, function()
			SettingsVoicePackageController.instance:RequsetVoiceInfo(function()
				SettingsVoicePackageController.instance:tryDownload(packageinfo)
			end)
		end)
	else
		self:_switchVideoHDMode()
	end
end

function SettingsGraphicsView:_btnVerticalmodeClick()
	local verticalMode = UnityEngine.QualitySettings.vSyncCount == 1

	UnityEngine.QualitySettings.vSyncCount = verticalMode and 0 or 1

	self:_refreshVerticalUI()
end

function SettingsGraphicsView:_switchVideoHDMode()
	local hdMode = SettingsModel.instance:getVideoHDMode()

	SettingsModel.instance:setVideoHDMode(hdMode == false)
	self:_refreshVideoUI()
end

function SettingsGraphicsView:_btnfullscreenswitchOnClick()
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	self:_refreshIsFullScreenUI()
end

function SettingsGraphicsView:_btnShotOnClick()
	local screenshotSwitch = not SettingsModel.instance:getScreenshotSwitch()

	SettingsModel.instance:setScreenshotSwitch(screenshotSwitch)
	self:_refreshShotUI()

	if screenshotSwitch and BootNativeUtil.isAndroid() then
		SDKMgr.instance:requestReadAndWritePermission()
	end
end

function SettingsGraphicsView:_onValueChanged(index)
	if not SettingsModel.instance:setScreenResolutionByIndex(index + 1) then
		self._drop:SetValue(self._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	self:_refreshIsFullScreenUI()

	self._preSelectedIndex = index
end

function SettingsGraphicsView:_onFrameValueChanged(index)
	SettingsModel.instance:setModelTargetFrameRate(index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function SettingsGraphicsView:_editableInitView()
	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		self:_refreshDropdownList()
		gohelper.setActive(self._drop.gameObject, true)
		gohelper.setActive(self._goscreen.gameObject, true)
	else
		gohelper.setActive(self._goscreen.gameObject, false)
	end

	if GameChannelConfig.isXfsdk() and SDKNativeUtil.isShowShareButton() then
		gohelper.setActive(self._goscreenshot, true)
	else
		gohelper.setActive(self._goscreenshot, false)
	end

	self._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() + 1)
	self:_refreshVerticalUI()
	gohelper.setActive(self.verticalmode, BootNativeUtil.isWindows())

	if BootNativeUtil.isMuMu() then
		gohelper.setActive(self._framerate, false)
	end
end

function SettingsGraphicsView:_onChangeLangTxt()
	self._drop:ClearOptions()
	self:_editableInitView()
end

function SettingsGraphicsView:onUpdateParam()
	self:_refreshUI()
end

function SettingsGraphicsView:onOpen()
	self:_refreshUI()

	local recommendQuality = SettingsModel.instance:getRecommendQuality()

	gohelper.setActive(self._golowrecommend, recommendQuality == ModuleEnum.Performance.Low)
	gohelper.setActive(self._gomiddlerecommend, recommendQuality == ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gohighrecommend, recommendQuality == ModuleEnum.Performance.High)
end

function SettingsGraphicsView:_refreshUI()
	self:_refreshGraphicsQualityUI()
	self:_refreshTargetFrameRateUI()
	self:_refreshIsFullScreenUI()
	self:_refreshShotUI()
	self:_refreshEnergyUI()
	self:_refreshVideoUI()
	self:_refreshEyeProtectUI()
end

function SettingsGraphicsView:onClose()
	return
end

function SettingsGraphicsView:onDestroyView()
	return
end

function SettingsGraphicsView:_setGraphicsQuality(quality)
	local currentQuality = SettingsModel.instance:getModelGraphicsQuality()

	if currentQuality == quality then
		return
	end

	local recommendQuality = SettingsModel.instance:getRecommendQuality()

	if quality < recommendQuality then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function()
			self:directSetGraphicsQuality(quality)
		end)
	else
		self:directSetGraphicsQuality(quality)
	end
end

function SettingsGraphicsView:directSetGraphicsQuality(quality)
	SettingsModel.instance:setGraphicsQuality(quality)
	self:_refreshGraphicsQualityUI()
end

function SettingsGraphicsView:_refreshGraphicsQualityUI()
	local quality = SettingsModel.instance:getModelGraphicsQuality()

	gohelper.setActive(self._golowselected, quality == ModuleEnum.Performance.Low)
	gohelper.setActive(self._gomiddleselected, quality == ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gohighselected, quality == ModuleEnum.Performance.High)
	gohelper.setActive(self._golowon, quality == ModuleEnum.Performance.Low)
	gohelper.setActive(self._golowoff, quality ~= ModuleEnum.Performance.Low)
	gohelper.setActive(self._gomiddleon, quality == ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gomiddleoff, quality ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gohighon, quality == ModuleEnum.Performance.High)
	gohelper.setActive(self._gohighoff, quality ~= ModuleEnum.Performance.High)
	gohelper.setActive(self._goline1, quality == ModuleEnum.Performance.High)
	gohelper.setActive(self._goline2, quality == ModuleEnum.Performance.Low)
end

function SettingsGraphicsView:_refreshIsFullScreenUI()
	gohelper.setActive(self._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(self._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function SettingsGraphicsView:_refreshShotUI()
	local screenshotSwitch = SettingsModel.instance:getScreenshotSwitch()

	gohelper.setActive(self._gooffshot, not screenshotSwitch)
	gohelper.setActive(self._goonshot, screenshotSwitch)
end

function SettingsGraphicsView:_refreshEnergyUI()
	local energyMode = SettingsModel.instance:getEnergyMode()

	gohelper.setActive(self._goenergyon, energyMode == 1)
	gohelper.setActive(self._goenergyoff, energyMode == 0)
end

function SettingsGraphicsView:_refreshVideoUI()
	local compatible = SettingsModel.instance:getVideoCompatible()
	local hdMode = SettingsModel.instance:getVideoHDMode()

	gohelper.setActive(self._govideoon, compatible)
	gohelper.setActive(self._govideooff, not compatible)
	gohelper.setActive(self._goHdModeOn, hdMode)
	gohelper.setActive(self._goHdModeOff, not hdMode)

	local list = {
		luaLang("SettingsGraphicsView_videoMode0"),
		luaLang("SettingsGraphicsView_videoMode1"),
		luaLang("SettingsGraphicsView_videoMode2")
	}
	local index = 0

	if SettingsModel.instance:getUseUnityVideo() then
		index = 2
	elseif SettingsModel.instance:getVideoCompatible() then
		index = 1
	end

	self._videoModeDrop:ClearOptions()
	self._videoModeDrop:AddOptions(list)

	local contentHeight = #list * 73

	recthelper.setHeight(self._videoModeTemplate.transform, contentHeight)
	self._videoModeDrop:SetValue(index)

	self._videoModeDropIndex = self._videoModeDrop:GetValue()

	local list = gohelper.findChild(self._videoModeDrop.gameObject, "Dropdown List")

	if list then
		local content = gohelper.findChild(list, "Viewport/Content")

		if content then
			local item = content.transform:GetChild(self._videoModeDropIndex + 1)

			if item then
				local bg = gohelper.findChild(item.gameObject, "BG")

				if bg then
					gohelper.setActive(bg, true)
				end
			end
		end
	end
end

function SettingsGraphicsView:_refreshVerticalUI()
	local verticalMode = UnityEngine.QualitySettings.vSyncCount == 1

	gohelper.setActive(self._goVerticalmodeOn, verticalMode)
	gohelper.setActive(self._goVerticalmodeOff, not verticalMode)
end

function SettingsGraphicsView:_refreshDropdownList()
	local strList = SettingsModel.instance:getResolutionRatioStrList()

	self._drop:ClearOptions()
	self._drop:AddOptions(strList)
	self._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	self._preSelectedIndex = self._drop:GetValue()
end

function SettingsGraphicsView:_refreshTargetFrameRateUI()
	local frames = SettingsModel.instance.FrameRate
	local list = {}

	for _, v in ipairs(frames) do
		if not BootNativeUtil.isWindows() and v > 60 then
			break
		end

		local str = tostring(v)

		table.insert(list, str)
	end

	self._framerateDrop:ClearOptions()
	self._framerateDrop:AddOptions(list)

	local contentHeight = #list * 73

	recthelper.setHeight(self._frameTemplate.transform, contentHeight)
	self._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() - 1)

	self._framerateDropIndex = self._framerateDrop:GetValue()

	if self._framerateDropIndex == 0 then
		SettingsModel.instance:setModelTargetFrameRate(0)
	end

	local list = gohelper.findChild(self._framerateDrop.gameObject, "Dropdown List")

	if list then
		local content = gohelper.findChild(list, "Viewport/Content")

		if content then
			local item = content.transform:GetChild(self._framerateDropIndex + 1)

			if item then
				local bg = gohelper.findChild(item.gameObject, "BG")

				if bg then
					gohelper.setActive(bg, true)
				end
			end
		end
	end
end

return SettingsGraphicsView
