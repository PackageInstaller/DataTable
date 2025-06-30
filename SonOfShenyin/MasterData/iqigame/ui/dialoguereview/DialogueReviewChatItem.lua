-- chunkname: @IQIGame\\UI\\DialogueReview\\DialogueReviewChatItem.lua

local DialogueReviewChatItem = {}
local colorRed = {
	g = 0.3882353,
	a = 1,
	b = 0.8588235,
	r = 0.6078432
}
local colorWhite = {
	g = 1,
	a = 1,
	b = 1,
	r = 1
}

function DialogueReviewChatItem.New(go, mainView)
	local o = Clone(DialogueReviewChatItem)

	o:Initialize(go, mainView)

	return o
end

function DialogueReviewChatItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DialogueReviewChatItem:InitComponent()
	self.textObjectList = {}

	for i = 1, 7 do
		local trans = LuaUtility.GetChild(self.SpeakContent.transform, i - 1)

		LuaUtility.SetTransGameObjectShow(trans:Find("objectSelect"), false)

		self.textObjectList[i] = trans.gameObject
	end

	self.textNpcSpeakSizeDelta = self.textNpcSpeak:GetComponent("RectTransform").sizeDelta
end

function DialogueReviewChatItem:InitDelegate()
	return
end

function DialogueReviewChatItem:AddListener()
	return
end

function DialogueReviewChatItem:RemoveListener()
	return
end

function DialogueReviewChatItem:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	LuaUtility.UnLoadAsset(self)
end

function DialogueReviewChatItem:ResetState()
	LuaUtility.SetGameObjectShow(self.imagePlayer, false)
	LuaUtility.SetGameObjectShow(self.SpeakContent, false)
	LuaUtility.SetGameObjectShow(self.textNpcSpeak, false)
end

function DialogueReviewChatItem:Refresh(Data, OptimizedViewsHolder)
	self.Data = Data

	self:ResetState()

	local index = 1

	if self.Data.type == Constant.DialogueReviewType.Chat then
		local speakNpcCfg = CfgUtil.GetCfgStorySpeakNpcDataWithID(self.Data.ID)
		local strName

		if speakNpcCfg.SpeakNPC <= 0 then
			LuaUtility.SetGameObjectShow(self.imagePlayer, true)

			strName = string.format(ColorCfg.White, self.Data.NpcName)
		else
			strName = self.Data.NpcName
		end

		local strContent = ConversationModule.GetSpeakNpcContent(speakNpcCfg)

		LuaUtility.SetText(self.textName, strName)
		LuaUtility.SetText(self.textNpcSpeak, string.format(strContent, PlayerModule.GetName()))
		LuaUtility.SetGameObjectShow(self.textNpcSpeak, true)

		OptimizedViewsHolder.ControlSize = self.textNpcSpeakSizeDelta.y + 15
	elseif self.Data.type == Constant.DialogueReviewType.Option then
		LuaUtility.SetText(self.textName, string.format(ColorCfg.White, self.Data.NpcName))
		LuaUtility.SetGameObjectShow(self.imagePlayer, true)

		local cfgOption = CfgUtil.GetCfgStoryOptionDataWithID(self.Data.ID)
		local options = cfgOption.Options

		for i = 1, #self.textObjectList do
			if options[i] then
				if options[i] == self.Data.selectID then
					LuaUtility.SetTransGameObjectShow(self.textObjectList[i].transform:Find("objectSelect"), true)
					LuaUtility.SetTextColor(self.textObjectList[i], colorRed.r, colorRed.g, colorRed.b, colorRed.a)
				else
					LuaUtility.SetTransGameObjectShow(self.textObjectList[i].transform:Find("objectSelect"), false)
					LuaUtility.SetTextColor(self.textObjectList[i], colorWhite.r, colorWhite.g, colorWhite.b, colorWhite.a)
				end

				LuaUtility.SetText(self.textObjectList[i], CfgUtil.GetCfgStoryTextDataWithID(options[i]))
				LuaUtility.SetGameObjectShow(self.textObjectList[i], true)

				index = i
			end
		end

		LuaUtility.SetGameObjectShow(self.SpeakContent, true)

		OptimizedViewsHolder.ControlSize = 40 * index + 35
	end

	for i = index + 1, #self.textObjectList do
		LuaUtility.SetGameObjectShow(self.textObjectList[i], false)
	end
end

return DialogueReviewChatItem
