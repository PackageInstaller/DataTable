-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/agent/HeartOfJieShenClgAgent.lua

module("logic.extensions.heartofjieshenclg.agent.HeartOfJieShenClgAgent", package.seeall)

local HeartOfJieShenClgAgent = class("HeartOfJieShenClgAgent", BaseAgent)

function HeartOfJieShenClgAgent:sendPM_HeartOfJieShenClgGetInfoReq(activityId)
	local req = HeartOfJieShenClgExtension_pb.PM_HeartOfJieShenClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgGetInfoRes(status, msg)
	if status == 0 then
		HeartofjieshenModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgGetInfoRes)
	end
end

function HeartOfJieShenClgAgent:sendPM_HeartOfJieShenClgFightYiReq(activityId, form)
	local req = HeartOfJieShenClgExtension_pb.PM_HeartOfJieShenClgFightYiReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgFightYiRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgFightYiRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgNotifyFightYiResultRes(status, msg)
	if status == 0 then
		HeartofjieshenModel.instance:onFightYiRes(msg)
		HeartofjieshenModel.instance:resetClgFinishDic()
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgNotifyFightYiResultRes)
	end
end

function HeartOfJieShenClgAgent:sendPM_HeartOfJieShenClgFightChiReq(activityId, form)
	local req = HeartOfJieShenClgExtension_pb.PM_HeartOfJieShenClgFightChiReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgFightChiRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgFightChiRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgNotifyFightChiResultRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local curFightDamage = msg.curFightDamage
		local historyMaxDamage = msg.historyMaxDamage
		local yiDamage = HeartofjieshenModel.instance:getFightYiResMsg().curFightDamage
		local params = {
			title = "造成伤害",
			content = string.format("亦&赤之阵总伤害%s", curFightDamage + yiDamage)
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.HeartofJieshen, params)
		HeartofjieshenModel.instance:setClgFinish(GameEnum.HeartofjieshenclgFmtType.Chi)
		HeartofjieshenModel.instance:updateMaxDamage(activityId, historyMaxDamage)
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgNotifyFightChiResultRes)
	end
end

function HeartOfJieShenClgAgent:sendPM_HeartOfJieShenClgGetHistoryRankReq(activityId)
	local req = HeartOfJieShenClgExtension_pb.PM_HeartOfJieShenClgGetHistoryRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgGetHistoryRankRes(status, msg)
	if status == 0 then
		HeartofjieshenModel.instance:setHistoryRankMsg(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgGetHistoryRankRes)
	end
end

function HeartOfJieShenClgAgent:sendPM_HeartOfJieShenClgGetDailyRankReq(activityId)
	local req = HeartOfJieShenClgExtension_pb.PM_HeartOfJieShenClgGetDailyRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgGetDailyRankRes(status, msg)
	if status == 0 then
		HeartofjieshenModel.instance:setDailyRankMsg(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfJieShenClgGetDailyRankRes)
	end
end

function HeartOfJieShenClgAgent:sendPM_HeartOfJieShenClgGetRankInfoV0926Req(activityId)
	local req = HeartOfJieShenClgExtension_pb.PM_HeartOfJieShenClgGetRankInfoV0926Req()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfJieShenClgAgent:handlePM_HeartOfJieShenClgGetRankInfoV0926Res(status, msg)
	if status == 0 then
		HeartOfAoJiuClgModel.instance:setRankMsg(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfAojiuRep0926Rank)
	end
end

HeartOfJieShenClgAgent.instance = HeartOfJieShenClgAgent.New()

return HeartOfJieShenClgAgent
