-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\RelicTipsInfoPanel.lua

local HeroSkill = require("Common/Object/HeroSkill")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local strClassName = "RelicTipsInfoPanel"
local RelicTipsInfoPanel = Class(strClassName, UIControls.Panel)

function RelicTipsInfoPanel:ctor()
	self:initUI()
end

function RelicTipsInfoPanel:initUI()
	self.basePath = ""

	if self.mPath and self.mPath ~= "" then
		self.basePath = self.mPath .. "/"
	end

	self.panelSkillRelic = UIControls.Panel(self, self.basePath .. "QualityYellowPanel")

	if UIControls.checkControlFunc(self, self.basePath .. "QualityYellowPanel/TextDes") then
		self.txtSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityYellowPanel/TextDes")
	elseif UIControls.checkControlFunc(self, self.basePath .. "QualityYellowPanel/Content/TextDes") then
		self.txtSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityYellowPanel/Content/TextDes")
	elseif UIControls.checkControlFunc(self, self.basePath .. "QualityYellowPanel/TextRuleList/Content/TextDes") then
		self.txtSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityYellowPanel/TextRuleList/Content/TextDes")
	else
		self.txtSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityYellowPanel/Viewport/TextDes")
	end

	self.panelNoSkillRelic = UIControls.Panel(self, self.basePath .. "QualityPurplePanel")

	if UIControls.checkControlFunc(self, self.basePath .. "QualityPurplePanel/TextDes") then
		self.txtNoSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityPurplePanel/TextDes")
	elseif UIControls.checkControlFunc(self, self.basePath .. "QualityPurplePanel/Content/TextDes") then
		self.txtNoSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityPurplePanel/Content/TextDes")
	else
		self.txtNoSkillRelicDes = UIControls.Label(self, self.basePath .. "QualityPurplePanel/Viewport/TextDes")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "AttrLessPanel") then
		self.attrList = {}

		for i = 1, 3 do
			local attrPanel = HeroAttrPanel(self, self.basePath .. "AttrLessPanel/Attr0" .. i)

			self.attrList[i] = attrPanel
		end
	end
end

function RelicTipsInfoPanel:setRelic(relic, hero)
	self.relic = relic
	self.hero = hero

	if self.attrList then
		local props = self.relic:getRelicAttrList()

		for i, info in pairs(props) do
			local propName = info.propName
			local value = info.value

			if propName and value then
				self.attrList[i]:setVisible(true)
				self.attrList[i]:setPropInfo(propName, value)
			end
		end

		for i = #props + 1, 3 do
			self.attrList[i]:setVisible(false)
		end
	end

	self.panelSkillRelic:setVisible(self.relic.heroIdLimit ~= nil)
	self.panelNoSkillRelic:setVisible(self.relic.heroIdLimit == nil)

	if self.relic.heroIdLimit and self.relic.enhanceSkillField then
		if not self.hero then
			self.hero = BaseObject.GetObject(self.relic.heroIdLimit)
			self.enhanceSkill = self.hero[self.relic.enhanceSkillField]
			self.enhanceSkill.level = 1
		else
			self.enhanceSkill = self.hero[self.relic.enhanceSkillField]
		end

		if not self.gridSkill then
			self.gridSkill = UIControls.HeroSkillGridChild(self, self.basePath .. "QualityYellowPanel/GridHeroSkillPanel", "System/Hero/GridHeroSkill", 0, 0, true)
		end

		self.gridSkill.mEnableTips = false

		self.gridSkill:setObj(self.enhanceSkill, self.hero)
		self.gridSkill.txtLv:setVisible(hero ~= nil and self.enhanceSkill.level > 0)
	end

	local passiveResData = self.relic:getPassiveResData()

	if passiveResData then
		self.txtSkillRelicDes:setText(passiveResData.desc)
		self.txtNoSkillRelicDes:setText(passiveResData.desc)
	end
end

return RelicTipsInfoPanel
