-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonPrizeWinTabFrameView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonPrizeWinTabFrameView", package.seeall)

local GodStatuesWarSeasonPrizeWinTabFrameView = class("GodStatuesWarSeasonPrizeWinTabFrameView", ViewComponent)

function GodStatuesWarSeasonPrizeWinTabFrameView:buildUI()
	GodStatuesWarSeasonPrizeWinTabFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function GodStatuesWarSeasonPrizeWinTabFrameView:bindEvents()
	GodStatuesWarSeasonPrizeWinTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GodStatuesWarSeasonPrizeWinTabFrameView:unbindEvents()
	GodStatuesWarSeasonPrizeWinTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodStatuesWarSeasonPrizeWinTabFrameView:onEnter()
	GodStatuesWarSeasonPrizeWinTabFrameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d | export_赛季配置 | j家族赛季榜(新) )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = FamilySeasonRankConfig.instance:getNfsSeasonData(self._seasonId)
	self._curTabIdx = 1

	self:_onUpdate()
end

function GodStatuesWarSeasonPrizeWinTabFrameView:onExit()
	GodStatuesWarSeasonPrizeWinTabFrameView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_onUpdateData()
	self:_updateTabData()
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_updateTabData()
	self._tabDataList = {}

	if self._seasonData.rankPrizePlanId > 0 then
		local data = {}

		data.viewName = ViewName.GodStatuesWarSeasonPrizeWinTabFamilyRankView
		data.tabName = "排行奖励"
		data.viewParams = {
			self._seasonId
		}

		table.insert(self._tabDataList, data)
	end

	if self._seasonData.scorePrizePlanId > 0 then
		local data = {}

		data.viewName = ViewName.GodStatuesWarSeasonPrizeWinTabFamilyScoreView
		data.tabName = "达标奖励"
		data.viewParams = {
			self._seasonId
		}

		table.insert(self._tabDataList, data)
	end

	self._curTabIdx = self._curTabIdx or 1
	self._curTabIdx = Mathf.Min(self._curTabIdx, #self._tabDataList)
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_showTabAt()
	local data = self._tabDataList[self._curTabIdx]

	if data == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == self._curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = self._curTabIdx

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function GodStatuesWarSeasonPrizeWinTabFrameView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return GodStatuesWarSeasonPrizeWinTabFrameView
