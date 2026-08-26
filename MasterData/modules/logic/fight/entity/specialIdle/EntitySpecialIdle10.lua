-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle10.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle10", package.seeall)

local EntitySpecialIdle10 = class("EntitySpecialIdle10", UserDataDispose)

function EntitySpecialIdle10:ctor(entity)
	self:__onInit()

	self._entity = entity
end

function EntitySpecialIdle10:releaseSelf()
	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle10
