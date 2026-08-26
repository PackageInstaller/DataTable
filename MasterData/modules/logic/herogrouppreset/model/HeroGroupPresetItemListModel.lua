-- chunkname: @modules/logic/herogrouppreset/model/HeroGroupPresetItemListModel.lua

module("modules.logic.herogrouppreset.model.HeroGroupPresetItemListModel", package.seeall)

local HeroGroupPresetItemListModel = class("HeroGroupPresetItemListModel", ListScrollModel)

HeroGroupPresetItemListModel.instance = HeroGroupPresetItemListModel.New()

function HeroGroupPresetItemListModel:initList(mo)
	self._heroItem = mo
	self._heroGroupNum = 0

	self:clearInfo()
	self:updateList()
end

function HeroGroupPresetItemListModel:updateList()
	local list = self:_getHeroGroupList(self._heroItem)
	local sortList = self:_getSortList(list)

	self:_sortList(list, sortList)

	self._heroGroupNum = #list

	if #list < HeroGroupPresetEnum.MaxNum then
		local heroGroup = HeroGroupMO.New()

		heroGroup.__isAdd = true

		table.insert(list, heroGroup)
	end

	self:setList(list)
end

function HeroGroupPresetItemListModel:_sortList(list, sortList)
	table.sort(list, function(a, b)
		local aIndex = tabletool.indexOf(sortList, a.id) or HeroGroupPresetEnum.MaxNum
		local bIndex = tabletool.indexOf(sortList, b.id) or HeroGroupPresetEnum.MaxNum

		return aIndex < bIndex
	end)
end

function HeroGroupPresetItemListModel:_getSortList(list)
	local sortList = HeroGroupSnapshotModel.instance:getSortSubIds(self._heroItem.id)

	if #sortList ~= #list then
		for i, v in ipairs(list) do
			if not tabletool.indexOf(sortList, v.id) then
				table.insert(sortList, v.id)
			end
		end
	end

	return sortList
end

function HeroGroupPresetItemListModel:_getHeroGroupList(mo)
	return HeroGroupPresetController.instance:getHeroGroupCopyList(self._heroItem.id) or HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(self._heroItem.id)
end

function HeroGroupPresetItemListModel:getHeroNum()
	return self._heroItem.batNum + self._heroItem.supNum
end

function HeroGroupPresetItemListModel:getHeroGroupSnapshotType()
	return self._heroItem.id
end

function HeroGroupPresetItemListModel:setHeroGroupSnapshotSubId(id)
	self._subId = id
end

function HeroGroupPresetItemListModel:getHeroGroupSnapshotSubId()
	return self._subId
end

function HeroGroupPresetItemListModel:setEditHeroGroupSnapshotSubId(id)
	self._editHeroGroupSnapshotSubId = id
end

function HeroGroupPresetItemListModel:getEditHeroGroupSnapshotSubId()
	return self._editHeroGroupSnapshotSubId
end

function HeroGroupPresetItemListModel:showDeleteBtn()
	return self._heroGroupNum > self._heroItem.minNum
end

function HeroGroupPresetItemListModel:setNewHeroGroupInfo(heroGroupType, subId)
	self._newHeroGroupType = heroGroupType
	self._newHeroGroupSubId = subId
end

function HeroGroupPresetItemListModel:getNewHeroGroupInfo()
	return self._newHeroGroupType, self._newHeroGroupSubId
end

function HeroGroupPresetItemListModel:setTopHeroGroupId(groupId, subId)
	self._topHeroGroupId = groupId
	self._subId = subId
end

function HeroGroupPresetItemListModel:getTopHeroGroupId()
	return self._topHeroGroupId, self._subId
end

function HeroGroupPresetItemListModel:getReplaceTeamSubId(replaceTeamList)
	if not replaceTeamList then
		return
	end

	local list = self:getList()

	for _, team in ipairs(list) do
		if self:_isSameHeroGroup(replaceTeamList, team.heroList) then
			return team.id
		end
	end

	return -1
end

function HeroGroupPresetItemListModel:_isSameHeroGroup(replaceTeamList, heroList)
	if #replaceTeamList ~= #heroList then
		return
	end

	for i, heroMo in ipairs(replaceTeamList) do
		if heroMo.heroUid ~= heroList[i] then
			return
		end
	end

	return true
end

function HeroGroupPresetItemListModel:clearInfo()
	self:setNewHeroGroupInfo()
	self:setTopHeroGroupId()
	self:setEditHeroGroupSnapshotSubId()
end

return HeroGroupPresetItemListModel
