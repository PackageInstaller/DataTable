-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/toasts/SimpleToast.lua

SimpleToast = class("SimpleToast", BaseToast, _M)

function SimpleToast:initialize(view)
	super.initialize(self, view)

	self._skip = false
end

function SimpleToast:getGroupName()
	return "simpletost"
end

function SimpleToast:getFrameRect()
	return
end

local _skip_tips = false

function SimpleToast:setup(parentLayer, parentFrame, options, activeToasts)
	self._duration = options.duration or 0.2
	self._delay = options.delay or 1
	self._options = options

	if options.once and _skip_tips then
		return
	end

	_skip_tips = true

	local view = self:getView()

	view:setCascadeOpacityEnabled(true)
	parentLayer:addChild(self:getView(), 1001)
	view:setPosition(0, 0)

	return true
end

function SimpleToast:startAnimation(endCallback)
	local view = self:getView()

	view:setOpacity(0)
	view:setPosition(0, 0)

	local inDuration = self._duration
	local moveUpAct = cc.MoveBy:create(inDuration, cc.p(0, 80))
	local fade_in = cc.FadeIn:create(inDuration)
	local moveFadeAct = cc.Spawn:create(moveUpAct, fade_in)
	local delayAction = cc.DelayTime:create(self._delay)
	local fade_out = cc.FadeOut:create(0.5)
	local callbackFunc = cc.CallFunc:create(function()
		view:removeFromParent()

		_skip_tips = false

		endCallback(self)
	end)
	local action = cc.Speed:create(cc.Sequence:create(moveFadeAct, delayAction, fade_out, callbackFunc), 1)

	view:runAction(action)
end

StaticToast = class("StaticToast", SimpleToast)

function StaticToast:startAnimation(endCallback)
	local view = self:getView()

	view:setPosition(0, -100)

	local delayAction = cc.DelayTime:create(self._delay)
	local callbackFunc = cc.CallFunc:create(function()
		view:removeFromParent()
		endCallback(self)
	end)

	if view.label and self._options.color then
		view.label:setColor(self._options.color)
	end

	view:runAction(cc.Sequence:create(delayAction, callbackFunc))

	local click = false

	view.touchNode:setTouchEnabled(true)
	view.touchNode:setSwallowTouches(true)
	view.touchNode:addClickEventListener(function()
		if click then
			view:removeFromParent()
			endCallback(self)

			return
		end

		view:stopAllActions()

		click = true
	end)
end

function ShowTipEvent(args)
	local text = args.tip
	local toastView = tipView(text)
	local toast = SimpleToast:new(toastView)

	return ToastEvent:new(EVT_SHOW_TOAST, toast, args)
end

function ShowTipEventOnce(args)
	local text = args.tip
	local toastView = tipView(text)
	local toast = SimpleToast:new(toastView)

	return ToastEvent:new(EVT_SHOW_TOAST, toast, args)
end

function ShowStaticTipEvent(args)
	local text = args.tip
	local toastView = tipView(text)
	local toast = StaticToast:new(toastView)

	return ToastEvent:new(EVT_SHOW_TOAST, toast, args)
end
