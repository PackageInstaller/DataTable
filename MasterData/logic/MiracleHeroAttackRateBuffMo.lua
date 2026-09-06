-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/buffMo/MiracleHeroAttackRateBuffMo.lua

module("logic.extensions.miraclehero.model.buffMo.MiracleHeroAttackRateBuffMo", package.seeall)

local MiracleHeroAttackRateBuffMo = class("MiracleHeroAttackRateBuffMo", MiracleHeroBuffMo)

function MiracleHeroAttackRateBuffMo:ctor()
	MiracleHeroAttackRateBuffMo.super.ctor(self)

	self.buffType = MiracleHeroBuffType.AttackRate
	self.changeValue = 0
end

function MiracleHeroAttackRateBuffMo:initData(buffId, params, effectTime)
	self.configId = buffId
	self.tier = effectTime
	self.changeValue = checknumber(params)
end

function MiracleHeroAttackRateBuffMo:onAttackPowerChange(powerChange)
	return powerChange + self.changeValue
end

return MiracleHeroAttackRateBuffMo
