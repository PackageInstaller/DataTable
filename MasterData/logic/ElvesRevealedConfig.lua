-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elvesrevealed/config/ElvesRevealedConfig.lua

module("logic.extensions.elvesrevealed.config.ElvesRevealedConfig", package.seeall)

local ElvesRevealedConfig = class("ElvesRevealedConfig", BaseConfig)

function ElvesRevealedConfig:getNames()
	return {
		"elves_revealed_activity",
		"elves_revealed_tab"
	}
end

function ElvesRevealedConfig:handleConfig(name, content)
	if name == "elves_revealed_activity" then
		self._elves_revealed_activity = content
	elseif name == "elves_revealed_tab" then
		self._elves_revealed_tab = content
	end
end

function ElvesRevealedConfig:getActivityCfgByActId(actId)
	return self._elves_revealed_activity[actId]
end

function ElvesRevealedConfig:getTabCfgsByActId(actId)
	local cfg = {}

	for i, v in ipairs(self._elves_revealed_tab[actId]) do
		if v.startTime and v.endTime then
			local isOpen = GameUtil.checkIsInTimePeriod(v.startTime, v.endTime)

			if isOpen then
				table.insert(cfg, v)
			end
		end
	end

	return cfg
end

ElvesRevealedConfig.instance = ElvesRevealedConfig.New()

return ElvesRevealedConfig
