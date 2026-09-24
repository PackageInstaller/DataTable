-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeTriggerBase.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeTriggerBase", package.seeall)

local DeleikeTriggerBase = class("DeleikeTriggerBase", LuaCompBase)

function DeleikeTriggerBase:init(go)
	self.pickupDist = DeleikeEnum.GridUnit
	self.go = go
	self.transform = go.transform
	self.isCollected = false
	self.anim = gohelper.findComponentAnim(go)
end

function DeleikeTriggerBase:onDestroy()
	TaskDispatcher.cancelTask(self.onAnimFinish, self)
end

function DeleikeTriggerBase:setData(type, x, y, worldPos)
	self.type = type
	self.x = x
	self.y = y

	self:setLogicPos(worldPos.x, worldPos.y)

	local size = DeleikeEnum.GridUnit * 0.5

	recthelper.setSize(self.transform, size, size)
	self:onSetData()
end

function DeleikeTriggerBase:getLogicPos()
	return self.worldPos.x, self.worldPos.y
end

function DeleikeTriggerBase:setLogicPos(x, y)
	self.worldPos = {
		x = x,
		y = y
	}

	recthelper.setAnchor(self.transform, x, y)
end

function DeleikeTriggerBase:tryPickup(px, py)
	if self.isCollected then
		return false
	end

	local dx = px - self.worldPos.x
	local dy = py - self.worldPos.y

	if dx * dx + dy * dy > self.pickupDist^2 then
		return false
	end

	self:_collect()
	self:onPicked()
	self.anim:Play("finish", 0, 0)
	TaskDispatcher.runDelay(self.onAnimFinish, self, 1)

	return true
end

function DeleikeTriggerBase:_collect()
	self.isCollected = true
end

function DeleikeTriggerBase:revive()
	self.isCollected = false

	TaskDispatcher.cancelTask(self.onAnimFinish, self)
	gohelper.setActive(self.go, true)
	self.anim:Play("idle", 0, 0)
end

function DeleikeTriggerBase:onSetData()
	return
end

function DeleikeTriggerBase:onPicked()
	return
end

function DeleikeTriggerBase:onAnimFinish()
	gohelper.setActive(self.go, false)
end

return DeleikeTriggerBase
