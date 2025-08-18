-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookHeroInfoPanel.lua

local ATTR_PANEL_PROP_MAP = {
	{
		prop = "atk"
	},
	{
		prop = "mhp"
	},
	{
		prop = "p_def"
	},
	{
		prop = "cri_rate"
	},
	{
		prop = "cri_dmg"
	},
	{
		prop = "assist_enhance"
	},
	{
		prop = "effect_hit"
	}
}
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local PropBoard = require("ClientData/PropBoard")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local strClassName = "HandBookHeroInfoPanel"
local HandBookHeroInfoPanel = Class(strClassName, UIControls.Panel)

function HandBookHeroInfoPanel:ctor()
	self:initUI()
end

function HandBookHeroInfoPanel:initUI()
	self.txtName = UIControls.Label(self, self.mPath .. "/InfoPanel/TextName")
	self.txtGroup = UIControls.Label(self, self.mPath .. "/InfoPanel/IconGroup/Text")
	self.imgGroup = UIControls.Image(self, self.mPath .. "/InfoPanel/IconGroup/Icon")
	self.txtCareer = UIControls.Label(self, self.mPath .. "/InfoPanel/IconCareer/Text")
	self.imgCareerIcon = UIControls.Image(self, self.mPath .. "/InfoPanel/IconCareer/Icon")
	self.txtTeam = UIControls.Label(self, self.mPath .. "/InfoPanel/IconTeam/Text")
	self.panelTeam = UIControls.Panel(self, self.mPath .. "/InfoPanel/IconTeam")
	self.imgTeamIcon = UIControls.Image(self, self.mPath .. "/InfoPanel/IconTeam/Icon")
	self.scrollStoryList = UIControls.ScrollView(self, self.mPath .. "/InfoPanel/TextStoryList")
	self.panelStoryContent = UIControls.Panel(self, self.mPath .. "/InfoPanel/TextStoryList/Content")
	self.txtStory = UIControls.Label(self, self.mPath .. "/InfoPanel/TextStoryList/Content/TextStory")
	self.imgGuide = UIControls.Image(self, self.mPath .. "/InfoPanel/ImageGuide")
	self.btnDetail = UIControls.Button(self, self.mPath .. "/AttrPanel/BtnDetail", "Text")

	self.btnDetail:addEventClick(self.onBtnDetailClick)

	self.attrList = {}
	self.attrMoreList = {}
	self.gridSkillList = {}
	self.panelLessAttr = UIControls.Panel(self, self.mPath .. "/AttrPanel/AttrLessPanel")
	self.panelMoreAttr = UIControls.Panel(self, self.mPath .. "/AttrPanel/AttrMorePanel")
	self.panelSkill = UIControls.Panel(self, self.mPath .. "/SkillPanel")

	for i = 1, 3 do
		local attrPanel = HeroAttrPanel(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.attrList, attrPanel)
	end

	local attrPanel = HeroAttrPanel(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr4")

	attrPanel:setVisible(false)

	for i = 1, 8 do
		local attrPanel = HeroAttrPanel(self, self.mPath .. "/AttrPanel/AttrMorePanel/Attr0" .. i)

		table.insert(self.attrMoreList, attrPanel)
	end

	self.imgStar = UIControls.Image(self, self.mPath .. "/InfoPanel/ImgStar")
end

function HandBookHeroInfoPanel:onBtnDetailClick()
	local txtStr = self.panelSkill:getVisible() and Lang.get(466) or Lang.get(963)

	self.btnDetail:setText(txtStr)
	self.panelSkill:changeVisible()
	self.panelLessAttr:changeVisible()
	self.panelMoreAttr:changeVisible()
end

function HandBookHeroInfoPanel:setHero(hero)
	self.hero = hero

	self:refreshBaseInfo()
	self:refreshStarInfo()
	self:refreshPropPanel()
	self:refreshGridSkill()

	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
end

function HandBookHeroInfoPanel:yieldSetScrollStatus()
	self.scrollStoryList:gotoTop()
	coroutine.step()

	local contentSize = self.scrollStoryList:getContentSize()
	local maxHeight = self.scrollStoryList:getSize().height

	if maxHeight >= contentSize[2] then
		self.scrollStoryList:cancelScroll()
		self.imgGuide:setVisible(false)
	else
		self.imgGuide:setVisible(true)
		self.scrollStoryList:openScroll(true)
	end
end

function HandBookHeroInfoPanel:refreshBaseInfo()
	if Const.REVIEW_VERSION and self.hero.fullName == "S-VIII" then
		self.txtName:setText(Lang.get(111526))
	else
		self.txtName:setText(self.hero.fullName)
	end

	local careerPath = self.hero:getCareerPath()

	self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	self.txtCareer:setText(Const.CAREER_CONFIG[self.hero.career].name)
	self.txtGroup:setText(Const.CAMP_CONFIG[self.hero.resData.camp].name)

	local groupPath = self.hero:getGroupPath()

	self.imgGroup:setImage(groupPath[1], groupPath[2])
	self.txtStory:setText(self.hero.resData.story)

	local groupTeamPath = self.hero:getGroupTeamPath()

	if groupTeamPath then
		self.panelTeam:setVisible(true)
		self.imgTeamIcon:setImage(groupTeamPath[1], groupTeamPath[2])
		self.txtTeam:setText(Const.HERO_TEAM_CONFIG[self.hero.team].name)
	else
		self.panelTeam:setVisible(false)
	end
end

function HandBookHeroInfoPanel:refreshPropPanel()
	local equips = self.hero:getEquips()
	local artifact = self.hero:getArtifact()

	if CurAvatar.heroDic[self.hero.gid] then
		self.container = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, self.hero:getPropLevel(), self.hero.battleStep, self.hero.star, equips, artifact, self.hero, self.hero:getSkinData(), self.hero:getBaseData(), self.hero:getRelic(), self.hero:getPaintData(), self.hero:getRelationPointData())
	else
		self.container = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, self.hero:getPropLevel(), self.hero.battleStep, self.hero.star, equips, artifact, self.hero)
	end

	for i = 1, #ATTR_PANEL_PROP_MAP do
		local attrName = ATTR_PANEL_PROP_MAP[i].prop
		local value = self.container[attrName] or 0
		local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, value, true)
		local attriconInfo = ClientUtils.getRolePropIcon(attrName)

		self.attrMoreList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		self.attrMoreList[i]:setData(zhName, valueStr)

		if self.attrList[i] then
			self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
			self.attrList[i]:setData(zhName, valueStr)

			local rankValue = CurAvatar:getHeroPropValueByStep(attrName, self.hero)
			local attrRank = CurAvatar:getHeroPropRank(attrName, rankValue)
			local rankIconInfo = UIConst.HERO_PROP_RANK_ICON[attrRank]
			local imgRank = UIControls.Image(self.attrList[i], self.attrList[i].mPath .. "/IconScore")

			imgRank:setImage(rankIconInfo[1], rankIconInfo[2])
		end
	end

	for i = #ATTR_PANEL_PROP_MAP + 1, #self.attrMoreList do
		self.attrMoreList[i]:setVisible(false)
	end
end

function HandBookHeroInfoPanel:refreshGridSkill()
	if self.skillTips then
		self.skillTips:setVisible(false)
		self.btnSkillTipsSensor:setVisible(false)

		if self.curSelectSkillGrid then
			self.curSelectSkillGrid.imgSelect:setVisible(false)
			self.curSelectSkillGrid.btnSelf:setEnable(true)

			self.curSelectSkillGrid = nil
		end
	end

	for i = 1, 4 do
		if self.hero[Const.SKILL_FIELD_LIST[i]] then
			if not self.gridSkillList[i] then
				self.gridSkillList[i] = UIControls.HeroSkillGridChild(self, self.mPath .. "/SkillPanel/SkillList", "System/Hero/GridHeroSkill", 0, 0, true)
			end

			self.gridSkillList[i].gridPanel = UIConst.SKILL_PANEL_HANDBOOK

			self.gridSkillList[i]:setObj(self.hero[Const.SKILL_FIELD_LIST[i]], self.hero)
		elseif self.gridSkillList[i] then
			self.gridSkillList[i]:destroy()

			self.gridSkillList[i] = nil
		end
	end
end

function HandBookHeroInfoPanel:refreshStarInfo()
	local largeStarPath = self.hero:getLargeStarPath()

	if largeStarPath then
		self.imgStar:setImage(largeStarPath[1], largeStarPath[2])
	end
end

return HandBookHeroInfoPanel
