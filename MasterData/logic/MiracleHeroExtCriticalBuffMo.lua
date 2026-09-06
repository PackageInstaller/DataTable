-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/buffMo/MiracleHeroExtCriticalBuffMo.lua

module("logic.extensions.miraclehero.model.buffMo.MiracleHeroExtCriticalBuffMo", package.seeall)

local MiracleHeroExtCriticalBuffMo = class("MiracleHeroExtCriticalBuffMo", MiracleHeroBuffMo)

function MiracleHeroExtCriticalBuffMo:ctor()
	MiracleHeroExtCriticalBuffMo.super.ctor(self)

	self.buffType = MiracleHeroBuffType.ExtCritical
	self.criticalRate = 0
	self.criticalDamage = 0
end

function MiracleHeroExtCriticalBuffMo:initData(buffId, params, effectTime)
	self.configId = buffId
	self.tier = effectTime

	local param = string.split(params, "#")

	self.criticalRate = checknumber(param[1])
	self.criticalDamage = checknumber(param[2])
end

function MiracleHeroExtCriticalBuffMo:onDamage(damage)
	local totalDamage = damage
	local random = math.random(1, 10000)
	local isCritical = random <= self.criticalRate * 10000

	if isCritical then
		totalDamage = totalDamage * self.criticalDamage
	end

	return totalDamage, isCritical
end

return MiracleHeroExtCriticalBuffMo
