-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collection/config/CollectionConfig.lua

module(..., package.seeall)

local CollectionConfig = class("CollectionConfig", BaseConfig)

function CollectionConfig:onInit()
	self._playDistribution = nil
end

function CollectionConfig:getNames()
	return {
		"play_distribution"
	}
end

function CollectionConfig:handleConfig(name, content)
	if name == "play_distribution" then
		self._playDistribution = content
	end
end

function CollectionConfig:getPlayListByType(type)
	local playList = {}
	local dataList = self._playDistribution.dataList

	for i = 1, #dataList do
		local data = dataList[i]

		if data.tab == type then
			table.insert(playList, data)
		end
	end

	return playList
end

CollectionConfig.instance = CollectionConfig.New()

return CollectionConfig
