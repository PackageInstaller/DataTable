-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/RoleNodeActions.lua

module("story", package.seeall)

RoleMoveTo = class("RoleMoveTo", BaseAction)

function RoleMoveTo:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local actorRenderNode = actor:getRenderNode()

	if actorRenderNode == nil then
		return BehaviorResult.Success
	end

	local actorParentNode = actorRenderNode:getParent()
	local parentSize = actorParentNode and actorParentNode:getContentSize()
	local position = calcPosition(args.position, parentSize)

	if args.duration then
		actor:moveWithDuration(position, args.duration, args.spineAnim, function(event)
			self:finish(BehaviorResult.Success)
		end)
	else
		actor:moveWithSpeed(position, args.speed, args.spineAnim, function(event)
			self:finish(BehaviorResult.Success)
		end)
	end
end

RoleMoveBy = class("RoleMoveBy", BaseAction)

function RoleMoveBy:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local actorRenderNode = actor:getRenderNode()

	if actorRenderNode == nil then
		return BehaviorResult.Success
	end

	local actorPosition = cc.p(actorRenderNode:getPosition())

	args.deltaPosition.x = args.deltaPosition.x or 0
	args.deltaPosition.y = args.deltaPosition.y or 0

	local position = cc.pAdd(actorPosition, args.deltaPosition)

	if args.duration then
		actor:moveWithDuration(position, args.duration, args.spineAnim, function(event)
			self:finish(BehaviorResult.Success)
		end)
	else
		actor:moveWithSpeed(position, args.speed, args.spineAnim, function(event)
			self:finish(BehaviorResult.Success)
		end)
	end
end
