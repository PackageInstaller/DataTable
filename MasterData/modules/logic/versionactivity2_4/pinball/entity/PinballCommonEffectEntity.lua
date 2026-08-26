-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballCommonEffectEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballCommonEffectEntity", package.seeall)

local PinballCommonEffectEntity = class("PinballCommonEffectEntity", PinballColliderEntity)

function PinballCommonEffectEntity:canHit()
	return false
end

function PinballCommonEffectEntity:initByCo()
	return
end

function PinballCommonEffectEntity:setScale(scale)
	self.scale = scale

	transformhelper.setLocalScale(self.trans, self.scale, self.scale, self.scale)
end

function PinballCommonEffectEntity:setDelayDispose(time)
	TaskDispatcher.runDelay(self.markDead, self, time or 1)
end

function PinballCommonEffectEntity:onDestroy()
	PinballCommonEffectEntity.super.onDestroy(self)
	TaskDispatcher.cancelTask(self.markDead, self)
end

return PinballCommonEffectEntity
