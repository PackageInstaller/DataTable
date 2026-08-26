-- chunkname: @modules/logic/seasonver/act123/controller/Season123EquipBookController.lua

module("modules.logic.seasonver.act123.controller.Season123EquipBookController", package.seeall)

local Season123EquipBookController = class("Season123EquipBookController", BaseController)

function Season123EquipBookController:changeSelect(itemId)
	Season123EquipBookModel.instance:setCurSelectItemId(itemId)
	Season123EquipBookModel.instance:onModelUpdate()
	self:dispatchEvent(Season123Event.OnEquipBookItemChangeSelect)
end

function Season123EquipBookController:setSelectTag(selectTagIndex)
	if Season123EquipBookModel.instance.tagModel then
		Season123EquipBookModel.instance.tagModel:selectTagIndex(selectTagIndex)
		self:handleItemChange()
	end
end

function Season123EquipBookController:handleItemChange()
	local oldSelected = Season123EquipBookModel.instance.curSelectItemId

	Season123EquipBookModel.instance:initList()
	Season123EquipBookModel.instance:setCurSelectItemId(oldSelected)

	if not Season123EquipBookModel.instance.curSelectItemId then
		Season123EquipBookModel.instance:selectFirstCard()
	end

	Season123EquipBookModel.instance:onModelUpdate()
	self:dispatchEvent(Season123Event.OnRefleshEquipBookView)
end

function Season123EquipBookController:onCloseView()
	Season123EquipBookModel.instance:flushRecord()
	Season123EquipBookModel.instance:clear()
	Season123DecomposeModel.instance:release()
	Season123DecomposeModel.instance:clear()
end

function Season123EquipBookController:openBatchDecomposeView(activityId)
	Season123DecomposeModel.instance:initDatas(activityId)
	Season123ViewHelper.openView(activityId, "BatchDecomposeView", {
		actId = activityId
	})
end

function Season123EquipBookController:clearItemSelectState()
	Season123DecomposeModel.instance:clearCurSelectItem()
	self:dispatchEvent(Season123Event.OnRefleshDecomposeItemUI)
end

Season123EquipBookController.instance = Season123EquipBookController.New()

return Season123EquipBookController
