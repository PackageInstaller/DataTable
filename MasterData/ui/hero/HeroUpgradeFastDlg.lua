-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroUpgradeFastDlg.lua

local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResLevelCost = require("ClientData/ResLevelCost")
local strClassName = "HeroUpgradeFastDlg"
local HeroUpgradeFastDlg = Class(strClassName, UIControls.Window)

function HeroUpgradeFastDlg:ctor()
	self:initUI()
end

function HeroUpgradeFastDlg:initUI()
	self.txtOriLv = UIControls.Label(self, "Bg/UpgradeFastPanel/TextLvBefore")
	self.txtTarLv = UIControls.Label(self, "Bg/UpgradeFastPanel/TextLvAfter")
	self.imgGoldIcon = UIControls.Image(self, "Bg/GridMaterialPanel/UpgradeMaterial1")
	self.txtNeedGold = UIControls.Label(self, "Bg/GridMaterialPanel/UpgradeMaterial1/TextNum")
	self.imgMaterialIcon = UIControls.Image(self, "Bg/GridMaterialPanel/UpgradeMaterial2")
	self.txtNeedMaterial = UIControls.Label(self, "Bg/GridMaterialPanel/UpgradeMaterial2/TextNum")
	self.imgMaterialIcon2 = UIControls.Image(self, "Bg/GridMaterialPanel/UpgradeMaterial3")
	self.txtNeedMaterial2 = UIControls.Label(self, "Bg/GridMaterialPanel/UpgradeMaterial3/TextNum")
	self.panelUpgradeFast = UIControls.Panel(self, "Bg/UpgradeFastPanel")
	self.panelInfo = UIControls.Panel(self, "Bg/InfoPanel")
	self.txtName = UIControls.Label(self, "Bg/TextName")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function HeroUpgradeFastDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroUpgradeFastDlg:onBtnDenyClick()
	self:setVisible(false)
end

function HeroUpgradeFastDlg:onBtnConfirmClick()
	RPC.heroLevelUp(self.hero.gid, self.quickTarget)
end

function HeroUpgradeFastDlg:setHeroQuickLv(hero, quickTarget)
	self.hero = hero
	self.quickTarget = quickTarget

	self.txtOriLv:setText(self.hero.level)
	self.txtTarLv:setText(self.quickTarget)
	self.txtName:setText(self.hero.name)

	self.gridHero = GridHeroStarUp(self, "Bg/HeroPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)

	self.gridHero:setHero(self.hero)
	self.gridHero:setOnlyShowHead()

	local materialIdNums = utils.getHeroLevelCost(self.hero, self.hero.realLevel, self.quickTarget)

	self.levelCostInfo = {}
	self.levelCostInfo.res_id = {}
	self.levelCostInfo.res_num = {}

	if materialIdNums[Const.MONEY_ID_HERO_EXP] then
		self.levelCostInfo.res_id[1] = Const.MONEY_ID_HERO_EXP
		self.levelCostInfo.res_num[1] = materialIdNums[Const.MONEY_ID_HERO_EXP]
	end

	if materialIdNums[Const.MONEY_ID_HERO_EXP2] then
		self.levelCostInfo.res_id[2] = Const.MONEY_ID_HERO_EXP2
		self.levelCostInfo.res_num[2] = materialIdNums[Const.MONEY_ID_HERO_EXP2]
	end

	self.levelCostInfo.gold = materialIdNums[Const.MONEY_ID_GOLD]

	self:refreshMaterialInfo()
end

function HeroUpgradeFastDlg:refreshMaterialInfo()
	local needMaterialId = self.levelCostInfo.res_id[1]
	local needMaterialCount = self.levelCostInfo.res_num[1]
	local needGoldCount = self.levelCostInfo.gold
	local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_GOLD]

	if moneyInfo then
		self.imgGoldIcon:setImage(moneyInfo[1], moneyInfo[2])
	end

	self.txtNeedGold:setText(ClientUtils.getNumShortStr(needGoldCount))
	self.imgMaterialIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconHeroExp")
	self.txtNeedMaterial:setText(ClientUtils.getNumShortStr(needMaterialCount))

	if self.levelCostInfo.res_id[2] then
		local needId = self.levelCostInfo.res_id[2]
		local needNum = self.levelCostInfo.res_num[2]

		self.imgMaterialIcon2:setVisible(true)
		self.imgMaterialIcon2:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconLvUp")
		self.txtNeedMaterial2:setText(ClientUtils.getNumShortStr(needNum))
	else
		self.imgMaterialIcon2:setVisible(false)
	end
end

return HeroUpgradeFastDlg
