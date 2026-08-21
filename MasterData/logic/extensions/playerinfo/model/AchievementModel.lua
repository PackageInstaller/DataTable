-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/AchievementModel.lua

module("logic.extensions.playerinfo.model.AchievementModel", package.seeall)

local M = class("AchievementModel", BaseModel)

function M:ctor()
	self._labelMoList = {}
	self._achievementMoList = {}
	self._achievementSkillMoList = {}
	self._currLevelSkillMoDic = {}
	self._achievementSkillListModel = BaseListModel.New()
	self._rewards = false
end

function M:onInit()
	local allLabelCfgs = AchievementConfig.instance:getAllAchievementLabelCfgs()

	for _, cfg in ipairs(allLabelCfgs) do
		table.insert(self._labelMoList, AchievementLabelMO.New(cfg))
	end

	local allAchievementCfgs = AchievementConfig.instance:getAllAchievementCfgs()

	for _, cfg in ipairs(allAchievementCfgs) do
		table.insert(self._achievementMoList, AchievementMO.New(cfg))
	end

	local achievementSkillLevelCfgs = AchievementConfig.instance:getAchievementSkillLevelCfgs()

	for _, cfg in ipairs(achievementSkillLevelCfgs) do
		local mo = AchievementSkillMO.New(cfg)

		table.insert(self._achievementSkillMoList, mo)

		if not self._currLevelSkillMoDic[mo:getId()] then
			self._currLevelSkillMoDic[mo:getId()] = mo
		end
	end
end

function M:onReset()
	table.clear(self._labelMoList)
	table.clear(self._achievementMoList)
	self._achievementSkillListModel:clear()

	self._achievementSkillMoList = {}
	self._currLevelSkillMoDic = {}
	self._rewards = false

	self:onInit()
end

function M:getLabelMoList()
	local moList = {}

	for _, mo in pairs(self._labelMoList) do
		table.insert(moList, mo)
	end

	table.sort(moList, self._sortLabel)

	return moList
end

function M:getAchievementMoList(skillId)
	local moListFilter = {}

	for i = 1, #self._achievementMoList do
		local mo = self._achievementMoList[i]
		local preTaskFinish = true
		local preTaskId = mo:getPreTask()
		local preTask2Id = mo:getPreTask2()

		if preTaskId ~= 0 then
			local moPre = self:getAchievementMoById(preTaskId)

			preTaskFinish = moPre:getIsFinish()
		elseif preTask2Id ~= 0 then
			local moPre = self:getAchievementMoById(preTask2Id)

			preTaskFinish = moPre:getIsFinish()
		end

		if skillId == mo:getSkillId() and mo:getIsOnline() and preTaskFinish then
			table.insert(moListFilter, mo)
		end
	end

	return moListFilter
end

function M:getAchievementSkillListModel()
	local moList = {}

	for _, mo in pairs(self._labelMoList) do
		table.insert(moList, mo)
	end

	table.sort(moList, self._sortLabel)
	self._achievementSkillListModel:setMoList(moList)

	return self._achievementSkillListModel
end

function M:getAchievementMoById(id)
	for _, achievementMo in ipairs(self._achievementMoList) do
		if achievementMo:getId() == id then
			return achievementMo
		end
	end

	printError("Can't find AchievementMO for id = " .. tostring(id))
end

function M:getSkillLevelMo(id, level, isNext)
	if isNext == true then
		level = level + 1
	elseif isNext == false then
		level = level - 1
	end

	for _, skillMo in ipairs(self._achievementSkillMoList) do
		if skillMo:getId() == id and skillMo:getLevel() == level then
			return skillMo
		end
	end

	return nil
end

function M:getSkillMaxLevel(id)
	local level = 1

	for _, skillMo in ipairs(self._achievementSkillMoList) do
		if skillMo:getId() == id and level < skillMo:getLevel() then
			level = skillMo:getLevel()
		end
	end

	return level
end

function M:getCurrSkillLevelMo(id)
	local mo = self._currLevelSkillMoDic[id]

	if mo then
		return mo
	end

	printError("Can't find _currLevelSkillMoDic for id = ", tostring(id))
end

function M:isGetSkill(id)
	local mo = self._currLevelSkillMoDic[id]

	if mo then
		return mo:getLevel() > 0
	end

	printError("isGetSkill Can't find _currLevelSkillMoDic for id = ", tostring(id))

	return false
end

function M:getSkillLevelMoList()
	local moList = {}

	for k, v in pairs(self._currLevelSkillMoDic) do
		table.insert(moList, v)
	end

	return moList
end

function M:getSkillLevelProfit(id)
	local mo = self:getCurrSkillLevelMo(id)

	if mo:getSkillLevel() == 0 then
		return 0
	end

	local rate = mo:getEffectValue() / 100

	return rate
end

function M:refreshAchievementMoByAgent(datas)
	local lstFromServer = {}

	for _, AchievementNO in ipairs(datas) do
		local achievementMo = self:getAchievementMoById(AchievementNO.id)

		achievementMo:setFinishCnt(AchievementNO.count)
		achievementMo:setIsFinish(AchievementNO.finish)
		achievementMo:setIsOnline(true)

		lstFromServer[AchievementNO.id] = 1
	end

	for _, achievementMo in ipairs(self._achievementMoList or {}) do
		local id = achievementMo:getId()

		if not lstFromServer[id] then
			achievementMo:setIsOnline(false)
		end
	end

	self:_sortAchievementListModel()
end

function M:refreshSingleAchMoByAgent(achievementNOs)
	if #achievementNOs == 0 then
		return
	end

	for _, achievementNO in ipairs(achievementNOs) do
		local achievementMo = self:getAchievementMoById(achievementNO.id)

		achievementMo:setFinishCnt(achievementNO.count)
		achievementMo:setIsFinish(achievementNO.finish)
		achievementMo:setIsOnline(true)
	end

	self:_sortAchievementListModel()
end

function M:updateAchievementSkillInfo(data, isFromUpdate)
	local unLockMoList = {}
	local gradeMoList = {}
	local skillPreExp = {}

	for _, skillNO in ipairs(data) do
		local skillMo = self:getSkillLevelMo(skillNO.skillId, skillNO.level)

		if skillMo then
			local level = self._currLevelSkillMoDic[skillNO.skillId]:getLevel()

			if isFromUpdate then
				local preExp = {
					id = skillMo:getId(),
					preExp = skillMo:getSkillExp()
				}

				table.insert(skillPreExp, preExp)
			end

			skillMo:update(skillNO)

			self._currLevelSkillMoDic[skillNO.skillId] = skillMo

			if isFromUpdate and level ~= skillNO.level then
				if level == 0 then
					table.insert(unLockMoList, skillMo)
				else
					table.insert(gradeMoList, skillMo)
				end
			end
		else
			printError("====skillNO.id ==>", skillNO.skillId, skillNO.level)
		end
	end

	for k, v in pairs(self._labelMoList) do
		local currMo = self._currLevelSkillMoDic[k]

		if currMo then
			v:setSkillLevelMo(currMo)
		end
	end

	self:_setPreExp(skillPreExp)

	local isShowUpgrade = false

	if #unLockMoList > 0 then
		isShowUpgrade = true

		ViewMgr.instance:open(ViewName.AchievementSkillUpgrade, unLockMoList, "unlock")
	end

	if #gradeMoList > 0 then
		isShowUpgrade = true

		ViewMgr.instance:open(ViewName.AchievementSkillUpgrade, gradeMoList, "upgrade")
	end

	if isFromUpdate and not isShowUpgrade then
		local rewards = self:getRewards()

		if rewards then
			GainItemController.instance:openView(rewards)
			self:setRewards(false)
		end
	end
end

function M:_setPreExp(skillPreExp)
	self._preExp = skillPreExp
end

function M:getPreExp()
	return self._preExp or {}
end

local SortIndex = {
	CanJump = 2,
	ReadOnly = 3,
	Done = 10,
	CanGetReward = 1
}

local function _genSortIndex(mo)
	if mo:getIsFinish() then
		return SortIndex.Done
	elseif mo:canGetReward() then
		return SortIndex.CanGetReward
	elseif mo:canJump() then
		return SortIndex.CanJump
	else
		return SortIndex.ReadOnly
	end
end

function M:_sortAchievementListModel()
	local moList = self._achievementMoList

	table.sort(moList, function(mo1, mo2)
		if _genSortIndex(mo1) ~= _genSortIndex(mo2) then
			return _genSortIndex(mo1) < _genSortIndex(mo2)
		elseif mo1:getPriority() ~= mo2:getPriority() then
			return mo1:getPriority() < mo2:getPriority()
		else
			return mo1:getId() < mo2:getId()
		end
	end)
end

function M._sortLabel(mo1, mo2)
	local active1 = mo1:getSkillMo():getLevel() > 0 and 1 or 0
	local active2 = mo2:getSkillMo():getLevel() > 0 and 1 or 0

	if active1 > 0 or active2 > 0 then
		if active1 == active2 then
			return mo1:getId() < mo2:getId()
		end

		return active2 < active1
	end

	return mo1:getId() < mo2:getId()
end

function M:isAchievementPreTaskFinish(achId)
	local curMo = self:getAchievementMoById(achId)

	if not curMo then
		return false
	end

	local preAchTaskId = curMo:getPreTask() or 0

	if preAchTaskId > 0 then
		local preAch = self:getAchievementMoById(preAchTaskId)

		return preAch and preAch:getIsFinish()
	end

	return true
end

function M:setRewards(rewardData)
	self._rewards = rewardData
end

function M:getRewards()
	return self._rewards
end

function M:getHeroUpgradeAchievementSkillFactor()
	local expAddProfile = 0
	local goldConsumeProfile = 0
	local skillMOList = self:getSkillLevelMoList()

	for i, AchievementSkillMO in ipairs(skillMOList) do
		if AchievementSkillMO:getId() == 1 and AchievementSkillMO:getLevel() > 0 then
			expAddProfile = tonumber(AchievementSkillMO:getEffectValue()) / 100
		end

		if AchievementSkillMO:getId() == 6 and AchievementSkillMO:getLevel() > 0 then
			goldConsumeProfile = tonumber(AchievementSkillMO:getEffectValue()) / 100
		end
	end

	return expAddProfile, goldConsumeProfile
end

M.instance = M.New()

return M
