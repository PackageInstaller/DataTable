-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRemoveAttackAttr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRemoveAttackAttr", package.seeall)

local ArcadeSkillHitRemoveAttackAttr = class("ArcadeSkillHitRemoveAttackAttr", ArcadeSkillHitBase)

function ArcadeSkillHitRemoveAttackAttr:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillTargetId = tonumber(params[2])
	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillHitRemoveAttackAttr:onHit()
	if self._skillTargetBase then
		self._skillTargetBase:findByContext(self._context)

		local unitMOList = self._skillTargetBase:getTargetList()

		self:addHiterList(unitMOList)

		for _, unitMO in ipairs(unitMOList) do
			ArcadeGameController.instance:changeEntityAttackAttr(unitMO)
		end
	end
end

function ArcadeSkillHitRemoveAttackAttr:onHitPrintLog()
	local unitMOList = self._skillTargetBase:getTargetList()

	if unitMOList and #unitMOList > 0 then
		local target = unitMOList[1]

		logNormal(string.format("%s ==> 移除目标攻击属性 type:%s id:%s uid:%s", self:getLogPrefixStr(), target:getEntityType(), target:getId(), target:getUid()))
	end
end

return ArcadeSkillHitRemoveAttackAttr
