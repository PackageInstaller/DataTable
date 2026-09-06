-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/agent/DragonTrialAgent.lua

module("logic.extensions.dragontrial.agent.DragonTrialAgent", package.seeall)

local DragonTrialAgent = class("DragonTrialAgent", BaseAgent)

DragonTrialAgent.PM_DragonTrialSecondTrialFightFinishRes = "DragonTrialAgent_PM_DragonTrialSecondTrialFightFinishRes"
DragonTrialAgent.PM_DragonTrialFirstTrialFightFinishRes = "DragonTrialAgent_PM_DragonTrialFirstTrialFightFinishRes"
DragonTrialAgent.PM_DragonTrialViewRankRes = "DragonTrialAgent_PM_DragonTrialViewRankRes"
DragonTrialAgent.PM_DragonTrialGainCultivateTaskPrizeRes = "DragonTrialAgent_PM_DragonTrialGainCultivateTaskPrizeRes"
DragonTrialAgent.PM_DragonTrialGainDailyTaskPrizeRes = "DragonTrialAgent_PM_DragonTrialGainDailyTaskPrizeRes"
DragonTrialAgent.PM_DragonTrialBuyTimesRes = "DragonTrialAgent_PM_DragonTrialBuyTimesRes"
DragonTrialAgent.PM_DragonTrialSecondFightRes = "DragonTrialAgent_PM_DragonTrialSecondFightRes"
DragonTrialAgent.PM_DragonTrialSetDreamTrialFormRes = "DragonTrialAgent_PM_DragonTrialSetDreamTrialFormRes"
DragonTrialAgent.PM_DragonTrialFirstFightRes = "DragonTrialAgent_PM_DragonTrialFirstFightRes"
DragonTrialAgent.PM_DragonTrialSetFirstTrialFormRes = "DragonTrialAgent_PM_DragonTrialSetFirstTrialFormRes"
DragonTrialAgent.PM_DragonTrialGetInfoRes = "DragonTrialAgent_PM_DragonTrialGetInfoRes"
DragonTrialAgent.PM_DragonTrialValidatePetStrengthenRes = "DragonTrialAgent_PM_DragonTrialValidatePetStrengthenRes"

function DragonTrialAgent:sendPM_DragonTrialGetInfoReq(activityId)
	local req = DragonTrialExtension_pb.PM_DragonTrialGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialGetInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialGetInfoRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialSetFirstTrialFormReq(activityId, form)
	local req = DragonTrialExtension_pb.PM_DragonTrialSetFirstTrialFormReq()

	req.activityId = activityId

	for i = 1, 9 do
		local bagPetId = checknumber(form.pos[i])

		req.form.pos:append(bagPetId)
	end

	req.form.formId = form.formId
	req.form.extParams.heroSkillId = form.extParams.heroSkillId
	req.form.extParams.psychicSkillId = form.extParams.psychicSkillId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialSetFirstTrialFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialSetFirstTrialFormRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialFirstFightReq(activityId, stageId)
	local req = DragonTrialExtension_pb.PM_DragonTrialFirstFightReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialFirstFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialFirstFightRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialSetDreamTrialFormReq(activityId, form)
	local req = DragonTrialExtension_pb.PM_DragonTrialSetDreamTrialFormReq()

	req.activityId = activityId

	for i = 1, 9 do
		local bagPetId = checknumber(form.pos[i])

		req.form.pos:append(bagPetId)
	end

	req.form.formId = form.formId
	req.form.extParams.heroSkillId = form.extParams.heroSkillId
	req.form.extParams.psychicSkillId = form.extParams.psychicSkillId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialSetDreamTrialFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialSetDreamTrialFormRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialSecondFightReq(activityId, dragonTrial)
	local req = DragonTrialExtension_pb.PM_DragonTrialSecondFightReq()

	req.activityId = activityId
	req.dragonTrial = dragonTrial

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialSecondFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialSecondFightRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialBuyTimesReq(activityId, dragonTrial)
	local req = DragonTrialExtension_pb.PM_DragonTrialBuyTimesReq()

	req.activityId = activityId
	req.dragonTrial = dragonTrial

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialBuyTimesRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialBuyTimesRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialGainDailyTaskPrizeReq(activityId, taskId)
	local req = DragonTrialExtension_pb.PM_DragonTrialGainDailyTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialGainDailyTaskPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialGainDailyTaskPrizeRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialGainCultivateTaskPrizeReq(activityId, raceId, taskId)
	local req = DragonTrialExtension_pb.PM_DragonTrialGainCultivateTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId
	req.raceId = raceId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialGainCultivateTaskPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialGainCultivateTaskPrizeRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialViewRankReq(activityId, stageId, dragonTrial)
	local req = DragonTrialExtension_pb.PM_DragonTrialViewRankReq()

	req.activityId = activityId
	req.stageId = stageId
	req.dragonTrial = dragonTrial

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialViewRankRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialViewRankRes, status, msg)
end

function DragonTrialAgent:handlePM_DragonTrialFirstTrialFightFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialFirstTrialFightFinishRes, status, msg)
end

function DragonTrialAgent:handlePM_DragonTrialSecondTrialFightFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialSecondTrialFightFinishRes, status, msg)
end

function DragonTrialAgent:sendPM_DragonTrialValidatePetStrengthenReq(activityId, petId)
	local req = DragonTrialExtension_pb.PM_DragonTrialValidatePetStrengthenReq()

	req.activityId = activityId
	req.petId = petId

	self:sendMsg(req)
end

function DragonTrialAgent:handlePM_DragonTrialValidatePetStrengthenRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(DragonTrialAgent.PM_DragonTrialValidatePetStrengthenRes, status, msg)
end

DragonTrialAgent.instance = DragonTrialAgent.New()

return DragonTrialAgent
