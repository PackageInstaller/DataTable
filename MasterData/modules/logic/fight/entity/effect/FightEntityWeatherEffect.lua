-- chunkname: @modules/logic/fight/entity/effect/FightEntityWeatherEffect.lua

module("modules.logic.fight.entity.effect.FightEntityWeatherEffect", package.seeall)

local FightEntityWeatherEffect = class("FightEntityWeatherEffect", FightBaseClass)

function FightEntityWeatherEffect:onConstructor(entity)
	self.entity = entity

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onSceneLevelLoaded)
	self:com_registFightEvent(FightEvent.SetEntityWeatherEffectVisible, self._setEntityWeatherEffectVisible)
	self:com_registFightEvent(FightEvent.SetEntityAlpha, self.onSetEntityAlpha)
	self:showEffect()
end

function FightEntityWeatherEffect:onSceneLevelLoaded()
	self:showEffect()
end

function FightEntityWeatherEffect:showEffect()
	self:releaseEffect()

	local levelId = FightGameMgr.sceneLevelMgr:getCurLevelId()
	local levelCO = lua_scene_level.configDict[levelId]
	local weatherEffect = levelCO.weatherEffect

	if weatherEffect ~= 0 then
		if weatherEffect == 1 then
			self._weatherEffect_url = "roleeffects/roleeffect_rain_write"
			UrpCustom.PPEffectMask.hasRain = true
		elseif weatherEffect == 2 then
			self._weatherEffect_url = "roleeffects/roleeffect_rain_black"
			UrpCustom.PPEffectMask.hasRain = true
		else
			UrpCustom.PPEffectMask.hasRain = false

			logError("错误的天气类型:", weatherEffect)
		end
	else
		UrpCustom.PPEffectMask.hasRain = false
	end

	if not self._weatherEffect_url then
		return
	end

	local target_entity = self.entity

	if target_entity.ingoreRainEffect then
		return
	end

	local spine = target_entity.spine

	if not target_entity.effect or spine._spineGo:GetComponent(typeof(UnityEngine.Renderer)) == nil then
		return
	end

	self.effectWrap = target_entity.effect:addHangEffect(self._weatherEffect_url)

	gohelper.addChild(spine:getSpineGO(), self.effectWrap.containerGO)
	self.effectWrap:setLocalPos(0, 0, 0)
	self.effectWrap:setActive(false)
	self.effectWrap:setActive(true)
end

function FightEntityWeatherEffect:_setEntityWeatherEffectVisible(entity, state)
	if not self.effectWrap then
		return
	end

	if entity == self.entity then
		gohelper.setActive(self.effectWrap.containerGO, state or false)
	end
end

function FightEntityWeatherEffect:onSetEntityAlpha(entityId, state)
	if entityId ~= self.entity.id then
		return
	end

	self:_setEntityWeatherEffectVisible(self.entity, state)
end

function FightEntityWeatherEffect:releaseEffect()
	if self.effectWrap then
		self.entity.effect:removeEffect(self.effectWrap)

		self.effectWrap = nil
	end
end

function FightEntityWeatherEffect:onDestructor()
	return
end

return FightEntityWeatherEffect
