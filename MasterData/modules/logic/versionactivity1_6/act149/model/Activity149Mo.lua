-- chunkname: @modules/logic/versionactivity1_6/act149/model/Activity149Mo.lua

module("modules.logic.versionactivity1_6.act149.model.Activity149Mo", package.seeall)

local Activity149Mo = class("Activity149Mo")

function Activity149Mo:ctor(id, activityId)
	self.id = id
	self._activityId = activityId
	self.cfg = self:getAct149EpisodeCfg(id)
end

function Activity149Mo:getAct149EpisodeCfg(id)
	return Activity149Config.instance:getAct149EpisodeCfg(id)
end

return Activity149Mo
