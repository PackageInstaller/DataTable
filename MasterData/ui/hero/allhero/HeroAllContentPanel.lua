-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\AllHero\\HeroAllContentPanel.lua

local HeroContentBaseInfoPanel = require("UI/Hero/AllHero/HeroAllContentBaseInfoPanel")
local HeroContentEquipPanel = require("UI/Hero/ContentPanel/HeroContentEquipPanel")
local HeroStageUpPanel = require("UI/Hero/ContentPanel/HeroStageUpPanel")
local HeroStepUpPanel = require("UI/Hero/ContentPanel/HeroStepUpPanel")
local HeroStarUpPanel = require("UI/Hero/ContentPanel/HeroStarUpPanel")
local strClassName = "HeroAllContentPanel"
local HeroAllContentPanel = Class(strClassName, UIControls.Panel)
local HERO_CONTENT_MAP = {
	{
		prefabPath = "System/Hero/HeroContentBaseInfoPanel",
		btnName = "BtnBaseInfo",
		luaTable = HeroContentBaseInfoPanel
	},
	{
		prefabPath = "System/Hero/HeroContentEquipPanel",
		btnName = "BtnEquip",
		luaTable = HeroContentEquipPanel
	},
	{
		prefabPath = "System/Hero/HeroStageUp2Panel",
		btnName = "BtnStageUp",
		luaTable = HeroStepUpPanel
	},
	{
		prefabPath = "System/Hero/HeroStarUpPanel",
		btnName = "BtnStarUp",
		luaTable = HeroStarUpPanel
	},
	{
		prefabPath = "System/Hero/HeroStageUpPanel",
		btnName = "BtnStageUpOld",
		luaTable = HeroStageUpPanel
	}
}

function HeroAllContentPanel:ctor()
	self:initUI()
end

function HeroAllContentPanel:initUI()
	self.btnTypeList = {}
	self.panelList = {}

	for i, v in ipairs(HERO_CONTENT_MAP) do
		local btn = UIControls.Button(self, self.mPath .. "/TabPanel/" .. HERO_CONTENT_MAP[i].btnName)

		btn:addEventClick(self.onBtnTypeClick)
		table.insert(self.btnTypeList, btn)
	end
end

function HeroAllContentPanel:selectTab(idx)
	self:onBtnTypeClick(self.btnTypeList[idx])
end

function HeroAllContentPanel:initSelectTab()
	if not self.curShowTab then
		self:selectTab(1)
	else
		self:selectTab(self.curShowTab)
	end
end

function HeroAllContentPanel:refreshContentPanel(heroGid)
	self.hero = heroGid and CurAvatar.heroDic[heroGid] or self.mWindow.selectedHero

	for k, v in pairs(self.panelList) do
		if self.panelList[k]:getVisible() then
			self.panelList[k]:setHero(self.hero)

			if k == Const.HERO_CONTENT_PANEL.STAGE_UP then
				self.panelList[k]:refreshScrollContentPos()
			end
		end
	end
end

function HeroAllContentPanel:onBtnTypeClick(sender)
	for i, v in ipairs(self.btnTypeList) do
		if v == sender then
			if self.panelList[i] then
				self.panelList[i]:setVisible(true)
			else
				self.panelList[i] = HERO_CONTENT_MAP[i].luaTable(self, self.mPath, HERO_CONTENT_MAP[i].prefabPath, 0, 0, true)
			end

			self.curShowTab = i

			self.panelList[i]:setHero(self.hero or self.mWindow.selectedHero)
			self.mWindow.heroInfoPanel:setVisible(i ~= Const.HERO_CONTENT_PANEL.HERO_EQUIP)

			if i == Const.HERO_CONTENT_PANEL.STAGE_UP then
				self.panelList[i].uiAni:startAni("ShowHeroStageUpWindow")

				self.panelList[i].showSkill = false

				self.panelList[i]:refreshScrollContentPos()
			end
		elseif self.panelList[i] then
			self.panelList[i]:setVisible(false)
		end

		v:setEnable(v ~= sender)
	end
end

return HeroAllContentPanel
