-- chunkname: @modules/logic/main/controller/work/SummonNewCustomPickPatFaceWork.lua

module("modules.logic.main.controller.work.SummonNewCustomPickPatFaceWork", package.seeall)

local SummonNewCustomPickPatFaceWork = class("SummonNewCustomPickPatFaceWork", PatFaceWorkBase)

function SummonNewCustomPickPatFaceWork:_viewName()
	return PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
end

function SummonNewCustomPickPatFaceWork:_actId()
	return PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)
end

function SummonNewCustomPickPatFaceWork:checkCanPat()
	local actId = self:_actId()

	return SummonNewCustomPickViewModel.instance:isActivityOpen(actId)
end

function SummonNewCustomPickPatFaceWork:startPat()
	self:_startBlock()

	local actId = self:_actId()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnGetServerInfoReply, self._refreshSummonCustomPickActivity, self)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnSummonCustomGet, self._revertOpenState, self)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(actId)
end

function SummonNewCustomPickPatFaceWork:clearWork()
	self:_endBlock()

	self._needRevert = false

	SummonNewCustomPickViewController.instance:unregisterCallback(SummonNewCustomPickEvent.OnGetServerInfoReply, self._refreshSummonCustomPickActivity, self)
	SummonNewCustomPickViewController.instance:unregisterCallback(SummonNewCustomPickEvent.OnSummonCustomGet, self._revertOpenState, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.OnGetReward, self)
end

function SummonNewCustomPickPatFaceWork:_onOpenViewFinish(openingViewName)
	local viewName = self:_viewName()

	if openingViewName ~= viewName then
		return
	end

	self:_endBlock()
end

function SummonNewCustomPickPatFaceWork:_onCloseViewFinish(closingViewName)
	local viewName = self:_viewName()

	if closingViewName ~= viewName then
		return
	end

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	if self._needRevert then
		self._needRevert = false

		return
	end

	self:patComplete()
end

function SummonNewCustomPickPatFaceWork:_refreshSummonCustomPickActivity()
	local actId = self:_actId()
	local viewName = self:_viewName()
	local isFirstLogin = SummonNewCustomPickViewModel.instance:getHaveFirstDayLogin(actId)

	if self:isActivityRewardGet() or not isFirstLogin then
		if ViewMgr.instance:isOpen(viewName) then
			return
		end

		self:patComplete()

		return
	end

	local viewParam = {
		refreshData = false,
		actId = actId
	}

	ViewMgr.instance:openView(viewName, viewParam)
	SummonNewCustomPickViewModel.instance:setHaveFirstDayLogin(actId)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnSummonCustomGet, self._revertOpenState, self)
end

function SummonNewCustomPickPatFaceWork:_revertOpenState()
	self._needRevert = true
end

function SummonNewCustomPickPatFaceWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function SummonNewCustomPickPatFaceWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function SummonNewCustomPickPatFaceWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function SummonNewCustomPickPatFaceWork:isActivityRewardGet()
	local actId = self:_actId()

	return SummonNewCustomPickViewModel.instance:isGetReward(actId)
end

return SummonNewCustomPickPatFaceWork
