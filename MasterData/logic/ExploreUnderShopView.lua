-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderShopView.lua

module("logic.extensions.exploreunder.view.ExploreUnderShopView", package.seeall)

local ExploreUnderShopView = class("ExploreUnderShopView", ViewComponent)

function ExploreUnderShopView:buildUI()
	ExploreUnderShopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGiveUp = self:getGo("btnGiveUp")
	self._goodCells = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("goodCells/cell_" .. i)
		cell.item = goutil.findChild(cell.go, "item")
		cell.iconCost = goutil.findChild(cell.go, "cost/txt/icon")
		cell.txtCost = goutil.findChildTextComponent(cell.go, "cost/txt")
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.txtDiscount = goutil.findChildTextComponent(cell.go, "discount/txt")
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txtBtn = goutil.findChildTextComponent(cell.btn, "Text")
		cell.isHasBuy = false
		cell.costType = 0
		cell.costId = 0
		cell.costNum = 0
		cell.matNum = 0
		self._goodCells[i] = cell
	end
end

function ExploreUnderShopView:bindEvents()
	ExploreUnderShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGiveUp, self._onClickGiveUp, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._goodCells[i].btn, GameUtil.handler(self._onClickBuyGood, self, i))
	end
end

function ExploreUnderShopView:unbindEvents()
	ExploreUnderShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGiveUp)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._goodCells[i].btn)
	end
end

function ExploreUnderShopView:onEnter()
	ExploreUnderShopView.super.onEnter(self)

	if self:_onHandle() then
		return
	end

	local eventPamam = checkint(self._curEventInfo.eventParm)
	local cfgs = ExploreUnderConfig.instance:getItemCfgs(eventPamam) or {}

	for i = 1, 3 do
		local cfg = cfgs[i]
		local cell = self._goodCells[i]

		if cfg then
			goutil.setActive(cell.go, true)

			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.content or "")

			MaterialMgr.setCellByCfg(cfg.content, cell.item)

			cell.matNum = matNum
			cell.txtName.text = MaterialMgr.getMaterialsName(matType, matId)
			cell.costType, cell.costId, cell.costNum = MaterialMgr.getMatParams(cfg.price or "")

			MaterialMgr.setIcon(cell.iconCost, cell.costType, cell.costId)

			cell.txtCost.text = cell.costNum
			cell.txtDiscount.text = langPara("%s折", cfg.discount)
		else
			goutil.setActive(cell.go, false)
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderEventInfoChange, self._onHandle, self)
end

function ExploreUnderShopView:onExit()
	ExploreUnderShopView.super.onExit(self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._goodCells[i].item)
		MaterialMgr.resetAll(self._goodCells[i].iconCost)
	end

	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderEventInfoChange, self._onHandle, self)
end

function ExploreUnderShopView:_onClickGiveUp()
	if table.nums(self._params) >= 3 then
		ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.giveUpBuy)
	else
		local text = langPara("您真的要放弃这些超值商品吗？")

		TipsFacade.instance:openPopupWindow(langPara("温馨提示"), text, function()
			ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.giveUpBuy)
		end)
	end
end

function ExploreUnderShopView:_onClickBuyGood(id)
	local cell = self._goodCells[id]

	if cell and not cell.isHasBuy then
		local costName = MaterialMgr.getMaterialsName(cell.costType, cell.costId)
		local content = langPara("确认消耗%s*%s购买%s*%s？", costName, cell.costNum, cell.txtName.text, cell.matNum)

		TipsFacade.instance:openPopupCostMatViewNew(cell.costType, cell.costId, cell.costNum, content, function()
			ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.buyItem, {
				{
					value = tostring(id),
					key = ExploreUnderModel.EventExtraParamKey.itemId
				}
			})
		end)
	end
end

function ExploreUnderShopView:_onHandle()
	self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

	local curEventState = ExploreUnderModel.instance:getCurEventState()

	if self._curEventInfo.eventType ~= 4 or curEventState ~= ExploreUnderEnum.EventState_Orgin then
		self:close()

		return true
	end

	ExploreUnderModel.instance:ShowCI()

	local param = ExploreUnderModel.instance:getCurEventData()

	self._params = {}

	if checkint(param) > 0 then
		table.insert(self._params, checkint(param))
	else
		local params = string.split(param, ",")

		for k, v in pairs(params) do
			table.insert(self._params, checkint(v))
		end
	end

	for i = 1, 3 do
		local cell = self._goodCells[i]

		cell.isHasBuy = table.keyof(self._params, i)

		GameUtil.SetGray(cell.btn, cell.isHasBuy)

		cell.txtBtn.text = cell.isHasBuy and lang("已购买") or lang("购买")
	end
end

return ExploreUnderShopView
