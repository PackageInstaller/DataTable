-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuobuygoodsView.lua

module("logic.extensions.flyingnuo.view.FlynuobuygoodsView", package.seeall)

local FlynuobuygoodsView = class("FlynuobuygoodsView", ViewComponent)

function FlynuobuygoodsView:ctor()
	FlynuobuygoodsView.super.ctor(self)
end

function FlynuobuygoodsView:buildUI()
	FlynuobuygoodsView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewBgIma/viewCloseBtn")

	local itemShowObj = self:getGo("viewBgIma/itemShowObj")
	local parentObj = goutil.findChild(itemShowObj, "cellItem")

	self.goodsNameTxt = goutil.findChild(parentObj, "goodsNameTxt"):GetComponent("Text")
	self.goodsDesTxt = goutil.findChild(parentObj, "goodsDesTxt"):GetComponent("Text")
	self.goodsExplainTxt = goutil.findChild(parentObj, "goodsExplainTxt"):GetComponent("Text")
	self.buyBtn = GameUtil.asBtn(goutil.findChild(parentObj, "useClickBtn"))
	self.goodsIconIma = goutil.findChild(parentObj, "goodsBgIma/goodsIconIma"):GetComponent("Image")
	self.useDesTxt = goutil.findChild(parentObj, "useClickBtn/useDesTxt"):GetComponent("Text")
end

function FlynuobuygoodsView:bindEvents()
	FlynuobuygoodsView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.buyBtn:AddClickListener(self._clickBuy, self)
end

function FlynuobuygoodsView:unbindEvents()
	FlynuobuygoodsView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.buyBtn:RemoveClickListener()
end

function FlynuobuygoodsView:destroyUI()
	FlynuobuygoodsView.super.destroyUI(self)
end

function FlynuobuygoodsView:onEnter()
	FlynuobuygoodsView.super.onEnter(self)
	GlobalDispatcher:addListener(FlyingNuoAgent.GetInfoRes, self._updateView, self)
	GlobalDispatcher:addListener(FlyingNuoAgent.BuyRes, self._updateView, self)
	self:_updateView()
end

function FlynuobuygoodsView:onEnterFinished()
	FlynuobuygoodsView.super.onEnterFinished(self)
end

function FlynuobuygoodsView:onExit()
	FlynuobuygoodsView.super.onExit(self)
	GlobalDispatcher:removeListener(FlyingNuoAgent.GetInfoRes, self._updateView, self)
	GlobalDispatcher:removeListener(FlyingNuoAgent.BuyRes, self._updateView, self)
	MaterialMgr.clearIcon(self.goodsIconIma)
end

function FlynuobuygoodsView:onExitFinished()
	FlynuobuygoodsView.super.onExitFinished(self)
end

function FlynuobuygoodsView:_clickBuy()
	if self._activityId and self._info then
		FlyingNuoAgent.instance:sendPM_BuyReq(self._activityId, 2)
	end
end

function FlynuobuygoodsView:_updateView()
	self._info = FlyNuoModel.instance:getActivityInfo()

	if not self._info then
		return
	end

	self._activityId = self:getFirstParam()

	local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
	local t = GameUtil.parseMatStr2Table(cfg.gameStartItem)
	local name = MaterialMgr.getMaterialsName(t[1], t[2])
	local matCfg = MaterialMgr.getMatCfg(t[1], t[2])
	local buyCfgs = FlyNuoConfig.instance:getBuyCfgByType(cfg.buyTimesPlan, 2)
	local buyCfg = FlyNuoConfig.instance:getBuyCfgByTime(cfg.buyTimesPlan, 2, self._info.todayGameStartItemBuyTimes + 1)

	MaterialMgr.setIcon(self.goodsIconIma, t[1], t[2])

	self.goodsExplainTxt.text = "每日限购：" .. self._info.todayGameStartItemBuyTimes .. "/" .. #buyCfgs
	self.goodsNameTxt.text = name
	self.goodsDesTxt.text = matCfg.desc
	self.useDesTxt.text = buyCfg and MaterialFacade.instance:getGoodCostByStr(buyCfg.consume) or ""

	goutil.setActive(self.buyBtn.gameObject, buyCfg)
end

return FlynuobuygoodsView
