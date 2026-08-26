-- chunkname: @modules/logic/season/model/Activity104EquipItemBookModel.lua

module("modules.logic.season.model.Activity104EquipItemBookModel", package.seeall)

local Activity104EquipItemBookModel = class("Activity104EquipItemBookModel", ListScrollModel)

function Activity104EquipItemBookModel:clear()
	Activity104EquipItemBookModel.super.clear(self)

	self.activityId = nil
	self.curSelectItemId = nil
	self._itemMap = nil
	self.recordNew = nil
	self._itemStartAnimTime = nil
	self.tagModel = nil
end

function Activity104EquipItemBookModel:initDatas(activityId)
	self.activityId = activityId
	self.curSelectItemId = nil

	self:initSubModel()
	self:initPlayerPrefs()
	self:initList()
end

function Activity104EquipItemBookModel:initList()
	self:initConfig()
	self:initBackpack()

	if self:getCount() > 0 then
		self:setSelectItemId(self:getByIndex(1).id)
	end
end

function Activity104EquipItemBookModel:initSubModel()
	self.tagModel = Activity104EquipTagModel.New()

	self.tagModel:init(self.activityId)
end

function Activity104EquipItemBookModel:initConfig()
	local list = {}
	local cfgDict = SeasonConfig.instance:getSeasonEquipCos()

	for itemId, cfg in pairs(cfgDict) do
		if not SeasonConfig.instance:getEquipIsOptional(itemId) and not SeasonEquipMetaUtils.isBanActivity(cfg, self.activityId) and self:isCardCanShowByTag(cfg.tag) then
			local listMO = Activity104EquipBookMo.New()

			listMO:init(itemId)
			table.insert(list, listMO)
		end
	end

	self:setList(list)
end

function Activity104EquipItemBookModel:initPlayerPrefs()
	self.recordNew = SeasonEquipLocalRecord.New()

	self.recordNew:init(self.activityId, Activity104Enum.PlayerPrefsKeyItemUid)
end

function Activity104EquipItemBookModel:initBackpack()
	self._itemMap = Activity104Model.instance:getAllItemMo(self.activityId) or {}

	for itemUid, itemMO in pairs(self._itemMap) do
		local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemMO.itemId)

		if itemCO then
			local listMO = self:getById(itemMO.itemId)

			if listMO then
				listMO.count = listMO.count + 1

				if not self.recordNew:contain(itemUid) then
					listMO:setIsNew(true)
				end
			end
		end
	end

	self:sort(Activity104EquipItemBookModel.sortItemMOList)
end

function Activity104EquipItemBookModel:isCardCanShowByTag(itemTags)
	if self.tagModel then
		return self.tagModel:isCardNeedShow(itemTags)
	end

	return true
end

function Activity104EquipItemBookModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	local curTime = Time.time

	if self._itemStartAnimTime == nil then
		self._itemStartAnimTime = curTime + SeasonEquipBookItem.OpenAnimStartTime
	end

	local index = self:getIndex(mo)

	if not index or index > SeasonEquipBookItem.AnimRowCount * SeasonEquipBookItem.ColumnCount then
		return -1
	end

	local delayTime = math.floor((index - 1) / SeasonEquipBookItem.ColumnCount) * SeasonEquipBookItem.OpenAnimTime + SeasonEquipBookItem.OpenAnimStartTime
	local passTime = curTime - self._itemStartAnimTime

	if delayTime < passTime then
		return -1
	else
		return delayTime - passTime
	end
end

function Activity104EquipItemBookModel.sortItemMOList(a, b)
	local hasGainA = a.count > 0
	local hasGainB = b.count > 0

	if hasGainA ~= hasGainB then
		return hasGainA
	end

	local cfgA = SeasonConfig.instance:getSeasonEquipCo(a.id)
	local cfgB = SeasonConfig.instance:getSeasonEquipCo(b.id)

	if cfgA ~= nil and cfgB ~= nil then
		if cfgA.rare ~= cfgB.rare then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.equipId > cfgB.equipId
		end
	else
		return a.id < b.id
	end
end

function Activity104EquipItemBookModel:setSelectItemId(itemId)
	local selectItemMO = self:getById(itemId)

	if selectItemMO then
		self.curSelectItemId = itemId

		selectItemMO:setIsNew(false)
	end
end

function Activity104EquipItemBookModel:checkResetCurSelected()
	if self.curSelectItemId and not self:getById(self.curSelectItemId) then
		self.curSelectItemId = nil
	end
end

function Activity104EquipItemBookModel:flushRecord()
	if self.recordNew then
		self.recordNew:recordAllItem()
	end
end

Activity104EquipItemBookModel.instance = Activity104EquipItemBookModel.New()

return Activity104EquipItemBookModel
