-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/model/LingShenChallengeFmtMo.lua

module("logic.extensions.lingshenchallenge.model.LingShenChallengeFmtMo", package.seeall)

local LingShenChallengeFmtMo = class("LingShenChallengeFmtMo", ICustomFmtMo)

LingShenChallengeFmtMo.ROWPOS = {
	{
		1,
		4,
		7
	},
	{
		2,
		5,
		8
	},
	{
		3,
		6,
		9
	}
}

local SUPPORT_PET_ID = 1000000000

function LingShenChallengeFmtMo:initParams(activityId, bossId, setRow)
	self.isSetEnemySimpleForm = true
	self.isShowOneKey = false
	self.isShowClean = false
	self.isShowBtnBuffForm = false
	self.isShowBtnCutePet = false
	self.isShowBtnContractPet = false
	self.isShowBtnFormationUse = false
	self.isShowBtnSave = true
	self.isShowPetBag = false
	self.isReady = false
	self.activityId = activityId
	self.bossId = bossId
	self._bossCfg = LingShenChallengeConfig.instance:getBossCfg(self.activityId, self.bossId)
	self._setRow = setRow
	self._cfgEnemy = LingShenChallengeConfig.instance:getTeamCfg(self._bossCfg.creepsMasterId)
	self._masterList = LingShenChallengeConfig.instance:getCreepsCfg(self._bossCfg.creepsMasterId)
	self.needUpPetCount = 9
	self._petOnSelfPos = {}
	self._sendFmtMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	self._sendFmtMo.isAutoSetSummonPet = false
end

function LingShenChallengeFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()

	local preFrom = LingShenChallengeModel.instance:getPetFormPosPet(self.activityId)
	local fightFrom = LingShenChallengeModel.instance:getFightFrom()
	local teamPetList = fightFrom.petList

	for i, v in ipairs(teamPetList) do
		local readPosId = v.posId + 1
		local isBagPet = false

		for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[self._setRow]) do
			if readPosId == posId then
				isBagPet = true

				break
			end
		end

		if not isBagPet then
			self:getCurFormation():SetPosition(readPosId, SUPPORT_PET_ID + readPosId)
		else
			local findIndex = 1

			for index = 1, 3 do
				if readPosId == LingShenChallengeFmtMo.ROWPOS[self._setRow][index] then
					findIndex = index

					break
				end
			end

			self._petOnSelfPos[findIndex] = preFrom[findIndex]

			self:getCurFormation():SetPosition(readPosId, preFrom[findIndex])
		end
	end

	table.clear(self:getCurFormation():GetChangeRaceTypes())

	if fightFrom.form.extParams and fightFrom.form.extParams.changeRaceTypes then
		for i, v in ipairs(fightFrom.form.extParams.changeRaceTypes) do
			local petId = self:getCurFormation():GetPosition(v.petId + 1)

			self:getCurFormation():updateChangeRaceTypes(petId, v.raceType)
		end
	end
end

function LingShenChallengeFmtMo:initFightHandler()
	local function handler()
		if not self.isReady then
			self._sendFmtMo:Clone(self:getCurFormation())

			for i = 1, 3 do
				if i ~= self._setRow then
					for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[i]) do
						self._sendFmtMo:SetPosition(posId, 0)
					end
				end
			end

			local simpleForm = CustomFmtController.instance:createFormPb(self._sendFmtMo)

			LingShenChallengeAgent.instance:sendPM_LingShenClgReadyReq(simpleForm)
		else
			FloatWordMgr.instance:show(lang("您已准备，请等待战斗开始"))
		end
	end

	self:setFightHandler(handler, nil)
end

function LingShenChallengeFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local clone = petMo:GetClone()

		clone.summonedPetId = 0
		clone.summonMasterId = 0

		self:addPetToList(self:_changePetMo(clone))
	end

	local teamPetList = LingShenChallengeModel.instance:getFightFrom().petList

	for i, v in ipairs(teamPetList) do
		local readPosId = v.posId + 1
		local isBagPet = false

		for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[self._setRow]) do
			if readPosId == posId then
				isBagPet = true

				break
			end
		end

		if not isBagPet then
			local petMo = FightingPowerPetMo.fromBasePetView(v.petView, nil, readPosId)
			local mo = petMo:toBaseBagPetMo()

			mo.petId = SUPPORT_PET_ID + readPosId
			mo.isSupportedPet = true
			mo.summonedPetId = 0
			mo.summonMasterId = 0

			self:addPetToList(self:_changePetMo(mo))
		end
	end
end

function LingShenChallengeFmtMo:refreshPetList(changePetMoMap)
	changePetMoMap = changePetMoMap or {}

	local fightFrom = LingShenChallengeModel.instance:getFightFrom()

	if not fightFrom then
		return
	end

	local teamPetList = fightFrom.petList

	for i, v in ipairs(teamPetList) do
		local readPosId = v.posId + 1
		local isBagPet = false

		for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[self._setRow]) do
			if readPosId == posId then
				isBagPet = true

				break
			end
		end

		if not isBagPet then
			local petMo = FightingPowerPetMo.fromBasePetView(v.petView, nil, readPosId)
			local mo = petMo:toBaseBagPetMo()

			mo.petId = SUPPORT_PET_ID + readPosId
			mo.isSupportedPet = true
			mo.summonedPetId = 0
			mo.summonMasterId = 0
			changePetMoMap[mo.petId] = mo
		end
	end

	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end

	self._lockSend = true

	for i, v in ipairs(teamPetList) do
		local readPosId = v.posId + 1
		local isBagPet = false

		for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[self._setRow]) do
			if readPosId == posId then
				isBagPet = true

				break
			end
		end

		if not isBagPet then
			self:getCurFormation():SetPosition(readPosId, SUPPORT_PET_ID + readPosId, true)
		else
			self:getCurFormation():SetPosition(readPosId, v.petView.petId, true)
		end
	end

	table.clear(self:getCurFormation():GetChangeRaceTypes())

	if fightFrom.form.extParams and fightFrom.form.extParams.changeRaceTypes then
		for i, v in ipairs(fightFrom.form.extParams.changeRaceTypes) do
			local petId = self:getCurFormation():GetPosition(v.petId + 1)

			self:getCurFormation():updateChangeRaceTypes(petId, v.raceType)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)

	self._lockSend = false
end

function LingShenChallengeFmtMo:_changePetMo(petMo)
	return petMo
end

function LingShenChallengeFmtMo:getFixedPosList()
	local list = {}

	for i = 1, 3 do
		if i ~= self._setRow then
			for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[i]) do
				table.insert(list, posId)
			end
		end
	end

	return list
end

function LingShenChallengeFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._formCondition then
		return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:getCurFormation(), isShowTip)
	else
		return true
	end
end

function LingShenChallengeFmtMo:getMonsterConfigList()
	return self._masterList
end

function LingShenChallengeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function LingShenChallengeFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show(lang("不可临阵脱逃哦~"))

	return false
end

function LingShenChallengeFmtMo:getExtendViewName()
	return ViewName.LingShenChallengeAddTipView
end

function LingShenChallengeFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local petMap = {}

	for i, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[self._setRow]) do
		if self:getCurFormation():GetPosition(posId) == 0 then
			FloatWordMgr.instance:show(lang("请上阵3个精灵"))

			return true
		else
			local petMo = self:getPetMoById(self:getCurFormation():GetPosition(posId))

			petMap[petMo.raceId] = true
		end
	end

	local fightInfo = LingShenChallengeModel.instance:getFightInfo()
	local mo = LingShenChallengeModel.instance:getFightFmtMo()
	local readyStatus = LingShenChallengeModel.instance:getReadyStatus()
	local playerPosId

	for i, v in ipairs(fightInfo.playerList) do
		if v.playerId ~= RoleModel.instance:getUserId() and readyStatus[v.playerId] == true then
			for j, pos in ipairs(LingShenChallengeFmtMo.ROWPOS[v.playerPosId]) do
				local petMo = self:getPetMoById(self:getCurFormation():GetPosition(pos))

				if petMap[petMo.raceId] == true then
					FloatWordMgr.instance:show(lang("已存在重复精灵，请替换"))

					return true
				end
			end
		end
	end

	return false
end

function LingShenChallengeFmtMo:initFormationMo()
	self.formationMo = LingShenChallengeFormationMo.New(GameUtil.handler(self.getPetMoById, self))
	self.formaitionMo.isAutoSetSummonPet = false
end

function LingShenChallengeFmtMo:checkBlockClickBtn(buttonName)
	if buttonName == "HeroSkill" then
		FloatWordMgr.instance:show(lang("不可调整"))

		return true
	elseif buttonName == "PsychicSkill" then
		FloatWordMgr.instance:show(lang("不可调整"))

		return true
	end

	return false
end

function LingShenChallengeFmtMo:checkPetIsForbit(petMo, baseCheck)
	if petMo.isSupportedPet == true then
		return true
	end

	return false
end

function LingShenChallengeFmtMo:showForbitPetAlert(petMo)
	if petMo.isSupportedPet == true then
		FloatWordMgr.instance:show(lang("无法调整队友的精灵"))
	end
end

function LingShenChallengeFmtMo:onFmoSetDown()
	local isChangeSelf = false

	for i = 1, 3 do
		local targetPos = LingShenChallengeFmtMo.ROWPOS[self._setRow][i]

		if self:getCurFormation():GetPosition(targetPos) ~= self._petOnSelfPos[i] then
			self._petOnSelfPos[i] = self:getCurFormation():GetPosition(targetPos)
			isChangeSelf = true
		end
	end

	if not self.formMsg and not self._lockSend then
		if isChangeSelf == true then
			self._sendFmtMo:Clone(self:getCurFormation())

			for i = 1, 3 do
				if i ~= self._setRow then
					for j, posId in ipairs(LingShenChallengeFmtMo.ROWPOS[i]) do
						self._sendFmtMo:SetPosition(posId, 0)
					end
				end
			end

			local simpleForm = CustomFmtController.instance:createFormPb(self._sendFmtMo)

			LingShenChallengeAgent.instance:sendPM_LingShenClgSetFormReq(simpleForm)
		end
	else
		self.formMsg = nil
	end
end

function LingShenChallengeFmtMo:getSetRow()
	return self._setRow
end

return LingShenChallengeFmtMo
