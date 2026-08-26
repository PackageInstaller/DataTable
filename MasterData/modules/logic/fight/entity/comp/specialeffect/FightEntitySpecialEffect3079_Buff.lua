-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffect3079_Buff.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3079_Buff", package.seeall)

local FightEntitySpecialEffect3079_Buff = class("FightEntitySpecialEffect3079_Buff", FightBaseClass)

function FightEntitySpecialEffect3079_Buff:onConstructor(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)

	self._showBuffIdList = {}
end

local _effectTime = 1.5
local _effectInterval = 0.9

function FightEntitySpecialEffect3079_Buff:_onBuffUpdate(targetId, effectType, buffId, buffUid, configEffect, buffData)
	if targetId ~= self._entity.id then
		return
	end

	if not buffData then
		return
	end

	local fromEntityData = FightDataHelper.entityMgr:getById(buffData.fromUid)

	if not fromEntityData then
		return
	end

	if not lua_fight_6_buff_effect.configDict[fromEntityData.skin] then
		local config = lua_fight_6_buff_effect.configDict[0]

		config = config and config[buffId]

		if config and effectType == FightEnum.EffectType.BUFFADD then
			table.insert(self._showBuffIdList, {
				buffId = buffId,
				config = config
			})

			if not self._playing then
				self:_showBuffEffect()
			end
		end
	end
end

function FightEntitySpecialEffect3079_Buff:_showBuffEffect()
	local tab = table.remove(self._showBuffIdList, 1)

	if tab then
		self._playing = true

		local config = tab.config

		if string.nilorempty(config.effectHang) then
			if not ModuleEnum.SpineHangPointRoot then
				local hangPoint = config.effectHang
				local effectWrap = self._entity.effect:addHangEffect(config.effect, hangPoint, nil, _effectTime)

				FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
				effectWrap:setLocalPos(0, 0, 0)
				self:com_registTimer(self._showBuffEffect, _effectInterval)

				if config.audioId ~= 0 then
					AudioMgr.instance:trigger(config.audioId)
				end
			end
		end
	else
		self._playing = false
	end
end

return FightEntitySpecialEffect3079_Buff
