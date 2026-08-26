-- chunkname: @modules/logic/versionactivity2_8/activity2nd/model/Activity2ndModel.lua

module("modules.logic.versionactivity2_8.activity2nd.model.Activity2ndModel", package.seeall)

local Activity2ndModel = class("Activity2ndModel", BaseModel)

function Activity2ndModel:onInit()
	self._showTypeMechine = false
end

function Activity2ndModel:reInit()
	self._showTypeMechine = false
end

function Activity2ndModel:changeShowTypeMechine()
	self._showTypeMechine = not self._showTypeMechine
end

function Activity2ndModel:getShowTypeMechine()
	return self._showTypeMechine
end

function Activity2ndModel:cleanShowTypeMechine()
	self._showTypeMechine = false
end

function Activity2ndModel:checkAnnualReviewShowRed()
	return ActivityHelper.isOpen(Activity2ndEnum.ActivityId.AnnualReview) and GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 0) == 0
end

Activity2ndModel.instance = Activity2ndModel.New()

return Activity2ndModel
