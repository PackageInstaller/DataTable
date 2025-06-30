-- chunkname: @IQIGame\\Scene\\MemoryStory\\Element\\MemoryStoryNpc.lua

local MemoryStoryElement = require("IQIGame.Scene.MemoryStory.Element.MemoryStoryElement")
local MemoryStoryElemTaskTagComponent = require("IQIGame.Scene.MemoryStory.Element.FunctionComponent.MemoryStoryElemTaskTagComponent")
local m = {
	isTriggered = false
}

m = extend(MemoryStoryElement, m)

function m.New(controller, view)
	local obj = Clone(m)

	obj:__OnInit(controller, view)

	return obj
end

function m:__OnInit(controller, view)
	self:__Init(controller, view)
	self:__InitPositionByConfig()

	self.isTriggered = false
end

function m:__OnEntityPrepareSucceed(executeService)
	if self.goTaskTag ~= nil then
		self.taskTagComponent = MemoryStoryElemTaskTagComponent.New(self.goTaskTag)
	else
		self.taskTagComponent = nil
	end

	self:__DoEntityPrepareSucceed(executeService)
end

function m:OnDestroy()
	if self.taskTagComponent ~= nil then
		self.taskTagComponent:OnDestroy()
	end

	self:__BaseDestroy()
end

function m:EnterTalking()
	self.isTalking = true

	self:OnHideTaskElement()
end

function m:ExitTalking()
	self.isTalking = false

	self:HideTip()
	self:OnShowTaskElement()
end

function m:ShowTaskTag(state)
	if self.taskTagComponent == nil then
		return
	end

	self.taskTagComponent:ShowTaskTag(state)
end

function m:OnShowTaskElement()
	if self.taskTagComponent == nil then
		return
	end

	self.taskTagComponent:ShowElement()
end

function m:OnHideTaskElement()
	if self.taskTagComponent == nil then
		return
	end

	self.taskTagComponent:HideElement()
end

function m:OnCollisionEnter2D()
	if self.isTriggered then
		return
	end

	self:__SetOutlineActive(true)

	self.isTriggered = true

	MemoryStoryModule.ExecuteElementServices(MemoryStoryModule.ElementTriggerType.ColliderEnter, self.elementId)
end

function m:OnCollisionExit2D()
	if not self.isTriggered then
		return
	end

	self.isTriggered = false

	MemoryStoryModule.ExecuteElementServices(MemoryStoryModule.ElementTriggerType.ColliderExit, self.elementId)
	self:__SetOutlineActive(false)
end

return m
