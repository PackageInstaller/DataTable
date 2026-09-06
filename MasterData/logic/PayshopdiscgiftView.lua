-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopdiscgiftView.lua

module("logic.extensions.payshop.view.PayshopdiscgiftView", package.seeall)

local PayshopdiscgiftView = class("PayshopdiscgiftView", TableViewComponent)
local json = require("cjson")

function PayshopdiscgiftView:ctor()
	PayshopdiscgiftView.super.ctor(self)
end

function PayshopdiscgiftView:unbindEvents()
	PayshopdiscgiftView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
end

function PayshopdiscgiftView:bindEvents()
	PayshopdiscgiftView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function PayshopdiscgiftView:buildUI()
	PayshopdiscgiftView.super.buildUI(self)

	self._btnGet = self:getBtn("btnGet")
	self._txtBtnGet = goutil.findChildTextComponent(self.mainGO, "btnGet/txtBtnGet")
end

function PayshopdiscgiftView:onExit()
	PayshopdiscgiftView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.GainDiscountGiftRes, self._updateView, self)
	GlobalDispatcher:removeListener(PayShopController.OneKeyGainDiscountGiftRes, self._updateView, self)
end

function PayshopdiscgiftView:onEnter()
	PayshopdiscgiftView.super.onEnter(self)

	local activityType = GameEnum.ActivityType.PAY_SHOP_DISCOUNT_GIFT
	local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

	if not acfg then
		self:close()

		return
	end

	GlobalDispatcher:addListener(PayShopController.GainDiscountGiftRes, self._updateView, self)
	GlobalDispatcher:addListener(PayShopController.OneKeyGainDiscountGiftRes, self._updateView, self)

	self._activityId = acfg.activityId
	self._curViewDatas = PayShopConfig.instance:getDiscountGiftCfgs(self._activityId)

	self:_updateView()
end

function PayshopdiscgiftView:_onClickbtnGet()
	local isAllGet = PayShopModel.instance:isGetAllDiscountGift(self._activityId)

	if isAllGet then
		PayShopController.instance:openShopByJumpPageConfig(6)
		self:close()
	else
		PayShopAgent.instance:sendOneKeyGainDiscountGiftReq(self._activityId)
	end
end

function PayshopdiscgiftView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PayshopdiscgiftView:_updateCell(view, cell, cfg)
	local btnOpen = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnOpen")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goReceive = goutil.findChild(cell.gameObject, "receive")

	txtName.text = cfg.name

	local isGain = PayShopModel.instance:isGainDiscountGift(cfg.giftId)

	goutil.setActive(btnOpen.gameObject, not isGain)
	goutil.setActive(goReceive, isGain)
	btnOpen:AddClickListener(function()
		PayShopAgent.instance:sendGainDiscountGiftReq(self._activityId, cfg.giftId)
	end)
end

function PayshopdiscgiftView:_clearTableview(cell)
	return
end

function PayshopdiscgiftView:_updateView()
	self:reloadData()
	self:_setBtnState()
end

function PayshopdiscgiftView:_setBtnState()
	local isAllGet = PayShopModel.instance:isGetAllDiscountGift(self._activityId)

	self._txtBtnGet.text = isAllGet and "去购买" or "全部领取"
end

return PayshopdiscgiftView
