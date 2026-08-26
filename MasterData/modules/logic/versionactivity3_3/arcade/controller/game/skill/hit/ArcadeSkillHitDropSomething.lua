-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDropSomething.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDropSomething", package.seeall)

local ArcadeSkillHitDropSomething = class("ArcadeSkillHitDropSomething", ArcadeSkillHitBase)

function ArcadeSkillHitDropSomething:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._dropId = tonumber(params[2])
end

function ArcadeSkillHitDropSomething:onHit()
	local mo = self._context.target
	local gridX, gridY

	if mo then
		gridX, gridY = mo:getGridPos()
	end

	self.dropItem = ArcadeGameController.instance:gainDropItemById(self._dropId, gridX, gridY)

	if self._context and self._context.target then
		self:addHiter(self._context.target)
	end
end

function ArcadeSkillHitDropSomething:onHitPrintLog()
	if self.dropItem then
		logNormal(string.format("%s ==> 掉落成功！dropId:[%s] itemId:%s", self:getLogPrefixStr(), self._dropId, self.dropItem.id))
	else
		logNormal(string.format("%s ==> 掉落失败！==> dropId:[%s]", self:getLogPrefixStr(), self._dropId))
	end
end

return ArcadeSkillHitDropSomething
