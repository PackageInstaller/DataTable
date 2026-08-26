-- chunkname: @modules/logic/versionactivity2_5/act186/model/Activity186SignModel.lua

module("modules.logic.versionactivity2_5.act186.model.Activity186SignModel", package.seeall)

local Activity186SignModel = class("Activity186SignModel", BaseModel)

function Activity186SignModel:getSignStatus(activityId, activity186Id, signId)
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(activityId, signId)

	if rewardGet then
		return Activity186Enum.SignStatus.Hasget
	end

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(activityId, signId)

	if not couldGet then
		return Activity186Enum.SignStatus.None
	end

	local value = Activity186Model.instance:getLocalPrefsState(Activity186Enum.LocalPrefsKey.SignMark, activity186Id, signId, 0)

	if value == 0 then
		return Activity186Enum.SignStatus.Canplay
	end

	return Activity186Enum.SignStatus.Canget
end

Activity186SignModel.instance = Activity186SignModel.New()

return Activity186SignModel
