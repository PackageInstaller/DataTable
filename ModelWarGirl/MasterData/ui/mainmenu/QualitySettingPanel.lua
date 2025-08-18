-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\QualitySettingPanel.lua

local GameSettings = require("Helper/GameSettings")
local DeviceHelper = require("Helper/DeviceHelper")
local SettingConfig = require("DesignerScript/SettingConfig")
local QualitySettingCellList = require("UI/MainMenu/QualitySettingCellList")
local QualitySettingCellToggle = require("UI/MainMenu/QualitySettingCellToggle")
local strClassName = "QualitySettingPanel"
local QualitySettingPanel = Class(strClassName, UIControls.Panel)

function QualitySettingPanel:ctor(...)
	self:initUI()
end

function QualitySettingPanel:initUI(...)
	self.qualityToggles = {}
	self.proposeImgs = {}

	for i = 1, 5 do
		local toggle = UIControls.Toggle(self, self.mPath .. "/Option" .. i, "Text")

		if i == 5 then
			toggle.level = Const.GAME_QUALITY.Custom
		else
			toggle.level = i - 1
		end

		toggle:addEventValueChanged(self._onQualityToggle)
		table.insert(self.qualityToggles, toggle)

		local propose = UIControls.Image(self, self.mPath .. "/Option" .. i .. "/Text/ImgRecom")

		self.proposeImgs[i] = propose
	end

	self.qualityDesTxt = UIControls.Label(self, self.mPath .. "/TxtExplan")

	self:_initDetailCells()
end

QualitySettingPanel.TOGGLE_SETTINGS = {
	{
		Lang.get(30442),
		"onToggleCellChanged",
		"HighFramerate"
	}
}
QualitySettingPanel.LIST_SETTINGS = {
	{
		Lang.get(632),
		"onListCellChanged",
		3,
		{
			Lang.get(1793),
			"2x",
			"4x"
		},
		"MSAAEnable"
	},
	{
		Lang.get(30443),
		"onListCellChanged",
		4,
		{
			Lang.get(633),
			Lang.get(1476),
			Lang.get(1541),
			Lang.get(30444)
		},
		"ResolutionLv"
	}
}

function QualitySettingPanel:_initDetailCells()
	self.togglePath = self.mPath .. "/BgImg/SwitchPanel"
	self.listPath = self.mPath .. "/BgImg/BtnCellPanel"
	self.toggleCellList = {}
	self.listCellList = {}

	for _, settingInfo in ipairs(QualitySettingPanel.TOGGLE_SETTINGS) do
		local cell = QualitySettingCellToggle(self, self.togglePath, "System/BtnQualityCell")

		cell:setVisible(true)
		cell:setToggleSetting(settingInfo[1], Functor(self[settingInfo[2]], self, settingInfo[3]))
		table.insert(self.toggleCellList, cell)
	end

	for _, settingInfo in ipairs(QualitySettingPanel.LIST_SETTINGS) do
		local cell = QualitySettingCellList(self, self.listPath, "System/BtnQualityListCell")

		cell:setVisible(true)
		cell:setListSetting(settingInfo[1], Functor(self[settingInfo[2]], self, settingInfo[5]), settingInfo[3], settingInfo[4])
		table.insert(self.listCellList, cell)
	end
end

function QualitySettingPanel:loadSettings()
	self.curQualityLevel = GameSettings.getCurGameQuality()
	self.proposedQuality = GameSettings.gameQualityProposed
	self.customQuality = GameSettings.customQuality

	for i, settingInfo in ipairs(QualitySettingPanel.TOGGLE_SETTINGS) do
		self:initToggleCell(settingInfo[3], self.toggleCellList[i])
	end

	for i, settingInfo in ipairs(QualitySettingPanel.LIST_SETTINGS) do
		self:initListCell(settingInfo[5], self.listCellList[i])
	end

	self:_refreshQualityToggles()
end

function QualitySettingPanel:_refreshQualityToggles()
	for i = 1, 5 do
		local toggle = self.qualityToggles[i]

		if i == 5 then
			toggle:setOn(self.customQuality)
			toggle:setEnable(not self.customQuality)
		else
			toggle:setOn(not self.customQuality and self.curQualityLevel == toggle.level)
			toggle:setEnable(self.customQuality or self.curQualityLevel ~= toggle.level)
		end
	end

	if not self.proposedInited then
		for i = 1, 4 do
			self.proposeImgs[i]:setVisible(self.proposedQuality == i - 1)
		end

		self.proposedInited = true
	end
end

function QualitySettingPanel:_onQualityToggle(sender, isOn)
	if isOn then
		local selectLv = sender.level

		if not self.customQuality and self.curQualityLevel == selectLv then
			return
		end

		if selectLv == Const.GAME_QUALITY.Custom then
			self:_switchCustomQuality(true)
			self:_refreshQualityToggles()
		elseif selectLv > self.proposedQuality then
			local confirmMsg = SettingConfig.CHANGE_HIGH_QUALITY_CONFRIM

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), confirmMsg, Functor(self._realSetQualityToggle, self, selectLv), nil, -1, Lang.get(8), Lang.get(7))
			self:_refreshQualityToggles()
		else
			self:_realSetQualityToggle(selectLv)
		end
	end
end

function QualitySettingPanel:_realSetQualityToggle(selectLv)
	self.curQualityLevel = selectLv

	self:_switchCustomQuality(false)
	self:_refreshQualityToggles()
	GameSettings.setGameQuality(self.curQualityLevel)
end

function QualitySettingPanel:_switchCustomQuality(isCustom)
	self.customQuality = isCustom
	GameSettings.customQuality = isCustom

	if not isCustom then
		for i, settingInfo in ipairs(QualitySettingPanel.TOGGLE_SETTINGS) do
			self:initToggleCell(settingInfo[3], self.toggleCellList[i], true)
		end

		for i, settingInfo in ipairs(QualitySettingPanel.LIST_SETTINGS) do
			self:initListCell(settingInfo[5], self.listCellList[i], true)
		end
	end
end

function QualitySettingPanel:onToggleCellChanged(settingName, isOn)
	self:_switchCustomQuality(true)
	self:_refreshQualityToggles()
	GameSettings.setCustomSetting(settingName, isOn)
end

function QualitySettingPanel:onListCellChanged(settingName, lv)
	self:_switchCustomQuality(true)
	self:_refreshQualityToggles()
	GameSettings.setCustomSetting(settingName, lv)
end

function QualitySettingPanel:initToggleCell(settingName, cell, useQualityDefault)
	if cell then
		local value

		if useQualityDefault then
			value = GameSettings.getCustomSettingDefault(settingName, self.curQualityLevel)
		else
			value = GameSettings.getCustomSetting(settingName)
		end

		cell:setToggle(value)
	end
end

function QualitySettingPanel:initListCell(settingName, cell, useQualityDefault)
	if cell then
		local value

		if useQualityDefault then
			value = GameSettings.getCustomSettingDefault(settingName, self.curQualityLevel)
		else
			value = GameSettings.getCustomSetting(settingName)
		end

		cell:selectList(value)
	end
end

return QualitySettingPanel
