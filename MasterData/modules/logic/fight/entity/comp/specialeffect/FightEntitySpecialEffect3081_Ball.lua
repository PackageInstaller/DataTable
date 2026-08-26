-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffect3081_Ball.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3081_Ball", package.seeall)

local FightEntitySpecialEffect3081_Ball = class("FightEntitySpecialEffect3081_Ball", FightBaseClass)

function FightEntitySpecialEffect3081_Ball:onConstructor(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.SetBuffEffectVisible, self._onSetBuffEffectVisible)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, LuaEventSystem.High)
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect)
	self:com_registFightEvent(FightEvent.SkillEditorRefreshBuff, self._onSkillEditorRefreshBuff)

	self._ballEffect = {}
end

local defaultEffect = "default"

FightEntitySpecialEffect3081_Ball.skin2EffectPath = {
	{
		[308103] = "v2a1_ysed_jscq/ysed_jscq_idle_01_head02",
		[defaultEffect] = "v1a7_ysed/ysed_idle_01_head02"
	},
	{
		[308103] = "v2a1_ysed_jscq/ysed_jscq_idle_02_head02",
		[defaultEffect] = "v1a7_ysed/ysed_idle_02_head02"
	},
	{
		[308103] = "v2a1_ysed_jscq/ysed_jscq_idle_03_head02",
		[defaultEffect] = "v1a7_ysed/ysed_idle_03_head02"
	}
}
FightEntitySpecialEffect3081_Ball.buffId2EffectPath = {
	[30810101] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[1],
	[30810102] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[2],
	[30810110] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[2],
	[30810112] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[2],
	[30810114] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[2],
	[30810103] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[3],
	[30810111] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[3],
	[30810113] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[3],
	[30810115] = FightEntitySpecialEffect3081_Ball.skin2EffectPath[3]
}

function FightEntitySpecialEffect3081_Ball:_onBuffUpdate(targetId, effectType, buffId, buffUid)
	if targetId ~= self._entity.id then
		return
	end

	local buffConfig = lua_skill_buff.configDict[buffId]

	if not buffConfig then
		logError("buff表找不到id:" .. buffId)

		return
	end

	local entityMO = self._entity:getMO()

	if not entityMO then
		return
	end

	local config = lua_fight_yi_suo_er_de_ball.configDict[entityMO.skin]

	if not config then
		return
	end

	config = config[buffId]

	if not config then
		return
	end

	local effectPath = config.effect

	if effectPath then
		if effectType == FightEnum.EffectType.BUFFADD then
			self:_releaseEffect(buffId)

			local effectWrap = self._entity.effect:addHangEffect(effectPath, ModuleEnum.SpineHangPointRoot)

			effectWrap:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 9)

			local xPos = self._entity:isMySide() and 1 or -1

			effectWrap:setLocalPos(xPos, 3.1, 0)

			self._ballEffect[buffId] = effectWrap

			local audio = config.audio

			if audio ~= 0 then
				AudioMgr.instance:trigger(audio)
			end
		elseif effectType == FightEnum.EffectType.BUFFDEL then
			self:_releaseEffect(buffId)
		end
	end
end

function FightEntitySpecialEffect3081_Ball:_onBeforeEnterStepBehaviour()
	if FightDataHelper.stateMgr.dealingCrash then
		self:releaseAllEffect()
	end

	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			self:_onBuffUpdate(self._entity.id, FightEnum.EffectType.BUFFADD, v.buffId, v.uid)
		end
	end
end

function FightEntitySpecialEffect3081_Ball:_onSkillEditorRefreshBuff()
	self:releaseAllEffect()
	self:_onBeforeEnterStepBehaviour()
end

function FightEntitySpecialEffect3081_Ball:_onSetBuffEffectVisible(entityId, state, sign)
	if self._entity.id == entityId and self._ballEffect then
		for i, v in pairs(self._ballEffect) do
			v:setActive(state, sign or "FightEntitySpecialEffect3081_Ball")
		end
	end
end

function FightEntitySpecialEffect3081_Ball:_onSkillPlayStart(entity)
	self:_onSetBuffEffectVisible(entity.id, false, "FightEntitySpecialEffect3081_Ball_PlaySkill")
end

function FightEntitySpecialEffect3081_Ball:_onSkillPlayFinish(entity)
	self:_onSetBuffEffectVisible(entity.id, true, "FightEntitySpecialEffect3081_Ball_PlaySkill")
end

function FightEntitySpecialEffect3081_Ball:_releaseEffect(buffId)
	local effectWrap = self._ballEffect[buffId]

	if effectWrap then
		self._entity.effect:removeEffect(effectWrap)
	end

	self._ballEffect[buffId] = nil
end

function FightEntitySpecialEffect3081_Ball:releaseAllEffect()
	for buffId, effect in pairs(self._ballEffect) do
		self:_releaseEffect(buffId)
	end
end

function FightEntitySpecialEffect3081_Ball:_onBeforeDeadEffect(entityId)
	if entityId == self._entity.id then
		self:releaseAllEffect()
	end
end

function FightEntitySpecialEffect3081_Ball:onDestructor()
	self:releaseAllEffect()
end

return FightEntitySpecialEffect3081_Ball
