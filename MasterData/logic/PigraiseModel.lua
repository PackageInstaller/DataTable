-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/model/PigraiseModel.lua

module("logic.extensions.pigraise.model.PigraiseModel", package.seeall)

local PigraiseModel = class("PigraiseModel", BaseModel)

function PigraiseModel:ctor()
	return
end

function PigraiseModel:onInit()
	PigraiseModel.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.updateAllPetInfoUnlockState, self)
	self:onReset()
end

function PigraiseModel:onReset()
	self._id = nil
	self._defineId = 1
	self._name = nil
	self._hair = nil
	self._skin = nil
	self._tail = nil
	self._intimacy = 0
	self._intimacyBefo = 0
	self._mood = 0
	self._energy = 0
	self._feedbackEventId = 0
	self._eventId = 0
	self._isFollow = false
	self._moodUpdateTime = nil
	self._energyUpdateTime = nil
	self._touchCdStartTime = nil
	self._dailyTouchTimes = nil
	self._hasGainPrizeLvs = nil
	self._isTake = false
	self._hasFreeRenameTimes = false
	self._todayHasRename = false
	self._changeSetId = nil
	self._adventureIntervalTime = nil
	self._adventurePrizeList = nil
	self._gainLv = nil
	self._curDialogueHashtable = nil
	self._notifyFlag = nil
	self._petInfos = nil
	self._curInfo = nil
end

function PigraiseModel:getPigId()
	return self._id
end

function PigraiseModel:getDefineId()
	return self._defineId or 1
end

function PigraiseModel:getAllPetInfo()
	local allPetInfos = {}
	local allPetCfgs = PigraiseConfig.instance:getAllPetCfgs()

	if not self._petInfos then
		return allPetInfos
	end

	for _, cfg in ipairs(allPetCfgs) do
		local info = self._petInfos[cfg.defineId]

		if not info then
			if cfg.isOnline then
				info = PetInfo.New()

				info:SetCfg(cfg)
				table.insert(allPetInfos, info)
			end
		else
			table.insert(allPetInfos, info)
		end
	end

	table.sort(allPetInfos, function(a, b)
		return b:getCurState() > a:getCurState()
	end)

	return allPetInfos
end

function PigraiseModel:updateAllPetInfoUnlockState()
	if FuncOpenModel.instance:getFuncIsOpen(100) and self._petInfos then
		local allPetInfos = self:getAllPetInfo()

		for _, info in pairs(allPetInfos) do
			if info:getIsAbleUnlock() then
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_NEWPET, true)

				return
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_NEWPET, false)
end

function PigraiseModel:getPigName()
	if string.nilorempty(self._name) then
		return "佩奇"
	end

	return self._name
end

function PigraiseModel:getPigAvatarMo()
	local cfg = PigraiseConfig.instance:getPetCfgById(self:getDefineId())
	local petId = self:getDefineId()
	local avatarMo = AvatarPetMo.New()

	if cfg then
		avatarMo.skeleton = cfg.modelId

		local partCfg = PigraiseConfig.instance:getModelinfoCfgById(petId, 1, self._skin)

		if partCfg and partCfg.partId then
			avatarMo:setDataByCfgId(partCfg.partId)
		end

		partCfg = PigraiseConfig.instance:getModelinfoCfgById(petId, 2, self._tail)

		if partCfg and partCfg.partId then
			avatarMo:setDataByCfgId(partCfg.partId)
		end

		partCfg = PigraiseConfig.instance:getModelinfoCfgById(petId, 3, self._hair)

		if partCfg and partCfg.partId then
			avatarMo:setDataByCfgId(partCfg.partId)
		end
	end

	avatarMo:setDefaultState()

	return avatarMo
end

function PigraiseModel:getPigCurMood()
	return Mathf.Clamp(self._mood, 0, PigraiseConfig.instance:getMaxMoodVal())
end

function PigraiseModel:getPigCurEnergy()
	return Mathf.Clamp(self._energy, 0, PigraiseConfig.instance:getMaxEnergyVal())
end

function PigraiseModel:getCurFeedbackEventInfo()
	local eventId = checkint(self._feedbackEventId)

	if eventId > 0 then
		return PigraiseConfig.instance:getFeedbackCfgById(eventId)
	else
		return nil
	end
end

function PigraiseModel:getCurEventInfo()
	local eventId = checkint(self._eventId)

	if eventId > 0 then
		return PigraiseConfig.instance:getInteractiveCfgById(eventId)
	else
		return nil
	end
end

function PigraiseModel:getIsFollow()
	return self._isFollow or false
end

function PigraiseModel:getCurLevel(value)
	if value == nil then
		value = checknumber(self._intimacy)
	end

	local level = 0

	for _, v in ipairs(PigraiseConfig.instance:getLevelCfg(self._defineId)) do
		if value >= checkint(v.initimacy) then
			level = level + 1
		else
			return level
		end
	end

	return PigraiseConfig.instance:getMaxLevel(self._defineId)
end

function PigraiseModel:getCurShowIntimacyInfo()
	local curLevel = self:getCurLevel()

	if curLevel == PigraiseConfig.instance:getMaxLevel(self._defineId) then
		return false
	end

	local curIntimacy = self._intimacy - checkint(PigraiseConfig.instance:getLevelCfgById(self._defineId, curLevel).initimacy)
	local curIntimacyMax = checknumber(PigraiseConfig.instance:getLevelCfgById(self._defineId, curLevel + 1).initimacy) - checknumber(PigraiseConfig.instance:getLevelCfgById(self._defineId, curLevel).initimacy)

	return curIntimacy, curIntimacyMax
end

function PigraiseModel:getChangeSetId()
	return self._changeSetId
end

function PigraiseModel:getDailyTouchTimes()
	self._dailyTouchTimes = Mathf.Clamp(self._dailyTouchTimes, 0, VipModel.instance:getPigTouchDailyCount())

	return VipModel.instance:getPigTouchDailyCount() - self._dailyTouchTimes
end

function PigraiseModel:getAdventurePrizeList()
	local prizes = self._adventurePrizeList

	if prizes and #prizes > 0 then
		local showPrizes = {}
		local info1, info2 = "8:6:", "8:1:"
		local prizecount1, prizecount2 = 0, 0

		for i = 1, #prizes do
			local count1 = string.sub(prizes[i][1], string.len(info1) + 1)
			local count2 = string.sub(prizes[i][2], string.len(info2) + 1)

			prizecount1 = prizecount1 + checkint(count1)
			prizecount2 = prizecount2 + checkint(count2)

			for k = 3, #prizes[i] do
				table.insert(showPrizes, prizes[i][k])
			end
		end

		info1 = info1 .. tostring(prizecount1)
		info2 = info2 .. tostring(prizecount2)

		table.insert(showPrizes, 1, info1)
		table.insert(showPrizes, 2, info2)

		return showPrizes
	else
		return nil
	end
end

function PigraiseModel:getPrizeDatas()
	local cfgs = PigraiseConfig.instance:getLevelCfg(self._defineId)
	local t = {}
	local isShowPoint = false

	for _, cfg in ipairs(cfgs) do
		local lv = checkint(cfg.level)
		local prizes = cfg.upgradePrize

		if lv > 0 and not table.indexof(self._hasGainPrizeLvs, lv) and not string.nilorempty(prizes) then
			local data = {
				isGetPrize = false,
				id = lv
			}

			table.insert(t, data)

			if lv <= self:getCurLevel() then
				isShowPoint = true
			end
		end
	end

	for i = 1, #self._hasGainPrizeLvs do
		local data = {
			isGetPrize = true,
			id = self._hasGainPrizeLvs[i]
		}

		table.insert(t, data)
	end

	return t, isShowPoint
end

function PigraiseModel:getPigCDTime()
	return self._touchCdStartTime + PigraiseConfig.instance:getTouchCD() - ServerTime.now()
end

function PigraiseModel:getCurPigDialogue()
	if self._curDialogueHashtable then
		local randomKey = MathUtil.randomWithWeightHashtable(self._curDialogueHashtable)
		local randomCfg = PigraiseConfig.instance:getDialogueCfgById(randomKey)

		if randomKey and randomCfg and not GameUtil.isEmptyString(randomCfg.dialogue) then
			return randomCfg.dialogue
		else
			return nil
		end
	else
		return nil
	end
end

function PigraiseModel:getCurPetInfo()
	return self._curInfo
end

function PigraiseModel:getCurOwnPetInfos()
	return self._petInfos
end

function PigraiseModel:getCurOwnPetInfoByDefineId(defineId)
	return self._petInfos[defineId]
end

function PigraiseModel:isHavePigDefineId()
	local result = false

	if self._petInfos then
		for defineId, v in pairs(self._petInfos) do
			if defineId == 1 then
				result = true

				break
			end
		end
	end

	return result
end

function PigraiseModel:isupdatePigCurMood()
	if not self._moodUpdateTime then
		return false
	end

	return ServerTime.now() >= self._moodUpdateTime
end

function PigraiseModel:isupdatePigCurEnergy()
	if not self._energy or self._energy <= 0 then
		return false
	end

	if not self._energyUpdateTime then
		return false
	end

	return ServerTime.now() >= self._energyUpdateTime
end

function PigraiseModel:isupdatePigCDTime()
	if not self._touchCdStartTime then
		return false
	end

	if self:getDailyTouchTimes() <= 0 then
		return false
	end

	return ServerTime.now() <= self._touchCdStartTime + PigraiseConfig.instance:getTouchCD()
end

function PigraiseModel:getAdventureTime()
	if not self:isupdateAdventure() then
		return PigraiseConfig.instance:getAdventureTotalTime()
	end

	return self._adventureIntervalTime
end

function PigraiseModel:isupdateAdventure()
	if not self._adventureIntervalTime or not self._adventurePrizeList then
		return nil
	end

	local isUpdatetime = PigraiseConfig.instance:getAdventureTotalTime() > self._adventureIntervalTime
	local prizeNum = #self._adventurePrizeList + 1
	local isUpdatePrize = self._adventureIntervalTime > prizeNum * PigraiseConfig.instance:getAdventurePrizeInterval()

	return isUpdatetime, isUpdatePrize
end

function PigraiseModel:updateAdventureTime()
	self._adventureIntervalTime = self._adventureIntervalTime + 1
end

function PigraiseModel:setFollowState(isFollow)
	self._isFollow = checkbool(isFollow)
end

function PigraiseModel:gainLvPrize(lv)
	self._gainLv = lv
end

function PigraiseModel:updatePigCurMood()
	self._moodUpdateTime = ServerTime.now() + PigraiseConfig.instance:getMoodDecInterval()

	if self._mood > 0 then
		self._mood = self._mood - 1
	end
end

function PigraiseModel:updatePigCurEnergy()
	self._energyUpdateTime = ServerTime.now() + PigraiseConfig.instance:getEnergyDecInterval()

	if self._energy > 0 then
		self._energy = self._energy - 1
	end
end

function PigraiseModel:updatePigCurDialogueHashtable()
	local curLv = self:getCurLevel()
	local curLvCfg = PigraiseConfig.instance:getLevelCfgById(self._defineId, curLv)
	local curDialogueHash = PigraiseConfig.instance:getDialogueHashTableById(curLvCfg.dialogueId)

	if not curLv or not curLvCfg or not curDialogueHash or table.nums(curDialogueHash) <= 0 then
		self._curDialogueHashtable = nil

		return
	end

	self._curDialogueHashtable = curDialogueHash
end

function PigraiseModel:playPigIntimacyAni(newValue)
	local beforeLevel = self:getCurLevel(self._intimacyBefo)
	local newLevel = self:getCurLevel(newValue)
	local addValue = newValue - self._intimacyBefo

	if self._intimacyBefo > 0 and addValue > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PigFeedSuccess, addValue, beforeLevel < newLevel)
	end

	self._intimacyBefo = newValue
end

function PigraiseModel:updateInfo()
	local flag = false
	local infoNums = table.nums(self._petInfos)

	if self._petInfos and infoNums ~= 0 then
		for _, info in pairs(self._petInfos) do
			if info.isTake then
				if flag then
					printError("多个宠物同时使用")

					return
				end

				flag = true

				self:_setCurInfo(info)
			end
		end

		if flag then
			return
		end

		self:_setCurInfo(self._petInfos[1])
	end
end

function PigraiseModel:_setCurInfo(info)
	self._id = info.id
	self._defineId = info.defineId
	self._hair = info.hair
	self._tail = info.tail
	self._skin = info.skin
	self._name = info.name
	self._intimacy = info.intimacy
	self._mood = info.mood
	self._energy = info.energy
	self._isFollow = info.isFollow
	self._feedbackEventId = info.feedbackEventId
	self._moodUpdateTime = info.moodUpdateTime
	self._energyUpdateTime = info.energyUpdateTime
	self._hasGainPrizeLvs = info.hasGainPrizeLvs
	self._hasFreeRenameTimes = info.hasFreeRenameTimes
	self._todayHasRename = info.todayHasRename
	self._curInfo = info
end

function PigraiseModel:updateAfterGetState(msg)
	if msg == nil then
		return
	end

	self._petInfos = {}

	for _, info in ipairs(msg.animalStates) do
		local petInfo = PetInfo.New()

		petInfo:setInfo(info)

		self._petInfos[petInfo.defineId] = petInfo
	end

	self._touchCdStartTime = checkint(msg.touchCdStartTime) / 1000
	self._dailyTouchTimes = msg.dailyTouchTimes

	self:updateInfo()
	self:updateAllPetInfoUnlockState()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_EVENT, checkint(self._feedbackEventId) > 0)
	self:updatePigCurDialogueHashtable()
end

function PigraiseModel:updateTake(defineId)
	for k, petInfo in pairs(self._petInfos) do
		petInfo.isTake = petInfo.id == checknumber(defineId)
	end
end

function PigraiseModel:updateAfterProcessFeedBack(msg)
	self:_updatePigState(msg)

	self._changeSetId = msg.changeSetId
end

function PigraiseModel:updateAfterTouch(msg)
	self:_updatePigState(msg)

	self._eventId = 0

	if not string.nilorempty(msg.eventId) then
		self._eventId = msg.eventId
		self._changeSetId = msg.changeSetId
	end

	self._dailyTouchTimes = self._dailyTouchTimes + 1
	self._touchCdStartTime = ServerTime.now()
end

function PigraiseModel:updateAfterOneKeyTouch()
	self._dailyTouchTimes = VipModel.instance:getPigTouchDailyCount()
end

function PigraiseModel:updateAfterFeed(msg)
	self:_updatePigState(msg)

	self._eventId = 0

	if not string.nilorempty(msg.eventId) then
		self._eventId = msg.eventId
		self._changeSetId = msg.changeSetId
	end
end

function PigraiseModel:updateAfterFollow(msg)
	return
end

function PigraiseModel:updateAfterGainIntimacyPrize(msg)
	self._changeSetId = msg.changeSetId

	if self._gainLv then
		table.insert(self._hasGainPrizeLvs, self._gainLv)
		table.sort(self._hasGainPrizeLvs, function(a, b)
			return a < b
		end)
	end

	self._gainLv = nil

	local _, isShowPoint = self:getPrizeDatas()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_PRIZE, isShowPoint)
end

function PigraiseModel:updateAfterGetFeedbackEvent(msg)
	self._mood = msg.mood
	self._energy = msg.energy
	self._moodUpdateTime = checkint(msg.moodUpdateTime) / 1000
	self._energyUpdateTime = checkint(msg.energyUpdateTime) / 1000
	self._feedbackEventId = msg.eventId

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_EVENT, checkint(self._feedbackEventId) > 0)
end

function PigraiseModel:updateAfterAdopt(msg)
	return
end

function PigraiseModel:updateAfterGetAdventureInfo(msg)
	self._adventureIntervalTime = checkint(msg.intervalTime)

	local t = {}

	for _, id in ipairs(msg.prizes) do
		local cfg = PigraiseConfig.instance:getAdventureCfgById(checkint(id))

		if cfg then
			local prizestr = cfg.prize

			if not string.nilorempty(prizestr) then
				local prizeList = string.split(prizestr, "#")

				if #prizeList >= 2 then
					table.insert(t, prizeList)
				end
			end
		end
	end

	self._adventurePrizeList = t

	if not self._notifyFlag then
		GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
			4
		}, PigraiseConfig.instance:getAdventureTotalTime() - self._adventureIntervalTime)

		self._notifyFlag = true
	end
end

function PigraiseModel:updateAfterGetAdventurePrize(msg)
	self._changeSetId = msg.changeSetId
	self._adventurePrizeList = {}
	self._adventureIntervalTime = 0
	self._notifyFlag = true

	GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
		4
	}, PigraiseConfig.instance:getAdventureTotalTime())
end

function PigraiseModel:updateAfterActivatePet(msg)
	local petInfo = PetInfo.New()

	petInfo:setInfo(msg.animalState)

	self._petInfos[petInfo.defineId] = petInfo
end

function PigraiseModel:updateAfterTakePet(msg)
	self._curInfo.isTake = false

	local petInfo = PetInfo.New()

	petInfo:setInfo(msg.animalState)

	self._petInfos[petInfo.defineId] = petInfo
	petInfo.isTake = true

	self:updateInfo()

	self._intimacyBefo = self._intimacy

	local _, isShowPoint = self:getPrizeDatas()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_PRIZE, isShowPoint)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_EVENT, checkint(self._feedbackEventId) > 0)
end

function PigraiseModel:updateAfterRenamePet(name)
	self._curInfo.hasFreeRenameTimes = false
	self._curInfo.name = name
	self._name = name
end

function PigraiseModel:_updatePigState(msg)
	self._intimacy = msg.intimacy

	self:playPigIntimacyAni(checkint(self._intimacy))
	self:updatePigCurDialogueHashtable()

	self._mood = msg.mood
	self._energy = msg.energy
	self._moodUpdateTime = checkint(msg.moodUpdateTime) / 1000 + PigraiseConfig.instance:getMoodDecInterval()
	self._energyUpdateTime = checkint(msg.energyUpdateTime) / 1000 + PigraiseConfig.instance:getEnergyDecInterval()
	self._feedbackEventId = msg.feedbackEventId

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_EVENT, checkint(self._feedbackEventId) > 0)

	local _, isShowPoint = self:getPrizeDatas()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_PRIZE, isShowPoint)
end

function PigraiseModel:isExistFeedbackEventId()
	return checkint(self._feedbackEventId) > 0
end

PigraiseModel.instance = PigraiseModel.New()

return PigraiseModel
