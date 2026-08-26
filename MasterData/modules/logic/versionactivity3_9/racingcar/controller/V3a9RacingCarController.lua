-- chunkname: @modules/logic/versionactivity3_9/racingcar/controller/V3a9RacingCarController.lua

module("modules.logic.versionactivity3_9.racingcar.controller.V3a9RacingCarController", package.seeall)

local V3a9RacingCarController = class("V3a9RacingCarController", BaseController)
local StatPrefix = {
	Talent = "243_3.9主活动外围玩法-天赋-",
	Racer = "243_3.9主活动外围玩法-车手-",
	Episode = "243_3.9主活动外围玩法-关卡-"
}

function V3a9RacingCarController:onInit()
	return
end

function V3a9RacingCarController:onInitFinish()
	return
end

function V3a9RacingCarController:addConstEvents()
	return
end

function V3a9RacingCarController:reInit()
	self._statStartTime = nil
	self._statReported = nil
end

function V3a9RacingCarController:startStat()
	self._statStartTime = UnityEngine.Time.realtimeSinceStartup
	self._statReported = false
end

function V3a9RacingCarController:_getStatTalentNames()
	local result = {}
	local actId = V3a9RacingCarModel.instance:getActId()
	local talentMos = V3a9RacingTalentModel.instance:getTalentMos(actId)

	for _, talentMo in pairs(talentMos or {}) do
		local co = talentMo:getCurLevelCo()

		if co then
			table.insert(result, StatPrefix.Talent .. co.name)
		end
	end

	table.sort(result)

	return result
end

function V3a9RacingCarController:_getStatCommonProperties(result)
	local episodeConfig = V3a9RacingCarModel.instance:getEpisodeConfig()
	local racerConfig = V3a9RacingCarModel.instance:getMainPlayerRacer()
	local var_7_0 = {}

	var_7_0[StatEnum.EventProperties.EpisodeId] = StatPrefix.Episode .. tostring((episodeConfig or nil) and (episodeConfig.episodeId or 0))
	var_7_0[StatEnum.EventProperties.Result] = result
	var_7_0[StatEnum.EventProperties.UseTime] = math.floor((self._statStartTime or nil) and (UnityEngine.Time.realtimeSinceStartup - self._statStartTime or 0))
	var_7_0[StatEnum.EventProperties.SideMiniGamesRacerName] = StatPrefix.Racer .. ((racerConfig or nil) and (racerConfig.name or ""))
	var_7_0[StatEnum.EventProperties.SideMiniGamesOutsideTalentNameList] = self:_getStatTalentNames()

	return var_7_0
end

function V3a9RacingCarController:sendGameSuccessStat(star, rank, completedCombatTarget)
	if self._statReported then
		return
	end

	self._statReported = true

	local properties = self:_getStatCommonProperties("成功")

	properties[StatEnum.EventProperties.Star] = star or 0
	properties[StatEnum.EventProperties.SideMiniGamesCompletedCombatTarget] = completedCombatTarget or {}
	properties[StatEnum.EventProperties.TotalRound] = math.floor(V3a9RacingCarModel.instance:getPlayerFinishTime())
	properties[StatEnum.EventProperties.Rank] = rank or 0

	StatController.instance:track(StatEnum.EventName.SideMiniGames, properties)
end

function V3a9RacingCarController:sendGameExitStat()
	if self._statReported then
		return
	end

	self._statReported = true

	StatController.instance:track(StatEnum.EventName.SideMiniGames, self:_getStatCommonProperties("手动退出"))
end

function V3a9RacingCarController:sendTalentUnlockStat(talentInfo)
	local talentId = talentInfo and talentInfo.giftPoint

	if talentId then
		::label_10_0::

		local talentMo = V3a9RacingTalentModel.instance:getTalentMoById(V3a9RacingCarModel.instance:getActId(), talentId)
		local talentCo = talentMo and talentMo:getCurLevelCo()
		local var_10_0 = StatEnum.EventName.SideMiniGamesUnlock
		local var_10_1 = {
			[StatEnum.EventProperties.SideMiniGamesOutsideTalentId] = StatPrefix.Talent .. tostring(talentId or 0)
		}

		var_10_1[StatEnum.EventProperties.SideMiniGamesOutsideTalentName] = StatPrefix.Talent .. ((talentCo or nil) and (talentCo.name or ""))

		StatController.instance:track(var_10_0, var_10_1)
	end
end

function V3a9RacingCarController:sendRacerUnlockStat(racerId)
	local racerCo = lua_racing_racer.configDict[racerId]
	local var_11_0 = StatEnum.EventName.SideMiniGamesUnlock
	local var_11_1 = {
		[StatEnum.EventProperties.SideMiniGamesRacerId] = StatPrefix.Racer .. tostring(racerId or 0)
	}

	var_11_1[StatEnum.EventProperties.SideMiniGamesRacerName] = StatPrefix.Racer .. ((racerCo or nil) and (racerCo.name or ""))

	StatController.instance:track(var_11_0, var_11_1)
end

function V3a9RacingCarController:finishTalentGuide()
	if not GuideController.instance:isForbidGuides() then
		local guideId = V3a9RacingCarEnum.TalentGuideId

		if not GuideModel.instance:isGuideFinish(guideId) then
			GuideController.instance:oneKeyFinishGuide(guideId, true)
		end
	end
end

function V3a9RacingCarController:onOpenCarMainView(actId)
	actId = actId or V3a9RacingCarModel.instance:getActId()

	V3a9RacingCarRpc.instance:sendGetAct243InfoRequest(actId, function()
		local param = {
			actId = actId
		}

		ViewMgr.instance:openView(ViewName.V3a9RacingCarMainView, param)
	end)
end

function V3a9RacingCarController:enterRacingCarGame()
	V3a9RacingCarModel.instance:initTrack()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.V3a9RacingCarLoadingView)
	GameSceneMgr.instance:startScene(SceneType.RacingCar, 1, V3a9RacingCarEnum.SceneLevelId.Main, true)
end

function V3a9RacingCarController:restartGame()
	V3a9RacingCarModel.instance:resetGameState()
	self:dispatchEvent(V3a9RacingCarEvent.OnRestartGame)
end

function V3a9RacingCarController:openV3a9RacingCarRecordView(param)
	ViewMgr.instance:openView(ViewName.V3a9RacingCarRecordView, param)
end

function V3a9RacingCarController:openV3a9RacingCarResultView(actId)
	local param = {
		actId = actId
	}

	ViewMgr.instance:openView(ViewName.V3a9RacingCarResultView, param)
end

function V3a9RacingCarController:openV3a9RacingCarRoleListView(actId)
	local param = {
		actId = actId
	}

	ViewMgr.instance:openView(ViewName.V3a9RacingCarRoleListView, param)
end

function V3a9RacingCarController:onOpenRewardView(actId)
	MileStoneRpc.instance:sendGetMilestoneInfoRequest({
		V3a9RacingCarEnum.MileStoneId
	}, function()
		local param = {
			actId = actId
		}

		ViewMgr.instance:openView(ViewName.V3a9RacingRewardView, param)
	end)
end

function V3a9RacingCarController:onOpenTalentView(actId)
	local param = {
		actId = actId
	}

	ViewMgr.instance:openView(ViewName.V3a9RacingTalentView, param)
end

V3a9RacingCarController.instance = V3a9RacingCarController.New()

return V3a9RacingCarController
