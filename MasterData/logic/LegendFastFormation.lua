-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/controller/LegendFastFormation.lua

module("logic.extensions.legend.controller.LegendFastFormation", package.seeall)

local LegendFastFormation = class("LegendFastFormation", FastFormation)

function LegendFastFormation:_getCurFormId()
	return LegendModel.instance:getCurFormationId()
end

function LegendFastFormation:SetHeroSkillId()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfgSupport = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)

	self:_getCurFormation():SetHeroSkillId((cfgSupport or nil) and LegendController.instance:raceIdToHeroSkillId(cfgSupport.raceId))
end

function LegendFastFormation:clean(fixedPosDic)
	local formId = self:_getCurFormId()
	local formCo = BattleConfig.instance:getFormationCo(formId)
	local targetIdx = self:_getSupportPosId()

	for i = 1, 9 do
		if i ~= targetIdx then
			if fixedPosDic then
				if not fixedPosDic[i] then
					local isFixed = false

					if TableUtil.isHad(formCo.posList, i) and not isFixed then
						self:_changePosition(i, 0)
					end
				end
			end
		else
			local creepId = self:_getCreepId()

			self:_changePosition(i, creepId)
		end
	end

	self:_setPositionFinish()
end

function LegendFastFormation:innerNotFilterFunc(petMo)
	local tempId = self:_getCreepId()
	local temPetMo = self:_getPet(tempId)

	if temPetMo and temPetMo.raceId == petMo.raceId then
		return false
	end

	return true
end

function LegendFastFormation:getMyCurFormationList()
	local tempId = self:_getCreepId()
	local temPetMo = self:_getPet(tempId)
	local list
	local formation = self:_getCurFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = self:_getPet(petId)

			if pet and pet.petId ~= temPetMo.petId then
				list = list or {}

				table.insert(list, pet)
			end
		end
	end

	return list
end

function LegendFastFormation:setPetAtFixedPos(posList, finalList)
	local creepId = self:_getCreepId()
	local targetIdx = self:_getSupportPosId()
	local exist = false

	for k, v in pairs(finalList) do
		if v.petId == creepId then
			exist = true
		end
	end

	local tempMo = self:_getPet(creepId)

	if not exist then
		table.insert(finalList, tempMo)
	end

	for i, v in pairs(finalList) do
		if tempMo and tempMo.petId == v.petId then
			if posList[i] ~= targetIdx then
				for j, pos in ipairs(posList) do
					if pos == targetIdx then
						posList[i], posList[j] = posList[j], posList[i]
					end
				end
			end

			break
		end
	end

	for i, v in ipairs(posList) do
		local pet = finalList[i]

		if pet then
			self:_changePosition(v, pet.petId)
		else
			self:_changePosition(v, 0)
		end
	end
end

function LegendFastFormation:_getCreepId()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()

	return (LegendConfig.instance:getCreepsId(challengeId, stageId))
end

function LegendFastFormation:_getSupportPosId()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfgSupport = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)

	return cfgSupport.posId
end

LegendFastFormation.instance = LegendFastFormation.New()

return LegendFastFormation
