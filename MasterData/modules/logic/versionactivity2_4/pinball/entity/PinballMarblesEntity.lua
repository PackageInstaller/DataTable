-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballMarblesEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesEntity", package.seeall)

local PinballMarblesEntity = class("PinballMarblesEntity", PinballColliderEntity)

function PinballMarblesEntity:onInit()
	self.ay = PinballConst.Const5
	self.shape = PinballEnum.Shape.Circle
	self.speedScale = 1
	self.path = "v2a4_tutushizi_ball_0"
	self.decx = PinballConst.Const14
	self.decy = PinballConst.Const14
	self._isTemp = false
	self._hitDict = {}
end

function PinballMarblesEntity:initByCo()
	self.co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][self.unitType]
	self.path = self.co.icon
	self.lv = PinballModel.instance:getMarblesLvCache(self.unitType)

	local scaleArr = string.splitToNumber(self.co.radius, "#") or {}

	self.scale = (scaleArr[self.lv] or scaleArr[#scaleArr] or 1000) / 1000 * PinballConst.Const7
	self.width = PinballConst.Const6 * self.scale
	self.height = PinballConst.Const6 * self.scale

	local elasticityArr = string.splitToNumber(self.co.elasticity, "#") or {}
	local baseForce = (elasticityArr[self.lv] or elasticityArr[#elasticityArr] or 1000) / 1000

	self.baseForceX = baseForce
	self.baseForceY = baseForce
	self.speedScale = self.co.velocity / 1000

	local hitArr = string.splitToNumber(self.co.detectTime, "#") or {}

	self.hitNum = hitArr[self.lv] or hitArr[#hitArr] or 1

	local effectArr = string.splitToNumber(self.co.effectTime, "#") or {}

	self.effectNum = effectArr[self.lv] or effectArr[#effectArr] or 1

	local effectArr2 = string.splitToNumber(self.co.effectTime2, "#") or {}

	self.effectNum2 = effectArr2[self.lv] or effectArr2[#effectArr2] or 1
end

function PinballMarblesEntity:fixedPos()
	if self.y < PinballConst.Const2 and self.vy < 0 then
		self:markDead()
	end

	if self.y > PinballConst.Const1 and self.vy > 0 then
		self.vy = -self.vy
	end

	if self.x + self.width > PinballConst.Const3 and self.vx > 0 then
		self.vx = -self.vx

		local effectEntity = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

		effectEntity:setDelayDispose(2)

		effectEntity.x = self.x + self.width
		effectEntity.y = self.y

		effectEntity:tick(0)
		effectEntity:playAnim("hit")

		if self.unitType == PinballEnum.UnitType.MarblesElasticity then
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
		end
	end

	if self.x - self.width < PinballConst.Const4 and self.vx < 0 then
		self.vx = -self.vx

		local effectEntity = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

		effectEntity:setDelayDispose(2)

		effectEntity.x = self.x - self.width
		effectEntity.y = self.y

		effectEntity:tick(0)
		effectEntity:playAnim("hit")

		if self.unitType == PinballEnum.UnitType.MarblesElasticity then
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
		end
	end
end

function PinballMarblesEntity:onTick(dt)
	if self._isTemp then
		return
	end

	self.vx = Mathf.Clamp(self.vx, PinballConst.Const8, PinballConst.Const9)
	self.vy = Mathf.Clamp(self.vy, PinballConst.Const10, PinballConst.Const11)

	if math.abs(self.vx) < PinballConst.Const12 and math.abs(self.vy) < PinballConst.Const12 then
		self.stopDt = not self.stopDt and 0 or self.stopDt + dt

		if self.stopDt > PinballConst.Const13 then
			self:markDead()
		end
	else
		self.stopDt = nil
	end
end

function PinballMarblesEntity:canHit()
	return not self._isTemp
end

function PinballMarblesEntity:isCheckHit()
	return not self._isTemp
end

function PinballMarblesEntity:setTemp()
	self._isTemp = true
	self.ay = 0
end

function PinballMarblesEntity:getHitResCount()
	return 1
end

function PinballMarblesEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity then
		return
	end

	if hitEntity:isResType() then
		hitEntity:doHit(self:getHitResCount())
	end

	if hitEntity.unitType == PinballEnum.UnitType.TriggerElasticity then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio14)
	elseif self.unitType == PinballEnum.UnitType.MarblesElasticity then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
	else
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
	end

	if not hitEntity:isBounce() then
		return
	end

	self.vx = self.vx * self.baseForceX * hitEntity.baseForceX
	self.vy = self.vy * self.baseForceY * hitEntity.baseForceY

	local outAngle = 0
	local preHitEntityId = next(self._hitDict)

	if preHitEntityId then
		local preHitEntity = PinballEntityMgr.instance:getEntity(preHitEntityId)

		if preHitEntity:isOtherType() and not hitEntity:isOtherType() then
			return
		end

		local totalX = hitX - self.x
		local totalY = hitY - self.y

		for _, hit in pairs(self._hitDict) do
			totalX = totalX + hit.x
			totalY = totalY + hit.y
		end

		outAngle = math.deg(math.atan2(totalY, totalX))
	else
		local hitAngle = math.deg(math.atan2(self.y - hitY, self.x - hitX))
		local vAngle = math.deg(math.atan2(self.vy, self.vx))

		vAngle = (180 + vAngle) % 360
		outAngle = hitAngle * 2 - vAngle
		outAngle = hitAngle * 2 - vAngle + math.random(0, 20) - 10
	end

	local vLen = math.sqrt(self.vx * self.vx + self.vy * self.vy)

	self.vx, self.vy = PinballHelper.rotateAngle(vLen, 0, outAngle)

	local hitDis = self.width - math.sqrt((hitX - self.x)^2 + (hitY - self.y)^2)

	hitDis = math.max(hitDis, 0.1)
	self._hitDict[hitEntityId] = {
		x = hitX - self.x,
		y = hitY - self.y
	}
	self.ay = 0
end

function PinballMarblesEntity:onHitExit(hitEntityId)
	self._hitDict[hitEntityId] = nil

	if not next(self._hitDict) then
		self.ay = PinballConst.Const5
	end
end

return PinballMarblesEntity
