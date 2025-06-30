-- chunkname: @IQIGame\\Scene\\Home\\Controller\\ActorController.lua

local Controller = {}

function Controller.New(actor, class)
	local controller = Clone(class)

	controller:__Init(actor)

	return controller
end

function Controller:__Init(actor)
	self.actor = actor

	function self.actor.__prepareReadyCall()
		self:__OnActorReady()
	end

	self:__InitEventDelegate()
end

function Controller:__InitEventDelegate()
	self:__OnInitEventDelegate()
end

function Controller:__AddListeners()
	self:__OnAddListeners()
end

function Controller:__RemoveListeners()
	self:__OnRemoveListeners()
end

function Controller:__OnActorReady()
	self:__OnInit()
	self:__AddListeners()
end

function Controller:OnFrameUpdate()
	self:__OnFrameUpdate()
end

function Controller:Dispose()
	self:__RemoveListeners()
	self:__OnDispose()

	self.actor = nil
end

function Controller:__OnInit()
	self:__OnControllerReady()
end

function Controller:__OnControllerReady()
	self.actor:ReadyToShow()
end

function Controller:__OnInitEventDelegate()
	return
end

function Controller:__OnAddListeners()
	return
end

function Controller:__OnRemoveListeners()
	return
end

function Controller:__OnDispose()
	return
end

function Controller:__OnFrameUpdate()
	return
end

return Controller
