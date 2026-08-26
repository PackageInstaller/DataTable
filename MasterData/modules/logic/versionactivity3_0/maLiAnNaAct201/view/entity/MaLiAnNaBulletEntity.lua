-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/entity/MaLiAnNaBulletEntity.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.entity.MaLiAnNaBulletEntity", package.seeall)

local MaLiAnNaBulletEntity = class("MaLiAnNaBulletEntity", LuaCompBase)

function MaLiAnNaBulletEntity:init(go)
	self._go = go
	self._tr = go.transform
end

function MaLiAnNaBulletEntity:setOnlyId(bulletId)
	self.bulletId = bulletId
end

function MaLiAnNaBulletEntity:getOnlyId()
	return self.bulletId
end

function MaLiAnNaBulletEntity:setInfo(startX, startY, soliderId, speed, bulletPathId, isFollow)
	self:_updateTrPos(startX, startY)

	self._startX = startX
	self._startY = startY
	self._targetSoliderId = soliderId
	self._speed = speed or 0
	self._isFollow = isFollow or false
	self._bulletPathId = bulletPathId or 1

	self:_updateTargetPos()
	self:showModel()
	self:setVisible(true)
end

function MaLiAnNaBulletEntity:onUpdate()
	local delta = Time.deltaTime

	if not self._isVisible or Activity201MaLiAnNaGameController.instance:getPause() then
		return
	end

	self:updateLocalPos(delta)
end

function MaLiAnNaBulletEntity:updateLocalPos(deltaTime)
	if self._tr == nil then
		return
	end

	if self._isFollow then
		self:_updateTargetPos(deltaTime)
	end

	if deltaTime == nil then
		return
	end

	local speed = self._speed * deltaTime

	self._posX = self._posX + self._moveDirX * speed
	self._posY = self._posY + self._moveDirY * speed

	self:_updateTrPos(self._posX, self._posY)

	if MathUtil.hasPassedPoint(self._posX, self._posY, self._endPosX, self._endPosY, self._moveDirX, self._moveDirY) or MathUtil.vec2_lengthSqr(self._posX, self._posY, self._startX, self._startY) > 1000000 then
		self:setVisible(false)
		Activity201MaLiAnNaGameController.instance:consumeSoliderHp(self._targetSoliderId, -Activity201MaLiAnNaEnum.bulletDamage)
		MaliAnNaBulletEntityMgr.instance:releaseBulletEffectEntity(self)
	end
end

function MaLiAnNaBulletEntity:_updateTrPos(x, y)
	self._posX = x
	self._posY = y

	if self._posX ~= nil and self._posY ~= nil then
		transformhelper.setLocalPosXY(self._tr, x, y)
	end
end

function MaLiAnNaBulletEntity:_updateTargetPos(deltaTime)
	local soliderMo = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoById(self._targetSoliderId)

	if soliderMo ~= nil then
		local endX, endY = soliderMo:getLocalPos()

		self._moveDirX, self._moveDirY = MathUtil.vec2_normalize(endX - self._posX, endY - self._posY)
		self._endPosX = endX
		self._endPosY = endY

		local angle = MathUtil.calculateV2Angle(self._posX, self._posY, endX, endY)

		transformhelper.setLocalRotation(self._tr, 0, 0, angle)
	end
end

function MaLiAnNaBulletEntity:getResPath()
	return Activity201MaLiAnNaEnum.BulletEffect[self._bulletPathId]
end

function MaLiAnNaBulletEntity:setVisible(isVisible, force)
	if self._isVisible == isVisible and not force then
		return
	end

	if self.goSpine == nil then
		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.goSpine, self._isVisible)
	gohelper.setActive(self._go, self._isVisible)
end

function MaLiAnNaBulletEntity:showModel()
	if not gohelper.isNil(self.goSpine) then
		return
	end

	if self._loader then
		return
	end

	self._loader = PrefabInstantiate.Create(self._go)

	local path = self:getResPath()

	if string.nilorempty(path) then
		return
	end

	self._loader:startLoad(path, self._onResLoadEnd, self)
end

function MaLiAnNaBulletEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self.goSpine = go

	local scale = self:getScale()

	transformhelper.setLocalScale(trans, scale, scale, scale)
	gohelper.addChild(self._tr.gameObject, self.goSpine)
	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	self:setVisible(true)
end

function MaLiAnNaBulletEntity:getScale()
	return 0.5
end

function MaLiAnNaBulletEntity:onDestroy()
	if self._loader ~= nil then
		self._loader:onDestroy()

		self._loader = nil
	end

	if self._go then
		gohelper.destroy(self._go)

		self._go = nil
	end
end

return MaLiAnNaBulletEntity
