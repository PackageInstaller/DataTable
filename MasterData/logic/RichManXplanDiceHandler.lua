-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/controller/RichManXplanDiceHandler.lua

module("logic.extensions.richmanxplan.controller.RichManXplanDiceHandler", package.seeall)

local RichManXplanDiceHandler = class("RichManXplanDiceHandler")
local FaceTo = {
	Vector3.New(0, 90, 0),
	Vector3.New(-90, 0, 0),
	Vector3.New(0, 180, 0),
	Vector3.New(0, -90, 0),
	Vector3.New(-90, 0, -180),
	(Vector3.New(0, 0, 0))
}

function RichManXplanDiceHandler:ctor()
	return
end

function RichManXplanDiceHandler:initFromGo(mainGo, saiziCount)
	self._mainGo = mainGo
	self._saiziCount = saiziCount or 1
	self._goSaiZiGos = {}

	for i = 1, self._saiziCount do
		local go = goutil.findChild(self._mainGo, string.format("camera/go_%s", i))

		table.insert(self._goSaiZiGos, go)
	end

	self:setVisible(false)
end

function RichManXplanDiceHandler:setVisible(value)
	GameUtil.SetActive(self._mainGo, value)
end

function RichManXplanDiceHandler:dispose()
	self._value = nil
	self._bNotPlayAnim = nil
	self._doneCallback = nil
	self._startCallback = nil
	self._thisArg = nil
	self._faceTo = nil

	self:_removeTimer()
end

function RichManXplanDiceHandler:play(params)
	if self._isPlaying then
		return false
	end

	self._params = params

	local useSaiZiId = self:_getParam("useSaiZiId", 1)

	self._currentGo = nil

	for i, v in ipairs(self._goSaiZiGos) do
		if i == useSaiZiId then
			self._currentGo = v
		end
	end

	if self._currentGo then
		self._value = self:_getParam("value")
		self._bNotPlayAnim = self:_getParam("bNotPlayAnim")
		self._doneCallback = self:_getParam("doneCallback")
		self._startCallback = self:_getParam("startCallback")
		self._thisArg = self:_getParam("thisArg")
		self._faceTo = self:_getParam("faceTo", FaceTo)
		self._autoHideSelfSec = self:_getParam("autoHideSelfSec", -1)
		self._autoHideSelfCallback = self:_getParam("autoHideSelfCallback")

		self:_removeTimer()
		self:_doPlay()
	end
end

function RichManXplanDiceHandler:_getParam(key, defaultValue)
	if self._params[key] ~= nil then
		return self._params[key]
	end

	return defaultValue
end

function RichManXplanDiceHandler:_callBack(func, thisArg, ...)
	if thisArg and thisArg.__destroyed then
		return
	end

	GameUtil.callBack(func, thisArg)
end

function RichManXplanDiceHandler:_doPlay()
	self:_callBack(self._startCallback, self._thisArg)

	self._isPlaying = true
	self._curFaceTo = self._faceTo[Mathf.Clamp(self._value, 1, #self._faceTo)]

	self:setVisible(true)
	self:_resetSaiZi(self._currentGo)

	if self._bNotPlayAnim then
		GameUtil.setLocalRotation(self._currentGo, self._curFaceTo.x, self._curFaceTo.y, self._curFaceTo.z)
		self:_endPlayDice()
	else
		self:_playDiceAni1()
	end
end

function RichManXplanDiceHandler:_resetSaiZi(go)
	local tweenBezier = go:GetComponent("TweenBezier")

	tweenBezier.enabled = false

	GameUtil.setLocalRotation(go, 0, 0, 0)
	UnityTweens.TweenRotate.StopTween(go)
	GameUtil.SetActive(go, false)
end

function RichManXplanDiceHandler:_playDiceAni1()
	local goSaizi = self._currentGo

	GameUtil.SetActive(goSaizi, true)

	goSaizi:GetComponent("TweenBezier").enabled = true
	UnityTweens.TweenRotate.StartTween(goSaizi, Vector3.zero, Vector3.New(360, 360, 0), 0.3).loopType = UnityTweens.LoopType.loop

	settimer(1, self._playDiceAni2, self, false)
end

function RichManXplanDiceHandler:_playDiceAni2()
	local goSaizi = self._currentGo

	self:_setTweenBezierToLast()
	GameUtil.SetActive(goSaizi, true)

	local tx, ty, tz = GameUtil.getLocalRotation(goSaizi)

	UnityTweens.TweenRotate.StartTween(goSaizi, Vector3.New(tx, ty, tz), self._curFaceTo, 0.5).loopType = UnityTweens.LoopType.none

	settimer(1.5, self._endPlayDice, self, false)
end

function RichManXplanDiceHandler:_endPlayDice()
	self:_removeTimer()

	self._isPlaying = false

	local goSaizi = self._currentGo

	self:_setTweenBezierToLast()
	GameUtil.SetActive(goSaizi, true)
	self:_callBack(self._doneCallback, self._thisArg)

	if self._autoHideSelfSec > 0 then
		settimer(self._autoHideSelfSec, self._autoHide, self)
	end
end

function RichManXplanDiceHandler:_setTweenBezierToLast()
	local goSaizi = self._currentGo
	local tweenBezier = goSaizi:GetComponent("TweenBezier")
	local lastPos = tweenBezier.points[tweenBezier.points.Length - 1]

	tweenBezier.enabled = false

	GameUtil.setLocalPos(goSaizi, lastPos.x, lastPos.y, lastPos.z)
end

function RichManXplanDiceHandler:_autoHide()
	removetimer(self._autoHide, self)
	self:setVisible(false)
	self:_callBack(self._autoHideSelfCallback, self._thisArg)
end

function RichManXplanDiceHandler:_removeTimer()
	removetimer(self._playDiceAni2, self)
	removetimer(self._endPlayDice, self)
	removetimer(self._autoHide, self)
end

return RichManXplanDiceHandler
