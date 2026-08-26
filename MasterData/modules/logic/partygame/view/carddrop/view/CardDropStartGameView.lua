-- chunkname: @modules/logic/partygame/view/carddrop/view/CardDropStartGameView.lua

module("modules.logic.partygame.view.carddrop.view.CardDropStartGameView", package.seeall)

local CardDropStartGameView = class("CardDropStartGameView", BaseView)

function CardDropStartGameView:onOpen()
	local interface = PartyGameCSDefine.CardDropInterfaceCs
	local remainTime = interface.GetStateRemainTime()

	TaskDispatcher.runDelay(self.closeThis, self, remainTime)
	AudioMgr.instance:trigger(340128)
end

function CardDropStartGameView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return CardDropStartGameView
