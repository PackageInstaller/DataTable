-- chunkname: @modules/logic/rouge2/common/model/Rouge2_GameCurAlchemyInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_GameCurAlchemyInfoMO", package.seeall)

local Rouge2_GameCurAlchemyInfoMO = pureTable("Rouge2_GameCurAlchemyInfoMO")

function Rouge2_GameCurAlchemyInfoMO:init(info)
	self._formula = info.formula
	self._formulaCo = Rouge2_OutSideConfig.instance:getFormulaConfig(self._formula)
	self._mainEffect = info.mainEffect
	self._subEffectList = info.subEffect
end

function Rouge2_GameCurAlchemyInfoMO:getFormulaId()
	return self._formula
end

function Rouge2_GameCurAlchemyInfoMO:getFormulaConfig()
	return self._formulaCo
end

function Rouge2_GameCurAlchemyInfoMO:getMainEffect()
	return self._mainEffect
end

function Rouge2_GameCurAlchemyInfoMO:getSubEffectList()
	return self._subEffectList
end

return Rouge2_GameCurAlchemyInfoMO
