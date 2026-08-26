-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballColliderEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballColliderEntity", package.seeall)

local PinballColliderEntity = class("PinballColliderEntity", LuaCompBase)

function PinballColliderEntity:ctor()
	self.x = 0
	self.y = 0
	self.vx = 0
	self.vy = 0
	self.ax = 0
	self.ay = 0
	self.decx = 0
	self.decy = 0
	self.curHitEntityIdList = {}
	self.inBlackHoleId = nil
	self.isDead = false
	self.width = 1
	self.height = 1
	self.scale = 1
	self.shape = PinballEnum.Shape.Rect
	self.path = ""
	self.id = 0
	self.angle = 0
	self.baseForceX = 1
	self.baseForceY = 1

	self:onInit()
end

function PinballColliderEntity:onInit()
	return
end

function PinballColliderEntity:initByCo(pinballUnitCo)
	if not pinballUnitCo then
		return
	end

	self.x = pinballUnitCo.posX
	self.y = pinballUnitCo.posY
	self.angle = pinballUnitCo.angle
	self.spData = pinballUnitCo.specialData
	self.path = pinballUnitCo.spriteName
	self.shape = pinballUnitCo.shape
	self.scale = pinballUnitCo.scale
	self.resType = pinballUnitCo.resType
	self.width = pinballUnitCo.size.x / 2 * self.scale
	self.height = pinballUnitCo.size.y / 2 * self.scale
	self.vx = pinballUnitCo.speed.x
	self.vy = pinballUnitCo.speed.y
	self.unitCo = pinballUnitCo

	self:onInitByCo()
	transformhelper.setLocalRotation(self.trans, 0, 0, self.angle)
	transformhelper.setLocalScale(self.trans, self.scale, self.scale, self.scale)
end

function PinballColliderEntity:onInitByCo()
	return
end

function PinballColliderEntity:loadRes()
	if not string.nilorempty(self.path) then
		gohelper.setActive(self._imageComp, true)
		UISpriteSetMgr.instance:setAct178Sprite(self._imageComp, self.path, true)
		transformhelper.setLocalScale(self.trans, self.scale, self.scale, self.scale)

		self._imageComp.maskable = not not ((self:isResType() or self.unitType == PinballEnum.UnitType.TriggerRefresh) and (self.vx ~= 0 or self.vy ~= 0))
	else
		gohelper.setActive(self._imageComp, false)
	end
end

function PinballColliderEntity:onResLoaded()
	return
end

function PinballColliderEntity:init(go)
	self.go = go
	self.trans = go.transform
	self._imageComp = gohelper.findChildImage(self.go, "icon")
	self._anim = gohelper.findChildAnim(go, "")
	self._tail = gohelper.findChild(go, "trail")

	if self._tail then
		self._tailEffect = gohelper.onceAddComponent(self._tail, typeof(ZProj.EffectTimeScale))
	end
end

function PinballColliderEntity:playAnim(animName, time)
	if not self._anim then
		return
	end

	self._anim:Play(animName, 0, time or 0)
end

function PinballColliderEntity:tick(dt)
	self.vx = (self.vx + self.ax * dt) * (1 - self.decx * dt)
	self.vy = (self.vy + self.ay * dt) * (1 - self.decy * dt)
	self.x = self.x + self.vx * dt
	self.y = self.y + self.vy * dt

	if not self._cacheX or self._cacheX ~= self.x or self._cacheY ~= self.y then
		self._cacheX = self.x
		self._cacheY = self.y

		recthelper.setAnchor(self.trans, self.x, self.y)
	end

	self:fixedPos()
	self:onTick(dt)
end

function PinballColliderEntity:_createLinkEntity(x, y)
	if self.linkEntity then
		return
	end

	self.linkEntity = PinballEntityMgr.instance:addEntity(self.unitType, self.unitCo)
	self.linkEntity.x = x
	self.linkEntity.y = y
	self.linkEntity.vx = self.vx
	self.linkEntity.vy = self.vy
	self.linkEntity.linkEntity = self

	self.linkEntity:tick(0)
	self:onCreateLinkEntity(self.linkEntity)
end

function PinballColliderEntity:onCreateLinkEntity(linkEntity)
	return
end

function PinballColliderEntity:_delLinkEntity()
	if self.linkEntity then
		self.linkEntity.linkEntity = nil
	end

	self.isDead = true
end

function PinballColliderEntity:fixedPos()
	if self.isDead then
		return
	end

	if self.vx > 0 then
		if self.x + self.width > PinballConst.Const3 then
			self:_createLinkEntity(PinballConst.Const4 - self.width, self.y)
		end

		if self.x - self.width > PinballConst.Const3 then
			self:_delLinkEntity()

			return
		end
	elseif self.vx < 0 then
		if self.x - self.width < PinballConst.Const4 then
			self:_createLinkEntity(PinballConst.Const3 + self.width, self.y)
		end

		if self.x + self.width < PinballConst.Const4 then
			self:_delLinkEntity()

			return
		end
	end

	if self.vy > 0 then
		if self.y + self.height > PinballConst.Const1 then
			self:_createLinkEntity(self.x, PinballConst.Const2 - self.height)
		end

		if self.y - self.height > PinballConst.Const1 then
			self:_delLinkEntity()

			return
		end
	elseif self.vy < 0 then
		if self.y - self.height < PinballConst.Const2 then
			self:_createLinkEntity(self.x, PinballConst.Const1 + self.height)
		end

		if self.y + self.height < PinballConst.Const2 then
			self:_delLinkEntity()

			return
		end
	end
end

function PinballColliderEntity:canHit()
	return true
end

function PinballColliderEntity:isCheckHit()
	return false
end

function PinballColliderEntity:isBounce()
	return true
end

function PinballColliderEntity:isResType()
	return PinballHelper.isResType(self.unitType)
end

function PinballColliderEntity:isMarblesType()
	return PinballHelper.isMarblesType(self.unitType)
end

function PinballColliderEntity:isOtherType()
	return PinballHelper.isOtherType(self.unitType)
end

function PinballColliderEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	return
end

function PinballColliderEntity:onHitExit(hitEntityId)
	return
end

function PinballColliderEntity:onEnterHole()
	gohelper.setActive(self._tail, false)
end

function PinballColliderEntity:onExitHole()
	gohelper.setActive(self._tail, true)
end

function PinballColliderEntity:onTick(dt)
	return
end

function PinballColliderEntity:markDead()
	self.isDead = true

	if self.linkEntity and not self.linkEntity.isDead then
		self.linkEntity:markDead()

		self.linkEntity = nil
	end
end

function PinballColliderEntity:onDestroy()
	self.curHitEntityIdList = {}
end

function PinballColliderEntity:dispose()
	gohelper.destroy(self.go)
end

return PinballColliderEntity
