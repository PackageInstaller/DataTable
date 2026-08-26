-- chunkname: @modules/logic/rouge2/common/model/Rouge2_SaveInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_SaveInfoMO", package.seeall)

local Rouge2_SaveInfoMO = pureTable("Rouge2_SaveInfoMO")

function Rouge2_SaveInfoMO:init(info)
	self.index = info.index
	self.reviewInfo = Rouge2_ReviewMO.New()

	self.reviewInfo:init(info.review)
end

function Rouge2_SaveInfoMO:getIndex()
	return self.index
end

function Rouge2_SaveInfoMO:getReviewInfo()
	return self.reviewInfo
end

return Rouge2_SaveInfoMO
