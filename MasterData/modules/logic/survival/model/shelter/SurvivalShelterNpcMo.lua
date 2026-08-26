-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterNpcMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterNpcMo", package.seeall)

local SurvivalShelterNpcMo = pureTable("SurvivalShelterNpcMo")

function SurvivalShelterNpcMo:init(data)
	self.id = data.id
	self.status = data.status
	self.co = SurvivalConfig.instance:getNpcConfig(self.id)
end

function SurvivalShelterNpcMo.sort(a, b)
	local shelterStatus1, buildingId1 = a:getShelterNpcStatus()
	local shelterStatus2, buildingId2 = b:getShelterNpcStatus()

	if shelterStatus1 ~= shelterStatus2 then
		return shelterStatus1 < shelterStatus2
	end

	if buildingId1 and buildingId2 and buildingId1 ~= buildingId2 then
		return buildingId1 < buildingId2
	end

	return a.id < b.id
end

function SurvivalShelterNpcMo:getShelterNpcStatus()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingId = weekInfo:getNpcPostion(self.id)

	if buildingId then
		local buildingInfo = weekInfo:getBuildingInfo(buildingId)

		if buildingInfo and buildingInfo:isDestoryed() then
			return SurvivalEnum.ShelterNpcStatus.InDestoryBuild
		else
			return SurvivalEnum.ShelterNpcStatus.InBuild, buildingId
		end
	else
		return SurvivalEnum.ShelterNpcStatus.NotInBuild
	end
end

function SurvivalShelterNpcMo:isEqualStatus(status)
	return self:getShelterNpcStatus() == status
end

function SurvivalShelterNpcMo:isRecommend(mapId)
	local map_group_mapping = lua_survival_map_group_mapping.configDict[mapId]
	local group = map_group_mapping.id
	local map_group = lua_survival_map_group.configDict[group]
	local mapType = map_group.type
	local list = SurvivalConfig.instance:getNpcConfigTag(self.co.id)

	for i, cfgId in ipairs(list) do
		local cfg = SurvivalConfig.instance:getTagCo(cfgId)

		if not string.nilorempty(cfg.suggestMap) then
			local tags = string.splitToNumber(cfg.suggestMap, "#")

			for j, t in ipairs(tags) do
				if t == mapType then
					return true
				end
			end
		end
	end

	return false
end

return SurvivalShelterNpcMo
