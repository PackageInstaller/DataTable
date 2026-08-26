-- chunkname: @modules/logic/herogroup/model/HeroGroupSnapshotModel.lua

module("modules.logic.herogroup.model.HeroGroupSnapshotModel", package.seeall)

local HeroGroupSnapshotModel = class("HeroGroupSnapshotModel", BaseModel)

function HeroGroupSnapshotModel:onInit()
	self:reInit()
end

function HeroGroupSnapshotModel:reInit()
	self.curSnapshotId = nil
	self.curGroupIds = nil
	self.customSelectDict = {}
end

function HeroGroupSnapshotModel:onReceiveGetHeroGroupSnapshotListReply(info)
	if not info then
		return
	end

	for i = 1, #info.heroGroupSnapshots do
		self:updateHeroGroupSnapshot(info.heroGroupSnapshots[i])
	end
end

function HeroGroupSnapshotModel:updateHeroGroupSnapshot(info)
	local mo = self:getById(info.snapshotId)

	if not mo then
		mo = HeroGroupSnapshotMo.New()

		mo:init(info.snapshotId)
		self:addAtLast(mo)
	end

	mo:updateGroupInfoList(info.heroGroupSnapshots)
	mo:updateSortSubIds(info.sortSubIds)
end

function HeroGroupSnapshotModel:updateSortSubIds(snapshotId, sortSubIds)
	local mo = self:getById(snapshotId)

	return mo and mo:updateSortSubIds(sortSubIds)
end

function HeroGroupSnapshotModel:getSortSubIds(snapshotId)
	local mo = self:getById(snapshotId)

	return mo and mo:getSortSubIds() or {}
end

function HeroGroupSnapshotModel:getHeroGroupSnapshotList(snapshotId)
	local mo = self:getById(snapshotId)

	return mo and mo:getHeroGroupSnapshotList()
end

function HeroGroupSnapshotModel:getHeroGroupInfo(snapshotId, groupId, create)
	local mo = self:getById(snapshotId)

	return mo and mo:getHeroGroupInfo(groupId, create)
end

function HeroGroupSnapshotModel:updateHeroGroupInfo(snapshotId, groupId, info)
	local mo = self:getById(snapshotId)

	return mo and mo:updateGroupInfoByGroupId(info, groupId)
end

function HeroGroupSnapshotModel:removeHeroGroup(snapshotId, groupId)
	local mo = self:getById(snapshotId)

	return mo and mo:removeHeroGroup(groupId)
end

function HeroGroupSnapshotModel:addHeroGroup(snapshotId, groupId, heroMo)
	local mo = self:getById(snapshotId)

	return mo and mo:addHeroGroup(groupId, heroMo)
end

function HeroGroupSnapshotModel:getHeroGroupName(snapshotId, groupId)
	local info = self:getHeroGroupInfo(snapshotId, groupId)

	return info and info.name
end

function HeroGroupSnapshotModel:setHeroGroupName(id, groupId, name)
	local info = self:getHeroGroupInfo(id, groupId)

	if info then
		info.name = name
	end
end

function HeroGroupSnapshotModel:setParam(episodeId)
	local snapshotId, groupIds = HeroGroupHandler.getSnapShot(episodeId)

	self.curSnapshotId = snapshotId
	self.curGroupIds = groupIds
	self.episodeId = episodeId
end

function HeroGroupSnapshotModel:getCurSnapshotId()
	return self.curSnapshotId
end

function HeroGroupSnapshotModel:getCurGroupId(snapshotId, isSurvivalDebug)
	local index = self:getSelectIndex(snapshotId)

	snapshotId = snapshotId or self.curSnapshotId

	if HeroGroupPresetController.snapshotUsePreset(snapshotId) then
		return index
	end

	local v = self.curGroupIds[index]

	if isSurvivalDebug and v == nil then
		v = self.curGroupIds[1] or 1

		local str = ""

		for i, id in ipairs(self.curGroupIds) do
			str = str .. " " .. id
		end

		logError(string.format("雨前漫游 英雄保存报错 index:%s ids:%s", index, str))
	end

	return v
end

function HeroGroupSnapshotModel:getCurGroup()
	local groupId = self:getCurGroupId(self.curSnapshotId)

	return (self:getHeroGroupInfo(self.curSnapshotId, groupId, true))
end

function HeroGroupSnapshotModel:getCurGroupList()
	return (self:getHeroGroupSnapshotList(self.curSnapshotId))
end

function HeroGroupSnapshotModel:setSelectIndex(snapshotId, index)
	snapshotId = snapshotId or self.curSnapshotId

	if snapshotId == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		local episdoeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)

		if episdoeConfig then
			if not episdoeConfig.type then
				local episodeType = 0

				if self.customSelectDict[episodeType] == index then
					return false
				end

				self.customSelectDict[episodeType] = index

				return true
			end
		end
	end

	local mo = self:getById(snapshotId)

	if mo then
		return mo:setSelectIndex(index)
	end
end

function HeroGroupSnapshotModel:getSelectIndex(snapshotId)
	snapshotId = snapshotId or self.curSnapshotId

	if snapshotId == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		local episdoeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)

		if episdoeConfig then
			if not episdoeConfig.type then
				local episodeType = 0

				if self.customSelectDict[episodeType] == nil then
					self.customSelectDict[episodeType] = 1
				end

				local selectIndex = self.customSelectDict[episodeType]

				if HeroGroupPresetController.snapshotUsePreset(snapshotId) then
					selectIndex = HeroGroupPresetHeroGroupSelectIndexController.instance:getSnapshotTypeSelectedIndex(snapshotId, selectIndex)
				end

				return selectIndex
			end
		end
	elseif snapshotId == ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal then
		return 1
	elseif snapshotId == ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss then
		local recordFightParam = TowerComposeModel.instance:getRecordFightParam()

		if recordFightParam then
			return recordFightParam.themeId
		end
	end

	local mo = self:getById(snapshotId)

	if mo then
		return mo:getSelectIndex()
	end
end

function HeroGroupSnapshotModel:getGroupName(groupId)
	groupId = groupId or self:getCurGroupId()

	local info = self:getHeroGroupInfo(self.curSnapshotId, groupId)

	return info and info.name
end

function HeroGroupSnapshotModel:setGroupName(id, groupId, name)
	local info = self:getHeroGroupInfo(id, groupId)

	if info then
		info.name = name
	end
end

HeroGroupSnapshotModel.instance = HeroGroupSnapshotModel.New()

return HeroGroupSnapshotModel
