-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightSkillCardMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightSkillCardMo", package.seeall)

local DiceHeroFightSkillCardMo = pureTable("DiceHeroFightSkillCardMo")

function DiceHeroFightSkillCardMo:init(data, curRound)
	self.curSelectUids = self.curSelectUids or {}
	self.skillId = data.skillId
	self.curRoundUse = 0

	for _, roundUseCount in ipairs(data.roundUseCounts) do
		if roundUseCount.round == curRound then
			self.curRoundUse = roundUseCount.count

			break
		end
	end

	self.co = lua_dice_card.configDict[self.skillId]

	if not self.co then
		logError("dice_card配置不存在" .. self.skillId)
	end

	self.matchDiceUids = {}

	if self.matchNums then
		return
	end

	self.matchNums = {}
	self.matchDiceRules = {}

	local patternlist = string.splitToNumber(self.co.patternlist, "#") or {}

	for index, patternId in ipairs(patternlist) do
		local patternCo = lua_dice_pattern.configDict[patternId]

		if not patternCo then
			logError("dice_pattern配置不存在" .. patternId)
		end

		local arr = GameUtil.splitString2(patternCo.patternList, true) or {}

		self.matchNums[index] = ((not self.matchNums[index - 1] or nil) and 0) + #arr

		for _, info in ipairs(arr) do
			table.insert(self.matchDiceRules, info)
		end
	end
end

function DiceHeroFightSkillCardMo:initMatchDices(diceMos, isMixMatch)
	self.curSelectUids = {}

	for index, info in ipairs(self.matchDiceRules) do
		local suit = info[1]
		local point = info[2]
		local suitDict = DiceHeroConfig.instance:getDiceSuitDict(suit)
		local pointDict = DiceHeroConfig.instance:getDicePointDict(point)

		if not suitDict then
			logError("dice_suit配置不存在" .. suit)
		end

		if not pointDict then
			logError("dice_point配置不存在" .. point)
		end

		local list = {}

		for _, diceMo in ipairs(diceMos) do
			if self:isMatchDice(diceMo, suitDict, pointDict, isMixMatch) then
				table.insert(list, diceMo.uid)
			end
		end

		self.matchDiceUids[index] = list
	end
end

function DiceHeroFightSkillCardMo:isMatchDice(diceMo, suitDict, pointDict, isMixMatch)
	if diceMo.deleted or diceMo.status == DiceHeroEnum.DiceStatu.HardLock then
		return false
	end

	if not pointDict[diceMo.num] then
		return false
	end

	local matchSuit = DiceHeroConfig.instance:getDiceSuitDict(diceMo.suitId)

	for suitId in pairs(matchSuit) do
		if suitDict[suitId] then
			return true
		end

		if isMixMatch and suitId == DiceHeroEnum.DiceType.Power then
			return true
		end
	end

	return false
end

function DiceHeroFightSkillCardMo:isMatchMin(isMatchPerfect)
	if #self.matchNums == 0 or #self.matchDiceUids == 0 then
		return true, {}
	end

	local num = self.matchNums[1]
	local indexList = {}
	local lenList = {}
	local curList = {}

	for i = 1, num do
		local len = #self.matchDiceUids[i]

		if len == 0 then
			return false
		end

		lenList[i] = len
		indexList[i] = 1
	end

	local all = {}

	while indexList[1] <= lenList[1] do
		for i = 1, num do
			curList[i] = self.matchDiceUids[i][indexList[i]]
		end

		for i = num, 1, -1 do
			indexList[i] = indexList[i] + 1

			if indexList[i] > lenList[i] and i ~= 1 then
				indexList[i] = 1
			else
				break
			end
		end

		if not self:isRepeat(curList) then
			if isMatchPerfect then
				table.insert(all, curList)

				curList = {}
			else
				return true, curList
			end
		end
	end

	if all[1] then
		if all[2] then
			local diceByUid = DiceHeroFightModel.instance:getGameData().diceBox.dicesByUid

			if self.skillId == 19 then
				local perfectIndex = 1
				local perfectPointMin = math.huge

				for planIndex, plan in ipairs(all) do
					local totalPoint = 0

					for index, uid in ipairs(plan) do
						totalPoint = totalPoint + diceByUid[uid].num
					end

					if totalPoint < perfectPointMin then
						perfectIndex = planIndex
						perfectPointMin = totalPoint
					end
				end

				return true, all[perfectIndex]
			end

			local perfectIndex = 1
			local perfectMatchColor = -1
			local perfectPointMax = 0

			for planIndex, plan in ipairs(all) do
				local matchColorCount = 0
				local totalPoint = 0

				for index, uid in ipairs(plan) do
					local matchSuit = self.matchDiceRules[index][1]
					local useSuit = diceByUid[uid].suitId

					if DiceHeroEnum.BaseDiceSuitDict[matchSuit] and DiceHeroEnum.BaseDiceSuitDict[useSuit] then
						matchColorCount = matchColorCount + 1
					end

					totalPoint = totalPoint + diceByUid[uid].num
				end

				if perfectMatchColor < matchColorCount or matchColorCount == perfectMatchColor and perfectPointMax < totalPoint then
					perfectIndex = planIndex
					perfectMatchColor = matchColorCount
					perfectPointMax = totalPoint
				end
			end

			return true, all[perfectIndex]
		else
			return true, all[1]
		end
	end

	return false
end

function DiceHeroFightSkillCardMo:isRepeat(list)
	for i = 1, #list - 1 do
		for j = i + 1, #list do
			if list[i] == list[j] then
				return true
			end
		end
	end

	return false
end

function DiceHeroFightSkillCardMo:canSelect()
	local isBanCard = DiceHeroFightModel.instance:getGameData().allyHero:isBanSkillCard(self.co.type)

	if isBanCard then
		return false, DiceHeroEnum.CantUseReason.BanSkill
	end

	if self.co.roundLimitCount ~= 0 and self.curRoundUse >= self.co.roundLimitCount then
		return false, DiceHeroEnum.CantUseReason.NoUseCount
	end

	if not self:isMatchMin() then
		return false, DiceHeroEnum.CantUseReason.NoDice
	end

	return true
end

function DiceHeroFightSkillCardMo:addDice(uid)
	for i = 1, #self.matchDiceUids do
		if not self.curSelectUids[i] and tabletool.indexOf(self.matchDiceUids[i], uid) then
			self.curSelectUids[i] = uid

			DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardDiceChange)

			return true
		end
	end

	return false
end

function DiceHeroFightSkillCardMo:getCanUseDiceUidDict()
	local dict = {}

	for i = 1, #self.matchDiceUids do
		if not self.curSelectUids[i] then
			for _, uid in pairs(self.matchDiceUids[i]) do
				dict[uid] = true
			end
		end
	end

	return dict
end

function DiceHeroFightSkillCardMo:removeDice(uid)
	for i = 1, #self.matchDiceUids do
		if self.curSelectUids[i] == uid then
			self.curSelectUids[i] = nil

			self:_refreshDiceIndex()
			DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardDiceChange)

			break
		end
	end
end

function DiceHeroFightSkillCardMo:_refreshDiceIndex()
	local len = #self.matchDiceUids

	while true do
		local isMove = false

		for i = len, 1, -1 do
			if self.curSelectUids[i] then
				for j = 1, i - 1 do
					if not self.curSelectUids[j] and tabletool.indexOf(self.matchDiceUids[j], self.curSelectUids[i]) then
						self.curSelectUids[i], self.curSelectUids[j] = self.curSelectUids[j], self.curSelectUids[i]
						isMove = true

						break
					end
				end
			end
		end

		if not isMove then
			break
		end
	end
end

function DiceHeroFightSkillCardMo:clearSelects()
	self.curSelectUids = {}
end

function DiceHeroFightSkillCardMo:canUse()
	if #self.matchNums == 0 then
		return -1, {}
	end

	local len = 0

	for i = 1, #self.matchDiceUids do
		if not self.curSelectUids[i] then
			break
		end

		len = i
	end

	for i = #self.matchNums, 1, -1 do
		if len >= self.matchNums[i] then
			return i, {
				unpack(self.curSelectUids, 1, self.matchNums[i])
			}
		end
	end

	return false
end

function DiceHeroFightSkillCardMo:clearMatches()
	self.matchDiceUids = {}
end

return DiceHeroFightSkillCardMo
