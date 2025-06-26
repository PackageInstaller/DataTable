-- chunkname: @IQIGame\\UI\\LibraryNewsPaperUI.lua

local LibraryNewsPaperUI = Base:Extend("LibraryNewsPaperUI", "IQIGame.Onigao.UI.LibraryNewsPaperUI", {})
local LibraryNewsLoginView = require("IQIGame.UI.Library.LibraryNewsLoginView")
local LibraryNewsListView = require("IQIGame.UI.Library.LibraryNewsListView")
local LibraryNewsMsgView = require("IQIGame.UI.Library.LibraryNewsMsgView")

function LibraryNewsPaperUI:OnInit()
	self.newsLoginView = LibraryNewsLoginView.New(self.NewsLoginView, self)
	self.newsListView = LibraryNewsListView.New(self.NewsListView, self)

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	function self.delegateUpdateLibraryNews(newData)
		self:OnUpdateLibraryNews(newData)
	end
end

function LibraryNewsPaperUI:GetPreloadAssetPaths()
	return nil
end

function LibraryNewsPaperUI:GetOpenPreloadAssetPaths(userData)
	self.newsPrefabType = {
		UIGlobalApi.GetPrefabRoot("/UI/_LibraryUI/NewsPaper_Mould01.prefab"),
		UIGlobalApi.GetPrefabRoot("/UI/_LibraryUI/NewsPaper_Mould02.prefab"),
		UIGlobalApi.GetPrefabRoot("/UI/_LibraryUI/NewsPaper_Mould03.prefab"),
		UIGlobalApi.GetPrefabRoot("/UI/_LibraryUI/NewsPaper_Mould04.prefab"),
		UIGlobalApi.GetPrefabRoot("/UI/_LibraryUI/NewsPaper_Mould05.prefab")
	}

	return self.newsPrefabType
end

function LibraryNewsPaperUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryNewsPaperUI:GetBGM(userData)
	return nil
end

function LibraryNewsPaperUI:OnOpen(userData)
	self.openNewsData = userData

	self.newsLoginView:Open()
	self.newsListView:Close()
	self.BtnGetReward:SetActive(false)

	local isShow = true

	if self.openNewsData then
		self:OpenNewsView(self.openNewsData, function()
			self:OnBtnClose()
		end)

		isShow = false
	end

	self.Bg:SetActive(isShow)
	self.BackGround:SetActive(isShow)
end

function LibraryNewsPaperUI:OnClose(userData)
	return
end

function LibraryNewsPaperUI:OnAddListeners()
	self.BtnGetReward:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)
end

function LibraryNewsPaperUI:OnRemoveListeners()
	self.BtnGetReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)
end

function LibraryNewsPaperUI:OnPause()
	return
end

function LibraryNewsPaperUI:OnResume()
	return
end

function LibraryNewsPaperUI:OnCover()
	return
end

function LibraryNewsPaperUI:OnReveal()
	return
end

function LibraryNewsPaperUI:OnRefocus(userData)
	return
end

function LibraryNewsPaperUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryNewsPaperUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryNewsPaperUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryNewsPaperUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryNewsPaperUI:OnDestroy()
	self.newsLoginView:Dispose()
	self.newsListView:Dispose()

	if self.mewsMsgView then
		self.mewsMsgView:Dispose()
	end
end

function LibraryNewsPaperUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryNewsPaperUI)
end

function LibraryNewsPaperUI:OpenTypeNews(type)
	local canOpen = false

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.isLock and v.cfgInfo.PaperType == type then
			canOpen = true

			break
		end
	end

	if not canOpen then
		NoticeModule.ShowNoticeNoCallback(21042501)

		return
	end

	self.newsLoginView:Close()
	self.newsListView:Open()
	self.newsListView:UpdateView(type)
end

function LibraryNewsPaperUI:OnCloseListView()
	self.newsListView:Close()
	self.newsLoginView:Open()
	self.BtnGetReward:SetActive(false)
end

function LibraryNewsPaperUI:OpenNewsView(newsData, callback)
	if newsData then
		if self.mewsMsgView then
			self.mewsMsgView:Dispose()
		end

		local path = self.newsPrefabType[newsData.cfgInfo.PrefabsType]
		local newsPrefab = self.UIController:GetPreloadedAsset(path)
		local obj = UnityEngine.Object.Instantiate(newsPrefab)

		obj.transform:SetParent(self.NewsPaperPoint.transform, false)

		self.mewsMsgView = LibraryNewsMsgView.New(obj, self)
		self.mewsMsgView.closeCallBack = callback

		self.mewsMsgView:Open(newsData)
		self:UpdateGetRewardState(newsData)
	end
end

function LibraryNewsPaperUI:UpdateGetRewardState(newsData)
	self.BtnGetReward:SetActive(true)

	self.selectNewData = newsData

	local state = newsData:GetRewardState()

	self.ImgLock:SetActive(state == 1)
	self.ImgUnlock:SetActive(state == 2)
	self.ImgGot:SetActive(state == 3)
end

function LibraryNewsPaperUI:OnUpdateLibraryNews(newDate)
	if self.selectNewData and self.selectNewData.cfgID == newDate.cfgID then
		self:UpdateGetRewardState(newDate)
	end
end

function LibraryNewsPaperUI:OnBtnGetReward()
	if self.selectNewData and self.selectNewData:IsGetReward() then
		TownLibraryModule.GetNewsBookRewards(self.selectNewData.cfgID)
	end
end

return LibraryNewsPaperUI
