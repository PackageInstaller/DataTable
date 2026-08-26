-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightSceneSpecialEffect0_HuanJingKa.lua

module("modules.logic.fight.entity.comp.specialeffect.FightSceneSpecialEffect0_HuanJingKa", package.seeall)

local FightSceneSpecialEffect0_HuanJingKa = class("FightSceneSpecialEffect0_HuanJingKa", FightBaseClass)
local _EffectPath = "v1a3_huanjing/v1a3_scene_huanjing_effect_01"
local _playAniName = "v1a3_scene_huanjing_effect_01"
local _hideAniName = "v1a3_scene_huanjing_effect_03"
local _reShowAniName = "v1a3_scene_huanjing_effect_04"

function FightSceneSpecialEffect0_HuanJingKa:onConstructor(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.EntityEffectLoaded, self._onEntityEffectLoaded)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
end

function FightSceneSpecialEffect0_HuanJingKa:_onBuffUpdate(targetId, effectType, buffId)
	if self:_isEffectBuff(buffId) then
		self:_dealHuanJingChangJingTeXiao(targetId, effectType, buffId)
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_dealHuanJingChangJingTeXiao(targetId, effectType, buffId)
	local tarEntity = FightHelper.getEntity(targetId)
	local entityMO = tarEntity and tarEntity:getMO()

	if entityMO and entityMO.side == FightEnum.EntitySide.MySide and effectType == FightEnum.EffectType.BUFFADD then
		self:_showEffect()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_showEffect()
	if self._playing then
		return
	end

	self._playing = true
	self._aniName = _playAniName

	if not self._effectWrap then
		self._effectWrap = self._entity.effect:addGlobalEffect(_EffectPath)
	else
		self._effectWrap:setActive(true)
		self:_refreshAni()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_onEntityEffectLoaded(entityId, effectWrap)
	if entityId ~= self._entity.id then
		return
	end

	if effectWrap.path == FightHelper.getEffectUrlWithLod(_EffectPath) then
		local root = gohelper.findChild(effectWrap.effectGO, "root")

		self._ani = gohelper.onceAddComponent(root, typeof(UnityEngine.Animator))

		self:_refreshAni()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_refreshAni()
	if self._ani then
		if self._aniName == _hideAniName then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_dreamland02)
		elseif self._aniName ~= _reShowAniName then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_dreamland01)
		end

		self._ani:Play(self._aniName)
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_hideEffect()
	self._aniName = _hideAniName

	self:_refreshAni()
end

function FightSceneSpecialEffect0_HuanJingKa:_onRoundSequenceFinish()
	if not self:_detectHaveBuff() and self._effectWrap then
		if not self._playing then
			return
		end

		self._playing = false

		self:_hideEffect()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_onFightReconnectLastWork()
	if self:_detectHaveBuff() then
		self:_showEffect()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_detectHaveBuff()
	local haveBuff = false
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for i, v in ipairs(entityList) do
		local entityMO = v:getMO()

		if entityMO then
			local buffDic = entityMO:getBuffDic()

			for index, buff in pairs(buffDic) do
				if self:_isEffectBuff(buff.buffId) then
					haveBuff = true

					break
				end
			end

			if haveBuff then
				break
			end
		end
	end

	return haveBuff
end

function FightSceneSpecialEffect0_HuanJingKa:_isEffectBuff(buffId)
	local buff_config = lua_skill_buff.configDict[buffId]

	if buff_config and (buff_config.typeId == 2130101 or buff_config.typeId == 2130102 or buff_config.typeId == 2130103 or buff_config.typeId == 2130104 or buff_config.typeId == 4130030 or buff_config.typeId == 4130031 or buff_config.typeId == 4130059 or buff_config.typeId == 4130060 or buff_config.typeId == 4130061 or buff_config.typeId == 4130062) then
		return true
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_onSkillPlayStart(entity, curSkillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and self:_detectHaveBuff() and self._effectWrap then
		self:_hideEffect()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_onSkillPlayFinish(entity, curSkillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and self:_detectHaveBuff() and self._effectWrap then
		self._aniName = _reShowAniName

		self:_refreshAni()
	end
end

function FightSceneSpecialEffect0_HuanJingKa:_releaseEffect()
	if self._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._effectWrap)

		self._effectWrap = nil
	end
end

function FightSceneSpecialEffect0_HuanJingKa:onDestructor()
	self:_releaseEffect()
end

return FightSceneSpecialEffect0_HuanJingKa
