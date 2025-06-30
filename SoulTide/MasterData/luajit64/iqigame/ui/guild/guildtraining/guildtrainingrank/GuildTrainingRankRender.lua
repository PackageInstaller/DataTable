-- chunkname: @IQIGame\\UI\\Guild\\GuildTraining\\GuildTrainingRank\\GuildTrainingRankRender.lua

local m = {}
local GuildHeadCell = require("IQIGame.UI.Guild.GuildMain.GuildHeadCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.guildHeadCell = GuildHeadCell.New(self.GuildHead)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.guildRankData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.guildRankData then
		self.guildHeadCell:SetData(self.guildRankData.iconCid, self.guildRankData.avatarFrameCid)
		UGUIUtil.SetText(self.GuildName, self.guildRankData.guildName)
		UGUIUtil.SetText(self.GuildScore, self.guildRankData.guildScore)
		UGUIUtil.SetText(self.GuildScore, GuildTrainingRankUIApi:GetString("GuildScore", self.guildRankData.guildScore))
		UGUIUtil.SetText(self.TextRank, GuildTrainingRankUIApi:GetString("TextRank", self.guildRankData.rank, self.guildRankData.rankType))

		if self.guildRankData.cfgRankRewardData then
			local path = UIGlobalApi.GetImagePath(self.guildRankData.cfgRankRewardData.Image)

			AssetUtil.LoadImage(self, path, self.RankIcon:GetComponent("Image"))
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.guildHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
