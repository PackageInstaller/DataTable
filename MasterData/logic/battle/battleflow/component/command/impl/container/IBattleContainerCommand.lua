-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/container/IBattleContainerCommand.lua

module("logic.battle.battleflow.component.command.impl.container.IBattleContainerCommand", package.seeall)

local IBattleContainerCommand = class("IBattleContainerCommand")

function IBattleContainerCommand:addCommand(command)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

function IBattleContainerCommand:submit(command)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method")
	end
end

return IBattleContainerCommand
