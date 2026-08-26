-- chunkname: @modules/logic/dragonboat/controller/work/DragonBoatFestivalPatFaceWork.lua

module("modules.logic.dragonboat.controller.work.DragonBoatFestivalPatFaceWork", package.seeall)

local DragonBoatFestivalPatFaceWork = class("DragonBoatFestivalPatFaceWork", PatFaceWorkBase)

function DragonBoatFestivalPatFaceWork:onStart(context)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.DragonBoatFestival) then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onShowFinish, self)

	local hasCouldGetReward = DragonBoatFestivalModel.instance:hasRewardNotGet()

	if hasCouldGetReward then
		DragonBoatFestivalController.instance:openDragonBoatFestivalView()
	else
		self:onDone(true)
	end
end

function DragonBoatFestivalPatFaceWork:_onShowFinish(viewName)
	if viewName == ViewName.DragonBoatFestivalView then
		self:onDone(true)
	end
end

function DragonBoatFestivalPatFaceWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onShowFinish, self)
end

return DragonBoatFestivalPatFaceWork
