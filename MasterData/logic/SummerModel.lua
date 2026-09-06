-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summer/model/SummerModel.lua

module("logic.extensions.summer.model.SummerModel", package.seeall)

local SummerModel = class("SummerModel", BaseModel)

function SummerModel:ctor()
	return
end

function SummerModel:onInit()
	return
end

function SummerModel:onReset()
	return
end

function SummerModel:getOpenActivityId()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.Summer)
	local id

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end

		id = item.activityId
	end

	return id
end

function SummerModel:getBestQuality(poolId)
	return
end

SummerModel.instance = SummerModel.New()

return SummerModel
