-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/model/LingShenChallengeFormationMo.lua

module("logic.extensions.lingshenchallenge.model.LingShenChallengeFormationMo", package.seeall)

local LingShenChallengeFormationMo = class("LingShenChallengeFormationMo", FormationMO)

function LingShenChallengeFormationMo:GetHeroSkillId()
	self._heroSkillId = checknumber(self._heroSkillId)

	if self._heroSkillId > 0 then
		local skills = self:_getValidHeroSkills()

		self._heroSkillId = table.getn(skills) > 0 and skills[1] or 0
	end

	return self._heroSkillId
end

function LingShenChallengeFormationMo:GetPsychicedSkillId()
	self._psychicedSkillId = 0

	for i, v in ipairs(self._positions) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if petCo.psychicSkillId ~= 0 then
					self._psychicedSkillId = petCo.psychicSkillId

					break
				end
			end
		end
	end

	return self._psychicedSkillId
end

function LingShenChallengeFormationMo:GetElementalMasterId()
	self._elementalMasterId = 0

	return self._elementalMasterId
end

return LingShenChallengeFormationMo
