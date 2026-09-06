-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/agent/DivineLongYanChallengeAgent.lua

module("logic.extensions.divinelongyanchallenge.agent.DivineLongYanChallengeAgent", package.seeall)

local DivineLongYanChallengeAgent = class("DivineLongYanChallengeAgent", BaseAgent)

function DivineLongYanChallengeAgent:sendPM_DivineLongYanChallengeInfoReq(activityId)
	local req = DivineLongYanChallengeExtension_pb.PM_DivineLongYanChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineLongYanChallengeAgent:handlePM_DivineLongYanChallengeInfoRes(status, msg)
	if status == 0 then
		DivinelongyanModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineLongYanChallengeInfoRes)
	end
end

function DivineLongYanChallengeAgent:sendPM_DivineLongYanPowerChallengeReq(activityId, stageId, form)
	local req = DivineLongYanChallengeExtension_pb.PM_DivineLongYanPowerChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineLongYanChallengeAgent:handlePM_DivineLongYanPowerChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineLongYanPowerChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineLongYanChallengeAgent:sendPM_DivineLongYanUpgradeLevelReq(activityId, upLevel)
	local req = DivineLongYanChallengeExtension_pb.PM_DivineLongYanUpgradeLevelReq()

	req.activityId = activityId
	req.upLevel = upLevel

	self:sendMsg(req)
end

function DivineLongYanChallengeAgent:handlePM_DivineLongYanUpgradeLevelRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local supportPet = msg.supportPet

		DivinelongyanModel.instance:updateSupportPet(activityId, supportPet)
		GlobalDispatcher:dispatch(GlobalNotify.DivineLongYanUpgradeLevelRes)
	end
end

function DivineLongYanChallengeAgent:sendPM_DivineLongYanUpgradeSkillReq(activityId, skillType)
	local req = DivineLongYanChallengeExtension_pb.PM_DivineLongYanUpgradeSkillReq()

	req.activityId = activityId
	req.skillType = skillType

	self:sendMsg(req)
end

function DivineLongYanChallengeAgent:handlePM_DivineLongYanUpgradeSkillRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local supportPet = msg.supportPet

		DivinelongyanModel.instance:updateSupportPet(activityId, supportPet)
		GlobalDispatcher:dispatch(GlobalNotify.DivineLongYanUpgradeSkillRes)
	end
end

function DivineLongYanChallengeAgent:sendPM_DivineLongYanLineChallengeReq(activityId, form)
	local req = DivineLongYanChallengeExtension_pb.PM_DivineLongYanLineChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineLongYanChallengeAgent:handlePM_DivineLongYanLineChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineLongYanLineChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineLongYanChallengeAgent:handlePM_NotifyDivineLongYanPowerClgFinsihRes(status, msg)
	if status == 0 then
		UIJumper.instance:pushOneStack(ViewName.DivinelongyanmainView)
		UIJumper.instance:pushOneStack(ViewName.DivinelongyanpowerstageView)

		if msg.isWin then
			DivinelongyanModel.instance:updatePowerStage(msg.activityId, msg.stageId)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NotifyDivineLongYanPowerClgFinsihRes)
	end
end

function DivineLongYanChallengeAgent:handlePM_NotifyDivineLongYanLineClgFinsihRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		if msg.isWin then
			DivinelongyanModel.instance:updateLineStage(activityId)
		end

		UIJumper.instance:pushOneStack(ViewName.DivinelongyanmainView)

		local stageId = DivinelongyanModel.instance:getCurLineStageId(activityId)
		local cfgs = DivinelongyanConfig.instance:getLineStageCfgs(activityId)

		if stageId < #cfgs then
			UIJumper.instance:pushOneStack(ViewName.DivinelongyanlineView)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NotifyDivineLongYanLineClgFinsihRes)
	end
end

DivineLongYanChallengeAgent.instance = DivineLongYanChallengeAgent.New()

return DivineLongYanChallengeAgent
