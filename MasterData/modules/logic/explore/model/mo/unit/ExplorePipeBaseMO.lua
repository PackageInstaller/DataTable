-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePipeBaseMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePipeBaseMO", package.seeall)

local ExplorePipeBaseMO = class("ExplorePipeBaseMO", ExploreBaseUnitMO)

function ExplorePipeBaseMO:getColor(dir)
	local mapPipe = ExploreController.instance:getMapPipe()

	if not mapPipe or not mapPipe:isInitDone() then
		return ExploreEnum.PipeColor.None
	end

	if dir == -1 then
		return mapPipe:getCenterColor(self.id)
	end

	return mapPipe:getDirColor(self.id, ExploreHelper.getDir(dir + self.unitDir))
end

function ExplorePipeBaseMO:getDirType(dir)
	return
end

function ExplorePipeBaseMO:canRotate()
	if not self._canRotate then
		for i, v in ipairs(self.triggerEffects) do
			if v[1] == ExploreEnum.TriggerEvent.Rotate then
				self._canRotate = true
			end
		end
	end

	return self._canRotate
end

function ExplorePipeBaseMO:isDivisive()
	return false
end

function ExplorePipeBaseMO:getPipeOutDir()
	return nil
end

function ExplorePipeBaseMO:isOutDir(dir)
	return false
end

return ExplorePipeBaseMO
