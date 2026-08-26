-- chunkname: @modules/logic/fight/entity/comp/FightEntityMoveComp.lua

module("modules.logic.fight.entity.comp.FightEntityMoveComp", package.seeall)

local FightEntityMoveComp = class("FightEntityMoveComp", FightBaseClass)

function FightEntityMoveComp:onConstructor(entity)
	self.entity = entity
	self.go = entity.go
	self.mover = MonoHelper.addLuaComOnceToGo(self.go, UnitMoverEase, self)
	self.parabolaMover = MonoHelper.addLuaComOnceToGo(self.go, UnitMoverParabola, self)
	self.bezierMover = MonoHelper.addLuaComOnceToGo(self.go, UnitMoverBezier, self)
	self.curveMover = MonoHelper.addLuaComOnceToGo(self.go, UnitMoverCurve, self)
	self.moveHandler = MonoHelper.addLuaComOnceToGo(self.go, UnitMoverHandler, self)
end

function FightEntityMoveComp:setTimeScale(speed)
	if self.mover then
		self.mover:setTimeScale(speed)
	end

	if self.parabolaMover then
		self.parabolaMover:setTimeScale(speed)
	end

	if self.bezierMover then
		self.bezierMover:setTimeScale(speed)
	end

	if self.curveMover then
		self.curveMover:setTimeScale(speed)
	end
end

function FightEntityMoveComp:onDestructor()
	return
end

return FightEntityMoveComp
