-- chunkname: @IQIGame\\UI\\Story\\SpeakView.lua

local SpeakView = {}

function SpeakView.New(obj, npcID, npcName, storyDialogueCid, dialogueContent, canvas, speakCfgId)
	local speakView = Clone(SpeakView)

	speakView:Init(obj, npcID, npcName, storyDialogueCid, dialogueContent, canvas, speakCfgId)

	return speakView
end

function SpeakView:Init(obj, npcID, npcName, storyDialogueCid, dialogueContent, canvas, speakCfgId)
	self.gameObject = obj
	self.canvas = canvas
	self.speakCfgId = speakCfgId

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.npcNameTextBackgroundSource = self.speakerName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.contentTextBackgroundSource = self.speakContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.nameBackground = self.speakerNameBackground:GetComponent(typeof(BordlessFramework.UI.TextBackground))
	self.contentBackground = self.speakContentBackground:GetComponent(typeof(BordlessFramework.UI.TextBackground))

	self.nameBackground.material:SetFloat("_DisplayAlpha", 1)
	self.contentBackground.material:SetFloat("_DisplayAlpha", 1)

	self.npcID = npcID

	self:ResetFollowNpc()

	self.FloatEffectComponent = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(IQIGame.Onigao.Game.FloatEffectComponent))

	local publicParametersData = CfgUtil.GetPublicParametersData()
	local SpeakViewFloatOffset = publicParametersData.SpeakViewFloatOffset
	local v = Vector3.New(SpeakViewFloatOffset.x, SpeakViewFloatOffset.y, 0)

	self.FloatEffectComponent:Init(v, publicParametersData.SpeakViewFloatFrequency)
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SpeakView:Open(storyDialogueCid, npcName, dialogueContent, npcId, speakCfgId)
	if self.FadeSequence then
		self.FadeSequence:Complete(true)
	end

	if self.gameObject.activeSelf then
		self.isOpenAgain = false
	else
		self.isOpenAgain = true
	end

	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.npcID = npcId
	self.speakCfgId = speakCfgId

	self:OnOpen(storyDialogueCid, npcName, dialogueContent)
end

function SpeakView:Close()
	self:PlayFadeAnimation()
end

function SpeakView:OnOpen(storyDialogueCid, npcName, dialogueContent)
	self:AddListeners()

	self.UIFollowerComponent.enabled = true
	self.FloatEffectComponent.enabled = true

	if self.isOpenAgain then
		self:Refresh(storyDialogueCid, npcName, dialogueContent)
		self:PlayOpenAgainAnimation()
		EventDispatcher.Dispatch(EventID.ConversationStageSetPlayingSpeak, self.speakCfgId, true)
	else
		self:PlayGoNextAnimation(storyDialogueCid, npcName, dialogueContent)
	end
end

function SpeakView:PlayOpenAgainAnimation()
	local publicParametersData = CfgUtil.GetPublicParametersData()
	local EnterContentPosition = publicParametersData.EnterContentPosition
	local EndContentPosition = publicParametersData.EndContentPosition
	local EnterNamePosition = publicParametersData.EnterNamePosition
	local EndNamePosition = publicParametersData.EndNamePosition

	LuaUtility.SetLocalPositionWithGameObject(self.speakContentBackground, EnterContentPosition.x, EnterContentPosition.y, EnterContentPosition.z)
	LuaUtility.SetLocalPositionWithGameObject(self.speakerName, EnterNamePosition.x, EnterNamePosition.y, EnterNamePosition.z)
	LuaUtility.SetLocalPositionWithGameObject(self.speakerNameBackground, 0, 27, 0)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.speakerNameBackground, false)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.speakContentBackground, false)
	LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(EndContentPosition.x, EndContentPosition.y, EndContentPosition.z), publicParametersData.EnterDuration, false, publicParametersData.EnterDurationCurve)
	LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 1, publicParametersData.EnterContentFadeDuration, publicParametersData.StoryDialogue_EnterFadeCurve)
	LuaUtility.DoLocalMove(self.speakerName, Vector3.New(EndNamePosition.x, EndNamePosition.y, 0), publicParametersData.EnterNameDuration, false, publicParametersData.StoryDialogue_EnterNameCurve)
	LuaUtility.DoFadeWithCanvasGroup(self.speakerNameBackground, 1, publicParametersData.EnterNameFadeDuration, publicParametersData.StoryDialogue_EnterNameFadeCurve)
end

function SpeakView:PlayGoNextAnimation(storyDialogueCid, npcName, dialogueContent)
	local publicParametersData = CfgUtil.GetPublicParametersData()
	local LastMovePosition = publicParametersData.LastMovePosition
	local NextStartPosition = publicParametersData.NextStartPosition
	local NextMovePosition = publicParametersData.NextMovePosition
	local sequence = DoTween.Sequence()
	local tweenMove = LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(LastMovePosition.x, LastMovePosition.y, 0), publicParametersData.LastMoveDuration, false, publicParametersData.StoryDialogue_LastMoveCurve)
	local tweenFade = LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 0, publicParametersData.LastFadeDuration, publicParametersData.StoryDialogue_LastFadeCurve)

	sequence:Append(tweenMove)
	sequence:Join(tweenFade)
	sequence:AppendCallback(function()
		self:Refresh(storyDialogueCid, npcName, dialogueContent)
		LuaUtility.SetLocalPositionWithGameObject(self.speakContentBackground, NextStartPosition.x, NextStartPosition.y, 0)
		EventDispatcher.Dispatch(EventID.ConversationStageSetPlayingSpeak, self.speakCfgId, true)
	end)

	local tweenMove2 = LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(NextMovePosition.x, NextMovePosition.y, 0), publicParametersData.NextMoveDuration, false, publicParametersData.StoryDialogue_NextMoveCurve)
	local tweenFade2 = LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 1, publicParametersData.NextFadeDuration, publicParametersData.StoryDialogue_NextFadeDuration)

	sequence:Append(tweenMove2)
	sequence:Join(tweenFade2)

	return sequence
end

function SpeakView:PlayFadeAnimation()
	local publicParametersData = CfgUtil.GetPublicParametersData()
	local LastMovePosition = publicParametersData.LastMovePosition

	self.FadeSequence = DoTween.Sequence()

	local tweenMove = LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(LastMovePosition.x, LastMovePosition.y, 0), publicParametersData.LastMoveDuration, false, publicParametersData.StoryDialogue_LastMoveCurve)
	local tweenFade = LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 0, publicParametersData.LastFadeDuration, publicParametersData.StoryDialogue_LastFadeCurve)

	self.FadeSequence:Append(tweenMove)
	self.FadeSequence:Join(tweenFade)

	local tweenMove2 = LuaUtility.DoLocalMove(self.speakerNameBackground, Vector3.New(LastMovePosition.x, LastMovePosition.y + 89, 0), publicParametersData.LastMoveDuration, false, publicParametersData.StoryDialogue_LastMoveCurve)
	local tweenFade2 = LuaUtility.DoFadeWithCanvasGroup(self.speakerNameBackground, 0, publicParametersData.LastFadeDuration, publicParametersData.StoryDialogue_LastFadeCurve)

	self.FadeSequence:Join(tweenMove2)
	self.FadeSequence:Join(tweenFade2)
	self.FadeSequence:AppendCallback(function()
		LuaUtility.SetGameObjectShow(self.gameObject, false)
		self:OnClose()

		self.FadeSequence = nil
	end)
end

function SpeakView:OnClose()
	self.UIFollowerComponent.enabled = false
	self.FloatEffectComponent.enabled = false
end

function SpeakView:AddListeners()
	return
end

function SpeakView:RemoveListeners()
	return
end

function SpeakView:Refresh(storyDialogueCid, npcName, dialogueContent)
	self:ResetFollowNpc()
	LuaUtility.SetText(self.speakerName, npcName)
	self.npcNameTextBackgroundSource:SetProgress(0)
	LuaUtility.SetText(self.speakContent, dialogueContent)
	self.contentTextBackgroundSource:SetProgress(0)
	self:SetCanGoNextShow(false)
	LuaUtility.SetGameObjectShow(self.speakTitleImg, not LuaUtility.StrIsNullOrEmpty(npcName))
end

function SpeakView:ResetFollowNpc()
	local character = BehaviorTreeUtility.GetNPCByNPCID(self.npcID)
	local storyDialoguePosTransform = character.DialogueMount

	self.UIFollowerComponent = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(UIFollower))

	self.UIFollowerComponent:Init(StoryModule.mainCamera, GameEntry.UICamera, storyDialoguePosTransform, self.canvas)
	self.UIFollowerComponent:LimitUIInScreen(self.Root:GetComponent("RectTransform"), 10)
end

function SpeakView:UpdateProgress(progress)
	self.contentTextBackgroundSource:SetProgress(progress)
	self.npcNameTextBackgroundSource:SetProgress(1)
end

function SpeakView:SetCanGoNextShow(show)
	LuaUtility.SetGameObjectShow(self.imageCanGoNext, show)

	if show then
		self.contentTextBackgroundSource:SetEndFlag()
	end
end

function SpeakView:OnDestroy()
	self.UIFollowerComponent = nil
	self.FloatEffectComponent = nil
	self.nameBackground = nil
	self.contentBackground = nil

	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

return SpeakView
