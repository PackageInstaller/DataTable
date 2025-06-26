-- chunkname: @IQIGame\\UI\\ChapterUnlockUI.lua

local ChapterUnlockUI = {}

ChapterUnlockUI = Base:Extend("ChapterUnlockUI", "IQIGame.Onigao.UI.ChapterUnlockUI", ChapterUnlockUI)

function ChapterUnlockUI:OnInit()
	function self.DelegateOnClickCloseButton()
		UIModule.CloseSelf(self)
	end

	function self.delegateOnTimelineStopped(playableDirector)
		self:OnTimelineCompleted(playableDirector)
	end
end

function ChapterUnlockUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

local stoped = false

function ChapterUnlockUI:OnOpen(queue)
	self:Show()
	CoroutineUtility.StartCoroutine(function()
		while queue.Size > 0 do
			local chapter = queue:Peek()

			self:LoadImg(chapter.ChapterUnlock, self.chapterImg)
			self:LoadImg(chapter.ChapterUnlockNum, self.chapterFontImg)
			self:LoadImg(chapter.ChapterUnlockLogo, self.chapterLogoImg)
			UGUIUtil.SetText(self.chapterNameText, chapter.Desc)
			UGUIUtil.SetText(self.chapterNameEnglishText, chapter.EngName)

			local playableDirector = self.View:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

			playableDirector.stopped = playableDirector.stopped + self.delegateOnTimelineStopped
			stoped = false

			playableDirector.gameObject:SetActive(true)
			playableDirector:Play()
			CoroutineUtility.Yield(WaitUntil(function()
				return stoped
			end))
			queue:Dequeue()

			playableDirector.stopped = playableDirector.stopped - self.delegateOnTimelineStopped
		end

		UIModule.CloseSelf(self)
	end)
end

function ChapterUnlockUI:OnTimelineCompleted(completePlayableDirector)
	stoped = true
end

function ChapterUnlockUI:OnClose(userData)
	self:Hide()
end

function ChapterUnlockUI:OnAddListeners()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseButton)
end

function ChapterUnlockUI:OnRemoveListeners()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseButton)
end

function ChapterUnlockUI:GetPreloadAssetPaths()
	return nil
end

function ChapterUnlockUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChapterUnlockUI:IsManualShowOnOpen(userData)
	return false
end

function ChapterUnlockUI:GetBGM(userData)
	return nil
end

function ChapterUnlockUI:OnPause()
	return
end

function ChapterUnlockUI:OnResume()
	return
end

function ChapterUnlockUI:OnCover()
	return
end

function ChapterUnlockUI:OnReveal()
	return
end

function ChapterUnlockUI:OnRefocus(userData)
	return
end

function ChapterUnlockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChapterUnlockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChapterUnlockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChapterUnlockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChapterUnlockUI:LoadImg(path, imgObj)
	AssetUtil.LoadImage(self, path, imgObj:GetComponent("Image"))
end

function ChapterUnlockUI:Show()
	self.gameObject:SetActive(true)
end

function ChapterUnlockUI:Hide()
	self.gameObject:SetActive(false)
end

return ChapterUnlockUI
