-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/controller/GoldenDiamondCardController.lua

module("logic.extensions.goldendiamondcard.controller.GoldenDiamondCardController", package.seeall)

local GoldenDiamondCardController = class("GoldenDiamondCardController", BaseController)

function GoldenDiamondCardController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
end

function GoldenDiamondCardController:_onStartEnterGame()
	GoldenDiamondCardModel.instance:onReset()
	GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGetInfoReq()
end

function GoldenDiamondCardController:handleGetInfo(msg)
	GoldenDiamondCardModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateGoldenDiamondCardInfo)
end

function GoldenDiamondCardController:handleGainDailyPrize(msg)
	GoldenDiamondCardModel.instance:onGainDailyPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateGoldenDiamondCardInfo)
end

function GoldenDiamondCardController:handleonPaySuc(msg)
	GoldenDiamondCardModel.instance:onPaySuc(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateGoldenDiamondCardInfo)
end

function GoldenDiamondCardController:handlePrivilegeInfoChange(msg)
	GoldenDiamondCardModel.instance:onPrivilegeInfoChange(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateGoldenDiamondCardInfo)
end

GoldenDiamondCardController.instance = GoldenDiamondCardController.New()

return GoldenDiamondCardController
