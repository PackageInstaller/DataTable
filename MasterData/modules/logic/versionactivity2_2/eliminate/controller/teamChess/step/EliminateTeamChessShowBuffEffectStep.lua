-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/EliminateTeamChessShowBuffEffectStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessShowBuffEffectStep", package.seeall)

local EliminateTeamChessShowBuffEffectStep = class("EliminateTeamChessShowBuffEffectStep", EliminateTeamChessStepBase)

function EliminateTeamChessShowBuffEffectStep:onStart()
	local data = self._data
	local vxEffectType = data.vxEffectType
	local uid = data.uid
	local time = data.time
	local entity = TeamChessUnitEntityMgr.instance:getEntity(uid)

	if entity == nil then
		self:onDone(true)

		return
	end

	local path = EliminateTeamChessEnum.VxEffectTypeToPath[vxEffectType]

	if string.nilorempty(path) then
		self:onDone(true)

		return
	end

	time = time or EliminateTeamChessEnum.VxEffectTypePlayTime[vxEffectType]

	local x, y, z = entity:getPosXYZ()

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, vxEffectType, x, y, z, time)

	if time ~= nil then
		TaskDispatcher.runDelay(self._onDone, self, time)
	else
		self:onDone(true)
	end
end

return EliminateTeamChessShowBuffEffectStep
