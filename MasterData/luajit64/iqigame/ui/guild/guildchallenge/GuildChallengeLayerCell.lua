-- chunkname: @IQIGame\\UI\\Guild\\GuildChallenge\\GuildChallengeLayerCell.lua

local m = {
	isOpen = false,
	isPass = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data, isPass, isOpen)
	self.guildChallengeLayerData = data
	self.isPass = isPass
	self.isOpen = isOpen

	self:UpdateView()
end

function m:UpdateView()
	self.NodeLock:SetActive(not self.isPass)
	self.TextLock:SetActive(not self.isOpen)
	self.ImgLock:SetActive(not self.isOpen)
	UGUIUtil.SetText(self.OnText1, self.guildChallengeLayerData.StageName)
	UGUIUtil.SetText(self.OffText1, self.guildChallengeLayerData.StageName)
	UGUIUtil.SetText(self.OffText2, self.guildChallengeLayerData.StageName)
	UGUIUtil.SetText(self.TextLock, self.guildChallengeLayerData.LockDesc)
end

function m:SetSelect(top)
	self.GoUp:SetActive(top)
	self.GoDown:SetActive(not top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
