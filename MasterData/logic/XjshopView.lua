-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjshopView.lua

module("logic.extensions.xingjiang.view.XjshopView", package.seeall)

local XjshopView = class("XjshopView", ViewComponent)

function XjshopView:ctor()
	XjshopView.super.ctor(self)
end

function XjshopView:buildUI()
	XjshopView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnShop = self:getGo("btnShop")
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.cellMap = {}

	GameUtil.SetActive(self.btnShop, false)
end

function XjshopView:bindEvents()
	XjshopView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnShop, self.onShopClick, self)
end

function XjshopView:unbindEvents()
	XjshopView.super.unbindEvents(self)
end

function XjshopView:destroyUI()
	XjshopView.super.destroyUI(self)
end

function XjshopView:onEnter()
	XjshopView.super.onEnter(self)

	self.curActId = 126001
	self.listCfg = ActivityPopupModel.instance:getAutoMallCfgs(self.curActId)

	if #self.listCfg == 0 then
		return
	end

	GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
	self:updateGoodsView()
end

function XjshopView:onEnterFinished()
	XjshopView.super.onEnterFinished(self)
end

function XjshopView:onExit()
	XjshopView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
end

function XjshopView:onExitFinished()
	XjshopView.super.onExitFinished(self)
end

function XjshopView:_payResultRes(status, msg)
	if status == 0 then
		local goodsId = msg.subGoodsId
		local payCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

		if payCfg then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.SHOP_POPUP_BUY, payCfg.name)
		end

		self:updateGoodsView()
	end
end

function XjshopView:updateGoodsView()
	local datas = {}

	for i, cfg in ipairs(self.listCfg) do
		local obj = {}

		obj.id = cfg.id
		obj.index = i
		obj.times = PayShopModel.instance:getMibaoBuyTimesById(cfg.id)

		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(obj.id)

		table.insert(datas, {
			goodsData = obj
		})
	end

	ArraySort.sortOn(datas, {
		function(obj)
			local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(obj.goodsData.id)

			if goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 then
				if obj.goodsData.times then
					local isSellOut = obj.goodsData.times >= goodsCfg.limitTimes

					if isSellOut then
						return 1
					else
						return 0
					end
				end
			end
		end,
		"index"
	})
	self.scrollList:reloadData(datas)
	self.scrollList:refresh()
end

function XjshopView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onEnter(self, self._scrollRect, data)
end

function XjshopView:clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onExit()
end

function XjshopView:onShopClick()
	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.MibaoShop)
	self:close()
end

return XjshopView
