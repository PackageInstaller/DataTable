-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/CCActionWrapper.lua

module("story", package.seeall)

__global_actions = __global_actions or {}

local function decorateCocosAction(decorate, action)
	if decorate == nil then
		return action
	end

	if action == nil then
		return
	end

	local type = decorate.type
	local args = {}

	if decorate.args then
		for key, value in pairs(decorate.args) do
			args[#args + 1] = value
		end
	end

	return cc[type]:create(action, unpack(args))
end

RunCocosAction = class("RunCocosAction", BaseAction)

function RunCocosAction:initialize(actionCreator)
	super.initialize(self)

	self._actionCreator = actionCreator
end

function RunCocosAction:start(args)
	if self._actionCreator == nil then
		return BehaviorResult.Success
	end

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local cocosAction = self._actionCreator(actor, args)

	if cocosAction == nil then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if renderNode == nil then
		return BehaviorResult.Success
	end

	local action = cc.Sequence:create(cocosAction, cc.CallFunc:create(function()
		self:finish(BehaviorResult.Success)

		self._runningAction = nil
	end))

	self._runningAction = decorateCocosAction(args.decorate, action)

	if self._runningAction then
		renderNode:runAction(self._runningAction)
	end
end

function RunCocosAction:abort(result)
	if self._runningAction then
		local actor = self:getActor()
		local renderNode = actor:getRenderNode()

		renderNode:stopAction(self._runningAction)

		self._runningAction = nil
	end

	super.abort(self, result)
end

RunRepeatAction = class("RunRepeatAction", BaseAction)

function RunRepeatAction:initialize(actionCreator)
	super.initialize(self)

	self._actionCreator = actionCreator
end

function RunRepeatAction:start(args)
	if self._actionCreator == nil then
		return BehaviorResult.Success
	end

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if renderNode == nil then
		return BehaviorResult.Success
	end

	local cocosAction = self._actionCreator(actor, args)

	if cocosAction == nil then
		return BehaviorResult.Success
	end

	renderNode:runAction(decorateCocosAction(args.decorate, cocosAction))

	return BehaviorResult.Success
end

function RunRepeatAction:abort(result)
	super.abort(self, result)
end

StopRepeatAction = class("StopRepeatAction", BaseAction)

function StopRepeatAction:initialize(actionCreator)
	super.initialize(self)

	self._actionCreator = actionCreator
end

function StopRepeatAction:start(args)
	if self._actionCreator == nil then
		return BehaviorResult.Success
	end

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	self._actionCreator(actor, args)

	return BehaviorResult.Success
end

function StopRepeatAction:abort(result)
	super.abort(self, result)
end

__global_actions.moveTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		local renderNode = actor:getRenderNode()

		if renderNode == nil then
			return
		end

		local parentNode = renderNode:getParent()
		local parentSize = parentNode and parentNode:getContentSize()
		local position = calcPosition(args.position, parentSize)

		if position == nil then
			return
		end

		return cc.MoveTo:create(args.duration or 0, position)
	end)
end)
__global_actions.moveBy = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return cc.MoveBy:create(args.duration, args.deltaPosition)
	end)
end)
__global_actions.bezierTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		if args.bezier and #args.bezier == 3 then
			local renderNode = actor:getRenderNode()

			if renderNode == nil then
				return
			end

			local parentNode = renderNode:getParent()
			local parentSize = parentNode and parentNode:getContentSize()
			local bezier = {}

			for _, point in ipairs(args.bezier) do
				bezier[#bezier + 1] = calcPosition(point, parentSize)
			end

			return cc.BezierTo:create(args.duration, bezier)
		end
	end)
end)
__global_actions.bezierBy = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return cc.BezierBy:create(args.duration, args.deltaBezier)
	end)
end)
__global_actions.scaleTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return cc.ScaleTo:create(args.duration, args.scale)
	end)
end)
__global_actions.scaleBy = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return cc.ScaleBy:create(args.duration, args.deltaScale)
	end)
end)
__global_actions.rotateTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return cc.RotateTo:create(args.duration, args.angle)
	end)
end)
__global_actions.rotateBy = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return cc.RotateBy:create(args.duration, args.deltaAngle)
	end)
end)
__global_actions.fadeTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		local opacity = 255 * args.opacity

		return cc.FadeTo:create(args.duration, opacity)
	end)
end)
__global_actions.fadeIn = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		local callFuncAct = cc.CallFunc:create(function()
			if actor then
				local renderNode = actor:getRenderNode()

				if renderNode then
					renderNode:setOpacity(0)
				end
			end
		end)
		local fadeInAct = cc.FadeIn:create(args.duration)

		if args.delay then
			local delayAct = cc.DelayTime:create(args.delay)

			return cc.Sequence:create(callFuncAct, delayAct, fadeInAct)
		end

		return cc.Sequence:create(callFuncAct, fadeInAct)
	end)
end)
__global_actions.fadeOut = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		local callFuncAct = cc.CallFunc:create(function()
			if actor then
				local renderNode = actor:getRenderNode()

				if renderNode then
					renderNode:setOpacity(255)
				end
			end
		end)
		local fadeOutAct = cc.FadeOut:create(args.duration)

		if args.delay then
			local delayAct = cc.DelayTime:create(args.delay)

			return cc.Sequence:create(callFuncAct, delayAct, fadeOutAct)
		end

		return cc.Sequence:create(callFuncAct, fadeOutAct)
	end)
end)
__global_actions.opacityTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		if actor then
			local renderNode = actor:getRenderNode()

			if renderNode and (args.valbegin or args.valbegin == 0) then
				renderNode:setOpacity(args.valbegin)
			end
		end

		return cc.FadeTo:create(args.duration, args.valend)
	end)
end)
__global_actions.brightnessTo = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return BrightnessTo:create(args.duration, args.brightness)
	end)
end)
__global_actions.rock = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		return RockAction:create(args.freq, args.strength)
	end)
end)
__global_actions.orbitCamera = ACTION(function()
	return RunCocosAction:new(function(actor, args)
		if not args.time then
			if not args.angleZ then
				local angleZ = 0

				if not args.deltaAngleZ then
					local deltaAngleZ = 0

					if not args.angleX then
						local angleX = 0

						if not args.deltaAngleX then
							local deltaAngleX = 0

							if not args.radius then
								local radius = 1

								if not args.deltaRadius then
									local deltaRadius = 0

									return cc.OrbitCamera:create(args.time, radius, deltaRadius, angleZ, deltaAngleZ, angleX, deltaAngleX)
								end
							end
						end
					end
				end
			end
		end
	end)
end)

local repeatRockActionTag = 90909

__global_actions.repeatRockStart = ACTION(function()
	return RunRepeatAction:new(function(actor, args)
		local renderNode = actor:getRenderNode()

		if renderNode:getActionByTag(repeatRockActionTag) then
			renderNode:stopActionByTag(repeatRockActionTag)
		end

		local rockAction = RockAction:create(args.freq, args.strength)
		local action = cc.RepeatForever:create(rockAction)

		action:setTag(repeatRockActionTag)

		return action
	end)
end)
__global_actions.repeatRockEnd = ACTION(function()
	return StopRepeatAction:new(function(actor, args)
		local renderNode = actor:getRenderNode()

		if renderNode:getActionByTag(repeatRockActionTag) then
			renderNode:stopActionByTag(repeatRockActionTag)
		end
	end)
end)

local repeatUpDownActionTag = 90910

__global_actions.repeatUpDownStart = ACTION(function()
	return RunRepeatAction:new(function(actor, args)
		local renderNode = actor:getRenderNode()

		if renderNode:getActionByTag(repeatUpDownActionTag) then
			renderNode:stopActionByTag(repeatUpDownActionTag)
		end

		local rockAction = UpDownAction:create(args.duration, args.height)
		local action = cc.RepeatForever:create(rockAction)

		action:setTag(repeatUpDownActionTag)

		return action
	end)
end)
__global_actions.repeatUpDownEnd = ACTION(function()
	return StopRepeatAction:new(function(actor, args)
		local renderNode = actor:getRenderNode()

		if renderNode:getActionByTag(repeatUpDownActionTag) then
			renderNode:stopActionByTag(repeatUpDownActionTag)
		end
	end)
end)
