-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitThrowingBomb.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitThrowingBomb", package.seeall)

local ArcadeSkillHitThrowingBomb = class("ArcadeSkillHitThrowingBomb", ArcadeSkillHitBase)

function ArcadeSkillHitThrowingBomb:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._bombIdList = {}

	for i = 2, #params do
		local bombId = tonumber(params[i])

		if bombId then
			table.insert(self._bombIdList, bombId)
		end
	end

	self._flyingTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FlyingEffectTime, true) or 0.3
end

function ArcadeSkillHitThrowingBomb:onHit()
	self._atkCount = 0

	if self._context and self._context.target then
		local dataList = ArcadeGameSummonController.instance:summonBombList(self._bombIdList, self._flyingTime)
		local gameScent = ArcadeGameController.instance:getGameScene()

		if dataList then
			self._atkCount = #dataList or 0
		end

		if dataList and #dataList > 0 and self.atkEffectId and self.atkEffectId ~= 0 and gameScent then
			local gx, gy = self._context.target:getGridPos()
			local beginX, beginY = ArcadeGameHelper.getGridPos(gx, gy)

			for _, data in ipairs(dataList) do
				local endX, endY = ArcadeGameHelper.getGridPos(data.x, data.y)

				gameScent.flyingEffectMgr:begin2EndXY(self.atkEffectId, beginX, beginY, endX, endY)
			end
		end
	end
end

function ArcadeSkillHitThrowingBomb:onPlayEffect()
	return
end

function ArcadeSkillHitThrowingBomb:onHitPrintLog()
	if self._context and self._context.target then
		logNormal(string.format("%s ==> 投掷炸弹位置随机 %s", self:getLogPrefixStr(), self._atkCount))
	end
end

return ArcadeSkillHitThrowingBomb
