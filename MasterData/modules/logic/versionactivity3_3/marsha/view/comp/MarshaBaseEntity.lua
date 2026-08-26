-- chunkname: @modules/logic/versionactivity3_3/marsha/view/comp/MarshaBaseEntity.lua

module("modules.logic.versionactivity3_3.marsha.view.comp.MarshaBaseEntity", package.seeall)

local MarshaBaseEntity = class("MarshaBaseEntity", LuaCompBase)

function MarshaBaseEntity:ctor(go)
	self.uid = 0
	self.x = 0
	self.y = 0
	self.speed = 0
	self.weight = 0
	self.width = 0
	self.height = 0
	self.radian = 0
	self.addSpeed = 0
	self.shape = MarshaEnum.Shape.Circle
end

function MarshaBaseEntity:init(go)
	self.go = go
	self.trans = go.transform
	self.image = gohelper.findChildImage(go, "image")
	self.anim = go:GetComponent(gohelper.Type_Animator)
end

function MarshaBaseEntity:onDestroy()
	if self.addSpeed ~= 0 then
		TaskDispatcher.cancelTask(self.addSpeedFinish, self)
	end
end

function MarshaBaseEntity:initBase(unitType, uid)
	self.uid = uid
	self.unitType = unitType
	self.config = MarshaConfig.instance:getBallConfig(self.unitType)
	self.isDead = false
end

function MarshaBaseEntity:setSpeed(speed)
	self.speed = speed
end

function MarshaBaseEntity:setWeight(weight)
	self.weight = weight

	local scale = 1 + weight * MarshaEnum.WeightRate

	self.width = recthelper.getWidth(self.trans) / 2 * scale
	self.height = recthelper.getHeight(self.trans) / 2 * scale

	transformhelper.setLocalScale(self.trans, scale, scale, 1)
end

function MarshaBaseEntity:setPos(x, y)
	self.x = x
	self.y = y

	recthelper.setAnchor(self.trans, self.x, self.y)
end

function MarshaBaseEntity:setDead()
	if self.unitType ~= MarshaEnum.UnitType.Player then
		AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_devour)
	end

	self.isDead = true
end

function MarshaBaseEntity:dispose()
	local time = 1.5

	if self.unitType == MarshaEnum.UnitType.Player or self.unitType == MarshaEnum.UnitType.Inverse or self.unitType == MarshaEnum.UnitType.Dead then
		time = 0.34
	end

	self:playAnim("out")
	TaskDispatcher.runDelay(self.delayDestroy, self, time)
end

function MarshaBaseEntity:delayDestroy()
	gohelper.destroy(self.go)
end

function MarshaBaseEntity:getAnchorPos()
	local x, y = recthelper.getAnchor(self.trans)

	return Vector2(x, y)
end

function MarshaBaseEntity:setAddSpeed(speed, time)
	if self.addSpeed ~= 0 then
		TaskDispatcher.cancelTask(self.addSpeedFinish, self)
	end

	self.addSpeed = speed

	TaskDispatcher.runDelay(self.addSpeedFinish, self, time)
end

function MarshaBaseEntity:addSpeedFinish()
	self.addSpeed = 0
end

function MarshaBaseEntity:getFixSpeed()
	return self.speed + self.addSpeed
end

function MarshaBaseEntity:setUnControl(time, pos, speed)
	if self.unControl then
		TaskDispatcher.cancelTask(self.unControlFinish, self)
	end

	local endDir = self:getAnchorPos() - pos
	local angle = MarshaHelper.SignedAngle(Vector2.right, endDir)

	self.radian = angle * Mathf.Deg2Rad
	self.unControlSpeed = speed or self.speed
	self.unControl = true

	TaskDispatcher.runDelay(self.unControlFinish, self, time)
end

function MarshaBaseEntity:unControlFinish()
	self.unControl = false
end

function MarshaBaseEntity:playAnim(name, continue)
	if continue then
		self.anim:Play(name)
	else
		self.anim:Play(name, 0, 0)
	end
end

function MarshaBaseEntity:initData()
	return
end

function MarshaBaseEntity:tick()
	return
end

return MarshaBaseEntity
