-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/model/InfinitefutureModel.lua

module("logic.extensions.infinitefuture.model.InfinitefutureModel", package.seeall)

local InfinitefutureModel = class("InfinitefutureModel", BaseModel)

function InfinitefutureModel:ctor()
	return
end

function InfinitefutureModel:onInit()
	self.curActId = 123001
	self.curPetId = 16005
	self.curStageId = 1
	self.endlessActIds = {
		123003,
		123004,
		123005
	}
	self.fireDragonActIds = {
		123006,
		123007,
		123008
	}
	self.viretaActIds = {
		123009,
		123010,
		123011
	}
	self.viretaActId = 0
	self.formationMo = {}
	self.viretaActTxts = {
		[self.viretaActIds[1]] = "回合数：",
		[self.viretaActIds[2]] = "存活数：",
		[self.viretaActIds[3]] = "维蕾塔击杀数："
	}
	self.curTeamID = 1
	self.isPass = false

	self:onReset()
end

function InfinitefutureModel:onReset()
	self.curStageId = 1
	self.curStageInfo = nil
	self.curDailySignId = 0
	self.isSignToday = false
	self.curBuffId = nil
	self.viretaActId = 0
	self._msgPool = {}
end

function InfinitefutureModel:getInfos(msg)
	self.curStageId = checknumber(msg.curStageId) + 1
	self.curStageInfo = {}
	self.curDailySignId = checknumber(msg.buffLevel)
	self.isSignToday = msg.gotBuff
	self.curBuffId = checknumber(msg.buffId)

	local teamids = msg.stageInfo.teamId

	for i = 1, #teamids do
		self.curStageInfo[i] = teamids[i]
	end

	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, self.curStageId)
end

function InfinitefutureModel:getStageById(activityId)
	local info = self._msgPool[activityId]

	if info then
		return checknumber(info.curStageId) + 1
	end

	return 1
end

function InfinitefutureModel:getStageById(activityId)
	local info = self._msgPool[activityId]

	if info then
		return checknumber(info.curStageId) + 1
	end

	return 1
end

function InfinitefutureModel:checkIsPassExById(activityId)
	local stageCfgs = InfinitefutureConfig.instance:getStageCfgs(activityId) or {}
	local totalCount = #stageCfgs

	return totalCount < self:getStageById(activityId)
end

function InfinitefutureModel:isChallengeTeamById(activityId, teamId)
	local info = self._msgPool[activityId]

	if info then
		if not info.stageInfo then
			if not info.stageInfo.teamId then
				local team = {}

				for k, v in pairs(team) do
					if teamId == v.teamId then
						return v.isChallenged
					end
				end
			end
		end
	end

	return false
end

function InfinitefutureModel:isChallengeTeam(teamId)
	if not self.curStageInfo[teamId] then
		return false
	end

	return self.curStageInfo[teamId].isChallenged
end

function InfinitefutureModel:getLockTeams(teamId)
	if not self.curStageInfo[teamId] then
		return {}
	end

	return self.curStageInfo[teamId].lockRaceIds
end

function InfinitefutureModel:isHaveScore(teamId)
	if not self.curStageInfo[teamId] then
		return false
	end

	return checknumber(self.curStageInfo[teamId].score) > 0
end

function InfinitefutureModel:getAllScore()
	local score = 0

	for i = 1, #self.curStageInfo do
		score = score + checknumber(self.curStageInfo[i].score)
	end

	return score
end

function InfinitefutureModel:setVretaKillScore(score, isWin)
	self._vretaKillScore = checknumber(score)
	self._vretaIsWin = isWin

	if self._vretaIsWin == nil then
		self._vretaIsWin = false
	end
end

function InfinitefutureModel:getVretaKillScore()
	return checknumber(self._vretaKillScore), self._vretaIsWin
end

function InfinitefutureModel:getScoreForList(teamId)
	if self.curStageInfo[teamId] ~= nil then
		return self.curStageInfo[teamId].score
	end

	return 0
end

function InfinitefutureModel:getConditionTxt(actId)
	if self.viretaActTxts[actId] ~= nil then
		return self.viretaActTxts[actId]
	end

	return ""
end

function InfinitefutureModel:setIsPass(isPass)
	self.isPass = isPass
end

function InfinitefutureModel:updateStageInfo(nextstage, teamid)
	if nextstage then
		self.curStageId = self.curStageId + 1
		self.curStageInfo = {}
	elseif teamid then
		self.curStageInfo[teamid] = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, self.curStageId)
end

function InfinitefutureModel:resetStageInfo(msg)
	local activityId = msg.activityId
	local teamId = msg.teamId
	local info = self._msgPool[activityId]

	if info then
		if not info.stageInfo then
			if not info.stageInfo.teamId then
				local team = {}

				for k, v in pairs(team) do
					if teamId == v.teamId then
						team[k] = nil

						break
					end
				end
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, self.curStageId)
end

function InfinitefutureModel:setCurSignInfo()
	self.curDailySignId = self.curDailySignId + 1
	self.isSignToday = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_ZXL_GETSIGN)
end

function InfinitefutureModel:setSelectBuffInfo(buffId)
	if self.curBuffId > 0 then
		self.curStageInfo = {}
	end

	self.curBuffId = checknumber(buffId)

	FloatWordMgr.instance:show("选择buff成功")
	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, self.curStageId)
end

function InfinitefutureModel:isBeLock(raceId)
	for k, v in pairs(self.curStageInfo) do
		for i = 1, #v.lockRaceIds do
			if checknumber(v.lockRaceIds[i]) == checknumber(raceId) then
				return true
			end
		end
	end

	return false
end

function InfinitefutureModel:isBuffNew(actId)
	local curStageOpen = checknumber(GameUtil.getUserData("infinitebuffred" .. actId))
	local openStage = 1
	local cfgs = InfinitefutureConfig.instance:getSelectBuffCfg(actId)

	for i, v in ipairs(cfgs) do
		if self.curStageId >= v.stageId then
			openStage = v.stageId
		end
	end

	return curStageOpen < openStage
end

function InfinitefutureModel:setBuffNew(actId)
	GameUtil.saveUserData("infinitebuffred" .. actId, self.curStageId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, self.curStageId)
end

function InfinitefutureModel:setSpecialFormation(actId, formation)
	if actId ~= self.viretaActIds[1] then
		return
	end

	local fMo = self:GetCurFormation(actId)

	fMo:Clone(formation)
end

function InfinitefutureModel:GetCurFormation(actId)
	self.formationMo[actId] = self.formationMo[actId] or FormationMO.New(GameUtil.handler(self.getPetMo, self))

	return self.formationMo[actId]
end

function InfinitefutureModel:onResetPetList(actid, isCleanForm)
	self._curPetMap = nil
	self._allPetList = nil

	if self.isPass then
		-- block empty
	end
end

function InfinitefutureModel:onResetFormationMo(actId)
	self.formationMo[actId] = nil
end

function InfinitefutureModel:isInViretaActIds(actId)
	for k, v in pairs(self.viretaActIds) do
		if v == actId then
			return true
		end
	end

	return false
end

function InfinitefutureModel:GetAllPetList(actId)
	if self._allPetList == nil then
		self:initPetList(actId)
	end

	self:updatePetListVersion()

	return self._allPetList
end

function InfinitefutureModel:initPetList(actId)
	local pets = BagPetsController.instance:getFightBagPet()
	local list = {}

	self._curPetMap = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	for k, v in pairs(pets) do
		if v then
			local mo = v:GetClone()

			if InfinitefutureConfig.instance:getExcludePublicStrengthens(actId) then
				mo.attrMo:resetPublicAttr()
				mo.attrMo:calcTotalAttrs()
				mo:refreshAllAttr()
			end

			table.insert(list, mo)

			self._curPetMap[v.petId] = mo
		end
	end

	local SupportedPet = self:getHelperPet(actId)

	if SupportedPet then
		for k, v in pairs(SupportedPet) do
			table.insert(list, v)

			self._curPetMap[v.petId] = v
		end
	end

	self._allPetList = list
end

function InfinitefutureModel:updatePetListVersion()
	local tmp = BagPetsController.instance:getPetChangeVersion()

	if self._curBagPetVersion == nil then
		self._curBagPetVersion = tmp
	end

	if tmp > self._curBagPetVersion then
		local changePetMoMap = BagPetsController.instance:getPetVersionChangeMap(self._curBagPetVersion)

		self:refreshPetList(changePetMoMap)

		self._curBagPetVersion = tmp
	end
end

function InfinitefutureModel:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function InfinitefutureModel:updatePetMo(mo)
	if self._allPetList then
		local isHas = false

		for i, v in ipairs(self._allPetList) do
			if v.petId == mo.petId then
				isHas = true

				if mo:isExist() then
					self._allPetList[i] = mo
					self._curPetMap[mo.petId] = mo

					break
				end

				table.remove(self._allPetList, i)
				table.remove(self._curPetMap, mo.petId)

				break
			end
		end

		if isHas == false then
			table.insert(self._allPetList, mo)
		end
	end
end

function InfinitefutureModel:getPetMo(petId, actId)
	if self._allPetList == nil then
		self:GetAllPetList(actId)
	end

	if self._curPetMap then
		return self._curPetMap[petId]
	end

	return nil
end

function InfinitefutureModel:getHelperPet(actId)
	local cfgs = InfinitefutureConfig.instance:getStageCfgs(actId)
	local helperPetId = cfgs[self.curStageId].helperPetPlanId
	local helperPetCfg = InfinitefutureConfig.instance:getHelperPet(helperPetId)
	local list = {}

	if helperPetCfg then
		for k, v in pairs(helperPetCfg) do
			local fMo = FightingPowerPetMo.New()

			fMo:fromChallengeCreepCo(v)

			local petMo = fMo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			table.insert(list, petMo)
		end
	end

	return list
end

InfinitefutureModel.instance = InfinitefutureModel.New()

return InfinitefutureModel
