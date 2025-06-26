-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityCollectionRewardView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local MazeActivityCollectionRewardView = {}

function MazeActivityCollectionRewardView.New(go, mainView)
	local o = Clone(MazeActivityCollectionRewardView)

	o:Initialize(go, mainView)

	return o
end

function MazeActivityCollectionRewardView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeActivityCollectionRewardView:InitComponent()
	self.previewItemPool = UIViewObjectPool.New(self.rewardItem, self.rewardContent.transform, function(_view)
		return ItemCell.New(_view)
	end)
end

function MazeActivityCollectionRewardView:InitDelegate()
	function self.delegateOnClickGetBtn()
		TaskSystemModule.SubmitTask({
			self.data.cid
		})
	end
end

function MazeActivityCollectionRewardView:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
	self.getBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGetBtn)
end

function MazeActivityCollectionRewardView:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
	self.getBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGetBtn)
end

function MazeActivityCollectionRewardView:Show()
	LuaUtility.SetGameObjectShow(self.rewardItem, false)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MazeActivityCollectionRewardView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MazeActivityCollectionRewardView:Refresh(mainTaskData)
	self.data = mainTaskData

	self:RefreshReward()
end

function MazeActivityCollectionRewardView:RefreshReward()
	local ActionParamNormal = UIUtil.GetConfigArr(self.data.BaseData.ActionParam)

	self.rewardList = ActionParamNormal

	self.previewItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #self.rewardList do
		local previewItem = self.previewItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		previewItem:SetItemByCid(self.rewardList[1][1])
		previewItem:SetNum(self.rewardList[1][2])
		previewItem:Show()
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].Icon), self.imageTask:GetComponent("Image"))
	UGUIUtil.SetText(self.itemNameText, string.format("【%s】", CfgItemTable[self.data.cfgTaskConfig.EventParam[1]].Name))
end

function MazeActivityCollectionRewardView:OnDestroy()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil
end

return MazeActivityCollectionRewardView
