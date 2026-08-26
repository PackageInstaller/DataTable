-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepCardUpdate.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardUpdate", package.seeall)

local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local XugoujiGameStepCardUpdate = class("XugoujiGameStepCardUpdate", XugoujiGameStepBase)

function XugoujiGameStepCardUpdate:start()
	local cardUid = self._stepData.uid
	local cardStatus = self._stepData.status
	local cardInfo = Activity188Model.instance:getCardInfo(cardUid)
	local cardId = cardInfo.id
	local cardCfg = Activity188Config.instance:getCardCfg(actId, cardId)

	if cardCfg.type ~= 2 and cardInfo.statue ~= XugoujiEnum.CardStatus.Disappear and cardStatus == XugoujiEnum.CardStatus.Disappear then
		Activity188Model.instance:addOpenedCard(cardUid)
	elseif cardCfg.type == 2 and cardStatus == XugoujiEnum.CardStatus.Front then
		Activity188Model.instance:addOpenedCard(cardUid)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPair)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.GotActiveCard, {
			cardUid,
			-1
		})
	end

	Activity188Model.instance:updateCardStatus(cardUid, cardStatus)

	if cardCfg.type == 2 then
		if cardStatus == XugoujiEnum.CardStatus.Front then
			if cardUid == Activity188Model.instance:getLastCardInfoUId() then
				self:finish()
			else
				Activity188Model.instance:setLastCardInfoUId(cardUid)
				XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, self.onCloseCardInfoView, self)
				XugoujiController.instance:openCardInfoView(nil)
			end
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, self._stepData.uid)
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, self._stepData.uid)
			TaskDispatcher.runDelay(self.finish, self, 0.25)
		end
	else
		local isMyTurn = Activity188Model.instance:isMyTurn()

		if isMyTurn then
			if Activity188Model.instance:getGameViewState() == XugoujiEnum.GameViewState.PlayerOperaDisplay then
				if cardStatus ~= XugoujiEnum.CardStatus.Disappear and cardStatus ~= XugoujiEnum.CardStatus.Back then
					XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, self._stepData.uid)
				end
			else
				XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, self._stepData.uid)
			end

			self:finish()
		elseif Activity188Model.instance:getGameViewState() == XugoujiEnum.GameViewState.EnemyOperaDisplay then
			if cardStatus ~= XugoujiEnum.CardStatus.Disappear and cardStatus ~= XugoujiEnum.CardStatus.Back then
				XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, self._stepData.uid)
			end

			self:finish()
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, self._stepData.uid)
			TaskDispatcher.runDelay(self.finish, self, 0.5)
		end
	end
end

function XugoujiGameStepCardUpdate:onCloseCardInfoView()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, self.onCloseCardInfoView, self)
	TaskDispatcher.runDelay(self.finish, self, 0.3)
end

function XugoujiGameStepCardUpdate:finish()
	XugoujiGameStepCardUpdate.super.finish(self)
end

function XugoujiGameStepCardUpdate:dispose()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, self.onCloseCardInfoView, self)
	TaskDispatcher.cancelTask(self.finish, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepCardUpdate
