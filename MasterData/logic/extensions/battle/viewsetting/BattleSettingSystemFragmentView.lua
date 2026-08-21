-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingSystemFragmentView.lua

module("logic.extensions.battle.viewsetting.BattleSettingSystemFragmentView", package.seeall)

local M = class("BattleSettingSystemFragmentView", StaticFragmentView)
local BattleAnimaSetting = GameEnum.SystemEnum.BattleAnimaSetting
local kMaxWidth = MainSettingModel.instance:getMaxAdaptationOffsetWidth()
local kResetTime = 0
local kShowWarmingTipsBarIndex = 4
local kShowWarmingTipsFrameIndex = 2
local kSwitchDpiWaitTime = 1

function M:buildUI()
	self._bgmAudioItem = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/element1/bgm"), SoundItem)
	self._soundAudioItem = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/element1/sound"), SoundItem)
	self._dubAudioItem = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/element1/dub"), SoundItem)

	self._bgmAudioItem:setAudioType(CriwareAudioFacade.AudioType.BGM)
	self._soundAudioItem:setAudioType(CriwareAudioFacade.AudioType.SE)
	self._dubAudioItem:setAudioType(CriwareAudioFacade.AudioType.VOICE)

	self._allSoundItems = {
		self._bgmAudioItem,
		self._soundAudioItem,
		self._dubAudioItem
	}

	self._bgmAudioItem:setValueChangeCallback(self.onItemValueChange, self)
	self._soundAudioItem:setValueChangeCallback(self.onItemValueChange, self)
	self._dubAudioItem:setValueChangeCallback(self.onItemValueChange, self)

	self._allSoundItems = {
		self._bgmAudioItem,
		self._soundAudioItem,
		self._dubAudioItem
	}
	self._toggleAllSound = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/allSound/togAllSound", UIComponentType.SpaceXToggle)
	self._toggleGroup = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/definition", UIComponentType.SpaceXToggleGroup)
	self._toggleCompList = {}

	for index = 1, 5 do
		local toggleComp = goutil.findChildComponent(self.mainGO, string.format("scroll/view/content/element2/definition/toggle%s", index), UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)

		if toggleComp then
			local co = ConstConfig.instance:getFrameSettingById(index)

			if co then
				local text1 = goutil.findChildTextComponent(toggleComp.gameObject, "normal/Text")
				local text2 = goutil.findChildTextComponent(toggleComp.gameObject, "select/Text")

				text1.text = co.typeString
				text2.text = co.typeString
			end
		end
	end

	self._dpiToggleGroup = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/dpi", UIComponentType.SpaceXToggleGroup)
	self._dpiToggleCompList = {}

	for index = 1, 4 do
		local toggleComp = goutil.findChildComponent(self.mainGO, string.format("scroll/view/content/element2/dpi/toggle%s", index), UIComponentType.SpaceXToggle)

		table.insert(self._dpiToggleCompList, toggleComp)
	end

	self._effectToggleGroup = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/effect", UIComponentType.SpaceXToggleGroup)
	self._effectToggleCompList = {}

	for index = 1, 4 do
		local toggleComp = goutil.findChildComponent(self.mainGO, string.format("scroll/view/content/element2/effect/toggle%s", index), UIComponentType.SpaceXToggle)

		table.insert(self._effectToggleCompList, toggleComp)
	end

	self._fpsToggleGroup = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/fps", UIComponentType.SpaceXToggleGroup)
	self._fpsToggleCompList = {}

	for index = 1, 2 do
		local toggleComp = goutil.findChildComponent(self.mainGO, string.format("scroll/view/content/element2/fps/toggle%s", index), UIComponentType.SpaceXToggle)

		table.insert(self._fpsToggleCompList, toggleComp)
	end

	self._toggleHdr = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/togHdr/toggle", UIComponentType.SpaceXToggle)
	self._toggleAntialiasing = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/togAliasing/toggle", UIComponentType.SpaceXToggle)
	self._togglePowerSaving = goutil.findChildComponent(self.mainGO, "scroll/view/content/element2/togPowerSaving/togPowerSaving", UIComponentType.SpaceXToggle)
	self._sliderBoarder = UIComponentType.SliderAdapter(goutil.findChild(self.mainGO, "scroll/view/content/element2/border/slider"))
	self._originalOffsetWidth = 0
end

function M:bindEvents()
	self._toggleAllSound:AddListener(self._onToggleAllSound, self)

	for k, v in pairs(self._dpiToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealDpiBarClick(k, isOn)
		end, nil)
	end

	for k, v in pairs(self._toggleCompList) do
		v:AddListener(function(_, isOn)
			self._inSwitching = true

			settimer(kResetTime, self._resetInSwitching, self, false)
			self:_dealBarClick(k, isOn)
			self:_storageSettings()
		end, nil)
	end

	for k, v in pairs(self._effectToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealEffectBarClick(k, isOn)
		end, nil)
	end

	for k, v in pairs(self._fpsToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealFpsBarClick(k, isOn)
		end, nil)
	end

	self._sliderBoarder:AddOnValueChanged(self._onBoarderValueChanged, self)
	self._toggleHdr:AddListener(self._onToggleHDR, self)
	self._toggleAntialiasing:AddListener(self._onToggleAliasing, self)
	self._togglePowerSaving:AddListener(self._onTogglePowerSaving, self)
end

function M:unbindEvents()
	self._toggleAllSound:RemoveListener()

	for k, v in ipairs(self._dpiToggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._toggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._effectToggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._fpsToggleCompList) do
		v:RemoveListener()
	end

	self._toggleHdr:RemoveListener()
	self._toggleAntialiasing:RemoveListener()
	self._togglePowerSaving:RemoveListener()
	self._sliderBoarder:RemoveOnValueChanged()
end

function M:onEnter()
	self._hasInit = false
	self._originalOffsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()

	MainSettingModel.instance:saveAdaptationOffsetWidth(self._originalOffsetWidth)
	self._sliderBoarder:SetValue(1 - self._originalOffsetWidth / kMaxWidth)
	self:syncSetting()

	self._hasInit = true
end

function M:onExit()
	EventSystemUtils.ReloadActiveInputModule()
	removetimer(self.__delayResetBlock, self)
	self:_setPageBlock(false)

	self._isCustom = false
	self._inSwitching = false
	self._hasInit = false

	removetimer(self._resetInSwitching, self)
end

function M:_showWarmingTips()
	if not self._hasInit then
		return
	end

	local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_frame_setting_warming"))

	dialog:setConfirmButtonText(lang("tip_common_sure"))
end

function M:_setPageBlock(isBlock)
	if not self._hasInit then
		return
	end

	ViewBlockMgr.instance:blockClick(isBlock, ViewBlockKey.Anim)
end

function M:onItemValueChange()
	local isSoundOn = false

	for k, v in pairs(self._allSoundItems) do
		isSoundOn = isSoundOn or v:getValue() > 0
	end

	PlayerLocalStorageModel.instance:setSoundMainSwitch(isSoundOn)
	self._toggleAllSound:ForceSetOn(isSoundOn)
end

function M:_onToggleAllSound(index, isOn)
	local isAllZero = true

	for k, v in pairs(self._allSoundItems) do
		if isOn then
			isAllZero = isAllZero and v:getValue() == 0
		else
			v:setValue(0)
		end
	end

	if isOn and isAllZero then
		local bgmVolume = PlayerLocalStorageModel.instance:getBgmVolumeHistory()

		self._allSoundItems[1]:setValue(bgmVolume)

		local soundEffVolume = PlayerLocalStorageModel.instance:getSoundEffVolumeHistory()

		self._allSoundItems[2]:setValue(soundEffVolume)

		local dubVolume = PlayerLocalStorageModel.instance:getDubVolumeHistory()

		self._allSoundItems[3]:setValue(dubVolume)
	end

	PlayerLocalStorageModel.instance:setSoundMainSwitch(isOn)
end

function M:syncSettingStorage()
	if not self._hasInit then
		return
	end

	if self._resolutionRatioQualityIndex ~= PlayerLocalStorageModel.instance:getResolutionRatioQuality() then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kResolutionRatioQuality, self._resolutionRatioQualityIndex)
	end

	if self._effectQualityIndex ~= PlayerLocalStorageModel.instance:getEffectQuality() then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kEffectQuality, self._effectQualityIndex)
	end

	if self._gameFrameIndex ~= PlayerLocalStorageModel.instance:getGameFrame() then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameFrame, self._gameFrameIndex)
	end

	if self._isOpenAntialiasing ~= PlayerLocalStorageModel.instance:getAntialiasingSwitch() then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameAntialiasing, self._isOpenAntialiasing)
	end

	if self._isOpenHdr ~= PlayerLocalStorageModel.instance:getOpenHdr() then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameHDR, self._isOpenHdr)
	end

	local offsetWidth = AdaptationUtils.GetDefaultOffsetSize(0)

	MainSettingModel.instance:saveAdaptationOffsetWidth(offsetWidth)
	PlayerLocalStorageModel.instance:setPowerSavingSwitch(self._isPowerSavingOn)
	PlayerLocalStorageModel.instance:setGraphicsSettingQuality(self._graphicsSettingQualityIndex)
	PlayerLocalStorageModel.instance:setResolutionRatioQuality(self._resolutionRatioQualityIndex)
	PlayerLocalStorageModel.instance:setEffectQuality(self._effectQualityIndex)
	PlayerLocalStorageModel.instance:setGameFrame(self._gameFrameIndex)
	PlayerLocalStorageModel.instance:setAntialiasingSwitch(self._isOpenAntialiasing)
	PlayerLocalStorageModel.instance:setOpenHdr(self._isOpenHdr)

	local frameNum = SettingConst.KFrameNumberValue[self._gameFrameIndex]

	UnityEngine.Application.targetFrameRate = frameNum
end

function M:syncSetting()
	local soundMainSwitch = PlayerLocalStorageModel.instance:getSoundMainSwitch()

	self._toggleAllSound:ForceSetOn(soundMainSwitch)

	local bgmVolume = PlayerLocalStorageModel.instance:getBgmVolume()

	self._bgmAudioItem:setValue(bgmVolume)

	local soundEffVolume = PlayerLocalStorageModel.instance:getSoundEffVolume()

	self._soundAudioItem:setValue(soundEffVolume)

	local dubVolume = PlayerLocalStorageModel.instance:getDubVolume()

	self._dubAudioItem:setValue(dubVolume)

	local graphicsQuality = PlayerLocalStorageModel.instance:getGraphicsSettingQuality()
	local barItem = self._toggleCompList[graphicsQuality]

	self._isCustom = graphicsQuality == 5

	self._toggleGroup:TryActiveChildOn(barItem, true)

	local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()

	self._dpiToggleGroup:TryActiveChildOn(self._dpiToggleCompList[dpiQuality], true)

	local effectQuality = PlayerLocalStorageModel.instance:getEffectQuality()

	self._effectToggleGroup:TryActiveChildOn(self._effectToggleCompList[effectQuality], true)

	local gameFrame = PlayerLocalStorageModel.instance:getGameFrame()

	if gameFrame <= 0 or gameFrame > 2 then
		gameFrame = 1
	end

	self._fpsToggleGroup:TryActiveChildOn(self._fpsToggleCompList[gameFrame], true)
	self._toggleHdr:ForceSetOn(PlayerLocalStorageModel.instance:getOpenHdr())
	self._toggleAntialiasing:ForceSetOn(PlayerLocalStorageModel.instance:getAntialiasingSwitch())
	self._togglePowerSaving:ForceSetOn(PlayerLocalStorageModel.instance:getPowerSavingSwitch())

	self._graphicsSettingQualityIndex = graphicsQuality
	self._resolutionRatioQualityIndex = dpiQuality
	self._effectQualityIndex = effectQuality
	self._gameFrameIndex = gameFrame
	self._isOpenHdr = PlayerLocalStorageModel.instance:getOpenHdr()
	self._isOpenAntialiasing = PlayerLocalStorageModel.instance:getAntialiasingSwitch()
	self._isPowerSavingOn = PlayerLocalStorageModel.instance:getPowerSavingSwitch()
	self._originalOffsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()

	self._sliderBoarder:SetValue(1 - self._originalOffsetWidth / kMaxWidth)

	local frameNum = SettingConst.KFrameNumberValue[self._gameFrameIndex]

	UnityEngine.Application.targetFrameRate = frameNum
end

function M:checkSettingChange()
	local isChange1 = self._isPowerSavingOn ~= PlayerLocalStorageModel.instance:getPowerSavingSwitch()
	local isChange2 = self._graphicsSettingQualityIndex ~= PlayerLocalStorageModel.instance:getGraphicsSettingQuality()
	local isChange3 = self._resolutionRatioQualityIndex ~= PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	local isChange4 = self._effectQualityIndex ~= PlayerLocalStorageModel.instance:getEffectQuality()
	local isChange5 = self._gameFrameIndex ~= PlayerLocalStorageModel.instance:getGameFrame()
	local offsetWidth = AdaptationUtils.GetDefaultOffsetSize(0)
	local newOffsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()
	local isChange6 = math.abs(offsetWidth - newOffsetWidth) > 0.0001
	local isChange7 = self._isOpenAntialiasing ~= PlayerLocalStorageModel.instance:getAntialiasingSwitch()
	local isChange8 = self._isOpenHdr ~= PlayerLocalStorageModel.instance:getOpenHdr()

	return isChange1 or isChange2 or isChange3 or isChange4 or isChange5 or isChange6 or isChange7 or isChange8
end

function M:_onBoarderValueChanged(value)
	local width = kMaxWidth * (1 - value)

	self:_setBoarderOffsetWidth(width)

	if self._tabIndex == kFrameSettingIndex then
		-- block empty
	end

	self:_storageSettings()
end

function M:_storageSettings()
	local isChange = self:checkSettingChange()

	if isChange then
		self:syncSettingStorage()
	end
end

function M:_checkSwitching()
	if not self._hasInit then
		return
	end

	if not self._inSwitching then
		if not self._isCustom then
			self._toggleGroup:TryActiveChildOn(self._toggleCompList[5], true)
		end

		self._inSwitching = true

		settimer(kResetTime, self._resetInSwitching, self, false)
		self:_storageSettings()
	end
end

function M:resetSetting()
	PlayerLocalStorageModel.instance:setGraphicsSettingQuality(4)
	PlayerLocalStorageModel.instance:setResolutionRatioQuality(3)
	PlayerLocalStorageModel.instance:setEffectQuality(3)
	PlayerLocalStorageModel.instance:setGameFrame(2)
	PlayerLocalStorageModel.instance:setPowerSavingSwitch(false)
	self:_setBoarderOffsetWidth(MainSettingModel.instance:getBestOffsetSize())
end

function M:_setBoarderOffsetWidth(width)
	AdaptationUtils.SetDefaultOffsetSize(width)
end

function M:_onToggleHDR(index, isOn)
	self._isOpenHdr = isOn

	self:_checkSwitching()
end

function M:_onToggleAliasing(index, isOn)
	self._isOpenAntialiasing = isOn

	self:_checkSwitching()
end

function M:_onTogglePowerSaving(index, isOn)
	self._isPowerSavingOn = isOn

	self:_storageSettings()

	if isOn then
		local barItem = self._toggleCompList[1]

		self._toggleGroup:TryActiveChildOn(barItem, true)
	end
end

function M:_dealBarClick(index, isOn)
	if isOn then
		local co = ConstConfig.instance:getFrameSettingById(index)

		if co then
			local resolutionRatio, effectLevel, frameNum, openAntialiasing, useHdr = GfxConfig.getGraphicsSettingInfo(index)
			local barItem = self._dpiToggleCompList[resolutionRatio]

			self._dpiToggleGroup:TryActiveChildOn(barItem, true)

			barItem = self._effectToggleCompList[effectLevel]

			self._effectToggleGroup:TryActiveChildOn(barItem, true)

			barItem = self._fpsToggleCompList[frameNum]

			self._fpsToggleGroup:TryActiveChildOn(barItem, true)

			self._toggleHdr.IsOn = useHdr
			self._toggleAntialiasing.IsOn = openAntialiasing
		end

		self._isCustom = index == 5
		self._graphicsSettingQualityIndex = index
		self._togglePowerSaving.IsOn = index == 1
	end
end

function M:_resetInSwitching()
	self._inSwitching = false
end

function M:_dealDpiBarClick(index, isOn)
	if isOn then
		if index == kShowWarmingTipsBarIndex then
			self:_showWarmingTips()
		end

		self._resolutionRatioQualityIndex = index

		self:_checkSwitching()
		self:_setPageBlock(true)
		settimer(kSwitchDpiWaitTime, self._delayResetBlock, self, false)
	end
end

function M:_delayResetBlock()
	self:_setPageBlock(false)
end

function M:_dealEffectBarClick(index, isOn)
	if isOn then
		self._effectQualityIndex = index

		self:_checkSwitching()
	end
end

function M:_dealFpsBarClick(index, isOn)
	if isOn then
		if index == kShowWarmingTipsFrameIndex then
			self:_showWarmingTips()
		end

		self._gameFrameIndex = index

		self:_checkSwitching()
	end
end

return M
