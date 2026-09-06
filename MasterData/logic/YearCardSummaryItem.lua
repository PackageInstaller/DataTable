-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardSummaryItem.lua

module("logic.extensions.yearcard.view.YearCardSummaryItem", package.seeall)

local YearCardSummaryItem = class("YearCardSummaryItem")

function YearCardSummaryItem:ctor(go)
	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self._cellGo = goutil.findChild(go, "cell")
	self._tableGo = goutil.findChild(go, "tableview")
	self._tableView = ScrollerList.create(self._tableGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._drag = Framework.UIDragTrigger.Get(self._tableGo)

	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)

	self._emptyGo = goutil.findChild(go, "empty")
	self._overGo = goutil.findChild(go, "over")
end

function YearCardSummaryItem:init(view, data)
	self._mainView = view

	local cfgMonthPrize = data

	self._txtDesc.text = cfgMonthPrize.name

	self._overGo:SetActive(checknumber(cfgMonthPrize.tag) == 1)

	if not string.nilorempty(cfgMonthPrize.prize) then
		local list = string.split(cfgMonthPrize.prize, "#")

		if cfgMonthPrize.month == 9 then
			self._tableView:reloadData(list)
			self._emptyGo:SetActive(false)
		else
			local isTime = GameUtil.getTimePeriodType(cfgMonthPrize.startTime, cfgMonthPrize.endTime)

			if isTime ~= GameUtil.beforeTimePeriod and list and #list > 0 then
				self._tableView:reloadData(list)
				self._emptyGo:SetActive(false)
			else
				self._tableView:reloadData({})
				self._emptyGo:SetActive(true)
			end
		end
	else
		self._tableView:reloadData({})
		self._emptyGo:SetActive(true)
	end
end

function YearCardSummaryItem:reset()
	self._tableView:dispose()
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function YearCardSummaryItem:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "con")
	local tagGo = goutil.findChild(cell, "tag")

	tagGo:SetActive(false)
	MaterialMgr.setCellByCfg(data, icon)
end

function YearCardSummaryItem:_clearTableview(cell)
	local icon = goutil.findChild(cell, "con")

	MaterialMgr.resetAll()
end

function YearCardSummaryItem:_onDrag(eventData)
	if self._mainView then
		self._mainView:dragCellChild(eventData)
	end
end

function YearCardSummaryItem:_onBeginDrag(eventData)
	if self._mainView then
		self._mainView:dragBegingCellChild(eventData)
	end
end

function YearCardSummaryItem:_onEndDrag(eventData)
	if self._mainView then
		self._mainView:dragEndCellChild(eventData)
	end
end

return YearCardSummaryItem
