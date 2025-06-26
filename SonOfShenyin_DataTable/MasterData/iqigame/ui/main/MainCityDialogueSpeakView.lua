-- chunkname: @IQIGame\\UI\\Main\\MainCityDialogueSpeakView.lua

local m = {
	curDialogueIsComplete = false,
	curTime = 0,
	startShowDialogue = false,
	dialogueContent = ""
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.npcNameTextBackgroundSource = self.speakerName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.contentTextBackgroundSource = self.speakContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.parentRect = self.View.transform.parent:GetComponent("RectTransform")

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.startShowDialogue == false then
		return
	end

	self.curTime = self.curTime + elapseSeconds

	if self.curTime >= self.needTime and self.curTime >= 1 then
		self.startShowDialogue = false
		self.curDialogueIsComplete = true

		self:UpdateProgress(1)

		return
	end

	self:UpdateProgress(self.curTime)
end

function m:UpdateNameText(name)
	UGUIUtil.SetText(self.speakerName, name)
end

function m:UpdateContentText(content)
	self.dialogueContent = content

	UGUIUtil.SetText(self.speakContent, content)
end

function m:UpdateDialogueProgress()
	self.curDialogueIsComplete = false
	self.needTime = string.len(self.dialogueContent) * 0.01
	self.curTime = 0
	self.startShowDialogue = true
end

function m:UpdateProgress(progress)
	self.contentTextBackgroundSource:SetProgress(progress)
	self.npcNameTextBackgroundSource:SetProgress(1)
end

function m:IsCanNextDialogue()
	return self.curDialogueIsComplete
end

function m:ClearDialogueInfo()
	self:UpdateNameText("")
	self:UpdateContentText("")
	self.contentTextBackgroundSource:SetProgress(0)
	self.npcNameTextBackgroundSource:SetProgress(0)
end

function m:SetNpcNameTextProgress()
	self.npcNameTextBackgroundSource:SetProgress(1)
end

function m:UpdateViewPosByTarget(target)
	local offsetY = 10
	local screenPosition = MainCityModule.mainCamera:WorldToScreenPoint(target.transform.position)
	local localPos = LuaUtility.ScreenPointToLocalPointInRectangle(self.parentRect, screenPosition, GameEntry.UICamera)

	localPos.z = 0
	localPos.y = 100
	self.View.transform.localPosition = localPos
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	self.npcNameTextBackgroundSource = nil
	self.contentTextBackgroundSource = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
