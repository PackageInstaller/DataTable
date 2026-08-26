-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePipeSensorMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePipeSensorMO", package.seeall)

local ExplorePipeSensorMO = class("ExplorePipeSensorMO", ExplorePipeBaseMO)

function ExplorePipeSensorMO:initTypeData()
	self._needColor = tonumber(self.specialDatas[1])
	self._pipeOutDir = tonumber(self.specialDatas[2])
end

function ExplorePipeSensorMO:getColor(dir)
	if dir == 0 then
		local mapPipe = ExploreController.instance:getMapPipe()

		if mapPipe and mapPipe:isInitDone() then
			local xy = ExploreHelper.dirToXY(self.unitDir)
			local inKey = ExploreHelper.getKeyXY(self.nodePos.x + xy.x, self.nodePos.y + xy.y)
			local inUnitMo = mapPipe._allPipeMos[inKey]
			local nowColor = inUnitMo and mapPipe:getOutDirColor(nil, nil, ExploreHelper.getDir(self.unitDir + 180), inUnitMo.id, ExploreEnum.PipeDirMatchMode.Single)

			return nowColor or ExploreEnum.PipeColor.None
		end
	end

	local isActive = self:isInteractActiveState()

	if not isActive then
		local mapPipe = ExploreController.instance:getMapPipe()

		if mapPipe and mapPipe:isCacheActive(self.id) then
			isActive = true
		end
	end

	if isActive then
		return self._needColor
	else
		return ExploreEnum.PipeColor.None
	end
end

function ExplorePipeSensorMO:getNeedColor()
	return self._needColor
end

function ExplorePipeSensorMO:getDirType(dir)
	if dir == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	elseif dir == self._pipeOutDir then
		return ExploreEnum.PipeGoNode.Pipe2
	end
end

function ExplorePipeSensorMO:getPipeOutDir()
	if not self._pipeOutDir then
		return
	end

	return ExploreHelper.getDir(self._pipeOutDir + self.unitDir)
end

function ExplorePipeSensorMO:isOutDir(dir)
	return ExploreHelper.getDir(dir - self.unitDir) == self._pipeOutDir
end

function ExplorePipeSensorMO:getUnitClass()
	return ExplorePipeSensorUnit
end

return ExplorePipeSensorMO
