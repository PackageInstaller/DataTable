-- chunkname: @modules/logic/activitywelfare/model/ActivityWelfareModel.lua

module("modules.logic.activitywelfare.model.ActivityWelfareModel", package.seeall)

local ActivityWelfareModel = class("ActivityWelfareModel", BaseModel)

function ActivityWelfareModel:onInit()
	self:reInit()
end

function ActivityWelfareModel:reInit()
	return
end

function ActivityWelfareModel:is3_8NewRegisterPlayer()
	local time = CommonConfig.instance:getConstNum(ConstEnum.V3a8NewRegisterPlayerTime)
	local playerRegTime = PlayerModel.instance:getPlayerRegisterTime()

	return time <= tonumber(playerRegTime) / 1000
end

ActivityWelfareModel.instance = ActivityWelfareModel.New()

return ActivityWelfareModel
