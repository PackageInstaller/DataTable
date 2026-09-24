-- chunkname: @modules/logic/story/view/StoryPostProcessAnimMgr.lua

module("modules.logic.story.view.StoryPostProcessAnimMgr", package.seeall)

local StoryPostProcessAnimMgr = class("StoryPostProcessAnimMgr")

StoryPostProcessAnimMgr.Target = {
	Scene = 1,
	UI = 0
}

local AnimatorType = typeof(UnityEngine.Animator)
local warnedStates = {}

function StoryPostProcessAnimMgr:ctor()
	self._stacks = {}
end

function StoryPostProcessAnimMgr:_getStack(target)
	local stack = self._stacks[target]

	if not stack then
		stack = {}
		self._stacks[target] = stack
	end

	return stack
end

function StoryPostProcessAnimMgr:_getWrap(target)
	if target == StoryPostProcessAnimMgr.Target.Scene then
		return PostProcessingMgr.instance:getUnitPPVolumeWrap()
	end

	return PostProcessingMgr.instance:getUIPPVolumeWrap()
end

function StoryPostProcessAnimMgr:play(target, owner, controller, opt)
	if not owner or not controller then
		logError("StoryPostProcessAnimMgr:play 参数不全")

		return false
	end

	local wrap = self:_getWrap(target)

	if gohelper.isNil(wrap) then
		logError("StoryPostProcessAnimMgr:play 找不到 PPVolumeWrap, target = " .. tostring(target))

		return false
	end

	opt = opt or {}

	local stack = self:_getStack(target)
	local oldIndex = self:_indexOf(stack, owner)

	if oldIndex then
		local old = table.remove(stack, oldIndex)

		self:_deactivate(old)
	end

	local top = stack[#stack]

	if top then
		self:_deactivate(top)
	end

	local var_4_0 = {
		normalizedTime = 0,
		target = target,
		owner = owner,
		wrap = wrap,
		go = wrap.gameObject,
		controller = controller
	}

	var_4_0.stateName = opt.stateName or "start"
	var_4_0.speed = opt.speed or 1
	var_4_0.syncMulti = opt.syncMulti

	local entry = var_4_0

	table.insert(stack, entry)

	stack.autoRestore = stack.autoRestore or opt.autoRestore ~= false
	stack.keepRefresh = stack.keepRefresh or opt.keepRefresh == true

	wrap:PushSnapshot()
	self:_activate(entry)

	return true
end

function StoryPostProcessAnimMgr:playState(owner, stateName, speed)
	local entry = self:_findActiveEntry(owner)

	if not entry then
		return false
	end

	if gohelper.isNil(entry.animator) then
		return false
	end

	if not entry.animator:HasState(0, UnityEngine.Animator.StringToHash(stateName)) then
		return false
	end

	entry.stateName = stateName
	entry.stateHash = nil
	entry.normalizedTime = 0

	if speed then
		entry.speed = speed
	end

	entry.animator.speed = entry.speed

	entry.animator:Play(stateName, 0, 0)

	return true
end

function StoryPostProcessAnimMgr:stop(owner)
	if not owner then
		return false
	end

	for _, stack in pairs(self._stacks) do
		local index = self:_indexOf(stack, owner)

		if index then
			local entry = stack[index]
			local wasTop = index == #stack

			table.remove(stack, index)

			if wasTop then
				self:_deactivate(entry)

				local resume = stack[#stack]

				if resume then
					self:_activate(resume)
				else
					self:_finish(stack, entry)
				end
			end

			return true
		end
	end

	return false
end

function StoryPostProcessAnimMgr:isActive(owner)
	return self:_findActiveEntry(owner) ~= nil
end

function StoryPostProcessAnimMgr:clearAll()
	for target, stack in pairs(self._stacks) do
		local top = stack[#stack]

		if top then
			self:_deactivate(top)
			self:_finish(stack, top)
		end

		self._stacks[target] = nil
	end
end

function StoryPostProcessAnimMgr:_activate(entry)
	if gohelper.isNil(entry.go) or gohelper.isNil(entry.wrap) then
		return
	end

	entry.wrap.refresh = true

	if entry.syncMulti then
		entry.wrap.syncMulti = entry.syncMulti
	end

	local animator = gohelper.onceAddComponent(entry.go, AnimatorType)

	animator.runtimeAnimatorController = entry.controller
	animator.speed = entry.speed
	entry.animator = animator

	if entry.stateHash then
		animator:Play(entry.stateHash, 0, entry.normalizedTime)

		return
	end

	if animator:HasState(0, UnityEngine.Animator.StringToHash(entry.stateName)) then
		animator:Play(entry.stateName, 0, entry.normalizedTime)
	else
		StoryPostProcessAnimMgr._warnMissingState(entry.controller, entry.stateName)
	end
end

function StoryPostProcessAnimMgr._warnMissingState(controller, stateName)
	local key = tostring(controller) .. "#" .. tostring(stateName)

	if warnedStates[key] then
		return
	end

	warnedStates[key] = true

	logWarn(string.format("[后处理动画] controller '%s' 没有状态 '%s'，改用默认状态", tostring(controller), tostring(stateName)))
end

function StoryPostProcessAnimMgr:_deactivate(entry)
	local animator = entry.animator

	entry.animator = nil

	if gohelper.isNil(animator) then
		return
	end

	local info = animator:GetCurrentAnimatorStateInfo(0)
	local time = info.normalizedTime

	if info.loop then
		time = time % 1
	elseif time > 1 then
		time = 1
	elseif time < 0 then
		time = 0
	end

	entry.normalizedTime = time
	entry.stateHash = info.fullPathHash

	if not gohelper.isNil(entry.go) then
		gohelper.removeComponent(entry.go, AnimatorType)
	end
end

function StoryPostProcessAnimMgr:_finish(stack, entry)
	local wrap = entry.wrap

	if not gohelper.isNil(wrap) then
		if stack.autoRestore then
			wrap:PopSnapshot()
		end

		if not stack.keepRefresh then
			wrap.refresh = false
		end
	end

	stack.autoRestore = nil
	stack.keepRefresh = nil
end

function StoryPostProcessAnimMgr:_indexOf(stack, owner)
	for i = 1, #stack do
		if stack[i].owner == owner then
			return i
		end
	end

	return nil
end

function StoryPostProcessAnimMgr:_findActiveEntry(owner)
	for _, stack in pairs(self._stacks) do
		local top = stack[#stack]

		if top and top.owner == owner then
			return top
		end
	end

	return nil
end

StoryPostProcessAnimMgr.instance = StoryPostProcessAnimMgr.New()

return StoryPostProcessAnimMgr
