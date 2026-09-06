-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtUsePetView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtUsePetView", package.seeall)

local DivineFarnasExtUsePetView = class("DivineFarnasExtUsePetView", ViewComponent)

function DivineFarnasExtUsePetView:ctor()
	DivineFarnasExtUsePetView.super.ctor(self)
end

function DivineFarnasExtUsePetView:unbindEvents()
	DivineFarnasExtUsePetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineFarnasExtUsePetView:bindEvents()
	DivineFarnasExtUsePetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DivineFarnasExtUsePetView:buildUI()
	DivineFarnasExtUsePetView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineFarnasExtUsePetView:onExit()
	DivineFarnasExtUsePetView.super.onExit(self)
	self._scrollList:dispose()
end

function DivineFarnasExtUsePetView:onEnter()
	DivineFarnasExtUsePetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 522001
	end

	self._stageId = checknumber(params[2])
	self._info = DivineFarnasModel.instance:getInfo(self._activityId)
	self._extremeStages = self._info.extremeStages

	local curExtStageInfo = self._extremeStages[self._stageId]
	local raceIdList = curExtStageInfo.activeRaceIds

	self._usedRaceIdList = DivineFarnasModel.instance:getDiffRaceIdList(self._activityId, self._stageId)

	local names = {}
	local opt = {
		ArraySort.DESCENDING
	}

	local function sortFunc(data)
		return (table.indexof(self._usedRaceIdList, data) or nil) and 1
	end

	table.insert(names, sortFunc)
	ArraySort.sortOn(raceIdList, names, opt)
	self._scrollList:reloadData(raceIdList)
	self._scrollList:setCenterMode(true)
end

function DivineFarnasExtUsePetView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local tag = goutil.findChild(cell, "tag")
	local isOnlyUse = table.indexof(self._usedRaceIdList, data)

	MaterialMgr.setCell(MatType.Pet, data, pet)
	GameUtil.SetActive(tag, isOnlyUse)
end

function DivineFarnasExtUsePetView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

return DivineFarnasExtUsePetView
