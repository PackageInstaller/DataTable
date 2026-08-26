-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/model/Activity164Model.lua

module("modules.logic.versionactivity2_1.lanshoupa.model.Activity164Model", package.seeall)

local Activity164Model = class("Activity164Model", BaseModel)

function Activity164Model:onInit()
	self._passEpisodes = {}
	self._unLockCount = 0
	self._curActivityId = 0
	self.currChessGameEpisodeId = 0
end

function Activity164Model:reInit()
	self._passEpisodes = {}
	self._unLockCount = 0
	self._curActivityId = 0
	self.currChessGameEpisodeId = 0
end

function Activity164Model:getCurActivityID()
	return self._curActivityId
end

function Activity164Model:onReceiveGetAct164InfoReply(msg)
	self._curActivityId = msg.activityId
	self._passEpisodes = {}
	self._unLockCount = 0
	self.currChessGameEpisodeId = msg.currChessGameEpisodeId

	for i, v in ipairs(msg.episodes) do
		local id = v.episodeId
		local co = Activity164Config.instance:getEpisodeCo(msg.activityId, id)

		self._passEpisodes[id] = co and co.mapIds <= 0 and StoryModel.instance:isStoryFinished(co.storyBefore) or v.passChessGame

		if self._passEpisodes[id] then
			self._unLockCount = self._unLockCount + 1
		else
			break
		end
	end
end

function Activity164Model:markEpisodeFinish(episodeId)
	if not self._passEpisodes[episodeId] then
		self._passEpisodes[episodeId] = true
		self._unLockCount = self._unLockCount + 1

		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.OnEpisodeFinish, self._episodeId)
	end
end

function Activity164Model:getUnlockCount()
	return self._unLockCount
end

function Activity164Model:getEpisodeData(id)
	return self._passEpisodes[id]
end

function Activity164Model:isEpisodeClear(id)
	local episodeData = self:getEpisodeData(id)

	if episodeData then
		return true
	end

	return false
end

function Activity164Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity164Model:getCurEpisodeId()
	return self._curEpisodeId or LanShouPaEnum.episodeId
end

Activity164Model.instance = Activity164Model.New()

return Activity164Model
