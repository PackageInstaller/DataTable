-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessPowerChangeStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPowerChangeStep", package.seeall)

local TeamChessPowerChangeStep = class("TeamChessPowerChangeStep", EliminateTeamChessStepBase)

function TeamChessPowerChangeStep:onStart()
	local data = self._data
	local needShowDamage = data.needShowDamage
	local reasonId = data.reasonId

	if data.uid == nil or data.diffValue == nil then
		self:onDone(true)

		return
	end

	local delayTime = EliminateTeamChessEnum.teamChessPowerChangeStepTime
	local hpChangeType = EliminateTeamChessEnum.HpDamageType.Chess

	if reasonId ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(reasonId)) then
		delayTime = EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime
		hpChangeType = EliminateTeamChessEnum.HpDamageType.GrowUpToChess
	end

	EliminateTeamChessModel.instance:updateChessPower(data.uid, data.diffValue)

	if needShowDamage then
		local entity = TeamChessUnitEntityMgr.instance:getEntity(data.uid)

		if entity ~= nil then
			local x, y, _ = entity:getTopPosXYZ()

			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, data.diffValue, x, y + 0.5, hpChangeType)
		end
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessPowerChange, data.uid, data.diffValue)
	TaskDispatcher.runDelay(self._onDone, self, delayTime)
end

return TeamChessPowerChangeStep
