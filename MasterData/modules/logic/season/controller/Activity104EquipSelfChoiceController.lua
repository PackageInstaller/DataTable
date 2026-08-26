-- chunkname: @modules/logic/season/controller/Activity104EquipSelfChoiceController.lua

module("modules.logic.season.controller.Activity104EquipSelfChoiceController", package.seeall)

local Activity104EquipSelfChoiceController = class("Activity104EquipSelfChoiceController", BaseController)

function Activity104EquipSelfChoiceController:onInit()
	return
end

function Activity104EquipSelfChoiceController:onInitFinish()
	return
end

function Activity104EquipSelfChoiceController:reInit()
	return
end

function Activity104EquipSelfChoiceController:checkOpenParam(actId, costItemUid)
	local allItemMap = Activity104Model.instance:getAllItemMo(actId) or {}
	local itemMO = allItemMap[costItemUid]

	if not itemMO then
		logNormal(string.format("ItemMO not found ! itemUid = [%s]", costItemUid))

		return false
	elseif not SeasonConfig.instance:getEquipIsOptional(itemMO.itemId) then
		logNormal(string.format("it't not optional card! itemUid = [%s], itemId = [%s]", costItemUid, itemMO.itemId))

		return false
	end

	return true
end

function Activity104EquipSelfChoiceController:onOpenView(actId, costUid)
	Activity104SelfChoiceListModel.instance:initDatas(actId, costUid)
end

function Activity104EquipSelfChoiceController:onCloseView()
	Activity104SelfChoiceListModel.instance:clear()
end

function Activity104EquipSelfChoiceController:changeSelectCard(itemId)
	Activity104SelfChoiceListModel.instance:setSelectEquip(itemId)
end

function Activity104EquipSelfChoiceController:sendSelectCard(callback, callbackObj)
	local selectedEquipId = Activity104SelfChoiceListModel.instance.curSelectedItemId
	local actId = Activity104SelfChoiceListModel.instance.activityId
	local costUid = Activity104SelfChoiceListModel.instance.costItemUid

	if selectedEquipId ~= nil then
		Activity104Rpc.instance:sendOptionalActivity104EquipRequest(actId, costUid, selectedEquipId, callback, callbackObj)
	end
end

function Activity104EquipSelfChoiceController:setSelectTag(tagIndex)
	if self:getFilterModel() then
		self:getFilterModel():selectTagIndex(tagIndex)
		Activity104SelfChoiceListModel.instance:initList()
	end
end

function Activity104EquipSelfChoiceController:getFilterModel()
	return Activity104SelfChoiceListModel.instance:getTagModel()
end

Activity104EquipSelfChoiceController.instance = Activity104EquipSelfChoiceController.New()

return Activity104EquipSelfChoiceController
