-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/TeachingBattleFlow.lua

module("logic.extensions.dungeon.battleflow.TeachingBattleFlow", package.seeall)

local TeachingBattleFlow = class("TeachingBattleFlow", DungeonBattleFlowBase)

function TeachingBattleFlow:fillExtensionViewClassList(extensionViewClassList)
	table.insert(extensionViewClassList, TeachingBattleRoundExtensionView)
end

function TeachingBattleFlow:getForbiddenAutoStatus()
	return true
end

return TeachingBattleFlow
