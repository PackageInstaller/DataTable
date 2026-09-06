-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/controller/ContractController.lua

module("logic.extensions.contract.controller.ContractController", package.seeall)

local ContractController = class("ContractController", BaseController)

function ContractController:ctor()
	return
end

function ContractController:onInit()
	GlobalDispatcher:addListener(PetAgent.PM_GetPetAllContractInfoRes, self._onGetPetAllContractInfoRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_MakeContractRes, self._onMakeContractRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_CancelContractRes, self._onCancelContractRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_ResetContractSkillRes, self._onResetContractSkillRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_ConfirmContractSkillRes, self._onConfirmContractSkillRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_PetSingleContractInfo, self._onPetSingleContractInfo, self)
end

function ContractController:onReset()
	self._tmpSummonerMasterId = 0
	self._tmpSummonedPetId = 0
	self._tmpCancelSummonerMasterId = 0
	self._tmpCancelSummonedPetId = 0
end

function ContractController:loadAllContractInfo()
	return
end

function ContractController:_onGetPetAllContractInfoRes(status, msg)
	if status == 0 then
		ContractModel.instance:onGetPetAllContractInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_GetPetAllContractInfoRes)
	end
end

function ContractController:sendCancelContract(summonerMasterId, summonedPetId)
	if summonedPetId > 0 then
		self._tmpCancelSummonerMasterId = summonerMasterId
		self._tmpCancelSummonedPetId = summonedPetId
	end
end

function ContractController:sendMakeContract(summonerMasterId, summonedPetId)
	self._tmpSummonerMasterId = summonerMasterId
	self._tmpSummonedPetId = summonedPetId
end

function ContractController:_onMakeContractRes(status, msg)
	local temM = self._tmpSummonerMasterId
	local temS = self._tmpSummonedPetId

	self._tmpSummonerMasterId = 0
	self._tmpSummonedPetId = 0

	if status == 0 then
		ContractModel.instance:onMakeContractRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_MakeContractRes, temM, temS)
	end

	if status == -35 then
		TipsFacade.instance:openCommonTips("网络波动，请尝试重新契约")
		self:sendCancelContract(temM, temS)
	end
end

function ContractController:_onCancelContractRes(status, msg)
	local temM = self._tmpCancelSummonerMasterId

	self._tmpCancelSummonerMasterId = 0
	self._tmpCancelSummonedPetId = 0

	if status == 0 then
		ContractModel.instance:onCancelContractRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_CancelContractRes)
		GlobalDispatcher:dispatch(GlobalNotify.PM_MakeContractRes, temM, -1)
	end
end

function ContractController:_onResetContractSkillRes(status, msg)
	if status == 0 then
		ContractModel.instance:onResetContractSkillRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_ResetContractSkillRes)
	end
end

function ContractController:_onConfirmContractSkillRes(status, msg)
	if status == 0 then
		ContractModel.instance:onConfirmContractSkillRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_ConfirmContractSkillRes)
	end
end

function ContractController:_onPetSingleContractInfo(status, msg)
	if status == 0 then
		ContractModel.instance:onPetSingleContractInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_PetSingleContractInfo)
	end
end

function ContractController:sendGetNewContractSkillInfo()
	PetAgent.instance:sendPM_NewContractInfoReq()
end

function ContractController:onGetNewContractSkillInfo(msg)
	ContractModel.instance:onGetNewContractSkillInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NEW_CONTRACT_SKILL_INFO_UPDATE)
end

function ContractController:sendResetNewContractSkill(petId)
	PetAgent.instance:sendPM_ResetNewContractSkillReq(petId)
end

function ContractController:onResetNewContractSkill(msg)
	ContractModel.instance:addNewTempSkill(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NEW_CONTRACT_SKILL_INFO_RESET)
end

function ContractController:sendNewConfirmContractSkill(petId, isUseNewGenSkill)
	self._curPetId = petId

	PetAgent.instance:sendPM_ConfirmNewContractSkillReq(petId, isUseNewGenSkill)
end

function ContractController:onNewConfirmContractSkill(msg)
	ContractModel.instance:onDelNewContractSkill(self._curPetId)
	GlobalDispatcher:dispatch(GlobalNotify.NEW_CONTRACT_SKILL_INFO_UPDATE)
end

function ContractController:sendContractSkillSelfSelect(petId, skillId)
	PetAgent.instance:sendPM_ContractSkillSelfSelectReq(petId, skillId)
end

function ContractController:onContractSkillSelfSelect(msg)
	ContractModel.instance:onContractSkillSelfSelect(msg)
	ContractModel.instance:onDelNewContractSkill(msg.petId)
	GlobalDispatcher:dispatch(GlobalNotify.NEW_CONTRACT_SKILL_INFO_UPDATE)
end

ContractController.instance = ContractController.New()

return ContractController
