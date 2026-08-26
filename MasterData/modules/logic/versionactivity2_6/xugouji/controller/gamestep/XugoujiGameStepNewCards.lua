-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepNewCards.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepNewCards", package.seeall)

local XugoujiGameStepNewCards = class("XugoujiGameStepNewCards", XugoujiGameStepBase)

function XugoujiGameStepNewCards:start()
	local newCards = self._stepData.cards

	Activity188Model.instance:clearCardsInfo()
	Activity188Model.instance:updateCardInfo(newCards)
	Activity188Model.instance:setPairCount(0, true)
	Activity188Model.instance:setPairCount(0, false)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GotNewCardDisplay)
	XugoujiGameStepController.instance:insertStepListClient({
		{
			stepType = XugoujiEnum.GameStepType.UpdateInitialCard
		}
	}, true)
	TaskDispatcher.runDelay(self.doNewCardDisplay, self, 0.5)
end

function XugoujiGameStepNewCards:doNewCardDisplay()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.NewCards)
	TaskDispatcher.runDelay(self.finish, self, 0.5)
end

function XugoujiGameStepNewCards:dispose()
	TaskDispatcher.cancelTask(self.finish, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepNewCards
