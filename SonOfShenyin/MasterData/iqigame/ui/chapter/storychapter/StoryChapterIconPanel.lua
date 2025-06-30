-- chunkname: @IQIGame\\UI\\Chapter\\StoryChapter\\StoryChapterIconPanel.lua

local StoryChapterIconPanel = {}

function StoryChapterIconPanel.New(prefab, parentTransform, id)
	local view = Clone(StoryChapterIconPanel)
	local gameObject = UnityEngine.GameObject.Instantiate(prefab, parentTransform)

	gameObject:SetActive(true)

	view.chapterID = id
	view.chapterConfig = StoryChapterModule.GetChapterByID(id)

	view:OnInit(gameObject)

	return view
end

function StoryChapterIconPanel:OnInit(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(gameObject, self)
	gameObject:SetActive(true)

	function self.DelegateOnClickEnterChapterButton()
		self:OnClickEnterChapterButton()
	end

	if ConditionModule.Check(self.chapterConfig.UnlockConditionId) then
		AssetUtil.LoadImage(self, MainChapterUIApi:GetUnlockedChapterIconImagePath(self.chapterID), self.BgImage:GetComponent(typeof(UnityEngine.UI.Image)))
		self.UnlockedParent:SetActive(true)
		UGUIUtil.SetText(self.ProgressText, MainChapterUIApi:FormatProgressText(self.chapterID))
		LuaUtility.SetImageFillAmount(self.ProgressBarImage, StoryChapterModule:GetChapterProgress(self.chapterID))
	else
		AssetUtil.LoadImage(self, MainChapterUIApi:GetLockedChapterIconImagePath(self.chapterID), self.BgImage:GetComponent(typeof(UnityEngine.UI.Image)))
		self.LockedParent:SetActive(true)
		UGUIUtil.SetText(self.UnlockedConditionText, ConditionModule.GetDesc(self.chapterConfig.UnlockConditionId))
	end

	self:OnAddListeners()
end

function StoryChapterIconPanel:OnDestroy(userData)
	logDebug("ChapterIconPanel:OnDestroy")
	AssetUtil.UnloadAsset(self)
	self:OnRemoveListeners()

	local gb = self.gameObject

	LuaCodeInterface.ClearOutlet(gb, self)
	gb.transform:SetParent(nil, false)
	UnityEngine.GameObject.Destroy(gb)
end

function StoryChapterIconPanel:OnAddListeners()
	self.Button:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickEnterChapterButton)
end

function StoryChapterIconPanel:OnRemoveListeners()
	self.Button:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickEnterChapterButton)
end

function StoryChapterIconPanel:OnClickEnterChapterButton()
	if not ConditionModule.Check(StoryChapterModule.GetChapterByID(self.chapterID).UnlockConditionId) then
		NoticeModule.ShowNotice(49005)
	else
		UIModule.Open(Constant.UIControllerName.StoryChapterUI, Constant.UILayer.UI, {
			chapterID = self.chapterID
		})
	end
end

return StoryChapterIconPanel
