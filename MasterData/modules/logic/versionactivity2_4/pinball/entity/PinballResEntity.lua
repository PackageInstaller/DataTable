-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballResEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballResEntity", package.seeall)

local PinballResEntity = class("PinballResEntity", PinballColliderEntity)

function PinballResEntity:doHit(hitNum)
	if self.isDead then
		return
	end

	self:onHitCount(hitNum)

	if self.isDead then
		self._waitAnim = true

		TaskDispatcher.runDelay(self._delayDestory, self, 1.5)
		self:playAnim("disapper")
	else
		self:playAnim("hit")
	end
end

function PinballResEntity:onHitCount(hitNum)
	return
end

function PinballResEntity:_delayDestory()
	gohelper.destroy(self.go)
end

function PinballResEntity:onDestroy()
	PinballResEntity.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._delayDestory, self)
end

function PinballResEntity:dispose()
	if not self._waitAnim then
		gohelper.destroy(self.go)
	end
end

return PinballResEntity
