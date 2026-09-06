-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/PlayerStrengrhChangeView.lua

module("logic.extensions.mainui.view.PlayerStrengrhChangeView", package.seeall)

local PlayerStrengrhChangeView = class("PlayerStrengrhChangeView", ViewComponent)
local UnityTime = UnityEngine.Time

function PlayerStrengrhChangeView:buildUI()
	self._arrow = self:getGo("Arrow").transform
	self._strength = self:getGo("Strength"):GetComponent("UIImgNumeralText")

	local arrowPosX, arrowPosY, _ = Framework.TransformUtil.GetLocalPos(self._arrow, nil, nil, nil)
	local textPosX, textPosY, _ = Framework.TransformUtil.GetLocalPos(self._strength.transform, nil, nil, nil)

	self._arrowYPos = arrowPosY
	self._textPosX = textPosX
	self._txtAdd = goutil.findChildTextComponent(self.mainGO, "Arrow/Num/txtNum")
end

function PlayerStrengrhChangeView:onEnter()
	self._tweenDelta = 0
	self._delayFinishTime = 0

	self:_popStrength()
	self:_updateText()
	settimer(0, self._tweenStrengthNum, self)
	AudioPlayerEx.instance:playEffect(30212)
end

function PlayerStrengrhChangeView:onExit()
	removetimer(self._tweenStrengthNum, self)

	GlobalModel.instance.isChangingSrength = nil
	self._tweenDelta = nil
	self._delayFinishTime = nil
end

function PlayerStrengrhChangeView:_updateNumber()
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

function PlayerStrengrhChangeView:_updateFinished()
	self._tweenDelta = 0
	self._delayFinishTime = self._delayFinishTime + UnityTime.deltaTime

	if self._delayFinishTime >= 1 then
		self._delayFinishTime = 0

		removetimer(self._tweenStrengthNum, self)
		GlobalController.instance:clearPlayerStrengthChange()
	end
end

function PlayerStrengrhChangeView:_tweenStrengthNum()
	if self._currStrength < self._destStrength then
		self:_updateNumber()
	else
		self:_updateFinished()
	end
end

function PlayerStrengrhChangeView:_popStrength()
	self._currStrength = GlobalModel.instance:getCurrStrength()
	self._destStrength = GlobalModel.instance:popStrength()
	self._txtAdd.text = "+" .. self._destStrength - self._currStrength
	GlobalModel.instance.currStrength = self._destStrength
end

function PlayerStrengrhChangeView:_getNumPace()
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

	if delta < 10000 then
		return 1000
	end

	if delta < 100000 then
		return 10000
	end

	return math.floor(delta / 10)
end

function PlayerStrengrhChangeView:_updateText()
	local txt = tostring(self._currStrength)

	self._strength:SetText(txt)

	local childList = GameUtil.getChildren(self._strength.transform)

	for _, v in ipairs(childList) do
		local graphic = v:GetComponent(typeof(UnityEngine.UI.Graphic))

		if not goutil.isNil(graphic) then
			graphic.raycastTarget = false
		end
	end

	local cnt = #txt
	local delta = self._textPosX + cnt * 32 + 27

	Framework.TransformUtil.SetLocalPos(self._arrow, delta, self._arrowYPos, 0)
end

return PlayerStrengrhChangeView
