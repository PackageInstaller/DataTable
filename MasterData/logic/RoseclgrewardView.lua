-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/view/RoseclgrewardView.lua

module("logic.extensions.roseclg.view.RoseclgrewardView", package.seeall)

local RoseclgrewardView = class("RoseclgrewardView", ViewComponent)

function RoseclgrewardView:ctor()
	RoseclgrewardView.super.ctor(self)
end

function RoseclgrewardView:unbindEvents()
	RoseclgrewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function RoseclgrewardView:bindEvents()
	RoseclgrewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function RoseclgrewardView:buildUI()
	RoseclgrewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("tablecell")
	local tableviewGo = self:getGo("tableview")

	self._scrollrect = tableviewGo:GetComponent("ScrollRect")
	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function RoseclgrewardView:onExit()
	RoseclgrewardView.super.onExit(self)
	self._tableview:dispose()
end

function RoseclgrewardView:onEnter()
	RoseclgrewardView.super.onEnter(self)

	self._cellPool = {}

	self.addGEvent(self, GlobalNotify.BeastFightingChessGainPrizeRes, self._onBeastFightingChessGainPrizeRes, self)

	self._activityId = self:getFirstParam()
	self._curSwitchId = nil

	self:_onSwitchList(1)
end

function RoseclgrewardView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	cell.txtTitle.text = string.format("第%s关", data.stageId)

	local prize = data.passPrize
	local itemList = string.split(prize, "#")

	cell.tableview:reloadData(itemList)
	cell.tableview:MoveCellToBegin(0)
	cell.drag:AddDragListener(self._onDrag, self)
	cell.drag:AddBeginDragListener(self._onBeginDrag, self)
	cell.drag:AddEndDragListener(self._onEndDrag, self)
end

function RoseclgrewardView:_clearCell(cellGo)
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

function RoseclgrewardView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function RoseclgrewardView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function RoseclgrewardView:_onEndDrag(eventData)
	self._scrollrect:OnEndDrag(eventData)
end

function RoseclgrewardView:_updateItemCell(view, cellGo, data)
	local proxy = MaterialMgr.setCellByCfg(data, cellGo)
end

function RoseclgrewardView:_clearItemCell(cellGo)
	MaterialMgr.resetAll(cellGo)
end

function RoseclgrewardView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		local stageCfgs = RoseclgConfig.instance:getStageCfgs(self._activityId)

		self._tableview:reloadData(stageCfgs)
	end
end

function RoseclgrewardView:_onBeastFightingChessGainPrizeRes()
	self._tableview:refresh()
end

return RoseclgrewardView
