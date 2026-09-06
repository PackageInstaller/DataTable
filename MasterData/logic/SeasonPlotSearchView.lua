-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPlotSearchView.lua

module("logic.extensions.season.view.SeasonPlotSearchView", package.seeall)

local SeasonPlotSearchView = class("SeasonPlotSearchView", ViewComponent)

function SeasonPlotSearchView:ctor()
	SeasonPlotSearchView.super.ctor(self)
end

function SeasonPlotSearchView:unbindEvents()
	SeasonPlotSearchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SeasonPlotSearchView:bindEvents()
	SeasonPlotSearchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SeasonPlotSearchView:buildUI()
	SeasonPlotSearchView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._scrollerGo = self:getGo("tableview")
	self._cellGo = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SeasonPlotSearchView:onExit()
	SeasonPlotSearchView.super.onExit(self)
	self._scrollList:dispose()
end

function SeasonPlotSearchView:onEnter()
	SeasonPlotSearchView.super.onEnter(self)
	self:_updateListData()
end

function SeasonPlotSearchView:_updateListData()
	local seasonId = SeasonModel.instance:getSeasonId()
	local map = SeasonConfig.instance:getGridSearchMap(seasonId)
	local array = {}

	for k, v in pairs(map) do
		if SeasonGridEvtTypes.IsNeedShowSearch[k] then
			table.insert(array, {
				eventType = k,
				confs = v
			})
		end
	end

	ArraySort.sortOn(array, "eventType")
	self._scrollList:reloadData(array)
	self._scrollList:refresh()
end

function SeasonPlotSearchView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "name/txtName")

	GameUtil.setUIImageSpriteIdx(goutil.findChild(cell, "plot"), data.eventType)

	txtName.text = SeasonGridEvtTypes.Names[data.eventType]

	GameUtil.addClickHandler(cell.gameObject, function()
		UIStateManager.instance:push(ViewName.SeasonPlotDetailView, data)
	end)
end

function SeasonPlotSearchView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

return SeasonPlotSearchView
