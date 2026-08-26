-- chunkname: @modules/logic/fight/system/work/FightWorkGetSecretKey344.lua

module("modules.logic.fight.system.work.FightWorkGetSecretKey344", package.seeall)

local FightWorkGetSecretKey344 = class("FightWorkGetSecretKey344", FightEffectBase)

function FightWorkGetSecretKey344:onStart()
	local entityMo = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)

	if not entityMo then
		return self:onDone(true)
	end

	FightFloatMgr.instance:float(self.actEffectData.targetId, FightEnum.FloatType.secret_key, luaLang("fight_get_secret_key"))

	local skin = entityMo.skin
	local co = lua_fight_sp_effect_wuerlixi_float.configDict[skin]

	if not co then
		return self:onDone(true)
	end

	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if not entity then
		return self:onDone(true)
	end

	local duration = co.duration
	local audioId = co.audioId
	local effectWrap = entity.uniqueEffect:addHangEffect(co.effect, co.hangPoint, nil, co.duration)

	effectWrap:setLocalPos(0, 0, 0)

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end

	self:com_registTimer(self._delayDone, duration)
end

return FightWorkGetSecretKey344
