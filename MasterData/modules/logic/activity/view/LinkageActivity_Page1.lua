-- chunkname: @modules/logic/activity/view/LinkageActivity_Page1.lua

module("modules.logic.activity.view.LinkageActivity_Page1", package.seeall)

local LinkageActivity_Page1 = class("LinkageActivity_Page1", LinkageActivity_PageBase)

function LinkageActivity_Page1:ctor(...)
	LinkageActivity_Page1.super.ctor(self, ...)
end

function LinkageActivity_Page1:getDurationTimeStr()
	local CO = self:getLinkageActivityCO()

	return StoreController.instance:getRecommendStoreTime(CO)
end

return LinkageActivity_Page1
