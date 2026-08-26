-- chunkname: @modules/logic/explore/map/unit/ExplorePipeUnit.lua

module("modules.logic.explore.map.unit.ExplorePipeUnit", package.seeall)

local ExplorePipeUnit = class("ExplorePipeUnit", ExploreBaseDisplayUnit)

function ExplorePipeUnit:initComponents()
	ExplorePipeUnit.super.initComponents(self)
	self:addComp("pipeComp", ExplorePipeComp)
end

function ExplorePipeUnit:setupMO()
	ExplorePipeUnit.super.setupMO(self)
	self.pipeComp:initData()
end

function ExplorePipeUnit:onRotateFinish()
	ExploreController.instance:getMapPipe():initColors()
end

return ExplorePipeUnit
