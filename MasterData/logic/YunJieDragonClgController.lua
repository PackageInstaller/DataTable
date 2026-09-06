-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/controller/YunJieDragonClgController.lua

module("logic.extensions.yunjiedragonclg.controller.YunJieDragonClgController", package.seeall)

local YunJieDragonClgController = class("YunJieDragonClgController", BaseController)

function YunJieDragonClgController:ctor()
	return
end

function YunJieDragonClgController:sendPM_YunJieDragonClgGetInfoReq(activityId)
	YunJieDragonClgAgent.instance:sendPM_YunJieDragonClgGetInfoReq(activityId)
end

function YunJieDragonClgController:handlePM_YunJieDragonClgGetInfoRes(msg)
	YunJieDragonClgModel.instance:handlePM_YunJieDragonClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YunJieDragonClgGetInfoRes)
end

function YunJieDragonClgController:sendPM_YunJieDragonClgChallengeReq(activityId, stageId, form)
	YunJieDragonClgAgent.instance:sendPM_YunJieDragonClgChallengeReq(activityId, stageId, form)
end

function YunJieDragonClgController:handlePM_Notify_YunJieDragonClgChallengeEndRes(msg)
	YunJieDragonClgModel.instance:handlePM_Notify_YunJieDragonClgChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_YunJieDragonClgChallengeEndRes)
end

function YunJieDragonClgController:sendPM_YunJieDragonClgOneKeyPassReq(activityId, leftStageCount)
	YunJieDragonClgAgent.instance:sendPM_YunJieDragonClgOneKeyPassReq(activityId, leftStageCount)
end

function YunJieDragonClgController:handlePM_YunJieDragonClgOneKeyPassRes(msg)
	YunJieDragonClgModel.instance:handlePM_YunJieDragonClgOneKeyPassRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YunJieDragonClgOneKeyPassRes)
end

function YunJieDragonClgController:enterBattleClg(activityId, stageId)
	local customFmtMo = YunJieDragonClgModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function YunJieDragonClgController:phaseHasAllPass(activityId, phaseId)
	local info = YunJieDragonClgModel.instance:getInfo(activityId)
	local stageCfgs = YunJieDragonClgConfig.instance:getStageCfgsByPhaseId(activityId, phaseId)
	local passedStageIds = info.passedStageIds
	local allPass = true

	if passedStageIds then
		for _, cfg in ipairs(stageCfgs) do
			local idx = table.indexof(passedStageIds, cfg.stageId)

			if not idx then
				allPass = false
			end
		end

		return allPass
	end

	return false
end

function YunJieDragonClgController:hasAllPass(activityId)
	local phaseCfgs = YunJieDragonClgConfig.instance:getPhaseCfgs(activityId)
	local info = YunJieDragonClgModel.instance:getInfo(activityId)
	local oneKeyPass = info.oneKeyPass

	if not info.passedStageIds then
		if phaseCfgs then
			if not #phaseCfgs then
				local phaseNum = 0

				if oneKeyPass then
					return true
				end

				if phaseNum > 0 then
					for i = 1, phaseNum do
						if not self:phaseHasAllPass(activityId, i) then
							return false
						end
					end
				else
					return false
				end

				return true
			end
		end
	end
end

function YunJieDragonClgController:getCurPhaseId(activityId)
	local info = YunJieDragonClgModel.instance:getInfo(activityId)

	if not info.passedStageIds then
		local passedStageIds = {}
		local curPassStage = #passedStageIds
		local nextStageId = curPassStage + 1
		local curTime = ServerTime.now()
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(572, activityId)
		local stageCfgs = YunJieDragonClgConfig.instance:getStageCfgs(activityId)

		nextStageId = math.min(nextStageId, #stageCfgs)

		local stageCfg = YunJieDragonClgConfig.instance:getStageCfgByStageId(activityId, nextStageId)
		local curPhaseId = 1
		local oneKeyPass = info.oneKeyPass

		if oneKeyPass then
			local phaseCfgs = YunJieDragonClgConfig.instance:getPhaseCfgs(activityId)

			return #phaseCfgs
		elseif stageCfg then
			if checknumber(stageCfg.phaseId) > 0 then
				if not stageCfg.phaseId then
					local phaseId = 1
					local phaseCfg = YunJieDragonClgConfig.instance:getPhaseCfgById(activityId, phaseId)
					local openDay = phaseCfg and checknumber(phaseCfg.openDay)
					local isUnLock = curTime >= startTime + (openDay - 1) * 86400

					if isUnLock then
						curPhaseId = checknumber(stageCfg.phaseId) > 0 and stageCfg.phaseId or 1
					else
						curPhaseId = checknumber(stageCfg.phaseId) > 0 and stageCfg.phaseId - 1 or 1
						curPhaseId = math.max(curPhaseId, 1)
					end
				end
			end
		end

		return curPhaseId
	end
end

function YunJieDragonClgController:getOpenStageLeftNum(activityId)
	local curTime = ServerTime.now()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(572, activityId)
	local info = YunJieDragonClgModel.instance:getInfo(activityId)

	if not info.passedStageIds then
		local passedStageIds = {}
		local curPassStage = #passedStageIds
		local phaseCfgs = YunJieDragonClgConfig.instance:getPhaseCfgs(activityId)
		local openUnlockPhase = 0

		for i, cfg in ipairs(phaseCfgs) do
			local openDay = cfg.openDay
			local unLockTime = startTime + (openDay - 1) * 86400

			if unLockTime <= curTime then
				openUnlockPhase = cfg.phaseId
			end
		end

		local stageCfgs = YunJieDragonClgConfig.instance:getStageCfgsByPhaseId(activityId, openUnlockPhase)
		local lastStage = stageCfgs[#stageCfgs]
		local lastStageId = lastStage.stageId

		return lastStageId - curPassStage
	end
end

function YunJieDragonClgController:hasNeedOpenPhase(activityId)
	local curTime = ServerTime.now()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(572, activityId)
	local phaseCfgs = YunJieDragonClgConfig.instance:getPhaseCfgs(activityId)

	for i = #phaseCfgs, 1, -1 do
		local cfg = phaseCfgs[i]

		if cfg then
			local openDay = cfg.openDay
			local unLockTime = startTime + (openDay - 1) * 86400

			if curTime < unLockTime then
				return true
			end
		end
	end

	return false
end

YunJieDragonClgController.instance = YunJieDragonClgController.New()

return YunJieDragonClgController
