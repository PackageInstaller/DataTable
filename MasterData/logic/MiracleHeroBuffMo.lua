-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/battleMo/MiracleHeroBuffMo.lua

module("logic.extensions.miraclehero.model.battleMo.MiracleHeroBuffMo", package.seeall)

local MiracleHeroBuffMo = class("MiracleHeroBuffMo")

function MiracleHeroBuffMo:ctor()
	self.battleId = 0
	self.buffId = 0
	self.configId = 0
	self.targetId = 0
	self.tier = 0
	self.buffCfg = nil
end

function MiracleHeroBuffMo:initData(cfg)
	self.tier = 10000
	self.buffCfg = cfg
end

function MiracleHeroBuffMo:onAddBuffBefore()
	return
end

function MiracleHeroBuffMo:onAddBuff()
	return
end

function MiracleHeroBuffMo:onRemoveBefore()
	return
end

function MiracleHeroBuffMo:onRemoveBuff()
	return
end

function MiracleHeroBuffMo:onDamage(totalDamage)
	return totalDamage
end

function MiracleHeroBuffMo:onAttackPowerChange(powerChange)
	return powerChange
end

function MiracleHeroBuffMo:onDefendPowerChange(powerChange)
	return powerChange
end

return MiracleHeroBuffMo
