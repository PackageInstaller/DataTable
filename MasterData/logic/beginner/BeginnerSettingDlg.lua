-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\BeginnerSettingDlg.lua

local SDKConst = require("SDK/SDKConst")
local GameSettings = require("Helper/GameSettings")
local UIControls = UIControls
local BeginnerCVToggle = Class("BeginnerCVToggle", UIControls.Child)

function BeginnerCVToggle:ctor()
	self.btnChoose = UIControls.Button(self, "")

	self.btnChoose:addEventClick(self.onChooseClick)

	self.imgBg = UIControls.RawImage(self, "BgNml")
	self.imgSelect = UIControls.Panel(self, "BgNml/ImgSel")
	self.txtLanguageName = UIControls.Label(self, "BgNml/Text")
end

function BeginnerCVToggle:setData(cvType)
	self.cvType = cvType
end

function BeginnerCVToggle:setSelected(isSelected)
	local selStr = "Del"

	if isSelected then
		selStr = "Nml"

		self.imgSelect:setVisible(true)
	else
		self.imgSelect:setVisible(false)
	end

	local languageStr = Const.CV_BTN_NAME[self.cvType][2]
	local languageCNStr = Const.CV_BTN_NAME[self.cvType][1]

	self.imgBg:setImage("NoAlpha/PlayerGuide/TxtBgImg" .. languageStr .. selStr)
	self.btnChoose:setEnable(not isSelected)
	self.txtLanguageName:setText(languageCNStr)

	local color = isSelected and ResColor.WHITE or ResColor.GREYLIGHT

	self.txtLanguageName:setFontColor(color)
end

function BeginnerCVToggle:onChooseClick()
	self.mParent:onChooseCV(self)
end

local QUALITY_CONFIG = {
	[Const.GAME_QUALITY.Low] = {
		Lang.get(29956),
		Lang.get(1650)
	},
	[Const.GAME_QUALITY.Fast] = {
		Lang.get(29956),
		Lang.get(1651)
	},
	[Const.GAME_QUALITY.Mid] = {
		Lang.get(29957),
		Lang.get(1541)
	},
	[Const.GAME_QUALITY.High] = {
		Lang.get(1536),
		Lang.get(1538)
	}
}
local CHOOSE_DESC = Lang.get(45485)
local QUALITY_RECOMMEND_CONFIG = {
	[Const.GAME_QUALITY.High] = {
		Const.GAME_QUALITY.Mid,
		Const.GAME_QUALITY.High
	},
	[Const.GAME_QUALITY.Mid] = {
		Const.GAME_QUALITY.Mid,
		Const.GAME_QUALITY.High
	},
	[Const.GAME_QUALITY.Fast] = {
		Const.GAME_QUALITY.Fast,
		Const.GAME_QUALITY.Mid
	},
	[Const.GAME_QUALITY.Low] = {
		Const.GAME_QUALITY.Low,
		Const.GAME_QUALITY.Mid
	}
}
local BeginnerRecommendBtn = Class("BeginnerRecommendBtn", UIControls.Button)

function BeginnerRecommendBtn:ctor()
	self.textQuality = UIControls.Label(self, self.mPath .. "/TextQuality")
	self.panelRecommend = UIControls.Image(self, self.mPath .. "/IconRecommend")
end

function BeginnerRecommendBtn:setData(quality, isRecommend)
	self.quality = quality

	local qualityConfig = QUALITY_CONFIG[quality] or QUALITY_CONFIG[Const.GAME_QUALITY.Low]

	self.textQuality:setText(qualityConfig[2])
	self.panelRecommend:setVisible(isRecommend)
end

local strClassName = "BeginnerSettingDlg"
local BeginnerSettingDlg = Class(strClassName, UIControls.Window)

function BeginnerSettingDlg:ctor()
	self:initUI()
	SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.BEGION_DLG)
end

function BeginnerSettingDlg:initUI()
	self.textRecommendDesc = UIControls.Label(self, "MainInfoPanel/TextChoose")
	self.btnQualityLeft = BeginnerRecommendBtn(self, "MainInfoPanel/QualityChoosePanel/BtnLowQuality")

	self.btnQualityLeft:addEventClick(self.onQualityClick)

	self.btnQualityRight = BeginnerRecommendBtn(self, "MainInfoPanel/QualityChoosePanel/BtnHighQuality")

	self.btnQualityRight:addEventClick(self.onQualityClick)

	self.cvPanel = UIControls.Panel(self, "MainInfoPanel/CVChoosePanel")
	self.cvToggles = {}

	if #Const.CV_LIST < 2 then
		self.cvPanel:setVisible(false)
	else
		self.cvPanel:setVisible(true)
	end

	for i, cvTypeId in ipairs(Const.CV_LIST) do
		local toggle = BeginnerCVToggle(self, "MainInfoPanel/CVChoosePanel/CVPanel", "System/PlayerGuide/BtnCVCellBig")

		toggle:setVisible(true)
		toggle:setData(cvTypeId)

		self.cvToggles[cvTypeId] = toggle
	end

	self.btnNext = UIControls.Button(self, "MainInfoPanel/BtnNext")

	self.btnNext:addEventClick(self.onNextClick)
	self:_initConfig()
end

function BeginnerSettingDlg:_initConfig()
	local quality = GameSettings.gameQualityProposed
	local qualityRecommend = QUALITY_RECOMMEND_CONFIG[quality] or QUALITY_RECOMMEND_CONFIG[Const.GAME_QUALITY.Low]

	self.btnQualityLeft:setData(qualityRecommend[1], qualityRecommend[1] == quality)
	self.btnQualityRight:setData(qualityRecommend[2], qualityRecommend[2] == quality)

	if qualityRecommend[2] == quality then
		self:onQualityClick(self.btnQualityRight)
	else
		self:onQualityClick(self.btnQualityLeft)
	end

	local recommend = QUALITY_CONFIG[quality] or QUALITY_CONFIG[Const.GAME_QUALITY.Low]

	self.textRecommendDesc:setText(utils.format(CHOOSE_DESC, recommend[1], recommend[2]))

	local defaultCVTypeId = Const.CV_LIST[1]

	self:onChooseCV(self.cvToggles[defaultCVTypeId])
end

function BeginnerSettingDlg:onQualityClick(sender)
	self.chooseQuality = sender.quality

	self.btnQualityLeft:setEnable(self.btnQualityLeft ~= sender)
	self.btnQualityRight:setEnable(self.btnQualityRight ~= sender)
end

function BeginnerSettingDlg:onChooseCV(sender)
	for _, toggle in pairs(self.cvToggles) do
		toggle:setSelected(sender == toggle)
	end

	self.chooseCV = sender.cvType
end

function BeginnerSettingDlg:onNextClick()
	GameSettings.setGameQuality(self.chooseQuality)
	GameSettings.setVocalLanguage(Const.CV_TYPE_STRING[self.chooseCV])
	GameSettings.savePreferences()
	self:setVisible(false)
end

return BeginnerSettingDlg
