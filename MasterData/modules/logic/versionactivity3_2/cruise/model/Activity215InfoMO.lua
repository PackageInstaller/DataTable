-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity215InfoMO.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity215InfoMO", package.seeall)

local Activity215InfoMO = pureTable("Activity215InfoMO")

function Activity215InfoMO:init(info)
	self.currentMainStage = info.currentMainStage
	self.itemSubmitCount = info.itemSubmitCount
	self.acceptedRewardId = info.acceptedRewardId
end

function Activity215InfoMO:updateCurrentMainStage(stage)
	self.currentMainStage = stage
end

function Activity215InfoMO:updateItemSubmitCount(count)
	self.itemSubmitCount = count
end

function Activity215InfoMO:updateAcceptedRewardId(id)
	self.acceptedRewardId = id
end

return Activity215InfoMO
