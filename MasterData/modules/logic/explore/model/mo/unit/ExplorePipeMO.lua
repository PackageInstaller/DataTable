-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePipeMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePipeMO", package.seeall)

local ExplorePipeMO = class("ExplorePipeMO", ExplorePipeBaseMO)

function ExplorePipeMO:initTypeData()
	self._pipeShape = tonumber(self.specialDatas[1])
	self._outDir = tonumber(self.specialDatas[2])
end

function ExplorePipeMO:isDivisive()
	return self._pipeShape == ExploreEnum.PipeShape.Shape3 or self._pipeShape == ExploreEnum.PipeShape.Shape4
end

function ExplorePipeMO:getPipeOutDir(fromDir)
	if not fromDir then
		return
	end

	local rawDir = ExploreHelper.getDir(fromDir - self.unitDir)

	if self._pipeShape == ExploreEnum.PipeShape.Shape1 then
		if rawDir == 0 or rawDir == 180 then
			return ExploreHelper.getDir(fromDir - 180)
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape2 then
		if rawDir == 0 then
			return ExploreHelper.getDir(fromDir + 90)
		elseif rawDir == 90 then
			return ExploreHelper.getDir(fromDir - 90)
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if (rawDir == 0 or rawDir == 90 or rawDir == 180) and self._outDir then
			if self._outDir == rawDir then
				return
			end

			return ExploreHelper.getDir(self._outDir + self.unitDir)
		end

		if rawDir == 0 then
			return ExploreHelper.getDir(fromDir + 90), ExploreHelper.getDir(fromDir + 180)
		elseif rawDir == 90 then
			return ExploreHelper.getDir(fromDir - 90), ExploreHelper.getDir(fromDir + 90)
		elseif rawDir == 180 then
			return ExploreHelper.getDir(fromDir - 90), ExploreHelper.getDir(fromDir - 180)
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if (rawDir == 0 or rawDir == 90 or rawDir == 180 or rawDir == 270) and self._outDir then
			if self._outDir == rawDir then
				return
			end

			return ExploreHelper.getDir(self._outDir + self.unitDir)
		end

		return ExploreHelper.getDir(fromDir + 90), ExploreHelper.getDir(fromDir + 180), ExploreHelper.getDir(fromDir + 270)
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape5 then
		if rawDir == 0 then
			return ExploreHelper.getDir(fromDir + 90)
		elseif rawDir == 90 then
			return ExploreHelper.getDir(fromDir - 90)
		elseif rawDir == 180 then
			return ExploreHelper.getDir(fromDir + 90)
		elseif rawDir == 270 then
			return ExploreHelper.getDir(fromDir - 90)
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape6 and (rawDir == 0 or rawDir == 180 or rawDir == 90 or rawDir == 270) then
		return ExploreHelper.getDir(fromDir - 180)
	end
end

function ExplorePipeMO:isOutDir(dir)
	local rawDir = ExploreHelper.getDir(dir - self.unitDir)

	if self._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if self._outDir then
			return self._outDir == rawDir
		end

		return rawDir == 0 or rawDir == 90 or rawDir == 180
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if self._outDir then
			return self._outDir == rawDir
		end

		return rawDir == 0 or rawDir == 90 or rawDir == 180 or rawDir == 270
	end

	return false
end

function ExplorePipeMO:haveOutDir()
	return not not self._outDir
end

function ExplorePipeMO:getDirType(dir)
	if self._pipeShape == ExploreEnum.PipeShape.Shape1 then
		if dir == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif dir == 180 and self:canRotate() then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape2 then
		if dir == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif dir == 90 and self:canRotate() then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if dir == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif dir == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		elseif dir == 180 then
			return ExploreEnum.PipeGoNode.Pipe3
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if dir == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif dir == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		elseif dir == 180 then
			return ExploreEnum.PipeGoNode.Pipe3
		elseif dir == 270 then
			return ExploreEnum.PipeGoNode.Pipe4
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape5 then
		if dir == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif dir == 180 then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif self._pipeShape == ExploreEnum.PipeShape.Shape6 then
		if dir == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif dir == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	end
end

function ExplorePipeMO:getUnitClass()
	return ExplorePipeUnit
end

return ExplorePipeMO
