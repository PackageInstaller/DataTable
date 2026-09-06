-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/agent/IslandStationAgent.lua

module("logic.extensions.islandstation.agent.IslandStationAgent", package.seeall)

local IslandStationAgent = class("IslandStationAgent", BaseAgent)

function IslandStationAgent:sendPM_IslandStationInfoReq(activityId)
	local req = IslandStationExtension_pb.PM_IslandStationInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationInfoRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationInfoRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationRefreshShelfReq(activityId)
	local req = IslandStationExtension_pb.PM_IslandStationRefreshShelfReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationRefreshShelfRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function IslandStationAgent:sendPM_IslandStationOneKeyFullFillReq(activityId, shopId)
	local req = IslandStationExtension_pb.PM_IslandStationOneKeyFullFillReq()

	req.activityId = activityId
	req.shopId = shopId

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationOneKeyFullFillRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationOneKeyFullFillRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationPutOrChangeFoodReq(activityId, shopId, posId, foodId, foodNum)
	local req = IslandStationExtension_pb.PM_IslandStationPutOrChangeFoodReq()

	req.activityId = activityId
	req.shopId = shopId
	req.posId = posId
	req.foodId = foodId
	req.foodNum = foodNum

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationPutOrChangeFoodRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationPutOrChangeFoodRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationMakeFoodReq(activityId, foodId, makeCount)
	local req = IslandStationExtension_pb.PM_IslandStationMakeFoodReq()

	req.activityId = activityId
	req.foodId = foodId
	req.makeCount = makeCount

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationMakeFoodRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationMakeFoodRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationStartGameReq(activityId, stageId, clientKey)
	local req = IslandStationExtension_pb.PM_IslandStationStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationStartGameRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationStartGameRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationGetBossInfoReq(activityId)
	local req = IslandStationExtension_pb.PM_IslandStationGetBossInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationGetBossInfoRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationGetBossInfoRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationEndGameReq(activityId, stageId, score, encryptedKey)
	local req = IslandStationExtension_pb.PM_IslandStationEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationEndGameRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationEndGameRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationChallengeBossReq(activityId, form)
	local req = IslandStationExtension_pb.PM_IslandStationChallengeBossReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationChallengeBossRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function IslandStationAgent:sendPM_IslandStationResetChatReq(activityId, girlId, dialogueId)
	local req = IslandStationExtension_pb.PM_IslandStationResetChatReq()

	req.activityId = activityId
	req.girlId = girlId
	req.dialogueId = dialogueId

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationResetChatRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationResetChatRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationSelectAnswerReq(activityId, girlId, dialogueId, answer)
	local req = IslandStationExtension_pb.PM_IslandStationSelectAnswerReq()

	req.activityId = activityId
	req.girlId = girlId
	req.dialogueId = dialogueId
	req.answer = answer

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationSelectAnswerRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationSelectAnswerRes(msg)
	end
end

function IslandStationAgent:sendPM_IslandStationGainCollectSkinPrizeReq(activityId)
	local req = IslandStationExtension_pb.PM_IslandStationGainCollectSkinPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IslandStationAgent:handlePM_IslandStationGainCollectSkinPrizeRes(status, msg)
	if status == 0 then
		IslandStationController.instance:handlePM_IslandStationGainCollectSkinPrizeRes(msg)
	end
end

IslandStationAgent.instance = IslandStationAgent.New()

return IslandStationAgent
