-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDropPortal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDropPortal", package.seeall)

local ArcadeSkillHitDropPortal = class("ArcadeSkillHitDropPortal", ArcadeSkillHitBase)

function ArcadeSkillHitDropPortal:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._interactiveId = tonumber(params[2])
	self._interIds = {
		self._interactiveId
	}
end

function ArcadeSkillHitDropPortal:onHit()
	if self._context and self._context.target then
		local target = self._context.target
		local gridX, gridY = target:getGridPos()
		local sizeX, sizeY = target:getSize()

		if target:getIsDead() and not target:getHasCorpse() then
			local curRoom = ArcadeGameController.instance:getCurRoom()

			if curRoom then
				curRoom:removeEntityOccupyGrids(target)
			end
		end

		local list = ArcadeGameSummonController.instance:getNearGirdList(gridX, gridY, sizeX, sizeY)

		ArcadeGameSummonController.instance:summonInteractiveList(self._interIds, true)
	end
end

function ArcadeSkillHitDropPortal:onHitPrintLog()
	if self._context and self._context.target then
		logNormal(string.format("%s ==> 生成特定的传送门 %s \n", self:getLogPrefixStr(), self._interactiveId))
	end
end

return ArcadeSkillHitDropPortal
