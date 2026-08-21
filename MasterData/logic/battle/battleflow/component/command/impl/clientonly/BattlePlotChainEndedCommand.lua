-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattlePlotChainEndedCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattlePlotChainEndedCommand", package.seeall)

local BattlePlotChainEndedCommand = class("BattlePlotChainEndedCommand", BattleCommandBase)

function BattlePlotChainEndedCommand:execute(battleFlow)
	local model = battleFlow.model

	model:setPhase(BattleEnum.Phase.NORMAL)
	BattleRoundReportViewFacade.instance:setVisible(true)
	self:finish(true)
end

function BattlePlotChainEndedCommand:toString()
	return "[plot chain ended command]"
end

return BattlePlotChainEndedCommand
