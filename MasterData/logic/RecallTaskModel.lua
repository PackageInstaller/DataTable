-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/model/RecallTaskModel.lua

module("logic.extensions.recalltask.model.RecallTaskModel", package.seeall)

local RecallTaskModel = class("RecallTaskModel", BaseModel)

function RecallTaskModel:ctor()
	self.openActivityType = 74
	self.openActivityId = 74001
	self._returnInfo = nil
	self._recallInfo = nil
	self._cacheTaskInfo = nil
end

function RecallTaskModel:onInit()
	RecallTaskModel.super.onInit(self)
	self:onReset()
end

function RecallTaskModel:onReset()
	RecallTaskModel.super.onReset(self)
	RecallTaskConfig.instance:getOpenActivityId()

	self._returnInfo = nil
	self._recallInfo = nil
	self._cacheTaskInfo = nil
end

function RecallTaskModel:isGetActivityOpen(isRec)
	local isRecallPlayer = self:isGetRecallPlayer()

	if isRec then
		return isRecallPlayer
	end

	if isRecallPlayer then
		return false
	end

	return not PlayerReturnModel.instance:isOpenActivityEnd()
end

function RecallTaskModel:isGetRecallPlayer()
	local info = RoleModel.instance:getRegressInfo()

	if info == nil or checknumber(info.activityId) <= 0 then
		return true
	end

	local actCfg = PlayerReturnConfig.instance:getReturnActivityCfg(info.activityId)

	if actCfg == nil then
		return
	end

	local endTime = checknumber(info.touchTimeMillis) / 1000 + checknumber(actCfg.totalDays) * 24 * 60 * 60

	return endTime <= ServerTime.nowServerLook()
end

function RecallTaskModel:getReturnPlayerEndTime()
	local info = RoleModel.instance:getRegressInfo()
	local nowtime = ServerTime.nowServerLook()

	if info == nil or checknumber(info.activityId) <= 0 then
		return nowtime
	end

	local actCfg = PlayerReturnConfig.instance:getReturnActivityCfg(info.activityId)

	if actCfg == nil then
		return nowtime
	end

	return checknumber(info.touchTimeMillis) / 1000 + checknumber(actCfg.totalDays) * 24 * 60 * 60
end

function RecallTaskModel:getReturnInfo()
	return self._returnInfo
end

function RecallTaskModel:getRecallInfo()
	return self._recallInfo
end

function RecallTaskModel:getRecallTaskShare(taskId)
	local cfg = RecallTaskConfig.instance:getRecallActivityCfg(self.openActivityId)

	if cfg == nil then
		return
	end

	taskId = checknumber(taskId)

	local taskCfg = RecallTaskConfig.instance:getRecallTaskCfgs(cfg.taskPlan, taskId)

	if taskCfg == nil or string.nilorempty(taskCfg.prize) then
		return
	end

	local arr = string.split(taskCfg.prize, ":")
	local matCfg = MaterialMgr.getMatCfg(checknumber(arr[1]), checknumber(arr[2]))

	if matCfg == nil then
		return
	end

	local matStr = arr[3] .. matCfg.name

	return taskCfg.desc, matStr, taskCfg.title
end

function RecallTaskModel:isCanReceiveRecallTask(taskId, userId, isTips)
	local cfg = RecallTaskConfig.instance:getRecallActivityCfg(self.openActivityId)

	if cfg == nil then
		if isTips then
			FloatWordMgr.instance:show(lang("text_recall_desc_19"))
		end

		return false
	end

	if cfg.funcId > 0 and not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		if isTips then
			FloatWordMgr.instance:show(lang("text_recall_desc_20"))
		end

		return false
	end

	if not self:isGetRecallPlayer() then
		if isTips then
			FloatWordMgr.instance:show(lang("text_recall_desc_18"))
		end

		return false
	end

	taskId = checknumber(taskId)

	local taskCfg = RecallTaskConfig.instance:getRecallTaskCfgs(cfg.taskPlan, taskId)

	if taskCfg == nil or string.nilorempty(taskCfg.prize) then
		if isTips then
			FloatWordMgr.instance:show(lang("text_recall_desc_21"))
		end

		return false
	end

	if self._recallInfo and self._recallInfo.taskInfoList and #self._recallInfo.taskInfoList > 0 then
		local count = #self._recallInfo.taskInfoList

		for i = 1, count do
			if self._recallInfo.taskInfoList[i].taskId == taskId and self._recallInfo.taskInfoList[i].partner and self._recallInfo.taskInfoList[i].partner.userId == userId then
				if isTips then
					FloatWordMgr.instance:show(lang("text_recall_desc_22"))
				end

				return false
			end
		end

		if count >= cfg.dailyTaskCount then
			if isTips then
				FloatWordMgr.instance:show(lang("text_recall_desc_23"))
			end

			return false
		end
	end

	return true
end

function RecallTaskModel:getReturnViewRedpoint()
	return RedPointModel.instance:isActiveByServer(RedPointModel.ID_RETURNTASK2)
end

function RecallTaskModel:getRecallViewRedpoint()
	return self:getShopRedpoint(true)
end

function RecallTaskModel:getShopRedpoint(isRec)
	return self:isCanBuyCommodity(isRec)
end

function RecallTaskModel:isCanBuyCommodity(isRec)
	local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self.openActivityId)

	if checknumber(count) <= 0 then
		return false
	end

	local list = isRec and RecallTaskConfig.instance:getRecallShopsCfgs(2) or RecallTaskConfig.instance:getRecallShopsCfgs(1)

	if list == nil or #list == 0 then
		return false
	end

	local mats

	for i = 1, #list do
		mats = string.split(list[i].sellPrice, ":")

		if mats == nil or count >= checknumber(mats[3]) then
			if list[i].sellPeriodLimit ~= "none" then
				return true
			end

			if ActivityshopModel.instance:getActiveShopBuyTimes(list[i].activityType, list[i].activityId, list[i].shopItemId) >= list[i].sellLimitCount then
				return true
			end
		end
	end

	return false
end

function RecallTaskModel:csRegressUserInfo(msg)
	self._returnInfo = nil

	if msg == nil or msg.actId ~= self.openActivityId then
		printError("sr--- 回流任务   RecallTaskModel:csRegressUserInfo()    数据有误 = ", self.openActivityId)

		return
	end

	self._returnInfo = {}
	self._returnInfo.taskInfoList = msg.taskInfos
	self._returnInfo.useCodeTime = msg.useCodeCd

	GlobalDispatcher:dispatch(GlobalNotify.UpdataRecallReturnInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 5)
end

function RecallTaskModel:csInviteUserInfo(msg)
	self._recallInfo = nil

	if msg == nil or msg.actId ~= self.openActivityId then
		printError("sr--- 回流任务   RecallTaskModel:csInviteUserInfo()    数据有误 = ", self.openActivityId)

		return
	end

	self._recallInfo = {}
	self._recallInfo.taskInfoList = msg.taskInfos
	self._recallInfo.codes = msg.code
	self._recallInfo.recallCount = msg.inviteCount
	self._recallInfo.prizeIds = msg.gainedPrizeIds

	GlobalDispatcher:dispatch(GlobalNotify.UpdataRecallRecallInfo)
end

function RecallTaskModel:csGainTaskPrize(msg)
	if msg == nil or checknumber(msg.taskId) <= 0 then
		return
	end

	local isRecall = self:isGetRecallPlayer()

	if isRecall then
		if self._recallInfo == nil or self._recallInfo.taskInfoList == nil or #self._recallInfo.taskInfoList == 0 then
			return
		end

		for i = 1, #self._recallInfo.taskInfoList do
			if self._recallInfo.taskInfoList[i] and self._recallInfo.taskInfoList[i].partner and self._recallInfo.taskInfoList[i].taskId == msg.taskId and self._recallInfo.taskInfoList[i].partner.userId == msg.partnerUserId then
				self._recallInfo.taskInfoList[i].prizeGained = true
			end
		end
	else
		if self._returnInfo == nil or self._returnInfo.taskInfoList == nil or #self._returnInfo.taskInfoList == 0 then
			return
		end

		for i = 1, #self._returnInfo.taskInfoList do
			if self._returnInfo.taskInfoList[i] and self._returnInfo.taskInfoList[i].partner and self._returnInfo.taskInfoList[i].taskId == msg.taskId and self._returnInfo.taskInfoList[i].partner.userId == msg.partnerUserId then
				self._returnInfo.taskInfoList[i].prizeGained = true
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataRecallReceiveTask)

	if not self:isGetRecallPlayer() then
		GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 5)
	end
end

function RecallTaskModel:csGainInvitePrize(msg)
	if msg == nil or checknumber(msg.prizeId) <= 0 then
		return
	end

	if self._recallInfo == nil then
		self._recallInfo = {}
	end

	if self._recallInfo.prizeIds == nil then
		self._recallInfo.prizeIds = {}
	end

	table.insert(self._recallInfo.prizeIds, msg.prizeId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataRecallReceivePrize)
end

function RecallTaskModel:csWriteUseCode(msg)
	if msg == nil or msg.useCodeCd == nil then
		return
	end

	if self._returnInfo == nil then
		self._returnInfo = {}
	end

	self._returnInfo.useCodeTime = msg.useCodeCd

	GlobalDispatcher:dispatch(GlobalNotify.UpdataRecallWriteCode)
end

function RecallTaskModel:csTaskInviteInfo(msg)
	self._cacheTaskInfo = nil

	if msg == nil or checknumber(msg.taskId) <= 0 then
		return
	end

	self._cacheTaskInfo = msg

	UIStateManager.instance:push(ViewName.RecallInvite, msg, false)
end

function RecallTaskModel:csAcceptTaskInvite(msg)
	if self._cacheTaskInfo == nil then
		return
	end

	self._recallInfo = self._recallInfo or {}
	self._recallInfo.taskInfoList = self._recallInfo.taskInfoList or {}

	local info = {}

	info.taskId = self._cacheTaskInfo.taskId
	info.partner = self._cacheTaskInfo.senderHeadInfo
	info.selfProgress = 0
	info.partnerDone = false
	info.prizeGained = false
	info.partnerCurZdl = 0

	table.insert(self._recallInfo.taskInfoList, info)

	self._cacheTaskInfo = nil

	FloatWordMgr.instance:show(lang("text_recall_desc_24"))
end

RecallTaskModel.instance = RecallTaskModel.New()

return RecallTaskModel
