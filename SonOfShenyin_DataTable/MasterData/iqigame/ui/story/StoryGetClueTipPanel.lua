-- chunkname: @IQIGame\\UI\\Story\\StoryGetClueTipPanel.lua

local StoryGetClueTipPanel = {}

function StoryGetClueTipPanel.New(go, mainView)
	local o = Clone(StoryGetClueTipPanel)

	o:Initialize(go, mainView)

	return o
end

function StoryGetClueTipPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryGetClueTipPanel:InitComponent()
	return
end

function StoryGetClueTipPanel:InitDelegate()
	return
end

function StoryGetClueTipPanel:AddListener()
	return
end

function StoryGetClueTipPanel:RemoveListener()
	return
end

function StoryGetClueTipPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:OnOpen()
end

function StoryGetClueTipPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:OnClose()
end

function StoryGetClueTipPanel:ResetStatus()
	LuaUtility.SetGameObjectShow(self.objectRefresh, false)
	LuaUtility.SetGameObjectShow(self.objectAdd, false)
end

function StoryGetClueTipPanel:OnOpen()
	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.Timer = Timer.New(function()
		self:Close()
	end, 3, 1)

	self.Timer:Start()
end

function StoryGetClueTipPanel:OnClose()
	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end
end

function StoryGetClueTipPanel:OnButtonMaskClick()
	self:Close()
end

function StoryGetClueTipPanel:Refresh(Data, getType)
	self.Data = PuzzleModule.GetCluesCfgDataWithID(Data)

	self:ResetStatus()
	LuaUtility.SetText(self.textSelectName, self.Data.CluesName)
	AssetUtil.LoadImage(self, self.Data.Icon, self.imageSelectItem:GetComponent("Image"))
	AssetUtil.LoadImage(self, self.Data.Shape, self.imageSelectIcon:GetComponent("Image"))

	if getType then
		if getType == Constant.CluesGetType.Add then
			LuaUtility.SetGameObjectShow(self.objectAdd, true)
		elseif getType == Constant.CluesGetType.Refresh then
			LuaUtility.SetGameObjectShow(self.objectRefresh, true)
		end
	end
end

function StoryGetClueTipPanel:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return StoryGetClueTipPanel
