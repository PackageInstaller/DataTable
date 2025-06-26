-- chunkname: @IQIGame\\Module\\Story\\ConversationStage.lua

local ConversationStage = {}

function ConversationStage.New(StoryDialogueInformation, index)
	local o = Clone(ConversationStage)

	o:Initialize(StoryDialogueInformation, index)

	return o
end

function ConversationStage:Initialize(StoryDialogueInformation, index)
	self.index = index
	self.storyDialogueInformation = StoryDialogueInformation
	self.SpeakList = {}
	self.DubIdList = {}
	self.FacialEffectList = {}
	self.prepareLoadList = {}
	self.skipCacheTime = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.StorySkipConversationTime) / 1000

	self:InitDelegate()
	self:AddListener()
end

function ConversationStage:InitDelegate()
	function self.SetPlayingSpeakDelegate(dialogueID, v)
		self:SetPlayingSpeak(dialogueID, v)
	end
end

function ConversationStage:AddListener()
	EventDispatcher.AddEventListener(EventID.ConversationStageSetPlayingSpeak, self.SetPlayingSpeakDelegate)
end

function ConversationStage:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.ConversationStageSetPlayingSpeak, self.SetPlayingSpeakDelegate)
end

function ConversationStage:Start()
	self.currentDialogueID = self.storyDialogueInformation.dialogueStartID
	self.isEnd = false

	self:Next(true)
end

function ConversationStage:Next(isFirst)
	if self.isEnd then
		return
	end

	if not isFirst then
		self:CheckLastEndAnimation()

		self.currentDialogueID = self.currentDialogueCfg.NextID
	end

	self:HideFacialEffect()

	self.prepareLoadList = {}

	if self.currentDialogueID == 0 then
		self:OnEnd()

		return
	end

	local dialogueCfg = CfgUtil.GetCfgStoryDialogueDataWithID(self.currentDialogueID)

	self.currentDialogueCfg = dialogueCfg

	self:StopDub()

	for _, v in pairs(self.SpeakList) do
		for __, v2 in pairs(v) do
			v2.isSpeaking = false
		end
	end

	self.dStartTime = Time.time
	self.textStayTime = 0
	self.notInteractButtonTime = dialogueCfg.skiptime
	self.canConfirmButton = false
	self.isTimeCanSkip = false
	self.isLoadCheck = false

	if dialogueCfg.Staytime ~= 0 then
		self.textStayTime = dialogueCfg.Staytime
	end

	self.contentShowProgress = 0

	if self.storyDialogueInformation.isActiveConfirmButton then
		EventDispatcher.Dispatch(EventID.StorySetConfirmButtonShowEvent, true)
	end

	local NpcList = dialogueCfg.Speakgroup
	local len = #NpcList

	for i = 1, len do
		local speakNpcCfg = CfgUtil.GetCfgStorySpeakNpcDataWithID(NpcList[i])
		local npc

		if dialogueCfg.DialogueType == Constant.StoryDialogueType.Conversation or dialogueCfg.DialogueType == Constant.StoryDialogueType.StandPaint then
			npc = StoryModule.GetCharacterByNPCID(speakNpcCfg.SpeakNPC)

			if not npc then
				logError(string.format("【剧情】在对话配置 ID = %s 中找不到 npcID = %s 的角色", dialogueCfg.Id, speakNpcCfg.SpeakNPC))

				return
			end
		else
			npc = StoryModule.player
		end

		self:PlayStandPaintAnimation(dialogueCfg, speakNpcCfg, npc)

		if speakNpcCfg.FacialEffect and speakNpcCfg.FacialEffect ~= 0 then
			self:ShowFacialEffect(speakNpcCfg, npc)
		else
			self:ShowSpeakView(dialogueCfg, speakNpcCfg, npc)
		end

		self:PlayRoleAnimation(dialogueCfg, speakNpcCfg, npc)
		self:PlaySoundEffect(speakNpcCfg)
	end

	self:HideNpcWhoNotSpeak()
end

function ConversationStage:Update()
	if self.isEnd then
		return
	end

	if StoryModule.isSkipState then
		self:OnEnd()
	end

	if not self.isLoadCheck then
		if not self:CheckLoadListIsClear() then
			return
		end

		self.isLoadCheck = true
		self.dStartTime = Time.time
	end

	self.contentShowProgress = math.clamp(self.contentShowProgress + Time.deltaTime * ConversationModule.GetTextShowSpeed(), 0, 1)

	for _, v in pairs(self.SpeakList) do
		for i, v2 in pairs(v) do
			if v2.isSpeaking then
				EventDispatcher.Dispatch(EventID.BehaviorTreeNPCUpdateSpeak, v2.dialogueType, i, self.contentShowProgress)
			end
		end
	end

	if Time.time - self.dStartTime >= self.skipCacheTime then
		self.isTimeCanSkip = true
	end

	if Time.time - self.dStartTime >= self.notInteractButtonTime then
		self.canConfirmButton = true

		if not ConversationModule.isAuto and self.currentDialogueCfg then
			local NpcList = self.currentDialogueCfg.Speakgroup
			local needNext = true

			for i = 1, #NpcList do
				local speakNpcCfg = CfgUtil.GetCfgStorySpeakNpcDataWithID(NpcList[i])

				if speakNpcCfg.FacialEffect == 0 then
					needNext = false

					break
				end
			end

			if needNext then
				self:Next()
			end
		end
	end

	if Time.time - self.dStartTime >= self.textStayTime then
		if self.storyDialogueInformation.isActiveConfirmButton then
			if ConversationModule.isAuto then
				self:Next()
			else
				for _, v in pairs(self.SpeakList) do
					for i, v2 in pairs(v) do
						if v2.isSpeaking and not v2.canGoNextShow then
							EventDispatcher.Dispatch(EventID.StoryUICanGoNextShow, v2.dialogueType, i, true)

							v2.canGoNextShow = true
						end
					end
				end
			end
		else
			self:Next()
		end
	end
end

function ConversationStage:OnEnd()
	self.isEnd = true

	for _, v in pairs(self.SpeakList) do
		for i, v2 in pairs(v) do
			if v2.isViewShowing then
				EventDispatcher.Dispatch(EventID.BehaviorTreeNPCRemoveSpeak, v2.dialogueType, i)

				v2.isViewShowing = false
			end
		end
	end

	self:HideFacialEffect()
	self:StopDub()
	ConversationModule.RemoveConversation(self.index)
	self.storyDialogueInformation.startConversationTask:Complete()

	if self.storyDialogueInformation.isActiveConfirmButton and ConversationModule.CheckNeedCloseConfirmMask() then
		EventDispatcher.Dispatch(EventID.StorySetConfirmButtonShowEvent, false)
	end
end

function ConversationStage:ConfirmConversation()
	if not self.isLoadCheck and not self:CheckLoadListIsClear() then
		return
	end

	if not self.isTimeCanSkip then
		return
	end

	if not self.canConfirmButton then
		return
	end

	if self.contentShowProgress < 1 then
		self:ShowAllTextNow()
	else
		self:Next()
	end
end

function ConversationStage:ShowAllTextNow()
	for _, v in pairs(self.SpeakList) do
		for i, v2 in pairs(v) do
			if v2.isSpeaking then
				EventDispatcher.Dispatch(EventID.BehaviorTreeNPCUpdateSpeak, v2.dialogueType, i, 1)
			end
		end

		self.contentShowProgress = 1
	end
end

function ConversationStage:SetPlayingSpeak(dialogueID, value)
	self.prepareLoadList[dialogueID] = true
end

function ConversationStage:AddOrUpdateSpeakingNpc(speakNpcID, npc, DialogueType)
	if not self.SpeakList[DialogueType] then
		self.SpeakList[DialogueType] = {}
	end

	local index

	index = DialogueType == Constant.StoryDialogueType.StandPaint and -1 or speakNpcID

	if not self.SpeakList[DialogueType][index] then
		self.SpeakList[DialogueType][index] = {}
	end

	self.SpeakList[DialogueType][index].npc = npc
	self.SpeakList[DialogueType][index].isSpeaking = true
	self.SpeakList[DialogueType][index].canGoNextShow = false
	self.SpeakList[DialogueType][index].dialogueType = DialogueType
	self.SpeakList[DialogueType][index].isViewShowing = true
end

function ConversationStage:PlaySoundEffect(CfgSpeakNpc)
	if CfgSpeakNpc.PlayBGM and CfgSpeakNpc.PlayBGM ~= 0 then
		BehaviorTreeUtility.PlayStoryBGM(CfgSpeakNpc.PlayBGM)
	end

	local dub, otherDub

	if PlayerModule.GetSex() == Constant.PlayerSex.Man then
		dub = CfgSpeakNpc.PlayDubbing
		otherDub = CfgSpeakNpc.PlayDubbingGirl
	elseif PlayerModule.GetSex() == Constant.PlayerSex.WoMen then
		if CfgSpeakNpc.PlayDubbingGirl and CfgSpeakNpc.PlayDubbingGirl ~= 0 then
			dub = CfgSpeakNpc.PlayDubbingGirl
			otherDub = CfgSpeakNpc.PlayDubbing
		else
			dub = CfgSpeakNpc.PlayDubbing
			otherDub = CfgSpeakNpc.PlayDubbingGirl
		end
	end

	if dub and dub ~= 0 then
		local cfgSound = CfgUtil.GetSoundCfgDataWithID(dub)

		if cfgSound and not LuaUtility.StrIsNullOrEmpty(cfgSound.FileName) then
			table.insert(self.DubIdList, LuaUtility.PlaySoundWithID(dub))

			local path = LuaUtility.GetSoundAssetPath(cfgSound.FileName)

			if not LuaUtility.StrIsNullOrEmpty(path) then
				LuaUtility.LoadAsset(self, path, function(owner, assetName, asset, duration, userData)
					local audio = asset

					self.textStayTime = audio.length

					if PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.CVContinuous) == "true" and otherDub and otherDub ~= 0 then
						if self.otherDubCo then
							coroutine.stop(self.otherDubCo)

							self.otherDubCo = nil
						end

						self.otherDubCo = coroutine.start(function()
							coroutine.wait(audio.length)
							table.insert(self.DubIdList, LuaUtility.PlaySoundWithID(otherDub))
						end)
					end
				end)
			end
		end
	end

	if CfgSpeakNpc.PlaySound and CfgSpeakNpc.PlaySound ~= 0 then
		local serializeID = LuaUtility.PlaySoundWithID(CfgSpeakNpc.PlaySound)

		if not LuaUtility.StrIsNullOrEmpty(CfgSpeakNpc.SoundID) then
			StoryModule.SetNpcVariableWithoutServer(999, IQIGame.Onigao.Game.VariableSetting.VariableType.Int, CfgSpeakNpc.SoundID, serializeID)
		end
	end
end

function ConversationStage:StopDub()
	for i = #self.DubIdList, 1, -1 do
		LuaUtility.StopSoundWithSerialId(self.DubIdList[i])
		table.remove(self.DubIdList, i)
	end

	if self.otherDubCo then
		coroutine.stop(self.otherDubCo)

		self.otherDubCo = nil
	end
end

function ConversationStage:ShowSpeakView(dialogueCfg, speakNpcCfg, npc)
	local npcName = ""

	if speakNpcCfg.NPCName ~= "" then
		npcName = string.format(speakNpcCfg.NPCName, npc:GetName())
	end

	local contentStr = ConversationModule.GetSpeakNpcContent(speakNpcCfg)
	local textTime = string.len(contentStr) * ConversationModule.autoCharacterSpeed

	if dialogueCfg.Staytime == 0 and textTime > self.textStayTime then
		self.textStayTime = textTime
	end

	self.prepareLoadList[speakNpcCfg.Id] = false

	local tb = {}

	tb.npcID = speakNpcCfg.SpeakNPC
	tb.npcName = npcName
	tb.storyDialogueCid = self.currentDialogueID
	tb.dialogueContent = string.format(contentStr, StoryModule.player:GetName())
	tb.isActiveConfirmButton = self.storyDialogueInformation.isActiveConfirmButton
	tb.speakCfgId = speakNpcCfg.Id

	EventDispatcher.Dispatch(EventID.BehaviorTreeNPCStartConversation, tb)
	self:AddOrUpdateSpeakingNpc(speakNpcCfg.SpeakNPC, npc, dialogueCfg.DialogueType)
	StoryModule.AddDialogueReviewData(Constant.DialogueReviewType.Chat, speakNpcCfg.Id)
end

function ConversationStage:PlayStandPaintAnimation(dialogueCfg, speakNpcCfg, npc)
	if dialogueCfg.DialogueType == Constant.StoryDialogueType.StandPaint then
		EventDispatcher.AddSingleEventListener(EventID.PlayStandPaintAnimationEvent, function()
			if speakNpcCfg.TachieAnimationName and npc.npcID and not LuaUtility.StrIsNullOrEmpty(speakNpcCfg.TachieAnimationName[1]) then
				EventDispatcher.Dispatch(EventID.SetStandPaintAnimationEvent, npc.npcID, speakNpcCfg.TachieAnimationName[1], speakNpcCfg.TachieAnimationLoop[1])

				for i = 2, #speakNpcCfg.TachieAnimationName do
					if not LuaUtility.StrIsNullOrEmpty(speakNpcCfg.TachieAnimationName[i]) then
						EventDispatcher.Dispatch(EventID.AddStandPaintAnimationEvent, npc.npcID, speakNpcCfg.TachieAnimationName[i], speakNpcCfg.TachieAnimationLoop[i])
					end
				end
			end
		end)
	end
end

function ConversationStage:PlayRoleAnimation(dialogueCfg, speakNpcCfg, npc)
	if speakNpcCfg.AnimationName and npc.npcID and not LuaUtility.StrIsNullOrEmpty(speakNpcCfg.AnimationName[1]) then
		npc:PlayAnimation(speakNpcCfg.AnimationName[1], speakNpcCfg.AnimationLoop[1])

		for i = 2, #speakNpcCfg.AnimationName do
			if not LuaUtility.StrIsNullOrEmpty(speakNpcCfg.AnimationName[i]) then
				npc:AddAnimation(speakNpcCfg.AnimationName[i], speakNpcCfg.AnimationLoop[i])
			end
		end
	end
end

function ConversationStage:ShowFacialEffect(speakNpcCfg, npc)
	local facialCfg = CfgUtil.GetCfgFacialEffectDataWithID(speakNpcCfg.FacialEffect)
	local obj = StoryModule.CachePool:GetObject(facialCfg.Path)

	if obj then
		LuaUtility.CheckFollowerComponent(obj, npc.DialogueMount, Vector3.zero)
		self:InsetInFacialEffectList(obj, facialCfg.Path)
	else
		self.prepareLoadList[facialCfg.Path] = false

		LuaUtility.LoadAsset(StoryModule, facialCfg.Path, function(owner, assetName, asset, duration, userData)
			local effect = GameObject.Instantiate(asset, StoryModule.EffectRoot)

			LuaUtility.CheckFollowerComponent(effect, npc.DialogueMount, Vector3.zero)
			self:InsetInFacialEffectList(effect, facialCfg.Path)

			self.prepareLoadList[facialCfg.Path] = true
		end)
	end

	if self.textStayTime == 0 then
		self.textStayTime = facialCfg.Staytime
	end

	if self.notInteractButtonTime == 0 then
		self.notInteractButtonTime = facialCfg.skiptime
	end
end

function ConversationStage:HideFacialEffect()
	for i = #self.FacialEffectList, 1, -1 do
		StoryModule.CachePool:BackPool(self.FacialEffectList[i].path, self.FacialEffectList[i].obj)
		LuaUtility.SetGameObjectShow(self.FacialEffectList[i].obj, false)
		table.remove(self.FacialEffectList, i)
	end
end

function ConversationStage:InsetInFacialEffectList(obj, path)
	local t = {}

	t.obj = obj
	t.path = path

	LuaUtility.SetGameObjectShow(obj, true)
	table.insert(self.FacialEffectList, t)
end

function ConversationStage:HideNpcWhoNotSpeak()
	for _, v in pairs(self.SpeakList) do
		for i, v2 in pairs(v) do
			if not v2.isSpeaking and v2.isViewShowing then
				local needHide = true

				if v2.dialogueType == Constant.StoryDialogueType.StandPaint then
					needHide = self.currentDialogueCfg.DialogueType ~= Constant.StoryDialogueType.StandPaint
				end

				if needHide then
					EventDispatcher.Dispatch(EventID.BehaviorTreeNPCRemoveSpeak, v2.dialogueType, i)

					v2.isViewShowing = false
				end
			end
		end
	end
end

function ConversationStage:CheckLoadListIsClear()
	for _, v in pairs(self.prepareLoadList) do
		if not v then
			return false
		end
	end

	return true
end

function ConversationStage:CheckLastEndAnimation()
	if self.currentDialogueCfg.DialogueType ~= Constant.StoryDialogueType.IntroNarration then
		local NpcList = self.currentDialogueCfg.Speakgroup

		for i = 1, #NpcList do
			local speakNpcCfg = CfgUtil.GetCfgStorySpeakNpcDataWithID(NpcList[i])

			if not LuaUtility.StrIsNullOrEmpty(speakNpcCfg.AnimationWhenNext[1]) then
				local npc = StoryModule.GetCharacterByNPCID(speakNpcCfg.SpeakNPC)

				if not npc then
					logError(string.format("【剧情】播放上句话的结束动作失败，没有找到该角色，对话id = %s,角色id = %s", speakNpcCfg.Id, speakNpcCfg.SpeakNPC))

					return
				end

				npc:PlayAnimation(speakNpcCfg.AnimationWhenNext[1], speakNpcCfg.AnimationWhenNextLoop[1])

				for j = 2, #speakNpcCfg.AnimationWhenNext do
					if not LuaUtility.StrIsNullOrEmpty(speakNpcCfg.AnimationWhenNext[j]) then
						npc:AddAnimation(speakNpcCfg.AnimationWhenNext[j], speakNpcCfg.AnimationWhenNextLoop[j])
					end
				end
			end
		end
	end
end

function ConversationStage:Destroy()
	self:OnEnd()
	AssetUtil.UnloadAsset(self)
end

return ConversationStage
