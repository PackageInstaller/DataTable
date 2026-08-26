-- chunkname: @modules/logic/herogrouppreset/controller/HeroGroupPresetHeroGroupChangeController.lua

module("modules.logic.herogrouppreset.controller.HeroGroupPresetHeroGroupChangeController", package.seeall)

local HeroGroupPresetHeroGroupChangeController = class("HeroGroupPresetHeroGroupChangeController", BaseController)

function HeroGroupPresetHeroGroupChangeController:getHeroGroupList(heroGroupType)
	local list = {}

	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local group = HeroGroupModel.instance:getCommonGroupList(i)

			if group then
				table.insert(list, group)
			end
		end

		return list
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local group = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, i)

			if group then
				table.insert(list, group)
			end
		end

		return list
	end

	logError(string.format("HeroGroupPresetHeroGroupChangeController:getHeroGroupList heroGroupType:%s 没有可用的列表", heroGroupType))

	return list
end

function HeroGroupPresetHeroGroupChangeController:removeHeroGroup(heroGroupType, subId)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		HeroGroupModel.instance:removeCommonGroupList(subId)

		return
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		HeroGroupSnapshotModel.instance:removeHeroGroup(snapshotType, subId)
	end
end

function HeroGroupPresetHeroGroupChangeController:updateHeroGroup(snapshotId, subId, groupInfo)
	if snapshotId == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		HeroGroupSnapshotModel.instance:updateHeroGroupInfo(snapshotId, subId, groupInfo)
	end
end

function HeroGroupPresetHeroGroupChangeController:addHeroGroup(heroGroupType, subId, heroGroupMo)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		HeroGroupModel.instance:addCommonGroupList(subId, heroGroupMo)

		return
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		HeroGroupSnapshotModel.instance:addHeroGroup(snapshotType, subId, heroGroupMo)
	end
end

function HeroGroupPresetHeroGroupChangeController:getEmptyHeroGroupId(heroGroupType)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local mo = HeroGroupModel.instance:getCommonGroupList(i)

			if not mo then
				return i
			end
		end
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local group = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, i)

			if not group then
				return i
			end
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupChangeController:getEmptyHeroGroupId heroGroupType:%s 没有可用的索引", heroGroupType))
end

function HeroGroupPresetHeroGroupChangeController:getValidHeroGroupId(heroGroupType, index)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		local mo = HeroGroupModel.instance:getCommonGroupList(index)

		if mo then
			return index
		end

		for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local mo = HeroGroupModel.instance:getCommonGroupList(i)

			if mo then
				return i
			end
		end
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		local group = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, index)

		if group then
			return index
		end

		for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local group = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, i)

			if group then
				return i
			end
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupChangeController:getFirstHeroGroupId heroGroupType:%s 没有可用的索引", heroGroupType))

	return index
end

function HeroGroupPresetHeroGroupChangeController:handleHeroListData(heroGroupType, heroGroupMo)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit then
		HeroGroupHandler.setTowerHeroListData(nil, heroGroupMo)
	end
end

HeroGroupPresetHeroGroupChangeController.instance = HeroGroupPresetHeroGroupChangeController.New()

return HeroGroupPresetHeroGroupChangeController
