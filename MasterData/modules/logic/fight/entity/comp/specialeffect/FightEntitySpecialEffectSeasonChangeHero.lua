-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectSeasonChangeHero.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectSeasonChangeHero", package.seeall)

local FightEntitySpecialEffectSeasonChangeHero = class("FightEntitySpecialEffectSeasonChangeHero", FightBaseClass)
local KeyWord = "_OutlineWidth"

function FightEntitySpecialEffectSeasonChangeHero:onConstructor(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.EnterOperateState, self._onEnterOperateState)
	self:com_registFightEvent(FightEvent.ExitOperateState, self._onExitOperateState)
	self:com_registFightEvent(FightEvent.SeasonSelectChangeHeroTarget, self._onSeasonSelectChangeHeroTarget)

	self._whiteLine = nil
	self._orangeLine = nil
end

function FightEntitySpecialEffectSeasonChangeHero:_onSeasonSelectChangeHeroTarget(entityId)
	self:_releaseOrangeEffect()

	if entityId == self._entity.id then
		self._orangeLine = self._entity.effect:addHangEffect("buff/buff_outline_orange", ModuleEnum.SpineHangPointRoot)

		self._orangeLine:setLocalPos(0, 0, 0)

		if gohelper.isNil(self._orangeLine.effectGO) then
			self._orangeLine:setCallback(self._setOrangeWidth, self)
		else
			self:_setOrangeWidth()
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._orangeLine)
		self._whiteLine:setActive(false)
	elseif self._whiteLine then
		self._whiteLine:setActive(true)
	end
end

function FightEntitySpecialEffectSeasonChangeHero:_setOrangeWidth()
	self:_setOutlineWidth(self._orangeLine)
end

function FightEntitySpecialEffectSeasonChangeHero:_onExitOperateState(state)
	if state ~= FightStageMgr.OperateStateType.SeasonChangeHero then
		return
	end

	self:releaseAllEffect()
end

function FightEntitySpecialEffectSeasonChangeHero:_onEnterOperateState(state)
	if not self._entity:isMySide() then
		return
	end

	if state == FightStageMgr.OperateStateType.SeasonChangeHero then
		self._whiteLine = self._entity.effect:addHangEffect("buff/buff_outline_white", ModuleEnum.SpineHangPointRoot)

		self._whiteLine:setLocalPos(0, 0, 0)

		if gohelper.isNil(self._whiteLine.effectGO) then
			self._whiteLine:setCallback(self._setWhileWidth, self)
		else
			self:_setWhileWidth()
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._whiteLine)
	end
end

function FightEntitySpecialEffectSeasonChangeHero:_setWhileWidth()
	self:_setOutlineWidth(self._whiteLine)
end

function FightEntitySpecialEffectSeasonChangeHero:_setOutlineWidth(effectWrap)
	if not effectWrap then
		return
	end

	local mat

	if effectWrap and not gohelper.isNil(effectWrap.effectGO) then
		local renderer = gohelper.findChildComponent(effectWrap.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer))

		if renderer then
			mat = renderer.material

			if renderer.material then
				self._defaultOutlineWidth = self._defaultOutlineWidth or mat:GetFloat(KeyWord)
			else
				logError("找不到描边材质")
			end
		else
			logError("找不到描边render")
		end
	end

	if mat then
		local entityMO = self._entity:getMO()

		if entityMO then
			::label_7_0::

			local var_7_0 = entityMO.skin

			if entityMO.skin then
				local skinCO = lua_monster_skin.configDict[entityMO.skin]
				local value = skinCO and skinCO.outlineWidth

				if value and value > 0 then
					mat:SetFloat(KeyWord, value)
				else
					mat:SetFloat(KeyWord, self._defaultOutlineWidth)
				end
			end
		end
	end
end

function FightEntitySpecialEffectSeasonChangeHero:releaseAllEffect()
	self:_releaseWhiteEffect()
	self:_releaseOrangeEffect()
end

function FightEntitySpecialEffectSeasonChangeHero:_releaseWhiteEffect()
	if self._whiteLine then
		self._entity.effect:removeEffect(self._whiteLine)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._whiteLine)

		self._whiteLine = nil
	end
end

function FightEntitySpecialEffectSeasonChangeHero:_releaseOrangeEffect()
	if self._orangeLine then
		self._entity.effect:removeEffect(self._orangeLine)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._orangeLine)

		self._orangeLine = nil
	end
end

function FightEntitySpecialEffectSeasonChangeHero:onDestructor()
	self:releaseAllEffect()
end

return FightEntitySpecialEffectSeasonChangeHero
