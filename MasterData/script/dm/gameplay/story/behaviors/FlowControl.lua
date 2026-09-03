-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/FlowControl.lua

module("story", package.seeall)

local function actionIterator(actionArray)
	assert(actionArray ~= nil)

	local function f(ctx, i)
		local total = table.maxn(actionArray)

		while i <= total do
			i = i + 1

			local action = actionArray[i]

			if action then
				return i, action
			end
		end

		return nil, nil
	end

	return f, 0
end

function sandbox.sequential(actionArray)
	return SequenceBehavior:new(actionIterator(actionArray))
end

function sandbox.concurrent(actionArray)
	return ParallelSelectorBehavior:new(actionIterator(actionArray))
end

BranchFlow = class("BranchFlow", BaseBehaviorNode)

function BranchFlow:initialize(branches)
	super.initialize(self)

	self._branches = branches
end

function BranchFlow:start()
	super.start(self)

	local context = self.context
	local matchedBranch

	for i, branch in ipairs(self._branches) do
		if branch.cond == nil or branch.cond(context) then
			matchedBranch = branch

			break
		end
	end

	if matchedBranch ~= nil and matchedBranch.subnode ~= nil then
		self._action = matchedBranch.subnode

		self._action:run(context, function(target, result)
			self._action = nil

			return self:finish(BehaviorResult.Success)
		end)

		return
	end

	return BehaviorResult.Success
end

function BranchFlow:abort(result)
	if self._action ~= nil then
		self._action:abort()

		self._action = nil
	end

	super.abort(self, result)
end

function sandbox.branch(branches)
	return BranchFlow:new(branches)
end

WhileDoFlow = class("WhileDoFlow", BaseBehaviorNode)

function WhileDoFlow:initialize(whileDo)
	super.initialize(self)

	self._whileDo = whileDo
end

function WhileDoFlow:start()
	super.start(self)
	self:runAction()
end

function WhileDoFlow:runAction()
	local context = self.context
	local cond = self._whileDo.cond

	if cond and self._whileDo.cond(context) and self._whileDo.subnode then
		self._action = self._whileDo.subnode

		self._action:run(context, function(target, result)
			self._action = nil

			self:runAction()
		end)

		return
	end

	self:finish(BehaviorResult.Success)
end

function WhileDoFlow:abort(result)
	if self._action ~= nil then
		self._action:abort()

		self._action = nil
	end

	super.abort(self, result)
end

function sandbox.while_do(whileDo)
	return WhileDoFlow:new(whileDo)
end

RepeatUntilFlow = class("RepeatUntilFlow", BaseBehaviorNode)

function RepeatUntilFlow:initialize(repeatUntil)
	super.initialize(self)

	self._repeatUntil = repeatUntil
end

function RepeatUntilFlow:start()
	super.start(self)
	self:runAction()
end

function RepeatUntilFlow:runAction()
	local context = self.context
	local cond = self._repeatUntil.cond

	if self._repeatUntil.subnode then
		self._action = self._repeatUntil.subnode

		self._action:run(context, function(target, result)
			self._action = nil

			if cond and cond(context) then
				self:runAction()
			else
				self:finish(BehaviorResult.Success)
			end
		end)

		return
	end

	self:finish(BehaviorResult.Success)
end

function RepeatUntilFlow:abort(result)
	if self._action ~= nil then
		self._action:abort()

		self._action = nil
	end

	super.abort(self, result)
end

function sandbox.repeat_until(repeatUntil)
	return RepeatUntilFlow:new(repeatUntil)
end
