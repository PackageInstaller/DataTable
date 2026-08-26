-- chunkname: @modules/logic/survival/model/map/Survival3DModelMO.lua

module("modules.logic.survival.model.map.Survival3DModelMO", package.seeall)

local Survival3DModelMO = pureTable("Survival3DModelMO")

function Survival3DModelMO:setDataByUnitMo(unitMo)
	self.isSearch = unitMo.unitType == SurvivalEnum.UnitType.Search
	self.curHeroPath = nil
	self.curUnitPath = nil
	self.isHandleHeroPath = true

	local resource = unitMo:getResPath()
	local cameraType = unitMo.co.camera
	local isExPointUnit = next(unitMo.exPoints)

	self:setData(resource, cameraType, isExPointUnit)
end

function Survival3DModelMO:setDataByEventID(eventID, unitResPath)
	self.curHeroPath = nil
	self.curUnitPath = nil
	self.isHandleHeroPath = false

	local resource = unitResPath
	local cameraType
	local isExPointUnit = false

	if eventID then
		local co = lua_survival_fight.configDict[eventID]

		co = co or SurvivalConfig.instance:getNpcConfig(eventID, true)
		co = co or lua_survival_search.configDict[eventID]
		co = co or lua_survival_mission.configDict[eventID]

		if co then
			resource = co.resource
			cameraType = co.camera
			isExPointUnit = not string.nilorempty(co.grid)
		end
	end

	self:setData(resource, cameraType, isExPointUnit)
end

function Survival3DModelMO:setData(resource, cameraType, isExPointUnit)
	self.unitPath = resource

	if cameraType == 4 then
		self.curHeroPath = "node6/role"
	elseif self.unitPath and string.find(self.unitPath, "^survival/buiding") then
		if cameraType == 2 then
			self.curUnitPath = "node4/buiding3"
		elseif cameraType == 3 then
			self.curUnitPath = "node5/buiding4"
		elseif isExPointUnit or cameraType == 1 then
			self.curUnitPath = "node3/buiding2"
		else
			self.curUnitPath = "node2/buiding1"
			self.curHeroPath = "node2/role"
		end
	else
		self.curHeroPath = "node1/role"
		self.curUnitPath = "node1/npc"
	end
end

return Survival3DModelMO
