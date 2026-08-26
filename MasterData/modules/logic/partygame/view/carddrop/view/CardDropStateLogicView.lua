-- chunkname: @modules/logic/partygame/view/carddrop/view/CardDropStateLogicView.lua

module("modules.logic.partygame.view.carddrop.view.CardDropStateLogicView", package.seeall)

local CardDropStateLogicView = class("CardDropStateLogicView", BaseView)

function CardDropStateLogicView:onInitView()
	self.interface = PartyGameCSDefine.CardDropInterfaceCs
	self.preState = CardDropEnum.GameState.None
end

function CardDropStateLogicView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.onFrameTick, self)
end

function CardDropStateLogicView:onFrameTick()
	local curState = self.interface.GetCurState()

	if curState == self.preState then
		return
	end

	CardDropGameController.instance:dispatchEvent(CardDropGameEvent.OnLogicStateStart, curState, self.preState)

	self.preState = curState
end

return CardDropStateLogicView
