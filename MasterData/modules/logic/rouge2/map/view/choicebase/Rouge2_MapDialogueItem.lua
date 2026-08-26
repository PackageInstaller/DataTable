-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapDialogueItem.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapDialogueItem", package.seeall)

local Rouge2_MapDialogueItem = class("Rouge2_MapDialogueItem", LuaCompBase)

function Rouge2_MapDialogueItem:init(go)
	self:__onInit()

	self.go = go

	self:_editableInitView()
end

function Rouge2_MapDialogueItem:_editableInitView()
	self._goSpeaker = gohelper.findChild(self.go, "go_Speaker")
	self._goNoneSpeaker = gohelper.findChild(self.go, "go_NoneSpeaker")
	self._txtName = gohelper.findChildText(self.go, "go_Speaker/txt_Name")
	self._txtContent1 = gohelper.findChildText(self.go, "go_Speaker/txt_Content1")
	self._txtContent2 = gohelper.findChildText(self.go, "go_NoneSpeaker/txt_Content2")
	self._goTopLine = gohelper.findChild(self.go, "go_NoneSpeaker/txt_Content2/image_Line1")
	self._goBottomLine = gohelper.findChild(self.go, "go_NoneSpeaker/txt_Content2/image_Line2")

	gohelper.setActive(self._goSpeaker, false)
	gohelper.setActive(self._goNoneSpeaker, false)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.quickSetDialogueDone, self._quickSetDialogueDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onAddNewDialogue, self._onAddNewDialogue, self)
end

function Rouge2_MapDialogueItem:addEventListeners()
	return
end

function Rouge2_MapDialogueItem:initInfo(info, playType, index, doneCallback, doneCallbackObj)
	TaskDispatcher.cancelTask(self._playNext, self)

	self._type = Rouge2_MapEnum.ChoiceDialogueType.None
	self._index = index
	self._doneCallback = doneCallback
	self._doneCallbackObj = doneCallbackObj
	self._tween = false
	self.go.name = index

	if info then
		if not #info then
			local dialogueLen = 0

			if dialogueLen == 1 then
				self._speakerId = 0
				self._speakerCo = nil
				self._talkId = info[1]
				self._type = Rouge2_MapEnum.ChoiceDialogueType.Narration
			elseif dialogueLen == 2 then
				self._speakerId = info[1]
				self._talkId = info[2]
				self._speakerCo = Rouge2_ChatConfig.instance:getSpeakerConfig(self._speakerId)
				self._type = Rouge2_MapEnum.ChoiceDialogueType.Chat
			else
				logError(string.format("肉鸽对话格式不匹配, dialogueStr = %s", table.concat(info, "#")))

				return
			end

			self._talkCo = Rouge2_ChatConfig.instance:getTalkConfig(self._talkId)
			self._desc = self._talkCo and self._talkCo.desc
			self._playType = playType
			self._tween = self._playType == Rouge2_MapEnum.DialoguePlayType.Tween and not string.nilorempty(self._desc)
			self._preEndIndex = self._tween and 0 or nil
		end
	end
end

function Rouge2_MapDialogueItem:play()
	self:show()
	gohelper.setActive(self._goSpeaker, self._type == Rouge2_MapEnum.ChoiceDialogueType.Chat)
	gohelper.setActive(self._goNoneSpeaker, self._type == Rouge2_MapEnum.ChoiceDialogueType.Narration)

	if self._type == Rouge2_MapEnum.ChoiceDialogueType.Chat then
		self._txtName.text = self._speakerCo and self._speakerCo.name
	else
		gohelper.setActive(self._goTopLine, self._index ~= 1)
		gohelper.setActive(self._goBottomLine, false)
	end

	if not self._type or self._type == Rouge2_MapEnum.ChoiceDialogueType.None then
		self:onPlayDialogueDone()

		return
	end

	self:startPlay()
end

function Rouge2_MapDialogueItem:startPlay()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.StartPlayDialogue)

	self._isPlaying = true

	self:_playNext()

	if self._tween then
		TaskDispatcher.runRepeat(self._playNext, self, Rouge2_MapEnum.DialogueInterval)
	end
end

function Rouge2_MapDialogueItem:_playNext()
	if not self._tween or not self._preEndIndex then
		self:onPlayDialogueDone()

		return
	end

	self:updateText()
end

function Rouge2_MapDialogueItem:updateText()
	if self._type == Rouge2_MapEnum.ChoiceDialogueType.Chat then
		self._txtContent1.text = self:getCurDesc()
	else
		self._txtContent2.text = self:getCurDesc()
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateChoiceDialogue)
end

function Rouge2_MapDialogueItem:getCurDesc()
	if not self._tween or not self._preEndIndex then
		return self._desc
	end

	local startIndex = self._preEndIndex + 1
	local inRichTag = false
	local index = 0

	while index < 1000 do
		local endIndex = utf8.next(self._desc, startIndex)

		if not endIndex then
			self._preEndIndex = nil

			return self._desc
		end

		local endChar = self._desc:sub(startIndex, endIndex - 1)

		if endChar == "<" then
			inRichTag = true
		elseif endChar == ">" then
			inRichTag = false
		elseif not inRichTag then
			self._preEndIndex = endIndex - 1

			return self._desc:sub(1, self._preEndIndex)
		end

		index = index + 1
		startIndex = endIndex
	end

	logError("endless loop !!!")

	self._preEndIndex = nil

	return self._desc
end

function Rouge2_MapDialogueItem:onPlayDialogueDone()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.EndPlayDialogue)

	self._isPlaying = false
	self._tween = false

	if self._doneCallback then
		self._doneCallback(self._doneCallbackObj)
	end

	self:updateText()
	TaskDispatcher.cancelTask(self._playNext, self)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onOneDialogueStepDone)
end

function Rouge2_MapDialogueItem:_quickSetDialogueDone()
	if not self._isPlaying then
		return
	end

	self:onPlayDialogueDone()
end

function Rouge2_MapDialogueItem:_onAddNewDialogue()
	gohelper.setActive(self._goBottomLine, true)
end

function Rouge2_MapDialogueItem:show()
	gohelper.setAsLastSibling(self.go)
	gohelper.setActive(self.go, true)
	TaskDispatcher.cancelTask(self._playNext, self)
end

function Rouge2_MapDialogueItem:hide()
	gohelper.setActive(self.go, false)
	TaskDispatcher.cancelTask(self._playNext, self)
end

function Rouge2_MapDialogueItem:onDestroy()
	TaskDispatcher.cancelTask(self._playNext, self)
end

return Rouge2_MapDialogueItem
