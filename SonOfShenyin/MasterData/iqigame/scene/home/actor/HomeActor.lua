-- chunkname: @IQIGame\\Scene\\Home\\Actor\\HomeActor.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local HomeActor = {
	actorCid = 0,
	isReadyToShow = false
}

function HomeActor.New(actorCid, actorClass, controllerClass, readyCall, componentId)
	local actor = Clone(actorClass)

	actor:__Init(actorCid, controllerClass, readyCall, componentId)

	return actor
end

function HomeActor:__Init(actorCid, controllerClass, readyCall, componentId)
	self.actorCid = actorCid
	self.isReadyToShow = false
	self.readyCall = readyCall
	self.componentId = componentId

	self:__InitEventDelegate()
	self:__OnInit()
	self:__AddListeners()

	self.controller = ActorController.New(self, controllerClass)
end

function HomeActor:__InitEventDelegate()
	self:__OnInitEventDelegate()
end

function HomeActor:__AddListeners()
	self:__OnAddListeners()
end

function HomeActor:__RemoveListeners()
	self:__OnRemoveListeners()
end

function HomeActor:OnFrameUpdate()
	self.controller:OnFrameUpdate()
end

function HomeActor:Dispose()
	self:__RemoveListeners()
	self.controller:Dispose()
	self:__OnDispose()
end

function HomeActor:__OnInit()
	self:__OnActorPrepareReady()
end

function HomeActor:__OnActorPrepareReady()
	if self.__prepareReadyCall ~= nil then
		self.__prepareReadyCall()
	end

	EventDispatcher.Dispatch(EventID.CommonDialogControl_Action_CreateRole, self.componentId)
end

function HomeActor:__OnInitEventDelegate()
	return
end

function HomeActor:__OnAddListeners()
	return
end

function HomeActor:__OnRemoveListeners()
	return
end

function HomeActor:__OnDispose()
	return
end

function HomeActor:GetNameMountPoint()
	logError("【RPG】HomeActor 未重写基类方法 GetNameMountPoint()")
end

function HomeActor:GetDialogMountPoint()
	logError("【RPG】HomeActor 未重写基类方法 GetDialogMountPoint()")
end

function HomeActor:GetSelectMountPoint()
	logError("【RPG】HomeActor 未重写基类方法 GetSelectMountPoint()")
end

function HomeActor:GetTagMountPoint()
	logError("【RPG】HomeActor 未重写基类方法 GetTagMountPoint()")
end

function HomeActor:GetName()
	logError("【RPG】HomeActor 未重写基类方法 GetName()")
end

function HomeActor:Hide()
	logError("【RPG】HomeActor 未重写基类方法 Hide()")
end

function HomeActor:Show()
	logError("【RPG】HomeActor 未重写基类方法 Show()")
end

function HomeActor:GetActive()
	logError("【RPG】HomeActor 未重写基类方法 GetActive()")
end

function HomeActor:ChangeDirection()
	logError("【RPG】HomeActor 未重写基类方法 ChangeDirection()")
end

function HomeActor:ReadyToShow()
	self.isReadyToShow = true

	if self.readyCall ~= nil then
		self.readyCall(self)
	end
end

return HomeActor
