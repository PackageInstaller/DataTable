-- chunkname: @modules/logic/explore/map/unit/ExplorePipeEntranceUnit.lua

module("modules.logic.explore.map.unit.ExplorePipeEntranceUnit", package.seeall)

local ExplorePipeEntranceUnit = class("ExplorePipeEntranceUnit", ExploreBaseDisplayUnit)

function ExplorePipeEntranceUnit:initComponents()
	ExplorePipeEntranceUnit.super.initComponents(self)
	self:addComp("pipeComp", ExplorePipeComp)
end

function ExplorePipeEntranceUnit:setupMO()
	ExplorePipeEntranceUnit.super.setupMO(self)
	self.pipeComp:initData()
end

function ExplorePipeEntranceUnit:onMapInit()
	ExplorePipeEntranceUnit.super.onMapInit(self)

	local bindPotId = self.mo:getBindPotId()
	local potUnit = ExploreController.instance:getMap():getUnit(bindPotId, true)

	if potUnit then
		potUnit:setParent(self.trans, ExploreEnum.ExplorePipePotHangType.Put)
	end
end

function ExplorePipeEntranceUnit:tryTrigger()
	local id = tonumber(ExploreModel.instance:getUseItemUid())
	local map = ExploreController.instance:getMap()
	local catchUnit = map:getUnit(id, true)
	local bindPotId = self.mo:getBindPotId()

	if catchUnit and catchUnit:getUnitType() == ExploreEnum.ItemType.PipePot and bindPotId == 0 or bindPotId > 0 and not catchUnit then
		ExplorePipeEntranceUnit.super.tryTrigger(self)
	end
end

function ExplorePipeEntranceUnit:onStatus2Change(preStatuInfo, nowStatuInfo)
	if ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	if not preStatuInfo.bindInteractId then
		local prePotId = 0

		if not nowStatuInfo.bindInteractId then
			local nowPotId = 0

			if prePotId ~= nowPotId then
				if prePotId == 0 then
					ExploreModel.instance:setStepPause(true)

					local map = ExploreController.instance:getMap()
					local potUnit = map:getUnit(nowPotId)

					ExploreHeroCatchUnitFlow.instance:uncatchUnitFrom(potUnit, self, self.onFlowEnd)
					ExploreModel.instance:setUseItemUid("0", true)
					map:getCatchComp():setCatchUnit(nil)
				elseif nowPotId == 0 then
					ExploreModel.instance:setStepPause(true)

					local map = ExploreController.instance:getMap()
					local potUnit = ExploreController.instance:getMap():getUnit(prePotId)

					ExploreHeroCatchUnitFlow.instance:catchUnitFrom(potUnit, self, self.onFlowEnd)
					ExploreModel.instance:setUseItemUid(tostring(prePotId), true)
					map:getCatchComp():setCatchUnit(potUnit)
				else
					logError("???")
				end
			end
		end
	end
end

function ExplorePipeEntranceUnit:onFlowEnd()
	ExploreModel.instance:setStepPause(false)
	ExploreController.instance:getMapPipe():initColors()
end

return ExplorePipeEntranceUnit
