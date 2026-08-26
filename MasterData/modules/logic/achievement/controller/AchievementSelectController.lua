-- chunkname: @modules/logic/achievement/controller/AchievementSelectController.lua

module("modules.logic.achievement.controller.AchievementSelectController", package.seeall)

local AchievementSelectController = class("AchievementSelectController", BaseController)

function AchievementSelectController:onOpenView(selectType)
	AchievementSelectListModel.instance:initDatas(selectType)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, self.handlePlayerInfoChanged, self)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, self.handleAchievementUpdated, self)
end

function AchievementSelectController:onCloseView()
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, self.handlePlayerInfoChanged, self)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, self.handleAchievementUpdated, self)
	AchievementSelectListModel.instance:release()
end

function AchievementSelectController:setCategory(category)
	AchievementSelectListModel.instance:setTab(category)
	self:notifyUpdateView()
end

function AchievementSelectController:switchGroup()
	local isGroup = AchievementSelectListModel.instance.isGroup
	local needSave = AchievementSelectListModel.instance:checkDirty(isGroup)

	if needSave then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, self.switchGroupWithoutCheck, nil, nil, self, nil)
	else
		self:switchGroupWithoutCheck()
	end
end

function AchievementSelectController:switchGroupAfterSave()
	self.sendSave(self, self.switchGroupWithoutCheck, self)
end

function AchievementSelectController:switchGroupWithoutCheck()
	local isGroup = AchievementSelectListModel.instance.isGroup

	AchievementSelectListModel.instance:resumeToOriginSelect()

	if not isGroup then
		AchievementSelectListModel.instance:setTab(AchievementEnum.Type.Activity)
	end

	AchievementSelectListModel.instance:setIsSelectGroup(not isGroup)
	self:notifyUpdateView()
end

function AchievementSelectController:resumeToOriginSelect()
	AchievementSelectListModel.instance:resumeToOriginSelect()
	self:notifyUpdateView()
end

function AchievementSelectController:clearAllSelect()
	AchievementSelectListModel.instance:clearAllSelect()
	self:notifyUpdateView()
end

function AchievementSelectController:changeGroupSelect(groupId)
	local isSelected = AchievementSelectListModel.instance:isGroupSelected(groupId)
	local curCount = AchievementSelectListModel.instance:getGroupSelectedCount()
	local isSupportSingleSelect = AchievementEnum.ShowMaxGroupCount <= 1

	if isSupportSingleSelect then
		AchievementSelectListModel.instance:clearAllSelect()
	elseif not isSelected and curCount >= AchievementEnum.ShowMaxGroupCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxGroupCount, AchievementEnum.ShowMaxGroupCount)

		return
	end

	AchievementSelectListModel.instance:setGroupSelect(groupId, not isSelected)
	self:notifyUpdateView()
end

function AchievementSelectController:changeSingleSelect(taskId)
	if AchievementSelectListModel.instance:getNamePlateSelectedCount() > 0 then
		AchievementSelectListModel.instance:clearNamePlateAllSelect()
	end

	local isSelected = AchievementSelectListModel.instance:isSingleSelected(taskId)
	local curCount = AchievementSelectListModel.instance:getSingleSelectedCount()

	if not isSelected and curCount >= AchievementEnum.ShowMaxSingleCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, AchievementEnum.ShowMaxSingleCount)

		return
	end

	AchievementSelectListModel.instance:setSingleSelect(taskId, not isSelected)
	self:notifyUpdateView()
end

function AchievementSelectController:changeNamePlateSelect(taskId)
	local isSelected = AchievementSelectListModel.instance:isSingleSelected(taskId)
	local curCount = AchievementSelectListModel.instance:getSingleSelectedCount()

	if not isSelected and curCount >= 1 then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, 1)

		return
	end

	AchievementSelectListModel.instance:setSingleSelect(taskId, not isSelected)
	self:notifyUpdateView()
end

function AchievementSelectController:handlePlayerInfoChanged()
	AchievementSelectListModel.instance:decodeShowAchievement()
	self:notifyUpdateView()
end

function AchievementSelectController:handleAchievementUpdated()
	AchievementSelectListModel.instance:refreshTabData()
	self:notifyUpdateView()
end

function AchievementSelectController:checkSave(isGroup, cancelCall, cancelCallObj)
	GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, self.switchGroupAfterSave, cancelCall, nil, self, cancelCallObj)
end

function AchievementSelectController:sendSave(callback, callbackObj)
	local taskIdList, groupId = AchievementSelectListModel.instance:getSaveRequestParam()

	AchievementRpc.instance:sendShowAchievementRequest(taskIdList, groupId, callback, callbackObj)
end

function AchievementSelectController:notifyUpdateView()
	self:dispatchEvent(AchievementEvent.SelectViewUpdated)
	AchievementSelectListModel.instance:onModelUpdate()
end

function AchievementSelectController:popUpMessageBoxIfNeedSave(yesCB, noCB, unPopUpCB, yesCBObj, noCBObj, unPopUpObj)
	local isGroup = AchievementSelectListModel.instance.isGroup
	local needSave = AchievementSelectListModel.instance:checkDirty(isGroup)

	if needSave then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, yesCB, noCB, nil, yesCBObj, noCBObj)
	elseif unPopUpCB then
		unPopUpCB(unPopUpObj)
	end
end

function AchievementSelectController:isCurrentShowGroupInPlayerView()
	local showStr = PlayerModel.instance:getShowAchievement()
	local _, groupSet = AchievementUtils.decodeShowStr(showStr)

	if groupSet and tabletool.len(groupSet) > 0 then
		return true
	end
end

AchievementSelectController.instance = AchievementSelectController.New()

LuaEventSystem.addEventMechanism(AchievementSelectController.instance)

return AchievementSelectController
