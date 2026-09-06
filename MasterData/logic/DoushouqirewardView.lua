-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqirewardView.lua

module("logic.extensions.doushouqi.view.DoushouqirewardView", package.seeall)

local DoushouqirewardView = class("DoushouqirewardView", ViewComponent)

function DoushouqirewardView:ctor()
	DoushouqirewardView.super.ctor(self)
end

function DoushouqirewardView:unbindEvents()
	DoushouqirewardView.super.unbindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end

	self._btnClose:RemoveClickListener()
end

function DoushouqirewardView:bindEvents()
	DoushouqirewardView.super.bindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end

	self._btnClose:AddClickListener(self.close, self)
end

function DoushouqirewardView:buildUI()
	DoushouqirewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("tablecell")
	local tableviewGo = self:getGo("tableview")

	self._scrollrect = tableviewGo:GetComponent("ScrollRect")
	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._switchBtns = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i .. "/btn")
		cell.change = cell.go:GetComponent("UIChangeGroup")
		cell.redpoint = self:getGo("switchBtns/btn_" .. i .. "/btn/redpoint")
		self._switchBtns[i] = cell

		goutil.setActive(cell.redpoint, false)
	end

	self._txtScore = self:getTxt("txtScore")
end

function DoushouqirewardView:onExit()
	DoushouqirewardView.super.onExit(self)
	self._tableview:dispose()
end

function DoushouqirewardView:onEnter()
	DoushouqirewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessGainPrizeRes, self._onBeastFightingChessGainPrizeRes, self)

	self._cellPool = {}
	self._activityId = self:getFirstParam()
	self._curSwitchId = nil

	self:_onSwitchList(1)
	self:_checkRedpoint()
end

function DoushouqirewardView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)
	local btn = Framework.ButtonAdapter.GetFrom(cellGo.gameObject, "btnGain")
	local goReceive = goutil.findChild(cellGo, "receive")
	local isGain = DoushouqiModel.instance:isGainPrize(self._activityId, self._curSwitchId, data.prizeId)
	local isCanGain = not isGain and DoushouqiModel.instance:isCanGainPrize(self._activityId, self._curSwitchId, data.prizeId)

	goutil.setActive(goReceive, isGain)
	goutil.setActive(btn.gameObject, not isGain and isCanGain)

	cell.txtTitle.text = string.format("累计获得积分达到\n%s", data.needScore)

	local prize = data.prize
	local itemList = string.split(prize, "#")

	cell.tableview:reloadData(itemList)
	cell.tableview:MoveCellToBegin(0)
	cell.drag:AddDragListener(self._onDrag, self)
	cell.drag:AddBeginDragListener(self._onBeginDrag, self)
	cell.drag:AddEndDragListener(self._onEndDrag, self)
	btn:AddClickListener(function()
		BeastFightingChessAgent.instance:sendBeastFightingChessGainPrizeReq(self._activityId, self._curSwitchId, data.prizeId)
	end)
end

function DoushouqirewardView:_clearCell(cellGo)
	local cell = self._cellPool[cellGo]

	if cell == nil then
		cell = {
			go = cellGo
		}
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
		cell.prizeCom = goutil.findChild(cell.go, "prizeCom")
		cell.prizecell = goutil.findChild(cell.go, "prizecell")
		cell.tableview = ScrollerList.create(cell.prizeCom, cell.prizecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		cell.drag = Framework.UIDragTrigger.Get(cell.prizeCom)
		self._cellPool[cellGo] = cell
	end

	cell.tableview:dispose()
	MaterialMgr.resetAll(cell.prizeCom)
	cell.drag:RemoveDragListener()
	cell.drag:RemoveBeginDragListener()
	cell.drag:RemoveEndDragListener()

	return cell
end

function DoushouqirewardView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function DoushouqirewardView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function DoushouqirewardView:_onEndDrag(eventData)
	self._scrollrect:OnEndDrag(eventData)
end

function DoushouqirewardView:_updateItemCell(view, cellGo, data)
	local proxy = MaterialMgr.setCellByCfg(data, cellGo)
end

function DoushouqirewardView:_clearItemCell(cellGo)
	MaterialMgr.resetAll(cellGo)
end

function DoushouqirewardView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		for i = 1, #self._switchBtns do
			local cell = self._switchBtns[i]

			cell.change:SetState(self._curSwitchId == i and 0 or 1)
		end

		self:_sortAndReloadPrize(id)

		local info = DoushouqiModel.instance:getTypeInfo(id)

		self._txtScore.text = string.format("当前积分：%s", info.score)
	end
end

function DoushouqirewardView:_sortAndReloadPrize(id)
	local prizeCfgs = DoushouqiConfig.instance:getPrizeCfgs(self._activityId, id)
	local normalList = {}
	local gainList = {}
	local cangainList = {}

	for i, cfg in ipairs(prizeCfgs) do
		local isGain = DoushouqiModel.instance:isGainPrize(self._activityId, id, cfg.prizeId)

		if isGain then
			table.insert(gainList, cfg)
		else
			local isCanGain = not isGain and DoushouqiModel.instance:isCanGainPrize(self._activityId, id, cfg.prizeId)

			if isCanGain then
				table.insert(cangainList, cfg)
			else
				table.insert(normalList, cfg)
			end
		end
	end

	table.insertto(cangainList, normalList)
	table.insertto(cangainList, gainList)
	self._tableview:reloadData(cangainList)
end

function DoushouqirewardView:_onBeastFightingChessGainPrizeRes()
	if self._curSwitchId then
		self:_sortAndReloadPrize(self._curSwitchId)
	end

	self:_checkRedpoint()
end

function DoushouqirewardView:_checkRedpoint()
	for id = 1, 2 do
		local isRed = false
		local prizeCfgs = DoushouqiConfig.instance:getPrizeCfgs(self._activityId, id)

		for i, cfg in ipairs(prizeCfgs) do
			local isGain = DoushouqiModel.instance:isGainPrize(self._activityId, id, cfg.prizeId)
			local isCanGain = not isGain and DoushouqiModel.instance:isCanGainPrize(self._activityId, id, cfg.prizeId)

			if isCanGain then
				isRed = true

				break
			end
		end

		goutil.setActive(self._switchBtns[id].redpoint, isRed)
	end
end

return DoushouqirewardView
