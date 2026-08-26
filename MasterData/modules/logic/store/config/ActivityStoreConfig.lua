-- chunkname: @modules/logic/store/config/ActivityStoreConfig.lua

module("modules.logic.store.config.ActivityStoreConfig", package.seeall)

local ActivityStoreConfig = class("ActivityStoreConfig", BaseConfig)

function ActivityStoreConfig:reqConfigNames()
	return {
		"activity107",
		"activity107_bubble_group",
		"activity107_bubble_talk",
		"activity107_bubble_talk_step"
	}
end

function ActivityStoreConfig:onInit()
	self.activityStoreGroupConfigDict = nil
end

function ActivityStoreConfig:onConfigLoaded(configName, configTable)
	if configName == "activity107" then
		self:initActivityStoreGroupConfig()
	elseif configName == "activity107_bubble_group" then
		self:initBubbleConfig()
	elseif configName == "activity107_bubble_talk" then
		self:initBubbleTalkConfig()
	end
end

function ActivityStoreConfig:initActivityStoreGroupConfig()
	self._skin2ActivityIdDict = {}
	self.activityStoreGroupConfigDict = {}

	local groupList, actStoreDict

	for _, storeCo in ipairs(lua_activity107.configList) do
		actStoreDict = self.activityStoreGroupConfigDict[storeCo.activityId]

		if not self.activityStoreGroupConfigDict[storeCo.activityId] then
			actStoreDict = {}
			self.activityStoreGroupConfigDict[storeCo.activityId] = actStoreDict
		end

		groupList = actStoreDict[storeCo.group]

		if not actStoreDict[storeCo.group] then
			groupList = {}
			actStoreDict[storeCo.group] = groupList
		end

		table.insert(groupList, storeCo)

		local arr = string.splitToNumber(storeCo.product, "#")
		local type, id = arr[1], arr[2]

		if type == MaterialEnum.MaterialType.HeroSkin then
			self._skin2ActivityIdDict[id] = storeCo.activityId
		end
	end
end

function ActivityStoreConfig:initBubbleConfig()
	self.actId2GroupList = {}

	for _, groupCo in ipairs(lua_activity107_bubble_group.configList) do
		local list = self.actId2GroupList[groupCo.actId]

		if not list then
			list = {}
			self.actId2GroupList[groupCo.actId] = list
		end

		table.insert(list, groupCo)
	end
end

function ActivityStoreConfig:initBubbleTalkConfig()
	self.groupId2TalkList = {}

	local metaTable = {}

	function metaTable.__index(t, key)
		local value = rawget(t, key)

		if not value then
			local srcCo = rawget(t, "_srcCo")

			value = srcCo[key]
		end

		return value
	end

	for _, talkCo in ipairs(lua_activity107_bubble_talk.configList) do
		local list = self.groupId2TalkList[talkCo.groupId]

		if not list then
			list = {}
			self.groupId2TalkList[talkCo.groupId] = list
		end

		local newTalkCo = {}
		local arr = string.splitToNumber(talkCo.condition, "#")

		newTalkCo._srcCo = talkCo
		newTalkCo.triggerType = arr[1]

		if arr[2] then
			table.remove(arr, 1)

			newTalkCo.triggerParam = arr
		end

		setmetatable(newTalkCo, metaTable)
		table.insert(list, newTalkCo)
	end
end

function ActivityStoreConfig:getActivityStoreGroupDict(actId)
	return self.activityStoreGroupConfigDict[actId]
end

function ActivityStoreConfig:getStoreConfig(actId, id)
	local dict = lua_activity107.configDict[actId]

	return dict and dict[id]
end

ActivityStoreConfig.TagEnum = {
	TimeLimit = 1
}

function ActivityStoreConfig:initTag()
	if self.tagDict then
		return
	end

	self.tagDict = {
		[ActivityStoreConfig.TagEnum.TimeLimit] = "versionactivity_store_goods_tag_1"
	}
end

function ActivityStoreConfig:getTagName(tag)
	self:initTag()

	local key = self.tagDict[tag]

	if string.nilorempty(key) then
		return ""
	end

	return luaLang(key)
end

function ActivityStoreConfig:getTalkGroupList(actId)
	return self.actId2GroupList[actId]
end

function ActivityStoreConfig:getUnlockGroupList(actId)
	local groupList = self:getTalkGroupList(actId)
	local result = {}

	for _, groupCo in ipairs(groupList) do
		local episodeId = groupCo.unlockCondition

		if episodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(episodeId) then
			table.insert(result, groupCo)
		end
	end

	return result
end

function ActivityStoreConfig:getGroupTalkCoList(groupId)
	return self.groupId2TalkList[groupId]
end

ActivityStoreConfig.BubbleTalkTriggerType = {
	ClickStageArea = 2,
	BuyGoodsById = 5,
	SellOutGoodsByRare = 4,
	BuyGoodsByRare = 3,
	EnterActivityStore = 1,
	FirstEnterActivityStore = 7,
	SellOutGoodsById = 6,
	None = 0
}

function ActivityStoreConfig:checkTalkCanTrigger(actId, talkCo, typeParam)
	self:initTypeCheckHandle()

	local type = talkCo.triggerType
	local handle = self.typeHandle[type]

	if not handle then
		return true
	end

	return handle(self, actId, talkCo, typeParam)
end

function ActivityStoreConfig:initTypeCheckHandle()
	self.typeHandle = self.typeHandle or {
		[ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsByRare] = self.checkGoodsRareHandle,
		[ActivityStoreConfig.BubbleTalkTriggerType.BuyGoodsById] = self.checkGoodsIdHandle,
		[ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsByRare] = self.checkGoodsRareHandle,
		[ActivityStoreConfig.BubbleTalkTriggerType.SellOutGoodsById] = self.checkGoodsIdHandle
	}
end

function ActivityStoreConfig:checkGoodsRareHandle(actId, talkCo, goodsId)
	local paramList = talkCo.triggerParam

	if not paramList then
		logError("type param is nil, talkId : " .. tostring(talkCo.id))

		return false
	end

	local goodsCo = lua_activity107.configDict[actId][goodsId]
	local arr = string.splitToNumber(goodsCo.product, "#")
	local type, id = arr[1], arr[2]
	local productCo = ItemConfig.instance:getItemConfig(type, id)

	return tabletool.indexOf(paramList, productCo.rare)
end

function ActivityStoreConfig:checkGoodsIdHandle(actId, talkCo, goodsId)
	local paramList = talkCo.triggerParam

	if not paramList then
		logError("type param is nil, talkId : " .. tostring(talkCo.id))

		return false
	end

	return tabletool.indexOf(paramList, goodsId)
end

function ActivityStoreConfig:getSkinApproachActivity(skinId)
	if self._skin2ActivityIdDict and self._skin2ActivityIdDict[skinId] then
		return self._skin2ActivityIdDict[skinId]
	end

	return -1
end

ActivityStoreConfig.instance = ActivityStoreConfig.New()

return ActivityStoreConfig
