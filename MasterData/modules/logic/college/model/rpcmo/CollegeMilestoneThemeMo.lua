-- chunkname: @modules/logic/college/model/rpcmo/CollegeMilestoneThemeMo.lua

module("modules.logic.college.model.rpcmo.CollegeMilestoneThemeMo", package.seeall)

local CollegeMilestoneThemeMo = pureTable("CollegeMilestoneThemeMo")

function CollegeMilestoneThemeMo:init(data)
	self.id = data.id
	self.unlockId = data.unlockId or {}
	self.activeId = data.activeId or {}
	self.co = lua_college_story_theme.configDict[self.id]
	self.storyList = CollegeConfig.instance:getStoryListByThemeId(self.id)

	if self.storyList then
		self.storyNum = #self.storyList or 0
	end

	self.unlockCount = 0
	self.unlockDict = {}
	self.locationDict = {}
	self.activeDict = {}

	for _, v in ipairs(self.unlockId) do
		local co = lua_college_story_node.configDict[v]

		if co and co.location > 0 then
			self.locationDict[v] = true
		else
			self.unlockDict[v] = true
			self.unlockCount = self.unlockCount + 1
		end
	end

	for _, v in ipairs(self.activeId) do
		self.activeDict[v] = true
	end
end

function CollegeMilestoneThemeMo:getNodeStatus(id)
	if self.activeDict[id] then
		return CollegeEnum.StoryNodeStatus.Active
	elseif self.unlockDict[id] then
		return CollegeEnum.StoryNodeStatus.Unlocked
	else
		return CollegeEnum.StoryNodeStatus.Locked
	end
end

function CollegeMilestoneThemeMo:getActiveCount()
	return #self.activeId
end

function CollegeMilestoneThemeMo:isAnyStoryUnlock()
	return self.unlockCount > 0
end

function CollegeMilestoneThemeMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeMilestoneThemeMo" then
		return false
	end

	local isSame = true

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeMilestoneThemeMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if #self.unlockId ~= #otherMo.unlockId then
		isSame = false

		logError(string.format("CollegeMilestoneThemeMo compareWith unlockId count not same: %s >> %s", #self.unlockId, #otherMo.unlockId))
	else
		for i = 1, #self.unlockId do
			if self.unlockId[i] ~= otherMo.unlockId[i] then
				isSame = false

				logError(string.format("CollegeMilestoneThemeMo compareWith unlockId not same: [%s] %s >> %s", i, self.unlockId[i], otherMo.unlockId[i]))

				break
			end
		end
	end

	if #self.activeId ~= #otherMo.activeId then
		isSame = false

		logError(string.format("CollegeMilestoneThemeMo compareWith activeId count not same: %s >> %s", #self.activeId, #otherMo.activeId))
	else
		for i = 1, #self.activeId do
			if self.activeId[i] ~= otherMo.activeId[i] then
				isSame = false

				logError(string.format("CollegeMilestoneThemeMo compareWith activeId not same: [%s] %s >> %s", i, self.activeId[i], otherMo.activeId[i]))

				break
			end
		end
	end

	return isSame
end

return CollegeMilestoneThemeMo
