-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/agent/InfiniteFutureAgent.lua

module("logic.extensions.infinitefuture.agent.InfiniteFutureAgent", package.seeall)

local InfiniteFutureAgent = class("InfiniteFutureAgent", BaseAgent)

function InfiniteFutureAgent:sendPM_InfiniteFutureInfoReq(activityId)
	local req = InfiniteFutureExtension_pb.PM_InfiniteFutureInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function InfiniteFutureAgent:handlePM_InfiniteFutureInfoRes(status, msg)
	if status == 0 then
		InfinitefutureModel.instance:getInfos(msg)
	end
end

function InfiniteFutureAgent:sendPM_InfiniteFutureChallengeReq(activityId, stageId, teamId, simpleForm)
	local req = InfiniteFutureExtension_pb.PM_InfiniteFutureChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function InfiniteFutureAgent:handlePM_InfiniteFutureChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	elseif ViewMgr.instance:isOpen(ViewName.InfinfuMissionView) then
		UIStateManager.instance:clear(true)
	end
end

function InfiniteFutureAgent:sendPM_InfiniteFutureResetReq(activityId, stageId, teamId)
	local req = InfiniteFutureExtension_pb.PM_InfiniteFutureResetReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function InfiniteFutureAgent:handlePM_InfiniteFutureResetRes(status, msg)
	if status == 0 then
		local teamid = msg.teamId

		InfinitefutureModel.instance:updateStageInfo(nil, teamid)
		InfinitefutureModel.instance:resetStageInfo(msg)
	end
end

function InfiniteFutureAgent:sendPM_InfiniteFutureGetBuffReq(activityId)
	local req = InfiniteFutureExtension_pb.PM_InfiniteFutureGetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function InfiniteFutureAgent:handlePM_InfiniteFutureGetBuffRes(status, msg)
	if status == 0 then
		InfinitefutureModel.instance:setCurSignInfo()
	end
end

function InfiniteFutureAgent:sendPM_InfiniteFutureSelectBuffReq(activityId, buffId)
	local req = InfiniteFutureExtension_pb.PM_InfiniteFutureSelectBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function InfiniteFutureAgent:handlePM_InfiniteFutureSelectBuffRes(status, msg)
	if status == 0 then
		InfinitefutureModel.instance:setSelectBuffInfo(msg.buffId)
	end
end

function InfiniteFutureAgent:handlePM_NotifyInfiniteFutureChallengeEndRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local iswin = msg.isWin
		local nextstage = msg.nextStage
		local teamid = msg.teamId

		if iswin then
			InfinitefutureModel.instance:updateStageInfo(nextstage, teamid)

			if msg.activityId == 123015 then
				local totalCount = InfinitefutureConfig.instance:getStageCount(msg.activityId)

				if totalCount < InfinitefutureModel.instance.curStageId then
					CustomFmtController.instance:showCommonPassViewWithJump(msg.changeSetId)
					UIJumper.instance:removeTopState(ViewName.DivineAnLevelsView)
				end
			end
		end

		InfinitefutureModel.instance:setIsPass(nextstage)
		InfinitefutureController.instance:startBattle(msg)
		self:sendPM_InfiniteFutureInfoReq(activityid)
	end
end

InfiniteFutureAgent.instance = InfiniteFutureAgent.New()

return InfiniteFutureAgent
