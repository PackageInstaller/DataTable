-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/model/PowerLandModel.lua

module("logic.extensions.powerland.model.PowerLandModel", package.seeall)

local PowerLandModel = class("PowerLandModel", BaseModel)

PowerLandModel.viewLayer = {}
PowerLandModel.viewLayer.scenceBg = 201
PowerLandModel.viewLayer.scenceAnim = 202
PowerLandModel.viewLayer.scenceUi = 203
PowerLandModel.viewLayer.stagePetBg = 204
PowerLandModel.viewLayer.stagePetAnim = 205
PowerLandModel.viewLayer.stagePetUi = 206

function PowerLandModel:ctor()
	return
end

function PowerLandModel:onInit()
	self:onReset()
end

function PowerLandModel:onReset()
	self._activityId = 0
	self._leaveGameTime = 0
	self._stageInfo = {
		score = 0,
		curStageId = 0,
		isStart = false,
		creepsMasterId = 0,
		leavePetRefreshCount = 0,
		canFormPetIds = {},
		selectPetIds = {},
		shopPets = {}
	}
	self._oldStageId = 1
	self._isWin = nil
	self._changeSetId = nil

	self:setInNewStage(false)

	self._simpleForm = {}
	self._petMoMap = {}
	self._targetMoList = {}
	self._targetMoPool = {}
end

function PowerLandModel:onHandlePowerLandGetInfoRes(msg)
	self._activityId = msg.activityId
	self._leaveGameTime = msg.leaveGameTime
	self._simpleForm = msg.simpleForm

	self:_handlePowerLandStageInfo(msg.stageInfo)
	self:_updateFmtTargetInfo(self:getCanFormPetIds())
end

function PowerLandModel:onHandlePowerLandRefreshRes(msg)
	self._stageInfo.canFormPetIds = msg.initPetIds
	self._stageInfo.leavePetRefreshCount = msg.leavePetRefreshCount

	self:_updateFmtTargetInfo(self:getCanFormPetIds())
end

function PowerLandModel:onHandlePowerLandStartChallengeRes(msg)
	self._stageInfo.isStart = true
end

function PowerLandModel:onHandlePowerLandChallengeRes(msg)
	return
end

function PowerLandModel:onHandlePowerLandRefreshShopRes(msg)
	self._stageInfo.score = msg.score
	self._stageInfo.shopPets = msg.shopPets

	self:_updateScoreToMatMo()
end

function PowerLandModel:onHandlePowerLandStageOverRes(msg)
	self._activityId = msg.activityId
	self._oldStageId = msg.oldStageId
	self._isWin = msg.isWin
	self._changeSetId = msg.changeSetId

	self:_handlePowerLandStageInfo(msg.stageInfo)

	local curStageId = msg.stageInfo.curStageId

	self:setInNewStage(self._oldStageId ~= curStageId)
	self:_updateFmtTargetInfo(self:getCanFormPetIds())
end

function PowerLandModel:onHandlePowerLandSetFormRes(msg)
	return
end

function PowerLandModel:_handlePowerLandStageInfo(info)
	self._stageInfo = {
		curStageId = info.curStageId,
		canFormPetIds = info.canFormPetIds,
		score = info.score,
		selectPetIds = info.selectPetIds,
		isStart = info.isStart,
		leavePetRefreshCount = info.leavePetRefreshCount,
		shopPets = info.shopPets,
		creepsMasterId = info.creepsMasterId
	}

	self:_updateScoreToMatMo()
end

function PowerLandModel:_updateScoreToMatMo()
	local itemStr = PowerLandConfig.instance:getPlShowItem()
	local matType, matId = MaterialMgr.getMatParams(itemStr)
	local count = self:getScore()
	local isAdd = false

	if matType ~= MatType.Item_Fake then
		printError(string.format("警告：试图修改\"非前端类型的道具数据\"，请检查是否正确( %s:%s:0 )", matType, matId))

		return
	end

	MaterialModel.instance:UpdateMaterial(matType, matId, count, isAdd)
end

function PowerLandModel:getCurActivityId()
	return self._activityId
end

function PowerLandModel:getLeaveGameTimes()
	return self._leaveGameTime
end

function PowerLandModel:getCurStageId()
	return self._stageInfo.curStageId
end

function PowerLandModel:getLeavePetRefreshCount()
	return self._stageInfo.leavePetRefreshCount
end

function PowerLandModel:getCanFormPetIds()
	return self._stageInfo.canFormPetIds
end

function PowerLandModel:getScore()
	return self._stageInfo.score
end

function PowerLandModel:getCreepsMasterId()
	return self._stageInfo.creepsMasterId
end

function PowerLandModel:getStageSelectPetIds()
	return self._stageInfo.selectPetIds
end

function PowerLandModel:getStageShopPetIds()
	local petIdList = {}

	for _, info in ipairs(self._stageInfo.shopPets) do
		table.insert(petIdList, info.petId)
	end

	return petIdList
end

function PowerLandModel:getOldStageId()
	return self._oldStageId
end

function PowerLandModel:getChangeSetId()
	return self._changeSetId
end

function PowerLandModel:clearChangeSetId()
	self._changeSetId = nil
end

function PowerLandModel:isStageShopPetHasBuy(petId)
	local isHasBuy = false

	for _, info in ipairs(self._stageInfo.shopPets) do
		if petId == info.petId then
			isHasBuy = info.hasBuy == true

			break
		end
	end

	return isHasBuy
end

function PowerLandModel:isStartChallenge()
	return self._stageInfo.isStart == true
end

function PowerLandModel:isInNewStage()
	return self._isInNewStage
end

function PowerLandModel:setInNewStage(isInNew)
	if isInNew == nil then
		printError("bool值不能设nil")
	end

	self._isInNewStage = isInNew
end

function PowerLandModel:isChallengeWin()
	return self._isWin
end

function PowerLandModel:isInFmt()
	return self._isInFmt == true
end

function PowerLandModel:setIsInFmt(isInFmt)
	self._isInFmt = isInFmt == true
end

function PowerLandModel:addViewInfo(callBack, ...)
	self._viewInfo = self._viewInfo or {}

	local info = {}

	info.callBack = callBack
	info.params = {
		...
	}

	table.insert(self._viewInfo, info)
end

function PowerLandModel:getViewInfos()
	return self._viewInfo or {}
end

function PowerLandModel:clearViewInfos()
	self._viewInfo = {}
end

function PowerLandModel:_addMatDataToList(matType, matId, matNum)
	local data = {
		matType = matType,
		matId = matId,
		matNum = matNum
	}

	self._matDataList = self._matDataList or {}

	table.insert(self._matDataList, data)
end

function PowerLandModel:_getMatDataList()
	return self._matDataList or {}
end

function PowerLandModel:_clearMatDataList()
	self._matDataList = {}
end

function PowerLandModel:_isMatDataListHaveContent()
	local matDataList = self:_getMatDataList()

	return #matDataList > 0
end

function PowerLandModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = PowerLandCustomFmtMo.New()
	end

	return self._customFmtMo
end

function PowerLandModel:getPetMo(petId)
	if petId <= 0 then
		printError("错误: petId(creepsId) = %d ", petId)

		return nil
	end

	local petMo
	local activityId = self:getCurActivityId()
	local petPlanId = PowerLandConfig.instance:getPlActData(activityId).petPlanId

	self._petMoMap[petPlanId] = self._petMoMap[petPlanId] or {}
	petMo = self._petMoMap[petPlanId][petId]

	if self._petMoMap[petPlanId][petId] == nil then
		local petCo = PowerLandConfig.instance:getPlPetData(petPlanId, petId)

		self._fPPetMo = self._fPPetMo or FightingPowerPetMo.New()

		self._fPPetMo:fromChallengeCreepCo(petCo)

		petMo = self._fPPetMo:toBaseBagPetMo()
		self._petMoMap[petPlanId][petId] = petMo
	end

	return petMo
end

function PowerLandModel:getSaveSimpleForm()
	return self._simpleForm
end

function PowerLandModel:setSaveSimpleForm(form)
	self._simpleForm = form
end

function PowerLandModel:getFmtTargetInfo()
	if self._fmtTargetInfo == nil then
		self._fmtTargetInfo = TargetInfo.New()
	end

	return self._fmtTargetInfo
end

function PowerLandModel:_updateFmtTargetInfo(petIdList)
	local curActId = self:getCurActivityId()
	local targetIdList = {}

	for _, petId in ipairs(petIdList) do
		local petData = PowerLandConfig.instance:getPlPetDataByActId(curActId, petId)

		if not petData.targetIds then
			for _, tId in ipairs(petData.targetIds) do
				table.insert(targetIdList, tId)
			end
		end
	end

	local targetInfo = self:getFmtTargetInfo()

	targetInfo:updateTargetMoData(targetIdList)
end

function PowerLandModel:getBattleTargetInfo()
	if self._battleTargetInfo == nil then
		self._battleTargetInfo = TargetInfo.New()
	end

	return self._battleTargetInfo
end

function PowerLandModel:_updateBattleTargetInfo(petIdList)
	local curActId = self:getCurActivityId()
	local targetIdList = {}

	for _, petId in ipairs(petIdList) do
		local petData = PowerLandConfig.instance:getPlPetDataByActId(curActId, petId)

		if not petData.targetIds then
			for _, tId in ipairs(petData.targetIds) do
				table.insert(targetIdList, tId)
			end
		end
	end

	local targetInfo = self:getBattleTargetInfo()

	targetInfo:updateTargetMoData(targetIdList)
end

PowerLandModel.instance = PowerLandModel.New()

return PowerLandModel
