-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaPlayerMO.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaPlayerMO", package.seeall)

local SpLilyaPlayerMO = class("SpLilyaPlayerMO", SpLilyaSceneBaseMo)

function SpLilyaPlayerMO:ctor()
	SpLilyaPlayerMO.super.ctor(self)

	self.res = nil
	self.life = 0
	self.maxLife = 0
	self.aimState = SpLilyaEnum.AimState.Normal
	self.rotation = 0
	self.state = SpLilyaEnum.PlayerState.Normal
	self.stateTime = 0
	self.damageRange = nil
	self.damageEnergyRange = nil
	self.damageRadiusRange = nil
	self.speedRange = nil
	self.bulletPosX = nil
	self.bulletPosY = nil
	self.maxPowerTime = nil
	self.powerTime = nil
	self.shotLimit = nil
	self.lastFireTime = nil
	self.energyMax = nil
	self.energyBulletCount = nil
	self.energyBulletDamage = nil
	self.energyBulletSpeed = nil
	self.normalBulletSpeed = nil
	self.curEnergy = nil
	self.bulletRadius = nil
	self.aimState = SpLilyaEnum.AimState.Normal
	self._isInitConst = false
end

function SpLilyaPlayerMO:initConstData()
	if self._isInitConst then
		return
	end

	self._isInitConst = true

	local damageMinParam = string.splitToNumber(SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.DamageMin, false), "#")
	local damageMaxParam = string.splitToNumber(SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.PowerMax, false), "#")

	self.damageRange = {
		damageMinParam[1],
		damageMaxParam[1]
	}
	self.damageEnergyRange = {
		damageMinParam[2],
		damageMaxParam[2]
	}
	self.damageRadiusRange = {
		damageMinParam[3],
		damageMaxParam[3]
	}
	self.maxPowerTime = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.PowerTime, true)

	local energySkillParam = string.splitToNumber(SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.EnergySkill, false), "#")

	self.energyMax = energySkillParam[1]
	self.energyBulletCount = energySkillParam[2]
	self.energyBulletDamage = energySkillParam[3]
	self.energyBulletSpeed = SpLilyaEnum.EnergyBulletSpeed
	self.normalBulletSpeed = SpLilyaEnum.NormalBulletSpeed

	local maxSpeed = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.SpeedMax, true)
	local minSpeed = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.SpeedMin, true)

	self.speedRange = {
		minSpeed,
		maxSpeed
	}
	self.shotLimit = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.ShotLimit, true)
	self.bulletRadius = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.BulletRadius, true)
end

function SpLilyaPlayerMO:init(gameConfig, halfWidth, halfHeight)
	self.res = gameConfig.res
	self.life = gameConfig.life
	self.maxLife = gameConfig.life
	self.lifeShow = gameConfig.lifeShow
	self.curEnergy = 0
	self.powerTime = 0
	self.lastFireTime = nil
	self.aimState = SpLilyaEnum.AimState.Normal
	self.rotation = 0
	self.state = SpLilyaEnum.PlayerState.Normal
	self.stateTime = 0

	self:setPos(SpLilyaHelper.ConvertOriginPos(SpLilyaEnum.PlayerOriginPos.x, SpLilyaEnum.PlayerOriginPos.y, halfWidth, halfHeight))
	self:initConstData()
end

function SpLilyaPlayerMO:getRes()
	return self.res
end

function SpLilyaPlayerMO:setLife(life)
	self.life = life
end

function SpLilyaPlayerMO:changeState(state)
	if self.state == state then
		self.stateTime = 0

		return false
	end

	self.state = state
	self.stateTime = 0

	return true
end

function SpLilyaPlayerMO:isStateExpired()
	local duration = SpLilyaEnum.PlayerStateDuration[self.state]
	local var_7_1

	if duration ~= nil then
		if duration > (self.stateTime or 0) then
			var_7_1 = false

			goto label_7_0
		end
	end

	::label_7_0::

	return true
end

return SpLilyaPlayerMO
