-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePipeMemoryMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePipeMemoryMO", package.seeall)

local ExplorePipeMemoryMO = class("ExplorePipeMemoryMO", ExplorePipeBaseMO)

function ExplorePipeMemoryMO:initTypeData()
	self._needColor = tonumber(self.specialDatas[1])
	self._pipeOutDir = tonumber(self.specialDatas[2])
end

function ExplorePipeMemoryMO:setCacheColor(color)
	self._cacheColor = color
end

function ExplorePipeMemoryMO:getColor(dir)
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

	self._cacheColor = self._cacheColor or self:getInteractInfoMO().statusInfo.color or ExploreEnum.PipeColor.None

	return self._cacheColor
end

function ExplorePipeMemoryMO:getPipeOutDir()
	if not self._pipeOutDir then
		return
	end

	return ExploreHelper.getDir(self._pipeOutDir + self.unitDir)
end

function ExplorePipeMemoryMO:isOutDir(dir)
	return ExploreHelper.getDir(dir - self.unitDir) == self._pipeOutDir
end

function ExplorePipeMemoryMO:getDirType(dir)
	if dir == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	elseif dir == self._pipeOutDir then
		return ExploreEnum.PipeGoNode.Pipe2
	end
end

function ExplorePipeMemoryMO:getNeedColor()
	return self._needColor
end

function ExplorePipeMemoryMO:getUnitClass()
	return ExplorePipeMemoryUnit
end

return ExplorePipeMemoryMO
