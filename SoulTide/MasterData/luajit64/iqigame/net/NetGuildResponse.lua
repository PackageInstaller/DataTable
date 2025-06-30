-- chunkname: @IQIGame\\Net\\NetGuildResponse.lua

function net_guild.signResult(code, itemShows)
	GuildModule.SignResult(itemShows)
end

function net_guild.getGuildQuestRewardsResult(code, ids, items)
	GuildModule.GetGuildQuestRewardsResult(ids, items)
end

function net_guild.refreshRedPointResult(code, status)
	GuildModule.RefreshRedPointResult(status)
end
