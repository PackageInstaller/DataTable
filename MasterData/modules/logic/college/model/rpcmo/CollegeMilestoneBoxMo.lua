-- chunkname: @modules/logic/college/model/rpcmo/CollegeMilestoneBoxMo.lua

module("modules.logic.college.model.rpcmo.CollegeMilestoneBoxMo", package.seeall)

local CollegeMilestoneBoxMo = pureTable("CollegeMilestoneBoxMo")

function CollegeMilestoneBoxMo:init(data)
	self.score = data.score
	self.gainId = data.gainId
	self.themes, self.themeMap = GameUtil.rpcInfosToListAndMap(data.theme, CollegeMilestoneThemeMo, "id", self.themeMap)

	for i, v in ipairs(lua_college_story_theme.configList) do
		if not self.themeMap[v.id] then
			local themeMo = CollegeMilestoneThemeMo.New()

			themeMo:init({
				id = v.id
			})
			table.insert(self.themes, themeMo)

			self.themeMap[v.id] = themeMo
		end
	end

	self.readStateId = GameUtil.listToDict(data.readStateId)
	self.lastChainId = {}

	for _, lastChainId in ipairs(data.lastChainId) do
		self:updateLastChainId(lastChainId)
	end
end

function CollegeMilestoneBoxMo:updateLastChainId(chainId)
	local chainCo = lua_college_character_chain.configDict[chainId]

	if chainCo then
		if not chainCo.type then
			local chainType = CollegeEnum.RelationShipBoardPage.Default

			self.lastChainId[chainType] = chainId
		end
	end
end

function CollegeMilestoneBoxMo:updateInfo(theme)
	local newActiveId
	local themeMo = self.themeMap[theme.id]

	if themeMo then
		local len = themeMo:getActiveCount()

		themeMo:init(theme)

		if len < themeMo:getActiveCount() then
			newActiveId = themeMo.activeId[themeMo:getActiveCount()]
		end
	else
		self.themeMap[theme.id] = GameUtil.rpcInfoToMo(theme, CollegeMilestoneThemeMo)

		table.insert(self.themes, self.themeMap[theme.id])

		themeMo = self.themeMap[theme.id]
		newActiveId = self.themeMap[theme.id].activeId[self.themeMap[theme.id]:getActiveCount()]
	end

	return newActiveId
end

function CollegeMilestoneBoxMo:getSceneUnlockNodes()
	local dict = {}

	for i, v in ipairs(self.themes) do
		for vv in pairs(v.locationDict) do
			dict[vv] = lua_college_story_node.configDict[vv]
		end
	end

	return dict
end

function CollegeMilestoneBoxMo:getActiveCount()
	local count = 0

	for i, v in ipairs(self.themes) do
		count = count + v:getActiveCount()
	end

	return count
end

function CollegeMilestoneBoxMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeMilestoneBoxMo" then
		return false
	end

	local isSame = true

	if self.score ~= otherMo.score then
		isSame = false

		logError(string.format("CollegeMilestoneBoxMo compareWith score not same: %s >> %s", self.score, otherMo.score))
	end

	if #self.gainId ~= #otherMo.gainId then
		isSame = false

		logError(string.format("CollegeMilestoneBoxMo compareWith gainId count not same: %s >> %s", #self.gainId, #otherMo.gainId))
	else
		for i = 1, #self.gainId do
			if self.gainId[i] ~= otherMo.gainId[i] then
				isSame = false

				logError(string.format("CollegeMilestoneBoxMo compareWith gainId not same: [%s] %s >> %s", i, self.gainId[i], otherMo.gainId[i]))

				break
			end
		end
	end

	if #self.themes ~= #otherMo.themes then
		isSame = false

		logError(string.format("CollegeMilestoneBoxMo compareWith themes count not same: %s >> %s", #self.themes, #otherMo.themes))
	else
		for i = 1, #self.themes do
			local otherThemeMo = otherMo.themeMap[self.themes[i].id]

			if not otherThemeMo or not self.themes[i]:compareWith(otherThemeMo) then
				isSame = false

				logError(string.format("CollegeMilestoneBoxMo compareWith themes not same: id=%s", self.themes[i].id))

				break
			end
		end
	end

	return isSame
end

function CollegeMilestoneBoxMo:isGainReward(rewardId)
	return tabletool.indexOf(self.gainId, rewardId) ~= nil
end

function CollegeMilestoneBoxMo:getRewardStatus(rewardId)
	local status = CollegeEnum.RewardStatus.None

	if self:isGainReward(rewardId) then
		status = CollegeEnum.RewardStatus.Hasget
	else
		local rewardCo = lua_college_reward.configDict[rewardId]

		if rewardCo and rewardCo.score <= self.score then
			status = CollegeEnum.RewardStatus.Canget
		end
	end

	return status
end

function CollegeMilestoneBoxMo:isAnyStoryUnlock()
	for i, v in ipairs(self.themes) do
		if v:isAnyStoryUnlock() then
			return true
		end
	end

	return false
end

return CollegeMilestoneBoxMo
