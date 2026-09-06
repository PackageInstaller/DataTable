-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/agent/NewYearPrayAgent.lua

module("logic.extensions.newyearpray.agent.NewYearPrayAgent", package.seeall)

local NewYearPrayAgent = class("NewYearPrayAgent", BaseAgent)

function NewYearPrayAgent:sendPM_NewYearPrayGetInfoReq(activityId)
	local req = NewYearPrayExtension_pb.PM_NewYearPrayGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NewYearPrayAgent:handlePM_NewYearPrayGetInfoRes(status, msg)
	if status == 0 then
		NewYearPrayController.instance:handlePM_NewYearPrayGetInfoRes(msg)
	end
end

function NewYearPrayAgent:sendPM_NewYearPrayDoPrayReq(activityId, stepChoices)
	local req = NewYearPrayExtension_pb.PM_NewYearPrayDoPrayReq()

	req.activityId = activityId

	for i, v in ipairs(stepChoices) do
		local info = NewYearPrayExtension_pb.PM_StepChoice()

		info.stepId = v.stepId

		if v.choiceId then
			info.choiceId = v.choiceId
		end

		req.stepChoices:add():ParseFromString(info:SerializeToString())
	end

	self:sendMsg(req)
end

function NewYearPrayAgent:handlePM_NewYearPrayDoPrayRes(status, msg)
	if status == 0 then
		NewYearPrayController.instance:handlePM_NewYearPrayDoPrayRes(msg)
	end
end

function NewYearPrayAgent:sendPM_NewYearPrayGainProgressPrizeReq(activityId, dataBitId)
	local req = NewYearPrayExtension_pb.PM_NewYearPrayGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function NewYearPrayAgent:handlePM_NewYearPrayGainProgressPrizeRes(status, msg)
	if status == 0 then
		NewYearPrayController.instance:handlePM_NewYearPrayGainProgressPrizeRes(msg)
	end
end

NewYearPrayAgent.instance = NewYearPrayAgent.New()

return NewYearPrayAgent
