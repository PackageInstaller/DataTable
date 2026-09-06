-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/agent/SixArtDaoguanAgent.lua

module("logic.extensions.sixartdaoguan.agent.SixArtDaoguanAgent", package.seeall)

local SixArtDaoguanAgent = class("SixArtDaoguanAgent", BaseAgent)

function SixArtDaoguanAgent:sendPM_SixArtDaoguanGetInfoReq(activityId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanGetInfoRes(status, msg)
	if status == 0 then
		SixartdaoguanModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanGetInfoRes)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanRerandomDropBuffReq(activityId, challengeId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanRerandomDropBuffReq()

	req.activityId = activityId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanRerandomDropBuffRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("刷新Buff成功")
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanRerandomDropBuffRes, msg)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanSelectDropBuffReq(activityId, challengeId, buffId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanSelectDropBuffReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.buffId = buffId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanSelectDropBuffRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("选择Buff成功")
		SixartdaoguanModel.instance:onSelectDropBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanSelectDropBuffRes)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanReShuffleDropBuffReq(activityId, challengeId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanReShuffleDropBuffReq()

	req.activityId = activityId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanReShuffleDropBuffRes(status, msg)
	if status == 0 then
		SixartdaoguanModel.instance:onReShuffleDropBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanReShuffleDropBuffRes, msg.activityId)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanStartFightReq(activityId, challengeId, stageId, form)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanStartFightReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanStartFightRes(status, msg)
	if status == 0 then
		SixartdaoguanController.instance:onStartFightRes()
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanStartFightRes)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanContinueFightReq(activityId, challengeId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanContinueFightReq()

	req.activityId = activityId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanContinueFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanContinueFightRes)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanBuyRentPetReq(activityId, rentPetId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanBuyRentPetReq()

	req.activityId = activityId
	req.rentPetId = rentPetId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanBuyRentPetRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("招募成功")
		SixartdaoguanModel.instance:onBuyRentPetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanBuyRentPetRes)
	end
end

function SixArtDaoguanAgent:sendPM_SixArtDaoguanRankReq(activityId)
	local req = SixArtDaoguanExtension_pb.PM_SixArtDaoguanRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanRankRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanRankRes, msg)
	end
end

function SixArtDaoguanAgent:handlePM_SixArtDaoguanNotifyFightResultRes(status, msg)
	if status == 0 then
		SixartdaoguanController.instance:notifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SixArtDaoguanNotifyFightResultRes)
	end
end

SixArtDaoguanAgent.instance = SixArtDaoguanAgent.New()

return SixArtDaoguanAgent
