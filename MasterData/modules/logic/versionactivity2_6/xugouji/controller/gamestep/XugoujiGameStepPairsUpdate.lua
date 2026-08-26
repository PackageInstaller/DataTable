-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepPairsUpdate.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepPairsUpdate", package.seeall)

local XugoujiGameStepPairsUpdate = class("XugoujiGameStepPairsUpdate", XugoujiGameStepBase)

function XugoujiGameStepPairsUpdate:start()
	local isSelf = self._stepData.isSelf
	local pairCount = self._stepData.pairCount

	if pairCount == 0 then
		self:finish()

		return
	end

	Activity188Model.instance:setPairCount(pairCount, isSelf)
	TaskDispatcher.runDelay(self.doGotPairsView, self, 0.5)
end

function XugoujiGameStepPairsUpdate:doGotPairsView()
	local cardUid1, cardUid2 = Activity188Model.instance:getLastCardPair()

	if cardUid1 then
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPair)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.GotActiveCard, {
			cardUid1,
			cardUid2
		})
	end

	XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, self.onCloseCardInfoView, self)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	XugoujiController.instance:openCardInfoView()
end

function XugoujiGameStepPairsUpdate:onCloseCardInfoView()
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	local cardUid1, cardUid2 = Activity188Model.instance:getLastCardPair()

	if cardUid1 then
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, cardUid1)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, cardUid2)
	end

	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, self.onCloseCardInfoView, self)
	TaskDispatcher.runDelay(self.finish, self, 0.3)
end

function XugoujiGameStepPairsUpdate:dispose()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, self.onCloseCardInfoView, self)
	TaskDispatcher.cancelTask(self.doGotPairsView, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepPairsUpdate
