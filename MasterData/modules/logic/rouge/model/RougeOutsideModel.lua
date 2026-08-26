-- chunkname: @modules/logic/rouge/model/RougeOutsideModel.lua

module("modules.logic.rouge.model.RougeOutsideModel", package.seeall)

local RougeOutsideModel = class("RougeOutsideModel", BaseModel)

function RougeOutsideModel:onInit()
	self:reInit()
end

function RougeOutsideModel:reInit()
	self:_setRougeSeason(nil, RougeConfig1.instance:season())
end

function RougeOutsideModel:onReceiveGetRougeOutsideInfoReply(msg)
	self:updateRougeOutsideInfo(msg.rougeInfo)
end

function RougeOutsideModel:updateRougeOutsideInfo(rougeInfo)
	self:_setRougeSeason(rougeInfo)

	self._rougeGameRecord = self._rougeGameRecord or RougeGameRecordInfoMO.New()

	self._rougeGameRecord:init(rougeInfo.gameRecordInfo)
	RougeFavoriteModel.instance:initReviews(rougeInfo.review)
	RougeOutsideController.instance:dispatchEvent(RougeEvent.OnUpdateRougeOutsideInfo)
end

function RougeOutsideModel:getRougeGameRecord()
	return self._rougeGameRecord
end

function RougeOutsideModel:_setRougeSeason(rougeInfo, season)
	if rougeInfo ~= nil then
		self._rougeInfo = rougeInfo
	else
		assert(tonumber(season))

		self._rougeInfo = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		rawset(self._rougeInfo, "season", season)
	end

	season = season or self:season()

	if not self._config or self._config:season() ~= season then
		self._config = _G["RougeConfig" .. season].instance
	end
end

function RougeOutsideModel:config()
	return self._config
end

function RougeOutsideModel:openUnlockId()
	return self._config:openUnlockId()
end

function RougeOutsideModel:season()
	local season

	if self._rougeInfo then
		season = self._rougeInfo.season
	end

	if not season and self._config then
		season = self._config:season()
	end

	if not season then
		return 1
	end

	return math.max(season, 1)
end

function RougeOutsideModel:isUnlock()
	local openUnlockId = self:openUnlockId()

	return OpenModel.instance:isFunctionUnlock(openUnlockId)
end

function RougeOutsideModel:passedDifficulty()
	if not self._rougeGameRecord then
		return 0
	end

	return self._rougeGameRecord.maxDifficulty or 0
end

function RougeOutsideModel:isPassedDifficulty(difficulty)
	return difficulty <= self:passedDifficulty()
end

function RougeOutsideModel:isOpenedDifficulty(difficulty)
	local difficultyCO = self._config:getDifficultyCO(difficulty)

	return self:isPassedDifficulty(difficultyCO.preDifficulty)
end

function RougeOutsideModel:isOpenedStyle(style)
	if not style then
		return
	end

	local styleCO = self._config:getStyleConfig(style)
	local unlockType = styleCO.unlockType

	if not unlockType or unlockType == 0 then
		return true
	end

	return RougeMapUnlockHelper.checkIsUnlock(unlockType, styleCO.unlockParam)
end

function RougeOutsideModel:endCdTs()
	if not self._rougeGameRecord then
		return 0
	end

	local fromTs = self._rougeGameRecord:lastGameEndTimestamp()

	if fromTs <= 0 then
		return 0
	end

	local duration = self._config:getAbortCDDuration()

	if duration == 0 then
		return 0
	end

	return fromTs + duration
end

function RougeOutsideModel:leftCdSec()
	return self:endCdTs() - ServerTime.now()
end

function RougeOutsideModel:isInCdStart()
	return self:leftCdSec() > 0
end

function RougeOutsideModel:getDifficultyInfoList(versionList)
	local difficultyCOList = self._config:getDifficultyCOListByVersions(versionList)
	local res = {}

	for _, difficultyCO in ipairs(difficultyCOList) do
		local difficulty = difficultyCO.difficulty

		table.insert(res, {
			difficulty = difficulty,
			difficultyCO = difficultyCO,
			isUnLocked = self:isOpenedDifficulty(difficulty)
		})
	end

	table.sort(res, function(a, b)
		local a_difficulty = a.difficulty
		local b_difficulty = b.difficulty

		if a_difficulty ~= b_difficulty then
			return a_difficulty < b_difficulty
		end
	end)

	return res
end

function RougeOutsideModel:getStyleInfoList(versionList)
	local styleCOList = self._config:getStyleCOListByVersions(versionList)
	local res = {}

	for _, styleCO in ipairs(styleCOList) do
		res[#res + 1] = self:_createStyleMo(styleCO)
	end

	table.sort(res, RougeOutsideModel._styleSortFunc)

	return res
end

function RougeOutsideModel:_createStyleMo(styleCO)
	local style = styleCO.id

	return {
		style = style,
		styleCO = styleCO,
		isUnLocked = self:isOpenedStyle(style)
	}
end

function RougeOutsideModel._styleSortFunc(a, b)
	local a_isUnLocked = a.isUnLocked and 1 or 0
	local b_isUnLocked = b.isUnLocked and 1 or 0

	if a_isUnLocked ~= b_isUnLocked then
		return b_isUnLocked < a_isUnLocked
	end

	return a.style < b.style
end

function RougeOutsideModel:getSeasonStyleInfoList()
	local styleCOList = self._config:getSeasonStyleConfigs()
	local res = {}

	for _, styleCO in ipairs(styleCOList) do
		res[#res + 1] = self:_createStyleMo(styleCO)
	end

	table.sort(res, RougeOutsideModel._styleSortFunc)

	return res
end

local TRUE = 1
local FALSE = 0

function RougeOutsideModel:getIsNewUnlockDifficulty(difficulty)
	return self:_getUnlockDifficulty(difficulty, FALSE) == TRUE
end

function RougeOutsideModel:setIsNewUnlockDifficulty(difficulty, isNew)
	self:_saveUnlockDifficulty(difficulty, (isNew or nil) and (TRUE or FALSE))
end

function RougeOutsideModel:getIsNewUnlockStyle(style)
	return self:_getUnlockStyle(style, FALSE) == TRUE
end

function RougeOutsideModel:setIsNewUnlockStyle(style, isNew)
	self:_saveUnlockStyle(style, (isNew or nil) and (TRUE or FALSE))
end

local kPrefix = "RougeOutside|"
local kLastMarkPrefix = "LastMark|"

function RougeOutsideModel:_getPrefsKeyPrefix()
	local season = self:season()
	local versionList = RougeModel.instance:getVersion()
	local versionStr = table.concat(versionList, "#")

	return kPrefix .. tostring(season) .. tostring(versionStr)
end

function RougeOutsideModel:_saveInteger(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function RougeOutsideModel:_getInteger(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kDifficultyPrefix = "D|"

function RougeOutsideModel:_getPrefsKeyDifficulty(difficulty)
	assert(type(difficulty) == "number")

	return self:_getPrefsKeyPrefix() .. kDifficultyPrefix .. tostring(difficulty)
end

function RougeOutsideModel:_saveUnlockDifficulty(difficulty, value)
	local playerPrefsKey = self:_getPrefsKeyDifficulty(difficulty)

	self:_saveInteger(playerPrefsKey, value)
end

function RougeOutsideModel:_getUnlockDifficulty(difficulty, defaultValue)
	local playerPrefsKey = self:_getPrefsKeyDifficulty(difficulty)

	return self:_getInteger(playerPrefsKey, defaultValue)
end

function RougeOutsideModel:_getPrefsKeyLastMarkDifficulty()
	return self:_getPrefsKeyPrefix() .. kLastMarkPrefix .. kDifficultyPrefix
end

function RougeOutsideModel:setLastMarkSelectedDifficulty(value)
	local playerPrefsKey = self:_getPrefsKeyLastMarkDifficulty()

	self:_saveInteger(playerPrefsKey, value)
end

function RougeOutsideModel:getLastMarkSelectedDifficulty(defaultValue)
	local playerPrefsKey = self:_getPrefsKeyLastMarkDifficulty()

	return self:_getInteger(playerPrefsKey, defaultValue)
end

local kStylePrefix = "S|"

function RougeOutsideModel:_getPrefsKeyStyle(style)
	assert(type(style) == "number")

	return self:_getPrefsKeyPrefix() .. kStylePrefix .. tostring(style)
end

function RougeOutsideModel:_saveUnlockStyle(style, value)
	local playerPrefsKey = self:_getPrefsKeyStyle(style)

	self:_saveInteger(playerPrefsKey, value)
end

function RougeOutsideModel:_getUnlockStyle(style, defaultValue)
	local playerPrefsKey = self:_getPrefsKeyStyle(style)

	return self:_getInteger(playerPrefsKey, defaultValue)
end

function RougeOutsideModel:passedLayerId(layerId)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:passedLayerId(layerId)
end

function RougeOutsideModel:collectionIsPass(id)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:collectionIsPass(id)
end

function RougeOutsideModel:storyIsPass(id)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:storyIsPass(id)
end

function RougeOutsideModel:passedAnyEventId(list)
	for i, v in ipairs(list) do
		if self:passedEventId(v) then
			return true
		end
	end

	return false
end

function RougeOutsideModel:passedEventId(eventId)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:passedEventId(eventId)
end

function RougeOutsideModel:passAnyOneEnd()
	return self._rougeGameRecord and self._rougeGameRecord:passAnyOneEnd()
end

function RougeOutsideModel:passEndId(endId)
	return self._rougeGameRecord and self._rougeGameRecord:passEndId(endId)
end

function RougeOutsideModel:passEntrustId(entrustId)
	return self._rougeGameRecord and self._rougeGameRecord:passEntrustId(entrustId)
end

function RougeOutsideModel:getGeniusBranchStartViewInfo(geniusBranchId)
	local isUnlock = RougeTalentModel.instance:isTalentUnlock(geniusBranchId)

	if not isUnlock then
		return 0
	end

	return self._config:getGeniusBranchStartViewInfo(geniusBranchId)
end

function RougeOutsideModel:getGeniusBranchStartViewDeltaValue(geniusBranchId, eStartViewEnum)
	local startViewInfo = self:getGeniusBranchStartViewInfo(geniusBranchId)

	return startViewInfo[eStartViewEnum] or 0
end

function RougeOutsideModel:getGeniusBranchStartViewAllInfo()
	local refDict = {}
	local list = self._config:getGeniusBranchIdListWithStartView()

	for _, geniusBranchId in ipairs(list) do
		refDict[geniusBranchId] = false
	end

	RougeTalentModel.instance:calcTalentUnlockIds(refDict)

	local res = {}

	for geniusBranchId, isUnlock in pairs(refDict) do
		if isUnlock then
			local startViewInfo = self._config:getGeniusBranchStartViewInfo(geniusBranchId)

			for eStartViewEnum, value in pairs(startViewInfo) do
				res[eStartViewEnum] = (res[eStartViewEnum] or 0) + value
			end
		end
	end

	return res
end

function RougeOutsideModel:getStartViewAllInfo(difficulty)
	local dict1 = self._config:getDifficultyCOStartViewInfo(difficulty)
	local dict2 = self:getGeniusBranchStartViewAllInfo()
	local res = {}

	for eStartViewEnum, value in pairs(dict1) do
		res[eStartViewEnum] = (res[eStartViewEnum] or 0) + value
	end

	for eStartViewEnum, value in pairs(dict2) do
		res[eStartViewEnum] = (res[eStartViewEnum] or 0) + value
	end

	return res
end

function RougeOutsideModel:getCurExtraPoint()
	return (self._rougeInfo or nil) and (self._rougeInfo.curExtraPoint or 0)
end

RougeOutsideModel.instance = RougeOutsideModel.New()

return RougeOutsideModel
