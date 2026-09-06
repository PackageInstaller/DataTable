-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/agent/PetGrowthPathAgent.lua

module("logic.extensions.petgrowthpath.agent.PetGrowthPathAgent", package.seeall)

local PetGrowthPathAgent = class("PetGrowthPathAgent", BaseAgent)

function PetGrowthPathAgent:sendPM_PetGrowthPathGetInfoReq(activityId)
	local req = PetGrowthPathExtension_pb.PM_PetGrowthPathGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PetGrowthPathAgent:handlePM_PetGrowthPathGetInfoRes(status, msg)
	if status == 0 then
		GrowUpRoadController.instance:handlePM_PetGrowthPathGetInfoRes(msg)
	end
end

function PetGrowthPathAgent:sendPM_PetGrowthPathGainPetReq(activityId)
	local req = PetGrowthPathExtension_pb.PM_PetGrowthPathGainPetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PetGrowthPathAgent:handlePM_PetGrowthPathGainPetRes(status, msg)
	if status == 0 then
		GrowUpRoadController.instance:handlePM_PetGrowthPathGainPetRes(msg)
	end
end

function PetGrowthPathAgent:sendPM_PetGrowthPathGetTaskInfosReq(activityId)
	local req = PetGrowthPathExtension_pb.PM_PetGrowthPathGetTaskInfosReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PetGrowthPathAgent:handlePM_PetGrowthPathGetTaskInfosRes(status, msg)
	if status == 0 then
		GrowUpRoadController.instance:handlePM_PetGrowthPathGetTaskInfosRes(msg)
	end
end

function PetGrowthPathAgent:sendPM_PetGrowthPathGainTaskPrizeReq(activityId, taskId)
	local req = PetGrowthPathExtension_pb.PM_PetGrowthPathGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function PetGrowthPathAgent:handlePM_PetGrowthPathGainTaskPrizeRes(status, msg)
	if status == 0 then
		GrowUpRoadController.instance:handlePM_PetGrowthPathGainTaskPrizeRes(msg)
	end
end

function PetGrowthPathAgent:sendPM_PetGrowthPathStrengthenReq(activityId, petId)
	local req = PetGrowthPathExtension_pb.PM_PetGrowthPathStrengthenReq()

	req.activityId = activityId
	req.petId = petId

	self:sendMsg(req)
end

function PetGrowthPathAgent:handlePM_PetGrowthPathStrengthenRes(status, msg)
	if status == 0 then
		GrowUpRoadController.instance:handlePM_PetGrowthPathStrengthenRes(msg)

		if msg.activityId == checknumber(NianNianChallConfig.instance:getCommonCfg("PET_GROWTH_PATH_ACTIVITY_ID")) then
			local curV = NianNianChallModel.instance:getGrowthPath()

			NianNianChallModel.instance:setGrowthPath(curV + 1)
		end
	end
end

PetGrowthPathAgent.instance = PetGrowthPathAgent.New()

return PetGrowthPathAgent
