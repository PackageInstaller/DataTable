-- chunkname: @modules/logic/explore/map/unit/comp/ExploreUnitLightComp.lua

module("modules.logic.explore.map.unit.comp.ExploreUnitLightComp", package.seeall)

local ExploreUnitLightComp = class("ExploreUnitLightComp", LuaCompBase)

function ExploreUnitLightComp:ctor(unit)
	self.unit = unit
	self.lights = {}
end

function ExploreUnitLightComp:init(go)
	self.go = go
end

function ExploreUnitLightComp:addLight(dir)
	if dir % 45 ~= 0 then
		return
	end

	local lightMO = ExploreController.instance:getMapLight():addLight(self.unit, dir)
	local index = #self.lights + 1

	self.lights[index] = {
		mo = lightMO,
		lightItem = ExploreMapLightPool.instance:getInst(lightMO, self.go)
	}
end

function ExploreUnitLightComp:haveLight()
	return #self.lights > 0
end

function ExploreUnitLightComp:onLightDataChange(lightMO)
	for i = 1, #self.lights do
		if self.lights[i].mo == lightMO then
			return self.lights[i].lightItem:updateLightMO(lightMO)
		end
	end
end

function ExploreUnitLightComp:addLights(dir1, dir2)
	self:addLight(dir1)
	self:addLight(dir2)
end

function ExploreUnitLightComp:removeLightByDir(dir)
	for index, lightInfo in ipairs(self.lights) do
		if lightInfo.mo.dir == dir then
			ExploreMapLightPool.instance:inPool(lightInfo.lightItem)
			table.remove(self.lights, index)

			break
		end
	end
end

function ExploreUnitLightComp:removeAllLight()
	for _, lightInfo in pairs(self.lights) do
		ExploreMapLightPool.instance:inPool(lightInfo.lightItem)
	end

	self.lights = {}
end

function ExploreUnitLightComp:onDestroy()
	self:removeAllLight()

	self.go = nil
	self.unit = nil
end

return ExploreUnitLightComp
