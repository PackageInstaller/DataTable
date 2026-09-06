-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingMatchView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingMatchView", package.seeall)

local YoungChampionKingMatchView = class("YoungChampionKingMatchView", ViewComponent)

function YoungChampionKingMatchView:ctor()
	YoungChampionKingMatchView.super.ctor(self)
end

function YoungChampionKingMatchView:unbindEvents()
	YoungChampionKingMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function YoungChampionKingMatchView:bindEvents()
	YoungChampionKingMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
end

function YoungChampionKingMatchView:buildUI()
	YoungChampionKingMatchView.super.buildUI(self)

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

function YoungChampionKingMatchView:onExit()
	YoungChampionKingMatchView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headLeft)
	HeadItemController.instance:resetHeadCell(self._headRight)
	removetimer(self._updateTimer, self)
	removetimer(self._finishPlayAni, self)
end

function YoungChampionKingMatchView:onEnter()
	YoungChampionKingMatchView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterStepId = checknumber(params[2])

	self:_startMatch()
	self.addGEvent(self, GlobalNotify.PM_YCKQualifierGetNewOpponentRes, self._handleGetNewMatch, self)
end

function YoungChampionKingMatchView:_handleGetNewMatch()
	removetimer(self._updateTimer, self)
	goutil.setActive(self._suc, false)
	goutil.setActive(self._match, false)
	HeadItemController.instance:setMyHeadCell(self._headLeft)

	self._Text01Left.text = RoleModel.instance:getUserName()
	self._Text02Left.text = string.format("%s", RoleModel.instance:getAreaName())
	self._Text03Left.text = string.format("战力：%s", RoleModel.instance:getMaxPower())

	local qualifyInfo = YoungChampionKingModel.instance:getQualifierInfo(self._activityId, self._enterStepId)
	local opponent = qualifyInfo.opponent

	if opponent then
		HeadItemController.instance:setHeadCellByInfo(self._headRight, opponent.headInfo)

		self._Text01Right.text = opponent.headInfo.userName
		self._Text02Right.text = string.format("%s", opponent.headInfo.areaName)
		self._Text03Right.text = string.format("战力：%s", opponent.zdl)
	else
		goutil.setActive(self._matching, true)
		goutil.setActive(self._enemyRole, false)
	end

	self:_playAni()
end

function YoungChampionKingMatchView:_startMatch()
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, true)

	self._timer = 0
	self._timeCount = 0
	self._timeStepLegth = math.random(1, 5)
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)

	settimer(1, self._updateTimer, self, true)
end

function YoungChampionKingMatchView:_updateTimer()
	self._timer = self._timer + 1

	local timeStep = math.floor(self._timer / self._timeStepLegth)

	if timeStep > self._timeCount then
		self._timeCount = timeStep

		YoungChampionKingController.instance:sendPM_YCKQualifierGetNewOpponentReq(self._activityId, self._enterStepId)
	end

	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
end

function YoungChampionKingMatchView:_playAni()
	removetimer(self._updateTimer, self)
	goutil.setActive(self._suc, true)
	settimer(3, self._finishPlayAni, self, false)
end

function YoungChampionKingMatchView:_finishPlayAni()
	self:close()
end

return YoungChampionKingMatchView
