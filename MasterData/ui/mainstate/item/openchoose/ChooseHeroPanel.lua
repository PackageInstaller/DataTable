-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChooseHeroPanel.lua

local strClassName = "BtnChooseHero"
local BtnChooseHero = Class(strClassName, UIControls.Child)

function BtnChooseHero:ctor()
	self:initUI()
end

function BtnChooseHero:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
end

function BtnChooseHero:onBtnTipsClick()
	local heroTips = UIManager.getUI("heroTips")

	heroTips:showObj(self, self.hero)
end

function BtnChooseHero:onBtnSelfClick()
	self.mParent:onBtnSelectClick(self.btnSelf)
end

function BtnChooseHero:setHero(hero)
	self.hero = hero
	self.heroCard = UIControls.HeroCardChild(self, "GridHeroCardPanel", "System/Hero/GridHeroCard", 0, 0, true)

	self.heroCard:setHero(self.hero)
end

local ChoosePanel = require("UI/MainState/Item/OpenChoose/ChoosePanel")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "ChooseHeroPanel"
local ChooseHeroPanel = Class(strClassName, ChoosePanel)

function ChooseHeroPanel:setItem(itemGift)
	self.itemGift = itemGift

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(self.itemGift.num)

	for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
		local heroId = ResRandClient[random_id].show_ids[1]
		local heroCell = BtnChooseHero(self, self.mPath .. "/HeroList/Content", "System/Bag/BtnChooseHero", 0, 0, true)
		local fakeHero = BaseObject.GetObject(heroId)

		heroCell:setHero(fakeHero)

		self.btnList[i] = heroCell.btnSelf
		self.btnList[i].idx = i
	end

	self:onBtnSelectClick(self.btnList[1])
end

return ChooseHeroPanel
