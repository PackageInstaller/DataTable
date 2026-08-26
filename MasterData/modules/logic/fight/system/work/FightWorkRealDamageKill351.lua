-- chunkname: @modules/logic/fight/system/work/FightWorkRealDamageKill351.lua

module("modules.logic.fight.system.work.FightWorkRealDamageKill351", package.seeall)

local FightWorkRealDamageKill351 = class("FightWorkRealDamageKill351", FightEffectBase)

function FightWorkRealDamageKill351:onStart()
	local killCo = self:getKillCo()

	if not killCo then
		return self:onDone(true)
	end

	local targetId = self.actEffectData.targetId
	local targetEntity = FightHelper.getEntity(targetId)

	if not targetEntity then
		return self:onDone(true)
	end

	local effect = killCo.effect
	local hangPoint = killCo.effectHangPoint
	local duration = killCo.duration
	local effectWrap = targetEntity.effect:addHangEffect(effect, hangPoint, nil, duration)

	FightRenderOrderMgr.instance:onAddEffectWrap(targetId, effectWrap)
	effectWrap:setLocalPos(0, 0, 0)

	local audioId = killCo.audio

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end

	local waitTime = killCo.waitTime

	if waitTime <= 0 then
		return self:onDone(true)
	end

	TaskDispatcher.runDelay(self.finishWork, self, waitTime)
end

function FightWorkRealDamageKill351:getKillCo()
	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	for _, entity in ipairs(entityList) do
		local skinId = entity.originSkin
		local co = lua_fight_kill.configDict[skinId]

		if co then
			return co
		end
	end
end

function FightWorkRealDamageKill351:clearWork()
	TaskDispatcher.cancelTask(self.finishWork, self)
end

return FightWorkRealDamageKill351
