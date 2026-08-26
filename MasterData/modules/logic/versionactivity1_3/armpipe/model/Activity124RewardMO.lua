-- chunkname: @modules/logic/versionactivity1_3/armpipe/model/Activity124RewardMO.lua

module("modules.logic.versionactivity1_3.armpipe.model.Activity124RewardMO", package.seeall)

local Activity124RewardMO = pureTable("Activity124RewardMO")

function Activity124RewardMO:init(episodeCo)
	self.id = episodeCo.episodeId
	self.config = episodeCo
end

function Activity124RewardMO:isLock()
	return false
end

function Activity124RewardMO:isReceived()
	return Activity124Model.instance:isReceived(self.config.activityId, self.config.episodeId)
end

function Activity124RewardMO:isHasReard()
	return Activity124Model.instance:isHasReard(self.config.activityId, self.config.episodeId)
end

return Activity124RewardMO
