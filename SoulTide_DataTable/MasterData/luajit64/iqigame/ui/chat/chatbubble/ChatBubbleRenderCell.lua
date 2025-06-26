-- chunkname: @IQIGame\\UI\\Chat\\ChatBubble\\ChatBubbleRenderCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TagLockLabel, ChatBubbleUIApi:GetString("TagLockLabel"))
	UGUIUtil.SetText(self.TagUseLabel, ChatBubbleUIApi:GetString("TagUseLabel"))
	self:AddListener()
	self:SetSelect(false)
	self:SetCurrentUse(false)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.chatBubbleData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.chatBubbleData then
		local path = UIGlobalApi.GetImagePath(self.chatBubbleData:GetConfigData().Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		self.TagLock:SetActive(not self.chatBubbleData.unlock)
	end
end

function m:SetCurrentUse(top)
	self.TagUse:SetActive(top)
end

function m:SetSelect(top)
	self.ImgCheck:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
