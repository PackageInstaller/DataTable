-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKMatchView.lua

module("logic.extensions.teenchampionking.view.TCKMatchView", package.seeall)

local TCKMatchView = class("TCKMatchView", ViewComponent)

function TCKMatchView:ctor()
	TCKMatchView.super.ctor(self)
end

function TCKMatchView:unbindEvents()
	TCKMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function TCKMatchView:bindEvents()
	TCKMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancle, self)
end

function TCKMatchView:buildUI()
	TCKMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._txtTime = self:getTxt("matching/txtTime")
	self._btnCancel = self:getGo("matching/btnCancel")
	self._suc = self:getGo("suc")
	self._headLeft = self:getGo("suc/animNode/root/left/information/head")
	self._Text01Left = self:getTxt("suc/animNode/root/left/information/group/Text01")
	self._Text03Left = self:getTxt("suc/animNode/root/left/information/group/Text03")
	self._Text02Left = self:getTxt("suc/animNode/root/left/information/group/Text02")
	self._headRight = self:getGo("suc/animNode/root/right/information/head")
	self._Text01Right = self:getTxt("suc/animNode/root/right/information/group/Text01")
	self._Text02Right = self:getTxt("suc/animNode/root/right/information/group/Text02")
	self._Text03Right = self:getTxt("suc/animNode/root/right/information/group/Text03")
	self._effectVS = self:getGo("suc/effectVS")
	self._effectSuccess = self:getGo("suc/effectSuccess")
end

function TCKMatchView:onExit()
	TCKMatchView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headLeft)
	HeadItemController.instance:resetHeadCell(self._headRight)
	removetimer(self._updateTimer, self)
	removetimer(self._finishPlayAni, self)
end

function TCKMatchView:onEnter()
	TCKMatchView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001
	self._enterStepId = params and checknumber(params[2]) or 1
	self._matchSucParam = params and params[3]

	self.addGEvent(self, GlobalNotify.PM_TCKStartMatch, self._startMatch, self)
	self.addGEvent(self, GlobalNotify.PM_TCKCancelMatch, self._onCancel, self)
	self.addGEvent(self, GlobalNotify.PM_TCKMatchFail, self._handleFail, self)
	self.addGEvent(self, GlobalNotify.PM_TCKNotifyFightStart, self._handleGetNewMatch, self)

	self._matchSec = TeenChampionKingConfig.instance:getCommonValue("MAX_MATCH_SEC")
	self._forceFight = false

	if self._matchSucParam then
		self._forceFight = true

		self:_handleGetNewMatch(self._matchSucParam)
	else
		TeenChampionKingController.instance:startMatch(self._activityId, self._enterStepId)
	end
end

function TCKMatchView:_onClickCancle()
	TeenChampionKingController.instance:cancelMatch()
end

function TCKMatchView:_fightStart()
	self._forceFight = true
end

function TCKMatchView:_onCancel()
	if not self._forceFight then
		self:close()
		print("少年竞技王取消匹配")
	end
end

function TCKMatchView:_handleFail()
	FloatWordMgr.instance:show("匹配失败")
	self:close()
end

function TCKMatchView:_handleGetNewMatch(msg)
	local info = GameUtil.pbToTable(msg)

	self._startTime = info.gameStartTime or 0

	removetimer(self._updateTimer, self)
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, false)
	HeadItemController.instance:setMyHeadCell(self._headLeft)

	self._Text01Left.text = RoleModel.instance:getUserName()
	self._Text02Left.text = string.format("%s", RoleModel.instance:getAreaName())
	self._Text03Left.text = string.format("战力：%s", RoleModel.instance:getMaxPower())

	local opHeadInfo = info.opHeadInfo

	if opHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(self._headRight, opHeadInfo)

		self._Text01Right.text = opHeadInfo.userName
		self._Text02Right.text = string.format("%s", info.opAreaName)
		self._Text03Right.text = string.format("战力：%s", info.opZdl or 0)

		self:_playAni()
	else
		goutil.setActive(self._matching, true)
		goutil.setActive(self._enemyRole, false)
	end
end

function TCKMatchView:_startMatch()
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, true)

	self._timer = 0
	self._timeCount = self._matchSec
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)

	settimer(1, self._updateTimer, self, true)
end

function TCKMatchView:_updateTimer()
	self._timer = self._timer + 1
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
end

function TCKMatchView:_playAni()
	removetimer(self._updateTimer, self)
	goutil.setActive(self._suc, true)
	settimer(3, self._finishPlayAni, self, false)
end

function TCKMatchView:_finishPlayAni()
	TeenChampionKingController.instance:tryShowMission(self._activityId, self._startTime / 1000)
	self:close()
end

return TCKMatchView
