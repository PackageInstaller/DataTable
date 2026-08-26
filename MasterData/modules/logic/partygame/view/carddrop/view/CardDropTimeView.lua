-- chunkname: @modules/logic/partygame/view/carddrop/view/CardDropTimeView.lua

module("modules.logic.partygame.view.carddrop.view.CardDropTimeView", package.seeall)

local CardDropTimeView = class("CardDropTimeView", BaseView)

function CardDropTimeView:onInitView()
	self.txtTime = gohelper.findChildText(self.viewGO, "txt_time")

	gohelper.setActive(self.txtTime, false)

	self.interface = PartyGameCSDefine.CardDropInterfaceCs
end

function CardDropTimeView:addEvents()
	return
end

function CardDropTimeView:onFrameTick()
	local curState = self.interface.GetCurState()
	local remainTime = self.interface.GetStateRemainTime()

	self.txtTime.text = string.format("%s : %s", curState, math.ceil(remainTime))
end

return CardDropTimeView
