-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/view/WBB_UITimeCounter.lua

module("logic.extensions.weeklybigbox.view.WBB_UITimeCounter", package.seeall)

local WBB_UITimeCounter = class("WBB_UITimeCounter")

function WBB_UITimeCounter:ctor(mainGo)
	self._mainGo = mainGo
	self._txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
end

function WBB_UITimeCounter:play(sec, callback, thisArg, timeFormat)
	assert(thisArg and thisArg.destroyed ~= nil)

	self._callback = callback
	self._thisArg = thisArg
	self._phaseTimestamp = UnityEngine.Time.realtimeSinceStartup + math.max(sec, 0)
	self._timeFormat = timeFormat or "%d"

	settimer(0.2, self._tick, self)
	self:_tick()
	goutil.setActive(self._mainGo, true)
end

function WBB_UITimeCounter:stop(bTriggerCallback)
	removetimer(self._tick, self)
	goutil.setActive(self._mainGo, false)

	if bTriggerCallback and self._thisArg.destroyed == false then
		GameUtil.callBack(self._callback, self._thisArg)
	end
end

function WBB_UITimeCounter:_tick()
	local delta = self._phaseTimestamp - UnityEngine.Time.realtimeSinceStartup
	local sec = math.ceil(delta)

	if sec > 0 then
		self._txtTime.text = langPara(self._timeFormat, sec)
	else
		self:stop()

		if self._thisArg.destroyed == false then
			GameUtil.callBack(self._callback, self._thisArg)
		end
	end
end

function WBB_UITimeCounter:dispose()
	self:stop()
end

return WBB_UITimeCounter
