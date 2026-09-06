-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/agent/HandbookAgent.lua

module("logic.extensions.petshandbook.agent.HandbookAgent", package.seeall)

local HandbookAgent = class("HandbookAgent", BaseAgent)

function HandbookAgent:sendUserPetManualInfoReq()
	local req = PetManualExtension_pb.UserPetManualInfoReq()

	self:sendMsg(req)
end

function HandbookAgent:handleUserPetManualInfoRes(status, msg)
	if status == 0 then
		PetsHandBookModel.instance:initPetInfoList(msg.userOwnedRaceIds)
		GlobalDispatcher:dispatch(GlobalNotify.HandBookInit)
	end
end

function HandbookAgent:handlePetManualGainNewRaceRes(status, msg)
	if status == 0 then
		local changesetid = msg.changeSetId

		GlobalDispatcher:dispatch(GlobalNotify.GainMagicPower, changesetid)
	end
end

function HandbookAgent:onInit()
	self:onReset()
end

function HandbookAgent:onReset()
	return
end

HandbookAgent.instance = HandbookAgent.New()

return HandbookAgent
