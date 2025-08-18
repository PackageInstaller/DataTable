-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\AllHero\\HeroAllContentBaseInfoPanel.lua

local HERO_COMMON_ATLAS = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local ATTR_PANEL_PROP_MAP = {
	{
		sprite = "",
		prop = "atk"
	},
	{
		sprite = "",
		prop = "mhp"
	},
	{
		sprite = "",
		prop = "p_def"
	},
	{
		sprite = "",
		prop = "m_def"
	}
}
local LACK_GOLD = 1
local LACK_MATERIAL = 2
local LACK_STAR_LV = 3
local LACK_PLAYER_LV = 4
local LACK_STEP_LV = 5
local LACK_TOTAL_LV = 6
local CANT_UPGRADE_REASON_NOTICE = {
	[LACK_GOLD] = Lang.get(30363),
	[LACK_MATERIAL] = Lang.get(200),
	[LACK_STAR_LV] = Lang.get(30364),
	[LACK_STEP_LV] = Lang.get(30365),
	[LACK_PLAYER_LV] = Lang.get(30366),
	[LACK_TOTAL_LV] = Lang.get(30367)
}
local HERO_ATLAS = "Atlas/HeroAtlas/HeroAtlas"
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local ResLevelCost = require("ClientData/ResLevelCost")
local ResColor = require("ClientData/ResColor")
local ResStar = require("ClientData/ResStar")
local strClassName = "HeroAllContentBaseInfoPanel"
local ResStep = require("ClientData/ResStep")
local ResHeroStepProp = require("ClientData/ResHeroStepProp")
local PropBoard = require("ClientData/PropBoard")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local HeroAllContentBaseInfoPanel = Class(strClassName, UIControls.Child)

function HeroAllContentBaseInfoPanel:ctor()
	self:initUI()
end

function HeroAllContentBaseInfoPanel:initUI()
	self.txtPower = UIControls.Label(self, "InfoPanel/ImgPower/TextPower")
	self.imgCareerIcon = UIControls.Image(self, "InfoPanel/IconCareer")
	self.txtCareer = UIControls.Label(self, "InfoPanel/IconCareer/Text")
	self.txtHeroLv = UIControls.Label(self, "InfoPanel/TextLv")
	self.txtHeroMaxLv = UIControls.Label(self, "InfoPanel/TextLv/TextLvMax")
	self.bgStage = UIControls.Image(self, "InfoPanel/TextName/BgStageLv")
	self.txtStage = UIControls.Label(self, "InfoPanel/TextName/BgStageLv/Text")
	self.txtName = UIControls.Label(self, "InfoPanel/TextName")
	self.txtGroup = UIControls.Label(self, "InfoPanel/IconGroup/Text")
	self.imgGroup = UIControls.Image(self, "InfoPanel/IconGroup")
	self.txtPowerNum = UIControls.Label(self, "InfoPanel/ImgPower/TextPower")
	self.imgIconHead = UIControls.Image(self, "InfoPanel/BgHead/IconHead")
	self.imgIconHeadBg = UIControls.Image(self, "InfoPanel/BgHead/Bg")
	self.btnUpgrade = UIControls.Button(self, "InfoPanel/BtnUpgrade")

	self.btnUpgrade:setVisible(false)

	self.imgGoldIcon = UIControls.Image(self, "InfoPanel/UpgradeMaterial1")
	self.txtNeedGold = UIControls.Label(self, "InfoPanel/UpgradeMaterial1/TextNum")
	self.imgMaterialIcon = UIControls.Image(self, "InfoPanel/UpgradeMaterial2")
	self.txtNeedMaterial = UIControls.Label(self, "InfoPanel/UpgradeMaterial2/TextNum")
	self.efxUpgradePanel = UIControls.Panel(self, "AttrPanel/EfxUpgrade")
	self.imgHeroStar = UIControls.Image(self, "InfoPanel/ImgStar")
	self.attrList = {}

	for i = 1, 4 do
		local attrPanel = HeroAttrPanel(self, "AttrPanel/Attr" .. i)

		table.insert(self.attrList, attrPanel)
	end

	if UIControls.checkControlFunc(self, "InfoPanel/BgHead/IconUR") then
		self.iconUR = UIControls.Panel(self, "InfoPanel/BgHead/IconUR")
	end

	self:setHero(self.mWindow.selectedHero)
end

function HeroAllContentBaseInfoPanel:playUpgradeEfx()
	if self.efxUpgradePanel:getVisible() then
		self.efxUpgradePanel:setVisible(false)
	end

	self.efxUpgradePanel:setVisible(true)
end

function HeroAllContentBaseInfoPanel:setHero(hero)
	self.hero = hero

	self:refreshBaseInfo()
	self:refreshStarPanel()
	self:refreshPropPanel()
	self:refreshMaterialInfo()
	self:refreshGridSkill()

	local reasonList = {}
	local reasonCount = #reasonList

	self.txtNeedGold:setFontColor(ResColor.GREYWHITE)
	self.txtNeedMaterial:setFontColor(ResColor.GREYWHITE)

	if reasonCount == 0 then
		-- block empty
	else
		for i = 1, reasonCount do
			if reasonList[i] == LACK_GOLD then
				self.txtNeedGold:setFontColor(ResColor.RED)
			elseif reasonList[i] == LACK_MATERIAL then
				self.txtNeedMaterial:setFontColor(ResColor.RED)
			elseif reasonList[i] == LACK_STAR_LV then
				-- block empty
			elseif reasonList[i] == LACK_PLAYER_LV then
				-- block empty
			end
		end
	end

	if self.iconUR then
		self.iconUR:setVisible(self.hero:isURHero())
	end
end

function HeroAllContentBaseInfoPanel:refreshGridSkill()
	if self.gridSkillList and #self.gridSkillList > 0 then
		for i, v in ipairs(self.gridSkillList) do
			self.gridSkillList[i]:destroy()
		end
	end

	self.gridSkillList = {}

	for i = 1, 4 do
		if self.hero[Const.SKILL_FIELD_LIST[i]] then
			local skillGrid = UIControls.HeroSkillGridChild(self, "SkillPanel/SkillList", "System/Hero/GridHeroSkill", 0, 0, true)

			skillGrid.gridPanel = UIConst.SKILL_PANEL_HERO_BASE

			skillGrid:setObj(self.hero[Const.SKILL_FIELD_LIST[i]], self.hero)
			table.insert(self.gridSkillList, skillGrid)
		end
	end
end

function HeroAllContentBaseInfoPanel:refreshMaterialInfo()
	self.levelCostInfo = ResLevelCost[self.hero.quality][self.hero.level]

	local needMaterialId = self.levelCostInfo.res_id
	local needMaterialCount = self.levelCostInfo.res_num
	local needGoldCount = self.levelCostInfo.gold
	local moneyID = Const.MONEY_TYPE2ID[Const.MONEY_TYPE_GOLD] or 0
	local moneyInfo = ClientUtils.getMoneyIcon(moneyID)

	if moneyInfo then
		self.imgGoldIcon:setImage(moneyInfo[1], moneyInfo[2])
	end

	self.txtNeedGold:setText(ClientUtils.getNumShortStr(needGoldCount))

	local materialItem = BaseObject.GetObject(needMaterialId)
	local materialsIconPath = materialItem:getIconPath()

	self.imgMaterialIcon:setImage(materialsIconPath[1], materialsIconPath[2])
	self.txtNeedMaterial:setText(ClientUtils.getNumShortStr(needMaterialCount))
	self.mWindow.pnlCommonFuncEntry:onItemUpdate(needMaterialId)
end

function HeroAllContentBaseInfoPanel:refreshPropPanel()
	local equips = self.hero:getEquips()
	local artifact = self.hero:getArtifact()

	self.container = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, self.hero:getPropLevel(), self.hero.step, self.hero.star, equips, artifact, self.hero)

	for i = 1, 4 do
		local attrName = ATTR_PANEL_PROP_MAP[i].prop
		local value = self.container[attrName] or 0
		local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, value, true)
		local rankValue = CurAvatar:getHeroPropValueByStep(attrName, self.hero.id, self.hero.battleStep)
		local attrRank = CurAvatar:getHeroPropRank(attrName, rankValue)
		local rankIconInfo = UIConst.HERO_PROP_RANK_ICON[attrRank]

		self.attrList[i]:setData(zhName, valueStr)

		local imgRank = UIControls.Image(self.attrList[i], self.attrList[i].mPath .. "/IconScore")

		imgRank:setImage(rankIconInfo[1], rankIconInfo[2])

		local attriconInfo = ClientUtils.getRolePropIcon(attrName)

		self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
	end
end

function HeroAllContentBaseInfoPanel:refreshStarPanel()
	local starPath = self.hero:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end
end

function HeroAllContentBaseInfoPanel:refreshBaseInfo()
	self.txtName:setText(self.hero.name)

	local headPath = self.hero:getIconPath(true)

	if headPath then
		self.imgIconHead:setImage(headPath[1], headPath[2])
	end

	local stepImgIdx = ResStep[self.hero.step] and ResStep[self.hero.step].step_img_idx or 1
	local stepImgInfo = UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]

	self.imgIconHeadBg:setImage(stepImgInfo.BG_HEAD[1], stepImgInfo.BG_HEAD[2])
	self.imgCareerIcon:setImage(HERO_COMMON_ATLAS, "IconCareer0" .. self.hero.career)
	self.txtCareer:setText(Const.CAREER_CONFIG[self.hero.career].name)
	self.txtHeroLv:setText(self.hero.level)
	self.hero:setHeroStepUI(self.hero.step, self.bgStage, self.txtStage)
	self.txtGroup:setText(Const.CAMP_CONFIG[self.hero.resData.camp].name)
	self.imgGroup:setImage(HERO_COMMON_ATLAS, "IconGroup0" .. self.hero.camp)

	local power = 9999

	self.txtPowerNum:setText(power)
	self.txtHeroMaxLv:setText(ResStar[self.hero.resData.star_prop_id][self.hero.star].max_level)
end

function HeroAllContentBaseInfoPanel:setVisible(isVisible)
	self.efxUpgradePanel:setVisible(false)
	HeroAllContentBaseInfoPanel.super.setVisible(self, isVisible)
end

return HeroAllContentBaseInfoPanel
