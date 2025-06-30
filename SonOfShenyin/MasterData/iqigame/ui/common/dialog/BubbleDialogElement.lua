-- chunkname: @IQIGame\\UI\\Common\\Dialog\\BubbleDialogElement.lua

local BubbleDialogElement = {}
local bubbleItemClass = require("IQIGame/UI/Common/Dialog/CommonDialogPanel_BubbleItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")

function BubbleDialogElement.New(go, mainView)
	local o = Clone(BubbleDialogElement)

	o:Initialize(go, mainView)

	return o
end

function BubbleDialogElement:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.mountPointViewDic = {}

	self:InitDelegate()
	self:InitComponent()
	self:AddListener()
end

function BubbleDialogElement:InitComponent()
	self.bubbleItemPool = UIViewObjectPool.New(self.bubblePrefab, self.gameObject.transform, function(_view)
		return bubbleItemClass.New(_view, self)
	end)
	self.timer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.BubbleDialogueTimer, self.upDateEvent, 1, -1)

	self.timer:Start()
end

function BubbleDialogElement:InitDelegate()
	function self.showBubbleEvent(mountPoint, name, text, duration)
		self:ShowBubble(mountPoint, name, text, duration)
	end

	function self.hideBubbleEvent(mountPoint)
		self:HideBubble(mountPoint)
	end

	function self.freeBubbleEvent(mountPoint)
		self:FreeBubble(mountPoint)
	end

	function self.upDateEvent()
		self:Update()
	end
end

function BubbleDialogElement:AddListener()
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_ShowBubble, self.showBubbleEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_HideBubble, self.hideBubbleEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_FreeBubble, self.freeBubbleEvent)
end

function BubbleDialogElement:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_ShowBubble, self.showBubbleEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_HideBubble, self.hideBubbleEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_FreeBubble, self.freeBubbleEvent)
end

function BubbleDialogElement:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function BubbleDialogElement:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	for _, v in pairs(self.mountPointViewDic) do
		v:StopCoroutine()
	end
end

function BubbleDialogElement:ShowBubble(mountPoint, name, text, duration, uiPoint, notUseAuto)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local instanceID = mountPoint.gameObject:GetInstanceID()

	if not self.mountPointViewDic[instanceID] then
		local item = self.bubbleItemPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		self.mountPointViewDic[instanceID] = item
	end

	self.mountPointViewDic[instanceID]:Refresh(mountPoint, name, text, duration, uiPoint, notUseAuto)
end

function BubbleDialogElement:HideBubble(mountPoint)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local instanceID = mountPoint.gameObject:GetInstanceID()

	if not self.mountPointViewDic[instanceID] then
		return
	end

	self.mountPointViewDic[instanceID]:Hide()
end

function BubbleDialogElement:FreeBubble(mountPoint)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local instanceID = mountPoint.gameObject:GetInstanceID()

	if not self.mountPointViewDic[instanceID] then
		return
	end

	self.mountPointViewDic[instanceID]:Hide()
	self.mountPointViewDic[instanceID]:Free()
end

function BubbleDialogElement:SetSetConfirmButtonShow(show)
	self.mainView:SetConfirmButtonShow(show)
end

function BubbleDialogElement:Update()
	if self.mountPointViewDic then
		for _, v in pairs(self.mountPointViewDic) do
			v:Update()
		end
	end
end

function BubbleDialogElement:StopTimer()
	if not self.timer then
		return
	end

	self.timer:Stop()
end

function BubbleDialogElement:OnDestroy()
	self:RemoveListener()
	self:StopTimer()

	self.mountPointViewDic = {}

	self.bubbleItemPool:Dispose(function(item)
		item:OnDestroy()
	end)
end

return BubbleDialogElement
