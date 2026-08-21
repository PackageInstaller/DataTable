-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/EntityHitEffectConfig.lua

module("logic.battle.config.EntityHitEffectConfig", package.seeall)

local EntityHitEffectConfig = class("EntityHitEffectConfig")
local kModelCode2HitEffectCode = {
	[100036] = 10028
}

function EntityHitEffectConfig:getHitEffectCode(modelCode)
	return kModelCode2HitEffectCode[modelCode] or false
end

EntityHitEffectConfig.instance = EntityHitEffectConfig.New()

return EntityHitEffectConfig
