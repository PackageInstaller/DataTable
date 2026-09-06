-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/controller/HolyStripeExploreController.lua

module("logic.extensions.holystripeexplore.controller.HolyStripeExploreController", package.seeall)

local HolyStripeExploreController = class("HolyStripeExploreController", BaseController)

function HolyStripeExploreController:onInit()
	return
end

function HolyStripeExploreController:onReset()
	self.isFirstShowW = false
end

function HolyStripeExploreController:getInfo()
	LingWenExploreAgent.instance:sendPM_LWExploreGetInfoReq()
end

function HolyStripeExploreController:handleGetInfo(msg)
	HolyStripeExploreModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreInfoUpdate)
end

function HolyStripeExploreController:startGame()
	local clientKey = math.random(ServerTime.now())

	LingWenExploreAgent.instance:sendPM_LWExploreStartGameReq(clientKey)
end

function HolyStripeExploreController:handleStartGame(msg)
	HolyStripeExploreModel.instance:onStartGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreStartGame)
end

function HolyStripeExploreController:gameMove(step, encryptedKey)
	LingWenExploreAgent.instance:sendPM_LWExploreEndGameReq(step, encryptedKey)
end

function HolyStripeExploreController:handleGameMove(msg)
	HolyStripeExploreModel.instance:onGameMove(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreFinshGame)
end

function HolyStripeExploreController:buyGameTime()
	LingWenExploreAgent.instance:sendPM_LWExploreBuyCountReq()
end

function HolyStripeExploreController:handleBuyGameTime(msg)
	HolyStripeExploreModel.instance:onBuyTime(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreTimeUpdate)
end

function HolyStripeExploreController:handleNotifyExplore(msg)
	HolyStripeExploreModel.instance:onGetInfo(msg)

	self.isFirstShowW = true

	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreStartGame)
end

function HolyStripeExploreController:showPopup()
	if self.isFirstShowW then
		self.isFirstShowW = false

		UIStateManager.instance:push(ViewName.HolyStripeExploreTipView)
	end
end

function HolyStripeExploreController:handlePM_LWExploreOneKeyRes(msg)
	HolyStripeExploreModel.instance:onGameMove(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreFinshOneKey)
end

HolyStripeExploreController.instance = HolyStripeExploreController.New()

return HolyStripeExploreController
