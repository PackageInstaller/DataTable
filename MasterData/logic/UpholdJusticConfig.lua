-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/config/UpholdJusticConfig.lua

module("logic.extensions.upholdjustice.config.UpholdJusticConfig", package.seeall)

local UpholdJusticConfig = class("UpholdJusticConfig", BaseConfig)

function UpholdJusticConfig:getNames()
	return {
		"uphold_justice_rank_prize",
		"uphold_justice_activity",
		"uphold_justice_player_type"
	}
end

function UpholdJusticConfig:handleConfig(name, content)
	if name == "uphold_justice_rank_prize" then
		self._uphold_justice_rank_prize = content
	elseif name == "uphold_justice_activity" then
		self._uphold_justice_activity = content
	elseif name == "uphold_justice_player_type" then
		self._uphold_justice_player_type = content
	end
end

function UpholdJusticConfig:getTypeCfgById(activityId)
	return self._uphold_justice_player_type[activityId]
end

function UpholdJusticConfig:getActCfgById(activityId)
	return self._uphold_justice_activity[activityId]
end

function UpholdJusticConfig:getTypeCfgByIdAndType(activityId, type)
	if self._uphold_justice_player_type[activityId] then
		return self._uphold_justice_player_type[activityId][type]
	end
end

function UpholdJusticConfig:getRankCfgById(activityId)
	return self._uphold_justice_rank_prize[activityId]
end

function UpholdJusticConfig:getPrizeList(activityId, rank)
	local cfgs = self._uphold_justice_rank_prize[activityId]

	if cfgs then
		for i, v in pairs(cfgs) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				return string.split(v.prize, "#")
			end
		end
	end

	return nil
end

function UpholdJusticConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

UpholdJusticConfig.instance = UpholdJusticConfig.New()

return UpholdJusticConfig
