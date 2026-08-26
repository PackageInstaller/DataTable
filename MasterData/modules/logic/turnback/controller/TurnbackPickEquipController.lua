-- chunkname: @modules/logic/turnback/controller/TurnbackPickEquipController.lua

module("modules.logic.turnback.controller.TurnbackPickEquipController", package.seeall)

local TurnbackPickEquipController = class("TurnbackPickEquipController", BaseController)

function TurnbackPickEquipController:onInit()
	self._pickHandler = nil
	self._pickHandlerObj = nil
	self._showMsgBoxFunc = nil
	self._showMsgBoxFuncObj = nil
	self._tmpViewParam = nil
end

function TurnbackPickEquipController:onInitFinish()
	return
end

function TurnbackPickEquipController:addConstEvents()
	return
end

function TurnbackPickEquipController:reInit()
	self:onInit()
end

function TurnbackPickEquipController:openTurnbackPickEquipView(bePickChoiceEquipIdList, pickHandler, pickHandlerObj, viewParam, showMsgBoxFunc, showMsgBoxFuncObj, maxSelectCount)
	self._pickHandler = pickHandler
	self._pickHandlerObj = pickHandlerObj
	self._showMsgBoxFunc = showMsgBoxFunc
	self._showMsgBoxFuncObj = showMsgBoxFuncObj

	TurnbackPickEquipListModel.instance:initData(bePickChoiceEquipIdList, maxSelectCount)
	ViewMgr.instance:openView(ViewName.TurnbackPickEquipView, viewParam)
end

function TurnbackPickEquipController:onOpenView()
	self:dispatchEvent(TurnbackEvent.onCustomPickListChanged)
end

function TurnbackPickEquipController:setSelect(equipId)
	local isSelected = TurnbackPickEquipListModel.instance:isEquipIdSelected(equipId)
	local selectCount = TurnbackPickEquipListModel.instance:getSelectCount()
	local maxSelectCount = TurnbackPickEquipListModel.instance:getMaxSelectCount()

	if not isSelected and maxSelectCount <= selectCount then
		if maxSelectCount > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			TurnbackPickEquipListModel.instance:clearAllSelect()
		end
	end

	TurnbackPickEquipListModel.instance:setSelectId(equipId)
	self:dispatchEvent(TurnbackEvent.onCustomPickListChanged)
end

function TurnbackPickEquipController:tryChoice(viewParam)
	self._tmpViewParam = viewParam

	if TurnbackPickEquipListModel.instance:checkAllLimit() then
		self:realChoiceWithAllGet()
	else
		local maxSelectCount = TurnbackPickEquipListModel.instance:getMaxSelectCount()
		local selectCount = TurnbackPickEquipListModel.instance:getSelectCount()

		if not selectCount or maxSelectCount < selectCount then
			return false
		end

		if selectCount < maxSelectCount then
			GameFacade.showToast(ToastEnum.NoChoiceHero)

			return false
		end

		self:realChoice()
	end
end

function TurnbackPickEquipController:realChoiceWithAllGet()
	if not self._pickHandler then
		return
	end

	local selectList = {
		99999
	}

	self._pickHandler(self._pickHandlerObj, self._tmpViewParam, selectList)

	self._tmpViewParam = nil
end

function TurnbackPickEquipController:realChoice()
	if not self._pickHandler then
		return
	end

	local selectList = TurnbackPickEquipListModel.instance:getSelectIds()

	self._pickHandler(self._pickHandlerObj, self._tmpViewParam, selectList)

	self._tmpViewParam = nil
end

function TurnbackPickEquipController:onCloseView()
	return
end

TurnbackPickEquipController.instance = TurnbackPickEquipController.New()

return TurnbackPickEquipController
