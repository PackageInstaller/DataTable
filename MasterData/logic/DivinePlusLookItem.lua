-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivinePlusLookItem.lua

module("logic.extensions.divineevolveplus.view.DivinePlusLookItem", package.seeall)

local DivinePlusLookItem = class("DivinePlusLookItem")

function DivinePlusLookItem:ctor(go)
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._cellGo = goutil.findChild(go, "skillcell")
	self._tableGo = goutil.findChild(go, "tableview")
	self._tableView = ScrollerList.create(self._tableGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._drag = Framework.UIDragTrigger.Get(self._tableGo)

	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function DivinePlusLookItem:init(view, element)
	self._mainView = view
	self._name = "神格" .. GameUtil.toRomanNumber(element.cfg.level)
	self._level = element.cfg.level
	self._txtName.text = self._name

	local list = element.list

	self._tableView:getView():SetOffsetWithoutRefresh(0)
	self._tableView:reloadData(list)
end

function DivinePlusLookItem:reset()
	self._tableView:dispose()
end

function DivinePlusLookItem:reloadData()
	self._tableView:getView():ReloadData()
end

function DivinePlusLookItem:_updateCell(view, cell, data)
	local select = goutil.findChild(cell, "select")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btn:AddClickListener(function()
		DivineEvolvePlusController.instance:notify(DivineEvolvePlusController.DivineLookItemClick, self._level, data.cfg, self._name)
	end)
	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.cfg.icon))
	goutil.setActive(select, data.isSelect)
end

function DivinePlusLookItem:_clearTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btn:RemoveClickListener()
	MaterialMgr.clearIcon(cell.gameObject)
end

function DivinePlusLookItem:_onDrag(eventData)
	if self._mainView then
		self._mainView:dragCellChild(eventData)
	end
end

function DivinePlusLookItem:_onBeginDrag(eventData)
	if self._mainView then
		self._mainView:dragBegingCellChild(eventData)
	end
end

function DivinePlusLookItem:_onEndDrag(eventData)
	if self._mainView then
		self._mainView:dragEndCellChild(eventData)
	end
end

return DivinePlusLookItem
