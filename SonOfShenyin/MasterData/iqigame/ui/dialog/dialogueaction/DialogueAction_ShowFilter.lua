-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ShowFilter.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)
local filterDefine = {
	Memory = 2,
	Thinking = 1
}
local duration = 0.5

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	if self.args.filterType == filterDefine.Thinking then
		if self.args.isShow then
			BehaviorTreeUtility.ShowThinkingFilter(duration)
		else
			BehaviorTreeUtility.HideThinkingFilter(duration)
		end
	elseif self.args.filterType == filterDefine.Memory then
		if self.args.isShow then
			BehaviorTreeUtility.ShowMemoryFilter(duration)
		else
			BehaviorTreeUtility.HideMemoryFilter(duration)
		end
	end

	self.isComplete = true
end

function m:OnSkip()
	if self.args.filterType == filterDefine.Thinking then
		if self.args.isShow then
			BehaviorTreeUtility.ShowThinkingFilter(0)
		else
			BehaviorTreeUtility.HideThinkingFilter(0)
		end
	elseif self.args.filterType == filterDefine.Memory then
		if self.args.isShow then
			BehaviorTreeUtility.ShowMemoryFilter(0)
		else
			BehaviorTreeUtility.HideMemoryFilter(0)
		end
	end

	self.isComplete = true
end

return m
