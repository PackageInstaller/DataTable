-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/agent/RichManXPlanAgent.lua

module("logic.extensions.richmanxplan.agent.RichManXPlanAgent", package.seeall)

local RichManXPlanAgent = class("RichManXPlanAgent", BaseAgent)

function RichManXPlanAgent:sendPM_RichManXPlanInfoReq(activityId)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanInfoRes(status, msg)
	if status == 0 then
		RichmanxplanModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanInfoRes)
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanDiceReq(activityId, diceType, param)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanDiceReq()

	req.activityId = activityId
	req.diceType = diceType
	req.param = param

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanDiceRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanDiceRes, status, msg.dice)
end

function RichManXPlanAgent:sendPM_RichManXPlanRunReq(activityId, runList)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanRunReq()

	req.activityId = activityId

	for i, v in ipairs(runList) do
		local add = req.runList:add()

		add.targetZoneId = v.targetZoneId
		add.targetGridId = v.targetGridId
		add.isConvey = checkbool(v.isConvey)
		add.useStepNum = v.useStepNum
	end

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanRunRes(status, msg)
	if status == 0 then
		RichmanxplanModel.instance:setEventState(msg.activityId, RichmanxplanController.RichmanState.Free)
		RichmanxplanController.instance:handlePM_RichManXPlanRunRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanRunRes, msg)
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanEventReq(activityId, cancel, handleParam)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanEventReq()

	req.activityId = activityId
	req.cancel = cancel
	req.handleParam = not handleParam and "" or handleParam

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanEventRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local isEnd = msg.isEnd

		RichmanxplanController.instance:handlePM_RichManXPlanEventRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanEventRes, msg)

		if isEnd then
			RichManXPlanAgent.instance:sendPM_RichManXPlanInfoReq(activityId)
		end
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanWorkInfoReq(activityId)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanWorkInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanWorkInfoRes(status, msg)
	if status == 0 then
		RichmanxplanModel.instance:setWorkInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanWorkInfoRes)
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanWorkGainReq(activityId)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanWorkGainReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanWorkGainRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("领取收益成功")

		local activityId = msg.activityId
		local positions = msg.positions

		RichmanxplanModel.instance:updatePositions(activityId, positions)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanWorkGainRes)
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanWorkUnlockReq(activityId, posId)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanWorkUnlockReq()

	req.activityId = activityId
	req.posId = posId

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanWorkUnlockRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local position = msg.position

		RichmanxplanModel.instance:unlockWorkPosition(activityId, position)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanWorkUnlockRes)
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanWorkSetPetReq(activityId, petId, posId)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanWorkSetPetReq()

	req.activityId = activityId
	req.petId = petId
	req.posId = posId

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanWorkSetPetRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local updatePos = msg.updatePos

		RichmanxplanModel.instance:updatePositionsNotFull(activityId, updatePos)
		self:sendPM_RichManXPlanWorkInfoReq(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanWorkSetPetRes)
	end
end

function RichManXPlanAgent:sendPM_RichManXPlanWorkPetStarLevelUpReq(activityId, petId, usePetIds)
	local req = RichManXPlanExtension_pb.PM_RichManXPlanWorkPetStarLevelUpReq()

	req.activityId = activityId
	req.petId = petId

	for i, v in ipairs(usePetIds) do
		req.usePetIds:append(v)
	end

	self:sendMsg(req)
end

function RichManXPlanAgent:handlePM_RichManXPlanWorkPetStarLevelUpRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local updatePos = msg.updatePos

		RichmanxplanModel.instance:updatePositionsNotFull(activityId, updatePos)
		self:sendPM_RichManXPlanWorkInfoReq(activityId)
		FloatWordMgr.instance:show("升星成功")
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanWorkPetStarLevelUpRes)
	end
end

function RichManXPlanAgent:handlePM_NotifyRichManXPlanScoreChangeRes(status, msg)
	if status == 0 then
		RichmanxplanController.instance:handlePM_NotifyRichManXPlanScoreChangeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyRichManXPlanScoreChangeRes)
	end
end

function RichManXPlanAgent:handlePM_NotifyRichManXPlanPetChangeRes(status, msg)
	if status == 0 then
		RichmanxplanModel.instance:workPetsChange(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyRichManXPlanPetChangeRes)
	end
end

RichManXPlanAgent.instance = RichManXPlanAgent.New()

return RichManXPlanAgent
