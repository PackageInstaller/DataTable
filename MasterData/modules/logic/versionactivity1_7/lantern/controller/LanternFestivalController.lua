-- chunkname: @modules/logic/versionactivity1_7/lantern/controller/LanternFestivalController.lua

module("modules.logic.versionactivity1_7.lantern.controller.LanternFestivalController", package.seeall)

local LanternFestivalController = class("LanternFestivalController", BaseController)

function LanternFestivalController:onInit()
	self:reInit()
end

function LanternFestivalController:reInit()
	return
end

function LanternFestivalController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function LanternFestivalController:_checkActivityInfo()
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.LanternFestival) then
		Activity154Rpc.instance:sendGet154InfosRequest(ActivityEnum.Activity.LanternFestival)
	end
end

function LanternFestivalController:openQuestionTipView(data)
	ViewMgr.instance:openView(ViewName.LanternFestivalQuestionTipView, data)
end

function LanternFestivalController:openLanternFestivalView()
	ViewMgr.instance:openView(ViewName.LanternFestivalView)
end

LanternFestivalController.instance = LanternFestivalController.New()

return LanternFestivalController
