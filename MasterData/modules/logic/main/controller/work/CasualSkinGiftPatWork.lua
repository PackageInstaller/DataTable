-- chunkname: @modules/logic/main/controller/work/CasualSkinGiftPatWork.lua

module("modules.logic.main.controller.work.CasualSkinGiftPatWork", package.seeall)

local CasualSkinGiftPatWork = class("CasualSkinGiftPatWork", ActivityRoleSignWorkBase)

function CasualSkinGiftPatWork:onGetViewNames()
	local viewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)

	if not string.nilorempty(viewName) then
		return {
			viewName
		}
	end

	return {
		ViewName.CasualSkinGift_PanelView
	}
end

function CasualSkinGiftPatWork:onGetActIds()
	local actId = PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)

	if actId and actId > 0 then
		return {
			actId
		}
	end

	return {
		(ActivityType101Config.instance:getCasualSkinGiftActId())
	}
end

function CasualSkinGiftPatWork:onWork(refWorkContext)
	local actId = self._actId

	if not self:_hasShowToday(actId) and ActivityType101Model.instance:isOpen(actId) then
		refWorkContext.bAutoWorkNext = false

		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	else
		refWorkContext.bAutoWorkNext = true
	end
end

function CasualSkinGiftPatWork:_onOpenViewFinish(viewName)
	CasualSkinGiftPatWork.super._onOpenViewFinish(self, viewName)

	if viewName ~= self._viewName then
		return
	end

	local actId = self._actId

	self:_setShownToday(actId)
end

local kShownTodayFlag = "CasualSkinGiftPatWork_ShownToday"

function CasualSkinGiftPatWork:_playerpfsKey(actId)
	return kShownTodayFlag .. tostring(actId)
end

function CasualSkinGiftPatWork:_hasShowToday(actId)
	local key = self:_playerpfsKey(actId)
	local bNotLoginToday = TimeUtil.getDayFirstLoginRed(key)

	return not bNotLoginToday
end

function CasualSkinGiftPatWork:_setShownToday(actId)
	local key = self:_playerpfsKey(actId)

	TimeUtil.setDayFirstLoginRed(key)
end

return CasualSkinGiftPatWork
