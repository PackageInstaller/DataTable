-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingCarRoleListModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingCarRoleListModel", package.seeall)

local V3a9RacingCarRoleListModel = class("V3a9RacingCarRoleListModel", ListScrollModel)

function V3a9RacingCarRoleListModel:initList()
	V3a9RacingRoleListModel.instance:setMoList()
	self:setList(V3a9RacingRoleListModel.instance:getMoList())
	self:setSelectedCell(1)
end

function V3a9RacingCarRoleListModel:setSelectedCell(index)
	self._selectedCellIndex = index

	self:selectCell(index, true)
end

function V3a9RacingCarRoleListModel:getSelectedConfig()
	local mo = self:getByIndex(self._selectedCellIndex)

	return mo and mo.config
end

V3a9RacingCarRoleListModel.instance = V3a9RacingCarRoleListModel.New()

return V3a9RacingCarRoleListModel
