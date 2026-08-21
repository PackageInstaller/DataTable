-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/FootballScoreBoardPlayerItem.lua

module("logic.extensions.football.view.battle.FootballScoreBoardPlayerItem", package.seeall)

local M = class("FootballScoreBoardPlayerItem", UIReusableLuaBehavior)

function M:buildUI()
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtPlayerName")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._imgHead = goutil.findChildImageComponent(self.mainGO, "imgHead")
	self._goTime = goutil.findChild(self.mainGO, "time")
	self._timeoutHandler = Handler.New()
	self._userInfoMO = false
	self._seconds = 0
end

function M:destroyUI()
	self._txtScore = false
	self._txtName = false
	self._txtTime = false
	self._goTime = false
	self._imgHead = false
	self._timeoutHandler = false
	self._userInfoMO = false
end

function M:clear()
	self:stopCountDown()
end

function M:setTimeoutListener(callback, callbackSelf)
	self._timeoutHandler:setListener(callback, callbackSelf)
end

function M:getTeamId()
	return self._userInfoMO.teamId
end

function M:getUserId()
	return self._userInfoMO.userId
end

function M:setUserInfoMO(userInfoMO)
	self._userInfoMO = userInfoMO
	self._txtName.text = userInfoMO.nickname
	self._txtScore.text = 0

	IconLoader.setSprite(self._imgHead, IconType.HeadIcon, userInfoMO:getIconName())
	goutil.setActive(self._goTime, false)
end

function M:setScore(score)
	self._txtScore.text = score
end

function M:startCountDown(seconds)
	self._seconds = seconds
	self._txtTime.text = seconds

	goutil.setActive(self._goTime, true)
	settimer(1, self._onSecondTick, self, true)
end

function M:stopCountDown()
	goutil.setActive(self._goTime, false)
	removetimer(self._onSecondTick, self)
end

function M:_onSecondTick()
	self._seconds = self._seconds - 1

	if self._seconds <= 0 then
		self._timeoutHandler:call(self)
		self:stopCountDown()
	end

	self._txtTime.text = self._seconds
end

return M
