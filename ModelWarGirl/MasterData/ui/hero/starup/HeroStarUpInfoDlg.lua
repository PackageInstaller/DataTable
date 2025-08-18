-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarUpInfoDlg.lua

local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResStar = require("ClientData/ResStar")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local strClassName = "HeroStarUpInfoDlg"
local HeroStarUpInfoDlg = Class(strClassName, UIControls.Window)
local STAR_UP_SHIELD_ATTR = {
	star_atk_percent = 1,
	atk_percent = 1,
	mhp_percent = 1,
	star_mhp_percent = 1
}

function HeroStarUpInfoDlg:ctor()
	self:initUI()
end

function HeroStarUpInfoDlg:initUI()
	self.attrPanelList = {}

	for i = 1, 3 do
		local attrPanel = HeroAttrPanel(self, "BgPanel/InfoPanel/AttrPanel" .. i)

		self.attrPanelList[i] = attrPanel
	end

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.aniDlg = UIControls.UIAni(self, "")
end

function HeroStarUpInfoDlg:setHero(hero, materials)
	self.hero = hero
	self.materials = materials
	self.attrNameMap = {}

	local equips = hero:getEquips()
	local artifact = hero:getArtifact()
	local oriContainer = {}
	local targetContainer = {}

	if self.materials then
		oriContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep, hero.star, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
		targetContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep, hero.star + 1, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
	else
		oriContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep, hero.star - 1, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
		targetContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep, hero.star, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
	end

	local changeContainer = {}

	for k, v in pairs(targetContainer) do
		if not STAR_UP_SHIELD_ATTR[k] then
			local attrInfo = self:genAttrInfo(k, oriContainer[k], v)

			if attrInfo then
				table.insert(changeContainer, attrInfo)
			end
		end
	end

	local starPropOri = {}
	local starPropTar = {}

	if self.materials then
		starPropOri = ResStar[self.hero.resData.star_prop_id][self.hero.star]
		starPropTar = ResStar[self.hero.resData.star_prop_id][self.hero.star + 1]
	else
		starPropOri = ResStar[self.hero.resData.star_prop_id][self.hero.star - 1]
		starPropTar = ResStar[self.hero.resData.star_prop_id][self.hero.star]
	end

	if starPropOri.max_level ~= starPropTar.max_level then
		local attrInfo = {}

		attrInfo.attrName = Lang.get(30361)
		attrInfo.oriValue = string.format(Lang.get(30171), starPropOri.max_level)
		attrInfo.tarValue = string.format(Lang.get(30171), starPropTar.max_level)

		table.insert(changeContainer, attrInfo)
	end

	for i, v in ipairs(changeContainer) do
		self.attrPanelList[i]:setData(v.attrName, v.oriValue, v.tarValue)
	end

	for i = #changeContainer + 1, 3 do
		self.attrPanelList[i]:setVisible(false)
	end

	local oriHero = BaseObject.CopyObject(self.hero)

	oriHero:initCrystalData()

	local tarHero = BaseObject.CopyObject(self.hero)

	tarHero:initCrystalData()

	local beforeHeroGrid = GridHeroStarUp(self, "BgPanel/StarUpBeforePanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
	local afterHeroGrid = GridHeroStarUp(self, "BgPanel/StarUpAfterPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)

	if self.materials then
		self:initMaterialsGrid()

		tarHero.star = tarHero.star + 1
	else
		oriHero.star = oriHero.star - 1
	end

	beforeHeroGrid:setHero(oriHero)
	afterHeroGrid:setHero(tarHero)
end

local MATERIAL_TYPE_LIST = {
	Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID,
	Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP,
	Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID
}

function HeroStarUpInfoDlg:initMaterialsGrid()
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, hero in ipairs(self.materials[materialType]) do
			local gridHero = GridHeroStarUp(self, "BgPanel/GridMaterialList/Content", "System/StarUp/GridHeroStarUp", 0, 0, true)

			gridHero:setHero(hero)
		end
	end
end

function HeroStarUpInfoDlg:genAttrInfo(attrName, oriAttr, tarAttr)
	if oriAttr and tarAttr ~= oriAttr and type(oriAttr) == "number" then
		local attrInfo = {}
		local tarValue = tarAttr or 0
		local attrFromPlayer = self.upgradeType == 1
		local tarZhName, tarValueStr = ClientUtils.getRolePropZhName(attrName, tarValue, attrFromPlayer)
		local oriValue = oriAttr or 0
		local oriZhName, oriValueStr = ClientUtils.getRolePropZhName(attrName, oriValue, attrFromPlayer)

		attrInfo.attrName = tarZhName
		attrInfo.oriValue = oriValueStr
		attrInfo.tarValue = tarValueStr
		self.attrNameMap[tarZhName] = attrName

		return attrInfo
	end
end

function HeroStarUpInfoDlg:onBtnConfirmClick()
	self:realConfirm()
end

function HeroStarUpInfoDlg:realConfirm()
	local gids = {}

	gids[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = {}
	gids[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = {}
	gids[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = {}

	local eatedHeros = {}

	for materialType, heroList in pairs(self.materials) do
		for _, hero in ipairs(heroList) do
			table.insert(gids[materialType], hero.gid)
			table.insert(eatedHeros, hero)
		end
	end

	CurAvatar:setMaterialHerosEated(eatedHeros)

	local starUpInfo = {}

	starUpInfo.hero_gid = self.hero.gid
	starUpInfo.same_gid = gids.sameGid or {}
	starUpInfo.any_gid = gids.anyGid or {}
	starUpInfo.special_gid = gids.specialGid or {}
	starUpInfo.same_camp_gid = gids.campGid or {}
	starUpInfo.star = self.hero.star + 1

	RPC.heroStarUpBatch({
		starUpInfo
	})
end

function HeroStarUpInfoDlg:onBtnCloseClick()
	if not self.isClosing then
		self.isClosing = true

		self.aniDlg:clearEventFinish()
		self.aniDlg:addEventFinish(self.realCloseDlg)
		self.aniDlg:startAni("CloseHeroStarUpInfoWin", true)
	end
end

function HeroStarUpInfoDlg:realCloseDlg()
	self:setVisible(false)
end

return HeroStarUpInfoDlg
