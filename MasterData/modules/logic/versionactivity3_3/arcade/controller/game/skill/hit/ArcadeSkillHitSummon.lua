-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitSummon.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitSummon", package.seeall)

local ArcadeSkillHitSummon = class("ArcadeSkillHitSummon", ArcadeSkillHitBase)

function ArcadeSkillHitSummon:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._monsterDataList = {}

	for i = 2, #self._params do
		local arr = string.splitToNumber(self._params[i], ",")

		if arr and #arr >= 3 then
			table.insert(self._monsterDataList, arr)
		end
	end
end

function ArcadeSkillHitSummon:onHit()
	if self._context and self._context.target then
		self:addHiter(self._context.target)
	end

	for _, numArr in ipairs(self._monsterDataList) do
		ArcadeGameSummonController.instance:summonMonsterByXY(numArr[1], numArr[2], numArr[3])
	end
end

function ArcadeSkillHitSummon:onHitPrintLog()
	logNormal(string.format("%s ==> 召唤怪物", self:getLogPrefixStr()))
end

return ArcadeSkillHitSummon
