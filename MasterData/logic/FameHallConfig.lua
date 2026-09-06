-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/config/FameHallConfig.lua

module("logic.extensions.famehall.config.FameHallConfig", package.seeall)

local FameHallConfig = class("FameHallConfig", BaseConfig)

function FameHallConfig:onInit()
	FameHallConfig.super.onInit(self)
end

function FameHallConfig:getNames()
	return {
		"fame_hall",
		"fame_hall_teen_champion"
	}
end

function FameHallConfig:handleConfig(name, content)
	if name == "fame_hall" then
		self._fame_hall = content
	elseif name == "fame_hall_teen_champion" then
		self._fame_hall_teen_champion = content
	end
end

function FameHallConfig:getTabList()
	return self._fame_hall.dataList
end

function FameHallConfig:getTabCfg(tabId)
	return self._fame_hall[tabId]
end

function FameHallConfig:getTeenChampionSeasonDataList()
	return self._fame_hall_teen_champion.dataList
end

FameHallConfig.instance = FameHallConfig.New()

return FameHallConfig
