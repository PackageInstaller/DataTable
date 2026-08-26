-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitKillSelf.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitKillSelf", package.seeall)

local ArcadeSkillHitKillSelf = class("ArcadeSkillHitKillSelf", ArcadeSkillHitBase)

function ArcadeSkillHitKillSelf:onCtor()
	local params = self._params

	self._changeName = params[1]
end

function ArcadeSkillHitKillSelf:onHit()
	if self._context and self._context.target then
		local target = self._context.target

		self:addHiter(target)

		local curHp = target:getHp()

		ArcadeGameController.instance:changeEntityHp(target, -curHp)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillKillDeathSettle, target)

		local curRoom = ArcadeGameController.instance:getCurRoom()

		if curRoom then
			curRoom:removeEntityOccupyGrids(target)
		end
	end
end

function ArcadeSkillHitKillSelf:onHitPrintLog()
	if self._context and self._context.target then
		local target = self._context.target

		logNormal(string.format("%s ==> 怪物自杀【%s-%s】", self:getLogPrefixStr(), target.id, target:getUid()))
	end
end

return ArcadeSkillHitKillSelf
