-- chunkname: @modules/logic/explore/map/unit/ExploreLightReceiverUnit.lua

module("modules.logic.explore.map.unit.ExploreLightReceiverUnit", package.seeall)

local ExploreLightReceiverUnit = class("ExploreLightReceiverUnit", ExploreBaseLightUnit)

function ExploreLightReceiverUnit:getLightRecvDirs()
	local dirs = {
		[ExploreHelper.getDir(self.mo.unitDir)] = true
	}

	if self.mo.isPhoticDir then
		dirs[ExploreHelper.getDir(self.mo.unitDir + 180)] = true
	end

	return dirs
end

function ExploreLightReceiverUnit:onLightEnter(lightMO)
	local mapLight = ExploreController.instance:getMapLight()

	mapLight:beginCheckStatusChange(self.id, false)
	mapLight:endCheckStatus()
end

function ExploreLightReceiverUnit:haveLight()
	return ExploreController.instance:getMapLight():haveLight(self)
end

function ExploreLightReceiverUnit:onLightChange(lightMO, isEnter)
	if not self.mo.isPhoticDir then
		return
	end

	if isEnter then
		self.lightComp:addLight(lightMO.dir)
	else
		self.lightComp:removeLightByDir(lightMO.dir)
	end
end

function ExploreLightReceiverUnit:onLightExit(lightMO)
	if lightMO and not self:getLightRecvDirs()[ExploreHelper.getDir(lightMO.dir - 180)] then
		return
	end

	local mapLight = ExploreController.instance:getMapLight()

	mapLight:beginCheckStatusChange(self.id, true)
	mapLight:endCheckStatus()
end

return ExploreLightReceiverUnit
