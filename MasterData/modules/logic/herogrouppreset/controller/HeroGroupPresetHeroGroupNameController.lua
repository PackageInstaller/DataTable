-- chunkname: @modules/logic/herogrouppreset/controller/HeroGroupPresetHeroGroupNameController.lua

module("modules.logic.herogrouppreset.controller.HeroGroupPresetHeroGroupNameController", package.seeall)

local HeroGroupPresetHeroGroupNameController = class("HeroGroupPresetHeroGroupNameController", BaseController)

function HeroGroupPresetHeroGroupNameController:getName(heroGroupType, subId)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		local heroGroupMo = HeroGroupModel.instance:getCommonGroupList(subId)
		local name = heroGroupMo and heroGroupMo.name

		if string.nilorempty(name) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(subId))
		else
			return name
		end
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		local name = HeroGroupSnapshotModel.instance:getHeroGroupName(snapshotType, subId)

		if string.nilorempty(name) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(subId))
		else
			return name
		end
	end
end

function HeroGroupPresetHeroGroupNameController:setName(subId, name, heroGroupType)
	if heroGroupType == HeroGroupPresetEnum.HeroGroupType.Common then
		local heroGroupMo = HeroGroupModel.instance:getCommonGroupList(subId)

		if heroGroupMo then
			heroGroupMo.name = name
		end
	end

	local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[heroGroupType]

	if snapshotType then
		HeroGroupSnapshotModel.instance:setHeroGroupName(snapshotType, subId, name)
	end
end

HeroGroupPresetHeroGroupNameController.instance = HeroGroupPresetHeroGroupNameController.New()

return HeroGroupPresetHeroGroupNameController
