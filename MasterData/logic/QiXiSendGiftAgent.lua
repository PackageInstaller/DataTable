-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/agent/QiXiSendGiftAgent.lua

module("logic.extensions.romanticgifts.agent.QiXiSendGiftAgent", package.seeall)

local QiXiSendGiftAgent = class("QiXiSendGiftAgent", BaseAgent)

function QiXiSendGiftAgent:sendPM_QiXiSendGiftGetInfoReq(activityId)
	local req = QiXiSendGiftExtension_pb.PM_QiXiSendGiftGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QiXiSendGiftAgent:handlePM_QiXiSendGiftGetInfoRes(status, msg)
	if status == 0 then
		RomanticGiftsModel.instance:setSendInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.QiXiSendGiftGetInfoReq)
	end
end

function QiXiSendGiftAgent:sendPM_QiXiSendGiftSendReq(activityId, id, num, targetId)
	local req = QiXiSendGiftExtension_pb.PM_QiXiSendGiftSendReq()

	req.activityId = activityId
	req.id = id
	req.num = num
	req.targetId = targetId

	self:sendMsg(req)
end

function QiXiSendGiftAgent:handlePM_QiXiSendGiftSendRes(status, msg)
	if status == 0 then
		local target = msg.target
		local changeSetId = msg.changeSetId

		MaterialController.instance:setChangeSetPopup(changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
		RomanticGiftsModel.instance:updateFiendsInfo(target)
		GlobalDispatcher:dispatch(GlobalNotify.QiXiSendGiftSendReq)
	end
end

function QiXiSendGiftAgent:sendPM_QiXiSendGiftGetRomanceRankReq(zoneId)
	local req = QiXiSendGiftExtension_pb.PM_QiXiSendGiftGetRomanceRankReq()

	req.zoneId = zoneId

	self:sendMsg(req)
end

function QiXiSendGiftAgent:handlePM_QiXiSendGiftGetRomanceRankRes(status, msg)
	if status == 0 then
		RomanticGiftsModel.instance:setRomanticRankInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.QiXiSendGiftGetRankReq)
	end
end

function QiXiSendGiftAgent:sendPM_QiXiSendGiftGetSugarRankReq(zoneId)
	local req = QiXiSendGiftExtension_pb.PM_QiXiSendGiftGetSugarRankReq()

	req.zoneId = zoneId

	self:sendMsg(req)
end

function QiXiSendGiftAgent:handlePM_QiXiSendGiftGetSugarRankRes(status, msg)
	if status == 0 then
		RomanticGiftsModel.instance:setSweetRankInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.QiXiSendGiftGetRankReq)
	end
end

QiXiSendGiftAgent.instance = QiXiSendGiftAgent.New()

return QiXiSendGiftAgent
