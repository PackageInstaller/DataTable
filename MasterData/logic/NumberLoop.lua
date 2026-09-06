-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/model/NumberLoop.lua

module("logic.extensions.linkagelottery.model.NumberLoop", package.seeall)

local NumberLoop = class("NumberLoop")

function NumberLoop:ctor()
	self._startNum = 0
	self._endNum = 1
	self._firstNum = 0
	self._targetNum = 1
	self._loopNum = 1
	self._duration = 1
	self._onCompleteCallback = nil
	self._curNum = self._startNum
	self._curTween = nil
	self._realEndNum = 1
end

function NumberLoop:initParam(param)
	self._startNum = param.startNum or 0
	self._endNum = param.endNum or 1
	self._targetNum = param.targetNum or self._endNum
	self._loopNum = param.loopNum or 5
	self._duration = param.duration or 3
	self._onCompleteCallback = param.onCompleteCallback
	self._firstNum = param.firstNum and Mathf.Clamp(param.firstNum, self._startNum, self._endNum) or self._startNum

	self:_calculateParam()
end

function NumberLoop:play()
	if self._curTween then
		self._curTween:Kill()

		self._curTween = nil
	end

	local function updateFunc(num)
		local value = Mathf.Round(num)

		self._curNum = (value - self._startNum) % self._length + 1
	end

	self._curTween = TweenUtil.DOTweenNum(self._firstNum, self._realEndNum, self._duration, updateFunc, self)

	self._curTween:OnComplete(function()
		GameUtil.callBack(self._onCompleteCallback)
		self._curTween:Kill()

		self._curTween = nil
	end)
end

function NumberLoop:pause()
	if self._curTween then
		self._curTween:Pause()
	end
end

function NumberLoop:stop(isComplete)
	if self._curTween then
		self._curTween:Kill(isComplete)

		self._curTween = nil
	end
end

function NumberLoop:isPlaying()
	if self._curTween then
		return self._curTween:IsPlaying()
	end

	return false
end

function NumberLoop:getCurNum()
	return self._curNum or self._targetNum
end

function NumberLoop:_calculateParam()
	self._length = self._endNum - self._startNum + 1
	self._realEndNum = self._firstNum + self._length * self._loopNum + (self._targetNum - self._startNum)
	self._curNum = self._firstNum
end

return NumberLoop
