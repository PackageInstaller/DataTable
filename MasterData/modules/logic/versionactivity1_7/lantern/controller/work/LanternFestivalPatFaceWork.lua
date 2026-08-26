-- chunkname: @modules/logic/versionactivity1_7/lantern/controller/work/LanternFestivalPatFaceWork.lua

module("modules.logic.versionactivity1_7.lantern.controller.work.LanternFestivalPatFaceWork", package.seeall)

local LanternFestivalPatFaceWork = class("LanternFestivalPatFaceWork", PatFaceWorkBase)

function LanternFestivalPatFaceWork:onStart(context)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.LanternFestival) then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onShowFinish, self)

	local hasPuzzleCouldGetReward = LanternFestivalModel.instance:hasPuzzleCouldGetReward()

	if hasPuzzleCouldGetReward then
		LanternFestivalController.instance:openLanternFestivalView()
	else
		self:onDone(true)
	end
end

function LanternFestivalPatFaceWork:_onShowFinish(viewName)
	if viewName == ViewName.LanternFestivalView then
		self:onDone(true)
	end
end

function LanternFestivalPatFaceWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onShowFinish, self)
end

return LanternFestivalPatFaceWork
