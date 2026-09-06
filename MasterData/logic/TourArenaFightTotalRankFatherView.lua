-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightTotalRankFatherView.lua

module("logic.extensions.tourarena.view.TourArenaFightTotalRankFatherView", package.seeall)

local TourArenaFightTotalRankFatherView = class("TourArenaFightTotalRankFatherView", ViewComponent)

function TourArenaFightTotalRankFatherView:buildUI()
	TourArenaFightTotalRankFatherView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._contentCol = self:getGo("contentCol")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	local tabScrCell = self:getGo("tabCol/scrCell")
	local tabScrView = self:getGo("tabCol/scrView")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function TourArenaFightTotalRankFatherView:bindEvents()
	TourArenaFightTotalRankFatherView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TourArenaFightTotalRankFatherView:unbindEvents()
	TourArenaFightTotalRankFatherView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TourArenaFightTotalRankFatherView:onEnter()
	TourArenaFightTotalRankFatherView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = TourArenaController.instance:getActivityIdOfFight()
	end

	self._defalutTabKey = params[2]

	local activityType = TourArenaController.instance:getActivityTypeOfFight()

	self._txtOpenTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)

	self:_onUpdate()
end

function TourArenaFightTotalRankFatherView:onExit()
	TourArenaFightTotalRankFatherView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function TourArenaFightTotalRankFatherView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TourArenaFightTotalRankFatherView:_onUpdateData()
	self._tabDataPool = {}
	self._tabKeyList = {}

	local isUsePeriodMode = TourArenaController.instance:isUsePeriodMode(self._activityId)

	if isUsePeriodMode then
		local data = {}

		data.tabKey = "periodRank"
		data.viewName = ViewName.TourArenaFightPeriodRankChildView
		data.tabName = "总榜"
		data.viewParams = {
			self._activityId
		}
		self._tabDataPool[data.tabKey] = data

		table.insert(self._tabKeyList, data.tabKey)
	end

	if self._tabDataPool then
		local tazDataList = TourArenaZoneConfig.instance:getTazDataList() or {}

		for _, v in ipairs(tazDataList) do
			local data = {}

			data.tabKey = TourArenaController.instance:getTourArenaFightRankTabZoneKey(v.zoneId)
			data.viewName = ViewName.TourArenaFightWeeklyRankChildView
			data.tabName = "周榜"
			data.viewParams = {
				self._activityId,
				v.zoneId
			}
			self._tabDataPool[data.tabKey] = data

			table.insert(self._tabKeyList, data.tabKey)
		end
	end

	self._curTabKey = self._defalutTabKey or self._curTabKey or self._tabKeyList[1]

	if table.indexof(self._tabKeyList, self._curTabKey) == false then
		self._curTabKey = self._tabKeyList[1]
	end
end

function TourArenaFightTotalRankFatherView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
end

function TourArenaFightTotalRankFatherView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabKeyList)
end

function TourArenaFightTotalRankFatherView:_updateTabCell(view, cell, tabKey, tag)
	local data = self._tabDataPool[tabKey]
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, self._curTabKey == tabKey and 1 or 0)
	GameUtil.addClickHandler(mainGo, function()
		self._curTabKey = tabKey

		self:_onUpdateUI()
	end)
end

function TourArenaFightTotalRankFatherView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function TourArenaFightTotalRankFatherView:_showTabAt()
	local data = self._tabDataPool[self._curTabKey]

	if data == nil then
		return
	end

	if self._oldTabKey and self._oldTabKey == self._curTabKey then
		return
	end

	self:_onClearTabAt()

	self._oldTabKey = self._curTabKey

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function TourArenaFightTotalRankFatherView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabKey = nil
end

return TourArenaFightTotalRankFatherView
