-- chunkname: @modules/logic/explore/map/unit/ExplorePipePotUnit.lua

module("modules.logic.explore.map.unit.ExplorePipePotUnit", package.seeall)

local ExplorePipePotUnit = class("ExplorePipePotUnit", ExploreBaseMoveUnit)

function ExplorePipePotUnit:setPosByNode(...)
	if not ExploreHeroResetFlow.instance:isReseting() and ExploreHeroCatchUnitFlow.instance:isInFlow(self) then
		return
	end

	ExplorePipePotUnit.super.setPosByNode(self, ...)
end

function ExplorePipePotUnit:setPosByFlow()
	ExplorePipePotUnit.super.setPosByNode(self, self.nodePos)
end

function ExplorePipePotUnit:onStatus2Change(preStatuInfo, nowStatuInfo)
	if not ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	local map = ExploreController.instance:getMap()

	if not nowStatuInfo.bindInteractId then
		local bindEntranceId = 0

		if bindEntranceId > 0 then
			local bindUnit = map:getUnit(bindEntranceId)

			self:setParent(bindUnit.trans, ExploreEnum.ExplorePipePotHangType.Put)
		else
			self:setParent(map:getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		end
	end
end

function ExplorePipePotUnit:setParent(trans, type)
	self.trans:SetParent(trans, false)

	if type == ExploreEnum.ExplorePipePotHangType.Carry then
		local hero = ExploreController.instance:getMap():getHero()
		local heroDir = hero.dir

		self._carryDir = heroDir

		transformhelper.setLocalPos(self.trans, 0, 0, 0)
		transformhelper.setLocalRotation(self.trans, heroDir - 90 - self.mo.unitDir, 0, 90)
		self.clickComp:setEnable(false)
	elseif type == ExploreEnum.ExplorePipePotHangType.UnCarry then
		local hero = ExploreController.instance:getMap():getHero()
		local heroDir = hero.dir - ((not self._carryDir or nil) and 0)

		self.mo.unitDir = heroDir + self.mo.unitDir

		transformhelper.setLocalRotation(self.trans, 0, self.mo.unitDir, 0)
		self:setPosByFlow()
		self.clickComp:setEnable(true)
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, self, self.nodePos, self.nodePos)
	elseif type == ExploreEnum.ExplorePipePotHangType.Pick then
		transformhelper.setLocalPos(self.trans, 0, 0, 0)
		transformhelper.setLocalRotation(self.trans, 0, self.mo.unitDir, 0)
		self.clickComp:setEnable(false)
	elseif type == ExploreEnum.ExplorePipePotHangType.Put then
		transformhelper.setLocalPos(self.trans, 0, 0.65, 0)
		transformhelper.setLocalRotation(self.trans, 180, 360 - self.mo.unitDir, 0)
		self.clickComp:setEnable(false)
	end
end

return ExplorePipePotUnit
