-- chunkname: @modules/logic/versionactivity2_6/xugouji/model/Activity188StatMo.lua

module("modules.logic.versionactivity2_6.xugouji.model.Activity188StatMo", package.seeall)

local Activity188StatMo = pureTable("Activity188StatMo")

function Activity188StatMo:ctor()
	self.beginTime = Time.realtimeSinceStartup
end

function Activity188StatMo:reset()
	self.beginTime = Time.realtimeSinceStartup
	self._actId, self._gameId, self.episdoeId, self.result = nil
	self._roundNum, self._playerHp, self._enemyHp, self._playerPair, self._enemyPair = nil
end

function Activity188StatMo:setBaseData(actId, episdoeId, gameId)
	self._actId = actId and actId or self._actId
	self._gameId = gameId and gameId or self._gameId
	self.episdoeId = episdoeId and episdoeId or self.episdoeId
end

function Activity188StatMo:setGameData(result, roundNum, playerHp, enemyHp, playerPair, enemyPair)
	self.result = result and result or self.result
	self._roundNum = roundNum and roundNum or self._roundNum
	self._playerHp = playerHp and playerHp or self._playerHp
	self._enemyHp = enemyHp and enemyHp or self._enemyHp
	self._playerPair = playerPair and playerPair or self._playerPair
	self._enemyPair = enemyPair and enemyPair or self._enemyPair
end

function Activity188StatMo:sendDungeonFinishStatData()
	StatController.instance:track(StatEnum.EventName.Act188DungeonFinish, {
		[StatEnum.EventProperties.ActivityId] = tostring(self._actId),
		[StatEnum.EventProperties.EpisodeId] = tostring(self.episdoeId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime
	})
end

function Activity188StatMo:sendGameFinishStatData()
	local gameObj = {
		[StatEnum.EventProperties.RoundNum] = self._roundNum,
		[StatEnum.EventProperties.Act188GamePlayerHp] = self._playerHp,
		[StatEnum.EventProperties.Act188GameEnemyHp] = self._enemyHp,
		[StatEnum.EventProperties.Act188GamePlayerPair] = self._playerPair,
		[StatEnum.EventProperties.Act188GameEnemyPair] = self._enemyPair
	}

	StatController.instance:track(StatEnum.EventName.Act188MapFinish, {
		[StatEnum.EventProperties.ActivityId] = tostring(self._actId),
		[StatEnum.EventProperties.MapId] = tostring(self._gameId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.Result] = self.result == 1 and "success" or "fail",
		[StatEnum.EventProperties.Act188GameObj] = gameObj
	})
end

function Activity188StatMo:sendGameGiveUpStatData()
	local gameObj = {
		[StatEnum.EventProperties.RoundNum] = self._roundNum,
		[StatEnum.EventProperties.Act188GamePlayerHp] = self._playerHp,
		[StatEnum.EventProperties.Act188GameEnemyHp] = self._enemyHp,
		[StatEnum.EventProperties.Act188GamePlayerPair] = self._playerPair,
		[StatEnum.EventProperties.Act188GameEnemyPair] = self._enemyPair
	}

	StatController.instance:track(StatEnum.EventName.Act188MapGiveUp, {
		[StatEnum.EventProperties.ActivityId] = tostring(self._actId),
		[StatEnum.EventProperties.MapId] = tostring(self._gameId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.Act188GameObj] = gameObj
	})
end

return Activity188StatMo
