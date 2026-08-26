-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitPassiveSkillAdd.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitPassiveSkillAdd", package.seeall)

local ArcadeSkillHitPassiveSkillAdd = class("ArcadeSkillHitPassiveSkillAdd", ArcadeSkillHitBase)

function ArcadeSkillHitPassiveSkillAdd:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._addSkillId = tonumber(params[2])
end

function ArcadeSkillHitPassiveSkillAdd:onHit()
	if self._context and self._context.target then
		local target = self._context.target
		local skillSetMO = target:getSkillSetMO()

		self:addHiter(target)

		if skillSetMO then
			local skill = skillSetMO:getSkillById(self._addSkillId)

			if not skill then
				skillSetMO:addSkillById(self._addSkillId)
			end
		end
	end
end

function ArcadeSkillHitPassiveSkillAdd:onHitPrintLog()
	logNormal(string.format("%s ==> 自身获得特定id的被动技能:[%s]", self:getLogPrefixStr(), self._addSkillId))
end

return ArcadeSkillHitPassiveSkillAdd
