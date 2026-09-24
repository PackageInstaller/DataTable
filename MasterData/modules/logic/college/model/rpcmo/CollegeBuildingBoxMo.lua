-- chunkname: @modules/logic/college/model/rpcmo/CollegeBuildingBoxMo.lua

module("modules.logic.college.model.rpcmo.CollegeBuildingBoxMo", package.seeall)

local CollegeBuildingBoxMo = pureTable("CollegeBuildingBoxMo")

function CollegeBuildingBoxMo:init(data)
	self.buildings, self.buildingsMap = GameUtil.rpcInfosToListAndMap(data.buildings, CollegeBuildingMo, "id", self.buildingsMap)

	for i, v in ipairs(lua_college_building.configList) do
		if not self.buildingsMap[v.id] then
			table.insert(self.buildings, CollegeBuildingMo.Create(v.id))

			self.buildingsMap[v.id] = self.buildings[#self.buildings]
		end
	end
end

function CollegeBuildingBoxMo:getBuildingMo(id)
	return self.buildingsMap[id]
end

function CollegeBuildingBoxMo:getBuildingMoByType(type)
	for i, v in ipairs(self.buildings) do
		if v.co.buildingType == type and v.level > 0 then
			return v
		end
	end
end

function CollegeBuildingBoxMo:updateBuilding(building)
	local buildingMo = self.buildingsMap[building.id]

	if not buildingMo then
		logError("建筑不存在！" .. building.id)

		return
	end

	if not buildingMo.unlock then
		GameFacade.showToast(ToastEnum.CollegeUnlockBuilding, buildingMo.co.name)
	end

	buildingMo:init(building)
end

function CollegeBuildingBoxMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeBuildingBoxMo" then
		return false
	end

	local isSame = true

	if #self.buildings ~= #otherMo.buildings then
		isSame = false

		logError(string.format("CollegeBuildingBoxMo compareWith buildings count not same: %s >> %s", #self.buildings, #otherMo.buildings))
	else
		for i = 1, #self.buildings do
			local otherBuildingMo = otherMo.buildingsMap[self.buildings[i].id]

			if not otherBuildingMo or not self.buildings[i]:compareWith(otherBuildingMo) then
				isSame = false

				logError(string.format("CollegeBuildingBoxMo compareWith buildings not same: id=%s", self.buildings[i].id))

				break
			end
		end
	end

	return isSame
end

return CollegeBuildingBoxMo
