-- chunkname: @modules/logic/matchgame/outside/enter/MatchGameVersionActivityEnterView.lua

module("modules.logic.matchgame.outside.enter.MatchGameVersionActivityEnterView", package.seeall)

local MatchGameVersionActivityEnterView = class("MatchGameVersionActivityEnterView", BaseView)

function MatchGameVersionActivityEnterView:onInitView()
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_normal")
	self._goNormalRedDot = gohelper.findChild(self.viewGO, "entrance/#btn_normal/#go_normalreddot")
	self._goLocked = gohelper.findChild(self.viewGO, "entrance/#go_Locked")
	self._txtTime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameVersionActivityEnterView:addEvents()
	self._btnNormal:AddClickListener(self._btnNormalOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateEpisodeInfo, self._onUpdateEpisodeInfo, self)
end

function MatchGameVersionActivityEnterView:removeEvents()
	self._btnNormal:RemoveClickListener()
end

function MatchGameVersionActivityEnterView:_btnNormalOnClick()
	if self:checkIsActOpen() then
		MatchGameController.instance:openEnterView(self._actId)
	end
end

function MatchGameVersionActivityEnterView:checkIsActOpen()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	return true
end

function MatchGameVersionActivityEnterView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.MatchGame

	RedDotController.instance:addRedDot(self._goNormalRedDot, RedDotEnum.DotNode.MatchGameEntry)
end

function MatchGameVersionActivityEnterView:onOpen()
	self:refreshUI()
end

function MatchGameVersionActivityEnterView:refreshUI()
	self:refreshEntry()
	self:tickRefresh()
end

function MatchGameVersionActivityEnterView:refreshEntry()
	self._isOpen = ActivityHelper.isOpen(self._actId)

	gohelper.setActive(self._goLocked, not self._isOpen)
end

function MatchGameVersionActivityEnterView:tickRefresh()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runDelay(self.refreshRemainTime, self, 30)
end

function MatchGameVersionActivityEnterView:refreshRemainTime()
	self._txtTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function MatchGameVersionActivityEnterView:_onUpdateEpisodeInfo()
	self:refreshUI()
end

function MatchGameVersionActivityEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return MatchGameVersionActivityEnterView
