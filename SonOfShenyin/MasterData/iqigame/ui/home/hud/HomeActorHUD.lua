-- chunkname: @IQIGame\\UI\\Home\\HUD\\HomeActorHUD.lua

local HomeUIActorSpeakElement = require("IQIGame/UI/Home/HomeUIActorSpeakElement")
local HomeActorHUD = {
	actorCid = 0,
	isFree = true
}

function HomeActorHUD.New(view)
	local obj = Clone(HomeActorHUD)

	obj:__Init(view)

	return obj
end

function HomeActorHUD:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.uiParent = self.gameObject.transform.parent

	function self.__delegateOnWorkActorSpeakEnd(_actorCid)
		EventDispatcher.Dispatch(EventID.HomeWorkActorEndSpeak, self.actorCid)
		self:ShowWork()
	end

	self.speakElement = HomeUIActorSpeakElement.New(self.speakItem, self.__delegateOnWorkActorSpeakEnd)

	self.speakElement:Hide()
	self.workTag.gameObject:SetActive(false)
end

function HomeActorHUD:Mount(actorCid, target)
	self.isFree = false
	self.actorCid = actorCid

	LuaCodeInterface.SetCanvasEventCamera(self.gameObject, UnityEngine.Camera.main)

	self.gameObject.transform.parent = target
	self.gameObject.transform.localPosition = Vector3.zero
	self.gameObject.transform.localScale = Vector3.one

	setGameObjectLayers(self.gameObject.transform, "StoryNPC")
	self:ShowWork()
end

function HomeActorHUD:ShowWork()
	self.gameObject:SetActive(true)
	self.speakElement:Hide()
	self.workTag.gameObject:SetActive(true)
end

function HomeActorHUD:ShowSpeak(speakCid)
	self.gameObject:SetActive(true)
	self.workTag.gameObject:SetActive(false)
	self.speakElement:Show(speakCid)
end

function HomeActorHUD:OnFrameUpdate()
	if self.isFree then
		return
	end

	self.speakElement:OnFrameUpdate()
end

function HomeActorHUD:Release()
	self.isFree = true

	self.speakElement:Hide()
	self.workTag.gameObject:SetActive(false)
	self.gameObject.gameObject:SetActive(false)

	self.gameObject.transform.parent = self.uiParent
end

function HomeActorHUD:IsFree()
	return self.isFree
end

function HomeActorHUD:Dispose()
	self:Release()
	self.speakElement:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return HomeActorHUD
