-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillHitAlertBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillHitAlertBase", package.seeall)

local ArcadeSkillHitAlertBase = class("ArcadeSkillHitAlertBase", ArcadeSkillHitBase)

function ArcadeSkillHitAlertBase:ctor(params, entityType, uid)
	self._alertRound = 0
	self._curRound = 0

	ArcadeSkillHitAlertBase.super.ctor(self, params, entityType, uid)
end

function ArcadeSkillHitAlertBase:onHit()
	if self._context and self._context.target then
		self._curRound = self._curRound + 1

		local target = self._context.target

		if self._curRound > self._alertRound then
			self._curLimit = self._curLimit + 1
			self._curRound = 0

			self:addHiter(target)
			self:onHitAction()
		else
			local lockRound = target:getLockRound()

			if not lockRound or lockRound < 1 then
				target:setLockRound(1)
			end

			self:onAlertAction()
		end
	end
end

function ArcadeSkillHitAlertBase:setAlertRound(round)
	self._alertRound = round
end

function ArcadeSkillHitAlertBase:onHitAction()
	return
end

function ArcadeSkillHitAlertBase:onAlertAction()
	return
end

function ArcadeSkillHitAlertBase:onHitLimitCount()
	return
end

function ArcadeSkillHitAlertBase:onHitPrintLog()
	logNormal(string.format("%s:onHit() ==> 每X回合出现:%s/%s", self.__cname, self._curRound, self._alertRound))
end

return ArcadeSkillHitAlertBase
