-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/MallautopopView.lua

module("logic.extensions.activitypopup.view.MallautopopView", package.seeall)

local MallautopopView = class("MallautopopView", ViewComponent)

function MallautopopView:ctor()
	MallautopopView.super.ctor(self)
end

function MallautopopView:buildUI()
	MallautopopView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnShop = self:getGo("btnShop")
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.cellMap = {}

	GameUtil.SetActive(self.btnShop, false)
end

function MallautopopView:bindEvents()
	MallautopopView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnShop, self.onShopClick, self)
end

function MallautopopView:unbindEvents()
	MallautopopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnShop)
end

function MallautopopView:destroyUI()
	MallautopopView.super.destroyUI(self)
end

function MallautopopView:onEnter()
	MallautopopView.super.onEnter(self)

	local list = ActivityPopupModel.instance:getAutoMallCfgs(1)

	if #list > 0 then
		local datas = {}
		local allShowOut = true

		for i, cfg in ipairs(list) do
			local obj = {}

			obj.id = cfg.id
			obj.index = i
			obj.times = PayShopModel.instance:getMibaoBuyTimesById(cfg.id)

			local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(obj.id)

			if goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 then
				if obj.times then
					local isSellOut = obj.times >= goodsCfg.limitTimes

					if not isSellOut then
						allShowOut = false
					end

					table.insert(datas, {
						goodsData = obj
					})
				end
			end
		end

		if not allShowOut then
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
			GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
			GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
		else
			self:close()
		end
	else
		self:close()
	end
end

function MallautopopView:onEnterFinished()
	MallautopopView.super.onEnterFinished(self)
end

function MallautopopView:onExit()
	MallautopopView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
end

function MallautopopView:onExitFinished()
	MallautopopView.super.onExitFinished(self)
end

function MallautopopView:_payResultRes(status, msg)
	if status == 0 then
		local goodsId = msg.subGoodsId
		local payCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

		if payCfg then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.SHOP_POPUP_BUY, payCfg.name)
		end

		self:updateGoodsView()
	end
end

function MallautopopView:updateGoodsView()
	local datas = self.scrollList:getData()

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
	self.scrollList:refresh(datas)
end

function MallautopopView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onEnter(self, self._scrollRect, data)
end

function MallautopopView:clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onExit()
end

function MallautopopView:onShopClick()
	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.MibaoShop)
	self:close()
end

return MallautopopView
