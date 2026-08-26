-- chunkname: @modules/logic/act236/model/Act236InfoMo.lua

module("modules.logic.act236.model.Act236InfoMo", package.seeall)

local Act236InfoMo = pureTable("Act236InfoMo")

function Act236InfoMo:ctor()
	self.activityId = nil
	self.score = nil
	self.gainRewardsDic = {}
end

function Act236InfoMo:updateInfo(infoNo)
	self.activityId = infoNo.activityId
	self.score = infoNo.score

	self:updateReward(infoNo.gainRewardIds)
end

function Act236InfoMo:updateReward(gainRewardIds)
	if gainRewardIds and next(gainRewardIds) then
		for _, id in ipairs(gainRewardIds) do
			self.gainRewardsDic[id] = true
		end
	end
end

function Act236InfoMo:isRewardGet(id)
	return self.gainRewardsDic[id]
end

return Act236InfoMo
