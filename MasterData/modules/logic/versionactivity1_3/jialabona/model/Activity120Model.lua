-- chunkname: @modules/logic/versionactivity1_3/jialabona/model/Activity120Model.lua

module("modules.logic.versionactivity1_3.jialabona.model.Activity120Model", package.seeall)

local Activity120Model = class("Activity120Model", BaseModel)

function Activity120Model:onInit()
	self._curEpisodeId = 0
end

function Activity120Model:reInit()
	self._curEpisodeId = 0
end

function Activity120Model:getCurActivityID()
	return self._curActivityId
end

function Activity120Model:onReceiveGetAct120InfoReply(proto)
	self._curActivityId = proto.activityId
	self._episodeInfoData = {}

	for i, v in ipairs(proto.episodes) do
		local id = v.id

		self._episodeInfoData[id] = {}
		self._episodeInfoData[id].id = v.id
		self._episodeInfoData[id].star = v.star
		self._episodeInfoData[id].totalCount = v.totalCount
	end
end

function Activity120Model:getEpisodeData(id)
	return self._episodeInfoData and self._episodeInfoData[id]
end

function Activity120Model:isEpisodeClear(id)
	local episodeData = self:getEpisodeData(id)

	if episodeData then
		return episodeData.star > 0
	end

	return false
end

function Activity120Model:getTaskData(id)
	return TaskModel.instance:getTaskById(id)
end

function Activity120Model:increaseCount(id)
	if self._episodeInfoData then
		if self._episodeInfoData then
			self._episodeInfoData.totalCount = self._episodeInfoData.totalCount + 1
		end
	end
end

function Activity120Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity120Model:getCurEpisodeId()
	return self._curEpisodeId
end

Activity120Model.instance = Activity120Model.New()

return Activity120Model
