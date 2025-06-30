-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel_RoomSelectPanel_RoomItem.lua

local MainUI_HudPanel_RoomSelectPanel_RoomItem = {}

function MainUI_HudPanel_RoomSelectPanel_RoomItem.New(go, mainView)
	local o = Clone(MainUI_HudPanel_RoomSelectPanel_RoomItem)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:InitComponent()
	return
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:OnClickButtonClick()
	WorldMapModule.EnterRoom(self.data.roomId, true, self.data.playerBornPos and WorldMapModule.PackingEnterRoomData(self.data.playerBornPos) or "")
	self.mainView:Hide()
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:Refresh(Data)
	self.data = Data

	local roomData = WorldMapModule.GetRoomDataWithRoomID(self.data.roomId)

	if self.data.playerBornPos then
		HomeModule.playerBornPos = self.data.playerBornPos
	end

	LuaUtility.SetText(self.roomNameText, roomData:GetCfg().Name)
end

function MainUI_HudPanel_RoomSelectPanel_RoomItem:OnDestroy()
	return
end

return MainUI_HudPanel_RoomSelectPanel_RoomItem
