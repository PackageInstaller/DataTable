-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityCollectionDetailSecondView.lua

local MazeActivityCollectionDetailSecondView = {}

function MazeActivityCollectionDetailSecondView.New(go)
	local o = Clone(MazeActivityCollectionDetailSecondView)

	o:Initialize(go)

	return o
end

function MazeActivityCollectionDetailSecondView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeActivityCollectionDetailSecondView:InitComponent()
	return
end

function MazeActivityCollectionDetailSecondView:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:Hide()
	end
end

function MazeActivityCollectionDetailSecondView:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function MazeActivityCollectionDetailSecondView:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function MazeActivityCollectionDetailSecondView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MazeActivityCollectionDetailSecondView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MazeActivityCollectionDetailSecondView:Refresh(Data)
	self.data = Data

	UGUIUtil.SetText(self.collectionDescText, CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].ItemTips)
	UGUIUtil.SetText(self.collectionTitle, string.format("【%s】", CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].Name))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].Icon), self.collectionImg:GetComponent("Image"))
end

function MazeActivityCollectionDetailSecondView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
end

return MazeActivityCollectionDetailSecondView
