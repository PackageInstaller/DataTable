-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkBornMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkBornMO", package.seeall)

local M = class("AirWorkBornMO", AirWorkUnitMOBase)

function M:_initByAgent(no)
	self._bornCellNO = no
end

function M:getBornCell()
	return self._bornCellNO
end

function M:getUnionIndex()
	return BoardIndexConverter.coordinatesToUnionIndex(self._bornCellNO.cell.x, self._bornCellNO.cell.z)
end

function M:trans2AgentForm()
	local bornCellNO = BattleExtension_pb.BornCellNO()

	bornCellNO.cell.x = self._bornCellNO.cell.x
	bornCellNO.cell.z = self._bornCellNO.cell.z
	bornCellNO.direction = self._bornCellNO.direction

	return bornCellNO
end

return M
