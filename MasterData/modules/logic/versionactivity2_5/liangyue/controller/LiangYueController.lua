-- chunkname: @modules/logic/versionactivity2_5/liangyue/controller/LiangYueController.lua

module("modules.logic.versionactivity2_5.liangyue.controller.LiangYueController", package.seeall)

local LiangYueController = class("LiangYueController", BaseController)

function LiangYueController:onInit()
	return
end

function LiangYueController:reInit()
	return
end

function LiangYueController:onInitFinish()
	return
end

function LiangYueController:addConstEvents()
	return
end

function LiangYueController:openGameView(actId, episodeId)
	local config = LiangYueConfig.instance:getEpisodeConfigByActAndId(actId, episodeId)
	local viewParam = {
		actId = actId,
		episodeId = episodeId,
		episodeGameId = config.puzzleId
	}

	LiangYueModel.instance:setCurActId(actId)
	LiangYueModel.instance:setCurEpisodeId(episodeId)
	ViewMgr.instance:openView(ViewName.LiangYueGameView, viewParam)
end

function LiangYueController:enterLevelView(actId)
	LiangYueRpc.instance:sendGetAct184InfoRequest(actId, self._onReceiveInfo, self)
end

function LiangYueController:_onReceiveInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.LiangYueLevelView)
	end
end

function LiangYueController:finishEpisode(actId, episodeId, puzzle)
	LiangYueRpc.instance:sendAct184FinishEpisodeRequest(actId, episodeId, puzzle)
end

function LiangYueController:statExitData(enterTime, episodeId, result, illustrationList)
	local nowTime = ServerTime.now()
	local useTime = nowTime - enterTime

	StatController.instance:track(StatEnum.EventName.ExitLiangYueActivity, {
		[StatEnum.EventProperties.LiangYue_UseTime] = useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(episodeId),
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.LiangYue_Illustration_Result] = illustrationList
	})
end

LiangYueController.instance = LiangYueController.New()

return LiangYueController
