-- chunkname: @IQIGame\\UI\\MemoryStory\\MemoryStoryDialog.lua

local SelectItem = require("IQIGame.UI.MemoryStory.MemoryStoryDialogSelectItem")
local m = {
	selectItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.TalkOptionBtn.gameObject:SetActive(false)

	self.talkContentText = self.TalkContentText:GetComponent("Text")
end

function m:OnShowDialog(elementId, dialogId)
	self:__DoShow(dialogId)
	self.View.gameObject:SetActive(true)
end

function m:OnHide()
	self.View.gameObject:SetActive(false)
end

function m:OnDestroy()
	self:__DestroyDialogSelect()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.talkContentText = nil
end

function m:__DoShow(dialogId)
	self:__HideDialogSelect()

	self.dialogData = CfgMemoryStoryDialogTable[dialogId]

	if self.dialogData == nil then
		self:OnHide()

		return
	end

	local content = ""

	for i = 1, #self.dialogData.Contents do
		content = content .. self.dialogData.Contents[i]
	end

	self.talkContentText.text = content

	self:__ShowDialogSelect()
end

function m:__ShowDialogSelect()
	for k, jumpId in ipairs(self.dialogData.JumpID) do
		if jumpId ~= -99 then
			local item = self:__GetFreeItem()

			item:ShowNormal(self.dialogData.NextDialogName[k], k)
		end
	end
end

function m:__HideDialogSelect()
	for _, item in pairs(self.selectItems) do
		item:OnHide()
	end
end

function m:__DestroyDialogSelect()
	for _, item in pairs(self.selectItems) do
		item:OnDestroy()
	end
end

function m:__GetFreeItem()
	for _, item in pairs(self.selectItems) do
		if item:IsFree() then
			return item
		end
	end

	local obj = UnityEngine.Object.Instantiate(self.TalkOptionBtn)

	obj.transform:SetParent(self.TalkOptionBtn.transform.parent, false)

	local newItem = SelectItem.New(obj, function(index)
		self:__OnItemSelectedEventHandler(index)
	end)

	table.insert(self.selectItems, newItem)

	return newItem
end

function m:__OnItemSelectedEventHandler(index)
	self:OnHide()
	MemoryStoryModule.CallNextDialog(index)
end

return m
