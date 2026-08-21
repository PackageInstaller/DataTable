-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleParticleUtil.lua

module("logic.battle.util.BattleParticleUtil", package.seeall)

function BattleParticleUtil.create(effectCode, goParent)
	return ParticleMgr.instance:create(effectCode, goParent)
end

function BattleParticleUtil.remove(handleId)
	ParticleMgr.instance:remove(handleId)
end

return BattleParticleUtil
