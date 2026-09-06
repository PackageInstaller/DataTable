-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/agent/SeekFoodAgent.lua

module("logic.extensions.seekfood.agent.SeekFoodAgent", package.seeall)

local SeekFoodAgent = class("SeekFoodAgent", BaseAgent)

function SeekFoodAgent:sendPM_SeekFoodInfoReq(activityId)
	local req = SeekFoodExtension_pb.PM_SeekFoodInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SeekFoodAgent:handlePM_SeekFoodInfoRes(status, msg)
	if status == 0 then
		SeekFoodController.instance:handlePM_SeekFoodInfoRes(msg)
	end
end

function SeekFoodAgent:sendPM_SeekFoodDispatchReq(activityId, foodId, materialId, petIds)
	local req = SeekFoodExtension_pb.PM_SeekFoodDispatchReq()

	req.activityId = activityId
	req.foodId = foodId
	req.materialId = materialId

	if petIds then
		for _, v in ipairs(petIds) do
			req.petIds:append(v)
		end
	end

	self:sendMsg(req)
end

function SeekFoodAgent:handlePM_SeekFoodDispatchRes(status, msg)
	if status == 0 then
		SeekFoodController.instance:handlePM_SeekFoodDispatchRes(msg)
	end
end

function SeekFoodAgent:sendPM_SeekFoodGainDispatchReq(activityId, foodId, materialId)
	local req = SeekFoodExtension_pb.PM_SeekFoodGainDispatchReq()

	req.activityId = activityId
	req.foodId = foodId
	req.materialId = materialId

	self:sendMsg(req)
end

function SeekFoodAgent:handlePM_SeekFoodGainDispatchRes(status, msg)
	SeekFoodController.instance:handlePM_SeekFoodGainDispatchRes(status, msg)
end

function SeekFoodAgent:sendPM_SeekFoodFightBossReq(activityId, foodId, form)
	local req = SeekFoodExtension_pb.PM_SeekFoodFightBossReq()

	req.activityId = activityId
	req.foodId = foodId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SeekFoodAgent:handlePM_SeekFoodFightBossRes(status, msg)
	SeekFoodController.instance:handlePM_SeekFoodFightBossRes(status, msg)
end

function SeekFoodAgent:sendPM_SeekFoodGainPrizeReq(activityId, prizeId)
	local req = SeekFoodExtension_pb.PM_SeekFoodGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SeekFoodAgent:handlePM_SeekFoodGainPrizeRes(status, msg)
	if status == 0 then
		SeekFoodController.instance:handlePM_SeekFoodGainPrizeRes(msg)
	end
end

function SeekFoodAgent:handlePM_NotifySeekFoodFightBossEndRes(status, msg)
	if status == 0 then
		SeekFoodController.instance:handlePM_NotifySeekFoodFightBossEndRes(msg)
	end
end

SeekFoodAgent.instance = SeekFoodAgent.New()

return SeekFoodAgent
