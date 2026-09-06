-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/agent/GodDarkDragonAgent.lua

module("logic.extensions.goddarkdragon.agent.GodDarkDragonAgent", package.seeall)

local GodDarkDragonAgent = class("GodDarkDragonAgent", BaseAgent)

function GodDarkDragonAgent:sendPM_GodDarkDragonInfoReq(activityId)
	local req = GodDarkDragonExtension_pb.PM_GodDarkDragonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodDarkDragonAgent:handlePM_GodDarkDragonInfoRes(status, msg)
	if status == 0 then
		GodDarkDragonController.instance:handlePM_GodDarkDragonInfoRes(msg)
	end
end

function GodDarkDragonAgent:sendPM_GodDarkDragonBuffChallengeReq(activityId, stageId, form)
	local req = GodDarkDragonExtension_pb.PM_GodDarkDragonBuffChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function GodDarkDragonAgent:handlePM_GodDarkDragonBuffChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GodDarkDragonAgent:handlePM_NotifyGodDarkDragonBuffChallengeEndRes(status, msg)
	if status == 0 then
		GodDarkDragonController.instance:handlePM_NotifyGodDarkDragonBuffChallengeEndRes(msg)
	end
end

function GodDarkDragonAgent:sendPM_GodDarkDragonBuffConfirmReq(activityId, confirm)
	local req = GodDarkDragonExtension_pb.PM_GodDarkDragonBuffConfirmReq()

	req.confirm = confirm
	req.activityId = activityId

	self:sendMsg(req)
end

function GodDarkDragonAgent:handlePM_GodDarkDragonBuffConfirmRes(status, msg)
	if status == 0 then
		GodDarkDragonController.instance:handlePM_GodDarkDragonBuffConfirmRes(msg)
	end
end

function GodDarkDragonAgent:sendPM_GodDarkDragonMainChallengeReq(activityId, stageId, myFormLimitNum, enemyFormLimitNum, myForm, enemyForm)
	local req = GodDarkDragonExtension_pb.PM_GodDarkDragonMainChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.myFormLimitNum = myFormLimitNum
	req.enemyFormLimitNum = enemyFormLimitNum

	if myForm ~= nil then
		req.myForm:ParseFromString(myForm:SerializeToString())
	end

	if enemyForm ~= nil then
		req.enemyForm:ParseFromString(enemyForm:SerializeToString())
	end

	self:sendMsg(req)
end

function GodDarkDragonAgent:handlePM_GodDarkDragonMainChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GodDarkDragonAgent:handlePM_NotifyGodDarkDragonMainChallengeEndRes(status, msg)
	if status == 0 then
		GodDarkDragonController.instance:handlePM_NotifyGodDarkDragonMainChallengeEndRes(msg)
	end
end

function GodDarkDragonAgent:sendPM_GodDarkDragonGainPrizeReq(activityId, stageId)
	local req = GodDarkDragonExtension_pb.PM_GodDarkDragonGainPrizeReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function GodDarkDragonAgent:handlePM_GodDarkDragonGainPrizeRes(status, msg)
	if status == 0 then
		GodDarkDragonController.instance:handlePM_GodDarkDragonGainPrizeRes(msg)
	end
end

GodDarkDragonAgent.instance = GodDarkDragonAgent.New()

return GodDarkDragonAgent
