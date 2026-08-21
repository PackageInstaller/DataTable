-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePostEventAnimationCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePostEventAnimationCommand", package.seeall)

local BattlePostEventAnimationCommand = class("BattlePostEventAnimationCommand", BattleCommandBase)

function BattlePostEventAnimationCommand:execute(battleFlow)
	local localLogic = battleFlow.localLogic

	if localLogic:checkBattleEnded() then
		self:safeFinish(true)

		return
	end

	local model = battleFlow.model
	local phase = model:getPhase()

	if phase == BattleEnum.Phase.READY then
		self:finish(true)

		return
	end

	local netAgent = battleFlow.netAgent

	netAgent:sendPostEventAnimationRequest()
	self:finish(true)
end

function BattlePostEventAnimationCommand:toString()
	return "[post event animation command]"
end

return BattlePostEventAnimationCommand
