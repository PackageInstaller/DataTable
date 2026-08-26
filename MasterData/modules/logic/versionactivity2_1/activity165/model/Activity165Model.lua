-- chunkname: @modules/logic/versionactivity2_1/activity165/model/Activity165Model.lua

module("modules.logic.versionactivity2_1.activity165.model.Activity165Model", package.seeall)

local Activity165Model = class("Activity165Model", BaseModel)

function Activity165Model:onInit()
	self:reInit()
end

function Activity165Model:reInit()
	self._storyMoDict = nil
end

function Activity165Model:onInitInfo()
	self._actId = VersionActivity2_1Enum.ActivityId.StoryDeduction

	if ActivityModel.instance:isActOnLine(self._actId) then
		Activity165Rpc.instance:sendAct165GetInfoRequest(self._actId)
	end
end

function Activity165Model:onGetInfo(actId, storyInfos)
	self._actId = actId

	for _, info in pairs(storyInfos) do
		if info.storyId then
			self:onGetStoryInfo(info)
		end
	end

	self:_initAllElements()
end

function Activity165Model:getStoryCount()
	return 3
end

function Activity165Model:onGetStoryInfo(storyInfo)
	self:setStoryMo(self._actId, storyInfo)
end

function Activity165Model:onModifyKeywordCallback(activityId, storyInfo)
	local storyId = storyInfo.storyId
	local mo = self:getStoryMo(activityId, storyId)

	mo:onModifyKeywordCallback(storyInfo)
end

function Activity165Model:onGenerateEnding(activityId, storyId, endingInfo)
	return
end

function Activity165Model:setEndingRedDot(storyId)
	local storyMo = self:getStoryMo(self._actId, storyId)

	for endingId, _ in pairs(storyMo.unlockEndings) do
		GameUtil.playerPrefsSetNumberByUserId(self:getEndingRedDotKey(endingId), 1)
	end
end

function Activity165Model:isShowEndingRedDot(storyId)
	local storyMo = self:getStoryMo(self._actId, storyId)

	for endingId, _ in pairs(storyMo.unlockEndings) do
		if GameUtil.playerPrefsGetNumberByUserId(self:getEndingRedDotKey(endingId), 0) == 0 then
			return true
		end
	end
end

function Activity165Model:getEndingRedDotIndex()
	for i = 1, self:getStoryCount() do
		if self:isShowEndingRedDot(i) then
			return i
		end
	end
end

function Activity165Model:getEndingRedDotKey(endingId)
	return self:_getStoryPrefsKey("Ending", endingId)
end

function Activity165Model:_getStoryPrefsKey(key, storyId)
	return (PlayerModel.instance:getPlayerPrefsKey(string.format("Activity165_%s_%s_%s", key, self._actId, storyId)))
end

function Activity165Model:onRestart(actId, storyInfo)
	self:setStoryMo(actId, storyInfo)
end

function Activity165Model:onGetReward(activityId, storyId, rewardIds)
	local mo = self:getStoryMo(activityId, storyId)

	mo:setclaimRewardCount(rewardIds)
end

function Activity165Model:getActivityId()
	return self._actId or VersionActivity2_1Enum.ActivityId.StoryDeduction
end

function Activity165Model:setStoryMo(actId, storyInfo)
	local mo = self:getStoryMo(actId, storyInfo.storyId)

	mo:setMo(storyInfo)
end

function Activity165Model:getStoryMo(actId, storyId)
	self._storyMoDict = self._storyMoDict or {}
	self._storyMoDict[actId] = self._storyMoDict[actId] or {}

	local storyMo = self._storyMoDict[actId][storyId]

	if not storyMo then
		storyMo = Activity165StoryMo.New()

		storyMo:onInit(actId, storyId)

		self._storyMoDict[actId][storyId] = storyMo
	end

	return storyMo
end

function Activity165Model:getAllActStory()
	return (self._storyMoDict or nil) and (self._storyMoDict[self._actId] or {})
end

function Activity165Model:hasUnlockStory()
	local storys = self:getAllActStory()

	if LuaUtil.tableNotEmpty(storys) then
		for _, story in pairs(storys) do
			if story.isUnlock then
				return true
			end
		end
	end
end

function Activity165Model:isHasUnlockEnding()
	local storys = self:getAllActStory()

	if LuaUtil.tableNotEmpty(storys) then
		for _, story in pairs(storys) do
			if story:getUnlockEndingCount() > 0 then
				return true
			end
		end
	end
end

function Activity165Model:_initAllElements()
	local storys = self:getAllActStory()

	self._elements = {}

	if LuaUtil.tableNotEmpty(storys) then
		for _, story in pairs(storys) do
			tabletool.addValues(self._elements, story:getElements())
		end
	end
end

function Activity165Model:getAllElements()
	return self._elements
end

function Activity165Model:isShowAct165Reddot()
	local storys = self:getAllActStory()

	if storys then
		for i, mo in pairs(storys) do
			if mo:isShowReddot() then
				return true
			end
		end
	end

	return false
end

function Activity165Model:setSeparateChars(txt)
	local charList = {}

	if not string.nilorempty(txt) then
		local tempList = string.split(txt, "\n")
		local str = ""

		for j = 1, #tempList do
			if not string.nilorempty(tempList[j]) then
				local chars = LuaUtil.getUCharArr(tempList[j])

				for i = 1, #chars do
					str = str .. chars[i]

					table.insert(charList, str)
				end

				str = str .. "\n"

				table.insert(charList, str)
			end
		end
	end

	return charList
end

function Activity165Model:GMCheckConfig()
	local endingStep = {}

	for id, co in pairs(lua_activity165_step.configDict) do
		if co.answersKeywordIds == "-1" then
			table.insert(endingStep, co.stepId)
		end
	end

	self.allRounds = {}

	local firstIds = {}

	for id, co in pairs(lua_activity165_step.configDict) do
		if not string.nilorempty(co.nextStepConditionIds) then
			local nextRounds = GameUtil.splitString2(co.nextStepConditionIds, true)

			for _, round in pairs(nextRounds) do
				self.allRounds[id] = self.allRounds[id] or {}

				table.insert(self.allRounds[id], round)

				if not LuaUtil.tableContains(firstIds, round[2]) then
					table.insert(firstIds, round[2])
				end
			end
		end
	end

	self:GMCheckAllRounds()
end

function Activity165Model:GMCheckAllRounds()
	for id, rounds in pairs(self.allRounds) do
		self:GMCheckisSameRound1(id, rounds)
	end
end

function Activity165Model:GMCheckisSameRound1(id, rounds)
	for i, round in pairs(rounds) do
		if LuaUtil.tableNotEmpty(round) then
			local finalId = round[1]

			if not self:GMCheckisSameRound2(id, round, finalId) then
				local _rounds = self:GMNextRoundByLast(finalId, id)
				local log = string.format("跳转步骤错误: 当前检查：%s步骤%s,\n%s中通过%s的步骤有：\n%s", id, self:logRound(round), finalId, id, self:logRounds(_rounds))

				SLFramework.SLLogger.LogError(log)
			elseif not self:GMCheckisSameRound4(id, round) then
				local log = string.format("跳转步骤错误: 当前检查：%s步骤%s,请检查%s是否缺少这条路径", id, self:logRound(round), round[#round])

				SLFramework.SLLogger.LogError(log)
			end
		end
	end
end

function Activity165Model:GMCheckisSameRound2(id, round, finalId)
	local finalRound = self.allRounds[finalId]

	if not finalRound then
		local co = Activity165Config.instance:getStepCo(self._actId, finalId)

		if not co or co.answersKeywordIds ~= "-1" then
			SLFramework.SLLogger.LogError("跳转步骤错误 " .. id .. "    " .. finalId)

			return false
		else
			return true
		end
	end

	for _, _round in pairs(finalRound) do
		if self:GMCheckisSameRound3(2, round, _round) then
			return true
		end
	end

	return false
end

function Activity165Model:GMCheckisSameRound4(id, round)
	local _round = {}

	table.insert(_round, id)

	local finalId = round[#round]

	for i = 2, #round - 1 do
		table.insert(_round, round[i])
	end

	local finalRound = self.allRounds[finalId]

	if finalRound then
		for _, __round in pairs(finalRound) do
			if self:GMCheckisSameRound3(1, _round, __round) then
				return true
			end
		end
	else
		return true
	end

	return false
end

function Activity165Model:GMNextRoundByLast(id, lastId)
	local rounds = self.allRounds[id]
	local list = {}

	if rounds then
		for _, round in pairs(rounds) do
			if round[#round] == lastId then
				table.insert(list, round)
			end
		end
	end

	return list
end

function Activity165Model:logRounds(rounds)
	local log = ""

	for _, round in pairs(rounds) do
		local _log = self:logRound(round)

		log = log .. "         " .. _log
	end

	return log
end

function Activity165Model:logRound(round)
	local log = ""

	for _, step in pairs(round) do
		log = log .. "#" .. step
	end

	return log
end

function Activity165Model:GMCheckisSameRound3(index, round1, round2)
	for i = index, #round1 do
		if round1[i] ~= round2[i] then
			return false
		end
	end

	return true
end

function Activity165Model:isPrintLog()
	return self._isPrintLog
end

function Activity165Model:setPrintLog(isPrintLog)
	self._isPrintLog = isPrintLog
end

function Activity165Model:closeEditView()
	return
end

Activity165Model.instance = Activity165Model.New()

return Activity165Model
