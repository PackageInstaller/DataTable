-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRandomSummon.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRandomSummon", package.seeall)

local ArcadeSkillHitRandomSummon = class("ArcadeSkillHitRandomSummon", ArcadeSkillHitBase)
local _Effect_Type = {
	Flying = 1
}

function ArcadeSkillHitRandomSummon:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._monsterIdList = nil

	local idstr = params[2]

	self._effectType = params[3] and tonumber(params[3])

	if not string.nilorempty(idstr) then
		self._monsterIdList = string.splitToNumber(idstr, ",")
	end

	if self._effectType == _Effect_Type.Flying then
		self.isNotPlayAtkEffct = true
		self._flyingTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FlyingEffectTime, true) or 0.3
	end
end

function ArcadeSkillHitRandomSummon:onHit()
	if self._monsterIdList then
		local dataList = ArcadeGameSummonController.instance:summonMonsterList(self._monsterIdList, self._flyingTime)
		local gameScent = ArcadeGameController.instance:getGameScene()

		if self._context and self._context.target and self._effectType == _Effect_Type.Flying and dataList and #dataList > 0 and self.atkEffectId ~= 0 and gameScent then
			local gx, gy = self._context.target:getGridPos()
			local beginX, beginY = ArcadeGameHelper.getGridPos(gx, gy)

			for _, data in ipairs(dataList) do
				local endX, endY = ArcadeGameHelper.getGridPos(data.x, data.y)

				gameScent.flyingEffectMgr:begin2EndXY(self.atkEffectId, beginX, beginY, endX, endY)
			end
		end
	end
end

function ArcadeSkillHitRandomSummon:onHitPrintLog()
	if self._monsterIdList and #self._monsterIdList > 0 then
		logNormal(string.format("%s ==> 随机坐标召唤怪物。munster:[%s] ", self:getLogPrefixStr(), self._params and self._params[2]))
	else
		logError(string.format("%s ==> 怪物参数配置错误。munster:[%s]", self:getLogPrefixStr(), (self._params or nil) and self._params[2]))
	end
end

return ArcadeSkillHitRandomSummon
