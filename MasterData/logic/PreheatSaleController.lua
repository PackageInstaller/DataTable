-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/controller/PreheatSaleController.lua

module("logic.extensions.preheatsale.controller.PreheatSaleController", package.seeall)

local PreheatSaleController = class("PreheatSaleController", BaseController)

function PreheatSaleController:handleGetInfo(msg)
	PreheatSaleModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PreheatSaleInfoUpdate)
end

function PreheatSaleController:handleFinishPay(msg)
	PreheatSaleModel.instance:onFinishPay(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PreheatSaleInfoUpdate)
end

PreheatSaleController.instance = PreheatSaleController.New()

return PreheatSaleController
