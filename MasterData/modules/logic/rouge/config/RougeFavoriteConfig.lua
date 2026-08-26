-- chunkname: @modules/logic/rouge/config/RougeFavoriteConfig.lua

module("modules.logic.rouge.config.RougeFavoriteConfig", package.seeall)

local RougeFavoriteConfig = class("RougeFavoriteConfig", BaseConfig)

function RougeFavoriteConfig:reqConfigNames()
	return {
		"rouge_story_list",
		"rouge_illustration_list"
	}
end

function RougeFavoriteConfig:onInit()
	return
end

function RougeFavoriteConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge_story_list" then
		self:_initStoryList()
	elseif configName == "rouge_illustration_list" then
		self:_initIllustrationList()
	end
end

function RougeFavoriteConfig:_initIllustrationList()
	self._illustrationList = {}
	self._illustrationPages = {}
	self._normalIllustrationPageCount = 0
	self._dlcIllustrationPageCount = 0

	local list = {}

	for _, v in ipairs(lua_rouge_illustration_list.configList) do
		table.insert(list, v)
	end

	table.sort(list, RougeFavoriteConfig._sortIllustration)

	local usePageIndex = 0

	for i, v in ipairs(list) do
		local page = self._illustrationPages[usePageIndex]

		if page then
			if not #page then
				local illustrationCount = 0
				local isFull = illustrationCount >= RougeEnum.IllustrationNumOfPage
				local lastIllustration = page and page[illustrationCount]
				local lastIllustrationCo = lastIllustration and lastIllustration.config
				local isPageDLC = self:isDLCIllustration(lastIllustrationCo)
				local isDLC = self:isDLCIllustration(v)
				local isSameType = isPageDLC == isDLC

				if not page or not isSameType or isFull then
					usePageIndex = usePageIndex + 1
					self._illustrationPages[usePageIndex] = {}

					if isDLC then
						self._dlcIllustrationPageCount = self._dlcIllustrationPageCount + 1
					else
						self._normalIllustrationPageCount = self._normalIllustrationPageCount + 1
					end
				end

				local eventIdList = string.splitToNumber(v.eventId, "|")
				local mo = {
					config = v,
					eventIdList = eventIdList
				}

				table.insert(self._illustrationPages[usePageIndex], mo)
				table.insert(self._illustrationList, mo)
			end
		end
	end
end

function RougeFavoriteConfig._sortIllustration(a, b)
	local isADLC = RougeFavoriteConfig.instance:isDLCIllustration(a)
	local isBDLC = RougeFavoriteConfig.instance:isDLCIllustration(b)

	if isADLC ~= isBDLC then
		return not isADLC
	end

	if a.order ~= b.order then
		return a.order > b.order
	end

	return a.id < b.id
end

function RougeFavoriteConfig:isDLCIllustration(illustrationCo)
	return illustrationCo and illustrationCo.dlc == 1
end

function RougeFavoriteConfig:getIllustrationList()
	return self._illustrationList
end

function RougeFavoriteConfig:getIllustrationPages()
	return self._illustrationPages
end

function RougeFavoriteConfig:getNormalIllustrationPageCount()
	return self._normalIllustrationPageCount
end

function RougeFavoriteConfig:getDLCIllustationPageCount()
	return self._dlcIllustrationPageCount
end

function RougeFavoriteConfig:_initStoryList()
	local list = {}

	for _, v in ipairs(lua_rouge_story_list.configList) do
		table.insert(list, v)
	end

	table.sort(list, RougeFavoriteConfig._sortStory)

	self._storyList = {}
	self._storyMap = {}

	for i, v in ipairs(list) do
		local t = {}

		t.index = i
		t.config = v
		t.storyIdList = string.splitToNumber(v.storyIdList, "#")

		table.insert(self._storyList, t)

		local storyId = t.storyIdList[#t.storyIdList]

		self._storyMap[storyId] = true
	end
end

function RougeFavoriteConfig._sortStory(a, b)
	if a.stageId ~= b.stageId then
		return a.stageId < b.stageId
	end

	return a.id < b.id
end

function RougeFavoriteConfig:getStoryList()
	return self._storyList
end

function RougeFavoriteConfig:inRougeStoryList(storyId)
	return self._storyMap and self._storyMap[storyId]
end

RougeFavoriteConfig.instance = RougeFavoriteConfig.New()

return RougeFavoriteConfig
