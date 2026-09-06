-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FormationServerMo.lua

module("logic.extensions.formation.model.FormationServerMo", package.seeall)

local FormationServerMo = class("FormationServerMo")

function FormationServerMo:ctor()
	self.curTab = 0
	self.userFormTab = {}
end

function FormationServerMo:getCurTab()
	return self.curTab
end

function FormationServerMo:getUserFormTab()
	return self.userFormTab
end

function FormationServerMo:saveServeData(data)
	self.curTab = data.curTab

	for _, value in ipairs(data.userFormTab) do
		local team = self.userFormTab[value.tabId]

		if not team then
			team = {}
			self.userFormTab[value.tabId] = team
		end

		team.tabId = value.tabId
		team.curFormId = value.curFormId
		team.simpleForm = team.simpleForm or {}
		team.tabName = value.tabName
		team.simpleForm.formId = value.simpleForm.formId
		team.simpleForm.pos = team.simpleForm.pos or {}

		for k, j in ipairs(value.simpleForm.pos) do
			team.simpleForm.pos[k] = j
		end

		team.simpleForm.extParams = team.simpleForm.extParams or {}
		team.simpleForm.extParams.heroSkillId = value.simpleForm.extParams.heroSkillId
		team.simpleForm.extParams.psychicSkillId = value.simpleForm.extParams.psychicSkillId
		team.simpleForm.extParams.spiritInvocationPetId = value.simpleForm.extParams.spiritInvocationPetId
		team.simpleForm.extParams.elementalMasterId = value.simpleForm.extParams.elementalMasterId
		team.simpleForm.extParams.elementalTargetId = value.simpleForm.extParams.elementalTargetId
		team.simpleForm.extParams.cutePetId = value.simpleForm.extParams.cutePetId
		team.simpleForm.extParams.cutePetRaceId = value.simpleForm.extParams.cutePetRaceId
		team.simpleForm.extParams.cutePetQuality = value.simpleForm.extParams.cutePetQuality
		team.simpleForm.extParams.cutePetQuality = value.simpleForm.extParams.cutePetQuality
		team.simpleForm.extParams.heavenAwakenMasterId = value.simpleForm.extParams.heavenAwakenMasterId
		team.simpleForm.extParams.heavenAwakenSummonPetId = value.simpleForm.extParams.heavenAwakenSummonPetId
		team.simpleForm.extParams.summonMasterPetId = value.simpleForm.extParams.summonMasterPetId
		team.simpleForm.extParams.summonedPetId = value.simpleForm.extParams.summonedPetId
	end
end

function FormationServerMo:RefreshServeData(data)
	for i, v in ipairs(data) do
		local team = self.userFormTab[v.tabId]

		if not team then
			team = {}
			self.userFormTab[v.tabId] = team
		end

		team.simpleForm = team.simpleForm or {}
		team.simpleForm.formId = v.simpleForm.formId
		team.simpleForm.pos = team.simpleForm.pos or {}

		for k, j in ipairs(v.simpleForm.pos) do
			team.simpleForm.pos[k] = j
		end

		team.simpleForm.extParams = team.simpleForm.extParams or {}
		team.simpleForm.extParams.heroSkillId = v.simpleForm.extParams.heroSkillId
		team.simpleForm.extParams.psychicSkillId = v.simpleForm.extParams.psychicSkillId
		team.simpleForm.extParams.spiritInvocationPetId = v.simpleForm.extParams.spiritInvocationPetId
		team.simpleForm.extParams.elementalMasterId = v.simpleForm.extParams.elementalMasterId
		team.simpleForm.extParams.elementalTargetId = v.simpleForm.extParams.elementalTargetId
		team.simpleForm.extParams.cutePetId = v.simpleForm.extParams.cutePetId
		team.simpleForm.extParams.cutePetRaceId = v.simpleForm.extParams.cutePetRaceId
		team.simpleForm.extParams.cutePetQuality = v.simpleForm.extParams.cutePetQuality
		team.simpleForm.extParams.heavenAwakenMasterId = v.simpleForm.extParams.heavenAwakenMasterId
		team.simpleForm.extParams.heavenAwakenSummonPetId = v.simpleForm.extParams.heavenAwakenSummonPetId
		team.simpleForm.extParams.summonMasterPetId = v.simpleForm.extParams.summonMasterPetId
		team.simpleForm.extParams.summonedPetId = v.simpleForm.extParams.summonedPetId
	end
end

function FormationServerMo:compareFormData(tabId, formId, formInfo)
	local serverData = self.userFormTab[tabId].simpleForm

	for posId, posInfo in ipairs(formInfo:GetPositions()) do
		if serverData and serverData.pos[posId] ~= posInfo then
			serverData.pos[posId] = posInfo

			return 1
		end
	end

	if serverData and serverData.extParams.heroSkillId ~= formInfo:GetHeroSkillId() then
		serverData.extParams.heroSkillId = formInfo:GetHeroSkillId()

		return 2
	end

	if serverData and serverData.extParams.psychicSkillId ~= formInfo:GetPsychicedSkillId() then
		serverData.extParams.psychicSkillId = formInfo:GetPsychicedSkillId()

		return 3
	end

	if serverData and serverData.extParams.elementalMasterId ~= formInfo:GetElementalMasterId() and formInfo:GetElementalTargetId() > 0 then
		serverData.extParams.elementalMasterId = formInfo:GetElementalMasterId()

		return 4
	end

	if serverData and serverData.extParams.elementalTargetId ~= formInfo:GetElementalTargetId() then
		serverData.extParams.elementalTargetId = formInfo:GetElementalTargetId()

		return 5
	end

	if serverData and serverData.extParams.cutePetId ~= formInfo:GetCutePetId() then
		serverData.extParams.elementalTargetId = formInfo:GetCutePetId()

		return 6
	end

	if serverData and serverData.extParams.cutePetRaceId ~= formInfo:GetCutePetRaceId() then
		serverData.extParams.cutePetRaceId = formInfo:GetCutePetRaceId()

		return 7
	end

	if serverData and serverData.extParams.cutePetQuality ~= formInfo:GetCutePetQuality() then
		serverData.extParams.cutePetQuality = formInfo:GetCutePetQuality()

		return 8
	end

	if formInfo:checkAndResetChangeRace() then
		return 9
	end

	if serverData and serverData.extParams.heavenAwakenMasterId ~= formInfo:GetHeavenAwakenMasterId() then
		serverData.extParams.heavenAwakenMasterId = formInfo:GetHeavenAwakenMasterId()

		return 10
	end

	if serverData and serverData.extParams.heavenAwakenSummonPetId ~= formInfo:GetHeavenAwakenSummonPetId() then
		serverData.extParams.heavenAwakenSummonPetId = formInfo:GetHeavenAwakenSummonPetId()

		return 11
	end

	if serverData and serverData.extParams.summonMasterPetId ~= formInfo:GetSummonMasterPetId() then
		serverData.extParams.summonMasterPetId = formInfo:GetSummonMasterPetId()

		return 12
	end

	if serverData and serverData.extParams.summonedPetId ~= formInfo:GetSummonPetId() then
		serverData.extParams.summonedPetId = formInfo:GetSummonPetId()

		return 13
	end

	if serverData and serverData.extParams.spiritInvocationPetId ~= formInfo:GetSpiritInvocationPetId() then
		serverData.extParams.spiritInvocationPetId = formInfo:GetSpiritInvocationPetId()

		return 14
	end

	return 0
end

return FormationServerMo
