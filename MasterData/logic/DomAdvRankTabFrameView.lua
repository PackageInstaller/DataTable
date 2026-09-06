-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/rank/DomAdvRankTabFrameView.lua

module("logic.extensions.domainadventure.view.rank.DomAdvRankTabFrameView", package.seeall)

local DomAdvRankTabFrameView = class("DomAdvRankTabFrameView", ViewComponent)
local _curTabIdx = 0

function DomAdvRankTabFrameView:buildUI()
	DomAdvRankTabFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function DomAdvRankTabFrameView:bindEvents()
	DomAdvRankTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DomAdvRankTabFrameView:unbindEvents()
	DomAdvRankTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DomAdvRankTabFrameView:onEnter()
	DomAdvRankTabFrameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local tabIdx = checknumber(params[2])
	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	if tabIdx > 0 then
		_curTabIdx = tabIdx
	end

	self:_onUpdate()
end

function DomAdvRankTabFrameView:onExit()
	DomAdvRankTabFrameView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function DomAdvRankTabFrameView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DomAdvRankTabFrameView:_onUpdateData()
	self._tabDataList = {}

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.DomAdvEliteFightRankView
		data.tabName = "神域强袭"
		data.viewParams = {
			self._activityId,
			DomAdvEnum.RankType_Elite
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.DomAdvBossRankView
		data.tabName = "领神决战"
		data.viewParams = {
			self._activityId,
			DomAdvEnum.RankType_Boss
		}

		table.insert(self._tabDataList, data)
	end

	if _curTabIdx <= 0 and #self._tabDataList > 0 then
		_curTabIdx = 1
	end

	_curTabIdx = Mathf.Clamp(_curTabIdx, 0, #self._tabDataList)
end

function DomAdvRankTabFrameView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
end

function DomAdvRankTabFrameView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabDataList)
end

function DomAdvRankTabFrameView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, _curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function DomAdvRankTabFrameView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DomAdvRankTabFrameView:_onClickTab(data, idx)
	_curTabIdx = idx

	self:_onUpdateUI()
end

function DomAdvRankTabFrameView:_showTabAt()
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

function DomAdvRankTabFrameView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return DomAdvRankTabFrameView
