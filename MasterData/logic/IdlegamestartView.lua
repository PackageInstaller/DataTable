-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdlegamestartView.lua

module("logic.extensions.idlegame.view.IdlegamestartView", package.seeall)

local IdlegamestartView = class("IdlegamestartView", ViewComponent)

function IdlegamestartView:ctor()
	IdlegamestartView.super.ctor(self)
end

function IdlegamestartView:unbindEvents()
	IdlegamestartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnStart)
	GameUtil.rmClickHandler(self.btnReward)
end

function IdlegamestartView:bindEvents()
	IdlegamestartView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnStart, self.onClickStart, self)
	GameUtil.addClickHandler(self.btnReward, self.onClickReward, self)
end

function IdlegamestartView:buildUI()
	IdlegamestartView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnStart = self:getGo("btnStart")
	self.btnReward = self:getGo("btnReward")
	self.txtTime = self:getTxt("time/txt")
	self.bubble_2 = self:getGo("bubble_2")
	self.txtTip = self:getTxt("bubble_2/txtTip")
	self.pointItem = self:getGo("bubble_2/pointItem")
	self._prizeRedPoint = self:getGo("btnReward/redpoint")

	goutil.setActive(self._prizeRedPoint, false)
end

function IdlegamestartView:onExit()
	IdlegamestartView.super.onExit(self)
	IdleGameController.instance:unregisterLocalNotify("ReceiveProgressPrize", self._onReceiveProgressPrize, self)
end

function IdlegamestartView:onEnter()
	IdlegamestartView.super.onEnter(self)

	self.txtTime.text = ""

	GameUtil.SetActive(self.btnReward, false)
	GameUtil.SetActive(self.bubble_2, false)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_IDLEGAME_START)
	IdleGameController.instance:registerLocalNotify("ReceiveProgressPrize", self._onReceiveProgressPrize, self)
	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoPlaceInfoReq(function(msg)
		IdleGameModel.instance:handlePM_XiaoNuoPlaceInfoRes(msg)

		local _actId = IdleGameModel.instance.activityId

		if _actId then
			GameUtil.SetActive(self.bubble_2, true)

			local cfg = ActivityDefineConfig.instance:getCfgById(math.floor(checknumber(_actId) / 1000), _actId)
			local startTime, endTime = cfg.startTime, cfg.endTime
			local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			self.txtTime.text = langPara("FunArena_HallView_Tips_1", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

			self:_onReceiveProgressPrize()

			local cfg = IdleGameConfig.instance:getActPirzes(_actId) or {}
			local tem = cfg[1]

			if tem then
				GameUtil.SetActive(self.btnReward, true)

				self.txtTip.text = langPara("达到%s萌值", StringUtil.numberToString(tem.target))

				MaterialMgr.setCellByCfg(tem.prize, self.pointItem)
			end
		end
	end)
end

function IdlegamestartView:_onReceiveProgressPrize()
	goutil.setActive(self._prizeRedPoint, IdleGameModel.instance:getHasPrizeNotReceive())
end

function IdlegamestartView:onClickStart()
	UIStateManager.instance:push(ViewName.IdleGame)
end

function IdlegamestartView:onClickReward()
	UIStateManager.instance:open(ViewName.IdlePrize)
end

return IdlegamestartView
