-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitChangeAttackAttr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitChangeAttackAttr", package.seeall)

local ArcadeSkillHitChangeAttackAttr = class("ArcadeSkillHitChangeAttackAttr", ArcadeSkillHitBase)

function ArcadeSkillHitChangeAttackAttr:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillTargetId = tonumber(params[2])
	self._attackAttrId = tonumber(params[3])
	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillHitChangeAttackAttr:onHit()
	if self._skillTargetBase and self._attackAttrId then
		self._skillTargetBase:findByContext(self._context)

		local unitMOList = self._skillTargetBase:getTargetList()

		self:addHiterList(unitMOList)

		for _, unitMO in ipairs(unitMOList) do
			ArcadeGameController.instance:changeEntityAttackAttr(unitMO, self._attackAttrId)
		end
	end
end

function ArcadeSkillHitChangeAttackAttr:onHitPrintLog()
	local unitMOList = self._skillTargetBase:getTargetList()

	if unitMOList and #unitMOList > 0 then
		local target = unitMOList[1]

		logNormal(string.format("%s ==> 添加目标攻击属性:%s  type:%s id:%s uid:%s", self:getLogPrefixStr(), self._attackAttrId, target:getEntityType(), target:getUid(), target:getId()))
	end
end

return ArcadeSkillHitChangeAttackAttr
