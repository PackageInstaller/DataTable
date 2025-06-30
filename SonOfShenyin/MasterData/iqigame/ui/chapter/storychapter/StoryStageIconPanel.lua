-- chunkname: @IQIGame\\UI\\Chapter\\StoryChapter\\StoryStageIconPanel.lua

local StoryStageIconPanel = {}

function StoryStageIconPanel.New(chapterView, prefab, parentTransform, id)
	local view = Clone(StoryStageIconPanel)
	local gameObject = UnityEngine.GameObject.Instantiate(prefab, parentTransform)

	view.stageID = id
	view.stageConfig = StoryChapterModule.GetStageByID(id)
	view.chapterView = chapterView

	view:OnInit(gameObject)

	return view
end

function StoryStageIconPanel:OnInit(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(gameObject, self)
	self.gameObject:SetActive(true)

	function self.DelegateOnOpenStageDetailButton()
		self:OnOpenStageDetailButton()
	end

	local transform = self.gameObject.transform

	transform.localPosition = Vector3.New(tonumber(self.stageConfig.Location[1]), tonumber(self.stageConfig.Location[2]), tonumber(self.stageConfig.Location[3]))

	UGUIUtil.SetText(self.NameText, self.stageConfig.Name)

	local isUnlock = ConditionModule.Check(self.stageConfig.UnlockConditionId)

	if StoryChapterModule.FinishDupDict[self.stageID] then
		AssetUtil.LoadImage(self, StoryStageUIApi:GetStageInvestigatedImage(), self.BgImage:GetComponent(typeof(UnityEngine.UI.Image)))
	elseif isUnlock then
		AssetUtil.LoadImage(self, StoryStageUIApi:GetStageInvestigatingImage(), self.BgImage:GetComponent(typeof(UnityEngine.UI.Image)))
	else
		AssetUtil.LoadImage(self, StoryStageUIApi:GetStageToBeInvestigatedImage(), self.BgImage:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	if not ConditionModule.Check(self.stageConfig.UnlockConditionId) then
		self.UnlockStateImg:SetActive(true)
		UGUIUtil.SetText(self.UnlockText, ConditionModule.GetDesc(self.stageConfig.UnlockConditionId))
	end

	self:OnAddListeners()
end

function StoryStageIconPanel:OnDestroy(userData)
	logDebug("StoryStageIconPanel:OnDestroy")
	AssetUtil.UnloadAsset(self)
	self:OnRemoveListeners()

	local gb = self.gameObject

	LuaCodeInterface.ClearOutlet(gb, self)
	gb.transform:SetParent(nil, false)
	UnityEngine.GameObject.Destroy(gb)
end

function StoryStageIconPanel:OnAddListeners()
	self.Button:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnOpenStageDetailButton)
end

function StoryStageIconPanel:OnRemoveListeners()
	self.Button:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnOpenStageDetailButton)
end

function StoryStageIconPanel:OnOpenStageDetailButton()
	if not ConditionModule.Check(self.stageConfig.UnlockConditionId) then
		NoticeModule.ShowNotice(49005)
	else
		self.chapterView.StoryStageDetailView:Show(self.stageID)
	end

	self.chapterView.SimpleScrollSnap:GoToPanel(self.stageConfig.Index)
end

return StoryStageIconPanel
