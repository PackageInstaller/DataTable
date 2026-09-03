-- chunkname: @/tmp/or_script/lua_compile/dm/base/actions.lua

RockAction = ccSequenceAction("RockAction", function(freq, strength)
	local amplitude = 0.8 * (strength or 1)
	local quarter = 1 / (4 * (freq or 8))

	return {
		cc.MoveBy:create(quarter, cc.p(6 * amplitude, 10 * amplitude)),
		cc.MoveBy:create(quarter, cc.p(-6 * amplitude, -10 * amplitude)),
		cc.MoveBy:create(quarter, cc.p(-5 * amplitude, -8 * amplitude)),
		cc.MoveBy:create(quarter, cc.p(-4 * amplitude, 6 * amplitude)),
		cc.MoveBy:create(quarter * 2, cc.p(15 * amplitude, 4 * amplitude)),
		cc.MoveBy:create(quarter, cc.p(-6 * amplitude, -2 * amplitude))
	}
end)
NumberScaleAction = ccSequenceAction("NumberScaleAction", function(func1, func2)
	return {
		cc.CallFunc:create(func1),
		cc.ScaleTo:create(0.06, 1.4),
		cc.ScaleTo:create(0.06, 1),
		cc.CallFunc:create(func2)
	}
end)
ScrollNumberAction = ccSequenceAction("ScrollNumberAction", function(info)
	local node, startNum, endNum, time = info.node, info.startNum, info.endNum, info.time
	local refreshFunc = info.refreshFunc
	local endFunc = info.endFunc
	local distanceHeight = 4
	local scaleBig = 1.2
	local scaleSmall = 0.6
	local time = 0.2
	local changeWidth = 10

	node:getParent():removeChildByTag(56456, true)

	local clippingLayout = ccui.Layout:create()

	clippingLayout:setAnchorPoint(node:getAnchorPoint())
	clippingLayout:setPosition(node:getPosition()):offset(changeWidth / 2, 0)
	clippingLayout:addTo(node:getParent()):setPosition(node:getPosition())
	clippingLayout:setClippingEnabled(true)
	clippingLayout:setTag(56456)

	local starLabel = node:clone()

	starLabel:setAnchorPoint(0.5, 0.5)
	starLabel:addTo(clippingLayout)

	local endLabel = node:clone()

	endLabel:setAnchorPoint(0.5, 0.5)
	endLabel:addTo(clippingLayout)
	node:setVisible(false)

	function moveAction(time, pos, scale, func)
		return cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(time, pos), cc.ScaleTo:create(time, scale)), cc.CallFunc:create(func))
	end

	function rSetPosX()
		local layoutSize = clippingLayout:getContentSize()

		starLabel:setPositionX(layoutSize.width / 2)
		endLabel:setPositionX(layoutSize.width / 2)
	end

	local actionList = {
		function()
			starLabel:setString(startNum)

			local size = starLabel:getContentSize()

			clippingLayout:setContentSize(cc.size(size.width + changeWidth, size.height))
			clippingLayout:setPosition(node:getPosition()):offset(changeWidth / 2, 0)

			local layoutSize = clippingLayout:getContentSize()

			starLabel:setPosition(layoutSize.width / 2, layoutSize.height / 2)
			rSetPosX()
			starLabel:setScale(1)
			starLabel:setVisible(true)
			endLabel:setVisible(false)
			endLabel:setScale(scaleBig)
			starLabel:setColor(cc.c3b(255, 255, 255))
			endLabel:setColor(cc.c3b(20, 211, 56))
		end,
		function(func)
			endLabel:setVisible(true)
			endLabel:setString(startNum + 1)

			if refreshFunc then
				refreshFunc(clippingLayout, changeWidth, startNum + 1)
			end

			local size = endLabel:getContentSize()

			clippingLayout:setContentSize(cc.size(size.width + changeWidth, size.height))
			clippingLayout:setPosition(node:getPosition()):offset(changeWidth / 2, 0)

			local layoutSize = clippingLayout:getContentSize()
			local posY = starLabel:getPositionY() + starLabel:getContentSize().height / 2

			posY = posY + endLabel:getContentSize().height / 2 + distanceHeight

			endLabel:setPositionY(posY)
			rSetPosX()
			starLabel:runAction(moveAction(time, cc.p(layoutSize.width / 2, -starLabel:getContentSize().height / 2 + 4), scaleSmall, function()
				return
			end))
			endLabel:runAction(moveAction(time, cc.p(layoutSize.width / 2, layoutSize.height / 2), 1, function()
				if func then
					func()
				end
			end))
		end
	}

	function scrollNumber(num)
		function changePos()
			local function callBack()
				startNum = startNum + 1

				scrollBackFunc()
			end

			actionList[2](callBack)
		end

		actionList[1]()
		rSetPosX()
		changePos(changePos)
	end

	function scrollBackFunc()
		if startNum < endNum then
			scrollNumber(startNum)
		else
			node:setVisible(true)
			node:setString(endNum)
			clippingLayout:removeFromParent(true)

			if endFunc then
				endFunc()
			end
		end
	end

	return {
		cc.CallFunc:create(function()
			scrollNumber(startNum)
		end)
	}
end)
DelayAction = ccSequenceAction("DelayAction", function(callback, delay)
	return {
		cc.DelayTime:create(delay),
		cc.CallFunc:create(callback)
	}
end)
BreatheAction = ccSequenceAction("BreatheAction", function(time, scale)
	time = time or 1.8
	scale = scale or 1

	return {
		cc.Spawn:create(cc.FadeOut:create(time), cc.ScaleTo:create(time, 1.1 * scale)),
		cc.Spawn:create(cc.FadeIn:create(time), cc.ScaleTo:create(time, 1 * scale))
	}
end)
ScaleAction = ccSequenceAction("ScaleAction", function(time, node)
	time = time or 0.6

	local preScale = node:getScale()

	return {
		cc.ScaleTo:create(time, (node or nil) and preScale + 0.2),
		cc.ScaleTo:create(time, preScale)
	}
end)
FadeAction = ccSequenceAction("FadeAction", function(time)
	time = time or 0.5

	return {
		cc.FadeOut:create(time),
		cc.FadeIn:create(time)
	}
end)
UpDownAction = ccSequenceAction("UpDownAction", function(time, changeHeight)
	time = time or 0.5
	changeHeight = changeHeight or 10

	return {
		cc.MoveBy:create(time, cc.p(0, -changeHeight)),
		cc.MoveBy:create(time, cc.p(0, changeHeight))
	}
end)
BlinkAction = ccSequenceAction("BlinkAction", function(time)
	return {
		cc.FadeOut:create(time),
		cc.FadeIn:create(time)
	}
end)
SuspensionAction = ccSequenceAction("SuspensionAction", function(node, time)
	local oldPosY = node:getPositionY()
	local moveTo1 = cc.MoveTo:create(time, cc.p(node:getPositionX(), oldPosY + 10))
	local moveTo2 = cc.MoveTo:create(time, cc.p(node:getPositionX(), oldPosY))

	return {
		moveTo1,
		moveTo2
	}
end)
FadeInOutAction = ccSequenceAction("FadeInOutAction", function(time)
	time = time or 0.5

	local fade_out = cc.FadeOut:create(time)
	local fade_in = cc.FadeIn:create(time)
	local seq = cc.Sequence:create(fade_out, fade_in)

	return {
		seq
	}
end)
BottomMoveAction = ccSequenceAction("BottomMoveAction", function(node, starPosY, func)
	local changeY = 4
	local starPosX = node:getPositionX()

	node:setPositionY(starPosY - 58)

	local delayAction = cc.DelayTime:create(0.05)
	local action1 = cc.MoveTo:create(0.3, cc.p(starPosX, starPosY + changeY))
	local action2 = cc.MoveTo:create(0.1, cc.p(starPosX, starPosY))

	return {
		delayAction,
		action1,
		action2,
		cc.CallFunc:create(function()
			if func then
				func()
			end
		end)
	}
end)
ClickAction = ccSequenceAction("ClickAction", function(node, func)
	return {
		cc.Sequence:create(callFunc1, cc.ScaleTo:create(0.08, node:getScale() + 0.1), cc.ScaleTo:create(0.1, node:getScale()), cc.CallFunc:create(function()
			if func then
				func()
			end
		end))
	}
end)
CombatChangeAction = ccSequenceAction("CombatChangeAction", function(time, func)
	time = 1

	local moveUpAct = cc.MoveBy:create(1, cc.p(0, 80))
	local fade_in = cc.FadeIn:create(time)
	local moveFadeAct = cc.Spawn:create(moveUpAct, fade_in)
	local delayAction = cc.DelayTime:create(0.1)
	local fade_out = cc.FadeOut:create(1)
	local callbackFunc = cc.CallFunc:create(function()
		if func then
			func()
		end
	end)

	return {
		cc.Sequence:create(moveFadeAct, delayAction, fade_out, callbackFunc)
	}
end)
UpDownAction = ccSequenceAction("UpDownAction", function(time, changeHeight)
	time = time or 0.5
	changeHeight = changeHeight or 10

	return {
		cc.Spawn:create(cc.MoveBy:create(time, cc.p(0, -changeHeight)), cc.FadeOut:create(time)),
		cc.Spawn:create(cc.MoveBy:create(time, cc.p(0, changeHeight)), cc.FadeIn:create(time))
	}
end)
UpDownActionWithNoFade = ccSequenceAction("UpDownActionWithNoFade", function(time, changeHeight)
	time = time or 0.5
	changeHeight = changeHeight or 10

	return {
		cc.MoveBy:create(time, cc.p(0, -changeHeight)),
		cc.MoveBy:create(time, cc.p(0, changeHeight))
	}
end)
LeftRightAction = ccSequenceAction("LeftRightAction", function(time, changeWidth)
	time = time or 0.5
	changeWidth = changeWidth or 10

	return {
		cc.MoveBy:create(time, cc.p(-changeWidth, 0)),
		cc.MoveBy:create(time, cc.p(changeWidth, 0))
	}
end)
TweenActionImpl = class("TweenActionImpl", objectlua.Object)
TweenAction = ccAction("TweenAction", TweenActionImpl)

function TweenActionImpl:initialize(duration, key, from, to)
	super.initialize(self)

	self._duration = duration
	self._key = key
	self._from = from
	self._to = to
end

function TweenActionImpl:clone()
	return TweenActionImpl:new(self._duration, self._key, self._from, self._to)
end

function TweenActionImpl:reverse()
	return TweenActionImpl:new(self._duration, self._key, self._to, self._from)
end

function TweenActionImpl:startWithTarget(target)
	self._target = target
	self._delta = self._to - self._from
end

function TweenActionImpl:update(time)
	self._target:updateTweenAction(self._to - self._delta * (1 - time), self._key)
end

BrightnessToImpl = class("BrightnessToImpl", objectlua.Object)
BrightnessTo = ccAction("BrightnessTo", BrightnessToImpl)

function BrightnessToImpl:initialize(duration, val)
	super.initialize(self)

	self._duration = duration
	self._to = val
end

function BrightnessToImpl:clone()
	return BrightnessToImpl:new(self._duration, self._to)
end

function BrightnessToImpl:reverse()
	return nil
end

function BrightnessToImpl:startWithTarget(target)
	self._target = target
	self._delta = self._to - target:getBrightness()
end

function BrightnessToImpl:update(time)
	self._target:setBrightness(self._to - self._delta * (1 - time))
end

TypeoutNextCharacterImpl = class("TypeoutNextCharacterImpl", objectlua.Object)
TypeoutNextCharacter = ccAction("TypeoutNextCharacter", TypeoutNextCharacterImpl)

function TypeoutNextCharacterImpl:initialize(interval, info)
	super.initialize(self)

	self._info = info
end

function TypeoutNextCharacterImpl:startWithTarget(target)
	self._target = target
	self._richTextContentSize = self._target:getContentSize()
end

function TypeoutNextCharacterImpl:update(dt)
	if dt >= 1 then
		local function callFunc()
			self._target:clipContent(0, self._info.clipCount)
			self._target:renderContent(self._richTextContentSize.width, self._richTextContentSize.height, false)

			self._info.clipCount = self._info.clipCount + 1
		end

		callFunc()
	end
end

TypeWriterAction = cclass("TypeWriterAction", function(interval, count)
	local info = {
		clipCount = 1
	}
	local showNextCharacterAction = TypeoutNextCharacter:new(interval, info)

	return cc.Repeat:create(showNextCharacterAction, count)
end)
NewTypeoutNextCharacterImpl = class("NewTypeoutNextCharacterImpl", objectlua.Object)
NewTypeoutNextCharacter = ccAction("TypeoutNextCharacter", NewTypeoutNextCharacterImpl)

function NewTypeoutNextCharacterImpl:initialize(interval, info, callfun)
	super.initialize(self)

	self._info = info
	self._callfun = callfun
end

function NewTypeoutNextCharacterImpl:startWithTarget(target)
	self._target = target
	self._richTextContentSize = self._target:getContentSize()
end

function NewTypeoutNextCharacterImpl:update(dt)
	if dt >= 1 then
		local function callFunc()
			self._target:clipContent(0, self._info.clipCount)
			self._target:renderContent(self._richTextContentSize.width, self._richTextContentSize.height, false)

			self._info.clipCount = self._info.clipCount + 1
		end

		callFunc()

		if self._callfun then
			self._callfun()
		end
	end
end

NewTypeWriterAction = cclass("NewTypeWriterAction", function(target, intervals, callfun)
	if type(intervals) == "table" then
		local actions = {}

		for i = 1, #intervals do
			local data = intervals[i]
			local beginI = data[1]
			local endI = data[2]

			if not data[3] then
				local speed = kTypeOutInterval
				local info = {
					clipCount = beginI
				}
				local count = target:getContentLength()
				local showNextCharacterAction = NewTypeoutNextCharacter:new(speed, info, callfun)

				actions[#actions + 1] = cc.Repeat:create(showNextCharacterAction, endI - beginI + 1)
			end
		end

		return cc.Sequence:create(actions)
	else
		local info = {
			clipCount = 1
		}
		local count = target:getContentLength()
		local showNextCharacterAction = NewTypeoutNextCharacter:new(intervals, info, callfun)

		return cc.Repeat:create(showNextCharacterAction, count)
	end
end)
CascadeFadeToImpl = class("CascadeFadeToImpl", objectlua.Object)
CascadeFadeTo = ccAction("CascadeFadeTo", CascadeFadeToImpl)

function CascadeFadeToImpl:initialize(duration, val)
	super.initialize(self)

	self._duration = duration
	self._finalAlpha = val
end

function CascadeFadeToImpl:clone()
	return CascadeFadeToImpl:new(self._duration, self._finalAlpha)
end

function CascadeFadeToImpl:reverse()
	return nil
end

function CascadeFadeToImpl:startWithTarget(target)
	self._target = target

	local color = self._target:getColorTransform()

	self._delta = self._finalAlpha - color.mults.w
end

function CascadeFadeToImpl:update(time)
	local color = self._target:getColorTransform()

	color.mults.w = self._finalAlpha - self._delta * (1 - time)

	self._target:setColorTransform(color)
end

RoundToImpl = class("RoundToImpl", objectlua.Object)
RoundTo = ccAction("RoundTo", RoundToImpl)

function RoundToImpl:initialize(duration, radio, target, radius, orgRadio, step, offset)
	super.initialize(self)

	self._duration = duration
	self._finalRadio = radio + orgRadio
	self._finalRadius = radius
	self._forcusTarget = target
	self._orgRadio = orgRadio
	self._step = step
	self._offset = offset
end

function RoundToImpl:clone()
	return RoundToImpl:new(self._duration, self._finalAlpha)
end

function RoundToImpl:reverse()
	return nil
end

function RoundToImpl:startWithTarget(target)
	self._target = target
	self._delta = self._finalRadio - self._orgRadio

	local radian = math.pi / 180 * self._orgRadio
	local offsetY = math.sin(radian) * self._finalRadius
	local offsetX = math.cos(radian) * self._finalRadius
	local x, y = self._forcusTarget:getPosition()
	local x = x + offsetX

	if self._offset then
		x = self._offset.x and self._offset.x + x or x
		y = self._offset.y and self._offset.y + y or y
	end

	local y = y + offsetY

	self._target:setPosition(x, y)
end

function RoundToImpl:update(time)
	local hudu = self._finalRadio - self._delta * (1 - time)
	local radian = math.pi / 180 * hudu
	local offsetY = math.sin(radian) * self._finalRadius
	local offsetX = math.cos(radian) * self._finalRadius
	local x, y = self._forcusTarget:getPosition()
	local x = x + offsetX
	local y = y + offsetY

	if self._offset then
		x = self._offset.x and self._offset.x + x or x
		y = self._offset.y and self._offset.y + y or y
	end

	self._target:setPosition(x, y)

	if self._step then
		self._step(hudu)
	end
end

PercentToImpl = class("PercentToImpl", objectlua.Object)
PercentTo = ccAction("PercentTo", PercentToImpl)

function PercentToImpl:initialize(duration, percent)
	super.initialize(self)

	self._duration = duration
	self._finalPercent = percent
end

function PercentToImpl:clone()
	return RoundToImpl:new(self._duration, self._finalAlpha)
end

function PercentToImpl:reverse()
	return nil
end

function PercentToImpl:startWithTarget(target)
	self._target = target
	self._orgPercent = target:getPercent()
	self._delta = self._finalPercent - self._orgPercent
end

function PercentToImpl:update(time)
	local percent = self._finalPercent - self._delta * (1 - time)

	self._target:setPercent(percent)
end

ContentSizeToImpl = class("ContentSizeToImpl", objectlua.Object)
ContentSizeTo = ccAction("ContentSizeTo", ContentSizeToImpl)

function ContentSizeToImpl:initialize(duration, val, call)
	super.initialize(self)

	self._duration = duration
	self._finalSize = val
	self._callback = call
end

function ContentSizeToImpl:clone()
	return ContentSizeToImpl:new(self._duration, self._finalSize)
end

function ContentSizeToImpl:reverse()
	return nil
end

function ContentSizeToImpl:startWithTarget(target)
	self._target = target

	local size = self._target:getContentSize()

	self._deltaX = self._finalSize.width - size.width
	self._deltaY = self._finalSize.height - size.height
end

function ContentSizeToImpl:update(time)
	local size = self._target:getContentSize()

	size.width = self._finalSize.width - self._deltaX * (1 - time)
	size.height = self._finalSize.height - self._deltaY * (1 - time)

	self._target:setContentSize(size)

	if self._callback then
		self._callback()
	end
end

OvalToImpl = class("OvalToImpl", objectlua.Object)
OvalTo = ccAction("OvalTo", OvalToImpl)

function OvalToImpl:initialize(times, config)
	super.initialize(self)

	self._key = config.key
	self._a = config.a
	self._b = config.b
	self._centerPos = config.centerPos
	self._moveClockDir = config.moveClockDir
	self._zOrder1 = config.zOrder1
	self._zOrder2 = config.zOrder2
	self._step = config.step
	self._dt = config.dt or 0
end

function OvalToImpl:clone()
	return OvalToImpl:new()
end

function OvalToImpl:reverse()
	return nil
end

function OvalToImpl:startWithTarget(target)
	self._target = target
end

function OvalToImpl:update(dt)
	if self._target then
		dt = dt + self._dt

		local x = self:getPosXAtOval(dt)
		local y = self:getPosYAtOval(dt)

		self._target:setPosition(cc.pAdd(self._centerPos, cc.p(x, y)))

		if self._zOrder2 and self._zOrder1 then
			if dt <= 0.5 then
				self._target:setLocalZOrder(self._zOrder2)
			else
				self._target:setLocalZOrder(self._zOrder1)
			end
		end

		if self._step then
			self._step(dt)
		end
	end
end

function OvalToImpl:getPosXAtOval(dt)
	if self._moveClockDir then
		return self._a * math.cos(4 * K_MATH_PIOVER2 * dt)
	else
		return self._a * math.cos(4 * K_MATH_PIOVER2 * (1 - dt))
	end
end

function OvalToImpl:getPosYAtOval(dt)
	if self._moveClockDir then
		return self._b * math.sin(4 * K_MATH_PIOVER2 * dt)
	else
		return self._b * math.sin(4 * K_MATH_PIOVER2 * (1 - dt))
	end
end
