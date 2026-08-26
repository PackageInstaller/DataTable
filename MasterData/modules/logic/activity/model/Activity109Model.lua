-- chunkname: @modules/logic/activity/model/Activity109Model.lua

module("modules.logic.activity.model.Activity109Model", package.seeall)

local Activity109Model = class("Activity109Model", BaseModel)

function Activity109Model:onInit()
	return
end

function Activity109Model:reInit()
	return
end

function Activity109Model:getCurActivityID()
	return self._activity_id
end

function Activity109Model:onReceiveGetAct109InfoReply(proto)
	self._activity_id = proto.activityId
	self._is_all_clear = true
	self._episode_data = {}

	self:initChapterClear()

	for i, v in ipairs(proto.episodes) do
		local id = v.id

		self._episode_data[id] = {}
		self._episode_data[id].id = v.id
		self._episode_data[id].star = v.star
		self._episode_data[id].totalCount = v.totalCount

		local cfg = Activity109Config.instance:getEpisodeCo(self._activity_id, id)

		if v.star and v.star <= 0 then
			self._is_all_clear = false

			if cfg then
				self._episode_clear[cfg.chapterId] = false
			end
		end
	end

	Activity109ChessController.instance:dispatchEvent(ActivityEvent.Refresh109ActivityData)
end

function Activity109Model:initChapterClear()
	self._episode_clear = {}

	local _, chapterIdList = Activity109Config.instance:getEpisodeList(self._activity_id)

	for _, chapterId in ipairs(chapterIdList) do
		self._episode_clear[chapterId] = true
	end

	self._chapter_id_list = chapterIdList
end

function Activity109Model:getEpisodeData(id)
	return self._episode_data and self._episode_data[id]
end

function Activity109Model:getTaskData(id)
	return TaskModel.instance:getTaskById(id)
end

function Activity109Model:isAllClear()
	return self._is_all_clear
end

function Activity109Model:isChapterClear(chapterId)
	return self._episode_clear[chapterId]
end

function Activity109Model:getChapterList()
	return self._chapter_id_list
end

function Activity109Model:increaseCount(id)
	if self._episode_data then
		if self._episode_data then
			self._episode_data.totalCount = self._episode_data.totalCount + 1
		end
	end
end

Activity109Model.instance = Activity109Model.New()

return Activity109Model
