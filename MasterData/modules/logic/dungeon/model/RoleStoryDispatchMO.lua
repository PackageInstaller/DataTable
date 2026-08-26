-- chunkname: @modules/logic/dungeon/model/RoleStoryDispatchMO.lua

module("modules.logic.dungeon.model.RoleStoryDispatchMO", package.seeall)

local RoleStoryDispatchMO = pureTable("RoleStoryDispatchMO")

function RoleStoryDispatchMO:init(dispatchId, storyId)
	self.id = dispatchId
	self.storyId = storyId
	self.config = RoleStoryConfig.instance:getDispatchConfig(dispatchId)
	self.heroIds = {}
	self.gainReward = false
	self.endTime = 0
end

function RoleStoryDispatchMO:updateInfo(info)
	self.endTime = tonumber(info.endTime)
	self.gainReward = info.gainReward
	self.heroIds = {}

	for i = 1, #info.heroIds do
		self.heroIds[i] = info.heroIds[i]
	end

	self:clearFinishAnimFlag()
	self:clearRefreshAnimFlag()
end

function RoleStoryDispatchMO:updateTime(info)
	self.endTime = tonumber(info.endTime)
end

function RoleStoryDispatchMO:completeDispatch()
	self.gainReward = true

	self:clearRefreshAnimFlag()
end

function RoleStoryDispatchMO:resetDispatch()
	self.endTime = 0
	self.heroIds = {}
end

function RoleStoryDispatchMO:getDispatchState()
	if self.gainReward then
		return RoleStoryEnum.DispatchState.Finish
	end

	if self.endTime > 0 then
		if ServerTime.now() >= self.endTime * 0.001 then
			return RoleStoryEnum.DispatchState.Canget
		else
			return RoleStoryEnum.DispatchState.Dispatching
		end
	end

	local unlockEpisodeId = self.config.unlockEpisodeId

	if unlockEpisodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(unlockEpisodeId) then
		return RoleStoryEnum.DispatchState.Normal
	end

	return RoleStoryEnum.DispatchState.Locked
end

function RoleStoryDispatchMO:getEffectHeros()
	local dict = {}
	local effectCondition = self.config.effectCondition

	if string.nilorempty(effectCondition) then
		return dict
	end

	local arr = GameUtil.splitString2(effectCondition, true)
	local type = arr[1][1]
	local heroConditions = arr[3]

	if type == RoleStoryEnum.EffectConditionType.Heros then
		for _, condition in ipairs(heroConditions) do
			dict[condition] = true
		end
	elseif type == RoleStoryEnum.EffectConditionType.Career then
		local heros = HeroConfig.instance:getHeroesList()
		local careerDict = {}

		for _, condition in ipairs(heroConditions) do
			careerDict[condition] = 1
		end

		for _, heroCfg in ipairs(heros) do
			if careerDict[heroCfg.career] then
				dict[heroCfg.id] = true
			end
		end
	end

	return dict
end

function RoleStoryDispatchMO:isMeetEffectCondition()
	return self:checkHerosMeetEffectCondition(self.heroIds)
end

function RoleStoryDispatchMO:checkHerosMeetEffectCondition(heros)
	local effectCondition = self.config.effectCondition

	if string.nilorempty(effectCondition) then
		return false
	end

	local arr = GameUtil.splitString2(effectCondition, true)
	local type = arr[1][1]

	if not arr[2][1] then
		local count = 0
		local heroConditions = arr[3]

		if type == RoleStoryEnum.EffectConditionType.Heros then
			local meetCount = 0

			for _, hero in ipairs(heros) do
				for _, condition in ipairs(heroConditions) do
					if hero == condition then
						meetCount = meetCount + 1

						break
					end
				end
			end

			return count <= meetCount
		elseif type == RoleStoryEnum.EffectConditionType.Career then
			local meetCount = 0
			local careerDict = {}

			for _, condition in ipairs(heroConditions) do
				careerDict[condition] = 1
			end

			for _, hero in ipairs(heros) do
				local heroCfg = HeroConfig.instance:getHeroCO(hero)

				if careerDict[heroCfg.career] then
					meetCount = meetCount + 1
				end
			end

			return count <= meetCount
		end

		return false
	end
end

function RoleStoryDispatchMO:getEffectAddRewardCount()
	local effect = self.config.effect
	local arr = string.splitToNumber(effect, "_")

	if not arr[2] then
		return (arr[2] - 1) * self.config.scoreReward
	end
end

function RoleStoryDispatchMO:getEffectDelTimeCount()
	local effect = self.config.effect
	local arr = string.splitToNumber(effect, "_")

	return arr[1] or 0
end

function RoleStoryDispatchMO:isNewFinish()
	local state = self:getDispatchState()
	local lastState = self.lastState

	self.lastState = state

	if state == RoleStoryEnum.DispatchState.Canget and lastState == RoleStoryEnum.DispatchState.Dispatching then
		return true
	end
end

function RoleStoryDispatchMO:checkFinishAnimIsPlayed()
	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, self.storyId, self.id)
	local flag = PlayerPrefsHelper.getNumber(key, 0)

	return flag == 1
end

function RoleStoryDispatchMO:clearFinishAnimFlag()
	if self:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
		return
	end

	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, self.storyId, self.id)
	local flag = 0

	PlayerPrefsHelper.setNumber(key, flag)
end

function RoleStoryDispatchMO:setFinishAnimFlag()
	if self:getDispatchState() ~= RoleStoryEnum.DispatchState.Finish then
		return
	end

	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, self.storyId, self.id)
	local flag = 1

	PlayerPrefsHelper.setNumber(key, flag)
end

function RoleStoryDispatchMO:canPlayRefreshAnim()
	if self:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, self.storyId, self.id)
	local flag = PlayerPrefsHelper.getNumber(key, 0)

	return flag == 0
end

function RoleStoryDispatchMO:clearRefreshAnimFlag()
	local state = self:getDispatchState()

	if state == RoleStoryEnum.DispatchState.Finish or state == RoleStoryEnum.DispatchState.Locked then
		local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, self.storyId, self.id)
		local flag = 0

		PlayerPrefsHelper.setNumber(key, flag)
	end
end

function RoleStoryDispatchMO:setRefreshAnimFlag()
	if self:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	local key = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, self.storyId, self.id)
	local flag = 1

	PlayerPrefsHelper.setNumber(key, flag)
end

return RoleStoryDispatchMO
