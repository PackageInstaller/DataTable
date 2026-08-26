-- chunkname: @modules/logic/partygame/view/decision/DecisionGameView.lua

module("modules.logic.partygame.view.decision.DecisionGameView", package.seeall)

local DecisionGameView = class("DecisionGameView", SceneGameCommonView)

function DecisionGameView:onInitView()
	self._uiRoot = gohelper.findChild(self.viewGO, "sceneuiroot")

	gohelper.setActive(self._uiRoot, false)
	DecisionGameView.super.onInitView(self)
end

function DecisionGameView:onCreateCompData()
	self.partyGameCountDownData = {
		getCountDownFunc = self.getCountDownFunc,
		context = self
	}
end

function DecisionGameView:onOpen()
	DecisionGameView.super.onOpen(self)
	gohelper.setActive(self._goJoystick, false)
end

function DecisionGameView:viewUpdate()
	if not self._inputComp then
		gohelper.setActive(self._uiRoot, true)

		self._inputComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._uiRoot, DecisionInputComp)
	end

	self._inputComp:viewDataUpdate()

	local curRound = PartyGameCSDefine.DecisionGameInterfaceCs.GetCurRound()
	local maxRound = #lua_partygame_decision.configDict

	self.partyGameRoundTip:setRoundData(curRound, maxRound)
end

function DecisionGameView:getCountDownFunc()
	local isOper = PartyGameCSDefine.DecisionGameInterfaceCs.IsShowOper()

	if isOper then
		return (PartyGameCSDefine.DecisionGameInterfaceCs.GetOperTime())
	end
end

return DecisionGameView
