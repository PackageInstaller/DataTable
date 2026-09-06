-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/agent/XiuNuoBrotherhoodAgent.lua

module("logic.extensions.xiunuobrotherhood.agent.XiuNuoBrotherhoodAgent", package.seeall)

local XiuNuoBrotherhoodAgent = class("XiuNuoBrotherhoodAgent", BaseAgent)

XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodInfoRes = "XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodInfoRes"
XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodStartMoveRes = "XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodStartMoveRes"
XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodEndMoveRes = "XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodEndMoveRes"
XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodResetRes = "XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodResetRes"
XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodFightRes = "XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodFightRes"
XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodBossBattleEndRes = "XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodBossBattleEndRes"

function XiuNuoBrotherhoodAgent:sendPM_XiuNuoBrotherhoodInfoReq(activityId)
	local req = XiuNuoBrotherhoodExtension_pb.PM_XiuNuoBrotherhoodInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodInfoRes, status, msg)
	end
end

function XiuNuoBrotherhoodAgent:sendPM_XiuNuoBrotherhoodStartMoveReq(activityId, stageId, clientKey)
	local req = XiuNuoBrotherhoodExtension_pb.PM_XiuNuoBrotherhoodStartMoveReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodStartMoveRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodStartMoveRes, status, msg)
	end
end

function XiuNuoBrotherhoodAgent:sendPM_XiuNuoBrotherhoodEndMoveReq(activityId, stageId, blocks, blockResult, score, encryptedKey)
	local req = XiuNuoBrotherhoodExtension_pb.PM_XiuNuoBrotherhoodEndMoveReq()

	req.activityId = activityId
	req.stageId = stageId
	req.score = score
	req.encryptedKey = encryptedKey

	for i, v1 in ipairs(blocks) do
		req.blocks:append(v1)
	end

	if blockResult ~= nil then
		for i, v1 in ipairs(blockResult) do
			local result = req.blockResult:add()

			result:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodEndMoveRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodEndMoveRes, status, msg)
	end
end

function XiuNuoBrotherhoodAgent:sendPM_XiuNuoBrotherhoodResetReq(activityId, stageId)
	local req = XiuNuoBrotherhoodExtension_pb.PM_XiuNuoBrotherhoodResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodResetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodResetRes, status, msg)
	end
end

function XiuNuoBrotherhoodAgent:sendPM_XiuNuoBrotherhoodFightReq(activityId, stageId, bossId, selectBuff, simpleForm)
	local req = XiuNuoBrotherhoodExtension_pb.PM_XiuNuoBrotherhoodFightReq()

	req.activityId = activityId
	req.stageId = stageId
	req.bossId = bossId

	for i, v in ipairs(selectBuff) do
		req.selectBuff:append(v)
	end

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodFightRes, status, msg)
	end
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodBossBattleEndRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodBossBattleEndRes, status, msg)
	end
end

function XiuNuoBrotherhoodAgent:sendPM_XiuNuoBrotherhoodUpgradeBuffReq(activityId)
	local req = XiuNuoBrotherhoodExtension_pb.PM_XiuNuoBrotherhoodUpgradeBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiuNuoBrotherhoodAgent:handlePM_XiuNuoBrotherhoodUpgradeBuffRes(status, msg)
	if status == 0 then
		XiuNuoBrotherhoodModel.instance:upgradeBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodUpgradeBuffRes)
	end
end

XiuNuoBrotherhoodAgent.instance = XiuNuoBrotherhoodAgent.New()

return XiuNuoBrotherhoodAgent
