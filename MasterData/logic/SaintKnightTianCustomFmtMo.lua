-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/model/SaintKnightTianCustomFmtMo.lua

module("logic.extensions.saintknighttian.model.SaintKnightTianCustomFmtMo", package.seeall)

local SaintKnightTianCustomFmtMo = class("SaintKnightTianCustomFmtMo", ICustomFmtMo)
local lastPosIdx = -1

function SaintKnightTianCustomFmtMo:initParams(stageCfg)
	self._creepsCfg = stageCfg
	self._masterList = SaintKnightTianConfig.instance:getCreepMonsterCfgs(self._creepsCfg.creepsMasterId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.levelDescription or lang("击败敌阵所有精灵即可过关")
	self._supportPetCfg = SaintKnightTianConfig.instance:getSupportPetCfg(self._creepsCfg.supportCreepsId)

	self:clearAllPetList()

	if lastPosIdx > 0 then
		self:getCurFormation():SetPosition(lastPosIdx, 0)
	end

	self:getCurFormation():SetPosition(self._supportPetCfg.posId, self._supportPetCfg.creepsId)

	lastPosIdx = self._supportPetCfg.posId
	self.needUpPetCount = 6
end

function SaintKnightTianCustomFmtMo:updateData()
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.levelDescription or ""
	self.isShowBtnFormation = false

	self:setFormCondition(self._creepsCfg.formCondition)
end

function SaintKnightTianCustomFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:pushOneStack(ViewName.SaintKnightTianChallengeView, true)
		BattleFacade.instance:startSKTFight(self._creepsCfg)
		SaintKnightTianController.instance:startStageBattle(SaintKnightTianModel.instance:getCurChallengeId(), self._creepsCfg.stageId, self:getCurFormation())
	end)
end

function SaintKnightTianCustomFmtMo:getFixedPosList()
	if self._supportPetCfg then
		return {
			self._supportPetCfg.posId
		}
	end
end

function SaintKnightTianCustomFmtMo:checkPetIsForbit(petMo)
	if petMo.petId == self._supportPetCfg.creepsId then
		return true
	end

	return false
end

function SaintKnightTianCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function SaintKnightTianCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

function SaintKnightTianCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)

		if self._allMyPetList then
			local isHas = false

			for i, v in ipairs(self._allMyPetList) do
				if v.petId == petId then
					self._allMyPetList[i] = petMo
					isHas = true

					break
				end
			end

			if isHas == false then
				table.insert(self._allMyPetList, petMo)
			end
		end
	end
end

function SaintKnightTianCustomFmtMo:initPetList()
	self._allMyPetList = {}

	local helpMasterId = self._creepsCfg.supportCreepsId
	local supportCfgs = {}
	local cfgMaster = SaintKnightTianConfig.instance:getSupportPetCfg(helpMasterId)

	table.insert(supportCfgs, cfgMaster)

	for i, v in ipairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true
		self._supportPetName = petMo:getName()

		self:addPetToList(petMo)
	end

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
		table.insert(self._allMyPetList, petMo)
	end
end

function SaintKnightTianCustomFmtMo:getAllContractPetList()
	return self._allMyPetList
end

function SaintKnightTianCustomFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local totalPos = self.needUpPetCount
	local curFormation = self:getCurFormation()
	local numPos = FormationFacade.instance:curFormationPetNum(curFormation)
	local petsNum = BagModel.instance:diffRacePetCount()
	local minNeedCount = math.min(petsNum, totalPos)
	local isLimit = false
	local poses = curFormation:GetPositions()
	local isSupportPetExist = false

	for i, id in ipairs(poses) do
		if id > 0 then
			local petMo = self:getPetMoById(id)

			if petMo and petMo.isSupportedPet then
				isSupportPetExist = true

				break
			end
		end
	end

	if not isSupportPetExist then
		FloatWordMgr.instance:show(string.format("需要上阵<color=#%s>支援</color>精灵 %s", ColorConst.Red, self._supportPetName))

		return true
	end

	if numPos == 0 then
		isLimit = true

		local tip = langPara("空阵不能进行挑战，请返回布阵")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	elseif numPos > 0 and numPos < minNeedCount then
		isLimit = true

		local text = langPara("当前未上满%s只精灵，是否进入战斗？", minNeedCount)

		TipsFacade.instance:openPopupWindowWithX(lang("tip"), text, function()
			self:sendFightMsg()
		end, nil, lang("进入战斗"), lang("去布阵"))
	end

	return isLimit
end

function SaintKnightTianCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	local maxNum = self.needUpPetCount
	local count = 0
	local posIds = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9
	}
	local petMos = {}

	for _, posId in ipairs(posIds) do
		local isFixPos = MissionModel.instance:isFixedPos(posId)

		if isFixPos then
			local petId = self:getCurFormation():GetPosition(posId)
			local petMo = self:getPetMoById(petId)

			if petMo then
				petMos[posId] = petMo

				if not petMo:isSummonedPet() then
					count = count + 1
				end
			end
		end
	end

	local exPetMoList = {}

	for idx, posId in ipairs(posList) do
		local petMo = petPool[idx]
		local isHavePet = petMo ~= nil
		local isRepeatRaceId = false
		local raceId = petMo and petMo:getDefineId() or -1

		for _, mo in pairs(petMos) do
			local mRaceId = mo:getDefineId()

			isRepeatRaceId = isRepeatRaceId or raceId == mRaceId
		end

		if isHavePet and not isRepeatRaceId then
			local isNilSeat = petMos[posId] == nil

			if isNilSeat then
				local isSummonedPet = petMo:isSummonedPet()
				local isFitCount = count < maxNum

				if isSummonedPet then
					petMos[posId] = petMo
				elseif not isSummonedPet and isFitCount then
					petMos[posId] = petMo
					count = count + 1
				end
			else
				table.insert(exPetMoList, petMo)
			end
		end
	end

	for _, exPetMo in ipairs(exPetMoList) do
		local fitPosId

		for _, posId in ipairs(posIds) do
			if petMos[posId] == nil then
				fitPosId = posId
			end
		end

		if fitPosId == nil then
			break
		end

		local isSummonedPet = exPetMo:isSummonedPet()
		local isFitCount = count < maxNum

		if isSummonedPet then
			petMos[fitPosId] = exPetMo
		elseif not isSummonedPet and isFitCount then
			petMos[fitPosId] = exPetMo
			count = count + 1
		end
	end

	return posIds, petMos
end

return SaintKnightTianCustomFmtMo
