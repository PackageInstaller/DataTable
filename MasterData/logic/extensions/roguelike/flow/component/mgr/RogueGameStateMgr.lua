-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueGameStateMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueGameStateMgr", package.seeall)

local M = class("RogueGameStateMgr", IRogueFlowComp)

function M:onInit()
	self._roundIndex = 0
	self._additionFighting = 0
	self._fixedFighting = nil
	self._judgeFailRoleList = {}
	self._deifyCount = 0
	self._tempExtraPattersUsed = {}
	self._clientRoundPatterns = {}
	self._clientOneTimePatterns = {}
	self._serverOneTimePatterns = {}
	self._serverContinuePatterns = {}
	self._totalPatterns = {}
	self._totalPatternsBackup = {}
	self._curUsablePattern = {}
	self._curUsablePatternBackup = {}
	self._tempRoleChangeValue = {}
	self._judgeCardUseInfos = {}
	self._clientNextCardEntries = {}
	self._clientCardEntries = {}

	self:setEvent(true)
end

function M:onStart()
	return
end

function M:onClear()
	self._isRestore = false
	self._isRestoreTotal = false

	self:setEvent(false)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onChangeCollector, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_UPDATE_JUDGE_ARCHIVE, self._onJudgeArchive, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onChangeCollector, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_UPDATE_JUDGE_ARCHIVE, self._onJudgeArchive, self)
	end
end

function M:addTempExtraPattern(patterns)
	for k, v in ipairs(patterns) do
		table.insert(self._clientOneTimePatterns, v)
		table.insert(self._totalPatterns, v)
		table.insert(self._curUsablePattern, v)
	end

	self:syncExtraPatterns()
end

function M:addRoundExtraPattern(patterns)
	for k, v in ipairs(patterns) do
		table.insert(self._clientRoundPatterns, v)
		table.insert(self._totalPatterns, v)
		table.insert(self._curUsablePattern, v)
	end

	self:syncExtraPatterns()
end

function M:removeTempExtraPattern()
	self._clientOneTimePatterns = {}
	self._clientRoundPatterns = {}

	self:syncExtraPatterns()
end

function M:setMonsterAttrBase(attr)
	self._monsterAttrBase = attr
end

function M:getMonsterAttrBase()
	return self._monsterAttrBase or 0
end

function M:updateExtraPatterns(overwrite)
	local archivePatterns = self:getArchivePattern()

	if #archivePatterns == 0 or overwrite then
		self._totalPatterns = {}
		self._totalPatterns = TableUtil.addRangeNew(self._totalPatterns, RoguelikeModel.instance:getTempExtraDiceCPatterns())
		self._totalPatterns = TableUtil.addRangeNew(self._totalPatterns, RoguelikeModel.instance:getExtraDiceCPatterns())
		self._totalPatterns = TableUtil.addRangeNew(self._totalPatterns, self._clientOneTimePatterns)
		self._curUsablePattern = TableUtil.deepCopy(self._totalPatterns)
	else
		self:syncTotalExtraFaces()
	end

	self:syncExtraPatterns()
	self:saveLastExtraFaceInfo()
end

function M:syncExtraPatterns()
	self._totalPatternsBackup = TableUtil.deepCopy(self._totalPatterns)
	self._curUsablePatternBackup = TableUtil.deepCopy(self._curUsablePattern)

	self:syncTotalExtraFaces()
end

function M:getArchivePattern()
	local faces = {}
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.totalFaces ~= nil and #judgeArchive.totalFaces > 0 then
		for k, v in ipairs(judgeArchive.totalFaces) do
			for i = 1, v.num do
				table.insert(faces, RoguelikeUtil.instance:convertSAttrTypeCSType(v.face))
			end
		end
	end

	return faces
end

function M:checkInEffectList(effectId)
	if not self._roleChangeEffect then
		self._roleChangeEffect = {}

		local effectList = RoguelikeConfig.instance:getConstByName("JudgeSelfLoseEffectTypes").numValues

		for k, v in pairs(effectList) do
			self._roleChangeEffect[v] = true
		end
	end

	local effectCo = RoguelikeConfig.instance:getEffectById(effectId)
	local effectSpecialType = effectCo and effectCo.specialType or 0

	return self._roleChangeEffect[effectSpecialType]
end

function M:_onChangeCollector(sender, changes)
	if changes and #changes > 0 then
		local attrType = RoguelikeExtension_pb.AttrType

		for k, v in ipairs(changes) do
			if v.id ~= nil and v.id ~= 0 and self:checkInEffectList(v.id) then
				local heroId = v.heroId
				local count = v.num

				if v.type == attrType.HP then
					self:setCurJudgeRoleChangeValue(heroId, count, nil)
				end

				if v.type == attrType.SAN then
					self:setCurJudgeRoleChangeValue(heroId, nil, count)
				end
			end
		end

		removetimer(self.delaySaveJudgeArchive, self)
		settimer(0.5, self.delaySaveJudgeArchive, self, false)
	end
end

function M:_onJudgeArchive(sender, archive)
	self._judgeCardUseInfos = {}
end

function M:delaySaveJudgeArchive()
	if RogueMgr.instance:isInRogue() then
		local judgeArchive = RoguelikeModel.instance:getJudgeArchive()
		local isJudge = judgeArchive and judgeArchive.isJudged

		if not judgeArchive then
			return
		end

		RogueMgr.instance:getRogueFlow().judgeMgr:saveJudgeArchive(isJudge)
	end
end

function M:clearRoleChange()
	self._isClearRoleChange = true
end

function M:setJudgeCardUse(actionId)
	table.insert(self._judgeCardUseInfos, {
		value = 1,
		id = actionId
	})

	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()
	local isJudge = judgeArchive and judgeArchive.isJudged or false

	RogueMgr.instance:getRogueFlow().judgeMgr:saveJudgeArchive(isJudge)
end

function M:getJudgeCardUseCount(actionId)
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.cardUseInfo then
		for k, v in ipairs(judgeArchive.cardUseInfo) do
			if v.id == actionId then
				return v.value
			end
		end
	end

	return 0
end

function M:getJudgeCardUseInfo()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive == nil then
		self._judgeCardUseInfos = {}
	end

	local result = {}

	for k, v in pairs(self._judgeCardUseInfos) do
		result[v.id] = v.value
	end

	if judgeArchive ~= nil and judgeArchive.cardUseInfo then
		for k, v in ipairs(judgeArchive.cardUseInfo) do
			result[v.id] = result[v.id] and result[v.id] + v.value or v.value
		end
	end

	return result
end

function M:getCurJudgeRoleChangeValue()
	if self._isClearRoleChange then
		self._tempRoleChangeValue = {}
		self._isClearRoleChange = false

		return {}
	end

	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()
	local result = {}

	if judgeArchive == nil then
		self._tempRoleChangeValue = {}
	end

	for k, v in pairs(self._tempRoleChangeValue) do
		result[k] = {}
		result[k].san = v.san
		result[k].hp = v.hp
	end

	self._tempRoleChangeValue = {}

	if judgeArchive ~= nil and judgeArchive.lossValue then
		for k, v in ipairs(judgeArchive.lossValue) do
			result[v.heroId] = result[v.heroId] or {}
			result[v.heroId].san = result[v.heroId].san and result[v.heroId].san + v.san or v.san
			result[v.heroId].hp = result[v.heroId].hp and result[v.heroId].hp + v.hp or v.hp
		end
	end

	return result
end

function M:setCurJudgeRoleChangeValue(heroId, hpChange, sanChange)
	self._tempRoleChangeValue[heroId] = self._tempRoleChangeValue[heroId] or {}

	local hp = self._tempRoleChangeValue[heroId].hp or 0
	local san = self._tempRoleChangeValue[heroId].san or 0

	if hpChange and hpChange < 0 then
		hp = hp + hpChange * -1
	end

	if sanChange and sanChange < 0 then
		san = san + sanChange * -1
	end

	self._tempRoleChangeValue[heroId].hp = hp
	self._tempRoleChangeValue[heroId].san = san
end

function M:getExtraFacesInfo()
	local patterns = self._curUsablePattern or {}
	local curPatterns = {}

	for k, v in pairs(patterns) do
		table.insert(curPatterns, RoguelikeUtil.instance:convertCAttrType2SType(v))
	end

	return curPatterns, self._tempExtraPattersUsed
end

function M:saveLastExtraFaceInfo()
	local extraPattern, usedPatterns = self:getExtraFacesInfo()

	self._lastExtraPattern = TableUtil.deepCopy(extraPattern or {})
	self._lastUsedPatterns = TableUtil.deepCopy(usedPatterns or {})

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)
end

function M:getLastExtraFaceInfo()
	if self._lastExtraPattern == nil then
		self:saveLastExtraFaceInfo()
	end

	return self._lastExtraPattern, self._lastUsedPatterns
end

function M:getTotalExtraFaces()
	local patternsTemp = {}

	for k, v in pairs(self._totalPatterns) do
		table.insert(patternsTemp, RoguelikeUtil.instance:convertCAttrType2SType(v))
	end

	return patternsTemp
end

function M:getClientRoundFaces()
	local patternsTemp = {}

	for k, v in pairs(self._clientRoundPatterns) do
		table.insert(patternsTemp, RoguelikeUtil.instance:convertCAttrType2SType(v))
	end

	return patternsTemp
end

function M:getClientFaces()
	local patternsTemp = {}

	for k, v in pairs(self._clientOneTimePatterns) do
		table.insert(patternsTemp, RoguelikeUtil.instance:convertCAttrType2SType(v))
	end

	return patternsTemp
end

function M:syncTotalExtraFaces()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.totalFaces ~= nil and #judgeArchive.totalFaces > 0 and not self._isRestoreTotal then
		self._totalPatterns = {}

		for k, v in ipairs(judgeArchive.totalFaces) do
			for i = 1, v.num do
				table.insert(self._totalPatterns, RoguelikeUtil.instance:convertSAttrTypeCSType(v.face))
			end
		end

		self._isRestoreTotal = true

		local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()

		if self._tempExtraPattersUsed and #self._tempExtraPattersUsed == 0 then
			self._tempExtraPattersUsed = {}

			local curExtraPatterns = self:getTmpExtraFaces()

			function removeTemp(pattern)
				for k, v in pairs(curExtraPatterns) do
					if v == pattern then
						table.remove(curExtraPatterns, k)

						return true
					end
				end

				return false
			end

			for k, v in pairs(self._totalPatterns) do
				local cPattern = RoguelikeUtil.instance:convertCAttrType2SType(v)

				if not removeTemp(cPattern) then
					table.insert(self._tempExtraPattersUsed, cPattern)
				end
			end
		end
	end
end

function M:getTmpExtraFaces(isCurPattern)
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil then
		if (judgeArchive.entryNext ~= nil and #judgeArchive.entryNext > 0 or judgeArchive.entry ~= nil and #judgeArchive.entry > 0) and not self._isRestore then
			local faces = {}

			self._totalPatterns = {}
			self._curUsablePattern = {}
			self._clientRoundPatterns = {}
			self._clientOneTimePatterns = {}
			self._clientNextCardEntries = {}

			for k, v in ipairs(judgeArchive.entryNext or {}) do
				table.insert(self._clientNextCardEntries, v)
			end

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_CLIENT_ENTRIES_CHANGE)

			self._isRestore = true

			self:syncExtraPatterns()
		end

		if not self._isRestore then
			local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()

			if not isFirst then
				self:restoreUsedPattern()
			end
		end
	end

	local extraPatterns = {}
	local patterns = {}

	if isCurPattern then
		local tempExtraPatterns = self._curUsablePattern or {}

		patterns = TableUtil.addRangeNew(extraPatterns, tempExtraPatterns)
	else
		local tempExtraPatterns = self._curUsablePatternBackup or {}

		patterns = TableUtil.addRangeNew(extraPatterns, tempExtraPatterns)
	end

	local patternsTemp = {}

	for k, v in pairs(patterns) do
		table.insert(patternsTemp, RoguelikeUtil.instance:convertCAttrType2SType(v))
	end

	return patternsTemp, self._tempExtraPattersUsed
end

function M:restoreUsedPattern()
	return
end

function M:getExtraPattern(roleIndex, allocType)
	local extraPatterns = {}
	local tempExtraPatterns = self._curUsablePattern or {}
	local behindCount = RogueMgr.instance:getModel():getBehindActiveRoleCount(roleIndex)

	function getCutPatterns(patterns)
		local t = {}
		local avgCount = behindCount ~= 0 and math.ceil(#patterns / behindCount) or #patterns

		if allocType == 1 then
			local endIndex = #patterns

			function swap(idx1, idx2)
				local t1 = patterns[idx1]

				patterns[idx1] = patterns[idx2]
				patterns[idx2] = t1
			end

			for i = 1, avgCount do
				local t1 = math.random(1, endIndex)

				table.insert(t, patterns[t1])
				swap(t1, endIndex)

				endIndex = endIndex - 1
			end
		elseif allocType == 2 then
			table.sort(patterns, function(a, b)
				local aCalcCount = RoguePredictionUtil.instance:getPatternCalcCount(a)
				local bCalcCount = RoguePredictionUtil.instance:getPatternCalcCount(b)

				return bCalcCount < aCalcCount
			end)

			for i = 1, avgCount do
				table.insert(t, patterns[i])
			end
		elseif allocType == 3 then
			table.sort(patterns, function(a, b)
				local aCalcCount = RoguePredictionUtil.instance:getPatternCalcCount(a)
				local bCalcCount = RoguePredictionUtil.instance:getPatternCalcCount(b)

				return aCalcCount < bCalcCount
			end)

			for i = 1, avgCount do
				table.insert(t, patterns[i])
			end
		end

		return t
	end

	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil then
		if not judgeArchive.isJudged and (judgeArchive.entryNext ~= nil and #judgeArchive.entryNext > 0 or judgeArchive.entry ~= nil and #judgeArchive.entry > 0) and not self._isRestore then
			local faces = {}

			self._totalPatterns = {}
			self._curUsablePattern = {}
			self._clientRoundPatterns = {}
			self._clientOneTimePatterns = {}
			self._clientNextCardEntries = {}

			for k, v in ipairs(judgeArchive.entryNext or {}) do
				table.insert(self._clientNextCardEntries, v)
			end

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_CLIENT_ENTRIES_CHANGE)

			self._isRestore = true

			return getCutPatterns(faces)
		end

		if not self._isRestore then
			local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()

			if not isFirst then
				self:restoreUsedPattern()
			end
		end
	end

	local patterns = TableUtil.addRangeNew(extraPatterns, tempExtraPatterns)

	return getCutPatterns(patterns)
end

function M:removeTempPatternByPattern(pattern)
	function removePattern(list)
		for k, v in ipairs(list or {}) do
			if v == pattern then
				table.remove(list, k)
				table.insert(self._tempExtraPattersUsed, RoguelikeUtil.instance:convertCAttrType2SType(v))

				return true
			end
		end

		return false
	end

	if removePattern(self._curUsablePattern) then
		return true
	end

	return false
end

function M:setRoundIndex(roundIndex)
	self._roundIndex = roundIndex

	RogueBroadcastModel.instance:setRound(roundIndex)

	self._tempExtraPattersUsed = {}
end

function M:addRoundIndex()
	self._tempExtraPattersUsed = {}
	self._totalPatterns = {}

	self:updateExtraPatterns(true)
	self.flow.judgeModel:setRoleDiceWall(0)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_DICE_WALL, 0)

	self._clientRoundPatterns = {}

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BEGIN, self._roundIndex)

	self._roundIndex = self._roundIndex + 1

	RogueBroadcastModel.instance:setRound(self._roundIndex)
end

function M:getRoundIndex()
	return self._roundIndex
end

function M:syncRoundIndex()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive and not judgeArchive.isJudged and RogueMgr.instance:getModel():checkIsLastOne() then
		self._roundIndex = self._roundIndex - 1

		RogueBroadcastModel.instance:setRound(self._roundIndex)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BEGIN, self._roundIndex)
	end
end

function M:addJudgeFailRole(roleIndex)
	for k, v in ipairs(self._judgeFailRoleList) do
		if k == roleIndex then
			return
		end
	end

	table.insert(self._judgeFailRoleList, roleIndex)
end

function M:getJudgeFailRole()
	return self._judgeFailRoleList
end

function M:setAdditionFighting(fighting)
	self._additionFighting = fighting
end

function M:getAdditionFighting()
	return self._additionFighting or 0
end

function M:addDeifyCount()
	self._deifyCount = self._deifyCount or 0
	self._deifyCount = self._deifyCount + 1
end

function M:getAddDeifyCount()
	return self._deifyCount or 0
end

function M:setDeifyCount(count)
	self._deifyCount = count
end

function M:setFixedFighting(fighting)
	self._fixedFighting = fighting
end

function M:getFixedFighting()
	return self._fixedFighting
end

function M:updateRoleInfo(heroNOs)
	for k, v in ipairs(heroNOs) do
		local roleId = v.code

		if RogueMgr.instance:isInRogue() then
			local roleMo = RogueMgr.instance:getModel():getRoleMoByIndex(k)

			if roleMo then
				roleMo:updateByNO(v, k)
			end
		end
	end
end

function M:setEnemyAttack(attack, roleWall)
	self._enemyAttack = attack
	self._roleWall = roleWall
end

function M:getEnemyAttack()
	return self._enemyAttack or 0, self._roleWall
end

function M:setEnemyAttackCallback(callback)
	self._attackCallback = callback
end

function M:execAttackCallback()
	if self._attackCallback then
		self._attackCallback()

		self._attackCallback = nil
	end
end

function M:getEnemyAttackCallback()
	return self._attackCallback
end

function M:addClientNextCardEntry(cardEntryId)
	table.insert(self._clientNextCardEntries, cardEntryId)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CLIENT_ENTRIES_CHANGE)
end

function M:removeClientNextCardEntry(cardEntryId)
	for k, v in pairs(self._clientNextCardEntries) do
		if v == cardEntryId then
			table.remove(self._clientNextCardEntries, k)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_CLIENT_ENTRIES_CHANGE)

			return
		end
	end
end

function M:clearClientNextCardEntry()
	self._clientNextCardEntries = {}
end

function M:getClientNextCardEntries()
	return self._clientNextCardEntries or {}
end

function M:addContinueCardEntries(cardEntryId)
	table.insert(self._clientCardEntries, cardEntryId)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CLIENT_ENTRIES_CHANGE)
end

function M:getContinueEntries()
	return self._clientCardEntries or {}
end

function M:clearClientCardEntry()
	self._clientCardEntries = {}
	self._clientNextCardEntries = {}

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CLIENT_ENTRIES_CHANGE)
end

return M
