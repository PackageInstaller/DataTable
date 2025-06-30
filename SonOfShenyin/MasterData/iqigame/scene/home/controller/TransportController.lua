-- chunkname: @IQIGame\\Scene\\Home\\Controller\\TransportController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local m = Clone(ActorController)

function m:__OnInit()
	self.actor.actorComponent.triggerEnterEvent:AddListener(self.onTriggerEnterEvent)
	self.actor.actorComponent.triggerExitEvent:AddListener(self.onTriggerEXitEvent)
	self:__OnControllerReady()
end

function m:__OnInitEventDelegate()
	function self.onTriggerEnterEvent(actorCom)
		self:onCollisionEnter(actorCom)
	end

	function self.onTriggerEXitEvent(actorCom)
		self:OnCollisionExit(actorCom)
	end
end

function m:__OnAddListeners()
	return
end

function m:__OnRemoveListeners()
	return
end

function m:__OnDispose()
	self.actor.actorComponent.triggerEnterEvent:RemoveListener(self.onTriggerEnterEvent)
	self.actor.actorComponent.triggerExitEvent:RemoveListener(self.onTriggerEXitEvent)
end

function m:onCollisionEnter(actorCom)
	local actor = self.actor

	WorldMapModule.GetComponentActionAndTrigger(actor.componentId)
end

function m:OnCollisionExit(actorCom)
	EventDispatcher.Dispatch(EventID.MainUI_HideRoomSelectEvent)
end

function m:InitAction()
	return
end

return m
