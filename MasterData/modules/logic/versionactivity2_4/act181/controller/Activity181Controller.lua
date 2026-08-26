-- chunkname: @modules/logic/versionactivity2_4/act181/controller/Activity181Controller.lua

module("modules.logic.versionactivity2_4.act181.controller.Activity181Controller", package.seeall)

local Activity181Controller = class("Activity181Controller", BaseController)

function Activity181Controller:onInit()
	return
end

function Activity181Controller:onInitFinish()
	return
end

function Activity181Controller:addConstEvents()
	return
end

function Activity181Controller:reInit()
	return
end

function Activity181Controller:getActivityInfo(activityId, callBack, callBackObj)
	Activity181Rpc.instance:SendGet181InfosRequest(activityId, callBack, callBackObj)
end

function Activity181Controller:getBonus(activityId, pos, callBack, callBackObj)
	Activity181Rpc.instance:SendGet181BonusRequest(activityId, pos, callBack, callBackObj)
end

function Activity181Controller:getSPBonus(activityId, callBack, callBackObj)
	Activity181Rpc.instance:SendGet181SpBonusRequest(activityId, callBack, callBackObj)
end

Activity181Controller.instance = Activity181Controller.New()

return Activity181Controller
