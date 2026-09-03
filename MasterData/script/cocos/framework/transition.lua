-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/transition.lua

local transition = {}
local ACTION_EASING = {}

ACTION_EASING.BACKIN = {
	cc.EaseBackIn,
	1
}
ACTION_EASING.BACKINOUT = {
	cc.EaseBackInOut,
	1
}
ACTION_EASING.BACKOUT = {
	cc.EaseBackOut,
	1
}
ACTION_EASING.BOUNCE = {
	cc.EaseBounce,
	1
}
ACTION_EASING.BOUNCEIN = {
	cc.EaseBounceIn,
	1
}
ACTION_EASING.BOUNCEINOUT = {
	cc.EaseBounceInOut,
	1
}
ACTION_EASING.BOUNCEOUT = {
	cc.EaseBounceOut,
	1
}
ACTION_EASING.ELASTIC = {
	cc.EaseElastic,
	2,
	0.3
}
ACTION_EASING.ELASTICIN = {
	cc.EaseElasticIn,
	2,
	0.3
}
ACTION_EASING.ELASTICINOUT = {
	cc.EaseElasticInOut,
	2,
	0.3
}
ACTION_EASING.ELASTICOUT = {
	cc.EaseElasticOut,
	2,
	0.3
}
ACTION_EASING.EXPONENTIALIN = {
	cc.EaseExponentialIn,
	1
}
ACTION_EASING.EXPONENTIALINOUT = {
	cc.EaseExponentialInOut,
	1
}
ACTION_EASING.EXPONENTIALOUT = {
	cc.EaseExponentialOut,
	1
}
ACTION_EASING.IN = {
	cc.EaseIn,
	2,
	1
}
ACTION_EASING.INOUT = {
	cc.EaseInOut,
	2,
	1
}
ACTION_EASING.OUT = {
	cc.EaseOut,
	2,
	1
}
ACTION_EASING.RATEACTION = {
	cc.EaseRateAction,
	2,
	1
}
ACTION_EASING.SINEIN = {
	cc.EaseSineIn,
	1
}
ACTION_EASING.SINEINOUT = {
	cc.EaseSineInOut,
	1
}
ACTION_EASING.SINEOUT = {
	cc.EaseSineOut,
	1
}

local actionManager = cc.Director:getInstance():getActionManager()

function transition.newEasing(action, easingName, more)
	local key = string.upper(tostring(easingName))
	local easing

	if ACTION_EASING[key] then
		local cls, count, default = unpack(ACTION_EASING[key])

		easing = count == 2 and cls:create(action, more or default) or cls:create(action)
	end

	return easing or action
end

function transition.create(action, args)
	args = checktable(args)

	if args.easing then
		action = type(args.easing) == "table" and transition.newEasing(action, unpack(args.easing)) or transition.newEasing(action, args.easing)
	end

	local actions = {}
	local delay = checknumber(args.delay)

	if delay > 0 then
		actions[#actions + 1] = cc.DelayTime:create(delay)
	end

	actions[#actions + 1] = action

	local onComplete = args.onComplete

	if type(onComplete) ~= "function" then
		onComplete = nil
	end

	if onComplete then
		actions[#actions + 1] = cc.CallFunc:create(onComplete)
	end

	if args.removeSelf then
		actions[#actions + 1] = cc.RemoveSelf:create()
	end

	if #actions > 1 then
		return transition.sequence(actions)
	else
		return actions[1]
	end
end

function transition.execute(target, action, args)
	assert(not tolua.isnull(target), "transition.execute() - target is not cc.Node")

	local action = transition.create(action, args)

	target:runAction(action)

	return action
end

function transition.moveTo(target, args)
	assert(not tolua.isnull(target), "transition.moveTo() - target is not cc.Node")

	if not args.x then
		local x = target:getPositionX()

		if not args.y then
			local y = target:getPositionY()
			local action = cc.MoveTo:create(args.time, cc.p(x, y))

			return transition.execute(target, action, args)
		end
	end
end

function transition.moveBy(target, args)
	assert(not tolua.isnull(target), "transition.moveBy() - target is not cc.Node")

	if not args.x then
		local x = 0

		if not args.y then
			local y = 0
			local action = cc.MoveBy:create(args.time, cc.p(x, y))

			return transition.execute(target, action, args)
		end
	end
end

function transition.fadeIn(target, args)
	assert(not tolua.isnull(target), "transition.fadeIn() - target is not cc.Node")

	local action = cc.FadeIn:create(args.time)

	return transition.execute(target, action, args)
end

function transition.fadeOut(target, args)
	assert(not tolua.isnull(target), "transition.fadeOut() - target is not cc.Node")

	local action = cc.FadeOut:create(args.time)

	return transition.execute(target, action, args)
end

function transition.fadeTo(target, args)
	assert(not tolua.isnull(target), "transition.fadeTo() - target is not cc.Node")

	local opacity = checkint(args.opacity)

	if opacity < 0 then
		opacity = 0
	elseif opacity > 255 then
		opacity = 255
	end

	local action = cc.FadeTo:create(args.time, opacity)

	return transition.execute(target, action, args)
end

function transition.scaleTo(target, args)
	assert(not tolua.isnull(target), "transition.scaleTo() - target is not cc.Node")

	local action

	if args.scale then
		action = cc.ScaleTo:create(checknumber(args.time), checknumber(args.scale))
	elseif args.scaleX or args.scaleY then
		local scaleX, scaleY

		scaleX = args.scaleX and checknumber(args.scaleX) or target:getScaleX()
		action = cc.ScaleTo:create(checknumber(args.time), scaleX, args.scaleY and checknumber(args.scaleY) or target:getScaleY())
	end

	return transition.execute(target, action, args)
end

function transition.rotateTo(target, args)
	assert(not tolua.isnull(target), "transition.rotateTo() - target is not cc.Node")

	if not args.rotation then
		local rotation = target:getRotation()
		local action = cc.RotateTo:create(args.time, rotation)

		return transition.execute(target, action, args)
	end
end

function transition.rotateBy(target, args)
	assert(not tolua.isnull(target), "transition.rotateTo() - target is not cc.Node")

	if not args.rotation then
		local rotation = 0
		local action = cc.RotateBy:create(args.time, rotation)

		return transition.execute(target, action, args)
	end
end

function transition.sequence(actions)
	if #actions < 1 then
		return
	end

	if #actions < 2 then
		return actions[1]
	end

	return cc.Sequence:create(actions)
end

function transition.removeAction(action)
	if not tolua.isnull(action) then
		actionManager:removeAction(action)
	end
end

function transition.stopTarget(target)
	if not tolua.isnull(target) then
		actionManager:removeAllActionsFromTarget(target)
	end
end

function transition.pauseTarget(target)
	if not tolua.isnull(target) then
		actionManager:pauseTarget(target)
	end
end

function transition.resumeTarget(target)
	if not tolua.isnull(target) then
		actionManager:resumeTarget(target)
	end
end

return transition
