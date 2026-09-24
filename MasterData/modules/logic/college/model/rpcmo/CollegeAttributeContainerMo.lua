-- chunkname: @modules/logic/college/model/rpcmo/CollegeAttributeContainerMo.lua

module("modules.logic.college.model.rpcmo.CollegeAttributeContainerMo", package.seeall)

local CollegeAttributeContainerMo = pureTable("CollegeAttributeContainerMo")

function CollegeAttributeContainerMo:init(data)
	self.attributes, self.attributesMap = GameUtil.rpcInfosToListAndMap(data.attributes, CollegeAttributeValueMo, "id", self.attributesMap)
end

function CollegeAttributeContainerMo:getAttrVal(id)
	if not self.attributesMap[id] then
		return 0
	end

	return self.attributesMap[id].value or 0
end

function CollegeAttributeContainerMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeAttributeContainerMo" then
		return false
	end

	local isSame = true

	if #self.attributes ~= #otherMo.attributes then
		isSame = false

		logError(string.format("CollegeAttributeContainerMo compareWith attributes count not same: %s >> %s", #self.attributes, #otherMo.attributes))
	else
		for i = 1, #self.attributes do
			local otherAttrMo = otherMo.attributesMap[self.attributes[i].id]

			if not otherAttrMo or not self.attributes[i]:compareWith(otherAttrMo) then
				isSame = false

				logError(string.format("CollegeAttributeContainerMo compareWith attributes not same: id=%s", self.attributes[i].id))

				break
			end
		end
	end

	return isSame
end

return CollegeAttributeContainerMo
