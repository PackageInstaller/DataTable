-- chunkname: @IQIGame\\UI\\Maze\\MazeStageDialogItem.lua

local m = {
	Enabled = false,
	OriginalTypeInterval = 0.05
}
local TextTypeHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.SpeakerNameText ~= nil then
		self.TextGenerator = IQIGame.Onigao.Game.PreBindSettingTextGenerator(self.SpeakerNameText:GetComponent("Text"))
	end

	self.TextTypeHelper = TextTypeHelper.New()

	self.NoticeClickView:SetActive(false)
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.TextTypeHelper:Update(elapseSeconds, realElapseSeconds)

	if self:IsTypeFinished() then
		self.NoticeClickView:SetActive(true)
	end
end

function m:SetData(cfgMazeStageDialogData)
	self:SetDataByNameContent(cfgMazeStageDialogData.SpeakerName, cfgMazeStageDialogData.Content)
end

function m:SetDataByNameContent(speakerName, content)
	if speakerName ~= "" then
		local speakerNameTextWidth = self.TextGenerator:GetPreferredWidth(speakerName)
		local sizeDelta = self.SpeakerNameText.transform.sizeDelta

		sizeDelta.x = speakerNameTextWidth
		self.SpeakerNameText.transform.sizeDelta = sizeDelta
		sizeDelta = self.ContentText.transform.sizeDelta
		sizeDelta.x = self.ContentText.transform.parent.sizeDelta.x - speakerNameTextWidth
		self.ContentText.transform.sizeDelta = sizeDelta
	end

	if self.SpeakerNameText ~= nil then
		UGUIUtil.SetText(self.SpeakerNameText, speakerName)
	end

	self.TextTypeHelper:Perform(self.ContentText, content)

	self.Started = true
end

function m:Reset()
	self.Started = false

	if self.SpeakerNameText ~= nil then
		UGUIUtil.SetText(self.SpeakerNameText, "")
	end

	self.TextTypeHelper:ResetGameObject(self.ContentText)
	self.NoticeClickView:SetActive(false)
end

function m:IsTypeFinished()
	return self.Started and self.TextTypeHelper:IsTypeFinished()
end

function m:StopTyping()
	self.TextTypeHelper:StopAll()
end

function m:SetEnabled(value)
	self.Enabled = value

	self:Reset()
	self.View:SetActive(value)
end

function m:SetTypeInterval(speedRatio)
	local interval = self.OriginalTypeInterval / speedRatio

	self.TextTypeHelper:SetTypeInterval(interval)
end

function m:Dispose()
	self:StopTyping()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.TextGenerator = nil
end

return m
