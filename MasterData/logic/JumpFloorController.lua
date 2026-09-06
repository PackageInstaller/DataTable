-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/controller/JumpFloorController.lua

module("logic.extensions.jumpfloor.controller.JumpFloorController", package.seeall)

local JumpFloorController = class("JumpFloorController", BaseController)

function JumpFloorController:ctor()
	return
end

function JumpFloorController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDate, self)
end

function JumpFloorController:_onChangeDate()
	JumpFloorModel.instance:refreshOnChangeDate()
	GlobalDispatcher:dispatch(GlobalNotify.DancingLionJumpOnChangeDate)
end

function JumpFloorController:openLevelGame(activityId, stagePlanId, stageId)
	UIStateManager.instance:push(ViewName.JumpFloorGameView, JumpFloorModel.LevelMode, activityId, stagePlanId, stageId)
end

function JumpFloorController:openEndlessGame(activityId)
	UIStateManager.instance:push(ViewName.JumpFloorGameView, JumpFloorModel.EndlessMode, activityId)
end

function JumpFloorController:sendLevelGameStartReq(activityId, stageId, clientKey)
	JumpFloorAgent.instance:sendPM_DancingLionJumpGameStartReq(activityId, stageId, clientKey)
end

function JumpFloorController:sendEndlessGameStartReq(activityId, clientKey)
	JumpFloorAgent.instance:sendPM_DancingLionJumpGameStartReq(activityId, 0, clientKey)
end

function JumpFloorController:getDailyLimitNum(activityId)
	local cfg = JumpFloorConfig.instance:getActivityCfg(activityId)

	return (cfg or nil) and (cfg.dailyTimeLimit or 0)
end

function JumpFloorController:getDailyLeftNum(activityId)
	local maxNum = JumpFloorController.instance:getDailyLimitNum(activityId)
	local curNum = JumpFloorModel.instance:getDailyFinishNum()

	return (Mathf.Max(maxNum - curNum, 0))
end

function JumpFloorController:getLeftOpenNum(stagePlanId)
	local stageCfgList = JumpFloorConfig.instance:getStageListById(stagePlanId)
	local passNum = JumpFloorModel.instance:getFinishNum()
	local count = 0
	local curTimestamp = ServerTime.now()

	for i, v in ipairs(stageCfgList) do
		if passNum < i then
			local startTimestamp = GameUtil.string2time(v.opTime)

			if startTimestamp <= curTimestamp then
				count = count + 1
			end
		end
	end

	return count
end

JumpFloorController.instance = JumpFloorController.New()

return JumpFloorController
