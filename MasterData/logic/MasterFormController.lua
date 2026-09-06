-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/controller/MasterFormController.lua

module("logic.extensions.masterform.controller.MasterFormController", package.seeall)

local MasterFormController = class("MasterFormController", BaseController)

function MasterFormController:ctor()
	return
end

function MasterFormController:onInit()
	self:onReset()
end

function MasterFormController:onReset()
	self:onResetMasterFormMgr()
end

function MasterFormController:sendPM_MasterFormViewFormReq(period, fmtPlanId)
	MasterFormAgent.instance:sendPM_MasterFormViewFormReq(period, fmtPlanId)
end

function MasterFormController:handlePM_MasterFormViewFormRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormViewFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormViewFormRes)
end

function MasterFormController:sendPM_MasterFormGetMyFormReq(period)
	MasterFormAgent.instance:sendPM_MasterFormGetMyFormReq(period)
end

function MasterFormController:handlePM_MasterFormGetMyFormRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormGetMyFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormGetMyFormRes)
end

function MasterFormController:sendPM_MasterFormGetCollectionFormReq(period)
	MasterFormAgent.instance:sendPM_MasterFormGetCollectionFormReq(period)
end

function MasterFormController:handlePM_MasterFormGetCollectionFormRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormGetCollectionFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormGetCollectionFormRes)
end

function MasterFormController:sendPM_MasterFormgetCommentsReq(period, formId)
	MasterFormAgent.instance:sendPM_MasterFormgetCommentsReq(period, formId)
end

function MasterFormController:handlePM_MasterFormgetCommentsRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormgetCommentsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormgetCommentsRes, msg)
end

function MasterFormController:sendPM_MasterFormKudoFormReq(period, formId)
	MasterFormAgent.instance:sendPM_MasterFormKudoFormReq(period, formId)
end

function MasterFormController:handlePM_MasterFormKudoFormRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormKudoFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormKudoFormRes)
end

function MasterFormController:sendPM_MasterFormKudoCommentReq(period, formId, commentId)
	MasterFormAgent.instance:sendPM_MasterFormKudoCommentReq(period, formId, commentId)
end

function MasterFormController:handlePM_MasterFormKudoCommentRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormKudoCommentRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormKudoCommentRes)
end

function MasterFormController:sendPM_MasterFormSubmitFormReq(period, formMsg)
	MasterFormAgent.instance:sendPM_MasterFormSubmitFormReq(period, formMsg)
end

function MasterFormController:handlePM_MasterFormSubmitFormRes(status, msg)
	if status == 0 then
		local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

		mgr:handlePM_MasterFormSubmitFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.MasterFormSubmitFormRes, status, msg)
end

function MasterFormController:sendPM_MasterFormRevokeReq(period, formId)
	MasterFormAgent.instance:sendPM_MasterFormRevokeReq(period, formId)
end

function MasterFormController:handlePM_MasterFormRevokeRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormRevokeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormRevokeRes)
end

function MasterFormController:sendPM_MasterFormCollectReq(period, formId, type)
	MasterFormAgent.instance:sendPM_MasterFormCollectReq(period, formId, type)
end

function MasterFormController:handlePM_MasterFormCollectRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormCollectRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormCollectRes, msg)
end

function MasterFormController:sendPM_MasterFormCancelCollectReq(period, formId, type)
	MasterFormAgent.instance:sendPM_MasterFormCancelCollectReq(period, formId, type)
end

function MasterFormController:handlePM_MasterFormCancelCollectRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormCancelCollectRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormCancelCollectRes, msg)
end

function MasterFormController:sendPM_MasterFormGetBaseInfoReq(period)
	MasterFormAgent.instance:sendPM_MasterFormGetBaseInfoReq(period)
end

function MasterFormController:handlePM_MasterFormGetBaseInfoRes(msg)
	local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

	mgr:handlePM_MasterFormGetBaseInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormGetBaseInfoRes)
end

function MasterFormController:sendPM_MasterFormCommentReq(period, formId, content)
	MasterFormAgent.instance:sendPM_MasterFormCommentReq(period, formId, content)
end

function MasterFormController:handlePM_MasterFormCommentRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.MasterFormCommentRes, status, msg)
end

function MasterFormController:handlePM_MasterFormNotifyCommnetRes(status, msg)
	if status == 0 then
		local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

		mgr:handlePM_MasterFormNotifyCommnetRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.MasterFormNotifyCommnetRes, status, msg)
end

function MasterFormController:handlePM_MasterFormNotifySubmitFormRes(status, msg)
	if status == 0 then
		local mgr = MasterFormController.instance:getMasterFormMgr(msg.period)

		mgr:handlePM_MasterFormNotifySubmitFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.MasterFormNotifySubmitFormRes, status, msg)
end

function MasterFormController:getPeriodId()
	local periodId = 0
	local dataList = MasterFormConfig.instance:getMfBaseDataList()

	for _, data in ipairs(dataList) do
		if self:isInTime(data.periodId) then
			periodId = data.periodId

			break
		end
	end

	return periodId
end

function MasterFormController:isInTime(periodId)
	return self:getTimePeriod(periodId) == GameUtil.inTimePeriod
end

function MasterFormController:getTimePeriod(periodId)
	local data = MasterFormConfig.instance:getMfBaseData(periodId)

	return GameUtil.getTimePeriod(data.openTime, data.endTime)
end

function MasterFormController:getMasterFormMgr(periodId)
	periodId = checknumber(periodId)

	if self._masterFormMgrs == nil then
		self._masterFormMgrs = {}
	end

	if self._masterFormMgrs[periodId] == nil then
		self._masterFormMgrs[periodId] = MasterFormMgr.New(periodId)
	end

	return self._masterFormMgrs[periodId]
end

function MasterFormController:onResetMasterFormMgr()
	if self._masterFormMgrs then
		for k, v in pairs(self._masterFormMgrs) do
			v:onReset()

			self._masterFormMgrs[k] = nil
		end

		self._masterFormMgrs = nil
	end
end

function MasterFormController:openMasterFormViewByFmtId(periodId, viewType, fmtPlanId)
	periodId = checknumber(periodId)
	viewType = checknumber(viewType)
	fmtPlanId = checknumber(fmtPlanId)

	local curPeriodId = self:getPeriodId()

	if curPeriodId ~= periodId then
		periodId = curPeriodId
		viewType = MasterFormSystemView.ViewType.System
		fmtPlanId = 1
	end

	GotoMgr.gotoByString(string.format("func#26#%s#%s#%s", periodId, viewType, fmtPlanId))
end

MasterFormController.instance = MasterFormController.New()

return MasterFormController
