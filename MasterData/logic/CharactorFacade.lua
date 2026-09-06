-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/facade/CharactorFacade.lua

module("logic.extensions.character.facade.CharactorFacade", package.seeall)

local CharactorFacade = class("CharactorFacade", BaseFacade)

function CharactorFacade:ctor()
	return
end

function CharactorFacade:isMagicPet(curFaceId)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	if not petCo then
		return
	end

	local job = petCo.job

	if not job or #job == 0 then
		return
	end

	local careers = string.split(job, ",")

	for i = 1, #careers do
		local jobId = GameEnum.JobZh[careers[i]]

		if jobId then
			local jobCo = CharacterConfig.instance:getJobCo(jobId)

			if jobCo and jobCo.attackType == 2 then
				return true
			end
		end
	end
end

function CharactorFacade:isPhysicPet(curFaceId)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	if not petCo then
		return
	end

	local job = petCo.job

	if not job or #job == 0 then
		return
	end

	local careers = string.split(job, ",")

	for i = 1, #careers do
		local jobId = GameEnum.JobZh[careers[i]]

		if jobId then
			local jobCo = CharacterConfig.instance:getJobCo(jobId)

			if jobCo and jobCo.attackType == 1 then
				return true
			end
		end
	end
end

function CharactorFacade:getModelUIPosAndScale(view, modelId)
	local viewName = view.viewName

	return CharacterConfig.instance:getModelUIPosAndScale(viewName, modelId)
end

function CharactorFacade:getPetRankRaceMyInfoModelUIPosAndScale(modelId)
	return self:getPetBagLihuiModelUIPosAndScale(modelId)
end

function CharactorFacade:getShareModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("share", modelId)
end

function CharactorFacade:getShareLihuiModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("sharelihui", modelId)
end

function CharactorFacade:getCommonLiHuiUIPosAndScale(modelId)
	local data = CharacterConfig.instance:getModelCo(modelId)
	local isLihui = data and not string.nilorempty(data.bustName)

	if isLihui then
		local var_8_0 = CharactorFacade.instance:getShareLihuiModelUIPosAndScale(modelId)

		if not var_8_0 then
			var_8_0 = CharactorFacade.instance:getShareModelUIPosAndScale(modelId)

			return var_8_0
		end
	end
end

function CharactorFacade:getPetBagModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("bag", modelId)
end

function CharactorFacade:getPetBagLihuiModelUIPosAndScale(modelId)
	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("baglihui", modelId)

	if displayBagOffset == nil then
		displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(modelId)
	end

	return displayBagOffset
end

function CharactorFacade:getFormationModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("formation", modelId)
end

function CharactorFacade:getEvolveViewModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("select", modelId)
end

function CharactorFacade:getHandbookModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("handbook", modelId)
end

function CharactorFacade:getHandbookLihuiModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("handbooklihui", modelId)
end

function CharactorFacade:getPetDisplayModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("display", modelId)
end

function CharactorFacade:getBattleResultModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("resultsofbattle", modelId)
end

function CharactorFacade:getSelectModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("select", modelId)
end

function CharactorFacade:getTowerModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("tower", modelId)
end

function CharactorFacade:getLegendModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("legend", modelId)
end

function CharactorFacade:getPetIntrodModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("petintroduction", modelId)
end

function CharactorFacade:getTreasureModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("treasure", modelId)
end

function CharactorFacade:getPetChallengeUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("petchallenge", modelId)
end

function CharactorFacade:getContractSignModelUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("contractenter", modelId)
end

function CharactorFacade:getDirectPurchaseUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("directpurchase", modelId)
end

function CharactorFacade:getFamilySeasonUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("familySeason", modelId)
end

function CharactorFacade:getFamilyWarUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("familyWar", modelId)
end

function CharactorFacade:getSeasonUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("season", modelId)
end

function CharactorFacade:getYdAnswerUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("ydAnswer", modelId)
end

function CharactorFacade:getElizabethUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("elizabethView", modelId)
end

function CharactorFacade:getPetSummaryUIPosAndScale(modelId)
	return CharacterConfig.instance:getModelUIPosAndScale("newpet", modelId)
end

CharactorFacade.instance = CharactorFacade.New()

return CharactorFacade
