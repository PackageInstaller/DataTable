-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/VideoPlayerAction.lua

module("story", package.seeall)

VideoPlayAction = class("VideoPlayAction", BaseAction)

function VideoPlayAction:initialize()
	super.initialize(self)
end

function VideoPlayAction:start(args)
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:play(function()
		renderNode:setVisible(false)
		self:finish(BehaviorResult.Success)
	end)
end

function VideoPlayAction:abort(result)
	super.abort(self, result)

	actor = self:getActor()

	local renderNode = actor:getRenderNode()

	if actor and renderNode then
		renderNode:stop()
	end
end

VideoStopAction = class("VideoStopAction", BaseAction)

function VideoStopAction:initialize()
	super.initialize(self)
end

function VideoStopAction:start(args)
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
