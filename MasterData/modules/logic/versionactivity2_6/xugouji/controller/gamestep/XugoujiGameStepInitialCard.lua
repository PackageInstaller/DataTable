-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepInitialCard.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepInitialCard", package.seeall)

local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local XugoujiGameStepInitialCard = class("XugoujiGameStepInitialCard", XugoujiGameStepBase)

function XugoujiGameStepInitialCard:start()
	local cardList = Activity188Model.instance:getCardsInfoList()
	local curGameId = Activity188Model.instance:getCurGameId()
	local gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	local initialCardNum = gameCfg.readNum

	initialCardNum = initialCardNum > #cardList and #cardList or initialCardNum
	self._randomCardIdxs = {}

	for i = 1, initialCardNum do
		local randomIdx = math.random(1, #cardList)

		while tabletool.indexOf(self._randomCardIdxs, randomIdx) do
			randomIdx = math.random(1, #cardList)
		end

		table.insert(self._randomCardIdxs, randomIdx)
	end

	for i = 1, #self._randomCardIdxs do
		local cardIdx = self._randomCardIdxs[i]
		local cardInfo = cardList[cardIdx]
		local cardUid = cardInfo.uid

		Activity188Model.instance:updateCardStatus(cardUid, XugoujiEnum.CardStatus.Front)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, cardUid)
	end

	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if not isDoingXugoujiGuide then
		TaskDispatcher.runDelay(self._onCardInitailDone, self, 2)
	end

	XugoujiController.instance:registerCallback(XugoujiEvent.FinishInitialCardShow, self._onCardInitailDone, self)
end

function XugoujiGameStepInitialCard:_onCardInitailDone()
	local cardList = Activity188Model.instance:getCardsInfoList()

	for i = 1, #self._randomCardIdxs do
		local cardIdx = self._randomCardIdxs[i]
		local cardInfo = cardList[cardIdx]
		local cardUid = cardInfo.uid

		Activity188Model.instance:updateCardStatus(cardUid, XugoujiEnum.CardStatus.Back)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, cardUid)
	end

	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	TaskDispatcher.runDelay(self.finish, self, 1)
end

function XugoujiGameStepInitialCard:dispose()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.FinishInitialCardShow, self._onCardInitailDone, self)
	TaskDispatcher.cancelTask(self._onCardInitailDone, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepInitialCard
