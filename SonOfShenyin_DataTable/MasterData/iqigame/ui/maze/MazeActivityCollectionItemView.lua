-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityCollectionItemView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local MazeUIShopLevelUpElement = require("IQIGame/UI/Maze/MazeUIShopLevelUpElement")
local GiftBagShopCell = require("IQIGame.UI.Shop.GiftBagShopCell")
local SubCollectionItemCell = {}

function SubCollectionItemCell.New(view, clickHandler)
	local obj = Clone(SubCollectionItemCell)

	obj:__Init(view, clickHandler)

	return obj
end

function SubCollectionItemCell:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnClickItemBtn()
		self:OnClickItemBtn()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.delegateOnClickItemBtn)
end

function SubCollectionItemCell:Show(data)
	self.gameObject:SetActive(true)
	self:__RefreshShow(data)
end

function SubCollectionItemCell:__RefreshShow(data)
	self.data = data
	self.isFinish = data.status == Constant.TaskStatus.hadGot or data.status == Constant.TaskStatus.hasDone

	LuaUtility.SetGameObjectShow(self.collectionImg, self.isFinish)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[data.cfgTaskConfig.EventParam[1]].Icon), self.collectionImg:GetComponent("Image"))
end

function SubCollectionItemCell:OnClickItemBtn()
	if not self.isFinish then
		return
	end

	if self.clickHandler ~= nil then
		self.clickHandler(self.data)
	end
end

function SubCollectionItemCell:Hide()
	self.gameObject:SetActive(false)
end

function SubCollectionItemCell:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickItemBtn)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local MazeActivityCollectionItemView = {}

function MazeActivityCollectionItemView.New(go, mainView)
	local o = Clone(MazeActivityCollectionItemView)

	o:Initialize(go, mainView)

	return o
end

function MazeActivityCollectionItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeActivityCollectionItemView:InitComponent()
	self.subCollectionItemPool = UIViewObjectPool.New(self.detailPrefab, self.subCollectionGrid.transform, function(_view)
		return SubCollectionItemCell.New(_view, function(data)
			self:SubItemClick(data)
		end)
	end)
end

function MazeActivityCollectionItemView:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function MazeActivityCollectionItemView:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function MazeActivityCollectionItemView:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function MazeActivityCollectionItemView:OnClickButtonClick()
	if self.data.mainData.status == Constant.TaskStatus.doing then
		return
	end

	if self.data.mainData.status == Constant.TaskStatus.hadGot then
		self.mainView:RefreshDetailMainInfoView(self.data.mainData)

		return
	end

	self.mainView:RefreshRewardView(self.data.mainData)
end

function MazeActivityCollectionItemView:SubItemClick(data)
	self.mainView:RefreshDetailSecondInfoView(data)
end

function MazeActivityCollectionItemView:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function MazeActivityCollectionItemView:Refresh(data)
	self.data = data

	LuaUtility.SetText(self.textName, self.data.mainData.cfgTaskConfig.Name)
	LuaUtility.SetGameObjectShow(self.imageItem, self.data.mainData.status == Constant.TaskStatus.hadGot or self.data.mainData.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.noItemImage, self.data.mainData.status == Constant.TaskStatus.doing)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[data.mainData.cfgTaskConfig.EventParam[1]].Icon), self.imageItem:GetComponent("Image"))
	self.subCollectionItemPool:ForItems(function(_item)
		return _item:Hide()
	end)

	for i = 1, #self.data.childData do
		local subCollectionItem = self.subCollectionItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		subCollectionItem:Show(self.data.childData[i])
	end
end

return MazeActivityCollectionItemView
