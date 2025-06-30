-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel_nameItem.lua

local MainUI_HudPanel_nameItem = {}
local AnimationCloseName = "NPCNamePrefab"

function MainUI_HudPanel_nameItem.New(go, mainView)
	local o = Clone(MainUI_HudPanel_nameItem)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel_nameItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.isFree = true
	self.canvas = mainView:GetCanvas()

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel_nameItem:InitComponent()
	return
end

function MainUI_HudPanel_nameItem:InitDelegate()
	function self.textNameDelegate()
		self:OnTextNameClick()
	end
end

function MainUI_HudPanel_nameItem:AddListener()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.textNameDelegate)
end

function MainUI_HudPanel_nameItem:RemoveListener()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.textNameDelegate)
end

function MainUI_HudPanel_nameItem:OnTextNameClick()
	if self.IsAnimation then
		return
	end

	self:PlayClickAnimation()
	WorldMapModule.GetComponentActionAndTrigger(self.componentId)
end

function MainUI_HudPanel_nameItem:Show()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.gameObject, true)
end

function MainUI_HudPanel_nameItem:Hide()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.gameObject, false)
end

function MainUI_HudPanel_nameItem:GetIsFree()
	return self.isFree
end

function MainUI_HudPanel_nameItem:PlayClickAnimation()
	LuaUtility.PlayAnimation(self.gameObject, AnimationCloseName, nil, function()
		self:Hide()

		self.IsAnimation = false
	end)

	self.IsAnimation = true

	LuaUtility.PlaySoundWithID(22000012)
end

function MainUI_HudPanel_nameItem:Refresh(mountPoint, nameString, componentId)
	self.componentId = componentId
	self.mountPoint = mountPoint

	local componentData = WorldMapModule.GetComponentDataWithId(self.componentId)

	LuaUtility.SetGameObjectShow(self.typeRole, componentData:GetCfg().Type == Constant.RoomComponentsType.Role)
	LuaUtility.SetGameObjectShow(self.typeLocation, componentData:GetCfg().Type == Constant.RoomComponentsType.Article)

	if not LuaUtility.StrIsNullOrEmpty(nameString) then
		LuaUtility.SetText(self.textNameFront, nameString)
	else
		LuaUtility.SetText(self.textNameFront, "")
	end

	local adapter = LuaUtility.GetComponent(self.gameObject, typeof(UISizeAdapter))

	adapter:UpdateSize()

	local follower = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(UIFollower))

	follower:Init(UnityEngine.Camera.main, GameEntry.UICamera, mountPoint.transform, self.canvas)
	follower:LimitUIInScreen(self.mainView:GetRoot():GetComponent("RectTransform"), 10)
	LuaUtility.AnimationStayInTime(self.gameObject, AnimationCloseName, 0)

	self.isFree = false
	self.IsAnimation = false
end

function MainUI_HudPanel_nameItem:SetIconShow(show)
	return
end

function MainUI_HudPanel_nameItem:OnDestroy()
	return
end

return MainUI_HudPanel_nameItem
