-- chunkname: @modules/logic/scene/common/BaseSceneUnitMgr.lua

module("modules.logic.scene.common.BaseSceneUnitMgr", package.seeall)

local BaseSceneUnitMgr = class("BaseSceneUnitMgr", BaseSceneComp)

function BaseSceneUnitMgr:ctor(scene)
	BaseSceneUnitMgr.super.ctor(self, scene)

	self._tagUnitDict = {}
	self._containerGO = self:getCurScene():getSceneContainerGO()
end

function BaseSceneUnitMgr:onSceneClose()
	self:removeAllUnits()
end

function BaseSceneUnitMgr:addUnit(unit)
	gohelper.addChild(self._containerGO, unit.go)

	local tag = unit.go.tag
	local tagUnits = self._tagUnitDict[tag]

	if not tagUnits then
		tagUnits = {}
		self._tagUnitDict[tag] = tagUnits
	end

	tagUnits[unit.id] = unit
end

function BaseSceneUnitMgr:removeUnit(unitTag, unitId)
	local tagUnits = self._tagUnitDict[unitTag]

	if tagUnits then
		local unit = tagUnits[unitId]

		if unit then
			tagUnits[unitId] = nil

			self:destroyUnit(unit)
		end
	end
end

function BaseSceneUnitMgr:removeUnitData(unitTag, unitId)
	if self._tagUnitDict[unitTag] and self._tagUnitDict[unitTag][unitId] then
		self._tagUnitDict[unitTag][unitId] = nil

		return self._tagUnitDict[unitTag][unitId]
	end
end

function BaseSceneUnitMgr:removeUnits(unitTag)
	local tagUnits = self._tagUnitDict[unitTag]

	if tagUnits then
		for id, unit in pairs(tagUnits) do
			tagUnits[id] = nil

			self:destroyUnit(unit)
		end
	end
end

function BaseSceneUnitMgr:removeAllUnits()
	for _, tagUnits in pairs(self._tagUnitDict) do
		for id, unit in pairs(tagUnits) do
			tagUnits[id] = nil

			self:destroyUnit(unit)
		end
	end
end

function BaseSceneUnitMgr:getUnit(unitTag, unitId)
	local tagUnits = self._tagUnitDict[unitTag]

	if tagUnits then
		return tagUnits[unitId]
	end
end

function BaseSceneUnitMgr:getTagUnitDict(unitTag)
	return self._tagUnitDict[unitTag]
end

function BaseSceneUnitMgr:destroyUnit(unit)
	if unit.beforeDestroy then
		unit:beforeDestroy()
	end

	gohelper.destroy(unit.go)
end

return BaseSceneUnitMgr
