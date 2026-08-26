-- chunkname: @modules/logic/store/controller/StoreGoodsTaskController.lua

module("modules.logic.store.controller.StoreGoodsTaskController", package.seeall)

local StoreGoodsTaskController = class("StoreGoodsTaskController", BaseController)

function StoreGoodsTaskController:onInit()
	self._canAutoFinishTaskIdDict = {}
end

function StoreGoodsTaskController:onInitFinish()
	return
end

function StoreGoodsTaskController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._onSetTaskList, self)
	StoreController.instance:registerCallback(StoreEvent.StoreInfoChanged, self._onStoreInfoChanged, self)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onStoreInfoChanged, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	SummonController.instance:registerCallback(SummonEvent.onSummonProgressRewards, self.waitUpdateRedDot, self)
	SummonController.instance:registerCallback(SummonEvent.onReceiveSummonReply, self._onCancelWaitRewardTask, self)
end

function StoreGoodsTaskController:reInit()
	self._isRunUdateInfo = false
	self._waitRewardtaskIdList = nil
	self._lockSendTaskTimeDict = nil
	self._canAutoFinishTaskIdDict = {}
end

function StoreGoodsTaskController:_onStoreInfoChanged()
	if not self._isRunUdateInfo then
		self._isRunUdateInfo = true

		self:requestGoodsTaskList()
	end
end

function StoreGoodsTaskController:_onFinishTask(taskId)
	if StoreConfig.instance:getChargeConditionalConfig(taskId) then
		self:waitUpdateRedDot()
	end
end

function StoreGoodsTaskController:_onCancelWaitRewardTask()
	if self._waitRewardtaskIdList then
		self._waitRewardtaskIdList = nil

		TaskDispatcher.cancelTask(self._onRunwaitRewardTask, self)
	end
end

function StoreGoodsTaskController:_onSetTaskList(taskTypeList)
	if not taskTypeList then
		return
	end

	for i = 1, #taskTypeList do
		local type = taskTypeList[i]

		if type == TaskEnum.TaskType.StoreLinkPackage then
			local tStoreConfig = StoreConfig.instance
			local taskMoInfoList = TaskModel.instance:getAllUnlockTasks(type)

			for _, taskMo in pairs(taskMoInfoList) do
				local chargeConditionalConfig = tStoreConfig:getChargeConditionalConfig(taskMo.id)

				if chargeConditionalConfig and chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalGetType.SP02 then
					local goodsId = StoreConfig.instance:getChargeGoodsIdByConditionalId(taskMo.id)
					local isClaimable = taskMo and taskMo:isClaimable()

					StoreModel.instance:checkTaskRewardRedDotType_1(goodsId, chargeConditionalConfig, isClaimable)
				end
			end
		end
	end
end

function StoreGoodsTaskController:_onUpdateTaskList(msg)
	local taskInfoList = msg and msg.taskInfo

	if not taskInfoList then
		return
	end

	local tStoreConfig = StoreConfig.instance

	for i = 1, #taskInfoList do
		local taskInfo = taskInfoList[i]
		local chargeConditionalConfig = tStoreConfig:getChargeConditionalConfig(taskInfo.id)

		if chargeConditionalConfig then
			if chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalGetType.Auto and taskInfo.progress > taskInfo.finishCount then
				if self._canAutoFinishTaskIdDict[taskInfo.id] then
					self:_addWaitRewardTask(taskInfo.id)
				end
			elseif chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalGetType.SP02 then
				local goodsId = StoreConfig.instance:getChargeGoodsIdByConditionalId(taskInfo.id)
				local taskMo = TaskModel.instance:getTaskById(taskInfo.id)
				local isClaimable = taskMo and taskMo:isClaimable()

				StoreModel.instance:checkTaskRewardRedDotType_1(goodsId, chargeConditionalConfig, isClaimable)
			end

			self:waitUpdateRedDot()
		end
	end
end

function StoreGoodsTaskController:_addWaitRewardTask(taskid)
	if self._waitRewardtaskIdList == nil then
		self._waitRewardtaskIdList = {}

		TaskDispatcher.runDelay(self._onRunwaitRewardTask, self, 0.1)
	end

	if not tabletool.indexOf(self._waitRewardtaskIdList) then
		table.insert(self._waitRewardtaskIdList, taskid)
	end
end

function StoreGoodsTaskController:_onRunwaitRewardTask()
	local taskIdList = self._waitRewardtaskIdList

	self._waitRewardtaskIdList = nil

	if taskIdList then
		for _, taskid in ipairs(taskIdList) do
			self:sendFinishTaskRequest(taskid)
		end
	end
end

function StoreGoodsTaskController:setAutoFininishTaskId(taskid)
	self._canAutoFinishTaskIdDict[taskid] = true
end

function StoreGoodsTaskController:sendFinishTaskRequest(taskid)
	self._lockSendTaskTimeDict = self._lockSendTaskTimeDict or {}

	if not self._lockSendTaskTimeDict[taskid] or self._lockSendTaskTimeDict[taskid] < Time.time then
		self._lockSendTaskTimeDict[taskid] = Time.time + 3

		TaskRpc.instance:sendFinishTaskRequest(taskid)
	end
end

function StoreGoodsTaskController:_getKeyPoolId(poolId)
	poolId = poolId or 0

	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreGoodsTaskPoolNewRed .. poolId)
end

function StoreGoodsTaskController:clearNewRedDotByPoolId(poolId)
	PlayerPrefsHelper.setNumber(self:_getKeyPoolId(poolId), 1)
end

function StoreGoodsTaskController:isHasNewRedDotByPoolId(poolId)
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)

	if goodsCfgList and PlayerPrefsHelper.getNumber(self:_getKeyPoolId(poolId), 0) == 0 and not SummonModel.instance:getSummonFullExSkillHero(poolId) then
		for _, goodsCfg in ipairs(goodsCfgList) do
			local goodsId = goodsCfg.id
			local storePackageGoodsMO = StoreModel.instance:getGoodsMO(goodsId)

			if storePackageGoodsMO and storePackageGoodsMO.buyCount == 0 and StoreCharageConditionalHelper.isCharageCondition(goodsId) then
				return true
			end
		end
	end

	return false
end

function StoreGoodsTaskController:waitUpdateRedDot()
	if not self._isHasWaitUpdateRedDoTask then
		self._isHasWaitUpdateRedDoTask = true

		TaskDispatcher.runDelay(self._onWaitUpdateRedDot, self, 0.2)
	end
end

function StoreGoodsTaskController:_onWaitUpdateRedDot()
	self._isHasWaitUpdateRedDoTask = false

	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
end

function StoreGoodsTaskController:isHasCanFinishTaskByPoolId(poolId)
	return SummonMainModel.instance:isHasCanFinishTaskByPoolId(poolId)
end

function StoreGoodsTaskController:autoFinishTaskByPoolId(poolId)
	local flag = false
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)

	if goodsCfgList then
		for _, goodsCfg in ipairs(goodsCfgList) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsCfg.id) then
				flag = true

				self:sendFinishTaskRequest(goodsCfg.taskid)
			end
		end
	end

	if flag then
		self:requestGoodsTaskList()
	end

	return flag
end

function StoreGoodsTaskController:requestGoodsTaskList(callback, callbackObj)
	local typeIds = {
		TaskEnum.TaskType.StoreLinkPackage
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, callback, callbackObj)
end

StoreGoodsTaskController.instance = StoreGoodsTaskController.New()

return StoreGoodsTaskController
