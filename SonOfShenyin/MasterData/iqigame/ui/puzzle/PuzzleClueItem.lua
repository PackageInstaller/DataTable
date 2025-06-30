-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleClueItem.lua

local PuzzleClueItem = {}

function PuzzleClueItem.New(go, mainView)
	local o = Clone(PuzzleClueItem)

	o:Initialize(go, mainView)

	return o
end

function PuzzleClueItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleClueItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
	self.imageCommonItem = self.imageCommonItem:GetComponent("Image")
end

function PuzzleClueItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClick()
	end
end

function PuzzleClueItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function PuzzleClueItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function PuzzleClueItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function PuzzleClueItem:OnButtonClick()
	if self.mainView.currentSelectClueItem == self then
		return
	end

	if self.mainView.currentSelectClueItem and self.Data.ComposeID == self.mainView.currentSelectClueItem.Data.Id then
		local composeID = PuzzleModule.CluesComposing(self.Data.Id, self.mainView.currentSelectClueItem.Data.Id)

		self.mainView.currentSelectClueItem = nil

		self.mainView:Refresh()
		self.mainView:SelectPuzzleWithID(composeID)

		local cfgClueData = PuzzleModule.GetCluesCfgDataWithID(composeID)

		if not LuaUtility.StrIsNullOrEmpty(cfgClueData.CreateParam) then
			EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, cfgClueData.CreateParam)
			self.mainView:Close()
		end

		return
	end

	self.mainView:ShowClueDetail(self)
	self:LightOn()
end

function PuzzleClueItem:OnButtonSurveyClick()
	self.mainView:Close()
	EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, self.Data.ActionParam)
	PuzzleModule.SetClueHasSurveyed(self.Data.Id)
end

function PuzzleClueItem:ResetShow()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	LuaUtility.SetGameObjectShow(self.objectLight, false)
end

function PuzzleClueItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function PuzzleClueItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function PuzzleClueItem:LightOn()
	LuaUtility.SetGameObjectShow(self.objectLight, true)
end

function PuzzleClueItem:LightOff()
	LuaUtility.SetGameObjectShow(self.objectLight, false)
end

function PuzzleClueItem:Refresh(Data, index)
	self.Data = Data
	self.Index = index

	self:LightOff()
	LuaUtility.SetText(self.textCommonName, self.Data.CluesName)
	AssetUtil.LoadImage(self, self.Data.Icon, self.imageCommonItem)
end

return PuzzleClueItem
