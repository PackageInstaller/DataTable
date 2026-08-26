-- chunkname: @modules/logic/battlepass/model/BpChargeBonusModel.lua

module("modules.logic.battlepass.model.BpChargeBonusModel", package.seeall)

local BpChargeBonusModel = class("BpChargeBonusModel", ListScrollModel)

function BpChargeBonusModel:setConfigList(list)
	self:setList(list)
end

BpChargeBonusModel.left = BpChargeBonusModel.New()
BpChargeBonusModel.right = BpChargeBonusModel.New()

return BpChargeBonusModel
