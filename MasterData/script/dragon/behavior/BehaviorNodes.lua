-- chunkname: @/tmp/or_script/lua_compile/dragon/behavior/BehaviorNodes.lua

BehaviorResult = {
	Failed = 1,
	Success = 0
}
BaseBehaviorNode = class("BaseBehaviorNode", objectlua.Object, _M)

function BaseBehaviorNode:initialize()
	super.initialize(self)
end

function BaseBehaviorNode:isRunning()
	return self._isRunning
end

function BaseBehaviorNode:run(ctx, onFinish)
	self._isRunning = true
	self.context = ctx
	self.onFinish = onFinish

	local result = self:start()

	if result ~= nil then
		self:finish(result)
	end
end

function BaseBehaviorNode:setOnAbortFunc(onAbort)
	self.onAbort = onAbort
end

function BaseBehaviorNode:abort(result)
	if self:isRunning() then
		if result ~= nil then
			if result == true then
				result = BehaviorResult.Success
			elseif result == false then
				result = BehaviorResult.Failed
			end

			self:finish(result)
		else
			self.context = nil
			self._isRunning = false
		end

		if self.onAbort then
			self:onAbort()
		end
	end
end

function BaseBehaviorNode:start()
	return BehaviorResult.Success
end

function BaseBehaviorNode:finish(result)
	if self:isRunning() then
		self.context = nil
		self._isRunning = false

		local onFinish = self.onFinish

		self.onFinish = nil

		if onFinish ~= nil then
			self:onFinish(result)
		end
	end
end

function iactions(actionArr)
	assert(actionArr ~= nil)

	local function f(ctx, i)
		i = i + 1

		if i > #actionArr then
			return
		end

		return i, actionArr[i]
	end

	return f, 0
end

CompositeBehaviorNode = class("CompositeBehaviorNode", BaseBehaviorNode, _M)

function CompositeBehaviorNode:initialize(iterFunc, ctrlVarInitValue)
	super.initialize(self)
	assert(iterFunc ~= nil)

	self._iterFunc = iterFunc
	self._ctrlVarInitValue = ctrlVarInitValue
end

function CompositeBehaviorNode:start()
	super.start(self)
	self:resetIterator()
end

function CompositeBehaviorNode:resetIterator()
	self._ctrlVar = self._ctrlVarInitValue
end

function CompositeBehaviorNode:next()
	if self._iterFunc ~= nil then
		local action

		while action == nil do
			self._ctrlVar, action = self._iterFunc(self.context, self._ctrlVar)

			if self._ctrlVar == nil then
				return nil
			end
		end

		return action
	else
		return nil
	end
end

SequenceBehavior = class("SequenceBehavior", CompositeBehaviorNode, _M)

function SequenceBehavior:initialize(iterFunc, ctrlVarInitValue)
	super.initialize(self, iterFunc, ctrlVarInitValue)
end

function SequenceBehavior:start()
	super.start(self)
	self:runNext()
end

function SequenceBehavior:runNext()
	self.current = self:next()

	if self.current ~= nil then
		local function checkCurrentResult(target, result)
			assert(result ~= nil)

			if result == BehaviorResult.Success then
				self:runNext()
			else
				self:finish(BehaviorResult.Failed)
			end
		end

		self.current:run(self.context, checkCurrentResult)
	else
		self:finish(BehaviorResult.Success)
	end
end

function SequenceBehavior:abort(result)
	if self.current ~= nil then
		self.current:abort()

		self.current = nil
	end

	super.abort(self, result)
end

SelectorBehavior = class("SelectorBehavior", CompositeBehaviorNode, _M)

function SelectorBehavior:initialize(iterFunc, ctrlVarInitValue)
	super.initialize(self, iterFunc, ctrlVarInitValue)
end

function SelectorBehavior:start()
	super.start(self)
	self:runNext()
end

function SelectorBehavior:runNext()
	self.current = self:next()

	if self.current ~= nil then
		local function checkCurrentResult(target, result)
			assert(result ~= nil)

			if result == BehaviorResult.Success then
				self:finish(BehaviorResult.Success)
			else
				self:runNext()
			end
		end

		self.current:run(self.context, checkCurrentResult)
	else
		self:finish(BehaviorResult.Failed)
	end
end

function SelectorBehavior:abort(result)
	if self.current ~= nil then
		self.current:abort()

		self.current = nil
	end

	super.abort(self, result)
end

ParallelBehaviorNode = class("ParallelBehaviorNode", CompositeBehaviorNode, _M)

function ParallelBehaviorNode:initialize(iterFunc, ctrlVarInitValue)
	super.initialize(self, iterFunc, ctrlVarInitValue)
end

function ParallelBehaviorNode:cacheSubnode(node)
	self.order = (self.order or 0) + 1

	if self.current == nil then
		self.current = {}
	end

	self.current[node] = self.order
end

function ParallelBehaviorNode:runAllSubnodes(onFinish)
	if self.current ~= nil then
		local toRun = {}
		local minOrder, maxOrder
		local node = next(self.current)

		assert(node ~= nil, "At least one child node expected")

		while node ~= nil do
			local index = self.current[node]

			toRun[index] = node

			if minOrder == nil or index < minOrder then
				minOrder = index
			end

			if maxOrder == nil or maxOrder < index then
				maxOrder = index
			end

			node = next(self.current, node)
		end

		if minOrder ~= nil then
			for i = minOrder, maxOrder do
				node = toRun[i]

				if toRun[i] ~= nil then
					node:run(self.context, onFinish)
				end
			end
		end
	end
end

function ParallelBehaviorNode:removeSubnode(node)
	if self.current ~= nil then
		self.current[node] = nil
	end
end

function ParallelBehaviorNode:hasRunningNodes()
	return self.current ~= nil and next(self.current) ~= nil
end

function ParallelBehaviorNode:finish(result)
	self:_abortRunningSubnodes()
	super.finish(self, result)
end

function ParallelBehaviorNode:abort(result)
	self:_abortRunningSubnodes()
	super.abort(self, result)
end

function ParallelBehaviorNode:_abortRunningSubnodes()
	if self.current ~= nil then
		local node = next(self.current)

		while node ~= nil do
			node:abort()

			node = next(self.current, node)
		end

		self.current = nil
	end
end

ParallelSelectorBehavior = class("ParallelSelectorBehavior", ParallelBehaviorNode, _M)

function ParallelSelectorBehavior:start()
	super.start(self)

	local nextnode = self:next()

	if nextnode ~= nil then
		while nextnode ~= nil do
			self:cacheSubnode(nextnode)

			nextnode = self:next()
		end

		local function checkResult(target, result)
			assert(result ~= nil)
			self:removeSubnode(target)

			if result == BehaviorResult.Failed then
				self:finish(BehaviorResult.Failed)
			elseif not self:hasRunningNodes() then
				self:finish(BehaviorResult.Success)
			end
		end

		self:runAllSubnodes(checkResult)
	else
		self:finish(BehaviorResult.Success)
	end
end

ParallelSequenceBehavior = class("ParallelSequenceBehavior", ParallelBehaviorNode, _M)

function ParallelSequenceBehavior:start()
	super.start(self)

	local nextnode = self:next()

	if nextnode ~= nil then
		while nextnode ~= nil do
			self:cacheSubnode(nextnode)

			nextnode = self:next()
		end

		local function checkResult(target, result)
			assert(result ~= nil)
			self:removeSubnode(target)

			if result == BehaviorResult.Success then
				self:finish(BehaviorResult.Success)
			elseif not self:hasRunningNodes() then
				self:finish(BehaviorResult.Failed)
			end
		end

		self:runAllSubnodes(checkResult)
	else
		self:finish(BehaviorResult.Failed)
	end
end

DecorateBehaviorNode = class("DecorateBehaviorNode", BaseBehaviorNode, _M)

function DecorateBehaviorNode:initialize(decoratedNode)
	assert(decoratedNode ~= nil)
	super.initialize(self)

	self.decoratedNode = decoratedNode
end

function DecorateBehaviorNode:start()
	self.decoratedNode:run(self.context, function(node, result)
		self:finish(result)
	end)
end

function DecorateBehaviorNode:abort(result)
	if self:isRunning() then
		self.decoratedNode:abort()
		super.abort(self, result)
	end
end

ConditionalBehaviorNode = class("ConditionalBehaviorNode", DecorateBehaviorNode, _M)

function ConditionalBehaviorNode:initialize(subnode, preCondition, resultWhenTestFailed)
	super.initialize(self, subnode)

	self.preCondition = preCondition
	self.defaultResult = resultWhenTestFailed
end

function ConditionalBehaviorNode:start()
	local passed, result = false

	if self.preCondition ~= nil then
		passed, result = self.preCondition(self.context)
	end

	if passed then
		return super.start(self)
	else
		local var_41_0

		if not result then
			::label_41_0::

			var_41_0 = self.defaultResult or BehaviorResult.Success
		end

		return var_41_0
	end
end

DelayBehaviorNode = class("DelayBehaviorNode", DecorateBehaviorNode, _M)

function DelayBehaviorNode:initialize(subnode, delayMilliseconds)
	super.initialize(self, subnode)

	self.delayMilliseconds = delayMilliseconds or 0
end

function DelayBehaviorNode:start()
	if self.delayMilliseconds <= 0 then
		return super.start(self)
	else
		self.isWaiting = true

		delayCallByTime(self.delayMilliseconds, function()
			if self.isWaiting then
				self.isWaiting = nil

				local result = super.start(self)

				if result ~= nil then
					self:finish(result)
				end
			end
		end)
	end
end

function DelayBehaviorNode:abort(result)
	self.isWaiting = false

	super.abort(self, result)
end

ConvertResultNode = class("ConvertResultNode", DecorateBehaviorNode, _M)

function ConvertResultNode:initialize(subnode, resultConverter)
	super.initialize(self, subnode)

	self.resultConverter = resultConverter
end

function ConvertResultNode:convertResult(originalResult)
	if self.resultConverter then
		return self.resultConverter(originalResult) or BehaviorResult.Success
	else
		return BehaviorResult.Success
	end
end

function ConvertResultNode:start()
	self.decoratedNode:run(self.context, function(node, result)
		self:finish(self:convertResult(result))
	end)
end

RepeatNode = class("RepeatNode", SequenceBehavior, _M)

function RepeatNode:initialize(subnode, cond)
	local function iter(ctx, index)
		index = index + 1

		if cond ~= nil and cond(ctx, index) then
			return index, subnode
		else
			return nil, nil
		end
	end

	super.initialize(self, iter, 0)
end

EmptyBehaviorNode = class("EmptyBehaviorNode", BaseBehaviorNode, _M)

function EmptyBehaviorNode:start()
	return BehaviorResult.Success
end

CallFuncBehaviorNode = class("CallFuncBehaviorNode", BaseBehaviorNode, _M)

function CallFuncBehaviorNode:initialize(callback)
	super.initialize(self)

	self.callback = callback
end

function CallFuncBehaviorNode:start()
	local result

	if self.callback ~= nil then
		local var_54_0

		if self.callback(self.context) == false then
			var_54_0 = BehaviorResult.Failed or BehaviorResult.Success
		end
	end

	self:finish(var_54_0)
end
