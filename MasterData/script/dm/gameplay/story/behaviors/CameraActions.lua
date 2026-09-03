-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/CameraActions.lua

module("story", package.seeall)

CameraMovingshot = class("CameraMovingshot", BaseAction)

function CameraMovingshot:initialize()
	super.initialize(self)
end

function CameraMovingshot:start(args)
	local context = self.context
	local scene = context:getScene()
	local focus = scene:getChildById(args.focus)

	if focus == nil then
		return BehaviorResult.Success
	end

	args.focus = focus

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	function args.onEnd()
		self:finish(BehaviorResult.Success)
	end

	actor:movingshot(args)
end

function CameraMovingshot:abort(result)
	return
end

CameraMoveTo = class("CameraMoveTo", BaseAction)

function CameraMoveTo:initialize()
	super.initialize(self)
end

function CameraMoveTo:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	function args.onEnd()
		self:finish(BehaviorResult.Success)
	end

	actor:moveTo(args)
end

CameraMoveBy = class("CameraMoveBy", BaseAction)

function CameraMoveBy:initialize()
	super.initialize(self)
end

function CameraMoveBy:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	function args.onEnd()
		self:finish(BehaviorResult.Success)
	end

	actor:moveBy(args)
end

CameraScaleTo = class("CameraScaleTo", BaseAction)

function CameraScaleTo:initialize()
	super.initialize(self)
end

function CameraScaleTo:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	function args.onEnd()
		self:finish(BehaviorResult.Success)
	end

	actor:scaleTo(args)
end
