-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/ClimbingTowerBrightSideBattleFlow.lua

module("logic.extensions.dungeon.battleflow.ClimbingTowerBrightSideBattleFlow", package.seeall)

local ClimbingTowerBrightSideBattleFlow = class("ClimbingTowerBrightSideBattleFlow", DungeonBattleFlowBase)

function ClimbingTowerBrightSideBattleFlow:sendRestartRequest(restartType)
	if restartType == BattleEnum.RestartType.TONEXT then
		local gamePlay = self.model:getGamePlay()

		if ClimbingTowerController.instance:startNextBattleLevel(self:getPassId(), gamePlay) then
			return
		end
	end

	ClimbingTowerDarkSideBattleFlow.super.sendRestartRequest(self, restartType)
end

function ClimbingTowerBrightSideBattleFlow:fillExtensionViewClassList(extensionViewClassList)
	return
end

function ClimbingTowerBrightSideBattleFlow:fillForbiddenCareerList(forbiddenCareerList)
	return
end

return ClimbingTowerBrightSideBattleFlow
