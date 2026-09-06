-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaostory/config/FuYaoStoryConfig.lua

module("logic.extensions.divinemizongclg.config.FuYaoStoryConfig", package.seeall)

local FuYaoStoryConfig = class("FuYaoStoryConfig", BaseConfig)

function FuYaoStoryConfig:getNames()
	return {
		"fuyao_story_base",
		"fuyao_story_enter",
		"fuyao_story_story"
	}
end

function FuYaoStoryConfig:handleConfig(name, content)
	if name == "fuyao_story_base" then
		self._fuyao_story_base = content
	elseif name == "fuyao_story_enter" then
		self._fuyao_story_enter = content
	elseif name == "fuyao_story_story" then
		self._fuyao_story_story = content
	end
end

function FuYaoStoryConfig:getBaseDataList()
	return self._fuyao_story_base.dataList
end

function FuYaoStoryConfig:getBaseData(basePlanId)
	return self._fuyao_story_base[basePlanId]
end

function FuYaoStoryConfig:getEnterCfg(basePlanId)
	return self._fuyao_story_enter[basePlanId]
end

function FuYaoStoryConfig:getEnterData(basePlanId, stepId)
	if self._fuyao_story_enter[basePlanId] then
		return self._fuyao_story_enter[basePlanId][stepId]
	end
end

function FuYaoStoryConfig:getStoryCfg(basePlanId)
	return self._fuyao_story_story[basePlanId]
end

function FuYaoStoryConfig:getStoryData(basePlanId, plotId)
	if self._fuyao_story_story[basePlanId] then
		return self._fuyao_story_story[basePlanId][plotId]
	end
end

function FuYaoStoryConfig:getStoryId(basePlanId, plotId)
	local data = self:getStoryData(basePlanId, plotId)

	return (data or nil) and (data.storyId or 0)
end

function FuYaoStoryConfig:getStoryCfgByStep(basePlanId, stepId)
	self._storyCfg = self._storyCfg or {}

	if self._storyCfg[basePlanId] then
		local cfg = self._storyCfg[basePlanId][stepId]

		if cfg == nil then
			local config = self._fuyao_story_story[basePlanId]

			if config then
				self._storyCfg[basePlanId] = {}
				self._storyCfg[basePlanId][stepId] = {}
				cfg = self._storyCfg[basePlanId][stepId]

				for i, data in pairs(config) do
					if stepId == data.stepId then
						table.insert(cfg, data)
					end
				end

				table.sort(cfg, function(a, b)
					return a.plotId < b.plotId
				end)
			end
		end

		return cfg
	end
end

FuYaoStoryConfig.instance = FuYaoStoryConfig.New()

return FuYaoStoryConfig
