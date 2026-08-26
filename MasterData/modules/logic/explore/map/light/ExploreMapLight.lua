-- chunkname: @modules/logic/explore/map/light/ExploreMapLight.lua

module("modules.logic.explore.map.light.ExploreMapLight", package.seeall)

local ExploreMapLight = class("ExploreMapLight")

function ExploreMapLight:initLight()
	self._checkCount = 0
	self._unitStatus = {}
	self._initDone = false
	self._lights = {}

	local map = ExploreController.instance:getMap()

	self:beginCheckStatusChange()

	for id, unit in pairs(map._unitDic) do
		if unit:getLightRecvType() == ExploreEnum.LightRecvType.Custom then
			unit:checkLight()
		end
	end

	self:endCheckStatus()

	self._initDone = true
end

function ExploreMapLight:isInitDone()
	return self._initDone
end

function ExploreMapLight:addLight(curUnit, dir)
	local lightMO = ExploreLightMO.New()

	table.insert(self._lights, lightMO)
	lightMO:init(curUnit, dir)

	return lightMO
end

function ExploreMapLight:removeLight(lightMO)
	local endUnit = lightMO.endEmitUnit

	tabletool.removeValue(self._lights, lightMO)

	if endUnit then
		self:removeUnitLight(endUnit, lightMO)
	end
end

function ExploreMapLight:haveLight(unit, excludeLight)
	local lightDirs = unit:getLightRecvDirs()
	local useIlluminant = ExploreEnum.PrismTypes[unit:getUnitType()]

	for _, light in ipairs(self._lights) do
		if light ~= excludeLight and light.endEmitUnit == unit and (not lightDirs or lightDirs[ExploreHelper.getDir(light.dir - 180)]) then
			return true
		end
	end

	if useIlluminant then
		local map = ExploreController.instance:getMap()
		local lightBall = map:getUnitByType(ExploreEnum.ItemType.LightBall)

		if lightBall and ExploreHelper.getDistance(lightBall.nodePos, unit.nodePos) <= 1 then
			return true
		end

		local illuminants = map:getUnitsByType(ExploreEnum.ItemType.Illuminant)

		for _, illuminant in pairs(illuminants) do
			if ExploreHelper.isPosEqual(illuminant.nodePos, unit.nodePos) then
				return true
			end
		end
	end

	return false
end

function ExploreMapLight:haveLightDepth(unit, excludeLight)
	if not unit or not unit:isEnter() then
		return false
	end

	local map = ExploreController.instance:getMap()
	local lightBall = map:getUnitByType(ExploreEnum.ItemType.LightBall)
	local illuminants = map:getUnitsByType(ExploreEnum.ItemType.Illuminant)

	if self:haveIlluminant(unit, lightBall, illuminants) then
		return true
	end

	local checkIds = {
		[unit.id] = true
	}
	local checkedIds = {}

	while next(checkIds) do
		local temp = checkIds

		checkIds = {}

		for id in pairs(temp) do
			checkedIds[id] = true

			local unit = map:getUnit(id)
			local lightDirs = unit:getLightRecvDirs()

			for _, light in ipairs(self._lights) do
				if excludeLight ~= light and light.endEmitUnit == unit and (not lightDirs or lightDirs[ExploreHelper.getDir(light.dir - 180)]) and not checkedIds[light.curEmitUnit.id] then
					checkIds[light.curEmitUnit.id] = true
				end
			end
		end
	end

	for id in pairs(checkedIds) do
		local unit = map:getUnit(id)

		if self:haveIlluminant(unit, lightBall, illuminants) then
			return true
		end
	end

	return false
end

function ExploreMapLight:haveIlluminant(unit, lightBall, illuminants)
	if not unit then
		return false
	end

	if unit:getIsNoEmitLight() then
		return false
	end

	local useIlluminant = ExploreEnum.PrismTypes[unit:getUnitType()]

	if not useIlluminant then
		return false
	end

	if lightBall and ExploreHelper.getDistance(lightBall.nodePos, unit.nodePos) <= 1 then
		return true
	end

	for _, illuminant in pairs(illuminants) do
		if ExploreHelper.isPosEqual(illuminant.nodePos, unit.nodePos) then
			return true
		end
	end
end

function ExploreMapLight:removeUnitEmitLight(unit)
	local removeLights

	for _, light in ipairs(self._lights) do
		if light.curEmitUnit == unit then
			removeLights = removeLights or {}

			table.insert(removeLights, light)
		end
	end

	if removeLights then
		for _, light in pairs(removeLights) do
			self:removeLight(light)
		end
	end
end

function ExploreMapLight:removeUnitLight(unit, excludeLight)
	unit:onLightChange(excludeLight, false)

	if not self:haveLightDepth(unit, excludeLight) then
		unit:onLightExit(excludeLight)

		local removeLights

		for _, light in ipairs(self._lights) do
			if light.curEmitUnit == unit then
				removeLights = removeLights or {}

				table.insert(removeLights, light)
			end
		end

		if removeLights then
			for _, light in pairs(removeLights) do
				self:removeLight(light)
			end
		end
	end
end

function ExploreMapLight:updateLightsByUnit(unit)
	for _, lightMO in pairs(self._lights) do
		if lightMO:isInLight(unit.nodePos) or lightMO.endEmitUnit == unit then
			lightMO:updateData()
		end
	end
end

function ExploreMapLight:getAllLightMos()
	return self._lights
end

function ExploreMapLight:beginCheckStatusChange(id, haveLight)
	self._checkCount = self._checkCount + 1

	if not id then
		return
	end

	self._unitStatus[id] = self._unitStatus[id] or haveLight
end

function ExploreMapLight:endCheckStatus()
	self._checkCount = self._checkCount - 1

	if self._checkCount == 0 then
		local exploreMap = ExploreController.instance:getMap()

		for id, haveLight in pairs(self._unitStatus) do
			local unit = exploreMap:getUnit(id)

			if unit and unit.setActiveAnim then
				local nowHaveLight = unit:haveLight()

				if nowHaveLight ~= haveLight then
					unit:setActiveAnim(nowHaveLight)
				end
			end
		end

		self._unitStatus = {}
	end
end

function ExploreMapLight:unloadMap()
	self:destroy()
end

function ExploreMapLight:destroy()
	self._lights = {}
end

return ExploreMapLight
