-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchRankTabFrameView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchRankTabFrameView", package.seeall)

local SummerTreasureSnatchRankTabFrameView = class("SummerTreasureSnatchRankTabFrameView", ViewComponent)
local _curTabIdx = 0

function SummerTreasureSnatchRankTabFrameView:buildUI()
	SummerTreasureSnatchRankTabFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function SummerTreasureSnatchRankTabFrameView:bindEvents()
	SummerTreasureSnatchRankTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SummerTreasureSnatchRankTabFrameView:unbindEvents()
	SummerTreasureSnatchRankTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummerTreasureSnatchRankTabFrameView:onEnter()
	SummerTreasureSnatchRankTabFrameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local tabIdx = checknumber(params[2])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	if tabIdx > 0 then
		_curTabIdx = tabIdx
	end

	self:_onUpdate()
end

function SummerTreasureSnatchRankTabFrameView:onExit()
	SummerTreasureSnatchRankTabFrameView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function SummerTreasureSnatchRankTabFrameView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SummerTreasureSnatchRankTabFrameView:_onUpdateData()
	self._tabDataList = {}

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.SummerTreasureSnatchRankView
		data.tabName = "周榜"
		data.viewParams = {
			self._activityId
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.SummerTreasureSnatchTotalRankView
		data.tabName = "总榜"
		data.viewParams = {
			self._activityId
		}

		table.insert(self._tabDataList, data)
	end

	if _curTabIdx <= 0 and #self._tabDataList > 0 then
		_curTabIdx = 1
	end

	_curTabIdx = Mathf.Clamp(_curTabIdx, 0, #self._tabDataList)
end

function SummerTreasureSnatchRankTabFrameView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
end

function SummerTreasureSnatchRankTabFrameView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabDataList)
end

function SummerTreasureSnatchRankTabFrameView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, _curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function SummerTreasureSnatchRankTabFrameView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function SummerTreasureSnatchRankTabFrameView:_onClickTab(data, idx)
	_curTabIdx = idx

	self:_onUpdateUI()
end

function SummerTreasureSnatchRankTabFrameView:_showTabAt()
	local data = self._tabDataList[_curTabIdx]

	if data == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == _curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = _curTabIdx

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function SummerTreasureSnatchRankTabFrameView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return SummerTreasureSnatchRankTabFrameView
