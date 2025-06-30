-- chunkname: @IQIGame\\Scene\\MemoryStory\\Element\\FunctionComponent\\MemoryStoryElemTaskTagComponent.lua

local MemoryStoryElemBaseComponent = require("IQIGame.Scene.MemoryStory.Element.FunctionComponent.MemoryStoryElemBaseComponent")
local m = {}

m = extend(MemoryStoryElemBaseComponent, m)

function m.New(view)
	local obj = Clone(m)

	obj:__OnInit(view)

	return obj
end

function m:__OnInit(view)
	self:__Init(view)
	self:ShowTaskTag(MemoryStoryPlayerModule.TaskState.None)
end

function m:ShowTaskTag(state)
	self.__ActiveEx(self.goReceiveTag, state == MemoryStoryPlayerModule.TaskState.Receive)
	self.__ActiveEx(self.goSubmitTag, state == MemoryStoryPlayerModule.TaskState.Succeed)
	self.__ActiveEx(self.goAvailableTag, state == MemoryStoryPlayerModule.TaskState.Available)
end

function m:OnDestroy()
	self:ShowTaskTag(MemoryStoryPlayerModule.TaskState.None)
	self:__BaseDestroy()
end

return m
