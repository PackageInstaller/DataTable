-- chunkname: @modules/logic/survival/model/reputation/SurvivalReputationModel.lua

module("modules.logic.survival.model.reputation.SurvivalReputationModel", package.seeall)

local SurvivalReputationModel = class("SurvivalReputationModel", BaseModel)

function SurvivalReputationModel:onInit()
	return
end

function SurvivalReputationModel:reInit()
	return
end

function SurvivalReputationModel:clear()
	SurvivalReputationModel.super.clear(self)
end

function SurvivalReputationModel:getSelectViewReputationAdd(items)
	local amount = 0

	for i, itemMo in ipairs(items) do
		amount = amount + itemMo:getExchangeReputationAmountTotal()
	end

	return amount
end

SurvivalReputationModel.instance = SurvivalReputationModel.New()

return SurvivalReputationModel
