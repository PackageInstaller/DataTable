-- chunkname: @IQIGame\\UI\\NewMemoryWindownUI.lua

local NewMemoryWindownUI = Base:Extend("NewMemoryWindownUI", "IQIGame.Onigao.UI.NewMemoryWindownUI", {})
local MemoryNewStoryChapterItem = require("IQIGame.UI.Memory.MemoryNewStoryChapterItem")

function NewMemoryWindownUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateOnMemoryLockReady()
		self:OnMemoryLockReady()
	end
end

function NewMemoryWindownUI:GetPreloadAssetPaths()
	return nil
end

function NewMemoryWindownUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function NewMemoryWindownUI:OnOpen(userData)
	self:UpDateView(userData)
end

function NewMemoryWindownUI:OnClose(userData)
	self.selectObj = nil
end

function NewMemoryWindownUI:OnAddListeners()
	self.BtnCloseBack:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.MemoryStoryChapterDataRefreshEvent, self.delegateOnMemoryLockReady)
end

function NewMemoryWindownUI:OnRemoveListeners()
	self.BtnCloseBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryChapterDataRefreshEvent, self.delegateOnMemoryLockReady)
end

function NewMemoryWindownUI:OnPause()
	return
end

function NewMemoryWindownUI:OnResume()
	return
end

function NewMemoryWindownUI:OnCover()
	return
end

function NewMemoryWindownUI:OnReveal()
	return
end

function NewMemoryWindownUI:OnRefocus(userData)
	return
end

function NewMemoryWindownUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function NewMemoryWindownUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NewMemoryWindownUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NewMemoryWindownUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NewMemoryWindownUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.chapterItems then
		for i, v in pairs(self.chapterItems) do
			v:DisPose()
		end
	end
end

function NewMemoryWindownUI:OnMemoryLockReady()
	if self.newStoryInfo then
		local storyInfo = MemoryNewModule.dictMemoryStoryInfo[self.newStoryInfo.cid]

		self:UpDateView(storyInfo)
	end
end

function NewMemoryWindownUI:UpDateView(newStoryInfo)
	self.newStoryInfo = newStoryInfo

	if self.newStoryInfo then
		self.chapterName:GetComponent("Text").text = self.newStoryInfo.cfgSoulNewStory.Name

		local imgPath = UIGlobalApi.GetImagePath(self.newStoryInfo.cfgSoulNewStory.InsideImage)

		AssetUtil.LoadImage(self, imgPath, self.chapterInIcon:GetComponent("Image"))

		self.chapterInIcon.transform.anchoredPosition = Vector2(self.newStoryInfo.cfgSoulNewStory.InsideImagePosition[1], self.newStoryInfo.cfgSoulNewStory.InsideImagePosition[2])
		self.chapterInIcon.transform.sizeDelta = Vector2.New(self.newStoryInfo.cfgSoulNewStory.InsideImageSize[1], self.newStoryInfo.cfgSoulNewStory.InsideImageSize[2])

		if self.chapterItems then
			for i, v in pairs(self.chapterItems) do
				v:DisPose()
				UnityEngine.GameObject.DestroyImmediate(v.goView)
			end
		end

		self.chapterItems = {}

		local parentTransform = self.chapterContent.transform
		local num, totalNum = self.newStoryInfo:GetChapterData()

		for i = 1, totalNum do
			local obj = UnityEngine.Object.Instantiate(self.Mould)

			obj:SetActive(true)
			obj.transform:SetParent(parentTransform, false)

			local chapterItem = MemoryNewStoryChapterItem:__New(obj)

			chapterItem:RefreshUI(self.newStoryInfo, i)
			table.insert(self.chapterItems, chapterItem)
		end
	end
end

function NewMemoryWindownUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.NewMemoryWindownUI)
end

return NewMemoryWindownUI
