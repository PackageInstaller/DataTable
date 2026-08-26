-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondAttributeJudgment.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondAttributeJudgment", package.seeall)

local ArcadeSkillCondAttributeJudgment = class("ArcadeSkillCondAttributeJudgment", ArcadeSkillCondBase)

function ArcadeSkillCondAttributeJudgment:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._attrId = tonumber(params[2])
	self._opName = tonumber(params[3])
	self._value = tonumber(params[4])
end

function ArcadeSkillCondAttributeJudgment:onIsCondSuccess()
	logNormal("ArcadeSkillCondAttributeJudgment:isCondSuccess() == > 特定属性的数值大于等于/小于等于X时，则触发")

	local JudgmentOperator = {
		"gtet",
		"ltet"
	}

	if not JudgmentOperator[self._opName] then
		local opStr = self._opName
		local compareFunc = ArcadeGameHelper.getCompareFunc(opStr)

		if compareFunc then
			local attrValue = self:_getAttrValue(self._context.target)

			return compareFunc(attrValue, self._value)
		end
	end
end

function ArcadeSkillCondAttributeJudgment:_getAttrValue(unitMO)
	if ArcadeGameEnum.BaseAttr.hp == self._attrId then
		return unitMO:getHp()
	end

	return unitMO:getAttributeValue(self._attrId)
end

return ArcadeSkillCondAttributeJudgment
