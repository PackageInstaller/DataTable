-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaPrizeTabView.lua

module("logic.extensions.kingarena.view.prize.KingArenaPrizeTabView", package.seeall)

local KingArenaPrizeTabView = class("KingArenaPrizeTabView", ViewComponent)
local _curTabIdx = 1

function KingArenaPrizeTabView:buildUI()
	KingArenaPrizeTabView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function KingArenaPrizeTabView:bindEvents()
	KingArenaPrizeTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KingArenaPrizeTabView:unbindEvents()
	KingArenaPrizeTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KingArenaPrizeTabView:onEnter()
	KingArenaPrizeTabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local tabIndex = checknumber(params[2])
	local isInTime = KingArenaController.instance:isInTimeOfSeason(self._seasonId)

	if not isInTime then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.KingArenaStepChange, self._handleKingArenaStepChange, self)

	if tabIndex > 0 then
		_curTabIdx = tabIndex
	end

	self:_onUpdate()
end

function KingArenaPrizeTabView:onExit()
	KingArenaPrizeTabView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function KingArenaPrizeTabView:_handleKingArenaStepChange(stepChangeState)
	if stepChangeState == KingArenaEnum.StepChangeState_Season then
		self:close()

		return
	else
		self:_onUpdate()
	end
end

function KingArenaPrizeTabView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KingArenaPrizeTabView:_onUpdateData()
	self:_updateTabData()
end

function KingArenaPrizeTabView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function KingArenaPrizeTabView:_updateTabData()
	self._tabDataList = {}

	local data = {}

	data.viewName = ViewName.KingArenaRankPrizeView
	data.tabName = "排行奖励"
	data.viewParams = {
		self._seasonId
	}
	data.redIds = nil

	table.insert(self._tabDataList, data)

	local data = {}

	data.viewName = ViewName.KingArenaSeasonPrizeView
	data.tabName = "赛季奖励"
	data.viewParams = {
		self._seasonId
	}
	data.redIds = {
		RedPointModel.ID_KINGARENA_SEASON_PRIZE
	}

	table.insert(self._tabDataList, data)

	local data = {}

	data.viewName = ViewName.KingArenaPrizeRuleView
	data.tabName = "基础奖励"
	data.viewParams = {
		self._seasonId
	}
	data.redIds = nil

	table.insert(self._tabDataList, data)

	if checknumber(_curTabIdx) <= 0 then
		_curTabIdx = 1
	end

	_curTabIdx = Mathf.Min(_curTabIdx, #self._tabDataList)
end

function KingArenaPrizeTabView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function KingArenaPrizeTabView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redGo = goutil.findChild(mainGo, "redGo")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, _curTabIdx == tabIdx and 1 or 0)

	if data.redIds then
		RedPointController.instance:regRedPoint(redGo, unpack(data.redIds))
	else
		RedPointController.instance:unregRedPoint(redGo)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function KingArenaPrizeTabView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redGo = goutil.findChild(mainGo, "redGo")

	GameUtil.rmClickHandler(mainGo)
	RedPointController.instance:unregRedPoint(redGo)
end

function KingArenaPrizeTabView:_onClickTab(data, idx)
	_curTabIdx = idx

	self:_onUpdateUI()
end

function KingArenaPrizeTabView:_showTabAt()
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

function KingArenaPrizeTabView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return KingArenaPrizeTabView
