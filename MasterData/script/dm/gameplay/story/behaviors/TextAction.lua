-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/TextAction.lua

module("story", package.seeall)

TypeOutAction = class("TypeOutAction", BaseAction)

function TypeOutAction:initialize()
	super.initialize(self)
end

function TypeOutAction:start(args)
	local action = self
	local actor = self:getActor()

	if not actor then
		return BehaviorResult.Success
	end

	local renderNode = actor:getRenderNode()

	if not renderNode then
		return BehaviorResult.Success
	end

	actor:typeOut(args.interval, args.content, function()
		action:finish(BehaviorResult.Success)
	end)
end

function TypeOutAction:abort(result)
	actor = self:getActor()

	local renderNode = actor:getRenderNode()

	if actor and renderNode then
		renderNode:stopAllActions()

		renderNode.callFunc = nil
	end

	super.abort(self, result)
end

SetTextAction = class("SetTextAction", BaseAction)

function SetTextAction:start(args)
	if not args.content then
		local actor = self:getActor()

		if not actor then
			return BehaviorResult.Success
		end

		local renderNode = actor:getRenderNode()

		if not renderNode then
			return BehaviorResult.Success
		end

		local size = renderNode:getContentSize()

		renderNode:setString(args.content)
		renderNode:renderContent(size.width, 0, true)

		return BehaviorResult.Success
	end
end
