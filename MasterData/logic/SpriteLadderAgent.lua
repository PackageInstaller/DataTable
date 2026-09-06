-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spriteladder/agent/SpriteLadderAgent.lua

module("logic.extensions.spriteladder.agent.SpriteLadderAgent", package.seeall)

local SpriteLadderAgent = class("SpriteLadderAgent", BaseAgent)

function SpriteLadderAgent:sendPM_PetStairGetInfoReq()
	local req = PetStairExtension_pb.PM_PetStairGetInfoReq()

	self:sendMsg(req)
end

function SpriteLadderAgent:handlePM_PetStairGetInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadPetStair===back")

	if status == 0 then
		SpriteLadderModel.instance:setPetStairGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LadderInfoRefresh, msg)
	end
end

function SpriteLadderAgent:sendPM_PetStairGainPrizeReq(changeSetId, prizeId)
	local req = PetStairExtension_pb.PM_PetStairGainPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function SpriteLadderAgent:handlePM_PetStairGainPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GainPrizeRes, msg)
	else
		FloatWordMgr.instance:show("奖励领取失败")
	end
end

SpriteLadderAgent.instance = SpriteLadderAgent.New()

return SpriteLadderAgent
