-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/config/Activity210Config.lua

module("modules.logic.versionactivity3_1.gaosiniao.config.Activity210Config", package.seeall)

local Activity210Config = class("Activity210Config", BaseConfig)

function Activity210Config:ctor()
	self.__activityId = false
end

function Activity210Config:reqConfigNames()
	return {
		"activity210_const",
		"activity210_episode",
		"activity210_task"
	}
end

function Activity210Config:onConfigLoaded(configName, configTable)
	if configName == "activity210_const" then
		self.__activityId = false
	end
end

local function _getEpisodeCO(activityId, episodeId)
	return lua_activity210_episode.configDict[activityId][episodeId]
end

local function _getConstCO(activityId, id)
	return lua_activity210_const.configDict[activityId][id]
end

function Activity210Config:getConstWithActId(activityId, id)
	local CO = _getConstCO(activityId, id)

	if not CO then
		return nil, nil
	end

	return CO.value, CO.value2
end

function Activity210Config:actId()
	if self.__activityId then
		return self.__activityId
	end

	self.__activityId = ActivityConfig.instance:getConstAsNum(2, 13118)

	return self.__activityId
end

function Activity210Config:getEpisodeCO(episodeId)
	return _getEpisodeCO(self:actId(), episodeId)
end

function Activity210Config:getPreEpisodeId(episodeId)
	if not episodeId then
		return 0
	end

	local CO = self:getEpisodeCO(episodeId)

	if not CO then
		return 0
	end

	return CO.preEpisodeId
end

function Activity210Config:getPreEpisodeCO(episodeId)
	local preEpisodeId = self:getPreEpisodeId(episodeId)

	if preEpisodeId <= 0 then
		return nil
	end

	return self:getEpisodeCO(preEpisodeId)
end

function Activity210Config:getStoryIdPrePost(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	if not CO then
		return 0, 0
	end

	return CO.storyBefore, CO.storyClear
end

function Activity210Config:getPreStoryId(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	return (CO or nil) and (CO.storyBefore or 0)
end

function Activity210Config:getPostStoryId(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	return (CO or nil) and (CO.storyClear or 0)
end

function Activity210Config:getPreEpisodeBranchId(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	return CO.preEpisodeBranchId or 0
end

function Activity210Config:getEpisodeCO_gameId(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	return (CO or nil) and (CO.gameId or 0)
end

function Activity210Config:getEpisodeCO_disactiveEpisodeInfoList(episodeId)
	if not episodeId or episodeId <= 0 then
		return {}
	end

	local CO = self:getEpisodeCO(episodeId)

	if CO then
		if not CO.disactiveEpisodeIds then
			local str

			if string.nilorempty(str) then
				return {}
			end

			return GameUtil.splitString2(str, true)
		end
	end
end

function Activity210Config:getEpisodeCOs()
	local actId = self:actId()

	if not actId then
		return {}
	end

	return lua_activity210_episode.configDict[actId]
end

function Activity210Config:isSP(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	if not CO then
		return false
	end

	return CO.type == GaoSiNiaoEnum.EpisodeType.SP
end

function Activity210Config:getEpisodeCO_guideId(episodeId)
	local CO = self:getEpisodeCO(episodeId)

	return (CO or nil) and (CO.guideId or 0)
end

return Activity210Config
