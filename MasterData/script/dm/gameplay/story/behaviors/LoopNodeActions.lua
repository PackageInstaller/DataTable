-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/LoopNodeActions.lua

module("story", package.seeall)

LoopNodePlay = class("LoopNodePlay", BaseAction)

function LoopNodePlay:start(args)
	local actor = self:getActor()

	if actor then
		actor:play()
	end

	return BehaviorResult.Success
end

LoopNodeStop = class("LoopNodeStop", BaseAction)

function LoopNodeStop:start(args)
	local actor = self:getActor()

	if actor then
		actor:stop()
	end

	return BehaviorResult.Success
end

LoopNodePause = class("LoopNodePause", BaseAction)

function LoopNodePause:start(args)
	local actor = self:getActor()

	if actor then
		actor:pause()
	end

	return BehaviorResult.Success
end

LoopNodeResume = class("LoopNodeResume", BaseAction)

function LoopNodeResume:start(args)
	local actor = self:getActor()

	if actor then
		actor:resume()
	end

	return BehaviorResult.Success
end

LoopNodeReverse = class("LoopNodeReverse", BaseAction)

function LoopNodeReverse:start(args)
	local actor = self:getActor()

	if actor then
		actor:reverse()
	end

	return BehaviorResult.Success
end
