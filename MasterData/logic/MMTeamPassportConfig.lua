-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/config/MMTeamPassportConfig.lua

module("logic.extensions.mmteampassport.config.MMTeamPassportConfig", package.seeall)

local MMTeamPassportConfig = class("MMTeamPassportConfig", BaseConfig)

function MMTeamPassportConfig:getNames()
	return {
		"mm_team_passport_activity",
		"mm_team_passport_team_prize"
	}
end

function MMTeamPassportConfig:handleConfig(name, content)
	if name == "mm_team_passport_activity" then
		self._mm_team_passport_activity = content
	elseif name == "mm_team_passport_team_prize" then
		self._mm_team_passport_team_prize = content
	end
end

function MMTeamPassportConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function MMTeamPassportConfig:getActivityData(activityId)
	return self:_safeGet(self._mm_team_passport_activity, activityId)
end

function MMTeamPassportConfig:getTeamPrizeDatas(activityId)
	return self:_safeGet(self._mm_team_passport_team_prize, activityId)
end

function MMTeamPassportConfig:getTeamPrizeData(activityId, prizeId)
	return self:_safeGet(self._mm_team_passport_team_prize, activityId, prizeId)
end

MMTeamPassportConfig.instance = MMTeamPassportConfig.New()

return MMTeamPassportConfig
