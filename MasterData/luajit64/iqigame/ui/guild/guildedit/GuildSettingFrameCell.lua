-- chunkname: @IQIGame\\UI\\Guild\\GuildEdit\\GuildSettingFrameCell.lua

local m = {
	isCurrentSetting = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.Tag, GuildEditUIApi:GetString("TagText"))
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.guildFrameData = data

	self.Lock:SetActive(self.guildFrameData.unLock == 0)

	local avatarPath = UIGlobalApi.GetIconPath(CfgGuildAvatarFrameTable[self.guildFrameData.cfgID].Url)

	AssetUtil.LoadImage(self, avatarPath, self.HeadFrame:GetComponent("Image"))
end

function m:SetCurrentPutOn(top)
	self.Tag:SetActive(top)
end

function m:Select(top)
	self.Choose:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
