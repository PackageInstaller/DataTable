-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroResetDlg.lua

local ResHeroResetMisc = require("ClientData/ResHeroResetMisc")
local ResStep = require("ClientData/ResStep")
local strClassName = "HeroResetDlg"
local HeroResetDlg = Class(strClassName, UIControls.Window)
local ConsumeTips = require("System/ConsumeTips")

function HeroResetDlg:ctor()
	self:initUI()
end

function HeroResetDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "Num")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgCost = UIControls.Image(self, "BgPanel/BtnConfirm/Icon")
	self.panelEquip = UIControls.Panel(self, "BgPanel/EquipRewardPanel")
	self.txtTitle = UIControls.Label(self, "BgPanel/ItemRewardPanel/TextTitle")
	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
	self.txtDlgTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.imgNothing = UIControls.Image(self, "BgPanel/EquipRewardPanel/ImgNothing")
end

local TITLE_RULE_TEXT_STR = {
	[Const.HERO_RESET_LEVEL] = {
		Lang.get(1237),
		Lang.get(1239),
		Lang.get(1146)
	},
	[Const.HERO_RESET_STEP] = {
		Lang.get(30348),
		Lang.get(30349),
		Lang.get(1147)
	},
	[Const.HERO_RESET_ALL] = {
		Lang.get(30350),
		Lang.get(30351),
		Lang.get(30352)
	}
}

function HeroResetDlg:setHero(hero, resetType)
	self.hero = hero
	self.resetType = resetType
	self.cosumeInfo = ResHeroResetMisc[self.resetType].consume[1]

	self.btnConfirm:setText(self.cosumeInfo.num)
	self.txtTitle:setText(TITLE_RULE_TEXT_STR[self.resetType][1])
	self.txtRule:setText(TITLE_RULE_TEXT_STR[self.resetType][2])
	self.txtDlgTitle:setText(TITLE_RULE_TEXT_STR[self.resetType][3])

	local moneyInfo = ClientUtils.getMoneyIcon(self.cosumeInfo.id)

	if moneyInfo then
		self.imgCost:setImage(moneyInfo[1], moneyInfo[2])
	else
		local materialItem = BaseObject.GetObject(self.cosumeInfo.id)
		local materialsIconPath = materialItem:getIconPath()

		if materialsIconPath then
			self.imgCost:setImage(materialsIconPath[1], materialsIconPath[2])
		end
	end

	local stepResetPanelPath = "ResetPanel/"
	local cardHeroPath1 = "GridHeroCardPanel/GridHeroCardPanel1"
	local cardHeroPath2 = "GridHeroCardPanel/GridHeroCardPanel2"
	local itemPanelPath = "ItemRewardPanel/RewardList/Content"
	local equipPanelPath = "EquipRewardPanel/RewardList/Content"

	if self.resetType == Const.HERO_RESET_STEP then
		cardHeroPath1 = "BgPanel/" .. stepResetPanelPath .. cardHeroPath1
		cardHeroPath2 = "BgPanel/" .. stepResetPanelPath .. cardHeroPath2
		itemPanelPath = "BgPanel/" .. stepResetPanelPath .. itemPanelPath
		equipPanelPath = "BgPanel/" .. stepResetPanelPath .. equipPanelPath
	else
		cardHeroPath1 = "BgPanel/" .. cardHeroPath1
		cardHeroPath2 = "BgPanel/" .. cardHeroPath2
		itemPanelPath = "BgPanel/" .. itemPanelPath
		equipPanelPath = "BgPanel/" .. equipPanelPath
	end

	local cardCurHero = UIControls.HeroCardChild(self, cardHeroPath1, "System/Hero/GridHeroCard")

	cardCurHero:setHero(self.hero)
	cardCurHero:setHeroRealLv()
	cardCurHero:setSelectCallback(Functor(self.showHeroTips, self, self.hero))
	cardCurHero:setVisible(true)

	local cardFakeHero = UIControls.HeroCardChild(self, cardHeroPath2, "System/Hero/GridHeroCard")
	local fakeHero = utils.getResetedHero(self.hero, self.resetType)

	cardFakeHero:setHero(fakeHero)

	local fakeLv = self.resetType == Const.HERO_RESET_STEP and self.hero.realLevel or 1

	cardFakeHero:setHeroRealLv(fakeLv)
	cardFakeHero:setSelectCallback(Functor(self.showHeroTips, self, fakeHero))
	cardFakeHero:setVisible(true)

	local materialIdNumList = utils.getHeroResetReturnMaterialList(self.hero, resetType)

	self.materialGrids = {}

	for _, idNum in ipairs(materialIdNumList) do
		local itemGrid = UIControls.ItemGridChild(self, itemPanelPath, "System/Common/Grid/GridMaterialItem")
		local item = BaseObject.GetObject(idNum.id, idNum.num)

		itemGrid:setObj(item)

		itemGrid.mDisableWays = true

		itemGrid:setVisible(true)
		table.insert(self.materialGrids, itemGrid)
	end

	local equipedList = hero:getEquipedList()

	self.imgNothing:setVisible(#equipedList == 0)

	if #equipedList ~= 0 then
		for part, equipItem in pairs(equipedList) do
			local fakeEquipedItem = BaseObject.CopyObject(equipItem)

			fakeEquipedItem.inWearing = nil

			local itemGrid = UIControls.getGridChild(fakeEquipedItem, self, equipPanelPath)

			itemGrid:setVisible(true)
			itemGrid:setObj(fakeEquipedItem)
		end
	end
end

function HeroResetDlg:flyGrid()
	for _, grid in ipairs(self.materialGrids) do
		if grid:getVisible() then
			grid:flyToCommonFuncEntryPanel()
		end
	end
end

function HeroResetDlg:showHeroTips(hero)
	local heroTips = UIManager.getUI("heroTips")

	heroTips:showObj(self, hero)
end

function HeroResetDlg:resetHero()
	if self.resetType == Const.HERO_RESET_STEP and self.hero:getResetStepCD() > 0 then
		local function yesFunc()
			self:showTips()
		end

		local msgContent = string.format(Lang.get(30347), self.hero:getResetStepCD() / 60)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	else
		self:showTips()
	end
end

function HeroResetDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroResetDlg:onBtnConfirmClick()
	ClientUtils.checkMoneyChange(self.cosumeInfo.id, self.cosumeInfo.num, self.resetHero, self, true)
end

function HeroResetDlg:showTips()
	local event_type

	if self.resetType == Const.HERO_RESET_LEVEL then
		event_type = Const.CONSUME_DIAMOND_RESET_LEVEL
	elseif self.resetType == Const.HERO_RESET_STEP then
		event_type = Const.CONSUME_DIAMOND_RESET_STEP
	elseif self.resetType == Const.HERO_RESET_ALL then
		event_type = Const.CONSUME_DIAMOND_RESET_ALL
	end

	ConsumeTips.showTipsDiamond(self.cosumeInfo.num, event_type, 1, Slot(self.realConfirmReset, self), Slot(self.onBtnCloseClick, self))
end

function HeroResetDlg:realConfirmReset()
	if not self.btnLock then
		self.btnLock = true

		if self.resetType == Const.HERO_RESET_LEVEL then
			RPC.heroLevelReset(self.hero.gid)
		end

		if self.resetType == Const.HERO_RESET_STEP then
			RPC.heroStepReset(self.hero.gid)
		end

		if self.resetType == Const.HERO_RESET_ALL then
			RPC.heroReset(self.hero.gid)
		end
	end
end

return HeroResetDlg
