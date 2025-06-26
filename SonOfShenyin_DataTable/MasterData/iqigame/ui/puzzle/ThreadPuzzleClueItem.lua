-- chunkname: @IQIGame\\UI\\Puzzle\\ThreadPuzzleClueItem.lua

local ThreadPuzzleClueItem = {}

function ThreadPuzzleClueItem.New(go, mainView)
	local o = Clone(ThreadPuzzleClueItem)

	o:Initialize(go, mainView)

	return o
end

function ThreadPuzzleClueItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ThreadPuzzleClueItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
	self.imageCommonItem = self.imageCommonItem:GetComponent("Image")
	self.imageCommonIcon = self.imageCommonIcon:GetComponent("Image")
end

function ThreadPuzzleClueItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClick()
	end
end

function ThreadPuzzleClueItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function ThreadPuzzleClueItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function ThreadPuzzleClueItem:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
end

function ThreadPuzzleClueItem:OnButtonClick()
	self.mainView:ShowCluesItem(self.Data.Id)
end

function ThreadPuzzleClueItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function ThreadPuzzleClueItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function ThreadPuzzleClueItem:ResetShow()
	return
end

function ThreadPuzzleClueItem:Refresh(Data)
	self.Data = Data

	LuaUtility.SetText(self.textCommonName, self.Data.CluesName)
	AssetUtil.LoadImage(self, self.Data.Icon, self.imageCommonItem)
	AssetUtil.LoadImage(self, self.Data.Shape, self.imageCommonIcon)
end

return ThreadPuzzleClueItem
