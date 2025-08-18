-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\HeroSkillTips.lua

local ResHeroRecharge = require("ClientData/ResHeroRecharge")
local ResColor = require("ClientData/ResColor")
local ResStepDes = require("ClientData/ResStepDes")
local ResStep = require("ClientData/ResStep")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local RectTransformType = typeof(UnityEngine.RectTransform)
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResSkillExtraDesc = require("ClientData/ResSkillExtraDesc")
local strClassName = "HeroSkillTips"
local HeroSkillTips = Class(strClassName, UIControls.Child)

function HeroSkillTips:ctor()
	self:initUI()
end

function HeroSkillTips:initUI()
	self.txtSkillName = UIControls.Label(self, "ScrollView/Content/TextTitle")
	self.txtSkillDes = UIControls.Label(self, "ScrollView/Content/TextDes")
	self.txtSkillPropName = UIControls.Label(self, "ScrollView/Content/TextNum/TextTitle")
	self.txtSkillPropValue = UIControls.Label(self, "ScrollView/Content/TextNum")
	self.txtSkillPropValue2 = UIControls.Label(self, "ScrollView/Content/TextNum2")
	self.imgPassive = UIControls.Image(self, "ScrollView/Content/TextNum/TextTitle/Image")
	self.txtCondition = UIControls.Label(self, "ScrollView/Content/TextCondition")
	self.txtLvUpCondition = UIControls.Label(self, "ScrollView/Content/TextLvUpTitle/TextLvUpCondition")
	self.txtLvUpTitle = UIControls.Panel(self, "ScrollView/Content/TextLvUpTitle")
	self.imgBg = UIControls.Image(self, "ScrollView/Content/Bg")
	self.imgLine = UIControls.Image(self, "ScrollView/Content/ImgLine")
	self.panelEmpty = UIControls.Panel(self, "ScrollView/Content/EmptyPanel")
	self.lvUpAttrList = {}

	for i = 2, 3 do
		local lvUpPanel = UIControls.Panel(self, "ScrollView/Content/LvUpAttr" .. i)
		local txtlvUpAttr = UIControls.Label(self, "ScrollView/Content/LvUpAttr" .. i .. "/TextAttr")
		local txtlv = UIControls.Label(self, "ScrollView/Content/LvUpAttr" .. i .. "/TextLv")

		self.lvUpAttrList[i] = {
			panel = lvUpPanel,
			text = txtlvUpAttr,
			textLv = txtlv
		}
	end

	self.panelSpecDesc = UIControls.Panel(self, "ScrollView/Content/SpeAttrPanel")
	self.panelSpecDesc1 = UIControls.Panel(self, "ScrollView/Content/SpeAttrPanel/SpeAttr1")
	self.titleSpecDesc1 = UIControls.Label(self, "ScrollView/Content/SpeAttrPanel/SpeAttr1/BgTitle/TextTitle")
	self.descSpecDesc1 = UIControls.Label(self, "ScrollView/Content/SpeAttrPanel/SpeAttr1/TextAttr")
	self.panelSpecDesc2 = UIControls.Panel(self, "ScrollView/Content/SpeAttrPanel/SpeAttr2")
	self.titleSpecDesc2 = UIControls.Label(self, "ScrollView/Content/SpeAttrPanel/SpeAttr2/BgTitle/TextTitle")
	self.descSpecDesc2 = UIControls.Label(self, "ScrollView/Content/SpeAttrPanel/SpeAttr2/TextAttr")
	self.panelRelic = UIControls.Panel(self, "ScrollView/Content/RelicPanel")
	self.txtRelicName = UIControls.Label(self, "ScrollView/Content/RelicPanel/TextTitle")
	self.txtRelicDes = UIControls.Label(self, "ScrollView/Content/RelicPanel/Text")
	self.selfPanel = UIControls.Panel(self, "")
	self.scrollSkillList = UIControls.ScrollView(self, "ScrollView")
end

function HeroSkillTips:hideLevelUpPanel()
	self.txtLvUpTitle:setVisible(false)

	for i = 2, 3 do
		self.lvUpAttrList[i].panel:setVisible(false)
	end

	self.txtCondition:setVisible(self.skill.level == 0)
	self.txtSkillDes:setText(self.skill.desc)
end

function HeroSkillTips:setSkill(grid)
	self.srcGrid = grid
	self.skill = grid.object
	self.hero = grid.hero

	self.txtSkillName:setText(self.skill.name)

	if self.isInHeroTips then
		self.imgBg:setVisible(false)
		self.panelEmpty:setVisible(false)
		self.imgLine:setVisible(true)
	else
		self.imgBg:setVisible(true)
		self.panelEmpty:setVisible(true)
		self.imgLine:setVisible(false)
	end

	if self.skill.isPassive then
		self.txtSkillDes:setText(ResPassiveSkill[self.skill.id][1].desc)
	else
		self.txtSkillDes:setText(ResSkillConfig[self.skill.id][1].skill_desc)
	end

	self.imgPassive:setVisible(self.skill.style == Const.HERO_SKILL_STYLE.PASSIVE)

	if self.skill.style == Const.HERO_SKILL_STYLE.ATTACK then
		self.txtSkillPropValue:setVisible(true)
		self.txtSkillPropName:setText(Lang.get(30241))
		self.txtSkillPropValue:setText(string.format(Lang.get(30237), self.hero.resData.attack_range or 1))
	elseif self.skill.style == Const.HERO_SKILL_STYLE.SKILL then
		self.txtSkillPropValue:setVisible(true)
		self.txtSkillPropName:setText(Lang.get(985))
		self.txtSkillPropValue:setText(self.hero:getInitMana() or 0)
		self.txtSkillPropValue2:setText(string.format(Lang.get(30238), self.hero.resData.mana_gen or 0))
	else
		self.txtSkillPropValue:setVisible(false)
	end

	self.txtSkillPropValue2:setVisible(self.skill.style == Const.HERO_SKILL_STYLE.SKILL)

	if not self.skillGrid then
		self.skillGrid = UIControls.HeroSkillGridChild(self, "ScrollView/Content/GridPanel", "System/Hero/GridHeroSkill", 0, 0, true)
	end

	self.skillGrid:setObj(self.skill)

	self.skillGrid.mEnableTips = false
	self.skillMaxLv = utils.getHeroMaxSkillLevel(self.hero, self.skill.skillField)

	self.txtLvUpTitle:setVisible(self.skillMaxLv > 1)

	for level = 2, 3 do
		self.lvUpAttrList[level].panel:setVisible(level <= self.skillMaxLv)

		if level <= self.skillMaxLv then
			local upDesc = ""

			if self.skill.isPassive then
				upDesc = ResPassiveSkill[self.skill.id][level].battle_desc
			else
				upDesc = ResSkillConfig[self.skill.id][level].battle_desc
			end

			self.lvUpAttrList[level].text:setText(upDesc)

			local textColor = level > self.skill.level and ResColor.GREYLIGHT or ResColor.ORANGEBTN

			self.lvUpAttrList[level].text:setFontColor(textColor)
			self.lvUpAttrList[level].textLv:setFontColor(textColor)
		end
	end

	if self.skill.level == 0 then
		self.txtCondition:setVisible(true)

		local unlockRecharge = 0

		for recharge, info in ipairs(ResHeroRecharge) do
			if self.skill.skillField == Const.HERO_SKILL_FIELD.ENTER_PASSIVE and info.assist_level == 1 then
				unlockRecharge = recharge

				break
			elseif self.skill.skillField == Const.HERO_SKILL_FIELD.HERO_PASSIVE and info.passive_level == 1 then
				unlockRecharge = recharge

				break
			end
		end

		self.txtCondition:setText(utils.format(Lang.get(30239), ResStep[unlockRecharge].level_limit, ResStepDes[self.hero.id][unlockRecharge].step_name))
		self.txtLvUpCondition:setVisible(false)
	else
		self.txtLvUpCondition:setVisible(true)

		if self.skillMaxLv == self.skill.level then
			self.txtLvUpCondition:setVisible(false)
		else
			local levelField = Const.HERO_SKILL_LEVEL_FIELD_DIC[self.skill.skillField]
			local unlockRecharge = 0

			for recharge, info in ipairs(ResHeroRecharge) do
				if info[levelField] == self.skill.level + 1 then
					unlockRecharge = recharge

					break
				end
			end

			if unlockRecharge > 0 then
				self.txtLvUpCondition:setText(utils.format(Lang.get(30240), ResStep[unlockRecharge].level_limit, ResStepDes[self.hero.id][unlockRecharge].step_name))
			end
		end

		if self.skillMaxLv == 1 and self.skill.level ~= 1 then
			self.txtCondition:setVisible(true)
			self.txtCondition:setText(Lang.get(467))
		else
			self.txtCondition:setVisible(false)
		end
	end

	local isSupport = self.hero.career == Const.CAREER_TYPE.SUPPORT

	if isSupport and self.skill.skillField == Const.HERO_SKILL_FIELD.HERO_PASSIVE then
		self.txtSkillPropValue:setVisible(true)
		self.txtSkillPropValue:setText("")
		self.txtSkillPropName:setText(Lang.get(4493))
		self.txtSkillPropValue:setVisible(true)

		local careerPath = self.hero:getCareerPath()

		if careerPath then
			self.imgPassive:setImage(careerPath[1], careerPath[2])
		end
	end

	local bgInfo = self.skill:getTipsBgInfo()

	if bgInfo then
		self.imgBg:setImage(bgInfo[1], bgInfo[2])
	end

	local titleColor = self.skill.level == 0 and ResColor.GREYLIGHT or ResColor.WHITE

	self.txtSkillName:setFontColor(titleColor)

	local propColor = self.skill.level == 0 and ResColor.GREYLIGHT or ResColor.QUALITYORANGE

	self.txtSkillPropName:setFontColor(propColor)

	if self.skill.extraDesc and not self.isInHeroTips then
		self.panelSpecDesc:setVisible(true)

		local extra1 = self.skill.extraDesc[1]

		if extra1 and ResSkillExtraDesc[extra1] then
			self.panelSpecDesc1:setVisible(true)
			self.titleSpecDesc1:setText(ResSkillExtraDesc[extra1].title or "")
			self.descSpecDesc1:setText(ResSkillExtraDesc[extra1].desc or "")
		else
			self.panelSpecDesc1:setVisible(false)
		end

		local extra2 = self.skill.extraDesc[2]

		if extra2 and ResSkillExtraDesc[extra2] then
			self.panelSpecDesc2:setVisible(true)
			self.titleSpecDesc2:setText(ResSkillExtraDesc[extra2].title or "")
			self.descSpecDesc2:setText(ResSkillExtraDesc[extra2].desc or "")
		else
			self.panelSpecDesc2:setVisible(false)
		end
	else
		self.panelSpecDesc:setVisible(false)
	end

	local relic = self.hero and self.hero:getRelic()
	local passiveResData = relic and relic:getPassiveResData()

	if self.hero and relic and relic.enhanceSkillField and relic.enhanceSkillField == self.skill.skillField and passiveResData then
		self.panelRelic:setVisible(true)
		self.txtRelicName:setText(relic.name)
		self.txtRelicDes:setText(passiveResData.desc)
	else
		self.panelRelic:setVisible(false)
	end

	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
end

function HeroSkillTips:yieldSetScrollStatus()
	if self.srcGrid and self.srcGrid.gridPanel and UIConst.SKILL_TIPS_INFO[self.srcGrid.gridPanel].pivot then
		local rect = self.selfPanel:getController():GetComponent(RectTransformType)
		local pivotValue = UIConst.SKILL_TIPS_INFO[self.srcGrid.gridPanel].pivot

		rect.pivot = Vector2(pivotValue[1], pivotValue[2])
	end

	coroutine.step()

	local contentSize = self.scrollSkillList:getContentSize()
	local maxHeight = 700

	if self.srcGrid and self.srcGrid.gridPanel and UIConst.SKILL_TIPS_INFO[self.srcGrid.gridPanel].maxHeight then
		maxHeight = UIConst.SKILL_TIPS_INFO[self.srcGrid.gridPanel].maxHeight
	end

	if maxHeight >= contentSize[2] then
		self.scrollSkillList:cancelScroll()
	else
		self.scrollSkillList:openScroll(true)
	end

	self.selfPanel:setRectSize(self.selfPanel:getRectSize().width, math.min(contentSize[2], maxHeight))
end

function HeroSkillTips:setVisible(v)
	if not v then
		if self.setScrollStatus then
			coroutine.stop(self.setScrollStatus)
		end

		self.scrollSkillList:setContentY(0)
	end

	HeroSkillTips.super.setVisible(self, v)
end

function HeroSkillTips:setSkillBySkill(skill, hero)
	local fakeGrid = {}

	fakeGrid.object = skill
	fakeGrid.hero = hero

	self:setSkill(fakeGrid)
end

return HeroSkillTips
