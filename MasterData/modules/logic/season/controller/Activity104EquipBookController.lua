-- chunkname: @modules/logic/season/controller/Activity104EquipBookController.lua

module("modules.logic.season.controller.Activity104EquipBookController", package.seeall)

local Activity104EquipBookController = class("Activity104EquipBookController", BaseController)

function Activity104EquipBookController:onOpenView(actId)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, self.handleItemChanged, self)
	Activity104EquipItemBookModel.instance:initDatas(actId)
end

function Activity104EquipBookController:onCloseView()
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, self.handleItemChanged, self)
	Activity104EquipItemBookModel.instance:flushRecord()
	Activity104Controller.instance:dispatchEvent(Activity104Event.OnPlayerPrefNewUpdate)
	Activity104EquipItemBookModel.instance:clear()
end

function Activity104EquipBookController:changeSelect(itemId)
	Activity104EquipItemBookModel.instance:setSelectItemId(itemId)
	Activity104EquipItemBookModel.instance:onModelUpdate()
	self:dispatchEvent(Activity104Event.OnBookChangeSelectNotify)
end

function Activity104EquipBookController:handleItemChanged()
	local oldSelected = Activity104EquipItemBookModel.instance.curSelectItemId

	Activity104EquipItemBookModel.instance:initList()
	Activity104EquipItemBookModel.instance:setSelectItemId(oldSelected)
	self:notifyUpdateView()
end

function Activity104EquipBookController:notifyUpdateView()
	Activity104EquipItemBookModel.instance:onModelUpdate()
	self:dispatchEvent(Activity104Event.OnBookUpdateNotify)
end

function Activity104EquipBookController:setSelectTag(tagIndex)
	if Activity104EquipItemBookModel.instance.tagModel then
		Activity104EquipItemBookModel.instance.tagModel:selectTagIndex(tagIndex)
		self:handleItemChanged()
	end
end

function Activity104EquipBookController:getFilterModel()
	return Activity104EquipItemBookModel.instance.tagModel
end

Activity104EquipBookController.instance = Activity104EquipBookController.New()

LuaEventSystem.addEventMechanism(Activity104EquipBookController.instance)

return Activity104EquipBookController
