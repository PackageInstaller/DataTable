-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/LongNvIconCell.lua

module("logic.extensions.directpurchase.view.LongNvIconCell", package.seeall)

local LongNvIconCell = class("LongNvIconCell", LongNvCellBase)

function LongNvIconCell:ctor()
	return
end

function LongNvIconCell:buildUI(go)
	LongNvIconCell.super.buildUI(self, go)

	self._imgIcon = goutil.findChild(go, "goods/img")
end

function LongNvIconCell:init(id, activityId)
	LongNvIconCell.super.init(self, id, activityId)
	self:_showView(nil)
end

function LongNvIconCell:onExit()
	self:_removeIcon()
end

function LongNvIconCell:_showView(petId)
	self._petId = petId

	local shopItemId, desc = self:_getShopItemId(self._activityId, self._id, self._petId)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopItemId)

	self._goodsId = shopItemId

	local maxBuyCount = goodsCfg.limitTimes
	local curBuyCount = PayShopModel.instance:getMibaoBuyTimesById(self._goodsId)

	self._txtPrice.text = curBuyCount < maxBuyCount and PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId) .. "元" or "已售罄"

	self:_loadIcon(goodsCfg.content)
	self:_setTxtLimit(curBuyCount, maxBuyCount)
	self:_setBtnGray(maxBuyCount <= curBuyCount)
	self:_setTxtTitle(desc)
end

function LongNvIconCell:_isHasBuyCount()
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsId)

	if goodsCfg then
		local maxBuyCount = goodsCfg.limitTimes
		local curBuyCount = PayShopModel.instance:getMibaoBuyTimesById(self._goodsId)

		return curBuyCount < maxBuyCount
	end

	return true
end

function LongNvIconCell:_onClickBuy()
	if not self:_isHasBuyCount() then
		self:_showTip()

		return
	end

	local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(self._goodsId)
	local data = {
		id = self._goodsId,
		times = buyTimes
	}

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
end

function LongNvIconCell:_loadIcon(itemStrs)
	self:_removeIcon()

	if not string.nilorempty(itemStrs) then
		local list = string.split(itemStrs, "#")

		if list[1] then
			MaterialMgr.setCellByCfg(list[1], self._imgIcon)
		end
	end
end

function LongNvIconCell:_removeIcon()
	MaterialMgr.resetAll(self._imgIcon)
end

function LongNvIconCell:update()
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsId)

	if goodsCfg then
		local maxBuyCount = goodsCfg.limitTimes
		local curBuyCount = PayShopModel.instance:getMibaoBuyTimesById(self._goodsId)

		self._txtPrice.text = curBuyCount < maxBuyCount and PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId) .. "元" or "已售罄"

		self:_setTxtLimit(curBuyCount, maxBuyCount)
		self:_setBtnGray(maxBuyCount <= curBuyCount)
	end
end

function LongNvIconCell:_setTxtTitle(desc)
	self._txtTitle.text = desc
end

function LongNvIconCell:setPetInfo(petId)
	self:_showView(petId)
end

return LongNvIconCell
