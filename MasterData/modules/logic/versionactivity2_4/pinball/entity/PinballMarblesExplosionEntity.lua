-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballMarblesExplosionEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesExplosionEntity", package.seeall)

local PinballMarblesExplosionEntity = class("PinballMarblesExplosionEntity", PinballMarblesEntity)

function PinballMarblesExplosionEntity:initByCo()
	PinballMarblesExplosionEntity.super.initByCo(self)

	self._totalExplosion = self.effectNum
	self._range = self.width * self.effectNum2
	self._curExplosionNum = 0
end

function PinballMarblesExplosionEntity:onHitExit(hitEntityId)
	PinballMarblesExplosionEntity.super.onHitExit(self, hitEntityId)

	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity then
		return
	end

	if self._curExplosionNum < self._totalExplosion and hitEntity:isResType() then
		self:doExplosion()
	end
end

function PinballMarblesExplosionEntity:doExplosion()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio15)

	local explodeEntity = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

	explodeEntity:setDelayDispose(2)

	explodeEntity.x = self.x
	explodeEntity.y = self.y

	explodeEntity:tick(0)
	explodeEntity:setScale(self.effectNum2 * 0.4 * self.scale / 3)
	explodeEntity:playAnim("explode")

	local allEntity = PinballEntityMgr.instance:getAllEntity()
	local rawWidth, rawHeight = self.width, self.height

	self.width = self._range
	self.height = self._range

	for _, entity in pairs(allEntity) do
		if entity:isResType() and not entity.isDead and PinballHelper.getHitInfo(self, entity) then
			entity:doHit(self.hitNum)
		end
	end

	self.width, self.height = rawWidth, rawHeight
	self._curExplosionNum = self._curExplosionNum + 1
end

return PinballMarblesExplosionEntity
