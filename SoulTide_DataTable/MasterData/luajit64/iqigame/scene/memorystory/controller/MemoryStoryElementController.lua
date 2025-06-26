-- chunkname: @IQIGame\\Scene\\MemoryStory\\Controller\\MemoryStoryElementController.lua

local m = {}

function m.New(elementId)
	local obj = Clone(m)

	obj:__Init(elementId)

	return obj
end

function m:__Init(elementId)
	self.CfgData = CfgMemoryStoryElementTable[elementId]
	self.ServicesDic = {}

	for _, v in pairs(self.CfgData.ServiceID) do
		local serviceCfg = CfgMemoryStoryServiceTable[v]
		local serviceList = self.ServicesDic[serviceCfg.TriggerType]

		if serviceList == nil then
			serviceList = {}
		end

		table.insert(serviceList, serviceCfg)

		self.ServicesDic[serviceCfg.TriggerType] = serviceList
	end

	self:__PrepareEventProxy()
	self:__RegionTriggerEventListener()
end

function m:__PrepareEventProxy()
	function self.memoryStoryPlayerSubmitTaskEventProxy(taskId)
		self:__OnMemoryStoryPlayerSubmitTaskEventHandler(taskId)
	end

	function self.memoryStoryPlayerReceiveTaskEventProxy(taskId)
		self:__OnMemoryStoryPlayerReceiveTaskEventHandler(taskId)
	end

	function self.memoryStoryPlayerTaskProgressChangeEventProxy(taskId, targetId)
		self:__OnMemoryStoryPlayerTaskProgressChangeEventHandler(taskId, targetId)
	end
end

function m:__RegionTriggerEventListener()
	EventDispatcher.AddEventListener(EventID.MemoryStoryPlayerReceiveTaskEvent, self.memoryStoryPlayerReceiveTaskEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryPlayerTaskProgressChangeEvent, self.memoryStoryPlayerTaskProgressChangeEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryPlayerSubmitTaskEvent, self.memoryStoryPlayerSubmitTaskEventProxy)
end

function m:__RemoveTriggerEventListener()
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryPlayerReceiveTaskEvent, self.memoryStoryPlayerReceiveTaskEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryPlayerTaskProgressChangeEvent, self.memoryStoryPlayerTaskProgressChangeEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryPlayerSubmitTaskEvent, self.memoryStoryPlayerSubmitTaskEventProxy)
end

function m:__OnMemoryStoryPlayerReceiveTaskEventHandler(taskId)
	self:ExecuteReceiveTaskServices()
end

function m:__OnMemoryStoryPlayerTaskProgressChangeEventHandler(taskId, targetId)
	return
end

function m:__OnMemoryStoryPlayerSubmitTaskEventHandler(taskId)
	self:ExecuteSubmitTaskServices()
end

function m:ExecuteReceiveTaskServices()
	self:__ExecuteServicesWidthDelete(MemoryStoryModule.ServiceTriggerType.RECEIVE_TASK, true)
end

function m:ExecuteSubmitTaskServices()
	self:__ExecuteServicesWidthDelete(MemoryStoryModule.ServiceTriggerType.SUBMIT_TASK, true)
end

function m:ExecuteReadyInSceneService()
	self:__ExecuteServices(MemoryStoryModule.ServiceTriggerType.Element_Ready, nil)
end

function m:ExecuteRemoveInSceneService()
	self:__ExecuteServices(MemoryStoryModule.ServiceTriggerType.Element_Remove, nil)
end

function m:__ExecuteServices(type, condition)
	local serviceLst = self.ServicesDic[type]
	local executeList = {}

	if serviceLst ~= nil then
		for k, service in pairs(serviceLst) do
			if MemoryStoryModule.ExecuteService(self, service, condition) then
				table.insert(executeList, k)
			end
		end
	end

	return executeList
end

function m:__ExecuteServicesWidthDelete(type, condition)
	local lst = self:__ExecuteServices(type, condition)

	for _, v in pairs(lst) do
		table.remove(self.ServicesDic[type], v)
	end
end

function m:RemoveToScene()
	self:__ExecuteServices(MemoryStoryModule.ServiceTriggerType.Element_Remove, nil)
	self:OnDestroy()
end

function m:OnDestroy()
	self:__DoDestroy()
end

function m:__DoDestroy()
	self:__RemoveTriggerEventListener()

	self.CfgData = nil
	self.ServicesDic = nil
end

return m
