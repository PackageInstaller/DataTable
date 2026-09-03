-- chunkname: @/tmp/or_script/lua_compile/dragon/behavior/BehaviorNodeFactory.lua

BehaviorNodeFactory = class("BehaviorNodeFactory", objectlua.Object, _M)

function BehaviorNodeFactory:initialize()
	self.creatorMap = {
		seq = self.create_sequence,
		sel = self.create_selector,
		parallel_seq = self.create_parallel_sequence,
		parallel_sel = self.create_parallel_selector,
		repeat_while = self.create_repeat_node,
		delay = self.create_delay_node,
		cond = self.create_condition_node,
		result_converter = self.create_result_converter_node,
		call = self.create_call_node
	}
end

function BehaviorNodeFactory:addActionCreator(typeString, creator)
	self.creatorMap[typeString] = creator
end

function BehaviorNodeFactory:extentByActionCreaterMap(actionMap)
	for k, creator in pairs(actionMap) do
		if type(creator) == "function" then
			self.creatorMap[k] = creator
		end
	end
end

function BehaviorNodeFactory:createAction(config)
	if config == nil then
		return nil
	end

	local creator = self.creatorMap[config.type]

	if creator ~= nil then
		return creator(self, config)
	else
		return nil
	end
end

function BehaviorNodeFactory:arrIterator(configArr)
	local function f(ctx, ctrlVar)
		local action

		while action == nil do
			ctrlVar = ctrlVar + 1

			if ctrlVar > #configArr then
				return
			else
				action = self:createAction(configArr[ctrlVar])
			end
		end

		return ctrlVar, action
	end

	return f, 0
end

function BehaviorNodeFactory:create_sequence(config)
	assert(config.type == "seq")

	return SequenceBehavior:new(self:arrIterator(config.subActions))
end

function BehaviorNodeFactory:create_selector(config)
	assert(config.type == "sel")

	return SelectorBehavior:new(self:arrIterator(config.subActions))
end

function BehaviorNodeFactory:create_parallel_sequence(config)
	assert(config.type == "parallel_seq")

	return ParallelSequenceBehavior:new(self:arrIterator(config.subActions))
end

function BehaviorNodeFactory:create_parallel_selector(config)
	assert(config.type == "parallel_sel")

	return ParallelSelectorBehavior:new(self:arrIterator(config.subActions))
end

function BehaviorNodeFactory:create_repeat_node(config)
	assert(config.type == "repeat_while")

	local subAction = self:createAction(config.action)

	return RepeatNode:new(subAction, config.cond)
end

function BehaviorNodeFactory:create_delay_node(config)
	assert(config.type == "delay")

	local subAction

	if config.action ~= nil then
		subAction = self:createAction(config.action)
	end

	if subAction == nil then
		subAction = EmptyBehaviorNode:new()
	end

	if subAction ~= nil then
		return DelayBehaviorNode:new(subAction, config.delay)
	else
		return nil
	end
end

function BehaviorNodeFactory:create_condition_node(config)
	assert(config.type == "cond")

	local subAction

	if config.action ~= nil then
		subAction = self:createAction(config.action)
	end

	if subAction ~= nil then
		return ConditionalBehaviorNode:new(subAction, config.cond, config.failResult)
	else
		return nil
	end
end

function BehaviorNodeFactory:create_result_converter_node(config)
	assert(config.type == "result_converter")

	local subAction

	if config.action ~= nil then
		subAction = self:createAction(config.action)
	end

	if subAction ~= nil then
		return ConvertResultNode:new(subAction, config.converter)
	else
		return nil
	end
end

function BehaviorNodeFactory:create_call_node(config)
	assert(config.type == "call")

	return CallFuncBehaviorNode:new(config.callback)
end
