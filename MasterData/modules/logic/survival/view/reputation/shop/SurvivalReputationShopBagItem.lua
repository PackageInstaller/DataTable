-- chunkname: @modules/logic/survival/view/reputation/shop/SurvivalReputationShopBagItem.lua

module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopBagItem", package.seeall)

local SurvivalReputationShopBagItem = class("SurvivalReputationShopBagItem", LuaCompBase)

function SurvivalReputationShopBagItem:ctor()
	return
end

function SurvivalReputationShopBagItem:init(viewGO)
	self.viewGO = viewGO
	self.go_item = gohelper.findChild(self.viewGO, "#go_item")
	self.btn_click = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
end

function SurvivalReputationShopBagItem:addEventListeners()
	self.addClickCb(self, self.btn_click, self.onClick, self)
end

function SurvivalReputationShopBagItem:onClick()
	if self.onClickCallBack then
		self.onClickCallBack(self.onClickContext, self)
	end
end

function SurvivalReputationShopBagItem:updateMo(data)
	self.viewContainer = data.viewContainer
	self.onClickCallBack = data.onClickCallBack
	self.onClickContext = data.onClickContext

	self:refreshBagItem(data.survivalShopItemMo)
end

function SurvivalReputationShopBagItem:refreshBagItem(survivalShopItemMo)
	self.survivalShopItemMo = survivalShopItemMo

	if not self.survivalBagItem then
		local resPath = self.viewContainer:getSetting().otherRes.survivalmapbagitem
		local obj = self.viewContainer:getResInst(resPath, self.go_item)

		self.survivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalBagItem)
	end

	self.survivalBagItem:updateMo(self.survivalShopItemMo, {
		jumpAdd = true
	})
	self.survivalBagItem:setReputationShopStyle({
		isShowFreeReward = false,
		isCanGet = false,
		isReceive = self.survivalShopItemMo.count <= 0,
		price = self.survivalShopItemMo:getBuyPrice()
	})

	self.survivalShopItemMo = survivalShopItemMo
end

return SurvivalReputationShopBagItem
