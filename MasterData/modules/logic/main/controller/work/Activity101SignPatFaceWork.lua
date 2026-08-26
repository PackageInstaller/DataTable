-- chunkname: @modules/logic/main/controller/work/Activity101SignPatFaceWork.lua

module("modules.logic.main.controller.work.Activity101SignPatFaceWork", package.seeall)

local Activity101SignPatFaceWork = class("Activity101SignPatFaceWork", PatFaceWorkBase)

function Activity101SignPatFaceWork:_viewName()
	return PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
end

function Activity101SignPatFaceWork:_actId()
	return PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)
end

function Activity101SignPatFaceWork:checkCanPat()
	local actId = self:_actId()

	return ActivityType101Model.instance:isOpen(actId)
end

function Activity101SignPatFaceWork:startPat()
	self:_startBlock()

	local actId = self:_actId()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	Activity101Rpc.instance:sendGet101InfosRequest(actId)
end

function Activity101SignPatFaceWork:clearWork()
	self:_endBlock()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function Activity101SignPatFaceWork:_onOpenViewFinish(openingViewName)
	local viewName = self:_viewName()

	if openingViewName ~= viewName then
		return
	end

	self:_endBlock()
end

function Activity101SignPatFaceWork:_onCloseViewFinish(closingViewName)
	local viewName = self:_viewName()

	if closingViewName ~= viewName then
		return
	end

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	self:patComplete()
end

function Activity101SignPatFaceWork:_refreshNorSignActivity()
	local actId = self:_actId()
	local viewName = self:_viewName()

	if not self:isType101RewardCouldGetAnyOne() then
		if ViewMgr.instance:isOpen(viewName) then
			return
		end

		self:patComplete()

		return
	end

	local viewParam = {
		actId = actId
	}

	if string.nilorempty(viewName) then
		logError(string.format("Error: excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s\n没配 'patFaceViewName' !!", self._patFaceId, actId))
		self:patComplete()

		return
	end

	if not _G.ViewName[viewName] then
		logError(string.format("Error: excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s, patFaceViewName: %s\nerror: modules_views.%s 不存在", self._patFaceId, actId, viewName, viewName))
		self:patComplete()

		return
	end

	ViewMgr.instance:openView(viewName, viewParam)
end

function Activity101SignPatFaceWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function Activity101SignPatFaceWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function Activity101SignPatFaceWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function Activity101SignPatFaceWork:isType101RewardCouldGetAnyOne()
	local actId = self:_actId()

	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

return Activity101SignPatFaceWork
