-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/config/ShowOffRankConfig.lua

module("logic.extensions.showoff.config.ShowOffRankConfig", package.seeall)

local ShowOffRankConfig = class("ShowOffRankConfig", BaseConfig)

function ShowOffRankConfig:getNames()
	return {
		"show_off_rank_tab",
		"show_off_rank_common"
	}
end

function ShowOffRankConfig:handleConfig(name, content)
	if name == "show_off_rank_tab" then
		self._show_off_rank_tab = content
	elseif name == "show_off_rank_common" then
		self._show_off_rank_common = content
	end
end

function ShowOffRankConfig:getShowOffRankTabList()
	return self._show_off_rank_tab.dataList
end

function ShowOffRankConfig:getShowOffRankCommon(key)
	if self._show_off_rank_common[key] then
		return self._show_off_rank_common[key].value
	end

	return ""
end

ShowOffRankConfig.instance = ShowOffRankConfig.New()

return ShowOffRankConfig
