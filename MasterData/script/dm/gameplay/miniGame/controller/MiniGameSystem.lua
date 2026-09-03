-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/controller/MiniGameSystem.lua

require("dm.gameplay.miniGame.MiniGameConfig")
require("dm.gameplay.miniGame.controller.DartsSystem")
require("dm.gameplay.miniGame.controller.JumpSystem")
require("dm.gameplay.miniGame.controller.PlaneWarSystem")

MiniGameSystem = class("MiniGameSystem", legs.Actor)

MiniGameSystem:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
MiniGameSystem:has("_activityService", {
	is = "r"
}):injectWith("ActivityService")
MiniGameSystem:has("_miniGameService", {
	is = "r"
}):injectWith("MiniGameService")
MiniGameSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
MiniGameSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
MiniGameSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MiniGameSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
MiniGameSystem:has("_rotation", {
	is = "rw"
})
MiniGameSystem:has("_dartsSystem", {
	is = "r"
})
MiniGameSystem:has("_jumpSystem", {
	is = "r"
})
MiniGameSystem:has("_planeWarSystem", {
	is = "r"
})

local miniGameActivityFunc = {
	[MiniGameType.kDarts] = function(sys, pointId)
		sys:getDartsSystem():tryEnterByActivity(pointId)
	end,
	[MiniGameType.kJump] = function(sys, pointId)
		sys:getJumpSystem():tryEnterByActivity(pointId)
	end,
	[MiniGameType.kPlaneWar] = function(sys, pointId)
		sys:getPlaneWarSystem():tryEnterByActivity(pointId)
	end
}

function MiniGameSystem:inintRotation()
	self._rotation = false
end

function MiniGameSystem:initialize()
	super.initialize(self)
	self:inintRotation()
	self:initSystem()
end

function MiniGameSystem:userInject(injector)
	injector:injectInto(self._rankSystem)
	injector:injectInto(self._dartsSystem)
	injector:injectInto(self._jumpSystem)
	injector:injectInto(self._planeWarSystem)
end

function MiniGameSystem:initSystem()
	self._dartsSystem = DartsSystem:new(self)
	self._jumpSystem = JumpSystem:new(self)
	self._planeWarSystem = PlaneWarSystem:new(self)
end

function MiniGameSystem:tryEnterByStage(pointId)
	if GameConfigs.forbiddenMiniGame then
		self:dispatch(ShowTipEvent({
			tip = GameConfigs.forbiddenMiniGameTips
		}))

		return
	end

	local config = ConfigReader:getRecordById("StagePoint", pointId)
	local gameType = config.PointGameConfig.MiniGameConfig.type

	if miniGameStageFunc[gameType] then
		miniGameStageFunc[gameType](self, pointId)
	end
end

function MiniGameSystem:getActivityByGameType(gameType)
	local map = self._activitySystem:getActivitysByType("MINIGAME")

	for activityId, activity in pairs(map) do
		local activityConfig = activity:getActivityConfig()

		if activityConfig.MiniGameConfig.type == gameType then
			return activity
		end
	end

	return nil
end

function MiniGameSystem:tryEnter(data)
	local activityId = data and data.activityId
	local activity = self._activitySystem:getActivityById(activityId)

	activity = activity or self._activitySystem:getActivityByType(ActivityType.KMiniGame)

	if activity and self._activitySystem:isActivityOpen(activity:getId()) then
		self:tryEnterByActivity(activity:getId())
	end
end

function MiniGameSystem:tryEnterByActivityType(gameType)
	if GameConfigs.forbiddenMiniGame then
		self:dispatch(ShowTipEvent({
			tip = GameConfigs.forbiddenMiniGameTips
		}))

		return
	end

	local activity = self:getActivityByGameType(gameType)

	self:tryEnterByActivity(activity:getId())
end

function MiniGameSystem:tryEnterByActivity(activityId)
	if GameConfigs.forbiddenMiniGame then
		self:dispatch(ShowTipEvent({
			tip = GameConfigs.forbiddenMiniGameTips
		}))

		return
	end

	local config = ConfigReader:getRecordById("Activity", activityId)
	local gameType = config.ActivityConfig.MiniGameConfig.type

	if miniGameActivityFunc[gameType] then
		miniGameActivityFunc[gameType](self, activityId)
	end
end

function MiniGameSystem:getActivityById(activityId)
	return self._activitySystem:getActivityById(activityId)
end

function MiniGameSystem:getRankListOjById(activityId, rankType)
	return self._rankSystem:getRank():getRankListByTypeAndSubId(rankType, activityId)
end

function MiniGameSystem:getRankListById(activityId, rankType)
	return self:getRankListOjById(activityId, rankType):getList()
end

function MiniGameSystem:requestActivityRankData(rankType, subId, rankStart, rankEnd, callFunc)
	local data = {
		type = rankType,
		subId = subId,
		rankStart = rankStart,
		rankEnd = rankEnd
	}

	self._rankSystem:requestAloneRankData(data, function(response)
		if callFunc then
			callFunc(response)
		end

		self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
	end)
end

function MiniGameSystem:requestActivityGameBegin(activityId, callFunc)
	local params = {
		activityId = activityId,
		param = {
			doActivityType = 101
		}
	}

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callFunc then
				callFunc(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_MINIGAME_BEGIN_SCUESS))
			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		end
	end)
end

function MiniGameSystem:requestActivityGameBuyTimes(activityId, callFunc)
	local params = {
		activityId = activityId,
		param = {
			doActivityType = 102
		}
	}

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callFunc then
				callFunc(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS))
			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		end
	end)
end

function MiniGameSystem:requestActivityGameResult(activityId, param, callFunc)
	param.doActivityType = 103

	local params = {
		param = param,
		activityId = activityId
	}

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_ACTIVITY_MINIGAME_RESULT_SCUESS, {
				response = response
			}))
			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		end

		if callFunc then
			callFunc(response)
		end
	end)
end

function MiniGameSystem:requestActivityGameGetReward(activityId, taskId, callFunc, type)
	local params = {
		param = {
			doActivityType = (type or nil) and type,
			taskId = taskId
		},
		activityId = activityId
	}

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callFunc then
				callFunc(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_MINIGAME_GETREWARD_SCUESS, {
				response = response.data.reward
			}))
			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		end
	end)
end

function MiniGameSystem:requestActivityGameGetCumulativeReward(activityId, taskId, callFunc)
	local params = {
		param = {
			doActivityType = 104,
			taskId = taskId
		},
		activityId = activityId
	}

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callFunc then
				callFunc(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_MINIGAME_GETREWARD_SCUESS, {
				response = response.data.reward
			}))
			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		end
	end)
end
