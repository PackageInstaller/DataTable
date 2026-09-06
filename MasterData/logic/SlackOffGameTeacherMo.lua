-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/model/SlackOffGameTeacherMo.lua

module("logic.extensions.slackoffgame.model.SlackOffGameTeacherMo", package.seeall)

local SlackOffGameTeacherMo = class("SlackOffGameTeacherMo", BaseLuaOnce)

function SlackOffGameTeacherMo:buildUI()
	self._bell = self:getGo("bell")
	self._img = self:getGo("img")
end

function SlackOffGameTeacherMo:onExit()
	self:endWork()
end

function SlackOffGameTeacherMo:onEnter(intervalTime, duration, scaleTimes, scaleVec3, shakeVec3)
	print("[YuTestPrint] =====>\t 初始化老师")
	self:setData(intervalTime, duration, scaleTimes, scaleVec3, shakeVec3)
	self:_init()
	self:_teacherActive(false)
end

function SlackOffGameTeacherMo:setData(intervalTime, duration, scaleTimes, scaleVec3, shakeVec3)
	self._intervalTime = intervalTime
	self._duration = duration
	self._scaleTimes = scaleTimes
	self._scaleVec3 = scaleVec3
	self._shakeVec3 = shakeVec3
end

function SlackOffGameTeacherMo:_init()
	self._goBigger = false

	goutil.setActive(self._bell, false)
end

function SlackOffGameTeacherMo:startWork()
	self._nextTime = math.random(self._intervalTime[1], self._intervalTime[2])
	self._bellTime = self._nextTime - 2

	settimer(self._bellTime, self._bellRing, self)
end

function SlackOffGameTeacherMo:endWork()
	goutil.setActive(self._bell, false)
	removetimer(self._bellRing, self)
	removetimer(self._teacherLeave, self)
	UnityTweens.TweenShakePosition.StopTween(self._bell)
end

function SlackOffGameTeacherMo:_bellRing()
	print("[YuTestPrint] =====>\t 铃铛震动")
	removetimer(self._bellRing, self)
	goutil.setActive(self._bell, true)

	local duration = 2
	local shakeRange = Vector3.New(self._shakeVec3[1], self._shakeVec3[2], self._shakeVec3[3]) or Vector3.New(5, 0, 1)

	self._timeCount = 0

	settimer(self._scaleTimes, self._bellScale, self)

	self._shakeTween = UnityTweens.TweenShakePosition.StartTween(self._bell, shakeRange, duration)

	settimer(duration, self._afterBellRing, self, false)
end

function SlackOffGameTeacherMo:_bellScale()
	self._timeCount = self._timeCount + self._scaleTimes
	self._goBigger = not self._goBigger

	if self._goBigger then
		GameUtil.setLocalScale(self._bell, self._scaleVec3[1], self._scaleVec3[2], self._scaleVec3[3])
	else
		GameUtil.setLocalScale(self._bell, 1, 1, 1)
	end
end

function SlackOffGameTeacherMo:_afterBellRing()
	print("[YuTestPrint] =====>\t 铃铛停止")
	removetimer(self._bellScale, self)
	removetimer(self._afterBellRing, self)
	self._shakeTween:RemoveListener()
	UnityTweens.UITweenShake.StopTween(self._bell)
	UnityTweens.TweenScale.StopTween(self._bell)
	GameUtil.setLocalScale(self._bell, 1, 1, 1)
	goutil.setActive(self._bell, false)
	self:_teacherComeIn()
end

function SlackOffGameTeacherMo:_teacherComeIn()
	print("[YuTestPrint] =====>\t 老师进入")
	GlobalDispatcher:dispatch(GlobalNotify.SlackOffGameTeacherComeIn)
	self:_teacherActive(true)

	local duration = math.random(self._duration[1], self._duration[2])

	settimer(duration, self._teacherLeave, self)
end

function SlackOffGameTeacherMo:_teacherLeave()
	print("[YuTestPrint] =====>\t 老师离开")
	removetimer(self._teacherLeave, self)
	GlobalDispatcher:dispatch(GlobalNotify.SlackOffGameTeacherLeave)
	self:_teacherActive(false)
	self:startWork()
end

function SlackOffGameTeacherMo:_teacherActive(isIn)
	goutil.setActive(self._img, isIn)
end

return SlackOffGameTeacherMo
