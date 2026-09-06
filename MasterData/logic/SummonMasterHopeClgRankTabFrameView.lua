-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgRankTabFrameView.lua

module("logic.extensions.summonmasterhopeclg.view.rank.SummonMasterHopeClgRankTabFrameView", package.seeall)

local SummonMasterHopeClgRankTabFrameView = class("SummonMasterHopeClgRankTabFrameView", ViewComponent)
local _curTabIdx = 0
local GOD_RANK_TYPE = 1
local DAILY_RANK_TYPE = 2

function SummonMasterHopeClgRankTabFrameView:buildUI()
	SummonMasterHopeClgRankTabFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function SummonMasterHopeClgRankTabFrameView:bindEvents()
	SummonMasterHopeClgRankTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SummonMasterHopeClgRankTabFrameView:unbindEvents()
	SummonMasterHopeClgRankTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummonMasterHopeClgRankTabFrameView:onEnter()
	SummonMasterHopeClgRankTabFrameView.super.onEnter(self)

	self._activityId = 403001

	self:_onUpdate()
end

function SummonMasterHopeClgRankTabFrameView:onExit()
	SummonMasterHopeClgRankTabFrameView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function SummonMasterHopeClgRankTabFrameView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SummonMasterHopeClgRankTabFrameView:_onUpdateData()
	self._tabDataList = {}

	local scoreArr = SummonMasterHopeClgConfig.instance:getScoresArr(self._activityId)

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.SummonMasterHopeClgGodRankView
		data.tabName = "大神排行"
		data.viewParams = {
			self._activityId,
			GOD_RANK_TYPE,
			scoreArr[1]
		}

		table.insert(self._tabDataList, data)
	end

	local canShowDailyRank = SummonMasterHopeClgController.instance:canShowDailyRank(self._activityId)

	if self._tabDataList and canShowDailyRank then
		local data = {}

		data.viewName = ViewName.SummonMasterHopeClgDailyRankView
		data.tabName = "每日排行"
		data.viewParams = {
			self._activityId,
			DAILY_RANK_TYPE,
			scoreArr[2]
		}

		table.insert(self._tabDataList, data)
	end

	if _curTabIdx <= 0 and #self._tabDataList > 0 then
		_curTabIdx = 1
	end

	_curTabIdx = Mathf.Clamp(_curTabIdx, 0, #self._tabDataList)
end

function SummonMasterHopeClgRankTabFrameView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
end

function SummonMasterHopeClgRankTabFrameView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabDataList)
end

function SummonMasterHopeClgRankTabFrameView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, _curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function SummonMasterHopeClgRankTabFrameView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function SummonMasterHopeClgRankTabFrameView:_onClickTab(data, idx)
	_curTabIdx = idx

	self:_onUpdateUI()
end

function SummonMasterHopeClgRankTabFrameView:_showTabAt()
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

function SummonMasterHopeClgRankTabFrameView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return SummonMasterHopeClgRankTabFrameView
