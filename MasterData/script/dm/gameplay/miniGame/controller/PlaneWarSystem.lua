-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/controller/PlaneWarSystem.lua

PlaneWarSystem = class("PlaneWarSystem", legs.Actor)

PlaneWarSystem:has("_miniGameService", {
	is = "r"
}):injectWith("MiniGameService")
PlaneWarSystem:has("_planeWarStage", {
	is = "r"
})
PlaneWarSystem:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

EVT_PLANEWAR_STAGE_PAUSE = "EVT_PLANEWAR_STAGE_PAUSE"
EVT_PLANEWAR_STAGE_RESUME = "EVT_PLANEWAR_STAGE_RESUME"
EVT_PLANEWAR_GAMEOVER = "EVT_PLANEWAR_GAMEOVER"
EVT_PLANEWAR_STAGE_CLOSE = "EVT_PLANEWAR_STAGE_CLOSE"
EVT_PLANEWAR_RSTARTGAME = "EVT_PLANEWAR_RSTARTGAME"
EVT_PLANEWAR_PAUSETIP_CLOSE = "EVT_PLANEWAR_PAUSETIP_CLOSE"
EVT_PLANEWAR_RESTARTGAME = "EVT_PLANEWAR_RESTARTGAME"
EVT_PLANEWAR_QUITGAME = "EVT_PLANEWAR_QUITGAME"
EVT_PLANEWAR_CONTINUEGAME = "EVT_PLANEWAR_CONTINUEGAME"

function PlaneWarSystem:initialize(miniGameSystem)
	super.initialize(self)

	self._miniGameSystem = miniGameSystem

	require("dm.gameplay.miniGame.model.plane.PlaneWarStage")

	self._planeWarStage = PlaneWarStage:new()
end

function PlaneWarSystem:getGameDesc()
	return Strings:get("PlaneGameDesc1")
end

function PlaneWarSystem:tryEnterByStage(pointId)
	local config = ConfigReader:getRecordById("StagePoint", pointId)
	local miniGameConfig = config.PointGameConfig

	self._planeWarStage:sync(miniGameConfig)

	local view = self:getInjector():getInstance("PlaneWarStageView")

	self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
		pointId = miniGameConfig.MiniGameConfig.point,
		stagePointId = pointId
	}))
end

function PlaneWarSystem:tryEnterByActivity(activityId)
	local miniGameConfig = self:getPlaneWarActivity():getMiniGameConfig()
	local view = self:getInjector():getInstance("PlaneWarActivityView")

	self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
		pointId = miniGameConfig.point,
		activityId = activityId
	}))
end

function PlaneWarSystem:getPlaneWarActivity()
	require("dm.gameplay.miniGame.model.plane.PlaneWarConfig")

	local allActivityIds = self._activitySystem:getAllActivityIds()

	for i = 1, #allActivityIds do
		local activityId = allActivityIds[i]
		local activity = self._activitySystem:getActivityById(activityId)

		if activity and activity:getType() == "MINIGAME" and self._activitySystem:isActivityOpen(activityId) then
			local miniGameConfig = activity:getConfig().ActivityConfig.MiniGameConfig

			if miniGameConfig and miniGameConfig.type == MiniGameType.kPlaneWar then
				return activity
			end
		end
	end
end

function PlaneWarSystem:getClubGamePlaneData()
	return self._miniGameSystem:getGameByType(MiniGameType.kPlaneWar)
end

function PlaneWarSystem:tryEnterByClub()
	local pointId = self:getClubGamePlaneData():getGamePointId()
	local view = self:getInjector():getInstance("PlaneWarClubView")

	self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
		pointId = pointId
	}))
end

function PlaneWarSystem:getPlaneClubGameTaskListOj()
	return self:getClubGamePlaneData():getTaskList()
end

function PlaneWarSystem:getPlaneClubGameScoreListOj()
	return self:getClubGamePlaneData():getScoreList()
end

function PlaneWarSystem:getPlaneClubGameScoreStatusById(scoreId)
	local data = self:getPlaneClubGameScoreListOj():getDataByScore(scoreId)
	local curScore = self:getClubGamePlaneData():getWeeklyTotalScore()
	local weeklyRewardedScore = self:getClubGamePlaneData():getWeeklyRewardedScore()

	if scoreId <= curScore then
		if weeklyRewardedScore[tostring(scoreId)] then
			return TaskStatus.kGet
		else
			return TaskStatus.kFinishNotGet
		end
	end

	return TaskStatus.kUnfinish
end

function PlaneWarSystem:hasResidueDegree()
	local planeActivity = self:getPlaneWarActivity()

	if planeActivity == nil then
		return false
	end

	return self:getClubGamePlaneData():getTimes() > 0
end

function PlaneWarSystem:getBuyCostItemId()
	local activityConfig = self:getPlaneWarActivity():getActivityConfig()

	return activityConfig.buyTimesCost.id
end

function PlaneWarSystem:getCostBuyTimes(times)
	local activityConfig = self:getPlaneWarActivity():getActivityConfig()
	local amount = activityConfig.buyTimesCost.amount

	if not amount[times] then
		return amount[times]
	end
end

function PlaneWarSystem:getCost()
	local activityConfig = self:getPlaneWarActivity():getActivityConfig()

	return activityConfig.buyTimesCost.amount
end

function PlaneWarSystem:getEachBuyNum(times)
	local activityConfig = self:getPlaneWarActivity():getActivityConfig()

	return activityConfig.eachBuyNum
end

function PlaneWarSystem:isTodayNotPlayed()
	return self:getClubGamePlaneData():getTimes() == self:getClubGamePlaneData():getTimesMax()
end

function PlaneWarSystem:hasRedPointByReward()
	local clubGamePlaneData = self:getClubGamePlaneData()

	if clubGamePlaneData:getTaskList():hasRedPoint() then
		return true
	end

	local scoreListOj = clubGamePlaneData:getScoreList()

	for id, data in pairs(scoreListOj:getMap()) do
		id = tonumber(id)

		local status = self:getPlaneClubGameScoreStatusById(id)

		if status == TaskStatus.kFinishNotGet then
			return true
		end
	end
end

function PlaneWarSystem:requestPlaneClubGameTaskList(callFunc)
	local params = {
		game = gameId
	}

	self._miniGameService:requestPlaneClubGameTaskList(params, true, function(response)
		self:getPlaneClubGameTaskListOj():synchronize(response.data.showTasks)

		if callFunc then
			callFunc(response)
		end
	end)
end
