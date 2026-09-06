-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/model/HolyChallFastFormation.lua

module("logic.extensions.kingway.model.HolyChallFastFormation", package.seeall)

local HolyChallFastFormation = class("HolyChallFastFormation", FastFormationBase)

function HolyChallFastFormation:_getCurFormId()
	return HolyChallModel.instance:getCurFormationId()
end

function HolyChallFastFormation:_getCurFormation()
	return HolyChallModel.instance:getFormation()
end

function HolyChallFastFormation:setFormation(isForce, notFilterFunc)
	self.position = nil

	HolyChallFastFormation.super.setFormation(self, isForce, notFilterFunc)
end

function HolyChallFastFormation:_changePosition(pos, value)
	self.position = self.position or {}

	local challengeId = HolyChallModel.instance:getCurChallengeId()

	self.position[challengeId] = self.position[challengeId] or {}
	self.position[challengeId][pos] = value
end

function HolyChallFastFormation:_setPositionFinish()
	local challengeId = HolyChallModel.instance:getCurChallengeId()

	self:_getCurFormation():setPositionForce(self.position[challengeId])
end

function HolyChallFastFormation:_getPets()
	return HolyChallModel.instance:getAllPets(false)
end

function HolyChallFastFormation:_getPet(id)
	return HolyChallModel.instance:getPet(id)
end

function HolyChallFastFormation:SetHeroSkillId()
	self:_getCurFormation():SetHeroSkillId(410027)
end

function HolyChallFastFormation:clean(fixedPosDic)
	local formId = self:_getCurFormId()
	local formCo = BattleConfig.instance:getFormationCo(formId)
	local challengeId = HolyChallModel.instance:getCurChallengeId()
	local creepId = HolyChallConfig.instance:GetChallGuardCfg(challengeId).supportPetId
	local supprotCfg = HolyChallConfig.instance:getSupportCreep(creepId)
	local targetIdx = supprotCfg.posId

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
		end
	end

	self:_setPositionFinish()
end

function HolyChallFastFormation:innerNotFilterFunc(petMo)
	local tempId = HolyChallModel.instance:getCreepsId()
	local temPetMo = self:_getPet(tempId)

	if temPetMo and temPetMo.raceId == petMo.raceId then
		return false
	end

	return true
end

function HolyChallFastFormation:getMyCurFormationList()
	local tempId = HolyChallModel.instance:getCreepsId()
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

function HolyChallFastFormation:setPetAtFixedPos(posList, finalList)
	local creepId = HolyChallModel.instance:getCreepsId()
	local supprotCfg = HolyChallConfig.instance:getSupportCreep(creepId)
	local targetIdx = supprotCfg.posId
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

HolyChallFastFormation.instance = HolyChallFastFormation.New()

return HolyChallFastFormation
