-- chunkname: @modules/logic/guide/model/GuideModel.lua

module("modules.logic.guide.model.GuideModel", package.seeall)

local GuideModel = class("GuideModel", BaseModel)

GuideModel.GuideFlag = {
	FightForbidRoundView = 3,
	SeasonDiscount = 28,
	FightForbidCloseSkilltip = 25,
	FightForbidLongPressCard = 2,
	MaskUseMainCamera = 23,
	FightDoingEnterPassedEpisode = 10,
	FightForbidClickTechnique = 7,
	AutoChessToast = 45,
	KeepEpisodeItemLock = 29,
	FightDoingSubEntity = 5,
	PinballBanOper = 34,
	FeiLinShiDuoBanOper = 35,
	AutoChessSetPlaceIndex = 37,
	AutoChessEnableExchangeEXP = 39,
	AutoChessEnableSale = 40,
	AutoChessEnableDragChess = 43,
	SkipShowDungeonMapLevelView = 26,
	DontOpenMain = 24,
	FightBackSkipDungeonView = 9,
	AutoChessEnableUseSkill = 44,
	CooperGarlandForceRemove = 46,
	JumpGameLongPressGuide = 47,
	UseBlock = 17,
	FightForbidAutoFight = 4,
	AutoChessEnablePreviewEnemy = 41,
	FightForbidRestrainTag = 6,
	FightForbidClickOpenView = 15,
	MainViewGuideId = 32,
	SurvivalGuideLock = 48,
	SkipShowElementAnim = 19,
	BeiLiErPuzzleGame = 50,
	FightForbidSpeed = 8,
	PartyGameLocalGame1Result = 61,
	MoveFightBtn2MapView = 21,
	FightMoveCard = 1,
	EchoSongDragJoystick = 63,
	SkipInitElement = 20,
	AutoChessBanAllOper = 36,
	PartyGameLocalGame2Result = 62,
	PutTalent = 22,
	MainViewGuideBlock = 31,
	TianShiNaNaBanOper = 33,
	ForceJumpToMainView = 14,
	AutoChessEnableDragFreeChess = 38,
	DelayGetPointReward = 18,
	Guidepost = 12,
	SeasonUTTU = 27,
	SkipClickElement = 13,
	RoomForbidBtn = 16,
	PartyGameLocalGame1 = 60,
	FightSetSpecificCardIndex = 30,
	EchoSongDragScreen = 64,
	EchoSongInGuide = 65,
	FightLeadRoleSkillGuide = 11,
	HuiDiaoLanCombineLock = 49
}

function GuideModel:onInit()
	self._stepExecList = {}
	self._guideHasSetFlag = {}
	self._guideFlagDict = {}
	self._firstOpenMainViewTime = nil
	self._gmStartGuideId = nil
	self._fixNextStepGOPathDict = {}
	self._lockGuideId = nil
	self._guideParam = {
		OnPushBoxWinPause = false
	}
end

function GuideModel:reInit()
	self:onInit()
end

function GuideModel:execStep(guideId, stepId)
	self:addStepLog(string.format("%d_%d", guideId, stepId))
end

function GuideModel:onClickJumpGuides()
	self:addStepLog("click jump all guides")
end

function GuideModel:addStepLog(logStr)
	if #self._stepExecList >= 10 then
		table.remove(self._stepExecList, 1)
	end

	table.insert(self._stepExecList, logStr)
end

function GuideModel:getStepExecStr()
	return table.concat(self._stepExecList, ",")
end

function GuideModel:onOpenMainView()
	if self._firstOpenMainViewTime == nil then
		self._firstOpenMainViewTime = Time.time
	end
end

function GuideModel:setFlag(guideFlag, flagValue, guideId)
	if guideId then
		self._guideHasSetFlag[guideId] = self._guideHasSetFlag[guideId] or {}
		self._guideHasSetFlag[guideId][guideFlag] = flagValue
	end

	self._guideFlagDict[guideFlag] = flagValue
end

function GuideModel:isFlagEnable(guideFlag)
	if self._guideFlagDict[guideFlag] ~= nil then
		return true
	end

	return false
end

function GuideModel:clearFlagValue(guideFlag)
	self._guideFlagDict[guideFlag] = nil
end

function GuideModel:getFlagValue(guideFlag)
	return self._guideFlagDict[guideFlag]
end

function GuideModel:clearFlagByGuideId(guideId)
	local dict = self._guideHasSetFlag[guideId]

	self._guideHasSetFlag[guideId] = nil

	if dict then
		for guideFlag, flagValue in pairs(dict) do
			if flagValue then
				self._guideFlagDict[guideFlag] = nil
			end
		end
	end
end

function GuideModel:setGuideList(guideInfos)
	local list = {}

	for i = 1, #guideInfos do
		local guideInfo = guideInfos[i]
		local guideCO = GuideConfig.instance:getGuideCO(guideInfo.guideId)

		if guideCO then
			local guideStepCOList = GuideConfig.instance:getStepList(guideInfo.guideId)

			if guideStepCOList then
				local guideMO = GuideMO.New()

				guideMO:init(guideInfo)
				table.insert(list, guideMO)
			else
				logError("guide step config not exist: " .. guideInfo.guideId)
			end
		else
			logError("guide config not exist: " .. guideInfo.guideId)
		end
	end

	self:addList(list)
end

function GuideModel:updateGuideList(guideInfos)
	for i = 1, #guideInfos do
		local guideInfo = guideInfos[i]

		self:setGMGuideStep(guideInfo)

		local guideMO = self:getById(guideInfo.guideId)

		if guideMO == nil then
			guideMO = GuideMO.New()

			if self._firstOpenMainViewTime and Time.time - self._firstOpenMainViewTime < 6 then
				logNormal(string.format("<color=#FFA500>login trigger guide_%d</color>", guideInfo.guideId))
				guideMO:init(guideInfo)
			else
				guideMO:updateGuide(guideInfo)
			end

			self:addAtLast(guideMO)
		elseif guideMO.isFinish then
			logNormal(string.format("<color=#FFA500>restart guide_%d</color>", guideInfo.guideId))
			guideMO:init(guideInfo)
		else
			guideMO:updateGuide(guideInfo)
		end
	end
end

function GuideModel:addEmptyGuide(guideId)
	local guideMO = self:getById(guideId)

	if guideMO == nil then
		guideMO = GuideMO.New()
		guideMO.id = guideId

		self:addAtLast(guideMO)
	end
end

function GuideModel:clientFinishStep(guideId, stepId)
	local guideMO = self:getById(guideId)

	guideMO:setClientStep(stepId)
end

function GuideModel:isDoingFirstGuide()
	return self:getDoingGuideId() == 101
end

function GuideModel:lastForceGuideId()
	return 108
end

function GuideModel:getDoingGuideId()
	local list = self:getDoingGuideIdList()

	if list then
		for i = #list, 1, -1 do
			local guideCO = GuideConfig.instance:getGuideCO(list[i])

			if guideCO.parallel == 1 or GuideInvalidController.instance:isInvalid(guideCO.id) then
				table.remove(list, i)
			end
		end

		return GuideConfig.instance:getHighestPriorityGuideId(list)
	end
end

function GuideModel:getDoingGuideIdList()
	local list
	local guideMOList = self:getList()

	for i = 1, #guideMOList do
		local guideMO = guideMOList[i]

		if not guideMO.isFinish or guideMO.currStepId > 0 then
			list = list or {}

			table.insert(list, guideMOList[i].id)
		end
	end

	return list
end

function GuideModel:isDoingClickGuide()
	local guideMOList = self:getList()

	for i = 1, #guideMOList do
		local guideMO = guideMOList[i]

		if not guideMO.isFinish or guideMO.currStepId > 0 then
			local goPath = GuideModel.instance:getStepGOPath(guideMO.id, guideMO.currStepId)

			if not string.nilorempty(goPath) then
				return true
			end
		end
	end

	return false
end

function GuideModel:isAnyGuideRunning()
	local guideMOList = self:getList()

	for i = 1, #guideMOList do
		local guideMO = guideMOList[i]

		if not guideMO.isFinish or guideMO.currStepId > 0 then
			return true
		end
	end

	return false
end

function GuideModel:isGuideRunning(guideId)
	local guideMO = self:getById(guideId)

	if guideMO and not guideMO.isFinish then
		return true
	end

	return false
end

function GuideModel:isGuideFinish(guideId)
	local guideMO = self:getById(guideId)

	if guideMO and guideMO.isFinish then
		return true
	end

	return false
end

function GuideModel:isStepFinish(guideId, stepId)
	if self:isGuideFinish(guideId) then
		return true
	end

	local guideMO = self:getById(guideId)

	if guideMO and stepId < guideMO.currStepId then
		return true
	end

	return false
end

function GuideModel:setLockGuide(guideId, force)
	if self._lockGuideId and not self:isGuideFinish(self._lockGuideId) and not force then
		logNormal(string.format("<color=#FFA500>setLockGuide old:%s new:%s</color>", self._lockGuideId, guideId))

		return
	end

	self._lockGuideId = guideId

	logNormal(string.format("<color=#FFA500>setLockGuide guideId:%s</color>", self._lockGuideId))
end

function GuideModel:getLockGuideId()
	if self._lockGuideId and self:isGuideFinish(self._lockGuideId) then
		self._lockGuideId = nil
	end

	return self._lockGuideId
end

function GuideModel:gmStartGuide(guideId, guideStep)
	self._gmStartGuideId = guideId
	self._gmStartGuideStep = guideStep
end

function GuideModel:setGMGuideStep(guideInfo)
	if not guideInfo or guideInfo.guideId ~= self._gmStartGuideId or not self._gmStartGuideStep then
		return
	end

	guideInfo.stepId = self._gmStartGuideStep
	self._gmStartGuideStep = nil

	logNormal(string.format("<color=#FF0000>setGMGuideStep guideId:%d step:%d</color>", guideInfo.guideId, guideInfo.stepId))
end

function GuideModel:isGMStartGuide(guideId)
	return guideId == self._gmStartGuideId
end

function GuideModel:setNextStepGOPath(guideId, curStepId, goPath)
	local nextStepId = GuideConfig.instance:getNextStepId(guideId, curStepId)

	if nextStepId then
		self._fixNextStepGOPathDict[guideId] = self._fixNextStepGOPathDict[guideId] or {}
		self._fixNextStepGOPathDict[guideId][nextStepId] = goPath
	end
end

function GuideModel:getStepGOPath(guideId, stepId)
	if self._fixNextStepGOPathDict[guideId] then
		local goPath = self._fixNextStepGOPathDict[guideId][stepId]

		if goPath then
			return goPath
		end
	end

	local stepCO = GuideConfig.instance:getStepCO(guideId, stepId)

	return stepCO and stepCO.goPath
end

function GuideModel:getGuideParam()
	return self._guideParam
end

GuideModel.instance = GuideModel.New()

return GuideModel
