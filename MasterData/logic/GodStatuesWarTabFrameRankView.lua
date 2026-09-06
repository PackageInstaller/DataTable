-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabFrameRankView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabFrameRankView", package.seeall)

local GodStatuesWarTabFrameRankView = class("GodStatuesWarTabFrameRankView", ViewComponent)

function GodStatuesWarTabFrameRankView:buildUI()
	GodStatuesWarTabFrameRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function GodStatuesWarTabFrameRankView:bindEvents()
	GodStatuesWarTabFrameRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GodStatuesWarTabFrameRankView:unbindEvents()
	GodStatuesWarTabFrameRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodStatuesWarTabFrameRankView:onEnter()
	GodStatuesWarTabFrameRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._curTabIdx = 1

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self:_onUpdate()
end

function GodStatuesWarTabFrameRankView:onExit()
	GodStatuesWarTabFrameRankView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function GodStatuesWarTabFrameRankView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarTabFrameRankView:_onUpdateData()
	self._step = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	self._stepInterval = GodStatuesWarController.instance:getStepInterval(self._seasonId, self._step)
	self._stepType = GodStatuesWarController.instance:getStepTypeOfGsw(self._seasonId, self._step)

	self:_updateTabData()
end

function GodStatuesWarTabFrameRankView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function GodStatuesWarTabFrameRankView:_updateTabData()
	self._tabDataList = {}

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.GodStatuesWarTabChildRankFamilyView
		data.tabName = "地图排行"
		data.viewParams = {
			self._seasonId
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.GodStatuesWarTabChildRankPrizeView
		data.tabName = "地图奖励"
		data.viewParams = {
			self._seasonId
		}

		table.insert(self._tabDataList, data)
	end

	if self._stepType == GswEnum.StepType_Zone then
		local data = {}

		data.viewName = ViewName.GodStatuesWarTabChildRankAreaEnergyView
		data.tabName = "战区排行"
		data.viewParams = {
			self._seasonId
		}

		table.insert(self._tabDataList, data)
	end
end

function GodStatuesWarTabFrameRankView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function GodStatuesWarTabFrameRankView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function GodStatuesWarTabFrameRankView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GodStatuesWarTabFrameRankView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function GodStatuesWarTabFrameRankView:_showTabAt()
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

function GodStatuesWarTabFrameRankView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return GodStatuesWarTabFrameRankView
