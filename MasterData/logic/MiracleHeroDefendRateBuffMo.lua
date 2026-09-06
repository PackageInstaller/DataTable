-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/buffMo/MiracleHeroDefendRateBuffMo.lua

module("logic.extensions.miraclehero.model.buffMo.MiracleHeroDefendRateBuffMo", package.seeall)

local MiracleHeroDefendRateBuffMo = class("MiracleHeroDefendRateBuffMo", MiracleHeroBuffMo)

function MiracleHeroDefendRateBuffMo:ctor()
	MiracleHeroDefendRateBuffMo.super.ctor(self)

	self.buffType = MiracleHeroBuffType.DefendRate
	self.changeValue = 0
end

function MiracleHeroDefendRateBuffMo:initData(buffId, params, effectTime)
	self.configId = buffId
	self.tier = effectTime
	self.changeValue = checknumber(params)
end

function MiracleHeroDefendRateBuffMo:onDefendPowerChange(powerChange)
	return (powerChange < 0 or nil) and 0
end

return MiracleHeroDefendRateBuffMo
