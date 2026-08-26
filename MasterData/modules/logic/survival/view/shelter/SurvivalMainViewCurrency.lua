-- chunkname: @modules/logic/survival/view/shelter/SurvivalMainViewCurrency.lua

module("modules.logic.survival.view.shelter.SurvivalMainViewCurrency", package.seeall)

local SurvivalMainViewCurrency = class("SurvivalMainViewCurrency", BaseView)

function SurvivalMainViewCurrency:onInitView()
	self.btnCurrency = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Top/#go_currency")
	self.imgCurrency = gohelper.findChildImage(self.viewGO, "go_normalroot/Top/#go_currency/#image_icon")
	self.txtCurrency = gohelper.findChildTextMesh(self.viewGO, "go_normalroot/Top/#go_currency/#txt_currency")
	self.goArrow = gohelper.findChild(self.viewGO, "go_normalroot/Top/#go_currency/arrow")
	self.goTips = gohelper.findChild(self.viewGO, "go_normalroot/Top/#go_currency/go_tips")
	self.txtSpeed = gohelper.findChildTextMesh(self.goTips, "#txt_speed")
	self.imgSpeedIcon = gohelper.findChildImage(self.goTips, "#txt_speed/#image_icon")
	self.btnCloseTips = gohelper.findChildButtonWithAudio(self.goTips, "#btn_close")
	self.itemType = SurvivalEnum.ItemType.Currency
	self.currencyList = {
		SurvivalEnum.CurrencyType.Food,
		SurvivalEnum.CurrencyType.Build
	}
	self.currencyItemList = {}
end

function SurvivalMainViewCurrency:addEvents()
	self.addClickCb(self, self.btnCurrency, self.onClickCurrency, self)
	self.addClickCb(self, self.btnCloseTips, self.onClickCloseTips, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, self.onWeekInfoUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnAttrUpdate, self.onAttrUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
end

function SurvivalMainViewCurrency:removeEvents()
	self:removeClickCb(self.btnCurrency)
	self:removeClickCb(self.btnCloseTips)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, self.onWeekInfoUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnAttrUpdate, self.onAttrUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
end

function SurvivalMainViewCurrency:onWeekInfoUpdate()
	self:refreshCurrency()
end

function SurvivalMainViewCurrency:onAttrUpdate()
	self:refreshCurrency()
end

function SurvivalMainViewCurrency:onNpcPostionChange()
	self:refreshCurrency()
end

function SurvivalMainViewCurrency:onShelterBagUpdate()
	self:refreshCurrency()
end

function SurvivalMainViewCurrency:onClickCurrency()
	self:setTipsVisible(true)
end

function SurvivalMainViewCurrency:onClickCloseTips()
	self:setTipsVisible(false)
end

function SurvivalMainViewCurrency:onOpen()
	self:setTipsVisible(false)
	self:refreshCurrency()
end

function SurvivalMainViewCurrency:setTipsVisible(isVisible)
	if self._tipsVisible == isVisible then
		return
	end

	self._tipsVisible = isVisible

	gohelper.setActive(self.goArrow, not isVisible)
	gohelper.setActive(self.goTips, isVisible)

	if isVisible then
		self:refreshSpeed()
	end
end

function SurvivalMainViewCurrency:refreshCurrency()
	for i, v in ipairs(self.currencyList) do
		local item = self:getCurrencyItem(i)

		self:refreshCurrencyItem(item, v)
	end

	self:refreshSpeed()
end

function SurvivalMainViewCurrency:getCurrencyItem(index)
	local item = self.currencyItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.findChild(self.viewGO, "go_normalroot/Top/#go_currency/#go_tag/tag" .. index)
		item.txtNum = gohelper.findChildTextMesh(item.go, "#txt_tag")
		self.currencyItemList[index] = item
	end

	return item
end

function SurvivalMainViewCurrency:refreshCurrencyItem(item, currencyId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local itemCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(currencyId)

	if currencyId == SurvivalEnum.CurrencyType.Food then
		local npcCost = weekInfo:getNpcCost()
		local enough = npcCost <= itemCount

		item.txtNum.text = enough and itemCount or string.format("<color=#ff0000>%s</color>", itemCount)
	else
		item.txtNum.text = itemCount
	end
end

function SurvivalMainViewCurrency:refreshSpeed()
	if not self._tipsVisible then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcCost = weekInfo:getNpcCost()

	self.txtSpeed.text = formatLuaLang("survival_mainview_foodcost_speed", npcCost)
end

return SurvivalMainViewCurrency
