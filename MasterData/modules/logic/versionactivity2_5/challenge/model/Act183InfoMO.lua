-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183InfoMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183InfoMO", package.seeall)

local Act183InfoMO = pureTable("Act183InfoMO")

function Act183InfoMO:init(info)
	self:_onGetGroupListInfo(info.groupList)
	self:_onGetBadgeNum(info.badgeNum)

	self._params = info.params
end

function Act183InfoMO:_onGetGroupListInfo(groupList)
	self._groupList = {}
	self._groupMap = {}
	self._groupTypeMap = {}

	for _, groupInfo in ipairs(groupList) do
		local groupMo = Act183GroupEpisodeMO.New()

		groupMo:init(groupInfo)
		table.insert(self._groupList, groupMo)

		local groupId = groupMo:getGroupId()

		self._groupMap[groupId] = groupMo

		local groupType = groupMo:getGroupType()

		self._groupTypeMap[groupType] = self._groupTypeMap[groupType] or {}

		table.insert(self._groupTypeMap[groupType], groupMo)
	end

	table.sort(self._groupList, self._sortGroupMoById)

	for _, typeGroupMos in pairs(self._groupTypeMap) do
		table.sort(typeGroupMos, self._sortGroupMoById)
	end
end

function Act183InfoMO._sortGroupMoById(aGroupMo, bGroupMo)
	local aGroupId = aGroupMo:getGroupId()
	local bGroupId = bGroupMo:getGroupId()

	return aGroupId < bGroupId
end

function Act183InfoMO:_onGetBadgeNum(badgeNum)
	self._badgeNum = badgeNum or 0
	self._unlockSupportHeros = {}
	self._unlockSupportHeroIds = {}

	local activityId = Act183Model.instance:getActivityId()
	local unlockHeroIds = Act183Helper.getUnlockSupportHeroIds(activityId, badgeNum)

	for _, unlockSupportHeroId in ipairs(unlockHeroIds) do
		local heroMo = HeroMo.New()

		heroMo:initFromTrial(unlockSupportHeroId)
		table.insert(self._unlockSupportHeros, heroMo)
		table.insert(self._unlockSupportHeroIds, unlockSupportHeroId)
	end
end

function Act183InfoMO:getGroupEpisodes()
	return self._groupList
end

function Act183InfoMO:getBadgeNum()
	return self._badgeNum
end

function Act183InfoMO:updateBadgeNum(newBadgeNum)
	self:_onGetBadgeNum(newBadgeNum)
end

function Act183InfoMO:getGroupEpisodeMos(typeId)
	return self._groupTypeMap[typeId]
end

function Act183InfoMO:getGroupEpisodeMo(groupId)
	if groupId then
		return self._groupMap and self._groupMap[groupId]
	end
end

function Act183InfoMO:getUnlockSupportHeros()
	return self._unlockSupportHeros
end

function Act183InfoMO:getUnlockSupportHeroIds()
	return self._unlockSupportHeroIds
end

function Act183InfoMO:updateGroupMo(groupInfo)
	local groupMo = Act183GroupEpisodeMO.New()

	groupMo:init(groupInfo)

	local groupId = groupMo:getGroupId()
	local groupMo = self:getGroupEpisodeMo(groupId)

	if groupMo then
		groupMo:init(groupInfo)
	end

	return groupMo
end

return Act183InfoMO
