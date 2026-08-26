-- chunkname: @modules/logic/pay/model/PayModel.lua

module("modules.logic.pay.model.PayModel", package.seeall)

local PayModel = LuaUtil.class("PayModel", PayModelBase, PayModel_OverseasImpl, PayModel_NativesImpl)

function PayModel:ctor()
	return
end

PayModel.instance = PayModel.New()

return PayModel
