-- chunkname: @modules/logic/partygame/view/carddrop/CardDropEndFlowController.lua

module("modules.logic.partygame.view.carddrop.CardDropEndFlowController", package.seeall)

local CardDropEndFlowController = class("CardDropEndFlowController")
local PauseKey = "cardDropEndFlow"

function CardDropEndFlowController:startCardDropEndFlow(data)
	self:clearFlow()

	local len = data.ScoreList.Count

	if len <= 2 then
		return
	end

	PartyGameController.instance:registerCallback(PartyGameEvent.transToGamePush, self.onTransToGamePush, self)

	self.cardDropEndFlow = FlowSequence.New()

	self.cardDropEndFlow:addWork(OpenViewWorkNew.New(ViewName.CardDropVSView, {
		openType = CardDropVSView.OpenType.ShowAllResult,
		data = data
	}))
	self.cardDropEndFlow:addWork(DelayWork.New(PartyGameEnum.AllResultVsViewWaitDuration))
	self.cardDropEndFlow:addWork(CloseViewWork.New(ViewName.CardDropVSView))

	if self:checkMainPlayerMoWin(data) then
		self.cardDropEndFlow:addWork(OpenViewWorkNew.New(ViewName.CardDropPromotionView, {
			data = data
		}))
		self.cardDropEndFlow:addWork(DelayWork.New(PartyGameEnum.PromotionViewWaitDuration))
		self.cardDropEndFlow:addWork(CloseViewWork.New(ViewName.CardDropPromotionView))
	end

	self.cardDropEndFlow:registerDoneListener(self.onEndFlowDone, self)
	self.cardDropEndFlow:start()
	PopupController.instance:setPause(PauseKey, true)
end

function CardDropEndFlowController:checkMainPlayerMoWin(data)
	local playerMo = PartyGameModel.instance:getMainPlayerMo()

	if not playerMo then
		return
	end

	local mainIndex = playerMo.index
	local scoreList = data.ScoreList
	local count = scoreList.Count

	for i = 0, count - 1 do
		local scoreMo = scoreList[i]
		local index = tonumber(PartyGameCSDefine.CardDropInterfaceCs.GetScoreMoValue(scoreMo, "index"))

		if index == mainIndex then
			local rank = tonumber(PartyGameCSDefine.CardDropInterfaceCs.GetScoreMoValue(scoreMo, "rank"))

			return rank == 1
		end
	end
end

function CardDropEndFlowController:onEndFlowDone()
	PartyGameController.instance:unregisterCallback(PartyGameEvent.transToGamePush, self.onTransToGamePush, self)

	self.cardDropEndFlow = nil

	PopupController.instance:setPause(PauseKey, false)
	PartyGameTrialController.instance:trialToNextGame()
end

function CardDropEndFlowController:onTransToGamePush()
	self:clearFlow()
	ViewMgr.instance:closeView(ViewName.CardDropVSView, true)
	ViewMgr.instance:closeView(ViewName.CardDropPromotionView, true)
end

function CardDropEndFlowController:clearFlow()
	if self.cardDropEndFlow then
		self.cardDropEndFlow:destroy()

		self.cardDropEndFlow = nil
	end

	PartyGameController.instance:unregisterCallback(PartyGameEvent.transToGamePush, self.onTransToGamePush, self)
end

CardDropEndFlowController.instance = CardDropEndFlowController.New()

return CardDropEndFlowController
