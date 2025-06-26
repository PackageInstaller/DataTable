-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Element\\HorizontalRPGChatView.lua

local m = {
	StartShowTimer = 0,
	ElementID = 0,
	IsShow = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.View:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:FrameUpdate()
	if not self.IsShow then
		return
	end

	if UnityEngine.Time.realtimeSinceStartup - self.StartShowTimer > 2 then
		self:EndShow()
	end
end

function m:SetData(elementID)
	self.ElementID = elementID
end

function m:ShowChatMsg(chatID, callback)
	self.ChatID = chatID
	self.ShowEndCallBack = callback

	local cfgData = CfgHorizontalRPGChatTable[self.ChatID]

	if self.ElementID == cfgData.Speaker then
		self.View:SetActive(true)

		self.IsShow = true

		UGUIUtil.SetTextInChildren(self.View, cfgData.ChatWord)

		self.StartShowTimer = UnityEngine.Time.realtimeSinceStartup
	end
end

function m:EndShow()
	self.IsShow = false

	self.View:SetActive(false)

	if self.ShowEndCallBack then
		self.ShowEndCallBack(self.ChatID, self.ElementID)
	end

	self.ShowEndCallBack = nil
end

function m:Dispose()
	self:RemoveListener()

	self.ShowEndCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
