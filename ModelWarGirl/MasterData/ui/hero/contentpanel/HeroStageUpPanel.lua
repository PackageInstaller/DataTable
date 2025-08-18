-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroStageUpPanel.lua

local ResStep = require("ClientData/ResStep")
local GridHeroCardStage = require("UI/Hero/Grid/GridHeroCardStage")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local ResColor = require("ClientData/ResColor")
local ResStepCost = require("ClientData/ResStepCost")
local HERO_COMMON_ATLAS = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local strClassName = "HeroStageUpPanel"
local HeroStageUpPanel = Class(strClassName, UIControls.Child)

function HeroStageUpPanel:ctor()
	self:initUI()
end

function HeroStageUpPanel:initUI()
	self.txtBeforeName = UIControls.Label(self, "HeroCardPanel/GridCardBefore/NamePanel/TextName")
	self.bgBeforeStage = UIControls.Image(self, "HeroCardPanel/GridCardBefore/NamePanel/BgStageLv")
	self.txtBeforeStage = UIControls.Label(self, "HeroCardPanel/GridCardBefore/NamePanel/BgStageLv/Text")
	self.txtAfterName = UIControls.Label(self, "HeroCardPanel/GridCardAfter/NamePanel/TextName")
	self.bgAfterStage = UIControls.Image(self, "HeroCardPanel/GridCardAfter/NamePanel/BgStageLv")
	self.txtAfterStage = UIControls.Label(self, "HeroCardPanel/GridCardAfter/NamePanel/BgStageLv/Text")
	self.btnUpgrage = UIControls.Button(self, "BtnUpgrade")

	self.btnUpgrage:addEventClick(self.onBtnUpgrageClick)

	self.imgArrow = UIControls.Image(self, "HeroCardPanel/ImgArrow")
	self.txtNeedGold = UIControls.Label(self, "BtnUpgrade/TextNum")
	self.txtLvMax = UIControls.Label(self, "MaterialPanel/TextLvMax")
	self.imgGoldIcon = UIControls.Image(self, "BtnUpgrade/TextNum/IconMoney")
	self.txtNeedGold = UIControls.Label(self, "BtnUpgrade/TextNum")
	self.materialPanel = UIControls.Panel(self, "MaterialPanel")
	self.heroCardPanel = UIControls.Panel(self, "HeroCardPanel")
	self.cardMaxPanel = UIControls.Panel(self, "CardMaxPanel")
	self.materialGridList = {}
end

function HeroStageUpPanel:onBtnUpgrageClick()
	if #self.lackInfo == 0 then
		RPC.heroStepUp(self.hero.gid)
	else
		MsgManager.notice(string.format(Lang.get(30029), self.lackInfo[1]))
	end
end

function HeroStageUpPanel:setHero(hero)
	self.hero = hero

	if not self.beforeCard then
		self.beforeCard = GridHeroCardStage(self, "HeroCardPanel/GridCardBefore", "System/Hero/GridHeroCard", 0, 0, true)
	end

	self.beforeCard:setHero(self.hero)

	local isStepMax = self.hero.step == self.hero:getMaxStep()

	self.heroCardPanel:setVisible(not isStepMax)
	self.materialPanel:setVisible(not isStepMax)
	self.cardMaxPanel:setVisible(isStepMax)

	if isStepMax then
		if not self.maxCard then
			self.maxCard = GridHeroCardStage(self, "CardMaxPanel", "System/Hero/GridHeroCard", 0, 0, true)
		end

		self.maxCard:setHero(self.hero)
		self:heroStageUpPanelClear()
	else
		self:initAfterCard()
		self:refreshStageMaterialInfo()
		self:checkStageUpGold()
		self.txtLvMax:setText(string.format(Lang.get(30383), ResStep[self.hero.step + 1].level_limit))
	end

	local canStageUp = not isStepMax and self.hero.level >= ResStep[self.hero.step + 1].level_limit

	self:setPanelBaseInfo(canStageUp)
end

function HeroStageUpPanel:checkStageUpGold()
	if CurAvatar:getMoneyByType(Const.MONEY_TYPE_GOLD) < self.stepCostInfo.gold then
		table.insert(self.lackInfo, Lang.get(30384))
		self.txtNeedGold:setFontColor(ResColor.RED)
	else
		self.txtNeedGold:setFontColor(ResColor.BLACKMAIN)
	end
end

function HeroStageUpPanel:initAfterCard()
	if not self.afterCard then
		self.afterCard = GridHeroCardStage(self, "HeroCardPanel/GridCardAfter", "System/Hero/GridHeroCard", 0, 0, true)
	end

	local afterHero = BaseObject.CopyObject(self.hero)

	afterHero:initTeamInfo()

	afterHero.step = afterHero.step + 1

	self.afterCard:setHero(afterHero)
	CurAvatar:setHeroStepUI(afterHero, self.bgAfterStage, self.txtAfterStage)
end

function HeroStageUpPanel:heroStageUpPanelClear()
	for k, v in pairs(self.materialGridList) do
		self.materialGridList[k]:destroy()
	end
end

function HeroStageUpPanel:refreshStageMaterialInfo()
	for k, v in pairs(self.materialGridList) do
		self.materialGridList[k]:destroy()
	end

	self.lackInfo = {}
	self.stepCostInfo = ResStepCost[self.hero.resData.step_up_id][self.hero.step + 1]

	for i, v in ipairs(self.stepCostInfo.materials) do
		local materialGrid = MaterialItemGridChild(self, "MaterialPanel/MaterialList", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		local enough = materialGrid:setMaterial(v.id, v.num)

		if not enough then
			table.insert(self.lackInfo, materialGrid.object.resData.name)
		end

		materialGrid.hero = self.hero
		self.materialGridList[i] = materialGrid
	end

	self.imgGoldIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconGold")
	self.txtNeedGold:setText(self.stepCostInfo.gold)
end

function HeroStageUpPanel:setPanelBaseInfo(canStageUp)
	self.txtBeforeName:setText(self.hero.name)
	self.txtAfterName:setText(self.hero.name)
	CurAvatar:setHeroStepUI(self.hero, self.bgBeforeStage, self.txtBeforeStage)
	self.btnUpgrage:setVisible(canStageUp)
	self.txtLvMax:setVisible(not canStageUp)
end

return HeroStageUpPanel
