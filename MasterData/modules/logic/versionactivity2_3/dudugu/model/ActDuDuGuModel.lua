-- chunkname: @modules/logic/versionactivity2_3/dudugu/model/ActDuDuGuModel.lua

module("modules.logic.versionactivity2_3.dudugu.model.ActDuDuGuModel", package.seeall)

local ActDuDuGuModel = class("ActDuDuGuModel", BaseModel)

function ActDuDuGuModel:onInit()
	self:reInit()
end

function ActDuDuGuModel:reInit()
	self._curLvIndex = 0
end

function ActDuDuGuModel:setCurLvIndex(index)
	self._curLvIndex = index
end

function ActDuDuGuModel:getCurLvIndex()
	return self._curLvIndex or 0
end

function ActDuDuGuModel:initData(actId)
	RoleActivityModel.instance:initData(actId)
end

function ActDuDuGuModel:updateData(actId)
	RoleActivityModel.instance:updateData(actId)
end

function ActDuDuGuModel:isLevelUnlock(actId, episodeId)
	return (RoleActivityModel.instance:isLevelUnlock(actId, episodeId))
end

function ActDuDuGuModel:isLevelPass(actId, episodeId)
	return (RoleActivityModel.instance:isLevelPass(actId, episodeId))
end

function ActDuDuGuModel:getNewFinishStoryLvl()
	local actId = VersionActivity2_3Enum.ActivityId.DuDuGu
	local episodeCos = RoleActivityConfig.instance:getStoryLevelList(actId)
	local episodeId = episodeCos[self._curLvIndex].id

	if not episodeId or episodeId <= 0 then
		return
	end

	if self._curLvIndex + 1 <= #episodeCos then
		if not episodeCos[self._curLvIndex + 1].id then
			local nextEpisode = 0

			if nextEpisode > 0 then
				local isPass = self:isLevelPass(actId, episodeId)
				local storyId = episodeCos[self._curLvIndex].afterStory
				local isUnlock = self:isLevelUnlock(actId, nextEpisode)

				if isPass and not isUnlock and (storyId > 0 or nil) and StoryModel.instance:isStoryFinished(storyId) then
					self.newFinishStoryLvlId = episodeId

					return self.newFinishStoryLvlId
				end
			end

			self.newFinishStoryLvlId = RoleActivityModel.instance:getNewFinishStoryLvl()

			return self.newFinishStoryLvlId
		end
	end
end

function ActDuDuGuModel:clearNewFinishStoryLvl()
	RoleActivityModel.instance:clearNewFinishStoryLvl()

	return self.newFinishStoryLvlId
end

ActDuDuGuModel.instance = ActDuDuGuModel.New()

return ActDuDuGuModel
