-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGameView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGameView", package.seeall)

local SnatchAreaGameView = class("SnatchAreaGameView", PartyGameCommonView)

function SnatchAreaGameView:onInitView()
	SnatchAreaGameView.super.onInitView(self)

	self.partygamestartui = gohelper.findChild(self.viewGO, "root/partygamestartui")
	self.partygamebattlebar = gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver")
	self.partygameteambar = gohelper.findChild(self.partygamebattlebar, "root/partygameteambar")
	self.partygamewaitbar = gohelper.findChild(self.viewGO, "root/partygamewaitbar")

	gohelper.setActive(self.partygameteambar, false)

	self.partygamecountdownbar = gohelper.findChild(self.partygamebattlebar, "root/partygamecountdown")
	self.txtTime = gohelper.findChildText(self.viewGO, "root/center/top/txt_time")

	gohelper.setActive(self.txtTime.gameObject, false)

	self.interface = PartyGameCSDefine.SnatchAreaInterfaceCs
end

function SnatchAreaGameView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.onFrameTick, self)
end

function SnatchAreaGameView:onFrameTick()
	self:refreshTime()
end

function SnatchAreaGameView:onOpen()
	if self.partygamestartui then
		self.partyGameStartUI = GameFacade.createLuaCompByGo(self.partygamestartui, PartyGameStartUI, nil, self.viewContainer)
	end

	self.battleBarComp = GameFacade.createLuaCompByGo(self.partygamebattlebar, PartyGameBattleBar, nil, self.viewContainer)

	self.battleBarComp:onSetData({
		partyGameCountDownData = {
			getCountDownFunc = self.getCountDownFunc,
			context = self
		}
	})

	self.countDownComp = GameFacade.createLuaCompByGo(self.partygamecountdownbar, PartyGameCountDown, nil, self.viewContainer)

	self.countDownComp:onSetData({
		getCountDownFunc = self.getCountDownFunc,
		context = self
	})

	self.partyGameWaitBar = GameFacade.createLuaCompByGo(self.partygamewaitbar, PartyGameWaitBar, nil, self.viewContainer)
end

function SnatchAreaGameView:getCountDownFunc()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.Playing then
		local remainTime = self.interface.GetRoundRemainTime()

		return math.max(0, remainTime)
	end
end

function SnatchAreaGameView:refreshTime()
	local gameTime = self.interface.GetRoundRemainTime()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.StartRound then
		self.txtTime.text = "state : StartRound : " .. math.floor(gameTime)
	elseif curState == SnatchEnum.GameState.ShowOperate then
		self.txtTime.text = "state : ShowOperate : " .. math.floor(gameTime)
	elseif curState == SnatchEnum.GameState.Playing then
		self.txtTime.text = "state : Playing : " .. math.floor(gameTime)
	elseif curState == SnatchEnum.GameState.Playing then
		self.txtTime.text = "state : Settlement : " .. math.floor(gameTime)
	end
end

return SnatchAreaGameView
