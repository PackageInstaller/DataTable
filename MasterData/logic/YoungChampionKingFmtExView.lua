-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingFmtExView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingFmtExView", package.seeall)

local YoungChampionKingFmtExView = class("YoungChampionKingFmtExView", ViewComponent)

function YoungChampionKingFmtExView:ctor()
	YoungChampionKingFmtExView.super.ctor(self)
end

function YoungChampionKingFmtExView:unbindEvents()
	YoungChampionKingFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
end

function YoungChampionKingFmtExView:bindEvents()
	YoungChampionKingFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function YoungChampionKingFmtExView:buildUI()
	YoungChampionKingFmtExView.super.buildUI(self)

	self._wait = self:getGo("wait")
	self._txtTips = self:getTxt("txtTips")
	self._btnStart = self:getGo("btnStart")
	self._txtTimer = self:getTxt("txtTimer")
end

function YoungChampionKingFmtExView:onExit()
	YoungChampionKingFmtExView.super.onExit(self)
	removetimer(self._updateTimer, self)
	removetimer(self._trySyncRoomInfo, self)
end

function YoungChampionKingFmtExView:onEnter()
	YoungChampionKingFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]

	goutil.setActive(self._wait, false)
	self.addGEvent(self, GlobalNotify.PM_YCKKnockoutSetGameFormation, self._handleFinishSet, self)
	self.addGEvent(self, GlobalNotify.PM_MakeContractRes, self._onHandleCancelContractInfo, self)
	self.addGEvent(self, GlobalNotify.PM_YCKKnockoutSyncRoomInfo, self._onHandleSyncRoomInfo, self)

	self._activityId = self.customFmtMo.activityId
	self._gameRoundCfg = YoungChampionKingConfig.instance:getKnockoutGameCfg(self._activityId, self.customFmtMo.gameRoundId)
	self._timer = self._gameRoundCfg.roundTime - 5

	local curRoundStartTime = self.customFmtMo.curRoundStartTime

	if curRoundStartTime ~= 0 then
		local timer = math.floor(curRoundStartTime + self._gameRoundCfg.roundTime - ServerTime.now() - 5)

		if timer > 0 then
			self._timer = timer
		end
	end

	self._txtTimer.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(self._timer))
	self._txtTips.text = self._gameRoundCfg.desc

	settimer(1, self._updateTimer, self, true)

	self._needDeal = true

	if self.customFmtMo.gameRoundId == 1 then
		SurveyController.instance:reportBehavior(201803)
	elseif self.customFmtMo.gameRoundId == 2 then
		SurveyController.instance:reportBehavior(201806)
	elseif self.customFmtMo.gameRoundId == 3 then
		SurveyController.instance:reportBehavior(201809)
	elseif self.customFmtMo.gameRoundId == 4 then
		SurveyController.instance:reportBehavior(201812)
	end
end

function YoungChampionKingFmtExView:_onClickBtnStart()
	local showTips = "确认上阵精灵后，之后无法修改"

	TipsFacade.instance:openPopupWindowWithX("提示", showTips, function()
		self:_sendStartFight()

		if self.customFmtMo.gameRoundId == 1 then
			SurveyController.instance:reportBehavior(201804)
		elseif self.customFmtMo.gameRoundId == 2 then
			SurveyController.instance:reportBehavior(201807)
		elseif self.customFmtMo.gameRoundId == 3 then
			SurveyController.instance:reportBehavior(201810)
		elseif self.customFmtMo.gameRoundId == 4 then
			SurveyController.instance:reportBehavior(201813)
		end
	end, nil)
end

function YoungChampionKingFmtExView:_handleFinishSet()
	goutil.setActive(self._wait, true)
	UIStateManager.instance:popByName(ViewName.Popupwindow)

	self._needDeal = false
end

function YoungChampionKingFmtExView:_updateTimer()
	self._timer = self._timer - 1
	self._txtTimer.text = string.format("剩余：<color=#eb4642>%s</color>", GameUtil.FormatTimeSymbol(self._timer))

	if self._timer <= 0 then
		removetimer(self._updateTimer, self)

		self._txtTimer.text = ""

		if self._needDeal then
			self:_sendStartFight()

			if self.customFmtMo.gameRoundId == 1 then
				SurveyController.instance:reportBehavior(201805)
			elseif self.customFmtMo.gameRoundId == 2 then
				SurveyController.instance:reportBehavior(201808)
			elseif self.customFmtMo.gameRoundId == 3 then
				SurveyController.instance:reportBehavior(201811)
			elseif self.customFmtMo.gameRoundId == 4 then
				SurveyController.instance:reportBehavior(201814)
			end
		end

		self._retrySynCount = 0

		settimer(3, self._trySyncRoomInfo, self, true)
	end
end

function YoungChampionKingFmtExView:_sendStartFight()
	local formMo = self.customFmtMo:getCurFormation()

	if self.customFmtMo.gameRoundId == 1 or self.customFmtMo.gameRoundId == 4 then
		self:_saveCurRoundForm()

		return
	end
end

function YoungChampionKingFmtExView:_trySendSaveMsg()
	self:_saveCurRoundForm()
end

function YoungChampionKingFmtExView:_onHandleCancelContractInfo(summonMasterId, summonedPetId)
	if self.customFmtMo.gameRoundId == 1 or self.customFmtMo.gameRoundId == 4 then
		return
	end

	if summonedPetId == -1 and self._needCancelPetList and #self._needCancelPetList > 0 then
		local obj = self._needCancelPetList[1]

		if obj.mId == summonMasterId then
			table.remove(self._needCancelPetList, 1)
			self:_trySendSaveMsg()
		end
	end
end

function YoungChampionKingFmtExView:_saveCurRoundForm()
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutSetGameFormationReq(self._activityId, self.customFmtMo:getCurSimpleForm())
end

function YoungChampionKingFmtExView:_trySyncRoomInfo()
	self._retrySynCount = self._retrySynCount + 1

	if self._retrySynCount <= 3 then
		YoungChampionKingController.instance:sendPM_YCKKnockoutSyncRoomInfoReq(self._activityId)
	else
		print("少年竞技王同步数据次数过多：", self.customFmtMo.gameRoundId)
		removetimer(self._trySyncRoomInfo, self)
	end
end

function YoungChampionKingFmtExView:_onHandleSyncRoomInfo(msg)
	if self.customFmtMo.gameRoundId == msg.gameRoundId then
		return
	end

	local fmtMo = YoungChampionKingModel.instance:getKnockoutRoundFmtMo()

	fmtMo:initParams(self._activityId, msg.gameRoundId, msg.myForm, msg.opForm, msg.roundStartTimeMillis / 1000)
	UIStateManager.instance:popByName(ViewName.FmtFeatureView)
	UIStateManager.instance:popByName(ViewName.CustomSummonPopView)
	UIStateManager.instance:popByName(ViewName.CustomMissionView)
	UIStateManager.instance:push(ViewName.CustomMissionView, fmtMo)
end

return YoungChampionKingFmtExView
