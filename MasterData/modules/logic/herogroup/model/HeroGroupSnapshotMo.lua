-- chunkname: @modules/logic/herogroup/model/HeroGroupSnapshotMo.lua

module("modules.logic.herogroup.model.HeroGroupSnapshotMo", package.seeall)

local HeroGroupSnapshotMo = pureTable("HeroGroupSnapshotMo")

function HeroGroupSnapshotMo:init(id)
	self.id = id
	self.groupInfoDict = {}
	self.groupInfoList = {}
	self.selectIndex = 1
	self.sortSubIds = {}
end

function HeroGroupSnapshotMo:updateSortSubIds(list)
	local t = {}

	for i, v in ipairs(list) do
		table.insert(t, v)
	end

	self.sortSubIds = t
end

function HeroGroupSnapshotMo:getSortSubIds()
	return self.sortSubIds
end

function HeroGroupSnapshotMo:updateGroupInfoList(list)
	if not list then
		return
	end

	for i = 1, #list do
		self:updateGroupInfo(list[i])
	end
end

function HeroGroupSnapshotMo:updateGroupInfo(info)
	local heroGroupMO = self.groupInfoDict[info.groupId]

	if not heroGroupMO then
		heroGroupMO = HeroGroupMO.New()
		self.groupInfoDict[info.groupId] = heroGroupMO

		table.insert(self.groupInfoList, heroGroupMO)
	end

	heroGroupMO:init(info)
end

function HeroGroupSnapshotMo:updateGroupInfoByGroupId(info, groupId)
	local heroGroupMO = self.groupInfoDict[groupId]

	if heroGroupMO then
		heroGroupMO:init(info)
	else
		logError(string.format("HeroGroupSnapshotMo:updateGroupInfoByGroupId error,groupId = %s", groupId))
	end
end

function HeroGroupSnapshotMo:getHeroGroupSnapshotList()
	return self.groupInfoList
end

function HeroGroupSnapshotMo:getHeroGroupInfo(groupId, create)
	groupId = groupId or 1

	local info = self.groupInfoDict[groupId]

	if info == nil and create then
		info = HeroGroupModel.instance:generateTempGroup(nil, nil, true)
		self.groupInfoDict[groupId] = info
	end

	return info
end

function HeroGroupSnapshotMo:removeHeroGroup(groupId)
	self.groupInfoDict[groupId] = nil
end

function HeroGroupSnapshotMo:addHeroGroup(groupId, mo)
	self.groupInfoDict[groupId] = mo
end

function HeroGroupSnapshotMo:setSelectIndex(index)
	if self.selectIndex == index then
		return
	end

	self.selectIndex = index

	return true
end

function HeroGroupSnapshotMo:getSelectIndex()
	return self.selectIndex
end

return HeroGroupSnapshotMo
