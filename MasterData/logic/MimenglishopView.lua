-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglishopView.lua

module("logic.extensions.mimengli.view.MimenglishopView", package.seeall)

local MimenglishopView = class("MimenglishopView", ViewComponent)

function MimenglishopView:ctor()
	MimenglishopView.super.ctor(self)
end

function MimenglishopView:unbindEvents()
	MimenglishopView.super.unbindEvents(self)
end

function MimenglishopView:bindEvents()
	MimenglishopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReset, self._onClickSkip, self)
end

function MimenglishopView:buildUI()
	MimenglishopView.super.buildUI(self)

	self._btnReset = self:getGo("btnReset")
	self._txtTip = self:getTxt("bubble/txtTip")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MimenglishopView:onExit()
	MimenglishopView.super.onExit(self)
	self._scrollList:dispose()
end

function MimenglishopView:onEnter()
	MimenglishopView.super.onEnter(self)

	self._activityId = MiMengLiController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	local param = self:getOpenParam() or {}

	self._stageId = checknumber(param[2])

	self.addGEvent(self, GlobalNotify.MiMengLi_Clg_Info_Update, self._onRefreshUI, self)
	self:_onRefreshUI()
end

function MimenglishopView:_onRefreshUI()
	self._actCfg = MiMengLiConfig.instance:getActivityCfgById(self._activityId) or {}

	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		self._curPassStageId = checknumber(clgInfo.curPassStageId)
		self._shopDiscountFromStageId = checknumber(clgInfo.shopDiscountFromStageId)
		self._hasGainBossBuff = checkbool(clgInfo.hasGainBossBuff)
		self._immunityTagType = clgInfo.immunityTagType or {}
		self._isDiscount = self._shopDiscountFromStageId > 0 and self._shopDiscountFromStageId < checknumber(clgInfo.curPassStageId)
		self._txtTip.text = "在这摆摊可不安全，价格贵一点也不能怪我嘛"

		if self._isDiscount then
			self._txtTip.text = "<color=#eb4642>本商店的商品已获得折扣，快来挑选吧</color>"
		end

		GameUtil.SetActive(self._btnReset, self._curPassStageId + 1 == self._stageId)

		local cfg = MiMengLiConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}
		local shopId = checknumber(cfg.shopId)
		local list = MiMengLiConfig.instance:getShopGoodsCfgById(self._activityId, shopId) or {}

		self._scrollList:reloadData(list)
	end
end

function MimenglishopView:_updateCell(view, cell, data, tag)
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local txtprice = goutil.findChildTextComponent(cell, "txtprice")
	local line = goutil.findChild(cell, "txtprice/line")
	local icon = goutil.findChild(cell, "txtprice/icon")
	local discountNeedGo = goutil.findChild(cell, "txtprice/discountNeedGo")
	local discountNeedTxt = goutil.findChildTextComponent(cell, "txtprice/discountNeedGo/discountNeedTxt")
	local hasBuy = goutil.findChild(cell, "hasBuy")
	local iconGo = goutil.findChild(cell, "item")
	local btn = goutil.findChild(cell, "btn")

	GameUtil.SetActive(hasBuy, false)
	GameUtil.SetActive(line, false)
	GameUtil.SetActive(discountNeedGo, false)

	txtLimit.text = ""

	if self._isDiscount then
		GameUtil.SetActive(line, true)
		GameUtil.SetActive(discountNeedGo, true)
	end

	local isHasBuy = false

	if data.goodsUsedClazz == "GainShopDiscount" then
		isHasBuy = self._shopDiscountFromStageId > 0
	elseif data.goodsUsedClazz == "ImmunityTagBuff" then
		isHasBuy = table.indexof(self._immunityTagType, checknumber(data.goodsUsedClazzParams)) ~= false
	elseif data.goodsUsedClazz == "GainBossBuff" then
		isHasBuy = self._hasGainBossBuff
	end

	GameUtil.SetActive(hasBuy, isHasBuy)

	txtprice.text = data.costScore
	discountNeedTxt.text = data.discountCostScore
	txtLimit.text = data.desc

	GameUtil.SetGray(cell, false)

	if self._curPassStageId + 1 ~= self._stageId then
		GameUtil.SetGray(cell, true)
	end

	local fakeItemID = self._actCfg.fakeItemID

	MaterialMgr.setIcon(icon, MatType.Item_Fake, fakeItemID)
	uGuiUtil.clearImage(iconGo)

	local path = data.iconPath

	if not string.nilorempty(path) then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/%s.png", path)

		uGuiUtil.setSpriteToImage(iconGo, spriteType, spriteName)
	end

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickItem, self, data, isHasBuy))
end

function MimenglishopView:_clearCell(cell)
	local icon = goutil.findChild(cell, "txtprice/icon")
	local iconGo = goutil.findChild(cell, "item")

	uGuiUtil.clearImage(iconGo)
	MaterialMgr.clearIcon(icon)
end

function MimenglishopView:_onClickSkip()
	local content = "确认要放弃购买进入下一关吗？"

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		MiMengLiController.instance:sendBuyShopGoods(self._activityId, true)
	end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function MimenglishopView:_onClickItem(data, isHasBuy)
	if self._curPassStageId + 1 ~= self._stageId then
		TipsFacade.instance:openCommonTips("当前关卡暂时不可以购买")

		return
	end

	if isHasBuy then
		TipsFacade.instance:openCommonTips("已售罄")

		return
	end

	if data.goodsUsedClazz == "DeadPetFullHp" then
		UIStateManager.instance:push(ViewName.MimenglipetuseView, data)
	elseif data.goodsUsedClazz == "PetFullHp" then
		UIStateManager.instance:push(ViewName.MimenglipetuseView, data)
	elseif data.goodsUsedClazz == "ChangeTagNum" then
		UIStateManager.instance:push(ViewName.MimenglibuffchangeView, data)
	else
		local fakeItemID = self._actCfg.fakeItemID
		local content = langPara("确认要购买此物品吗？\n效果：%s\n\n<color=#eb4642>***购买后立即使用***</color>", data.desc)

		TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, fakeItemID, (self._isDiscount or nil) and data.discountCostScore, content, function()
			MiMengLiController.instance:sendBuyShopGoods(self._activityId, false, data.goodsId)
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

return MimenglishopView
