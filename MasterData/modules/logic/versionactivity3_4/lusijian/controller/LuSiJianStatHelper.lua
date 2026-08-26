-- chunkname: @modules/logic/versionactivity3_4/lusijian/controller/LuSiJianStatHelper.lua

module("modules.logic.versionactivity3_4.lusijian.controller.LuSiJianStatHelper", package.seeall)

local LuSiJianStatHelper = class("LuSiJianStatHelper")

function LuSiJianStatHelper:ctor()
	self.episodeId = "0"
end

function LuSiJianStatHelper:enterGame()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function LuSiJianStatHelper:sendGameFinish()
	StatController.instance:track(StatEnum.EventName.ExitLuSiJianGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(LuSiJianModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = "成功",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime
	})
end

function LuSiJianStatHelper:sendGameAbort()
	StatController.instance:track(StatEnum.EventName.ExitLuSiJianGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(LuSiJianModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = "主动中断",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime
	})
end

function LuSiJianStatHelper:sendGameReset()
	StatController.instance:track(StatEnum.EventName.ExitLuSiJianGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(LuSiJianModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = "失败",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime
	})
	self:enterGame()
end

LuSiJianStatHelper.instance = LuSiJianStatHelper.New()

return LuSiJianStatHelper
