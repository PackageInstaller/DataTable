-- chunkname: @modules/logic/versionactivity3_7/anniversary3/model/Anniversary3Model.lua

module("modules.logic.versionactivity3_7.anniversary3.model.Anniversary3Model", package.seeall)

local Anniversary3Model = class("Anniversary3Model", BaseModel)

function Anniversary3Model:onInit()
	self._showTypeMechine = false
end

function Anniversary3Model:reInit()
	self._showTypeMechine = false
end

function Anniversary3Model:changeShowTypeMechine()
	self._showTypeMechine = not self._showTypeMechine
end

function Anniversary3Model:getShowTypeMechine()
	return self._showTypeMechine
end

function Anniversary3Model:cleanShowTypeMechine()
	self._showTypeMechine = false
end

function Anniversary3Model:checkAnnualReviewShowRed()
	return ActivityHelper.isOpen(Activity2ndEnum.ActivityId.AnnualReview) and GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 0) == 0
end

Anniversary3Model.instance = Anniversary3Model.New()

return Anniversary3Model
