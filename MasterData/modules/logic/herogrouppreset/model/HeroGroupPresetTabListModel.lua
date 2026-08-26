-- chunkname: @modules/logic/herogrouppreset/model/HeroGroupPresetTabListModel.lua

module("modules.logic.herogrouppreset.model.HeroGroupPresetTabListModel", package.seeall)

local HeroGroupPresetTabListModel = class("HeroGroupPresetTabListModel", ListScrollModel)

function HeroGroupPresetTabListModel:initTabList()
	local list = HeroGroupPresetConfig.instance:getHeroTeamList()

	list = self:_getTargetList(list)
	list = self:_getOnlineList(list)

	self:setList(list)
	self:setSelectedCell(1, true)
end

function HeroGroupPresetTabListModel:_getOnlineList(list)
	local result = {}

	for i, v in ipairs(list) do
		if self:_isUnlock(v.unlockId) and HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[v.id] then
			if v.actType == 0 then
				table.insert(result, v)
			else
				local config = ActivityModel.instance:tryGetFirstOpenedActCOByTypeId(v.actType)

				if config then
					table.insert(result, v)
				end
			end
		end
	end

	return result
end

function HeroGroupPresetTabListModel:_isUnlock(id)
	if id == 0 then
		return true
	end

	return OpenModel.instance:isFunctionUnlock(id)
end

function HeroGroupPresetTabListModel:_getTargetList(list)
	local targetList = HeroGroupPresetController.instance:getHeroGroupTypeList()
	local result = {}

	if targetList then
		for i, v in ipairs(list) do
			if tabletool.indexOf(targetList, v.id) then
				table.insert(result, v)
			end
		end

		return result
	end

	for i, v in ipairs(list) do
		if not HeroGroupPresetEnum.HideInThumbnailHeroGroupType[v.id] then
			table.insert(result, v)
		end
	end

	return result
end

function HeroGroupPresetTabListModel:setSelectedCell(index, value)
	self:selectCell(index, value)

	local mo = self:getByIndex(index)

	HeroGroupPresetItemListModel.instance:initList(mo)
end

HeroGroupPresetTabListModel.instance = HeroGroupPresetTabListModel.New()

return HeroGroupPresetTabListModel
