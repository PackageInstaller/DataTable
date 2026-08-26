-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGameRoundView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGameRoundView", package.seeall)

local SnatchAreaGameRoundView = class("SnatchAreaGameRoundView", BaseView)

function SnatchAreaGameRoundView:onInitView()
	self.partygameroundtip = gohelper.findChild(self.viewGO, "root/partygameroundtip")

	gohelper.setActive(self.partygameroundtip, false)

	self.partyGameRoundComp = GameFacade.createLuaCompByGo(self.partygameroundtip, PartyGameRoundTip, nil, self.viewContainer)
	self.interface = PartyGameCSDefine.SnatchAreaInterfaceCs
end

function SnatchAreaGameRoundView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.frameTick, self)
end

function SnatchAreaGameRoundView:frameTick()
	self:refreshRound()
end

function SnatchAreaGameRoundView:refreshRound()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.StartRound then
		local gameStart = self.interface.GetGameCountDownStart()

		if not gameStart then
			self.partyGameRoundComp:setIsShow(false)

			return
		end

		self.partyGameRoundComp:setIsShow(true)
		self.partyGameRoundComp:setRoundData(self.interface.GetCurRound(), self.interface.GetMaxRound())
	else
		self.partyGameRoundComp:setIsShow(false)
	end
end

return SnatchAreaGameRoundView
