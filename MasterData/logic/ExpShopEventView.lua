-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpShopEventView.lua

module("logic.extensions.expedition.view.ExpShopEventView", package.seeall)

local ExpShopEventView = class("ExpShopEventView", ViewComponent)

function ExpShopEventView:unbindEvents()
	ExpShopEventView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function ExpShopEventView:bindEvents()
	ExpShopEventView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnGet:AddClickListener(self._onClickGiveup, self)
end

function ExpShopEventView:buildUI()
	ExpShopEventView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnGet = self:getBtn("btnGet")
	self._mapRoot = self:getGo("cellRoot")
	self._cloneGrid = self:getGo("cellRoot/cell")

	self._cloneGrid:SetActive(false)

	self._gridPool = {}
	self._gridList = {}
	self._gridHeight = GameUtil.getHeight(self._cloneGrid)
	self._gridWidth = GameUtil.getWidth(self._cloneGrid)
	self._gridGap = 30
end

function ExpShopEventView:onEnter()
	ExpShopEventView.super.onEnter(self)

	self._selectDatas = self._viewPresentor._openParam[1]
	self._canGet = self._viewPresentor._openParam[2]
	self._isSweep = self._viewPresentor._openParam[3] or false

	self._closeButton.gameObject:SetActive(not self._isSweep)
	self:_updateDataByIndex(1)
	GlobalDispatcher:addListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
	GlobalDispatcher:addListener(ExpeditionAgent.PM_ExpeditionDoEventOverRes, self._onExpeditionDoEventOverRes, self)
end

function ExpShopEventView:onExit()
	ExpShopEventView.super.onExit(self)

	self._selectDatas = nil
	self._canGet = nil
	self._isSweep = nil
	self._data = nil

	GlobalDispatcher:removeListener(ExpeditionAgent.PM_ExpeditionDoEventOverRes, self._onExpeditionDoEventOverRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
end

function ExpShopEventView:_updateDataByIndex(index)
	self._currDataIndex = index
	self._data = self._selectDatas[index]
	self._itemIdList = self._data.eventInfo.em
	self._hasBuyList = self._data.eventInfo.gs
	self._isReqing = false

	self:_setupCards(nil)
	self:_updateBtnState()
end

function ExpShopEventView:_updateBtnState()
	self._btnGet.gameObject:SetActive(self._canGet)
end

function ExpShopEventView:_setupCards()
	self:_recyleAllGrids()

	local len = #self._itemIdList

	for i = 1, len do
		local grid = self:_getOneGrid()
		local index = i
		local cfg = ExpeditionConfig.instance:getShopCfg(self._itemIdList[i])
		local hasDiscount = cfg.discount > 0

		grid.txtName.text = cfg.name

		grid.goDiscount:SetActive(hasDiscount)

		grid.txtDiscount.text = langPara("%d折", cfg.discount)

		MaterialMgr.setCellByCfg(cfg.content, grid.itemRoot)

		grid.txtPrice.text = cfg.price

		grid.gold:SetActive(cfg.costType == 1)
		grid.diamond:SetActive(cfg.costType >= 2)
		grid.btn:RemoveClickListener()

		if self._canGet then
			GameUtil.SetGray(grid.btn.gameObject, not self._canGet)
			grid.goHasBuy:SetActive(self._hasBuyList[index])

			if self._canGet then
				grid.btn:AddClickListener(function()
					self:_onClickBuy(index)
				end, self)
			end

			GameUtil.setLocalPos(grid.go, (i - 1) * (self._gridWidth + self._gridGap), 0, 0)

			local matType, id = MaterialMgr.getMatParams(cfg.costItem)

			MaterialMgr.setIcon(grid.diamond, matType, id)
		end
	end
end

function ExpShopEventView:_onClickBuy(index)
	if self._isReqing then
		return
	end

	local id = self._itemIdList[index]
	local cfg = ExpeditionConfig.instance:getShopCfg(id)
	local costItem = cfg.costItem
	local mattype, id, cost = MaterialMgr.getMatParams(costItem)
	local matName = MaterialMgr.getMaterialsName(mattype, id)
	local content = langPara("花费%s%s,购买%s吗？", cost, matName, cfg.name)

	TipsFacade.instance:openPopupCostMatViewNew(mattype, id, cost, content, function()
		self:_doBuy(index)
	end)
end

function ExpShopEventView:_doBuy(index)
	if self._isReqing then
		return
	end

	self:_sendMsg(self._itemIdList[index])
end

function ExpShopEventView:_onClickGiveup()
	if self._isReqing then
		return
	end

	self._btnGet.gameObject:SetActive(false)
	self:_sendMsg(-1)
end

function ExpShopEventView:_sendMsg(selectedId)
	self._isReqing = true
	self._lastSelectIndex = selectedId

	local param = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	param.selectedId = selectedId
	param.replacedId = 0
	param.revertFight = false

	if not self._isSweep then
		ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(self._data.eventIndex, param)
	else
		ExpeditionAgent.instance:sendPM_ExpeditionDoSweepEventReq(self._data.eventIndex, param)
	end
end

function ExpShopEventView:_onExpeditionDoEventOverRes(status, msg)
	self._isReqing = false

	if status == 0 then
		if self._lastSelectIndex == -1 then
			self:close()

			return
		end

		if self:_onBuyGoodsBack() then
			self:close()
		end
	else
		self:_updateBtnState()
	end
end

function ExpShopEventView:_onBuyGoodsBack()
	self._hasBuyList[self._lastSelectIndex] = true

	self:_setupCards()
	self:_updateBtnState()

	for k, v in ipairs(self._hasBuyList) do
		if not v then
			return true
		end
	end
end

function ExpShopEventView:_onSweepSelEventBack(newGridData)
	if self:_onBuyGoodsBack() then
		local currDataIndex = self._currDataIndex + 1

		if currDataIndex <= #self._selectDatas then
			self:_updateDataByIndex(currDataIndex)
		else
			self:close()
			ExpeditionController.instance:checkSweepEvents()
		end
	end
end

function ExpShopEventView:_onClickClose()
	if self._isReqing then
		return
	end

	self:close()
end

function ExpShopEventView:_getOneGrid()
	local len = #self._gridPool
	local grid

	if len > 0 then
		grid = self._gridPool[len]
		self._gridPool[len] = nil
	else
		grid = {}

		local gridGo = goutil.cloneAndSetParent(self._cloneGrid, self._mapRoot.transform)

		grid.go = gridGo
		grid.goDiscount = goutil.findChild(gridGo, "discount")
		grid.txtDiscount = goutil.findChildTextComponent(gridGo, "discount/txtDiscount")
		grid.txtName = goutil.findChildTextComponent(gridGo, "txtName")
		grid.btn = Framework.ButtonAdapter.GetFrom(gridGo, "btnBuy")
		grid.txtPrice = goutil.findChildTextComponent(gridGo, "txtPrice")
		grid.itemRoot = goutil.findChild(gridGo, "item")
		grid.gold = goutil.findChild(gridGo, "gold")
		grid.diamond = goutil.findChild(gridGo, "diamond")
		grid.goHasBuy = goutil.findChild(gridGo, "hasbuy")
	end

	grid.go:SetActive(true)
	table.insert(self._gridList, grid)

	return grid
end

function ExpShopEventView:_recyleAllGrids()
	for i = 1, #self._gridList do
		local grid = self._gridList[i]

		grid.go:SetActive(false)
		table.insert(self._gridPool, grid)
	end

	self._gridList = {}
end

return ExpShopEventView
