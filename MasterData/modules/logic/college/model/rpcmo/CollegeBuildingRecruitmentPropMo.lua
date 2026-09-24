-- chunkname: @modules/logic/college/model/rpcmo/CollegeBuildingRecruitmentPropMo.lua

module("modules.logic.college.model.rpcmo.CollegeBuildingRecruitmentPropMo", package.seeall)

local CollegeBuildingRecruitmentPropMo = pureTable("CollegeBuildingRecruitmentPropMo")

function CollegeBuildingRecruitmentPropMo:init(data)
	self.characters = GameUtil.rpcInfosToList(data.characters, CollegeCharacterMo)

	if self.characters then
		self.characterNum = #self.characters or 0
	end
end

function CollegeBuildingRecruitmentPropMo:isRecruit()
	return self.characterNum > 0
end

function CollegeBuildingRecruitmentPropMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeBuildingRecruitmentPropMo" then
		return false
	end

	local isSame = true

	if #self.characters ~= #otherMo.characters then
		isSame = false

		logError(string.format("CollegeBuildingRecruitmentPropMo compareWith characters count not same: %s >> %s", #self.characters, #otherMo.characters))
	else
		for i = 1, #self.characters do
			if not self.characters[i]:compareWith(otherMo.characters[i]) then
				isSame = false

				logError(string.format("CollegeBuildingRecruitmentPropMo compareWith characters not same: [%s] uid=%s", i, self.characters[i].uid))

				break
			end
		end
	end

	return isSame
end

return CollegeBuildingRecruitmentPropMo
