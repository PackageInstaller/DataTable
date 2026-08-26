-- chunkname: @modules/logic/versionactivity3_1/yeshumei/controller/YeShuMeiStatHelper.lua

module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiStatHelper", package.seeall)

local YeShuMeiStatHelper = class("YeShuMeiStatHelper")

function YeShuMeiStatHelper:ctor()
	self.episodeId = "0"
end

function YeShuMeiStatHelper:enterGame()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function YeShuMeiStatHelper:sendGameFinish()
	StatController.instance:track(StatEnum.EventName.ExitYeShuMei, {
		[StatEnum.EventProperties.EpisodeId] = tostring(YeShuMeiModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[StatEnum.Result.Success],
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.GoalNum] = YeShuMeiGameModel.instance:getCompleteLevelNum()
	})
end

function YeShuMeiStatHelper:sendGameAbort()
	StatController.instance:track(StatEnum.EventName.ExitYeShuMei, {
		[StatEnum.EventProperties.EpisodeId] = tostring(YeShuMeiModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[StatEnum.Result.Abort],
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.GoalNum] = YeShuMeiGameModel.instance:getCompleteLevelNum()
	})
end

function YeShuMeiStatHelper:sendGameReset()
	StatController.instance:track(StatEnum.EventName.ExitYeShuMei, {
		[StatEnum.EventProperties.EpisodeId] = tostring(YeShuMeiModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[StatEnum.Result.Reset],
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.GoalNum] = YeShuMeiGameModel.instance:getCompleteLevelNum()
	})
	self:enterGame()
end

YeShuMeiStatHelper.instance = YeShuMeiStatHelper.New()

return YeShuMeiStatHelper
