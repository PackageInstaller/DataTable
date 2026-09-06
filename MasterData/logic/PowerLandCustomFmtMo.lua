-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/model/PowerLandCustomFmtMo.lua

module("logic.extensions.powerland.model.PowerLandCustomFmtMo", package.seeall)

local PowerLandCustomFmtMo = class("PowerLandCustomFmtMo", ICustomFmtMo)

function PowerLandCustomFmtMo:onReset()
	PowerLandCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function PowerLandCustomFmtMo:initFightHandler()
	local function handler()
		self._isNeedSendSaveReq = false

		local activityId = PowerLandModel.instance:getCurActivityId()
		local stageId = PowerLandModel.instance:getCurStageId()
		local creepsMasterId = PowerLandModel.instance:getCreepsMasterId()
		local simpleForm = PowerLandModel.instance:getCustomFmtMo():getCurSimpleForm()

		PowerLandController.instance:startSotrySummaryStageBattle(activityId, stageId, creepsMasterId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function PowerLandCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	local maxNum = self.needUpPetCount
	local petPoolNum = 0

	for _, petMo in pairs(petPool) do
		petPoolNum = petPoolNum + (petMo and 1 or 0)
	end

	local needAddPetNum = maxNum - petPoolNum

	if needAddPetNum == 0 then
		return posList, petPool
	elseif needAddPetNum < 0 then
		printError("错误,一键布阵意图上阵精灵数量超过限制,请务必检查( maxNum=%d, petPoolNum=%d )", maxNum, petPoolNum)

		return posList, petPool
	end

	local exPetMoList = {}
	local exPetNum = 0

	for _, petMo in ipairs(self:getAllShowPetList()) do
		local isFitCount = exPetNum < needAddPetNum

		if not isFitCount then
			break
		end

		local isRepeatRaceId = false
		local raceId = petMo:getDefineId()

		for _, v in pairs(petPool) do
			if v and v:getDefineId() == raceId then
				isRepeatRaceId = true

				break
			end
		end

		local isSummonedPet = petMo:isSummonedPet()

		if not isRepeatRaceId and not isSummonedPet then
			table.insert(exPetMoList, petMo)

			exPetNum = exPetNum + 1
		end
	end

	for idx, posId in ipairs(posList) do
		if petPool[idx] == nil then
			local exPetMo = exPetMoList[#exPetMoList]

			if exPetMo then
				petPool[idx] = exPetMo
				exPetMoList[#exPetMoList] = nil
			else
				break
			end
		end
	end

	return posList, petPool
end

function PowerLandCustomFmtMo:onFmoSetDown()
	local fmtMo = self:getCurFormation()
	local posList = fmtMo:GetPositions()
	local petIdList = {}

	for posId, petId in ipairs(posList) do
		if petId > 0 then
			table.insert(petIdList, petId)
		end
	end

	PowerLandModel.instance:_updateBattleTargetInfo(petIdList)
end

function PowerLandCustomFmtMo:initPetList()
	local petIds = PowerLandModel.instance:getCanFormPetIds()

	for _, petId in ipairs(petIds) do
		self:addPetToList(PowerLandModel.instance:getPetMo(petId))
	end
end

function PowerLandCustomFmtMo:updateCellTop(cell, petMo)
	local petId = petMo.petId
	local activityId = PowerLandModel.instance:getCurActivityId()
	local petData = PowerLandConfig.instance:getPlPetDataByActId(activityId, petId)
	local luaCls = TargetColCell
	local url = TargetColCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:onUpdateTargetCol(petData.targetIds)
		proxy.binder:setTargetCellPos(TargetColCell.posArrList_Fmt)
	end
end

function PowerLandCustomFmtMo:clearCellTop(cell)
	local proxy = MaterialMgr.getProxy(cell)

	if proxy then
		proxy.binder:clearTargetCol()
	end

	PowerLandCustomFmtMo.super.clearCellTop(self, cell)
end

function PowerLandCustomFmtMo:getMonsterConfigList()
	local creepsMasterId = PowerLandModel.instance:getCreepsMasterId()

	return PowerLandConfig.instance:getPlCreepsCfg(creepsMasterId)
end

function PowerLandCustomFmtMo:getFmtInfoConfig()
	local activityId = PowerLandModel.instance:getCurActivityId()
	local stageId = PowerLandModel.instance:getCurStageId()
	local creepsMasterId = PowerLandModel.instance:getCreepsMasterId()

	return (PowerLandConfig.instance:getPlTeamDataById(activityId, stageId, creepsMasterId))
end

function PowerLandCustomFmtMo:getExtendViewName()
	return ViewName.BtnTargetView
end

function PowerLandCustomFmtMo:updateData()
	local activityId = PowerLandModel.instance:getCurActivityId()
	local stageId = PowerLandModel.instance:getCurStageId()
	local creepsMasterId = PowerLandModel.instance:getCreepsMasterId()
	local plActData = PowerLandConfig.instance:getPlActData(activityId)
	local teamData = PowerLandConfig.instance:getPlTeamDataById(activityId, stageId, creepsMasterId)

	PowerLandModel.instance:setIsInFmt(true)

	self._isNeedSendSaveReq = true
	self.needUpPetCount = plActData.canFormPetCount
	self.topTitleStr = teamData.stageName
	self.ruleDescStr = teamData.passDesc
	self.isShowBtnContractPet = false

	self:clearAllPetList()
	self:getCurFormation():SetData(PowerLandModel.instance:getSaveSimpleForm())
end

function PowerLandCustomFmtMo:autoExitFormation()
	PowerLandModel.instance:setIsInFmt(false)

	local simpleForm = self:getCurSimpleForm()

	PowerLandModel.instance:setSaveSimpleForm(simpleForm)

	if self._isNeedSendSaveReq then
		local activityId = PowerLandModel.instance:getCurActivityId()

		PowerLandController.instance:onSendPowerLandSetFormReq(activityId, simpleForm)
	end
end

return PowerLandCustomFmtMo
