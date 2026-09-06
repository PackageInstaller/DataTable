-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/view/LingShenChallengeAddTipView.lua

module("logic.extensions.lingshenchallenge.view.LingShenChallengeAddTipView", package.seeall)

local LingShenChallengeAddTipView = class("LingShenChallengeAddTipView", ViewComponent)

function LingShenChallengeAddTipView:buildUI()
	LingShenChallengeAddTipView.super.buildUI(self)

	self._txtAutoTimer = self:getTxt("Nego_middle/autoTimer/txt")
	self._markReady = self:getGo("Nego_middle/markReady")
	self._txtReadyCount = self:getTxt("Nego_bottom/txtReadyCount")
	self._seatList = {}

	for i = 1, 3 do
		self._seatList[i] = self:getGo("Nego_seat/seat" .. i)
	end
end

function LingShenChallengeAddTipView:unbindEvents()
	LingShenChallengeAddTipView.super.unbindEvents(self)
end

function LingShenChallengeAddTipView:bindEvents()
	LingShenChallengeAddTipView.super.bindEvents(self)
end

function LingShenChallengeAddTipView:onEnter()
	LingShenChallengeAddTipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LingShenClgNotifyFormChangeRes, self._onFormChange, self)
	self.addGEvent(self, GlobalNotify.PM_LingShenClgNotifyReadyRes, self._onFormReady, self)
	self.addGEvent(self, GlobalNotify.PM_LingShenClgNotifyResultRes, self._onFightStart, self)

	local delayTime = 3

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo.activityId
	self._bossId = self._fmtMo.bossId
	self._activityCfg = LingShenChallengeConfig.instance:getActivityCfg(self._activityId)
	self._bossCfg = LingShenChallengeConfig.instance:getBossCfg(self._activityId, self._bossId)
	self._autoTimer = checkint(self._activityCfg.formCountDown) - delayTime

	self:_onCountdown()
	settimer(1, self._onCountdown, self)
	goutil.setActive(self._markReady, false)

	local fightInfo = GameUtil.pbToTable(LingShenChallengeModel.instance:getFightInfo())

	self._playerCount = table.nums(fightInfo.playerList)

	for i, v in ipairs(self._seatList) do
		GameUtil.SetActive(v, i == self._fmtMo:getSetRow())
	end

	self:_refreshView()
end

function LingShenChallengeAddTipView:onExit()
	LingShenChallengeAddTipView.super.onExit(self)
	removetimer(self._onCountdown, self)

	local autoState = FormTeamModel.instance:getTeamAutoReadyState(self._bossCfg.groupId)

	if autoState == GameEnum.FormTeamAutoReadyState.Not_Play_Before then
		FormTeamModel.instance:setTeamAutoReadyState(self._bossCfg.groupId, GameEnum.FormTeamAutoReadyState.Auto)
	end
end

function LingShenChallengeAddTipView:_refreshView()
	local readyMap = LingShenChallengeModel.instance:getReadyStatus()

	self._txtReadyCount.text = string.format("%d/<color=#61CC7DFF>%d</color>", table.nums(readyMap), self._playerCount)
end

function LingShenChallengeAddTipView:_onUpdatePet()
	self._fmtMo.formMsg = true

	self._fmtMo:refreshPetList()
end

function LingShenChallengeAddTipView:_onCountdown()
	self._autoTimer = self._autoTimer - 1
	self._txtAutoTimer.text = GameUtil.FormatTimeWords(self._autoTimer, true)

	if self._autoTimer <= 0 then
		removetimer(self._onCountdown, self)
		MissionMsgBlockController.instance:setIsBlocking(true)
		self:_onReady()
	end
end

function LingShenChallengeAddTipView:_onReady()
	goutil.setActive(self._markReady, true)

	self._fmtMo.isReady = true
end

function LingShenChallengeAddTipView:_onFormChange(playerId, isSuccess)
	if playerId == RoleModel.instance:getUserId() and isSuccess == false then
		FloatWordMgr.instance:show(lang("调整失败"))
	end

	self:_onUpdatePet()
end

function LingShenChallengeAddTipView:_onFormReady(playerId, isSuccess)
	if playerId == RoleModel.instance:getUserId() and isSuccess == false then
		FloatWordMgr.instance:show(lang("当前无法准备 请调整阵容"))
	elseif playerId == RoleModel.instance:getUserId() then
		self:_onReady()
	end

	self:_onUpdatePet()
	self:_refreshView()
end

function LingShenChallengeAddTipView:_onFightStart()
	self:_onReady()
	removetimer(self._onCountdown, self)
end

return LingShenChallengeAddTipView
