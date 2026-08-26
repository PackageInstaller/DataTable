-- chunkname: @modules/logic/season/controller/Activity104EquipComposeController.lua

module("modules.logic.season.controller.Activity104EquipComposeController", package.seeall)

local Activity104EquipComposeController = class("Activity104EquipComposeController", BaseController)

function Activity104EquipComposeController:onInit()
	return
end

function Activity104EquipComposeController:onInitFinish()
	return
end

function Activity104EquipComposeController:reInit()
	return
end

function Activity104EquipComposeController:onOpenView(actId)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, self.handleItemChanged, self)
	Activity104EquipItemComposeModel.instance:initDatas(actId)
end

function Activity104EquipComposeController:onCloseView()
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, self.handleItemChanged, self)
	Activity104EquipItemComposeModel.instance:clear()
end

function Activity104EquipComposeController:changeSelectCard(itemUid)
	if Activity104EquipItemComposeModel.instance:isEquipSelected(itemUid) then
		Activity104EquipItemComposeModel.instance:unloadEquip(itemUid)
		self:notifyUpdateView()
	else
		local targetRare = Activity104EquipItemComposeModel.instance:getSelectedRare()
		local itemMO = Activity104EquipItemComposeModel.instance:getEquipMO(itemUid)

		if not itemMO then
			return
		end

		local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemMO.itemId)

		if not itemCO then
			return
		end

		if targetRare ~= nil and itemCO.rare ~= targetRare then
			GameFacade.showToast(ToastEnum.SeasonChangeSelectCard)

			return
		end

		Activity104EquipItemComposeModel.instance:setSelectEquip(itemUid)
		self:notifyUpdateView()
	end
end

function Activity104EquipComposeController:notifyUpdateView()
	Activity104EquipItemComposeModel.instance:onModelUpdate()
	self:dispatchEvent(Activity104Event.OnComposeDataChanged)
end

function Activity104EquipComposeController:checkMaterialHasEquiped()
	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		local itemUid = Activity104EquipItemComposeModel.instance.curSelectMap[pos]

		if Activity104EquipItemComposeModel.instance:getEquipedHeroUid(itemUid) then
			return true
		end
	end

	return false
end

function Activity104EquipComposeController:sendCompose()
	if Activity104EquipItemComposeModel.instance:isMaterialAllReady() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_synthesis)
		Activity104Rpc.instance:sendComposeActivity104EquipRequest(Activity104EquipItemComposeModel.instance.activityId, Activity104EquipItemComposeModel.instance:getMaterialList())
	end
end

function Activity104EquipComposeController:handleItemChanged()
	Activity104EquipItemComposeModel.instance:initItemMap()
	Activity104EquipItemComposeModel.instance:checkResetCurSelected()
	Activity104EquipItemComposeModel.instance:initPosList()
	Activity104EquipItemComposeModel.instance:initList()
	self:notifyUpdateView()
end

function Activity104EquipComposeController:setSelectTag(tagIndex)
	if Activity104EquipItemComposeModel.instance.tagModel then
		Activity104EquipItemComposeModel.instance.tagModel:selectTagIndex(tagIndex)
		self:handleItemChanged()
	end
end

function Activity104EquipComposeController:setSelectFilterId(index)
	local countModel = self:getFilterModel2()

	if countModel then
		countModel:selectIndex(index)
		self:handleItemChanged()
	end
end

function Activity104EquipComposeController:getFilterModel()
	return Activity104EquipItemComposeModel.instance.tagModel
end

function Activity104EquipComposeController:getFilterModel2()
	return Activity104EquipItemComposeModel.instance.countModel
end

function Activity104EquipComposeController:autoSelectEquip()
	local result = Activity104EquipItemComposeModel.instance:checkAutoSelectEquip()

	if not result then
		GameFacade.showToast(ToastEnum.SeasonEquipAutoSelectFail)
	end

	self:notifyUpdateView()
end

Activity104EquipComposeController.instance = Activity104EquipComposeController.New()

LuaEventSystem.addEventMechanism(Activity104EquipComposeController.instance)

return Activity104EquipComposeController
