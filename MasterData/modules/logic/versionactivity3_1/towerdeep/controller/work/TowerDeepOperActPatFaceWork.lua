-- chunkname: @modules/logic/versionactivity3_1/towerdeep/controller/work/TowerDeepOperActPatFaceWork.lua

module("modules.logic.versionactivity3_1.towerdeep.controller.work.TowerDeepOperActPatFaceWork", package.seeall)

local TowerDeepOperActPatFaceWork = class("TowerDeepOperActPatFaceWork", PatFaceWorkBase)

function TowerDeepOperActPatFaceWork:_viewName()
	return PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
end

function TowerDeepOperActPatFaceWork:_actId()
	return PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)
end

function TowerDeepOperActPatFaceWork:checkCanPat()
	local actId = self:_actId()

	if not ActivityModel.instance:isActOnLine(actId) then
		return false
	end

	local activityInfoMo = ActivityModel.instance:getActMO(actId)

	if not activityInfoMo or not activityInfoMo:isOpen() or activityInfoMo:isExpired() then
		return false
	end

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.TowerDeepActPat)
	local hasPat = PlayerPrefsHelper.getNumber(key, 0)

	if hasPat ~= 0 then
		return false
	end

	PlayerPrefsHelper.setNumber(key, 1)

	return true
end

function TowerDeepOperActPatFaceWork:startPat()
	self:_startBlock()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerDeep
	}, self._onGetTaskInfo, self)
end

function TowerDeepOperActPatFaceWork:_onGetTaskInfo(cmd, resultCode, msg)
	local actId = self:_actId()

	Activity209Rpc.instance:sendGetAct209InfoRequest(actId, self._onGetInfoFinish, self)
end

function TowerDeepOperActPatFaceWork:_onGetInfoFinish(cmd, resultCode, msg)
	self:_endBlock()

	if resultCode == 0 then
		self:_openPanelView()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

		return
	end

	self:patComplete()
end

function TowerDeepOperActPatFaceWork:clearWork()
	self:_endBlock()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.OnGetReward, self)
end

function TowerDeepOperActPatFaceWork:_onOpenViewFinish(openingViewName)
	local viewName = self:_viewName()

	if openingViewName ~= viewName then
		return
	end

	self:_endBlock()
end

function TowerDeepOperActPatFaceWork:_onCloseViewFinish(closingViewName)
	local viewName = self:_viewName()

	if closingViewName ~= viewName then
		return
	end

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	self:patComplete()
end

function TowerDeepOperActPatFaceWork:_openPanelView()
	local actId = self:_actId()
	local viewName = self:_viewName()
	local viewParam = {
		actId = actId
	}

	ViewMgr.instance:openView(viewName, viewParam)
end

function TowerDeepOperActPatFaceWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function TowerDeepOperActPatFaceWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function TowerDeepOperActPatFaceWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

return TowerDeepOperActPatFaceWork
