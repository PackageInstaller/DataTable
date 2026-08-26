-- chunkname: @modules/logic/character/model/DestinyStoneMO.lua

module("modules.logic.character.model.DestinyStoneMO", package.seeall)

local DestinyStoneMO = class("DestinyStoneMO")

function DestinyStoneMO:initMo(stoneId)
	self.stoneId = stoneId
	self.facetCos = CharacterDestinyConfig.instance:getDestinyFacetCo(stoneId)
	self.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(stoneId)
end

function DestinyStoneMO:refresUnlock(isUnlock)
	self.isUnlock = isUnlock
end

function DestinyStoneMO:refreshUse(isUse)
	self.isUse = isUse
end

function DestinyStoneMO:getFacetCo(level)
	if level then
		return self.facetCos[level]
	end

	return self.facetCos
end

function DestinyStoneMO:getNameAndIcon()
	return self.conusmeCo.name, ResUrl.getDestinyIcon(self.conusmeCo.icon), self.conusmeCo
end

function DestinyStoneMO:isReshape()
	return self.conusmeCo.type == CharacterDestinyEnum.StoneType.Reshape
end

function DestinyStoneMO:getReshapeDesc()
	if not self:isReshape() then
		return
	end

	if self._reshapeDesc then
		return self._reshapeDesc
	end

	local cos = CharacterDestinyConfig.instance:getSkillExlevelCos(self.stoneId)

	self._reshapeDesc = {}

	for _, co in pairs(cos) do
		if not string.nilorempty(co.desc) then
			self._reshapeDesc[co.skillLevel] = co.desc
		end
	end

	return self._reshapeDesc
end

return DestinyStoneMO
