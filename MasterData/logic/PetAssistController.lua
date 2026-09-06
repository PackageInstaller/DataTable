-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/controller/PetAssistController.lua

module("logic.extensions.petassist.controller.PetAssistController", package.seeall)

local PetAssistController = class("PetAssistController", BaseController)

function PetAssistController:ctor()
	return
end

function PetAssistController:onInit()
	AssistAgent.instance:addHandler(AssistAgent.PM_AssistInfoRes, self.SCLoadAssistInfo, self)
	AssistAgent.instance:addHandler(AssistAgent.PM_AssistUpgradeTeamRes, self.SCUpgradePetTeam, self)
	AssistAgent.instance:addHandler(AssistAgent.PM_AssistSetPetPositionRes, self.SCSetPetTeamPosition, self)
	AssistAgent.instance:addHandler(AssistAgent.PM_NotifyPetPositionDropRes, self.SCPetPositionDrop, self)
	AssistAgent.instance:addHandler(AssistAgent.PM_AssistOneClickUpgradeTeamRes, self.handlePM_AssistOneClickUpgradeTeamRes, self)
	AssistAgent.instance:addHandler(AssistAgent.PM_AssistOneClickDeployRes, self.handlePM_AssistOneClickDeployRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._onPetChange, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetsInit, self._onBagPetsInit, self)
	self:onReset()
end

function PetAssistController:onReset()
	self.nowUpTeamType = nil
	self.addPetInfo = nil
end

function PetAssistController:_onBagPetsInit()
	PetAssistModel.instance:GetTotalAttributes(true)
	BagPetsController.instance:calcAllAssistAttr()
end

function PetAssistController:_onPetChange(oldPet, newPet)
	local allTeamInfos = PetAssistModel.instance.allTeamInfos

	if allTeamInfos and newPet then
		for k, info in pairs(allTeamInfos) do
			local posPetInfos = info.posPetInfos

			for _k, petId in pairs(posPetInfos or {}) do
				if petId == newPet.petId then
					self:CSLoadAssistInfoReq()

					return
				end
			end
		end
	end
end

function PetAssistController:CSLoadAssistInfoReq()
	AssistAgent.instance:sendPM_AssistInfoReq()
end

function PetAssistController:SCLoadAssistInfo(msg)
	PetAssistModel.instance:InitAllAssistInfos(msg.teamInfo)
end

function PetAssistController:CSUpgradePetTeamReq(teamType)
	self.nowUpTeamType = teamType

	AssistAgent.instance:sendPM_AssistUpgradeTeamReq(teamType)
end

function PetAssistController:SCUpgradePetTeam(msg, status)
	if status ~= 0 then
		self.nowUpTeamType = nil

		return
	end

	PetAssistModel.instance:UpgradePetTeamLevel(self.nowUpTeamType)
	UIStateManager.instance:open(ViewName.AssistUpgrade, 2, {
		teamType = self.nowUpTeamType
	})

	self.nowUpTeamType = nil
end

function PetAssistController:handlePM_AssistOneClickUpgradeTeamRes(msg, status)
	if status ~= 0 then
		return
	end

	local hasChange, changeInfo = PetAssistModel.instance:UpgradePetTeamsLevel(msg.teamLvInfo)

	if hasChange == true then
		local attrsList = PetAssistModel.instance:GetTeamChangeAttrsByChangeInfo(changeInfo)

		if attrsList == nil or #attrsList == 0 then
			FloatWordMgr.instance:show(lang("一键升级成功"))
		else
			UIStateManager.instance:open(ViewName.AssistUpgrade, 1, changeInfo)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_AssistOneClickUpgradeTeamRes, hasChange)
end

function PetAssistController:handlePM_AssistOneClickDeployRes(msg, status)
	PetAssistModel.instance:InitAllAssistInfos(msg.teamInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AssistOneClickDeployRes)
end

function PetAssistController:CSSetPetTeamPositionReq(teamType, petId, pos)
	local info = PetAssistModel.instance:GetSubTeamInfo(teamType)
	local oldPetId

	self.addPetInfo = {
		teamType = teamType,
		petId = petId,
		pos = pos,
		oldPetId = (info and info.posPetInfos and checknumber(info.posPetInfos[pos]) > 0 or nil) and info.posPetInfos[pos]
	}

	AssistAgent.instance:sendPM_AssistSetPetPositionReq(teamType, petId, pos)
end

function PetAssistController:SCSetPetTeamPosition(msg, status)
	if status ~= 0 then
		self.addPetInfo = nil

		return
	end

	PetAssistModel.instance:PetTeamAddPetInfo(self.addPetInfo)
	UIStateManager.instance:open(ViewName.AssistUpgrade, 2, self.addPetInfo)

	self.addPetInfo = nil
end

function PetAssistController:SCPetPositionDrop(msg, status)
	if msg == nil or msg.dropTeams == nil then
		return
	end

	PetAssistModel.instance:PetTeamDropPetInfo(msg.dropTeams)
end

PetAssistController.instance = PetAssistController.New()

return PetAssistController
