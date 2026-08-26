-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballMarblesDivisionEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesDivisionEntity", package.seeall)

local PinballMarblesDivisionEntity = class("PinballMarblesDivisionEntity", PinballMarblesEntity)
local status = {
	Done = 2,
	Hit = 1,
	None = 0
}

function PinballMarblesDivisionEntity:initByCo()
	PinballMarblesDivisionEntity.super.initByCo(self)

	self._statu = status.None
	self._canHitNum = 0
end

function PinballMarblesDivisionEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	PinballMarblesDivisionEntity.super.onHitEnter(self, hitEntityId, hitX, hitY, hitDir)

	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity or not hitEntity:isResType() then
		return
	end

	if self._statu == status.None then
		self._statu = status.Hit
	end

	if self._canHitNum > 0 then
		self._canHitNum = self._canHitNum - 1

		if self._canHitNum == 0 then
			self:markDead()
		end
	end
end

function PinballMarblesDivisionEntity:onHitExit(hitEntityId)
	PinballMarblesDivisionEntity.super.onHitExit(self, hitEntityId)

	if self._statu == status.Hit then
		self._statu = status.Done

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio17)

		for i = 1, self.effectNum - 1 do
			local randomAngle = math.random(0, 360)
			local newX, newY = PinballHelper.rotateAngle(self.width * 2.1, 0, randomAngle)
			local newEntity = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.MarblesDivision)

			newEntity._statu = status.Done
			newEntity.x = self.x + newX
			newEntity.y = self.y + newY

			local newVX, newVY = PinballHelper.rotateAngle(self.vx, self.vy, randomAngle)

			newEntity.vx = newVX
			newEntity.vy = newVY
			newEntity._canHitNum = self.effectNum2

			newEntity:tick(0)
			newEntity:playAnim("clone")
		end
	end
end

return PinballMarblesDivisionEntity
