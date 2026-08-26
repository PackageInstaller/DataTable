-- chunkname: @modules/logic/versionactivity3_9/bird/controller/V3a9BirdController.lua

module("modules.logic.versionactivity3_9.bird.controller.V3a9BirdController", package.seeall)

local V3a9BirdController = class("V3a9BirdController", BaseController)
local StatPrefix = {
	Episode = "243_3.9主活动外围玩法-关卡-"
}

function V3a9BirdController:onInit()
	return
end

function V3a9BirdController:onInitFinish()
	return
end

function V3a9BirdController:addConstEvents()
	return
end

function V3a9BirdController:reInit()
	return
end

function V3a9BirdController:openBirdMainView(actId, episodeId, isReturn)
	actId = actId or V3a9BirdModel.instance:getActId()

	V3a9BirdModel.instance:onEnterMainView(actId)
	V3a9BirdRpc.instance:sendGetAct243InfoRequest(actId, function()
		episodeId = episodeId or V3a9BirdEnum.BirdGameTypeEpisodeId[V3a9BirdEnum.BirdGameType.Infinite][1]

		local param = {
			actId = actId,
			episodeId = episodeId,
			isReturn = isReturn
		}

		ViewMgr.instance:openView(ViewName.V3a9BirdMainView, param)
	end)
end

function V3a9BirdController:enterGame(episodeId, initCount)
	V3a9BirdModel.instance:onStartGame(episodeId, initCount)

	local param = {
		episodeId = episodeId
	}

	ViewMgr.instance:openView(ViewName.V3a9BirdGameView, param)
end

function V3a9BirdController:checkOpenResultView(episodeId)
	if not ViewMgr.instance:isOpen(ViewName.V3a9BirdResultView) then
		local param = {
			episodeId = episodeId
		}

		ViewMgr.instance:openView(ViewName.V3a9BirdResultView, param)
	end
end

function V3a9BirdController:onStartGame()
	self._startGameTime = UnityEngine.Time.realtimeSinceStartup
end

function V3a9BirdController:onGameOver()
	local activityId = V3a9BirdModel.instance:getActId()
	local episodeId = V3a9BirdModel.instance:getEnterGameEpisodeId()
	local score = V3a9BirdModel.instance:getGameScore()
	local star = V3a9BirdModel.instance:getPassCount()

	if self._startGameTime then
		if not (UnityEngine.Time.realtimeSinceStartup - self._startGameTime) then
			local timeMs = 0

			V3a9BirdRpc.instance:sendGetAct243ReportEpisodeRequest(activityId, episodeId, score, star, timeMs * 1000)

			if not ViewMgr.instance:isOpen(ViewName.V3a9BirdResultView) then
				local param = {
					episodeId = episodeId
				}

				ViewMgr.instance:openView(ViewName.V3a9BirdResultView, param)
			end

			self:sendGameSuccessStat(true, timeMs)
		end
	end
end

function V3a9BirdController:openPauseView(yesCallback, yesCbobj, closeCallback, closeCbobj)
	local param = {
		yesCallback = yesCallback,
		yesCbobj = yesCbobj,
		closeCallback = closeCallback,
		closeCbobj = closeCbobj
	}

	ViewMgr.instance:openView(ViewName.V3a9BirdPauseView, param)
end

function V3a9BirdController:sendGameSuccessStat(isOver, timeMs)
	timeMs = timeMs or self._startGameTime and UnityEngine.Time.realtimeSinceStartup - self._startGameTime or 0

	local episodeId = V3a9BirdModel.instance:getEnterGameEpisodeId()

	if isOver then
		if not StatEnum.Result2Cn[StatEnum.Result.Success] then
			local result = StatEnum.Result2Cn[StatEnum.Result.Exit]
			local time = math.floor(timeMs or 0)
			local properties = {
				[StatEnum.EventProperties.EpisodeId] = StatPrefix.Episode .. tostring(episodeId or 0),
				[StatEnum.EventProperties.Result] = result,
				[StatEnum.EventProperties.UseTime] = time,
				[StatEnum.EventProperties.points] = V3a9BirdModel.instance:getGameScore()
			}

			StatController.instance:track(StatEnum.EventName.SideMiniGames, properties)
		end
	end
end

V3a9BirdController.instance = V3a9BirdController.New()

return V3a9BirdController
