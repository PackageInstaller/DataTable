-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/AnimationAction.lua

module("story", package.seeall)

PlayAnimationAction = class("PlayAnimationAction", BaseAction)

function PlayAnimationAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:play(args.name, args.loop, args.frame, function(event)
		if event == "complete" then
			return self:finish(BehaviorResult.Success)
		end
	end)
end

function PlayAnimationAction:abort(result)
	local actor = self:getActor()

	if actor then
		actor:stop()
	end

	super.abort(self, result)
end

StopAnimationAction = class("StopAnimationAction", BaseAction)

function StopAnimationAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:stop()

	return BehaviorResult.Success
end

PauseAnimationAction = class("PauseAnimationAction", BaseAction)

function PauseAnimationAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:pause()

	return BehaviorResult.Success
end

ResumeAnimationAction = class("ResumeAnimationAction", BaseAction)

function ResumeAnimationAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:resume()

	return BehaviorResult.Success
end

FreezeAnimationAction = class("FreezeAnimationAction", BaseAction)

function FreezeAnimationAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:freezeFrame(args.frame)

	return BehaviorResult.Success
end

PlayWithFrameAnimationAction = class("PlayWithFrameAnimationAction", BaseAction)

function PlayWithFrameAnimationAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:playWithFrame(args.startFrame, args.endFrame, args.speed, function(event)
		if event == "complete" then
			self:finish(BehaviorResult.Success)
		end
	end, args.name)
end
