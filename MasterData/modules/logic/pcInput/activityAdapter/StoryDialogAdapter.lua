-- chunkname: @modules/logic/pcInput/activityAdapter/StoryDialogAdapter.lua

module("modules.logic.pcInput.activityAdapter.StoryDialogAdapter", package.seeall)

local StoryDialogAdapter = class("StoryDialogAdapter", BaseActivityAdapter)

StoryDialogAdapter.keytoFunction = {
	Space = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogNext)
	end,
	F1 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogAuto)
	end,
	F2 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSkip)
	end,
	F3 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogExit)
	end,
	Alpha1 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 1)
	end,
	Alpha2 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 2)
	end,
	Alpha3 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 3)
	end
}

function StoryDialogAdapter:ctor()
	self.keytoFunction = StoryDialogAdapter.keytoFunction

	self:registerFunction()
end

function StoryDialogAdapter:registerFunction()
	for k, _ in pairs(self.keytoFunction) do
		PCInputController.instance:registerKey(k, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function StoryDialogAdapter:unRegisterFunction()
	for k, _ in pairs(self.keytoFunction) do
		PCInputController.instance:unregisterKey(k, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function StoryDialogAdapter:OnkeyUp(keyName)
	local func = self.keytoFunction[keyName]

	if func then
		func()
	end
end

function StoryDialogAdapter:OnkeyDown(keyName)
	local func = self.keytoFunction[keyName]

	if func then
		func()
	end
end

function StoryDialogAdapter:destroy()
	self:unRegisterFunction()
end

return StoryDialogAdapter
