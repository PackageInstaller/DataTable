-- chunkname: @modules/logic/survival/view/reputation/shop/SurvivalReputationShopItem.lua

module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopItem", package.seeall)

local SurvivalReputationShopItem = class("SurvivalReputationShopItem", LuaCompBase)

function SurvivalReputationShopItem:init(viewGO)
	self.viewGO = viewGO
	self.go_freeItem = gohelper.findChild(self.viewGO, "normal/reward/#go_item")
	self.survivalreputationshopbagitem = gohelper.findChild(self.viewGO, "normal/layout/survivalreputationshopbagitem")
	self.goGoods = gohelper.findChild(self.viewGO, "normal/layout")
	self.image_level = gohelper.findChildImage(self.viewGO, "normal/#image_level")
	self.go_lock = gohelper.findChild(self.viewGO, "lock")
	self.simage_panel = gohelper.findChildSingleImage(self.viewGO, "normal/#simage_panel")
	self.lockPlayer = SLFramework.AnimatorPlayer.Get(self.go_lock)

	gohelper.setActive(self.survivalreputationshopbagitem, false)

	self.customItems = {}
end

function SurvivalReputationShopItem:addEventListeners()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalReputationRewardReply, self.onReceiveSurvivalReputationRewardReply, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShopItemUpdate, self._onShopItemUpdate, self)
end

function SurvivalReputationShopItem:removeEventListeners()
	return
end

function SurvivalReputationShopItem:onReceiveSurvivalReputationRewardReply(msg)
	local reputationId = msg.reputationId
	local level = msg.level

	if reputationId == self.prop.reputationId and level == self.posLevel then
		self:refreshFreeItem()
		self.freeSurvivalBagItem:playGainReputationFreeReward()
	end
end

function SurvivalReputationShopItem:_onShopItemUpdate(index, itemMo)
	for i, v in ipairs(self.customItems) do
		if v.survivalShopItemMo.uid == itemMo.uid then
			v:refreshBagItem(itemMo)
		end
	end
end

function SurvivalReputationShopItem:initInternal(go, view)
	SurvivalReputationShopItem.super.initInternal(self, go, view)
end

function SurvivalReputationShopItem:updateMo(data, survivalReputationShopView)
	self.survivalReputationShopView = survivalReputationShopView
	self.viewContainer = data.viewContainer
	self.index = data.index
	self.posLevel = self.index
	self.survivalReputationPropMo = data.survivalReputationPropMo
	self.prop = self.survivalReputationPropMo.prop
	self.reputationLevel = self.prop.reputationLevel
	self.reputationCfg = SurvivalConfig.instance:getReputationCfgById(self.prop.reputationId, self.reputationLevel)
	self.reputationType = self.reputationCfg.type
	self.survivalShopMo = self.survivalReputationPropMo.survivalShopMo
	self.shopId = self.survivalShopMo.id
	self.shops = self.survivalShopMo:getReputationShopItemByGroupId(self.posLevel)
	self.isLock = self.survivalShopMo:isReputationShopLevelLock(self.posLevel)

	if data.isPlayLockAnim then
		gohelper.setActive(self.go_lock, true)
		self.lockPlayer:Play("close", self.onLockAnimEnd, self)
	else
		gohelper.setActive(self.go_lock, self.isLock)
	end

	local str = "survival_reputationshop_panel_" .. self.posLevel

	self.simage_panel:LoadImage(ResUrl.getSurvivalShopItemLevelIcon(str))
	self:refreshFreeItem()

	local listData = self.shops
	local customItemAmount = #self.customItems
	local listLength = #listData

	for i = 1, listLength do
		local survivalShopItemMo = listData[i]

		if customItemAmount < i then
			local obj = gohelper.clone(self.survivalreputationshopbagitem, self.goGoods)

			gohelper.setActive(obj, true)

			self.customItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalReputationShopBagItem)
		end

		local info = {
			viewContainer = self.viewContainer,
			survivalShopItemMo = survivalShopItemMo,
			onClickCallBack = self.onClickShopItem,
			onClickContext = self
		}

		self.customItems[i]:updateMo(info)
	end

	local path = string.format("survival_level_icon_%s", self.posLevel)

	UISpriteSetMgr.instance:setSurvivalSprite(self.image_level, path)
end

function SurvivalReputationShopItem:onLockAnimEnd()
	gohelper.setActive(self.go_lock, false)
end

function SurvivalReputationShopItem:onClickShopItem(survivalReputationShopBagItem)
	local isReceive = survivalReputationShopBagItem.survivalShopItemMo.count <= 0

	self.survivalReputationShopView:showInfoPanel(survivalReputationShopBagItem.survivalBagItem, survivalReputationShopBagItem.survivalShopItemMo, self.shopId, self.survivalShopMo.shopType, self.isLock or isReceive)
end

function SurvivalReputationShopItem:onClickFree()
	if not self.isLock and not self.isGainFreeReward then
		SurvivalWeekRpc.instance:sendSurvivalReputationRewardRequest(self.prop.reputationId, self.posLevel)
	elseif self.isLock or self.isGainFreeReward then
		self.survivalReputationShopView:showInfoPanel(self.freeSurvivalBagItem, self.freeItemMo, nil, nil, self.isLock)
	end
end

function SurvivalReputationShopItem:refreshFreeItem()
	self.isGainFreeReward = self.survivalReputationPropMo:isGainFreeReward(self.posLevel)
	self.freeItemMo = self.freeItemMo or SurvivalBagItemMo.New()

	if not self.freeSurvivalBagItem then
		local resPath = self.viewContainer:getSetting().otherRes.survivalmapbagitem
		local obj = self.viewContainer:getResInst(resPath, self.go_freeItem)

		self.freeSurvivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalBagItem)

		self.freeSurvivalBagItem:setClickCallback(self.onClickFree, self)
	end

	local freeReward = SurvivalConfig.instance:getShopFreeReward(self.prop.reputationId, self.posLevel)

	if freeReward then
		self.freeItemMo:init({
			id = freeReward[1],
			count = freeReward[2]
		})
		gohelper.setActive(self.freeSurvivalBagItem.go, true)
		self.freeSurvivalBagItem:updateMo(self.freeItemMo, {
			jumpAdd = true
		})
		self.freeSurvivalBagItem:setReputationShopStyle({
			isShowFreeReward = true,
			isCanGet = not self.isLock and not self.isGainFreeReward,
			isReceive = self.isGainFreeReward
		})
	else
		gohelper.setActive(self.freeSurvivalBagItem.go, false)
	end
end

return SurvivalReputationShopItem
