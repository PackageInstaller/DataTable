-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/model/DivineKingShiKongLongZunSecondFmtMo.lua

module("logic.extensions.divinekingshikongllongzun.model.DivineKingShiKongLongZunSecondFmtMo", package.seeall)

local DivineKingShiKongLongZunSecondFmtMo = class("DivineKingShiKongLongZunSecondFmtMo", BaseCustomFmtMo)

function DivineKingShiKongLongZunSecondFmtMo:updateCfg(activityId, floorId, stageId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._floorId = checknumber(floorId)
	self._stageId = checknumber(stageId)

	local stagePlanId = DivineKingShiKongLongZunConfig.instance:getStagePlanId(activityId, floorId)

	self._creepsMasterId = DivineKingShiKongLongZunConfig.instance:getCreepMasterId(stagePlanId, stageId)
	self._masterData = DivineKingShiKongLongZunConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineKingShiKongLongZunConfig.instance:getCreepCfg(self._creepsMasterId)
	self._stageCfg = DivineKingShiKongLongZunConfig.instance:getStageCfgByStageId(stagePlanId, stageId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.isOnlyUpdateExistPet = true
	self._info = DivineKingShiKongLongZunModel.instance:getInfo(self._activityId)
	self._floorInfo = self._info.floorInfos[self._floorId]

	self:_initHpParam()
	self:_reCaleHpPos()
	self:setFormCondition(self._masterData.formCondition)
end

function DivineKingShiKongLongZunSecondFmtMo:_initHpParam()
	self._samePosMap = {}
	self._nextToFillIdxList = {}
	self._leftHpToFillList = {}
	self._leftHpIdxToFillList = {}
	self._finalHpMap = {}
	self._curLeftHpToFillIdx = 1
	self._positions = self.formationMo:GetPositions()
end

function DivineKingShiKongLongZunSecondFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineKingShiKongLongZunController.instance:sendPM_DivineKingSpaceDragonChallengeReq(self._activityId, simpleForm, self._floorId, self._stageId)
	end, nil)
end

function DivineKingShiKongLongZunSecondFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineKingShiKongLongZunSecondFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineKingShiKongLongZunSecondFmtMo:getExtendViewName()
	if self._stageId == DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM then
		return ViewName.DivineKingShiKongLongZunFmtView
	end
end

function DivineKingShiKongLongZunSecondFmtMo:endDragBagPet()
	self:_initHpParam()
	self:_reCaleHpPos()
end

function DivineKingShiKongLongZunSecondFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		local faceId = petMo.curFaceId
		local hasShenYaoJob = PetSkinConfig.instance:checkHasJob(faceId, GameEnum.JobZhDefine.ShenYao)

		if hasShenYaoJob then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function DivineKingShiKongLongZunSecondFmtMo:onFormationChangeFinish()
	self:_initHpParam()
	self:_reCaleHpPos()
end

function DivineKingShiKongLongZunSecondFmtMo:getActivityId()
	return self._activityId
end

function DivineKingShiKongLongZunSecondFmtMo:getFloorId()
	return self._floorId
end

function DivineKingShiKongLongZunSecondFmtMo:getStageId()
	return self._stageId
end

function DivineKingShiKongLongZunSecondFmtMo:getHpMap()
	self:_initHpParam()
	self:_reCaleHpPos()

	return self._finalHpMap
end

function DivineKingShiKongLongZunSecondFmtMo:updateCellTop(cell, petMo)
	if self._stageId == DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM then
		local luaCls = DivineKingShiKongLongZunBlood
		local url = DivineKingShiKongLongZunBlood.prefabUrl
		local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

		if proxy then
			self._proxyPool[cell] = proxy

			local petId = petMo.petId
			local petPos = self.formationMo:GetPetPosition(petId)

			if petPos then
				local hp = self._finalHpMap[petPos]

				if hp then
					local hpRate = math.ceil(hp / 100)

					proxy.binder:setSliderRate(hpRate)
				else
					proxy.binder:clearSlider()
				end
			else
				proxy.binder:clearSlider()
			end
		end
	end
end

function DivineKingShiKongLongZunSecondFmtMo:clearCellTop(cell)
	DivineKingShiKongLongZunSecondFmtMo.super.clearCellTop(self, cell)

	if self._stageId == DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM then
		local proxy = self._proxyPool[cell]

		if proxy then
			proxy.binder:clearSlider()

			self._proxyPool[cell] = nil
		end
	end
end

function DivineKingShiKongLongZunSecondFmtMo:_reCaleHpPos()
	local hpMap = {}
	local positionAndHpRatio = self._floorInfo.positionAndHpRatio

	table.sort(positionAndHpRatio, function(a, b)
		return a.left < b.left
	end)

	for i, posAndHpPair in ipairs(positionAndHpRatio) do
		local pos = posAndHpPair.left
		local hp = posAndHpPair.right
		local petId = self._positions[pos + 1]

		if petId and petId > 0 then
			self._samePosMap[pos + 1] = hp
			self._finalHpMap[pos + 1] = hp
		else
			table.insert(self._leftHpToFillList, hp)
			table.insert(self._leftHpIdxToFillList, pos + 1)
		end

		hpMap[pos] = hp
	end

	for pos, petId in ipairs(self._positions) do
		local curIdxHp = self._samePosMap[pos]

		if curIdxHp == nil and petId > 0 then
			self._finalHpMap[pos] = self._leftHpToFillList[self._curLeftHpToFillIdx]
			self._curLeftHpToFillIdx = self._curLeftHpToFillIdx + 1
		end
	end

	for i, pos in ipairs(self._leftHpIdxToFillList) do
		if self._curLeftHpToFillIdx > #self._leftHpIdxToFillList then
			break
		end

		self._finalHpMap[pos] = self._leftHpToFillList[self._curLeftHpToFillIdx]
		self._curLeftHpToFillIdx = self._curLeftHpToFillIdx + 1
	end
end

function DivineKingShiKongLongZunSecondFmtMo:hasPetOnFormation()
	for i, petId in ipairs(self._positions) do
		if petId > 0 then
			return true
		end
	end

	return false
end

return DivineKingShiKongLongZunSecondFmtMo
