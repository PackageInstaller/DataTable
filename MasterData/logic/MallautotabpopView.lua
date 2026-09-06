-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/MallautotabpopView.lua

module("logic.extensions.activitypopup.view.MallautotabpopView", package.seeall)

local MallautotabpopView = class("MallautotabpopView", ViewComponent)

function MallautotabpopView:ctor()
	MallautotabpopView.super.ctor(self)
end

function MallautotabpopView:buildUI()
	MallautotabpopView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnShop = self:getGo("btnShop")
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("tablecell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._tableview = self.tableview:GetComponent("UITableGrid")
	self._bottomBtns = {}
	self._bottomBtnsChange = {}
	self._bottomBtnsDot = {}

	local bottomBtnRoot = self:getGo("bottomBtns/tableview/Viewport/Content")

	for i = 1, bottomBtnRoot.transform.childCount do
		local btn = self:getGo("bottomBtns/tableview/Viewport/Content/btn_" .. i)

		GameUtil.SetActive(btn, false)

		self._bottomBtns[i] = btn
		self._bottomBtnsDot[i] = goutil.findChild(btn.gameObject, "dot")
		self._bottomBtnsChange[i] = btn.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	end

	GameUtil.SetActive(self.btnShop, false)
end

function MallautotabpopView:bindEvents()
	MallautotabpopView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnShop, self.onShopClick, self)

	for i, btn in ipairs(self._bottomBtns) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self.onClickTab, self, i))
	end
end

function MallautotabpopView:unbindEvents()
	MallautotabpopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnShop)

	for i, btn in ipairs(self._bottomBtns) do
		GameUtil.rmClickHandler(btn)
	end
end

function MallautotabpopView:destroyUI()
	MallautotabpopView.super.destroyUI(self)
end

function MallautotabpopView:onEnter()
	MallautotabpopView.super.onEnter(self)

	self.tabIdx = 0

	for i, v in ipairs(self._bottomBtns) do
		GameUtil.SetActive(v, false)
	end

	self.allListMap, self.tabs = ActivityPopupModel.instance:getAutoTabMallCfgs()

	if #self.tabs > 0 then
		for i, v in ipairs(self.tabs) do
			GameUtil.SetActive(self._bottomBtns[v], true)
		end

		self:onClickTab(self.tabs[1])
	else
		self:close()
	end
end

function MallautotabpopView:onClickTab(idx)
	self.tabIdx = idx

	for typeId, v in pairs(self._bottomBtnsChange) do
		v:SetState(typeId == idx and 1 or 0)
	end

	self:updateCurrTab(self.tabIdx)
end

function MallautotabpopView:getSellKey()
	if self.tabIdx == 8 then
		return GameEnum.PayShopTabSellType.SellPet
	elseif self.tabIdx == 9 then
		return GameEnum.PayShopTabSellType.SellSkin
	else
		return nil
	end
end

function MallautotabpopView:updateCurrTab(idx)
	local list = self.allListMap[idx]

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
						goodsData = obj,
						sellKey = self:getSellKey()
					})
				end
			end
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
		self:_setCellOffset()
		self.scrollList:reloadData(datas)
		self.scrollList:MoveCellInView(0)
		GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
		GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
	else
		self.scrollList:reloadData({})
	end
end

function MallautotabpopView:onEnterFinished()
	MallautotabpopView.super.onEnterFinished(self)
end

function MallautotabpopView:onExit()
	MallautotabpopView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
end

function MallautotabpopView:onExitFinished()
	MallautotabpopView.super.onExitFinished(self)
end

function MallautotabpopView:_payResultRes(status, msg)
	if status == 0 then
		local goodsId = msg.subGoodsId
		local payCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

		if payCfg then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.SHOP_POPUP_BUY, payCfg.name)
		end

		self:updateGoodsView()
	end
end

function MallautotabpopView:updateGoodsView()
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
	self:_setCellOffset()
	self.scrollList:refresh(datas)
end

function MallautotabpopView:_setCellOffset()
	self._tableview.gridWidth = 234
	self._tableview.gridHeight = 296
	self._tableview.numRowsOrCols = 3
end

function MallautotabpopView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onEnter(self, self._scrollRect, data)
end

function MallautotabpopView:clearCell(cell, tag)
	local component = GameUtil.GetLua(cell.gameObject, PayShopMibaoGoodsItem)

	if component then
		component:onExit()
	end
end

function MallautotabpopView:onShopClick()
	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.MibaoShop)
	self:close()
end

return MallautotabpopView
