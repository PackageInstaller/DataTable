-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/buffMo/MiracleHeroStateBuffMo.lua

module("logic.extensions.miraclehero.model.buffMo.MiracleHeroStateBuffMo", package.seeall)

local MiracleHeroStateBuffMo = class("MiracleHeroStateBuffMo", MiracleHeroBuffMo)

function MiracleHeroStateBuffMo:ctor()
	MiracleHeroStateBuffMo.super.ctor(self)

	self.buffType = MiracleHeroBuffType.State
end

function MiracleHeroStateBuffMo:initData(buffId, params, effectTime)
	self.configId = buffId
	self.tier = effectTime
end

return MiracleHeroStateBuffMo
