-- chunkname: @IQIGame\\UI\\Story\\StoryUIDialogueSelectPanel.lua

local StoryUIDialogueSelectPanel = class(nil, BaseChildrenPanel)
local DialogueSelectPanelSelectItemClass = require("IQIGame.UI.Story.DialogueSelectPanelSelectItem")
local selectCount = 6

function StoryUIDialogueSelectPanel.New(go, mainView)
	local o = Clone(StoryUIDialogueSelectPanel)

	o:Initialize(go, mainView)

	return o
end

function StoryUIDialogueSelectPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryUIDialogueSelectPanel:InitComponent()
	self.selectItemViewList = {}

	local childCount = selectCount + 1

	for i = 2, childCount do
		local trans = LuaUtility.GetChild(self.selectContent.transform, i - 1)
		local item = DialogueSelectPanelSelectItemClass.New(LuaUtility.GetChild(trans, 0).gameObject, self)

		table.insert(self.selectItemViewList, item)
	end

	self.FloatEffectComponent = LuaUtility.GameObjectGetOrAddComponent(self.selectContent, typeof(IQIGame.Onigao.Game.FloatEffectComponent))

	local publicParametersData = CfgUtil.GetPublicParametersData()
	local AsideViewFloatOffset = publicParametersData.AsideViewFloatOffset
	local v = Vector3.New(AsideViewFloatOffset.x, AsideViewFloatOffset.y, 0)

	self.FloatEffectComponent:Init(v, publicParametersData.AsideViewFloatFrequency)

	self.FloatEffectComponent.enabled = true
	self.selectContentRect = self.selectContent:GetComponent("RectTransform")
	self.StoryUIRect = self.mainUI:GetComponent("RectTransform")
end

function StoryUIDialogueSelectPanel:InitDelegate()
	function self.buttonMaskDelegate()
		self:OnButtonMaskClick()
	end
end

function StoryUIDialogueSelectPanel:AddListener()
	self.buttonMask:GetComponent("Button").onClick:AddListener(self.buttonMaskDelegate)
end

function StoryUIDialogueSelectPanel:RemoveListener()
	self.buttonMask:GetComponent("Button").onClick:RemoveListener(self.buttonMaskDelegate)
end

function StoryUIDialogueSelectPanel:OnOpen()
	LuaUtility.PlayAnimation(self.selectContent, "selectContent_In", nil, function()
		self.isPlayingSelectAnimation = false
	end)

	self.isPlayingSelectAnimation = true
end

function StoryUIDialogueSelectPanel:OnDestroy()
	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryUIDialogueSelectPanel:OnButtonMaskClick()
	if not self.canClose then
		return
	end

	if self.isPlayingSelectAnimation then
		return
	end

	self:ActionClose(false, 0)
	self:Close()
end

function StoryUIDialogueSelectPanel:ActionClose(isTaskComplete, optionNum)
	if isTaskComplete then
		self.currentShowDialogueSelectionTask:SetReturnNum(optionNum)
		self.currentShowDialogueSelectionTask:TaskComplete()
	else
		self.currentShowDialogueSelectionTask:TaskFailure()
	end
end

function StoryUIDialogueSelectPanel:Refresh(npcID, selectCfgID, ShowDialogueSelectionTask)
	self.selectCfgID = selectCfgID
	self.currentShowDialogueSelectionTask = ShowDialogueSelectionTask

	local storyNPC = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if LuaUtility.StrIsNullOrEmpty(storyNPC.stringDialogueFollower) then
		logError("【剧情】试图打开对话选项界面,但是NPC没有配置对话选项挂点,npcID = %s,npcName = %s", npcID, storyNPC:GetName())

		return
	end

	local objectTrans = storyNPC.transform:Find(storyNPC.stringDialogueFollower)

	if not objectTrans then
		logError(string.format("【剧情】npc %s ID = %s 没有找到线索触发挂点名 = %s", storyNPC:GetName(), npcID, storyNPC.stringDialogueFollower))

		return
	end

	local cfg = CfgUtil.GetCfgStoryOptionDataWithID(selectCfgID)

	self.CfgStoryOptionData = cfg

	LuaUtility.SetText(self.questionText, cfg.Des)
	self:SetFollowNpc(objectTrans.transform.position)
	self:RefreshDialogueSelection(cfg)
	LuaUtility.LimitUIPosToScreen(self.StoryUIRect, self.selectContentRect, 30, 20)
end

function StoryUIDialogueSelectPanel:SetFollowNpc(npcPos)
	local screenPos = LuaUtility.WorldToScreenPos(StoryModule.mainCamera, npcPos)
	local worldPos = LuaUtility.ScreenToWorldPos(GameEntry.UICamera, screenPos, 100)

	LuaUtility.SetPositionWithGameObject(self.selectContent, worldPos.x, worldPos.y, worldPos.z)
end

function StoryUIDialogueSelectPanel:RefreshDialogueSelection(cfgStoryOption)
	if cfgStoryOption.OptionType ~= Constant.StoryOptionType.Dialogue then
		logError(string.format("【剧情】试图开启对话选项，但是配置的类型错误，配置类型为 %s。正确类型应该为 %s", cfgStoryOption.OptionType, Constant.StoryOptionType.Dialogue))

		return
	end

	local needShowList = {}

	for i = 1, #cfgStoryOption.Options do
		if StoryModule.CheckOptionIsShow(cfgStoryOption.Id, cfgStoryOption.Options[i]) then
			table.insert(needShowList, cfgStoryOption.Options[i])
		end
	end

	local index = 1

	for i = 1, #needShowList do
		if i <= #self.selectItemViewList then
			self.selectItemViewList[i]:Refresh(needShowList[i], cfgStoryOption.Id)
			self.selectItemViewList[i]:Show()
		end

		index = i
	end

	index = index + 1

	for i = index, #self.selectItemViewList do
		self.selectItemViewList[i]:Hide()
	end

	self:SetCanClose(cfgStoryOption.CanQuit)
end

function StoryUIDialogueSelectPanel:SetCanClose(canClose)
	self.canClose = canClose
end

function StoryUIDialogueSelectPanel:OnOptionClick(num)
	self:ActionClose(true, num)
	StoryModule.SetTriggerOption(self.selectCfgID, num)
	StoryModule.AddDialogueReviewData(Constant.DialogueReviewType.Option, self.selectCfgID, num)
end

function StoryUIDialogueSelectPanel:PlayHideSelectAnimation(except)
	for i = 1, #self.selectItemViewList do
		if self.selectItemViewList[i].optionID ~= except then
			self.selectItemViewList[i]:PlayHideAnimation()
		end
	end

	LuaUtility.PlayAnimation(self.selectContent, "selectContent_Out")

	self.isPlayingSelectAnimation = true
end

return StoryUIDialogueSelectPanel
