-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardSummaryView.lua

module("logic.extensions.yearcard.view.YearCardSummaryView", package.seeall)

local YearCardSummaryView = class("YearCardSummaryView", TableViewComponent)

function YearCardSummaryView:ctor()
	YearCardSummaryView.super.ctor(self)
end

function YearCardSummaryView:buildUI()
	YearCardSummaryView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._scrollrect = self:getGo("tableview"):GetComponent("ScrollRect")
end

function YearCardSummaryView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function YearCardSummaryView:bindEvents()
	YearCardSummaryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function YearCardSummaryView:unbindEvents()
	YearCardSummaryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function YearCardSummaryView:onEnter()
	YearCardSummaryView.super.onEnter(self)
	self:_refreshList()
end

function YearCardSummaryView:onExit()
	YearCardSummaryView.super.onExit(self)
end

function YearCardSummaryView:_onClickClose()
	self:close()
end

function YearCardSummaryView:_updateCell(view, cell, data)
	local item = GameUtil.AddLuaOnce(cell.gameObject, YearCardSummaryItem)

	item:init(self, data)
end

function YearCardSummaryView:_clearTableview(cell)
	return
end

function YearCardSummaryView:_refreshList()
	local activityId = PayShopModel.instance:getCurAnnuityId()

	if activityId and activityId > 0 then
		local cfgs = YearCardConfig.instance:getMonthRewardCfgs(activityId)

		if cfgs and #cfgs > 0 then
			self:updateListData(cfgs)
		end
	end
end

function YearCardSummaryView:dragCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function YearCardSummaryView:dragBegingCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function YearCardSummaryView:dragEndCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

return YearCardSummaryView
