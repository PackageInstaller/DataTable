-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleStageView.lua

local RoleStageView = {}
local RoleStageItemView = require("IQIGame.UI.RoleInfoDetails.RoleStageItemView")
local MapMainChapterPanel = require("IQIGame.UI.RoleInfoDetails.MapMainChapterPanel_Favor")
local HeroStageAwardShowPanel = require("IQIGame.UI.RoleInfoDetails.HeroStageAwardShowPanel")

function RoleStageView.New(go, mainView)
	local o = Clone(RoleStageView)

	o:Initialize(go, mainView)

	return o
end

function RoleStageView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function RoleStageView:InitMembers()
	self.stageViewList = {}
	self.stageDataList = {}
end

function RoleStageView:InitComponent()
	self.stageScroll = self.stageScroll:GetComponent("OptimizedScrollRect")

	self.stageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:StageScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)

	self.mainChapterPanel = MapMainChapterPanel.New(self.MainChapterPanel)
	self.stageAwardPanel = HeroStageAwardShowPanel.New(self.awardShowTipsPanel)
end

function RoleStageView:InitDelegate()
	function self.RefreshEvent()
		self:SetData(self.heroCid)
	end
end

function RoleStageView:AddListener()
	EventDispatcher.AddEventListener(EventID.RoleStageViewRefreshEvent, self.RefreshEvent)
end

function RoleStageView:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.RoleStageViewRefreshEvent, self.RefreshEvent)
end

function RoleStageView:SetData(heroCid)
	self.heroCid = heroCid

	self:RefreshStageScroll(heroCid)
	self.mainChapterPanel:Hide()
end

function RoleStageView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function RoleStageView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function RoleStageView:Dispose()
	self:RemoveListener()
	self.mainChapterPanel:Dispose()
	self.stageAwardPanel:OnDestroy()

	for _, v in pairs(self.stageViewList) do
		v:OnDestroy()
	end

	self.stageViewList = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function RoleStageView:RefreshStageScroll(heroCid)
	self.stageDataList = RoleInfoDetailsModule.GetHeroStoryList(heroCid)

	self.stageScroll:RefreshByItemCount(#self.stageDataList)
end

function RoleStageView:StageScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.stageDataList[index + 1]

	if not self.stageViewList[instanceID] then
		self.stageViewList[instanceID] = RoleStageItemView.New(viewGameObject, self)
	end

	self.stageViewList[instanceID]:Refresh(data, index + 1)
end

function RoleStageView:ShowStageDetail(id)
	self.mainChapterPanel:SetData(id)
end

function RoleStageView:ShowStageAward(dropArray)
	local awardList = {}
	local len = #dropArray

	for i = 1, len do
		local cfgDrop = CfgUtil.GetCfgDropLibDataWithID(dropArray[i])
		local showItemLen = #cfgDrop.DropShowItem

		for j = 1, showItemLen do
			local t = {}

			t.id = cfgDrop.DropShowItem[j]
			t.count = cfgDrop.GiftItemCount[j]

			table.insert(awardList, t)
		end
	end

	self.stageAwardPanel:Refresh(awardList)
	self.stageAwardPanel:Show()
end

return RoleStageView
