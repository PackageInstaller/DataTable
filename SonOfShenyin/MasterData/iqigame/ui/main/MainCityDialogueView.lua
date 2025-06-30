-- chunkname: @IQIGame\\UI\\Main\\MainCityDialogueView.lua

local mainCityDialogueSpeakView = require("IQIGame.UI.Main.MainCityDialogueSpeakView")
local m = {
	maxDialogueIndex = 0,
	curDialogueIndex = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.mainCityDialogueSpeakPanel = mainCityDialogueSpeakView.New(self.speakPanelPrefab)

	self.mainCityDialogueSpeakPanel:Hide()

	function self.DelegateOnJumpDialogue()
		self:OnJumpDialogue()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmConversationButton:GetComponent("LongButton").onClick:AddListener(self.DelegateOnJumpDialogue)
end

function m:RemoveListeners()
	self.ConfirmConversationButton:GetComponent("LongButton").onClick:RemoveListener(self.DelegateOnJumpDialogue)
end

function m:OpenDialogue(eventID, targetView)
	self:Show()

	self.EventID = eventID
	self.interactiveObj = targetView
	self.dialogueList = MainCityDialogueModule.GetDialogueList(self.EventID)
	self.maxDialogueIndex = #self.dialogueList
	self.curDialogueIndex = 1

	self:StartDialogue()
end

function m:StartDialogue()
	self.interactiveObj:SetCharacterDialogueState()
	MainCityModule.showPlayer:SetCharacterDialogueState()
	self:EnableOrDisableJumpBtn(true)
	MainCityModule.PlayCameraAnim(function()
		self.mainCityDialogueSpeakPanel:Show()
		self:PlayDialogue()
	end, true)
end

function m:PlayDialogue()
	local curSotoryTextCfg = CfgRoleStoryTextTable[self.dialogueList[self.curDialogueIndex]]
	local targetView = curSotoryTextCfg.SpeakNPC == 0 and MainCityModule.showPlayer or self.interactiveObj
	local targetName = curSotoryTextCfg.SpeakNPC == 0 and PlayerModule.PlayerInfo.baseInfo.pName or CfgHeroTable[curSotoryTextCfg.SpeakNPC].Name
	local content = curSotoryTextCfg.SpeakContent

	if PlayerModule.PlayerInfo.baseInfo.sex == 1 and not LuaUtility.StrIsNullOrEmpty(curSotoryTextCfg.SpeakContent_Female) then
		content = curSotoryTextCfg.SpeakContent_Female
	end

	self.mainCityDialogueSpeakPanel:UpdateViewPosByTarget(targetView.gameObject)
	self.mainCityDialogueSpeakPanel:UpdateNameText(targetName)
	self.mainCityDialogueSpeakPanel:SetNpcNameTextProgress()
	self.mainCityDialogueSpeakPanel:UpdateContentText(content)
	self.mainCityDialogueSpeakPanel:UpdateDialogueProgress()
	targetView:RefreshAnimationListData(MainCityDialogueModule.GetAnimationNameList(curSotoryTextCfg.AnimationName), curSotoryTextCfg.AnimationLoop, curSotoryTextCfg.AnimationWhenNext, curSotoryTextCfg.AnimationWhenNextLoop)
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.mainCityDialogueSpeakPanel:Update(elapseSeconds, realElapseSeconds)
end

function m:OnJumpDialogue()
	if not self.mainCityDialogueSpeakPanel:IsCanNextDialogue() then
		return
	end

	self.curDialogueIndex = self.curDialogueIndex + 1

	if self.curDialogueIndex > self.maxDialogueIndex then
		self:EnableOrDisableJumpBtn(false)
		self.interactiveObj:SetCharacterIdleState()
		MainCityModule.showPlayer:SetCharacterIdleState()
		MainCityModule.showPlayer:PlayIdleAnimation()
		self.mainCityDialogueSpeakPanel:ClearDialogueInfo()
		MainCityModule.PlayCameraAnim(function()
			PlayerModule.GetEventAward(self.EventID)
			self:Hide()
		end, false)

		return
	end

	self:PlayDialogue()
end

function m:EnableOrDisableJumpBtn(state)
	self.ConfirmConversationButton:GetComponent("Button").enabled = state
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.ConfirmConversationButton, true)
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.ConfirmConversationButton, false)
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.mainCityDialogueSpeakPanel:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
