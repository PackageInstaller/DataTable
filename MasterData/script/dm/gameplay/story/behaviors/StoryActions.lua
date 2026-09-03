-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/StoryActions.lua

module("story", package.seeall)

BaseAction = class("BaseAction", BaseBehaviorNode)

function BaseAction:getActor()
	if self._actor == nil and self._actorGetter ~= nil then
		self._actor = self._actorGetter(self.context)
	end

	return self._actor
end

function BaseAction:setActor(actor)
	self._actor = nil

	if type(actor) == "function" then
		self._actorGetter = actor
	else
		self._actor = actor
	end

	return self
end

function BaseAction:getArgs()
	return self._argsFunc and self._argsFunc(self.context) or {}
end

function BaseAction:setArgs(args)
	self._argsFunc = args ~= nil and (type(args) == "function" and args or function()
		return args
	end) or nil

	return self
end

function BaseAction:run(ctx, onFinish)
	self._isRunning = true
	self.context = ctx
	self.onFinish = onFinish

	local args = self:getArgs()

	if args.complexityNum and args.complexityNum > tonumber(self.context:getComplexNum()) then
		self:finish(BehaviorResult.Success)

		return
	end

	local result = self:start(args)

	if result ~= nil then
		self:finish(result)
	end
end

function BaseAction:start(args)
	return BehaviorResult.Success
end

InvokeAction = class("InvokeAction", BaseAction)

local function getActionDefinitionForActor(actor, name)
	local actionDefinition = actor:getActionDefinition(name)

	if actionDefinition ~= nil then
		return actionDefinition
	end

	local globals = __global_actions

	return globals and globals[name]
end

function InvokeAction:initialize(actionName)
	super.initialize(self, config)

	self._actionName = actionName
end

function InvokeAction:createTargetAction(actor, args)
	local actionDef = getActionDefinitionForActor(actor, self._actionName)

	if actionDef == nil then
		return nil
	end

	if type(actionDef) == "function" then
		return actionDef(actor, args)
	else
		return actionDef:new():setActor(actor):setArgs(args)
	end
end

function InvokeAction:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local action = self:createTargetAction(actor, args)

	if action == nil then
		return BehaviorResult.Success
	end

	self._action = action

	action:run(self.context, function(target, result)
		self._action = nil

		return self:finish(BehaviorResult.Success)
	end)
end

function InvokeAction:abort(result)
	if self._action ~= nil then
		self._action:abort()

		self._action = nil
	end

	super.abort(self, result)
end

function sandbox.invoke(config)
	assert(config.action ~= nil, "No action name")

	return InvokeAction:new(config.action):setActor(config.actor):setArgs(config.args)
end

function sandbox.act(config)
	local who, doWhat, argsEvaluator = config.actor, config.action, config.args

	return InvokeAction:new(doWhat):setActor(who):setArgs(argsEvaluator)
end

function ACTION(createFunc)
	return {
		new = function(_, ...)
			return createFunc(...)
		end
	}
end
