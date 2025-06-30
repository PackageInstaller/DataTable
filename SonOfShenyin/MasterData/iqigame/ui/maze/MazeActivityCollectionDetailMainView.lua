-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityCollectionDetailMainView.lua

local MazeActivityCollectionDetailMainView = {
	isFront = true
}

function MazeActivityCollectionDetailMainView.New(go)
	local o = Clone(MazeActivityCollectionDetailMainView)

	o:Initialize(go)

	return o
end

function MazeActivityCollectionDetailMainView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeActivityCollectionDetailMainView:InitComponent()
	return
end

function MazeActivityCollectionDetailMainView:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:Hide()
	end

	function self.delegateOnClickFlipBtn()
		self:OnClickFlipBtn()
	end
end

function MazeActivityCollectionDetailMainView:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
	self.flipBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickFlipBtn)
end

function MazeActivityCollectionDetailMainView:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
	self.flipBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickFlipBtn)
end

function MazeActivityCollectionDetailMainView:Show()
	self.isFront = true

	self:RefreshFace()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MazeActivityCollectionDetailMainView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MazeActivityCollectionDetailMainView:Refresh(Data)
	self.data = Data

	UGUIUtil.SetText(self.collectionDescText, CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].ItemTips)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].Icon), self.collectionImg:GetComponent("Image"))
end

function MazeActivityCollectionDetailMainView:RefreshFace()
	LuaUtility.SetGameObjectShow(self.FrontParent, self.isFront)
	LuaUtility.SetGameObjectShow(self.BackParent, not self.isFront)
end

function MazeActivityCollectionDetailMainView:OnClickFlipBtn()
	self.isFront = not self.isFront

	self:RefreshFace()
end

function MazeActivityCollectionDetailMainView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
end

return MazeActivityCollectionDetailMainView
