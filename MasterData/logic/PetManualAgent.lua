-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/agent/PetManualAgent.lua

module("logic.extensions.petmanual.agent.PetManualAgent", package.seeall)

local PetManualAgent = class("PetManualAgent", BaseAgent)

PetManualAgent.UserPetManualInfoRes = "PetManualAgent_UserPetManualInfoRes"
PetManualAgent.PreviewBattleRes = "PetManualAgent_PreviewBattleRes"
PetManualAgent.GainPetManualPetPrizeRes = "PetManualAgent_GainPetManualPetPrizeRes"
PetManualAgent.GainPetManualTeamPrizeRes = "PetManualAgent_GainPetManualTeamPrizeRes"
PetManualAgent.PetBenefitActivateRes = "PetManualAgent_PetBenefitActivateRes"
PetManualAgent.PetBenefitUpgradeRes = "PetManualAgent_PetBenefitUpgradeRes"
PetManualAgent.UserGroupInfoRes = "PetManualAgent_UserGroupInfoRes"
PetManualAgent.GainGroupPrizeRes = "PetManualAgent_GainGroupPrizeRes"
PetManualAgent.GainRankPrizeRes = "PetManualAgent_GainRankPrizeRes"
PetManualAgent.RaceRankKudosRes = "PetManualAgent_RaceRankKudosRes"
PetManualAgent.PetSkinInfoRes = "PetManualAgent_PetSkinInfoRes"

function PetManualAgent:ctor()
	MsgFlowMgr.instance:ignoreAutoShowFloatMsg(22, 13)
end

function PetManualAgent:setExtId(extId)
	PetManualAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetManualAgent:sendUserPetManualInfoReq(handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.UserPetManualInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.UserPetManualInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handleUserPetManualInfoRes(status, msg)
	self:dispatch(PetManualAgent.UserPetManualInfoRes, status, msg)
end

function PetManualAgent:sendPreviewBattleReq(raceId, skinId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.PreviewBattleReq()

	req.raceId = raceId

	if skinId ~= nil then
		req.skinId = skinId
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.PreviewBattleRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handlePreviewBattleRes(status, msg)
	self:dispatch(PetManualAgent.PreviewBattleRes, status, msg)
end

function PetManualAgent:sendGainPetManualPetPrizeReq(teamId, raceId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.GainPetManualPetPrizeReq()

	req.teamId = teamId
	req.raceId = raceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.GainPetManualPetPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handleGainPetManualPetPrizeRes(status, msg)
	self:dispatch(PetManualAgent.GainPetManualPetPrizeRes, status, msg)
end

function PetManualAgent:sendGainPetManualTeamPrizeReq(teamId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.GainPetManualTeamPrizeReq()

	req.teamId = teamId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.GainPetManualTeamPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handleGainPetManualTeamPrizeRes(status, msg)
	self:dispatch(PetManualAgent.GainPetManualTeamPrizeRes, status, msg)
end

function PetManualAgent:sendPetBenefitActivateReq(raceId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.PetBenefitActivateReq()

	req.raceId = raceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.PetBenefitActivateRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handlePetBenefitActivateRes(status, msg)
	self:dispatch(PetManualAgent.PetBenefitActivateRes, status, msg)
end

function PetManualAgent:sendPetBenefitOneKeyActivateReq()
	local req = PetManualExtension_pb.PetBenefitOneKeyActivateReq()

	self:sendMsg(req)
end

function PetManualAgent:handlePetBenefitOneKeyActivateRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PetBookStength)
	end
end

function PetManualAgent:sendPetSkinOneKeyActivateReq()
	local req = PetManualExtension_pb.PetSkinOneKeyActivateReq()

	self:sendMsg(req)
end

function PetManualAgent:handlePetSkinOneKeyActivateRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PetBookSkinActive)
	end
end

function PetManualAgent:sendPetBenefitUpgradeReq(raceId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.PetBenefitUpgradeReq()

	req.raceId = raceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.PetBenefitUpgradeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handlePetBenefitUpgradeRes(status, msg)
	self:dispatch(PetManualAgent.PetBenefitUpgradeRes, status, msg)
end

function PetManualAgent:sendUserGroupInfoReq(handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.UserGroupInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.UserGroupInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handleUserGroupInfoRes(status, msg)
	self:dispatch(PetManualAgent.UserGroupInfoRes, status, msg)
end

function PetManualAgent:sendGainGroupPrizeReq(groupId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.GainGroupPrizeReq()

	req.groupId = groupId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetManualAgent.GainGroupPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetManualAgent:handleGainGroupPrizeRes(status, msg)
	self:dispatch(PetManualAgent.GainGroupPrizeRes, status, msg)
end

function PetManualAgent:sendCalZdlAndRankReq(petId)
	local req = PetManualExtension_pb.CalZdlAndRankReq()

	req.petId = petId

	self:sendMsg(req)
end

function PetManualAgent:handleCalZdlAndRankRes(status, msg)
	if status == 0 then
		PowerCheckController.instance:onCalZdlAndRankReq(msg)
	end
end

function PetManualAgent:sendGetRaceZdlRankReq(raceId, rankType, subType, showNum, isWithKudos, ignoreRankList)
	local req = PetManualExtension_pb.GetRaceZdlRankReq()

	req.raceId = raceId
	req.rankType = rankType
	req.subType = subType
	req.showNum = showNum
	req.isWithKudos = isWithKudos
	req.ignoreRankList = ignoreRankList or false

	self:sendMsg(req)
end

function PetManualAgent:handleGetRaceZdlRankRes(status, msg)
	if status == 0 then
		PowerCheckController.instance:onGetRaceZdlRankReq(msg)
	end
end

function PetManualAgent:sendRaceRankKudosReq(raceId, rankType, subType, userId, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.RaceRankKudosReq()

	req.raceId = raceId
	req.rankType = rankType
	req.subType = subType
	req.userId = userId

	self:addEventOnce(PetManualAgent.RaceRankKudosRes, handler, handlerObj, errHandler)
	self:sendMsg(req)
end

function PetManualAgent:handleRaceRankKudosRes(status, msg)
	if status == 0 then
		PowerCheckController.instance:onRaceRankKudosReq(msg)
		self:dispatch(PetManualAgent.RaceRankKudosRes, status, msg)
	end
end

function PetManualAgent:sendGainRankPrizeReq(raceId, rankType, subType, handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.GainRankPrizeReq()

	req.raceId = raceId
	req.rankType = rankType
	req.subType = subType

	self:addEventOnce(PetManualAgent.GainRankPrizeRes, handler, handlerObj, errHandler)
	self:sendMsg(req)
end

function PetManualAgent:handleGainRankPrizeRes(status, msg)
	if status == 0 then
		PowerCheckController.instance:onGainRankPrizeReq(msg)
	else
		PowerCheckController.instance:resetCustomShowCI()

		if status == -38 then
			-- block empty
		else
			local tip = MsgFlowMgr.instance:getResultCodeStr(status)

			FloatWordMgr.instance:show(tip)
		end
	end

	self:dispatch(PetManualAgent.GainRankPrizeRes, status, msg)
end

function PetManualAgent:sendGetSkinManualInfoReq(handler, handlerObj, errHandler)
	local req = PetManualExtension_pb.GetSkinManualInfoReq()

	self:addEventOnce(PetManualAgent.PetSkinInfoRes, handler, handlerObj, errHandler)
	self:sendMsg(req)
end

function PetManualAgent:handleGetSkinManualInfoRes(status, msg)
	if status == 0 then
		local skinIds = msg.skinIds
		local activeSkinIds = msg.activeSkinIds

		PetbookModel.instance:setActiveSkinIds(activeSkinIds)
		PetbookModel.instance:setSkinIds(skinIds)
		GlobalDispatcher:dispatch(GlobalNotify.HandBookSkinInfo)
		self:dispatch(PetManualAgent.PetSkinInfoRes, status, msg)
	end
end

function PetManualAgent:sendPetSkinActivateReq(skinId)
	local req = PetManualExtension_pb.PetSkinActivateReq()

	req.skinId = skinId

	self:sendMsg(req)
end

function PetManualAgent:handlePetSkinActivateRes(status, msg)
	if status == 0 then
		self:sendGetSkinManualInfoReq()
	end
end

function PetManualAgent:sendOneKeyPetRankPrizeInfoReq()
	local req = PetManualExtension_pb.OneKeyPetRankPrizeInfoReq()

	self:sendMsg(req)
end

function PetManualAgent:handleOneKeyPetRankPrizeInfoRes(status, msg)
	if status == 0 then
		local items = msg.items

		PowerCheckController.instance:onOneKeyPetRankPrizeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OneKeyPetRankPrizeInfoRes, items)
	end
end

PetManualAgent.instance = PetManualAgent.New()

return PetManualAgent
