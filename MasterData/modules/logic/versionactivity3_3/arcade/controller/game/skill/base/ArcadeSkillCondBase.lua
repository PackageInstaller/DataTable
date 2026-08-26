-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillCondBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillCondBase", package.seeall)

local ArcadeSkillCondBase = class("ArcadeSkillCondBase", ArcadeSkillClass)

function ArcadeSkillCondBase:ctor(params)
	ArcadeSkillCondBase.super.ctor(self)

	self._params = params

	self:tryCallFunc(self.onCtor)
end

function ArcadeSkillCondBase:onCtor()
	return
end

function ArcadeSkillCondBase:isCondSuccess(context)
	self._context = context

	local isOk, success = self:tryCallFunc(self.onIsCondSuccess)

	if isOk and success then
		return true
	end

	return false
end

function ArcadeSkillCondBase:onIsCondSuccess()
	return true
end

function ArcadeSkillCondBase:getCondNeedCounter()
	return
end

return ArcadeSkillCondBase
