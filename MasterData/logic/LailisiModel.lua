-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/model/LailisiModel.lua

module("logic.extensions.lailisi.model.LailisiModel", package.seeall)

local LailisiModel = class("LailisiModel", BaseModel)

function LailisiModel:ctor()
	return
end

function LailisiModel:onInit()
	LailisiModel.super.onInit(self)
	self:onReset()
end

function LailisiModel:onReset()
	self:onResetInfo()

	self._allInfo = {}
	self._petProgress = {}
	self._petTeamInfo = {}
	self._rewardReceived = {}
	self._rewardReceivedPool = {}
	self._taskDetail = {}
	self._rankInfo = {}
	self._lailisiActIds = {
		165017,
		165018,
		165019,
		165020,
		165021
	}
	self.formationMo = {}
	self._curActId = nil
	self._finalActId = 0
	self._curDamage = 0
	self._lastActId = 0
	self._viewInfo = {}
	self._customFmtMo = nil
end

function LailisiModel:getLastActId()
	return self._lastActId
end

function LailisiModel:setLastActId(actId)
	self._lastActId = actId
end

function LailisiModel:setLailisiActIds(actId)
	table.insert(self._lailisiActIds, actId)
end

function LailisiModel:getLailisiActIds()
	local actids = LailisiConfig.instance:getCommonCfg("lailisiActIds")

	return string.split(actids, ",")
end

function LailisiModel:getXingluoActIds()
	local actids = LailisiConfig.instance:getCommonCfg("xingluoActIds")

	return string.split(actids, ",")
end

function LailisiModel:setRankInfo(msg)
	self._rankInfo = msg
end

function LailisiModel:getRankInfo()
	return self._rankInfo
end

function LailisiModel:setTaskDetailInfo(activityId, msg)
	self._taskDetail[activityId] = msg
end

function LailisiModel:getTaskDetailInfo(activityId)
	return self._taskDetail[activityId]
end

function LailisiModel:updataTaskDetailInfo(activityId, msg)
	if self._taskDetail[activityId] then
		local info = self._taskDetail[activityId]
		local count = #info

		for i = 1, count do
			if info[i].taskNum and info[i].taskNum == msg.taskNum then
				info[i] = msg
			end
		end
	end
end

function LailisiModel:setAllInfo(msg)
	self._allInfo = msg
	self._petProgress = {}
	self._petTeamInfo = {}

	for i, v in pairs(msg) do
		if v.activityId then
			self:_setPetInfo(v.activityId, v)
			self:setRewardReceivedWithId(v.activityId, v.rewardReceived)

			if self:judgeFinalActId(v.activityId) then
				self:setRewardReceived(v.rewardReceived)
				self:setTaskDetailInfo(v.activityId, v.taskInfo.taskDetail)
			end
		end
	end
end

function LailisiModel:updateInfo(msg)
	for k, v in pairs(self._allInfo) do
		if v.activityId == msg.activityId then
			self:_updatePetInfo(msg.activityId, msg)

			if self:judgeFinalActId(msg.activityId) then
				self:setTaskDetailInfo(msg.activityId, msg.taskInfo.taskDetail)

				self._curDamage = msg.damage
			end
		end
	end
end

function LailisiModel:getDamage()
	return self._curDamage
end

function LailisiModel:setRewardReceivedWithId(actId, msg)
	self._rewardReceivedPool[actId] = msg or {}
end

function LailisiModel:setRewardReceived(msg)
	self._rewardReceived = msg and msg or {}
end

function LailisiModel:_setPetInfo(actId, info)
	if not actId then
		return
	end

	self._petProgress[actId] = info.stageInfo
	self._petTeamInfo[actId] = info.liveCount
end

function LailisiModel:_updatePetInfo(actId, info)
	if not actId then
		return
	end

	self._petProgress[actId] = info.stageInfo

	local cfg = self._petTeamInfo[actId]

	for i, v in ipairs(cfg) do
		if v.stageId == info.liveCount.stageId then
			self._petTeamInfo[actId][i] = info.liveCount

			return
		end
	end
end

function LailisiModel:getAllInfo()
	return self._allInfo
end

function LailisiModel:getPetProgress(actId)
	return self._petProgress[actId]
end

function LailisiModel:getpetTeamInfo(actId)
	return self._petTeamInfo[actId]
end

function LailisiModel:setFinalActIdActivityId(finalActId)
	self._finalActId = finalActId
end

function LailisiModel:getFinalActivityId()
	return self._finalActId
end

function LailisiModel:getFinalActivity()
	for k, v in pairs(self._allInfo) do
		if v.activityId == self._finalActId then
			return v
		end
	end

	printError("lbc========好像没有最终决战的活动ID哦")

	return {}
end

function LailisiModel:getActivityInfo(activityId)
	for k, v in pairs(self._allInfo) do
		if v.activityId == activityId then
			return v
		end
	end

	return {}
end

function LailisiModel:isPlayerRewardCanGet(actId, prizeId, needScore)
	local isScoreEnough = needScore <= self._petProgress[actId].progress

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGetedWithId(actId, prizeId)

		return not isGeted
	else
		return false
	end
end

function LailisiModel:isPlayerRewardGeted(prizeId)
	local cfg = self._rewardReceived

	return TableUtil.isHad(cfg, prizeId)
end

function LailisiModel:isPlayerRewardGetedWithId(actId, prizeId)
	if not self._rewardReceivedPool[actId] then
		return TableUtil.isHad(self._rewardReceivedPool[actId], prizeId)
	end
end

function LailisiModel:getBuffcfgs()
	local cfgs = {}

	for i, v in ipairs(self._allInfo) do
		local cfg = LailisiConfig.instance:getActivityCfgById(v.activityId)

		if v.activityId ~= cfg.finalActivityId then
			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

function LailisiModel:getBuffcfgsBuyActId(activityId)
	local cfgs = {}
	local cfg = LailisiConfig.instance:getChallengeCfg(activityId) or {}

	if not cfg.actIds then
		local actIds = {}

		for i, actId in ipairs(actIds) do
			local cfgA = LailisiConfig.instance:getActivityCfgById(actId)

			table.insert(cfgs, cfgA)
		end

		return cfgs
	end
end

function LailisiModel:getBuffId(actId)
	return self._petProgress[actId].buffId
end

function LailisiModel:getTaskInfo(actId)
	for i, v in ipairs(self._allInfo) do
		if actId == v.activityId and v.taskInfo ~= nil then
			return v.taskInfo
		end
	end

	printError("lbc=============没找到的日常任务哦", actId)

	return {}
end

function LailisiModel:judgeFinalActId(actId)
	local cfg = LailisiConfig.instance:getActivityCfgById(actId)

	if cfg and actId == cfg.finalActivityId then
		return true
	end

	return false
end

function LailisiModel:isFinalAct(actId)
	for i, v in pairs(self._allInfo) do
		if v.activityId then
			local cfg = LailisiConfig.instance:getActivityCfgById(v.activityId)

			if v.activityId == cfg.finalActivityId and v.activityId == actId then
				return true
			end
		end
	end

	return false
end

function LailisiModel:onResetInfo()
	self._allPetList = nil
	self._curPetMap = {}
end

function LailisiModel:GetAllPetList(actId, stageId)
	if self._allPetList == nil then
		self:initPetList(actId, stageId)
	end

	return self._allPetList
end

function LailisiModel:initPetList(actId, stageId)
	if self:isFinalAct(actId) then
		local teamInfo = LailisiConfig.instance:getTeamInfo(actId, 1)
		local cfg = LailisiConfig.instance:getHelperPetCfg(teamInfo.creepsMasterId)

		self:initSupPetList(cfg)

		return
	end

	self:initBagPetList(actId, stageId)
end

function LailisiModel:initBagPetList(actId, stageId)
	local pets = BagPetsController.instance:getFightBagPet()
	local isHavePublicAttr = LailisiConfig.instance:isHavePublicAttr(actId)
	local list = {}

	self._curPetMap = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	for k, v in pairs(pets) do
		if v then
			local mo = v:GetClone()

			if isHavePublicAttr then
				mo.attrMo:resetPublicAttr()
				mo.attrMo:calcTotalAttrs()
				mo:refreshAllAttr()
			end

			table.insert(list, mo)

			self._curPetMap[v.petId] = mo
		end
	end

	self._allPetList = list
end

function LailisiModel:screenPet(list, petMo)
	if #list == 0 then
		return true
	end

	for k, v in pairs(list) do
		if petMo:checkHasRace(v) then
			return true
		end
	end

	return false
end

function LailisiModel:PetValidator(actId, stageId)
	if actId == nil or stageId == nil then
		return {}
	end

	local teamData = LailisiConfig.instance:getTeamInfo(actId, stageId)

	if teamData.formCondition == 0 then
		return {}
	end

	local validator = FormationValidatorConfig.instance:getFormationValidatorCfg(teamData.formCondition)
	local list = {}
	local str = string.split(validator.validator, "$")

	if str[1] == "All" then
		local allValidator = FormationValidatorConfig.instance:getFormationAllValidatorCfg(checknumber(str[2]))

		if allValidator and allValidator.count == 0 then
			local validatorList = string.split(allValidator.validator, "&")

			for k, v in pairs(validatorList) do
				local validator = string.split(v, "$")

				table.insert(list, validator[2])
			end
		end
	end

	return list
end

function LailisiModel:initSupPetList(cfg)
	local list = {}

	self._curPetMap = {}

	for k, v in pairs(cfg) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		table.insert(list, petMo)

		self._curPetMap[petMo.petId] = petMo
	end

	self._allPetList = list
end

function LailisiModel:GetCurFormation(actId, funcCallback)
	self.formationMo[actId] = self.formationMo[actId] or FormationMO.New(funcCallback)

	return self.formationMo[actId]
end

function LailisiModel:getPetMo(petId)
	if self._allPetList == nil then
		self:initPetList(self._curActId)
	end

	if self._curPetMap then
		return self._curPetMap[petId]
	end

	return nil
end

function LailisiModel:setSkipTime(time)
	self._skipTime = time
end

function LailisiModel:getSkipTime()
	return self._skipTime
end

function LailisiModel:getCustomFmtMo(actId, stageId)
	if self._customFmtMo == nil then
		self._customFmtMo = LailisiCustomFmtMo.New()
	end

	self._curActId = actId

	self._customFmtMo:getActivityId(actId, stageId)

	return self._customFmtMo
end

function LailisiModel:saveLastView(viewName, ...)
	local view = {}

	view.viewName = viewName
	view.params = {
		...
	}

	table.insert(self._viewInfo, view)
end

function LailisiModel:getLastView()
	return self._viewInfo or {}
end

function LailisiModel:clearLastView()
	self._viewInfo = {}
end

LailisiModel.instance = LailisiModel.New()

return LailisiModel
