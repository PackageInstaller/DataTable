-- chunkname: @IQIGame\\UI\\Guild\\GuildMain\\GuildHeadCell.lua

local m = {}

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

function m:SetData(headIcon, avatarFrame, lv)
	self.headIcon = headIcon
	self.avatarFrame = avatarFrame

	if self.headIcon == 0 then
		self.headIcon = GuildModule.GetGuildDefaultHeadIcon()
	end

	if self.avatarFrame == 0 then
		self.avatarFrame = GuildModule.GetGuildDefaultAvatarFrame()
	end

	self.lv = lv

	self:UpDateView()
end

function m:UpDateView()
	local headPath = UIGlobalApi.GetIconPath(CfgGuildHeadIconTable[self.headIcon].Url)

	AssetUtil.LoadImage(self, headPath, self.HeadIcon:GetComponent("Image"))

	local avatarPath = UIGlobalApi.GetIconPath(CfgGuildAvatarFrameTable[self.avatarFrame].Url)

	AssetUtil.LoadImage(self, avatarPath, self.HeadFrame:GetComponent("Image"))

	if self.LevelText then
		UGUIUtil.SetText(self.LevelText, GuildMainUIApi:GetString("LevelText", self.lv))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
