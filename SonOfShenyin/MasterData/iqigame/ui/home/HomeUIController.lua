-- chunkname: @IQIGame\\UI\\Home\\HomeUIController.lua

local HomeUISelectRoomElement = require("IQIGame/UI/Home/HomeUISelectRoomElement")
local HomeHUDController = require("IQIGame/UI/Home/HUD/HomeHUDController")
local m = {}

function m.New(gameObject)
	local obj = Clone(m)

	obj:__Init(gameObject)

	return obj
end

function m:__Init(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.selectRoomElement = HomeUISelectRoomElement.New(self.selectRoomRoot)
	self.hudController = HomeHUDController.New(self.hudRoot)

	self:__OnHomeSceneReadyToShow()
	self:__InitEventDelegate()
	self:__AddListeners()

	self.updateFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.Home, self.__delegateOnFrameUpdate, 1, -1)
end

function m:__InitEventDelegate()
	function self.__delegateOnShowHomeChangeRoomSelectListView(_roomList)
		self:__OnShowHomeChangeRoomSelectListView(_roomList)
	end

	function self.__delegateOnHideHomeChangeRoomSelectListView()
		self:__OnHideHomeChangeRoomSelectListView()
	end

	function self.__OnRoomMapBtnClickEventProxy()
		UIModule.Open(Constant.UIControllerName.HomeLandMapUI, Constant.UILayer.UI)
	end

	function self.__delegateOnHomeSceneReadyToShow()
		self:__OnHomeSceneReadyToShow()
	end

	function self.__delegateOnHomeWorkActorJoinRoom(_actorCid, _uiMountTrans)
		self:__OnHomeWorkActorJoinRoom(_actorCid, _uiMountTrans)
	end

	function self.__delegateOnHomeWorkActorExitRoom(_actorCid)
		self:__OnHomeWorkActorExitRoom(_actorCid)
	end

	function self.__delegateOnHomeWorkActorStartSpeak(_actorCid, _speakCid)
		self.hudController:ShowWorkActorSpeak(_actorCid, _speakCid)
	end

	function self.__delegateOnFrameUpdate()
		self:__OnFrameUpdate()
	end

	function self.__delegateOnHomeDispTaskChange()
		self:__OnHomeDispTaskChange()
	end
end

function m:__AddListeners()
	EventDispatcher.AddEventListener(EventID.ShowHomeChangeRoomSelectListView, self.__delegateOnShowHomeChangeRoomSelectListView)
	EventDispatcher.AddEventListener(EventID.HideHomeChangeRoomSelectListView, self.__delegateOnHideHomeChangeRoomSelectListView)
	EventDispatcher.AddEventListener(EventID.HomeSceneReadyToShow, self.__delegateOnHomeSceneReadyToShow)
	EventDispatcher.AddEventListener(EventID.HomeWorkActorJoinRoom, self.__delegateOnHomeWorkActorJoinRoom)
	EventDispatcher.AddEventListener(EventID.HomeWorkActorExitRoom, self.__delegateOnHomeWorkActorExitRoom)
	EventDispatcher.AddEventListener(EventID.HomeWorkActorStartSpeak, self.__delegateOnHomeWorkActorStartSpeak)
	self.mapBtn:GetComponent("Button").onClick:AddListener(self.__OnRoomMapBtnClickEventProxy)
	EventDispatcher.AddEventListener(EventID.HomeDispTaskChange, self.__delegateOnHomeDispTaskChange)
end

function m:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ShowHomeChangeRoomSelectListView, self.__delegateOnShowHomeChangeRoomSelectListView)
	EventDispatcher.RemoveEventListener(EventID.HideHomeChangeRoomSelectListView, self.__delegateOnHideHomeChangeRoomSelectListView)
	EventDispatcher.RemoveEventListener(EventID.HomeSceneReadyToShow, self.__delegateOnHomeSceneReadyToShow)
	EventDispatcher.RemoveEventListener(EventID.HomeWorkActorJoinRoom, self.__delegateOnHomeWorkActorJoinRoom)
	EventDispatcher.RemoveEventListener(EventID.HomeWorkActorExitRoom, self.__delegateOnHomeWorkActorExitRoom)
	EventDispatcher.RemoveEventListener(EventID.HomeWorkActorStartSpeak, self.__delegateOnHomeWorkActorStartSpeak)
	self.mapBtn:GetComponent("Button").onClick:RemoveListener(self.__OnRoomMapBtnClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.HomeDispTaskChange, self.__delegateOnHomeDispTaskChange)
end

function m:Show()
	self.gameObject:SetActive(true)
	self.updateFrameTimer:Start()
end

function m:Hide()
	self.gameObject:SetActive(false)
	self.updateFrameTimer:Stop()
end

function m:OnDispose()
	self.updateFrameTimer:Stop()
	self:__RemoveListeners()
	self.selectRoomElement:OnDispose()
	self.hudController:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:__OnFrameUpdate()
	self.hudController:OnFrameUpdate()
end

function m:__OnShowHomeChangeRoomSelectListView(roomList)
	self.selectRoomElement:Show(roomList)
end

function m:__OnHideHomeChangeRoomSelectListView()
	self.selectRoomElement:Hide()
end

function m:__OnHomeSceneReadyToShow()
	self:__OnHideHomeChangeRoomSelectListView()

	local areaData = WorldMapModule.GetCurrentAreaData()
	local active = areaData:GetRoomCount() > 1

	LuaUtility.SetGameObjectShow(self.mapBtn, active)
end

function m:__RefreshMapBtnRedDot()
	local curRoomCid = HomeModule.GetCurrentRoomCid()
	local needShowRedDot = HomeLandApi:CheckHomeMapButtonNeedShowRedDotByRoomCid(curRoomCid)

	if needShowRedDot then
		local taskList = HomeModule.GetAllFinishTaskCidList()

		needShowRedDot = #taskList > 0
	end

	self.mapBtnRedDot.gameObject:SetActive(needShowRedDot)
end

function m:__OnHomeDispTaskChange()
	self:__RefreshMapBtnRedDot()
end

function m:__OnHomeWorkActorJoinRoom(actorCid, uiMountTrans)
	local trans = uiMountTrans:Find("Speak")

	self.hudController:AddWorkActor(actorCid, trans)
end

function m:__OnHomeWorkActorExitRoom(actorCid)
	self.hudController:RemoveWorkActor(actorCid)
end

return m
