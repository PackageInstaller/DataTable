-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/controller/MangTowerController.lua

module("logic.extensions.mangtower.controller.MangTowerController", package.seeall)

local MangTowerController = class("MangTowerController", BaseController)
local MANG_DATA_KEY = "MangTower"

function MangTowerController:onInit()
	MangTowerController.super.onInit(self)
	PursueDreamAgent.instance:setShowChangeSetFunc(function()
		return
	end)
	GlobalDispatcher:addListener(PursueDreamAgent.PM_PursueDreamGetInfoRes, self.handleGetInfo, self)
	GlobalDispatcher:addListener(PursueDreamAgent.PM_PursueDreamChallengeRes, self.handleChallengeRes, self)
	self:onReset()
end

function MangTowerController:onReset()
	self._canClickNext = true
	self._3v3enemyFmtMo = {}
end

function MangTowerController:loadMangTowerInfo()
	self:refreshActId()
	self:initRedPoint()
end

function MangTowerController:refreshActId()
	MangTowerModel.instance:setActId()

	local curActivityId
	local data_version = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.MangTower)

	for k, v in pairs(data_version) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MangTower, v.activityId) then
			curActivityId = v.activityId

			break
		end
	end

	MangTowerModel.instance:setActId(curActivityId)

	return curActivityId
end

function MangTowerController:setCanClickNext(boo)
	self._canClickNext = boo
end

function MangTowerController:getCanClickNext()
	return self._canClickNext
end

function MangTowerController:openMissionView(cfg)
	if cfg == nil then
		FloatWordMgr.instance:show("已通关!")

		return
	end

	local type = checknumber(cfg.type)
	local params = {}

	params.creepsMasterIds = cfg.creepsMasterIds
	params.buffPlanId = cfg.buffPlanId
	params.name = cfg.name

	local quanArr = string.split(cfg.ticket, ":")

	if #quanArr > 0 then
		local matType = checknumber(quanArr[1])
		local matId = checknumber(quanArr[2])
		local consumeNum = checknumber(quanArr[3])
		local haveNum = checknumber(MaterialModel.instance:getMaterialsNumber(matType, matId))

		if haveNum < consumeNum then
			local matCfg = MaterialMgr.getMatCfg(matType, matId)

			FloatWordMgr.instance:show(langPara("%s不足！", matCfg.name))

			return
		end
	end

	MangTowerModel.instance:setCurCfg(cfg)

	if type == MangTowerModel.TOWER_TYPE_1V1 then
		UIStateManager.instance:push(ViewName.MangTower1v1MissionView, params)
	elseif type == MangTowerModel.TOWER_TYPE_3V3 then
		self._3v3enemyFmtMo = {}

		for tab = 1, 3 do
			local creepsMasterId = checknumber(cfg.creepsMasterIds[tab])
			local creepCfg = MangTowerConfig.instance:getCreepCfg(creepsMasterId)
			local formations = {}

			for i, v in pairs(creepCfg) do
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(v, creepCfg)

				petMo.creepName = v.creepName
				formations[v.posId] = petMo
			end

			self._3v3enemyFmtMo[tab] = formations
		end

		UIStateManager.instance:push(ViewName.MangTower3v3MissionView, params)
	end
end

function MangTowerController:sendGetInfo()
	local actId = MangTowerModel.instance:getActId()

	if actId then
		PursueDreamAgent.instance:sendPM_PursueDreamGetInfoReq(actId)
	end
end

function MangTowerController:handleGetInfo(status, msg)
	MangTowerModel.instance:setNormalPhase(msg.normalPhase)
	MangTowerModel.instance:setExcitedPhase(msg.excitedPhase)
	MangTowerModel.instance:setScore(msg.score)
	MangTowerModel.instance:setHasGainDailyBonus(msg.hasGainDailyBonus)
	MangTowerModel.instance:setHasGetInfo(true)
	GlobalDispatcher:dispatch(GlobalNotify.MangTowerGetInfo)
end

function MangTowerController:sendGetFormations(type, callback)
	local actId = MangTowerModel.instance:getActId()

	if actId then
		PursueDreamAgent.instance:sendPM_PursueDreamGetFormsReq(actId, type, function(msg)
			for k, v in ipairs(msg.simpleForm) do
				if type == MangTowerModel.TOWER_TYPE_1V1 then
					MangTowerModel.instance:setFmt(v, type, nil)
				elseif type == MangTowerModel.TOWER_TYPE_3V3 then
					MangTowerModel.instance:setFmt(v, type, k)
				end
			end

			GameUtil.callBack(callback)
		end)
	end
end

function MangTowerController:sendChallenge(buffId, type)
	local actId = MangTowerModel.instance:getActId()
	local phase = 0

	if type == MangTowerModel.TOWER_TYPE_1V1 then
		phase = MangTowerModel.instance:getNormalPhase()
	elseif type == MangTowerModel.TOWER_TYPE_3V3 then
		phase = MangTowerModel.instance:getExcitedPhase()
	end

	PursueDreamAgent.instance:sendPM_PursueDreamChallengeReq(actId, type, phase + 1, buffId)
end

function MangTowerController:pushOneStackView(newUnit)
	MangTowerModel.instance:setNeedToShowNewUnit(newUnit)
	UIJumper.instance:pushOneStack(ViewName.MangTowerMainView, true)
end

function MangTowerController:handleChallengeRes(status, msg)
	if status == 0 then
		self._isWin = msg.isWin
		self._btlResults = msg.battleResult
		self._battleMsg = msg

		local type = #self._btlResults > 1 and MangTowerModel.TOWER_TYPE_3V3 or MangTowerModel.TOWER_TYPE_1V1
		local phase = 0

		if checkbool(self._isWin) then
			if type == MangTowerModel.TOWER_TYPE_3V3 then
				phase = MangTowerModel.instance:getExcitedPhase()

				MangTowerModel.instance:setExcitedPhase(phase + 1)
			else
				phase = MangTowerModel.instance:getNormalPhase()

				MangTowerModel.instance:setNormalPhase(phase + 1)

				if (phase + 1) % 5 == 0 then
					self:setSwitchRedPoint(true)
				end
			end

			if msg:HasField("gainScore") then
				local score = MangTowerModel.instance:getScore()

				MangTowerModel.instance:setScore(score + checknumber(msg.gainScore))
			end
		end

		self:pushOneStackView((phase + 1) % 5 == 0)
		self:_setBattleSettlement(msg)
		print("start len = " .. #self._btlResults)

		if self._btlResults then
			if type == MangTowerModel.TOWER_TYPE_3V3 then
				self:_start3v3Battle()
			else
				local btlResult = self._btlResults[1]

				BattleFacade.instance:startMangTower1v1(btlResult)

				BattleModel.instance.enableSkip = btlResult.originalStates.enableSkip
			end
		end
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end
end

function MangTowerController:_setBattleSettlement(msg)
	local test = checknumber(msg.changeSetId)

	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId, nil)
end

function MangTowerController:_start3v3Battle()
	self._curBtlResultIdx = 1
	self._isReplaying = false

	local btlResult = self:getCloneBtlResult()

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startMangTower3v3(btlResult)

		BattleModel.instance.enableSkip = btlResult.originalStates.enableSkip
	end
end

function MangTowerController:tryNextBattle()
	if self._isReplaying then
		print("tryNextBattle _isReplaying")

		return false
	end

	self._curBtlResultIdx = self._curBtlResultIdx + 1

	local btlResult = self:getCloneBtlResult()

	print("tryNextBattle idx = " .. self._curBtlResultIdx .. "len = " .. #self._btlResults)

	if btlResult ~= nil then
		BattleController.instance:onBattleContinue(btlResult)

		BattleModel.instance.enableSkip = btlResult.originalStates.enableSkip

		return true
	end

	return false
end

function MangTowerController:getCloneBtlResult(idx)
	local btlResult = self._btlResults[self._curBtlResultIdx]

	if btlResult then
		local str = btlResult:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)

		return msgClone
	end
end

function MangTowerController:saveCurrNormalFormation()
	local curFmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_1V1)
	local form = curFmt:createFormPb()

	form.formId = 10

	local actId = MangTowerModel.instance:getActId()

	PursueDreamAgent.instance:sendPM_PursueDreamSetFormsReq(actId, MangTowerModel.TOWER_TYPE_1V1, {
		form
	}, function(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end)

	return true
end

function MangTowerController:saveCur3v3Formation()
	local forms = {}

	for tabIndex = 1, 3 do
		local curFmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, tabIndex)
		local form = curFmt:createFormPb()

		form.formId = 10

		table.insert(forms, form)
	end

	local actId = MangTowerModel.instance:getActId()

	PursueDreamAgent.instance:sendPM_PursueDreamSetFormsReq(actId, MangTowerModel.TOWER_TYPE_3V3, forms, function(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end)

	return true
end

function MangTowerController:isInOtherTab(raceId)
	local tab = MangTowerModel.instance:getSelectFmtTab()

	for tabIndex = 1, 3 do
		if tabIndex ~= tab then
			local fmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, tabIndex)

			for _, petId in ipairs(fmt:GetPositions()) do
				if petId > 0 then
					local pet = BagPetsController.instance:getPet(petId)

					if pet and pet.raceId == raceId then
						return tabIndex
					end
				end
			end
		end
	end

	return nil
end

function MangTowerController:clearOtherTabPetByRaceId(raceId)
	local tab = MangTowerModel.instance:getSelectFmtTab()

	for tabIndex = 1, 3 do
		if tabIndex ~= tab then
			local fmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, tabIndex)

			for k, petId in ipairs(fmt:GetPositions()) do
				if petId > 0 then
					local pet = BagPetsController.instance:getPet(petId)

					if pet and pet.raceId == raceId then
						fmt:SetPosition(k, 0)
					end
				end
			end
		end
	end
end

function MangTowerController:checkEmptyFmt(curFmt)
	local petIdDic = {}

	for i = 1, 3 do
		local fmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, i)

		if fmt then
			for i = 1, 9 do
				local petId = fmt:GetPosition(i)

				if petId > 0 then
					petIdDic[petId] = true
				end
			end
		end
	end

	local maxPetNum = 5
	local pets = BagModel.instance:getCullingBagPets(petIdDic)
	local leftNum = BagModel.instance:diffRacePetCount(pets)
	local curPetNum = 0

	for i = 1, 9 do
		local petId = curFmt:GetPosition(i)

		if petId > 0 then
			curPetNum = curPetNum + 1
		end
	end

	if curPetNum == 0 then
		return 0
	elseif leftNum > 0 and curPetNum < maxPetNum then
		return 1
	else
		return 2
	end
end

function MangTowerController:openBattleResultView()
	local leftPlayerInfo = self:getMyPlayerInfo()
	local rightFormMos = self._3v3enemyFmtMo
	local twoFormMos = {}

	for k, v in ipairs(self._btlResults) do
		local twoFormMo = {}
		local leftFormMo = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, k)
		local rightFormMo = rightFormMos[k]

		twoFormMo.formId = k
		twoFormMo.isChallengerWin = v.activityWinner == 0

		local fid = 0
		local flvl = 0
		local info = leftFormMo:GetFormStrengthInfo()

		if info and info.formStrengthId and info.formStrengthId > 0 then
			fid = info.formStrengthId
			flvl = info.formStrengthLv
		end

		local heroSkillId = leftFormMo:GetHeroSkillId()
		local team = {}

		for idx, v in ipairs(leftFormMo:GetPositions()) do
			if v > 0 then
				local pet = BagPetsController.instance:getPet(v)

				if pet then
					table.insert(team, pet)
				end
			end
		end

		local eleMap = leftFormMo:getCurElementRelationMap()
		local cutePetRaceId, cutePetQuality = leftFormMo:getCutePetInfo()
		local masterId = leftFormMo:GetSummonMasterPetId()
		local summonId = leftFormMo:GetSummonPetId()

		twoFormMo.challengeZdl = FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId)
		twoFormMo.challengePets = team

		local rightPower = 0
		local rightPets = {}

		for i = 1, 9 do
			if rightFormMo[i] ~= nil then
				rightPower = rightPower + rightFormMo[i]:getFightingPower()

				table.insert(rightPets, rightFormMo[i])
			end
		end

		twoFormMo.beChallengeZdl = "？？？"
		twoFormMo.beChallengePets = rightPets

		table.insert(twoFormMos, twoFormMo)
	end

	UIStateManager.instance:open(ViewName.MangTowerBattleSettlementView, self._battleMsg.changeSetId, self._battlePlayerInfo, twoFormMos)
end

function MangTowerController:getMyPlayerInfo()
	local mo = {}

	mo.userName = RoleModel.instance:getUserName()
	mo.headIconId = RoleModel.instance:getHeadIconId()
	mo.headFrameId = RoleModel.instance:getHeadFrameId()
	mo.isMyInfo = true

	return mo
end

function MangTowerController:getBattleMsg()
	return self._battleMsg
end

function MangTowerController:initRedPoint()
	local activityId = MangTowerModel.instance:getActId()

	if checknumber(activityId) > 0 then
		local key = MANG_DATA_KEY .. activityId

		self:setSwitchRedPoint(checkbool(GameUtil.getUserDayData(key)))
	end
end

function MangTowerController:setSwitchRedPoint(torf)
	local activityId = MangTowerModel.instance:getActId()
	local key = MANG_DATA_KEY .. activityId

	if RedPointModel.instance:isActive(RedPointModel.ID_MANG_TOWER_SWITCH) ~= torf then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_MANG_TOWER_SWITCH, torf)
		GameUtil.saveUserDayData(key, torf)
	end
end

MangTowerController.instance = MangTowerController.New()

return MangTowerController
