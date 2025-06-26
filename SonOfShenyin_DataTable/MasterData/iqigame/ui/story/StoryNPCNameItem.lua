-- chunkname: @IQIGame\\UI\\Story\\StoryNPCNameItem.lua

local StoryNPCNameItem = {}
local NameVariable = "NameIconShow"
local AnimationCloseName = "NPCNamePrefab"

function StoryNPCNameItem.New(go, mainView)
	local o = Clone(StoryNPCNameItem)

	o:Initialize(go, mainView)

	return o
end

function StoryNPCNameItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.canvas = mainView:GetCanvas()

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryNPCNameItem:InitComponent()
	return
end

function StoryNPCNameItem:InitDelegate()
	function self.textNameDelegate()
		self:OnTextNameClick()
	end
end

function StoryNPCNameItem:AddListener()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.textNameDelegate)

	self.canvasGroup = self.objectName:GetComponent("CanvasGroup")
end

function StoryNPCNameItem:RemoveListener()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.textNameDelegate)
end

function StoryNPCNameItem:OnTextNameClick()
	if self.IsAnimation then
		return
	end

	EventDispatcher.Dispatch(EventID.BehaviorTreeOnInteract, self.npcID)
	self:PlayClickAnimation()
end

function StoryNPCNameItem:PlayClickAnimation()
	LuaUtility.PlayAnimation(self.gameObject, AnimationCloseName, nil, function()
		self:Show(false)

		self.IsAnimation = false
	end)

	self.IsAnimation = true

	LuaUtility.PlaySoundWithID(22000012)
end

function StoryNPCNameItem:Show(show)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.gameObject, show)

	if show then
		self:OnOpen()
	else
		self:OnClose()
	end

	self.isShow = show
end

function StoryNPCNameItem:OnOpen()
	return
end

function StoryNPCNameItem:OnClose()
	self.IsAnimation = false
end

function StoryNPCNameItem:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryNPCNameItem:Refresh(nameString, npcID, followObject)
	self.npcID = npcID

	local npc = StoryModule.GetCharacterByNPCID(self.npcID)

	self.interActType = npc:GetInterActType()

	LuaUtility.SetGameObjectShow(self.typeRole, self.interActType == Constant.StoryInterActType.Role)
	LuaUtility.SetGameObjectShow(self.typeLocation, self.interActType == Constant.StoryInterActType.Location)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.objectName, true)
	LuaUtility.SetText(self.textNameFront, nameString)

	local adapter = LuaUtility.GetComponent(self.gameObject, typeof(UISizeAdapter))

	adapter:UpdateSize()

	local follower = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(UIFollower))

	follower:Init(StoryModule.mainCamera, GameEntry.UICamera, followObject.transform, self.canvas)
	follower:LimitUIInScreen(self.mainView.Root:GetComponent("RectTransform"), 10)

	local iconShow = BehaviorTreeUtility.GetNPCVariable(self.npcID, Constant.StoryNameIconShow)

	self:SetIconShow(iconShow == nil and true or iconShow)
	LuaUtility.AnimationStayInTime(self.gameObject, AnimationCloseName, 0)
end

function StoryNPCNameItem:SetIconShow(show)
	if self.interActType == Constant.StoryInterActType.Role then
		LuaUtility.SetGameObjectShow(self.on, show)
		LuaUtility.SetGameObjectShow(self.off, not show)
	elseif self.interActType == Constant.StoryInterActType.Location then
		LuaUtility.SetGameObjectShow(self.imageLocationOn, show)
		LuaUtility.SetGameObjectShow(self.imageLocationOff, not show)
	end
end

return StoryNPCNameItem
