-- chunkname: @modules/logic/room/controller/RoomBuildingFormulaController.lua

module("modules.logic.room.controller.RoomBuildingFormulaController", package.seeall)

local RoomBuildingFormulaController = class("RoomBuildingFormulaController", BaseController)

function RoomBuildingFormulaController:onInit()
	self:clear()
end

function RoomBuildingFormulaController:reInit()
	self:clear()
end

function RoomBuildingFormulaController:clear()
	return
end

function RoomBuildingFormulaController:addConstEvents()
	return
end

function RoomBuildingFormulaController:resetSelectFormulaStrId()
	RoomFormulaListModel.instance:resetSelectFormulaStrId()
end

function RoomBuildingFormulaController:setSelectFormulaStrId(selectFormulaStrId, forceSet, treeLevel)
	if self._waitingSelectFormulaParam then
		return
	end

	local formulaMo = RoomFormulaModel.instance:getFormulaMo(selectFormulaStrId)

	if not formulaMo then
		return
	end

	local isCollapse = false
	local newSelectFormulaStrId = selectFormulaStrId
	local preFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if selectFormulaStrId == preFormulaStrId and not forceSet then
		newSelectFormulaStrId = formulaMo:getParentStrId()
		isCollapse = true
	end

	self._waitingSelectFormulaParam = {
		formulaStrId = newSelectFormulaStrId,
		isCollapse = isCollapse,
		treeLevel = treeLevel
	}

	if treeLevel and self:_checkTreeLevel(treeLevel) then
		RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelHideAnim, treeLevel)
		TaskDispatcher.runDelay(self._onDelaySelectFormulaStrId, self, RoomProductLineEnum.AnimTime.TreeAnim)
	else
		self:_onDelaySelectFormulaStrId()
	end
end

function RoomBuildingFormulaController:_onDelaySelectFormulaStrId()
	if self._waitingSelectFormulaParam then
		local preFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()
		local newSelectFormulaStrId = self._waitingSelectFormulaParam.formulaStrId
		local isCollapse = self._waitingSelectFormulaParam.isCollapse
		local treeLevel = self._waitingSelectFormulaParam.treeLevel

		self._waitingSelectFormulaParam = nil

		RoomFormulaListModel.instance:refreshRankDiff()

		if treeLevel and not self:_checkTreeLevel(treeLevel) then
			RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelShowAnim, treeLevel)
		end

		RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelMoveAnim)
		RoomFormulaListModel.instance:setSelectFormulaStrId(newSelectFormulaStrId)
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectFormulaIdChanged, preFormulaStrId, isCollapse)
	end
end

function RoomBuildingFormulaController:_checkTreeLevel(treeLevel)
	local listLineMO = RoomFormulaListModel.instance:getList()

	for _, lineMO in ipairs(listLineMO) do
		local curTreeLevel = lineMO:getFormulaTreeLevel()

		if curTreeLevel and treeLevel < curTreeLevel then
			return true
		end
	end

	return false
end

RoomBuildingFormulaController.instance = RoomBuildingFormulaController.New()

return RoomBuildingFormulaController
