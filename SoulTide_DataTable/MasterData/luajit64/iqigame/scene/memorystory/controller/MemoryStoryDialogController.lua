-- chunkname: @IQIGame\\Scene\\MemoryStory\\Controller\\MemoryStoryDialogController.lua

local m = {}

function m.New()
	local obj = Clone(m)

	obj:__Init()

	return obj
end

function m:__Init()
	self:__PrepareEventProxy()
	EventDispatcher.AddEventListener(EventID.ShowMemoryStoryTalkEvent, self.showMemoryStoryTalkEventProxy)
end

function m:__PrepareEventProxy()
	function self.showMemoryStoryTalkEventProxy(elementId, dialogId)
		self:__OnShowMemoryStoryTalkEventHandler(elementId, dialogId)
	end
end

function m:__OnShowMemoryStoryTalkEventHandler(elementId, dialogId)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MemoryStorySceneShowDialog, true)
	EventDispatcher.Dispatch(EventID.ShowMemoryStoryTalkUIEvent, elementId, 0)

	self.curTalkingElement = MemoryStoryModule.StoryScene:__GetElementByElementId(elementId)

	if self.curTalkingElement == nil then
		self:__DoDialogEnd()

		return
	end

	local hero = MemoryStoryModule.StoryScene.hero

	if hero == nil then
		self:__DoDialogEnd()

		return
	end

	hero:EnterTalking()

	if elementId ~= hero.elementId then
		MemoryStoryModule.StoryScene:ElementLookAtElement(self.curTalkingElement, hero)
		self.curTalkingElement:EnterTalking()
	end

	self:ShowDialog(dialogId)
end

function m:ShowDialog(dialogId)
	if MemoryStoryModule.StoryScene.hero ~= nil then
		MemoryStoryModule.StoryScene.hero:HideTip()
	end

	if self.curTalkingElement ~= nil then
		self.curTalkingElement:HideTip()
	end

	self.cfgData = CfgMemoryStoryDialogTable[dialogId]

	if not self.cfgData then
		self:__DoDialogEnd()

		return
	end

	local speakerElement = self.cfgData.Speaker == 1 and MemoryStoryModule.StoryScene.hero or self.curTalkingElement

	if #self.cfgData.JumpID > 1 then
		self:__DoShowSelectDialog(speakerElement, self.cfgData)
	else
		self:__ShowSceneElementTalk(speakerElement, self.cfgData)
	end

	if speakerElement ~= nil and self.cfgData.Action ~= "" then
		speakerElement:PlayAnim(self.cfgData.Action, self.cfgData.ActionIsLoop)
	end
end

function m:Next(selectIndex)
	local nextDialogId = self.cfgData.JumpID[selectIndex]

	if nextDialogId == self.cfgData.Id then
		logError("CfgMemoryStoryDialogData " .. tostring(nextDialogId) .. " 配置出现死循环")
		self:__DoDialogEnd()

		return
	end

	if nextDialogId == nil then
		logError("取值错误。MemoryStoryDialog.Id: " .. self.cfgData.Id .. " MemoryStoryDialog.JumpID: " .. tableToString(self.cfgData.JumpID) .. " selectIndex " .. tostring(selectIndex))
	end

	local conditionList = self.cfgData.JumpCondition[selectIndex]
	local serviceList = self.cfgData.JumService[selectIndex]

	if nextDialogId ~= -1 then
		self:__ExecuteEndService(self.curTalkingElement.elementId, serviceList, conditionList)
		self:ShowDialog(nextDialogId)
	else
		self:__DoDialogEnd(serviceList, conditionList)
	end
end

function m:JumpToEnd()
	local talkIdList = {}
	local nextId, cfg = self:__SearchJumpEnd(self.cfgData, talkIdList)

	talkIdList = nil

	if nextId == -1 then
		local conditionList = cfg ~= nil and cfg.JumpCondition[1] or nil
		local serviceList = cfg ~= nil and cfg.JumService[1] or nil

		self:__DoDialogEnd(serviceList, conditionList)

		return
	end

	self:ShowDialog(nextId)
end

function m:__SearchJumpEnd(cfgData, idList)
	if idList[cfgData.Id] ~= nil then
		logError("CfgMemoryStoryDialogData " .. tostring(cfgData.Id) .. " 配置出现死循环")

		return -1, nil
	else
		idList[cfgData.Id] = 1
	end

	if cfgData == nil then
		return -1, nil
	end

	if #cfgData.JumpID > 1 then
		return cfgData.Id, cfgData
	end

	local nextId = cfgData.JumpID[1]

	if nextId == -1 then
		return -1, cfgData
	end

	local nextData = CfgMemoryStoryDialogTable[nextId]

	return self:__SearchJumpEnd(nextData, idList)
end

function m:__DoDialogEnd(serviceList, conditionList)
	if MemoryStoryModule.StoryScene.hero ~= nil then
		MemoryStoryModule.StoryScene.hero:ExitTalking()
	end

	if self.curTalkingElement ~= nil then
		self.curTalkingElement:ExitTalking()
	end

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MemoryStorySceneShowDialog, false)
	EventDispatcher.Dispatch(EventID.HideMemoryStoryTalkEvent)

	local elementId = self.curTalkingElement.elementId

	self.curTalkingElement = nil

	if serviceList ~= nil then
		self:__ExecuteEndService(elementId, serviceList, conditionList)
	end
end

function m:__DoShowSelectDialog(speaker, cfgData)
	EventDispatcher.Dispatch(EventID.ShowMemoryStoryTalkUIEvent, speaker.elementId, cfgData.Id)
end

function m:__ShowSceneElementTalk(speaker, cfgData)
	EventDispatcher.Dispatch(EventID.ShowMemoryStoryTalkUIEvent, speaker.elementId, 0)

	local content = ""

	for i = 1, #cfgData.Contents do
		content = content .. cfgData.Contents[i]
	end

	if speaker ~= nil then
		speaker:ShowTip(content)
	end
end

function m:__ExecuteEndService(elementId, serviceList, conditionList)
	MemoryStoryModule.DoExecution(elementId, serviceList, conditionList)
end

function m:OnDestroy()
	EventDispatcher.RemoveEventListener(EventID.ShowMemoryStoryTalkEvent, self.showMemoryStoryTalkEventProxy)
end

return m
