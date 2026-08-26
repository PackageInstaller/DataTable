-- chunkname: @modules/logic/survival/model/SurvivalOutSideInfoMo.lua

module("modules.logic.survival.model.SurvivalOutSideInfoMo", package.seeall)

local SurvivalOutSideInfoMo = pureTable("SurvivalOutSideInfoMo")

function SurvivalOutSideInfoMo:init(data)
	self.season = data.season
	self.versions = data.versions
	self.inWeek = data.inWeek

	table.sort(self.versions)
	self:refreshDifficulty(data.unlockDifficulty)
	self:refreshDifficultyMod(data.passHardnessMod)

	self.score = data.score
	self.gain = {}

	for i, v in ipairs(data.gain) do
		self.gain[v] = true
	end

	self.currMod = data.currMod
	self.currDay = data.currDay
	self.equipIds = {}

	for i, v in ipairs(data.equipIds) do
		table.insert(self.equipIds, v)
	end

	self.npcIds = {}

	for i, v in ipairs(data.npcId) do
		table.insert(self.npcIds, v)
	end

	self.endIdDict = {}

	for i, v in ipairs(data.endId) do
		self.endIdDict[v] = true
	end

	self.clientData = self.clientData or SurvivalOutSideClientDataMo.New()

	self.clientData:init(data.clientData)

	local handbookBox = data.handbookBox

	SurvivalHandbookModel.instance:setSurvivalHandbookBox(handbookBox)

	self.survivalOutSideRoleMo = self.survivalOutSideRoleMo or SurvivalOutSideRoleMo.New()

	self.survivalOutSideRoleMo:setData(data.roleBox)

	self.survivalOutSideTechMo = self.survivalOutSideTechMo or SurvivalOutSideTechMo.New()

	self.survivalOutSideTechMo:setData(data.outSideTechBox)

	local modBox = data.modBox

	self.unlockDiffIds = modBox.unlockId
	self.newDiffIds = modBox.newIds

	SurvivalStoreModel.instance:setData(data.mall)
end

function SurvivalOutSideInfoMo:refreshDifficulty(difficulty)
	self.difficultyDict = {}

	if not difficulty then
		return
	end

	for i = 1, #difficulty do
		self.difficultyDict[difficulty[i]] = true
	end
end

function SurvivalOutSideInfoMo:refreshDifficultyMod(difficulty)
	self.difficultyModDict = {}

	if not difficulty then
		return
	end

	for i = 1, #difficulty do
		self.difficultyModDict[difficulty[i]] = true
	end
end

function SurvivalOutSideInfoMo:isUnlockDifficultyMod(modId)
	return LuaUtil.tableContains(self.unlockDiffIds, modId)
end

function SurvivalOutSideInfoMo:isPassDifficultyMod(difficulty)
	return self.difficultyModDict[difficulty] or false
end

function SurvivalOutSideInfoMo:isUnlockDifficulty(difficulty)
	return self.difficultyDict[difficulty] or false
end

function SurvivalOutSideInfoMo:isFirstPlay()
	return not self:isPassDifficultyMod(SurvivalConst.FirstPlayDifficulty)
end

function SurvivalOutSideInfoMo:isGainReward(rewardId)
	return self.gain[rewardId]
end

function SurvivalOutSideInfoMo:getScore()
	return self.score
end

function SurvivalOutSideInfoMo:getRewardState(rewardId, rewardScore)
	if self:isGainReward(rewardId) then
		return 2
	end

	if rewardScore <= self:getScore() then
		return 1
	end

	return 0
end

function SurvivalOutSideInfoMo:onGainReward(rewardId)
	if rewardId ~= 0 then
		self.gain[rewardId] = true

		return
	end

	local list = SurvivalConfig.instance:getRewardList()

	for i, v in ipairs(list) do
		if self:getRewardState(v.id, v.score) == 1 then
			self.gain[v.id] = true
		end
	end
end

function SurvivalOutSideInfoMo:getEndId()
	local list = lua_survival_end.configList
	local endIds = {}

	for i, v in ipairs(list) do
		if self.endIdDict[v.id] then
			table.insert(endIds, v)
		end
	end

	table.sort(endIds, SortUtil.tableKeyUpper({
		"order",
		"id"
	}))

	return (endIds[1] or nil) and (endIds[1].id or 0)
end

function SurvivalOutSideInfoMo:isEndUnLock(id)
	for k, _ in pairs(self.endIdDict) do
		if k == id then
			return true
		end
	end
end

function SurvivalOutSideInfoMo:getBootyList()
	local list = {}
	local equipList = self.equipIds
	local npcList = self.npcIds

	for i, v in ipairs(equipList) do
		local mo = SurvivalBagItemMo.New()

		mo:init({
			count = 1,
			id = v
		})

		if mo.co ~= nil then
			table.insert(list, mo)
		end
	end

	for i, v in ipairs(npcList) do
		local mo = SurvivalBagItemMo.New()

		mo:init({
			count = 1,
			id = v
		})

		if mo.co ~= nil then
			table.insert(list, mo)
		end
	end

	return list
end

return SurvivalOutSideInfoMo
