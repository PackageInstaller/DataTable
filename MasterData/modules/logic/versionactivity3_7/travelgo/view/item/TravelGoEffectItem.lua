-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoEffectItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoEffectItem", package.seeall)

local TravelGoEffectItem = class("TravelGoEffectItem", LuaCompBase)

function TravelGoEffectItem:init(go)
	self.viewGO = go
	self.particleSpeedModify = self.viewGO:GetComponent(gohelper.Type_ParticleSpeedModify)
end

function TravelGoEffectItem:setData(time, res, speed, returnEffect, context)
	self.res = res
	self.returnEffect = returnEffect
	self.context = context

	self.particleSpeedModify:SetSpeed(speed)
	TaskDispatcher.runDelay(self.complete, self, time)
end

function TravelGoEffectItem:onDestroy()
	TaskDispatcher.cancelTask(self.complete, self)
end

function TravelGoEffectItem:complete()
	TaskDispatcher.cancelTask(self.complete, self)

	if self.returnEffect then
		self.returnEffect(self.context, self)
	end
end

return TravelGoEffectItem
