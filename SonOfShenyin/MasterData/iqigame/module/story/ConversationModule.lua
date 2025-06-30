-- chunkname: @IQIGame\\Module\\Story\\ConversationModule.lua

ConversationModule = {}

local ConversationStageClass = require("IQIGame.Module.Story.ConversationStage")
local this = ConversationModule
local conversationIndex = 1

function ConversationModule.Init()
	this.InitMembers()
	this.AddListener()

	this.updateFrameTimer = FrameTimer.New(this.Update, 1, -1)

	this.updateFrameTimer:Start()
end

function this.InitMembers()
	if this.isAuto == nil then
		this.isAuto = false
	end

	this.autoDialogueStateIndex = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.autoDialogueStateIndex, 1)

	if this.multipleSpeed == nil then
		this.multipleSpeed = 1
	end

	this.autoCharacterSpeed = 0.11
	this.skipCacheTime = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.StorySkipConversationTime) / 1000
	this.IsPause = false
	Time.timeScale = 1
	this.timeScale = 1
end

function ConversationModule.AddListener()
	EventDispatcher.AddEventListener(EventID.BehaviorTreeNPCConfirmConversation, this.ConfirmConversation)
end

function ConversationModule.RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeNPCConfirmConversation, this.ConfirmConversation)
end

function ConversationModule.Dispose()
	if this.updateFrameTimer then
		this.updateFrameTimer:Stop()

		this.updateFrameTimer = nil
	end

	ConversationModule.ClearConversation()

	Time.timeScale = 1
end

function ConversationModule.SetAutoCharacterSpeed(autoCharacterSpeed)
	ConversationModule.autoCharacterSpeed = autoCharacterSpeed
end

function this.StartNewConversation(StoryDialogueInformation)
	if StoryModule.isSkipState then
		StoryDialogueInformation.startConversationTask:Complete()

		return
	end

	if not this.conversationStageList then
		this.conversationStageList = {}
	end

	local stage = ConversationStageClass.New(StoryDialogueInformation, conversationIndex)

	conversationIndex = conversationIndex + 1

	table.insert(this.conversationStageList, stage)
	stage:Start()
end

function this.Update()
	if this.IsPause then
		return
	end

	if not this.conversationStageList then
		return
	end

	local len = #this.conversationStageList

	if len <= 0 then
		if this.timeScale ~= 1 and not StoryModule.isSkipState then
			Time.timeScale = 1
			this.timeScale = 1
		end

		return
	end

	if this.timeScale ~= this.multipleSpeed then
		Time.timeScale = this.multipleSpeed
		this.timeScale = this.multipleSpeed
	end

	for i = 1, len do
		if this.conversationStageList[i] then
			this.conversationStageList[i]:Update()
		end
	end
end

function this.RemoveConversation(index)
	for i, v in pairs(this.conversationStageList) do
		if v.index == index then
			table.remove(this.conversationStageList, i)

			break
		end
	end
end

function this.ConfirmConversation()
	for i = 1, #this.conversationStageList do
		if this.conversationStageList[i] and this.conversationStageList[i].storyDialogueInformation.isActiveConfirmButton then
			this.conversationStageList[i]:ConfirmConversation()
		end
	end
end

function this.SetMultipleSpeed(v)
	this.multipleSpeed = v
end

function this.SetTextShowSpeed(value)
	this.textShowSpeed = value
end

function this.GetTextShowSpeed()
	if not this.textShowSpeed then
		this.textShowSpeed = CfgUtil.GetPublicParametersData().TextShowSpeed
	end

	return this.textShowSpeed
end

function this.ClearConversation()
	if not this.conversationStageList then
		return
	end

	for i = 1, #this.conversationStageList do
		this.conversationStageList[i]:Destroy()
	end

	this.conversationStageList = {}

	this.InitMembers()
end

function this.PauseConversation()
	this.IsPause = true
end

function this.ContinueConversation()
	this.IsPause = false
end

function this.CheckNeedCloseConfirmMask()
	local r = true

	for i = 1, #this.conversationStageList do
		if this.conversationStageList[i] and this.conversationStageList[i].storyDialogueInformation.isActiveConfirmButton then
			r = false
		end
	end

	return r
end

function this.GetSpeakNpcContent(CfgSpeak)
	local str

	if PlayerModule.PlayerInfo.baseInfo.sex == 1 and not LuaUtility.StrIsNullOrEmpty(CfgSpeak.SpeakContent_Female) then
		str = CfgSpeak.SpeakContent_Female
	else
		str = CfgSpeak.SpeakContent
	end

	return str
end

function this.SkipCurrentConversation()
	if not this.conversationStageList then
		return
	end

	local len = #this.conversationStageList

	for i = 1, len do
		if this.conversationStageList[i] then
			this.conversationStageList[i]:OnEnd()
		end
	end
end

function this.GetIsHaveConversation()
	if not this.conversationStageList then
		return false
	end

	return #this.conversationStageList > 0
end
