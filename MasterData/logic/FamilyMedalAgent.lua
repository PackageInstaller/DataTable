-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/agent/FamilyMedalAgent.lua

module("logic.extensions.newfamily.agent.FamilyMedalAgent", package.seeall)

local FamilyMedalAgent = class("FamilyMedalAgent", BaseAgent)

function FamilyMedalAgent:sendPM_FamilyMedalGetMedalListReq()
	local req = FamilyMedalExtension_pb.PM_FamilyMedalGetMedalListReq()

	self:sendMsg(req)
end

function FamilyMedalAgent:handlePM_FamilyMedalGetMedalListRes(status, msg)
	if status == 0 then
		FamilyHonorController.instance:scPushFamilyMedalGetMedalList(msg)
	end
end

function FamilyMedalAgent:sendPM_FamilyMedalSetMedalWallReq(medalList)
	local req = FamilyMedalExtension_pb.PM_FamilyMedalSetMedalWallReq()

	for _, info in ipairs(medalList or {}) do
		if info and checknumber(info.defineId) > 0 then
			local medalList = req.medalList:add()

			medalList:ParseFromString(info:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function FamilyMedalAgent:handlePM_FamilyMedalSetMedalWallRes(status, msg)
	if status == 0 then
		FamilyHonorController.instance:scPushFamilyMedalSetMedalWall(msg)
	end
end

function FamilyMedalAgent:sendPM_FamilyMedalViewRankReq()
	local req = FamilyMedalExtension_pb.PM_FamilyMedalViewRankReq()

	self:sendMsg(req)
end

function FamilyMedalAgent:handlePM_FamilyMedalViewRankRes(status, msg)
	if status == 0 then
		FamilyHonorController.instance:scPushFamilyMedalViewRank(msg)
	end
end

function FamilyMedalAgent:sendPM_FamilyMedalgetChatMedalsReq(familyId, showOffKey)
	local req = FamilyMedalExtension_pb.PM_FamilyMedalgetChatMedalsReq()

	req.familyId = familyId
	req.showOffKey = showOffKey

	self:sendMsg(req)
end

function FamilyMedalAgent:handlePM_FamilyMedalGetChatMedalsRes(status, msg)
	if status == 0 then
		FamilyHonorController.instance:scPushFamilyMedalgetChatMedals(msg)
	end
end

FamilyMedalAgent.instance = FamilyMedalAgent.New()

return FamilyMedalAgent
