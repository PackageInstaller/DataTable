-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/agent/FamilyPartyAgent.lua

module("logic.extensions.familyparty.agent.FamilyPartyAgent", package.seeall)

local FamilyPartyAgent = class("FamilyPartyAgent", BaseAgent)

function FamilyPartyAgent:sendPM_FamilyParty_GainIdlePrizeReq(partyTimeMillis, prizeId)
	local req = FamilyPartyExtension_pb.PM_FamilyParty_GainIdlePrizeReq()

	req.partyTimeMillis = partyTimeMillis
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FamilyPartyAgent:handlePM_FamilyParty_GainIdlePrizeRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onGainIdlePrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyGainIdlePrizeRes)
	end
end

function FamilyPartyAgent:sendPM_FamilyParty_AnswerQuestionReq(partyTimeMillis, index, optionId)
	local req = FamilyPartyExtension_pb.PM_FamilyParty_AnswerQuestionReq()

	req.partyTimeMillis = partyTimeMillis
	req.index = index
	req.optionId = optionId

	self:sendMsg(req)
	FamilyPartyModel.instance:setAnswerQuestionInfo(index, optionId)
end

function FamilyPartyAgent:handlePM_FamilyParty_AnswerQuestionRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onAnswerQuestionRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyAnswerQuestionRes)
	end
end

function FamilyPartyAgent:sendPM_FamilyParty_OpenPartyReq()
	local req = FamilyPartyExtension_pb.PM_FamilyParty_OpenPartyReq()

	self:sendMsg(req)
end

function FamilyPartyAgent:handlePM_FamilyParty_OpenPartyRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onOpenPartyRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyOpenPartyRes)
	elseif status == -1902 then
		FloatWordMgr.instance:show("时间限制")
	end
end

function FamilyPartyAgent:handlePM_FamilyParty_NotifyPartyBeginRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onNotifyPartyBeginRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyNotifyPartyBeginRes)
	end
end

function FamilyPartyAgent:handlePM_FamilyParty_NotifyPartyEndRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onNotifyPartyEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyNotifyPartyEndRes)
	end
end

function FamilyPartyAgent:handlePM_FamilyParty_NotifyNextQuestionRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onNotifyNextQuestionRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyNotifyNextQuestionRes)
	end
end

function FamilyPartyAgent:handlePM_FamilyParty_NotifyQuestionResultRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onNotifyQuestionResultRes(msg)
		MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyNotifyQuestionResultRes)
	end
end

function FamilyPartyAgent:handlePM_FamilyParty_NotifyOptionInfoChangeRes(status, msg)
	if status == 0 then
		FamilyPartyModel.instance:onNotifyOptionInfoChangeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyPartyNotifyOptionInfoChangeRes)
	end
end

function FamilyPartyAgent:sendPM_FamilyParty_GetPartyPanelInfoReq()
	local req = FamilyPartyExtension_pb.PM_FamilyParty_GetPartyPanelInfoReq()

	self:sendMsg(req)
end

function FamilyPartyAgent:handlePM_FamilyParty_GetPartyPanelInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

FamilyPartyAgent.instance = FamilyPartyAgent.New()

return FamilyPartyAgent
