-- chunkname: @IQIGame\\UI\\Guild\\GuildEdit\\GuildSettingHeadCell.lua

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
	self.guildHeadIconData = data

	local headPath = UIGlobalApi.GetIconPath(CfgGuildHeadIconTable[self.guildHeadIconData.cfgID].Url)

	AssetUtil.LoadImage(self, headPath, self.GuildHeadIcon:GetComponent("Image"))
	self.Lock:SetActive(self.guildHeadIconData.unLock == 0)
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
