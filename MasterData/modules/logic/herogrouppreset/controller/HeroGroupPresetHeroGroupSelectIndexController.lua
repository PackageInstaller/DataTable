-- chunkname: @modules/logic/herogrouppreset/controller/HeroGroupPresetHeroGroupSelectIndexController.lua

module("modules.logic.herogrouppreset.controller.HeroGroupPresetHeroGroupSelectIndexController", package.seeall)

local HeroGroupPresetHeroGroupSelectIndexController = class("HeroGroupPresetHeroGroupSelectIndexController", BaseController)

function HeroGroupPresetHeroGroupSelectIndexController:getCommonSelectedIndex(id)
	local mo = HeroGroupModel.instance:getCommonGroupList(id)

	if mo then
		return id
	end

	local list = HeroGroupSnapshotModel.instance:getSortSubIds(ModuleEnum.HeroGroupSnapshotType.Common)

	id = list[1] or 1

	local mo = HeroGroupModel.instance:getCommonGroupList(id)

	if mo then
		return id
	end

	for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
		local mo = HeroGroupModel.instance:getCommonGroupList(i)

		if mo then
			return i
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupSelectIndexController:getCommonSelectedIndex id:%s 没有可用的索引", id))
end

function HeroGroupPresetHeroGroupSelectIndexController:getSnapshotTypeSelectedIndex(snapshotType, id)
	local mo = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, id)

	if mo then
		return id
	end

	local list = HeroGroupSnapshotModel.instance:getSortSubIds(snapshotType)

	id = list[1] or 1

	local mo = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, id)

	if mo then
		return id
	end

	for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
		local group = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, i)

		if not group then
			return i
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupSelectIndexController:getSnapshotTypeSelectedIndex snapshotType:%s,id:%s 没有可用的索引", snapshotType, id))
end

HeroGroupPresetHeroGroupSelectIndexController.instance = HeroGroupPresetHeroGroupSelectIndexController.New()

return HeroGroupPresetHeroGroupSelectIndexController
