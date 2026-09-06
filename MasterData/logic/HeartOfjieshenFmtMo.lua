-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/model/HeartOfjieshenFmtMo.lua

module("logic.extensions.heartofjieshen.model.HeartOfjieshenFmtMo", package.seeall)

local HeartOfjieshenFmtMo = class("HeartOfjieshenFmtMo", ICustomFmtMo)

function HeartOfjieshenFmtMo:initParams(activityId, creepsMasterId, fmtType)
	self._activityId = activityId
	self._creepsMasterId = creepsMasterId
	self._fmtType = fmtType
	self._masterData = HeartofjieshenConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = HeartofjieshenConfig.instance:getCreepsCfgs(self._creepsMasterId)

	local tempBanIds = HeartofjieshenModel.instance:getBanOnChiRaceIds()

	self._banRaceIds = {}

	for i, v in ipairs(tempBanIds) do
		self._banRaceIds[v] = v
	end

	local tempMustIds = HeartofjieshenModel.instance:getMustOnChiRaceIds()

	self._mustRaceIds = {}

	for i, v in ipairs(tempMustIds) do
		self._mustRaceIds[v] = v
	end
end

function HeartOfjieshenFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function HeartOfjieshenFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if self._fmtType == GameEnum.HeartofjieshenclgFmtType.Yi then
			HeartofjieshenController.instance:sendFightYi(self._activityId, simpleForm)
		else
			local mustIds = {}

			for k, v in pairs(self._mustRaceIds) do
				mustIds[v] = 0
			end

			for i = 1, 9 do
				local petId = self:getCurFormation():GetPosition(i)

				if petId and petId > 0 then
					local petMo = self:getPetMoById(petId)

					if mustIds[petMo.raceId] then
						mustIds[petMo.raceId] = 1
					end
				end
			end

			local isPass = true

			for raceId, v in pairs(mustIds) do
				if v == 0 then
					isPass = false

					FloatWordMgr.instance:show(string.format("必须上阵 %s", PetSkinConfig.instance:getPetSkinName(raceId)))
				end
			end

			if not isPass then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end

			HeartofjieshenController.instance:sendFightChi(self._activityId, simpleForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function HeartOfjieshenFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo:GetClone())
	end
end

function HeartOfjieshenFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function HeartOfjieshenFmtMo:getFmtInfoConfig()
	return self._masterData
end

function HeartOfjieshenFmtMo:checkPetIsForbit(petMo)
	if self._fmtType == GameEnum.HeartofjieshenclgFmtType.Yi then
		return false
	end

	return self._banRaceIds[petMo.raceId]
end

function HeartOfjieshenFmtMo:isPetUnableToLeve(oldPetId, newPetId)
	if self._fmtType == GameEnum.HeartofjieshenclgFmtType.Chi then
		local petMo = BagPetsController.instance:getPet(oldPetId)

		if not petMo then
			return false
		end

		if not newPetId then
			if self._mustRaceIds[petMo.raceId] then
				return true
			end
		else
			local petMoNew = BagPetsController.instance:getPet(newPetId)

			if self._mustRaceIds[petMo.raceId] and (not petMoNew or self._mustRaceIds[petMoNew.raceId]) then
				return true
			end
		end
	end

	return false
end

function HeartOfjieshenFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self._fmtType == GameEnum.HeartofjieshenclgFmtType.Yi then
		return HeartOfjieshenFmtMo.super.getFinalFmoList(self, posList, petPool, needPets)
	end

	local fixPosList = {}
	local fixPetMoList = {}

	for posId = 1, 9 do
		local petId = self:getCurFormation():GetPosition(posId)

		if petId and petId > 0 then
			local petMo = self:getPetMoById(petId)

			if self._mustRaceIds[petMo.raceId] then
				table.insert(fixPosList, posId)
				table.insert(fixPetMoList, petMo)
			end
		end
	end

	return CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petPool, needPets, fixPosList, fixPetMoList, self.needUpPetCount)
end

function HeartOfjieshenFmtMo:getUnableLevelPos()
	if self._fmtType == GameEnum.HeartofjieshenclgFmtType.Yi then
		return nil
	end

	local pos = self:getCurFormation():GetPositions()
	local posList = {}

	for p, petId in pairs(pos) do
		if petId > 0 then
			local petMo = self:getPetMoById(petId)

			if self._mustRaceIds[petMo.raceId] then
				posList[p] = true
			end
		end
	end

	return posList
end

function HeartOfjieshenFmtMo:onClickCloseBtn(handler)
	if self._fmtType == GameEnum.HeartofjieshenclgFmtType.Chi then
		TipsFacade.instance:openPopupWindow("提示", "退出布阵后会重置挑战，确定退出吗？", function()
			HeartofjieshenModel.instance:resetClgFinishDic()
			GameUtil.callBack(handler)
		end)

		return
	end

	GameUtil.callBack(handler)
end

return HeartOfjieshenFmtMo
