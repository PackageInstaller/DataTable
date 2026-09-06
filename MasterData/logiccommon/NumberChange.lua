-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/numberchange/NumberChange.lua

module("logiccommon.common.viewlib.numberchange.NumberChange", package.seeall)

local NumberChange = class("NumberChange")
local UnityTime = UnityEngine.Time

function NumberChange:ctor(go)
	self._go = go

	self:buildUI()
end

function NumberChange:buildUI()
	self._strength = goutil.findChildComponent(self._go, "imgNum", typeof(UIImgNumeralText))
end

function NumberChange:startPlay(startVal, endVal)
	self._tweenDelta = 0
	self._delayFinishTime = 0
	self._currStrength = startVal
	self._destStrength = endVal

	self:_updateText()
	settimer(0, self._tweenStrengthNum, self)
end

function NumberChange:_tweenStrengthNum()
	if self._currStrength < self._destStrength then
		self:_updateNumber()
	else
		self:_updateFinished()
	end
end

function NumberChange:_updateNumber()
	self._tweenDelta = self._tweenDelta + UnityTime.deltaTime
	self._delayFinishTime = 0

	if self._tweenDelta >= 0.05 then
		self._tweenDelta = self._tweenDelta - 0.05

		local delta = self:_getNumPace()

		self._currStrength = self._currStrength + delta

		if self._currStrength >= self._destStrength then
			self._currStrength = self._destStrength
		end

		self:_updateText()
	end
end

function NumberChange:_updateFinished()
	self._tweenDelta = 0
	self._delayFinishTime = self._delayFinishTime + UnityTime.deltaTime

	if self._delayFinishTime >= 1 then
		self._delayFinishTime = 0

		removetimer(self._tweenStrengthNum, self)

		if self._finishHandler then
			if self._finishTarget then
				self._finishHandler(self._finishTarget)
			else
				self._finishHandler()
			end
		end
	end
end

function NumberChange:setFinishCall(finishHandler, finishTarget)
	self._finishHandler = finishHandler
	self._finishTarget = finishTarget
end

function NumberChange:_getNumPace()
	local delta = self._destStrength - self._currStrength

	if delta < 10 then
		return 1
	end

	if delta < 20 then
		return 2
	end

	if delta < 50 then
		return 3
	end

	if delta < 100 then
		return 5
	end

	if delta < 300 then
		return 30
	end

	if delta < 500 then
		return 80
	end

	if delta < 1000 then
		return 300
	end

	return 500
end

function NumberChange:_updateText()
	local txt = tostring(self._currStrength)

	self._strength:SetText(txt)
end

function NumberChange:clear()
	self._tweenDelta = nil
	self._delayFinishTime = nil

	removetimer(self._tweenStrengthNum, self)
end

return NumberChange
