-- chunkname: @modules/logic/story/view/StoryCurvePlayer.lua

module("modules.logic.story.view.StoryCurvePlayer", package.seeall)

local StoryCurvePlayer = class("StoryCurvePlayer")

function StoryCurvePlayer:playAnim(startVal, endVal, transTime, curve, farmeCallback, finishCallback, callbackObj)
	self:initData(startVal, endVal, transTime, curve, farmeCallback, finishCallback, callbackObj)
	self:_play()
end

function StoryCurvePlayer:initData(startVal, endVal, transTime, curve, farmeCallback, finishCallback, callbackObj)
	self._startVal = startVal
	self._endVal = endVal
	self._startTime = Time.time
	self._duration = transTime
	self._farmeCallback = farmeCallback
	self._finishCallback = finishCallback
	self._callbackObj = callbackObj
	self._curve = curve
end

function StoryCurvePlayer:_play()
	self:clearAnim()

	if not self._curve then
		return
	end

	TaskDispatcher.runRepeat(self._onFrame, self, 0.001)
end

function StoryCurvePlayer:_onFrame()
	local runTime = Time.time - self._startTime

	if runTime >= self._duration then
		if self._finishCallback then
			self._finishCallback(self._callbackObj)
		end

		return
	end

	local t = runTime / self._duration
	local y = StoryTool.Evaluate(self._curve, t)

	if self._farmeCallback then
		local val = Mathf.Lerp(self._startVal, self._endVal, y)

		self._farmeCallback(self._callbackObj, val)
	end
end

function StoryCurvePlayer:clearAnim()
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function StoryCurvePlayer:destory()
	self:clearAnim()
end

return StoryCurvePlayer
