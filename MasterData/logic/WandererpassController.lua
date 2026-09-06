-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/controller/WandererpassController.lua

module("logic.extensions.wandererpass.controller.WandererpassController", package.seeall)

local WandererpassController = class("WandererpassController", BaseController)

WandererpassController.CURR_ACTIVITY_ID = 582001

function WandererpassController:onInit()
	self:onReset()
end

function WandererpassController:onReset()
	self._couponSelectMap = {}
end

function WandererpassController:setCouponSelect(activityId, isSelect)
	self._couponSelectMap[activityId] = isSelect
end

function WandererpassController:getCouponSelect(activityId)
	return checkbool(self._couponSelectMap[activityId])
end

WandererpassController.instance = WandererpassController.New()

return WandererpassController
