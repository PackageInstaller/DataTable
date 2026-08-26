-- chunkname: @modules/logic/fight/entity/comp/specialspine/FightEntitySpecialSpine3072.lua

module("modules.logic.fight.entity.comp.specialspine.FightEntitySpecialSpine3072", package.seeall)

local FightEntitySpecialSpine3072 = class("FightEntitySpecialSpine3072", UserDataDispose)

function FightEntitySpecialSpine3072:ctor(entity)
	self:__onInit()

	self._entity = entity
	self._maskEffect = FightEntitySpecialSpine3072_Mask.New(entity)
end

function FightEntitySpecialSpine3072:playAnim(animState, loop, reStart)
	self._maskEffect:playAnim(animState, loop, reStart)
end

function FightEntitySpecialSpine3072:setFreeze(isFreeze)
	self._maskEffect:setFreeze(isFreeze)
end

function FightEntitySpecialSpine3072:setTimeScale(timeScale)
	self._maskEffect:setTimeScale(timeScale)
end

function FightEntitySpecialSpine3072:setLayer(layer, recursive)
	self._maskEffect:setLayer(layer, recursive)
end

function FightEntitySpecialSpine3072:setRenderOrder(order, force)
	self._maskEffect:setRenderOrder(order, force)
end

function FightEntitySpecialSpine3072:changeLookDir(dir)
	self._maskEffect:changeLookDir(dir)
end

function FightEntitySpecialSpine3072:_changeLookDir()
	self._maskEffect:_changeLookDir()
end

function FightEntitySpecialSpine3072:setActive(isActive)
	self._maskEffect:setActive(isActive)
end

function FightEntitySpecialSpine3072:setAnimation(animState, loop, mixTime)
	self._maskEffect:setAnimation(animState, loop, mixTime)
end

function FightEntitySpecialSpine3072:releaseSelf()
	if self._maskEffect then
		self._maskEffect:releaseSelf()

		self._maskEffect = nil
	end

	self._entity = nil

	self:__onDispose()
end

return FightEntitySpecialSpine3072
