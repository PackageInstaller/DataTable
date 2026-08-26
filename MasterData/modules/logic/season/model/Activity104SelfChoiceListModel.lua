-- chunkname: @modules/logic/season/model/Activity104SelfChoiceListModel.lua

module("modules.logic.season.model.Activity104SelfChoiceListModel", package.seeall)

local Activity104SelfChoiceListModel = class("Activity104SelfChoiceListModel", ListScrollModel)

function Activity104SelfChoiceListModel:clear()
	Activity104SelfChoiceListModel.super.clear(self)

	self.activityId = nil
	self.costItemUid = nil
	self.curSelectedItemId = nil
	self.targetRare = nil
	self.tagModel = nil
end

function Activity104SelfChoiceListModel:initDatas(activityId, costItemUid)
	logNormal("Activity104SelfChoiceListModel initDatas")
	self:clear()

	self.activityId = activityId
	self.costItemUid = costItemUid
	self.curSelectedItemId = nil

	local allItemMap = Activity104Model.instance:getAllItemMo(self.activityId)
	local itemCo = SeasonConfig.instance:getSeasonEquipCo(allItemMap[self.costItemUid].itemId)

	self.itemId = itemCo.equipId
	self.targetRare = itemCo.rare

	self:initList()
end

function Activity104SelfChoiceListModel:initList()
	self.curSelectedItemId = nil

	local list = SeasonConfig.instance:getEquipCoByCondition(Activity104SelfChoiceListModel.filterSameRare)
	local moList = {}

	for _, cfg in ipairs(list) do
		local mo = Activity104SelfChoiceMo.New()

		mo:init(cfg)
		table.insert(moList, mo)

		self.curSelectedItemId = self.curSelectedItemId or cfg.equipId
	end

	self:setList(moList)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectSelfChoiceCard, self.curSelectedItemId)
end

function Activity104SelfChoiceListModel.filterSameRare(cfg)
	if cfg.rare == Activity104SelfChoiceListModel.instance.targetRare and not SeasonConfig.instance:getEquipIsOptional(cfg.equipId) and not SeasonEquipMetaUtils.isBanActivity(cfg, Activity104SelfChoiceListModel.instance.activityId) and Activity104SelfChoiceListModel.instance:isCardCanShowByTag(cfg.tag) then
		return true
	end

	return false
end

function Activity104SelfChoiceListModel:setSelectEquip(itemId)
	self.curSelectedItemId = itemId

	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectSelfChoiceCard, itemId)
	self:onModelUpdate()
end

function Activity104SelfChoiceListModel:initSubModel()
	self.tagModel = Activity104EquipTagModel.New()

	self.tagModel:init(self.activityId)
end

function Activity104SelfChoiceListModel:isCardCanShowByTag(itemTags)
	return self:getTagModel():isCardNeedShow(itemTags)
end

function Activity104SelfChoiceListModel:getTagModel()
	if not self.tagModel then
		self:initSubModel()
	end

	return self.tagModel
end

Activity104SelfChoiceListModel.instance = Activity104SelfChoiceListModel.New()

return Activity104SelfChoiceListModel
