-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pet/agent/PetAgent.lua

module("logic.extensions.pet.agent.PetAgent", package.seeall)

local PetAgent = class("PetAgent", BaseAgent)

PetAgent.PM_PagedLoadPetsRes = "PetAgent_PM_PagedLoadPetsRes"
PetAgent.PM_LoadUserPetsRes = "PetAgent_PM_LoadUserPetsRes"
PetAgent.PM_OnPetChanged = "PetAgent_PM_OnPetChanged"
PetAgent.PM_CompositePetPiecesRes = "PetAgent_PM_CompositePetPiecesRes"
PetAgent.PM_PetAwakenRes = "PetAgent_PM_PetAwakenRes"
PetAgent.PM_BatchPetAwakenRes = "PetAgent_PM_BatchPetAwakenRes"
PetAgent.PM_GetPetAllContractInfoRes = "PetAgent_PM_GetPetAllContractInfoRes"
PetAgent.PM_MakeContractRes = "PetAgent_PM_MakeContractRes"
PetAgent.PM_CancelContractRes = "PetAgent_PM_CancelContractRes"
PetAgent.PM_UpgradeTalentRes = "PetAgent_PM_UpgradeTalentRes"
PetAgent.PM_ChangeLockStateRes = "PetAgent_PM_ChangeLockStateRes"
PetAgent.PM_PetRareComposeRes = "PetAgent_PM_PetRareComposeRes"
PetAgent.PM_UpgradePetSkillRes = "PetAgent_PM_UpgradePetSkillRes"
PetAgent.PM_EvolvePetRes = "PetAgent_PM_EvolvePetRes"
PetAgent.PM_ResetContractSkillRes = "PetAgent_PM_ResetContractSkillRes"
PetAgent.PM_ConfirmContractSkillRes = "PetAgent_PM_ConfirmContractSkillRes"
PetAgent.PM_PetSingleContractInfo = "PetAgent_PM_PetSingleContractInfo"
PetAgent.PM_DivineEvolveRes = "PetAgent_PM_DivineEvolveRes"
PetAgent.PM_GetDivineEvolveInfoRes = "PetAgent_PM_GetDivineEvolveInfoRes"
PetAgent.PM_DivinePlusEvolveRes = "PetAgent_PM_DivinePlusEvolveRes"
PetAgent.PM_BatchLoadUserPetFullViewOnLoginRes = "PM_BatchLoadUserPetFullViewOnLoginRes"
PetAgent.PM_DivineExchangeRes = "PetAgent_PM_DivineExchangeRes"

function PetAgent:ctor()
	return
end

function PetAgent:setExtId(extId)
	PetAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetAgent:sendPM_LoadUserPetsReq()
	local req = PetExtension_pb.PM_LoadUserPetsReq()

	self:sendMsg(req)
end

function PetAgent:handlePM_LoadUserPetsRes(status, msg)
	if status == 0 then
		self:dispatch(PetAgent.PM_LoadUserPetsRes, status, msg)
	end
end

function PetAgent:sendPM_BatchLoadUserPetFullViewOnLoginReq(petId_i32_Ary)
	local req = PetExtension_pb.PM_BatchLoadUserPetFullViewOnLoginReq()

	for i, v1 in ipairs(petId_i32_Ary) do
		req.petId:append(v1)
	end

	self:sendMsg(req)
end

function PetAgent:handlePM_BatchLoadUserPetFullViewOnLoginRes(status, msg)
	if status == 0 then
		self:dispatch(PetAgent.PM_BatchLoadUserPetFullViewOnLoginRes, status, msg)
	end
end

function PetAgent:handlePM_PagedLoadPetsRes(status, msg)
	self:dispatch(PetAgent.PM_PagedLoadPetsRes, status, msg)
end

function PetAgent:handlePM_OnPetChanged(status, msg)
	self:dispatch(PetAgent.PM_OnPetChanged, status, msg)
end

function PetAgent:sendPM_CompositePetPiecesReq(raceId, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_CompositePetPiecesReq()

	req.raceId = raceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_CompositePetPiecesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_CompositePetPiecesRes(status, msg)
	self:dispatch(PetAgent.PM_CompositePetPiecesRes, status, msg)
end

function PetAgent:sendPM_PetAwakenReq(awakenPetId, usedPetIds_i32_Ary, usedItemIds_i32_Ary, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_PetAwakenReq()

	req.awakenPetId = awakenPetId

	for i, v1 in ipairs(usedPetIds_i32_Ary) do
		req.usedPetIds:append(v1)
	end

	for i, v2 in ipairs(usedItemIds_i32_Ary) do
		req.usedItemIds:append(v2)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_PetAwakenRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_PetAwakenRes(status, msg)
	self:dispatch(PetAgent.PM_PetAwakenRes, status, msg)
end

function PetAgent:sendPM_BatchPetAwakenReq(reqList_pb_Ary, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_BatchPetAwakenReq()

	if reqList_pb_Ary ~= nil then
		for i, v3 in ipairs(reqList_pb_Ary) do
			local reqList = req.reqList:add()

			reqList:ParseFromString(v3:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_BatchPetAwakenRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_BatchPetAwakenRes(status, msg)
	self:dispatch(PetAgent.PM_BatchPetAwakenRes, status, msg)
end

function PetAgent:sendPM_GetPetAllContractInfoReq(handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_GetPetAllContractInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_GetPetAllContractInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_GetPetAllContractInfoRes(status, msg)
	forcePrint("PetAgent.handlePM_GetPetAllContractInfoRes===", status)
	self:dispatch(PetAgent.PM_GetPetAllContractInfoRes, status, msg)
end

function PetAgent:sendPM_MakeContractReq(masterPetId, summonedPetId, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_MakeContractReq()

	req.masterPetId = masterPetId
	req.summonedPetId = summonedPetId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_MakeContractRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_MakeContractRes(status, msg)
	self:dispatch(PetAgent.PM_MakeContractRes, status, msg)
end

function PetAgent:sendPM_CancelContractReq(masterPetId, summonedPetId, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_CancelContractReq()

	req.masterPetId = masterPetId
	req.summonedPetId = summonedPetId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_CancelContractRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_CancelContractRes(status, msg)
	self:dispatch(PetAgent.PM_CancelContractRes, status, msg)
end

function PetAgent:sendPM_UpgradeTalentReq(petId, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_UpgradeTalentReq()

	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_UpgradeTalentRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_UpgradeTalentRes(status, msg)
	self:dispatch(PetAgent.PM_UpgradeTalentRes, status, msg)
end

function PetAgent:sendPM_ChangeLockStateReq(petId, isLock, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_ChangeLockStateReq()

	req.petId = petId
	req.isLock = isLock

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_ChangeLockStateRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_ChangeLockStateRes(status, msg)
	self:dispatch(PetAgent.PM_ChangeLockStateRes, status, msg)
end

function PetAgent:sendPM_PetRareComposeReq(petId_i32_Ary, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_PetRareComposeReq()

	for i, v4 in ipairs(petId_i32_Ary) do
		req.petId:append(v4)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_PetRareComposeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_PetRareComposeRes(status, msg)
	self:dispatch(PetAgent.PM_PetRareComposeRes, status, msg)
end

function PetAgent:sendPM_UpgradePetSkillReq(petId, skillType, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_UpgradePetSkillReq()

	req.petId = petId
	req.skillType = skillType

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_UpgradePetSkillRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_UpgradePetSkillRes(status, msg)
	self:dispatch(PetAgent.PM_UpgradePetSkillRes, status, msg)
end

function PetAgent:sendPM_EvolvePetReq(petId, targetRaceId, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_EvolvePetReq()

	req.petId = petId
	req.targetRaceId = targetRaceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_EvolvePetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_EvolvePetRes(status, msg)
	self:dispatch(PetAgent.PM_EvolvePetRes, status, msg)
end

function PetAgent:sendPM_ResetContractSkillReq(summonedPetId, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_ResetContractSkillReq()

	req.summonedPetId = summonedPetId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_ResetContractSkillRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_ResetContractSkillRes(status, msg)
	self:dispatch(PetAgent.PM_ResetContractSkillRes, status, msg)
end

function PetAgent:sendPM_ConfirmContractSkillReq(summonedPetId, useNewGenSkill, handler, handlerObj, errHandler)
	local req = PetExtension_pb.PM_ConfirmContractSkillReq()

	req.summonedPetId = summonedPetId
	req.useNewGenSkill = useNewGenSkill

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetAgent.PM_ConfirmContractSkillRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetAgent:handlePM_ConfirmContractSkillRes(status, msg)
	self:dispatch(PetAgent.PM_ConfirmContractSkillRes, status, msg)
end

function PetAgent:handlePM_PetSingleContractInfo(status, msg)
	self:dispatch(PetAgent.PM_PetSingleContractInfo, status, msg)
end

function PetAgent:sendPM_DivineEvolveReq(petId, costPetIds)
	local req = PetExtension_pb.PM_DivineEvolveReq()

	req.petId = petId

	for i, v in ipairs(costPetIds) do
		req.costPetIds:append(v)
	end

	self:sendMsg(req)
end

function PetAgent:handlePM_DivineEvolveRes(status, msg)
	self:dispatch(PetAgent.PM_DivineEvolveRes, status, msg)
end

function PetAgent:sendPM_GetDivineEvolveInfoReq()
	local req = PetExtension_pb.PM_GetDivineEvolveInfoReq()

	self:sendMsg(req)
end

function PetAgent:handlePM_GetDivineEvolveInfoRes(status, msg)
	self:dispatch(PetAgent.PM_GetDivineEvolveInfoRes, status, msg)
end

function PetAgent:sendPM_DivinePlusEvolveReq(petId, newRaceId)
	local req = PetExtension_pb.PM_DivinePlusEvolveReq()

	req.petId = petId
	req.newRaceId = newRaceId

	self:sendMsg(req)
end

function PetAgent:handlePM_DivinePlusEvolveRes(status, msg)
	self:dispatch(PetAgent.PM_DivinePlusEvolveRes, status, msg)
end

function PetAgent:sendPM_OneKeyPetAwakenReq(awakenPetList)
	local req = PetExtension_pb.PM_OneKeyPetAwakenReq()

	for i, v in ipairs(awakenPetList) do
		local param = req.awakenPetList:add()

		param:ParseFromString(v:SerializeToString())
	end

	self:sendMsg(req)
end

function PetAgent:handlePM_OneKeyPetAwakenRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PetOneKeyAwakeSuccess)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PetOneKeyAwakeFail, status)
	end
end

function PetAgent:sendPM_DivineExchangeReq(targetRaceId, petId, usePet)
	local req = PetExtension_pb.PM_DivineExchangeReq()

	req.targetRaceId = targetRaceId

	if petId then
		req.petId = petId
	end

	req.usePet = usePet

	self:sendMsg(req)
end

function PetAgent:handlePM_DivineExchangeRes(status, msg)
	self:dispatch(PetAgent.PM_DivineExchangeRes, status, msg)
end

function PetAgent:sendPM_CarriedLinkReq(carriedMasterId, carriedPetId)
	local req = PetExtension_pb.PM_CarriedLinkReq()

	req.carriedMasterId = carriedMasterId
	req.carriedPetId = carriedPetId

	self:sendMsg(req)
end

function PetAgent:handlePM_CarriedLinkRes(status, msg)
	return
end

function PetAgent:sendPM_CancelCariedLinkReq(carriedMasterId, carriedPetId)
	local req = PetExtension_pb.PM_CancelCariedLinkReq()

	req.carriedMasterId = carriedMasterId
	req.carriedPetId = carriedPetId

	self:sendMsg(req)
end

function PetAgent:handlePM_CancelCariedLinkRes(status, msg)
	return
end

function PetAgent:sendPM_OracleLinkReq(oracleMasterId, oraclePetId)
	local req = PetExtension_pb.PM_OracleLinkReq()

	req.oracleMasterId = oracleMasterId
	req.oraclePetId = oraclePetId

	self:sendMsg(req)
end

function PetAgent:handlePM_OracleLinkRes(status, msg)
	return
end

function PetAgent:sendPM_CancelOracleLinkReq(oracleMasterId, oraclePetId)
	local req = PetExtension_pb.PM_CancelOracleLinkReq()

	req.oracleMasterId = oracleMasterId
	req.oraclePetId = oraclePetId

	self:sendMsg(req)
end

function PetAgent:handlePM_CancelOracleLinkRes(status, msg)
	return
end

function PetAgent:sendPM_LevelUpWithTalentLvReq(petId, targetLv, useItems_pb_Ary)
	local req = PetExtension_pb.PM_LevelUpWithTalentLvReq()

	req.petId = petId
	req.targetLv = targetLv

	if useItems_pb_Ary ~= nil then
		for i, v9 in ipairs(useItems_pb_Ary) do
			local useItems = req.useItems:add()

			useItems:ParseFromString(v9:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PetAgent:handlePM_LevelUpWithTalentLvRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_LevelUpWithTalentLvRes)
	end
end

function PetAgent:sendPM_NewContractInfoReq()
	local req = PetExtension_pb.PM_NewContractInfoReq()

	self:sendMsg(req)
end

function PetAgent:handlePM_NewContractInfoRes(status, msg)
	if status == 0 then
		ContractController.instance:onGetNewContractSkillInfo(msg)
	end
end

function PetAgent:sendPM_ResetNewContractSkillReq(summonedPetId)
	local req = PetExtension_pb.PM_ResetNewContractSkillReq()

	req.summonedPetId = summonedPetId

	self:sendMsg(req)
end

function PetAgent:handlePM_ResetNewContractSkillRes(status, msg)
	if status == 0 then
		ContractController.instance:onResetNewContractSkill(msg)
	end
end

function PetAgent:sendPM_ConfirmNewContractSkillReq(summonedPetId, useNewGenSkill)
	local req = PetExtension_pb.PM_ConfirmNewContractSkillReq()

	req.summonedPetId = summonedPetId
	req.useNewGenSkill = useNewGenSkill

	self:sendMsg(req)
end

function PetAgent:handlePM_ConfirmNewContractSkillRes(status, msg)
	if status == 0 then
		ContractController.instance:onNewConfirmContractSkill(msg)
	end
end

function PetAgent:sendPM_ContractSkillSelfSelectReq(summonedPetId, skillId)
	local req = PetExtension_pb.PM_ContractSkillSelfSelectReq()

	req.summonedPetId = summonedPetId
	req.skillId = skillId

	self:sendMsg(req)
end

function PetAgent:handlePM_ContractSkillSelfSelectRes(status, msg)
	if status == 0 then
		ContractController.instance:onContractSkillSelfSelect(msg)
	end
end

function PetAgent:sendPM_BookSpiritLinkReq(masterPetId, bookSpiritPetId)
	local req = PetExtension_pb.PM_BookSpiritLinkReq()

	req.masterPetId = masterPetId
	req.bookSpiritPetId = bookSpiritPetId

	self:sendMsg(req)
end

function PetAgent:handlePM_BookSpiritLinkRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

PetAgent.instance = PetAgent.New()

return PetAgent
