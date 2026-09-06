-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFmtExView.lua

module("logic.extensions.teenchampionking.view.TCKFmtExView", package.seeall)

local TCKFmtExView = class("TCKFmtExView", ViewComponent)

function TCKFmtExView:ctor()
	TCKFmtExView.super.ctor(self)
end

function TCKFmtExView:unbindEvents()
	TCKFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
end

function TCKFmtExView:bindEvents()
	TCKFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function TCKFmtExView:buildUI()
	TCKFmtExView.super.buildUI(self)

	self._wait = self:getGo("wait")
	self._txtTips = self:getTxt("txtTips")
	self._btnStart = self:getGo("btnStart")
	self._txtTimer = self:getTxt("txtTimer")
end

function TCKFmtExView:onExit()
	TCKFmtExView.super.onExit(self)
	removetimer(self._updateTimer, self)
	removetimer(self._trySyncRoomInfo, self)
end

function TCKFmtExView:onEnter()
	TCKFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]

	goutil.setActive(self._wait, false)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutSetGameFormation, self._handleFinishSet, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutSyncRoomInfo, self._onHandleSyncRoomInfo, self)

	self._activityId = self.customFmtMo.activityId
	self._gameRoundCfg = TeenChampionKingConfig.instance:getGameRoundCfg(self._activityId, self.customFmtMo.gameRoundId)
	self._timer = self._gameRoundCfg.roundTime - 5
	self._endTime = 0

	local curRoundStartTime = self.customFmtMo.curRoundStartTime

	if curRoundStartTime ~= 0 then
		local timer = math.floor(curRoundStartTime + self._gameRoundCfg.roundTime - ServerTime.now() - 5)

		if timer > 0 then
			self._timer = timer
		end
	end

	self._endTime = ServerTime.now() + self._timer
	self._txtTimer.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(self._timer))
	self._txtTips.text = self._gameRoundCfg.desc

	settimer(1, self._updateTimer, self, true)

	self._needDeal = true
end

function TCKFmtExView:_onClickBtnStart()
	local showTips = "确认上阵精灵后无法修改"

	TipsFacade.instance:openPopupWindowWithX("提示", showTips, function()
		self:_sendStartFight()
	end, nil)
end

function TCKFmtExView:_handleFinishSet()
	goutil.setActive(self._wait, true)
	UIStateManager.instance:popByName(ViewName.Popupwindow)

	self._needDeal = false
end

function TCKFmtExView:_updateTimer()
	local timer = self._endTime - ServerTime.now()

	self._txtTimer.text = string.format("剩余：<color=#eb4642>%s</color>", GameUtil.FormatTimeSymbol(timer))

	if timer <= 0 then
		removetimer(self._updateTimer, self)

		self._txtTimer.text = ""

		if self._needDeal then
			self:_sendStartFight()
		end

		self._retrySynCount = 0

		settimer(3, self._trySyncRoomInfo, self, true)
	end
end

function TCKFmtExView:_sendStartFight()
	self:_saveCurRoundForm()
end

function TCKFmtExView:_trySendSaveMsg()
	self:_saveCurRoundForm()
end

function TCKFmtExView:_saveCurRoundForm()
	TeenChampionKingController.instance:setGameForm(self._activityId, self.customFmtMo:getCurSimpleForm(), self.customFmtMo.gameRoundId)
end

function TCKFmtExView:_trySyncRoomInfo()
	self._retrySynCount = self._retrySynCount + 1

	if self._retrySynCount <= 3 then
		TeenChampionKingController.instance:syncRoomInfo(self._activityId)
	else
		print("少年竞技王S2同步数据次数过多：", self.customFmtMo.gameRoundId)
		removetimer(self._trySyncRoomInfo, self)
	end
end

function TCKFmtExView:_onHandleSyncRoomInfo(msg)
	if self.customFmtMo.gameRoundId == msg.gameRoundId then
		return
	end

	local fmtMo = TeenChampionKingController.instance:getRoundFmtMo(msg.activityId)

	fmtMo:initParams(self._activityId, msg.gameRoundId, msg.myForm, msg.opForm, msg.roundStartTimeMillis / 1000, msg.opUseSysProperty)
	UIStateManager.instance:popByName(ViewName.FmtFeatureView)
	UIStateManager.instance:popByName(ViewName.CustomSummonPopView)
	UIStateManager.instance:popByName(ViewName.CustomMissionView)
	UIStateManager.instance:push(ViewName.CustomMissionView, fmtMo)
end

return TCKFmtExView
