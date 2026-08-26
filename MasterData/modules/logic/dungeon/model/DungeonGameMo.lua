-- chunkname: @modules/logic/dungeon/model/DungeonGameMo.lua

module("modules.logic.dungeon.model.DungeonGameMo", package.seeall)

local DungeonGameMo = pureTable("DungeonGameMo")

function DungeonGameMo:ctor()
	self.beginTime = Time.realtimeSinceStartup
end

function DungeonGameMo:sendMazeGameStatData(result, cellId, chaoValue)
	StatController.instance:track(StatEnum.EventName.DungeonMazeGame, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.DungeonMazeCellId] = tostring(cellId),
		[StatEnum.EventProperties.DungeonMazeChaosValue] = chaoValue
	})
end

function DungeonGameMo:sendJumpGameStatData(result, cellId)
	StatController.instance:track(StatEnum.EventName.DungeonJumpGame, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.DungeonMazeCellId] = tostring(cellId)
	})
end

return DungeonGameMo
