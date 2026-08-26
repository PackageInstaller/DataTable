-- chunkname: @modules/logic/playercard/controller/PlayerCardAchievementSelectController.lua

module("modules.logic.playercard.controller.PlayerCardAchievementSelectController", package.seeall)

local PlayerCardAchievementSelectController = class("PlayerCardAchievementSelectController", BaseController)

function PlayerCardAchievementSelectController:onOpenView(selectType)
	PlayerCardAchievementSelectListModel.instance:initDatas(selectType)
end

function PlayerCardAchievementSelectController:onCloseView()
	PlayerCardAchievementSelectListModel.instance:release()
end

function PlayerCardAchievementSelectController:changeNamePlateSelect(taskId)
	local isSelected = PlayerCardAchievementSelectListModel.instance:isSingleSelected(taskId)
	local curCount = PlayerCardAchievementSelectListModel.instance:getSingleSelectedCount()

	if not isSelected and curCount >= 1 then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, 1)

		return
	end

	PlayerCardAchievementSelectListModel.instance:setSingleSelect(taskId, not isSelected)
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:setCategory(category)
	PlayerCardAchievementSelectListModel.instance:setTab(category)
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:switchGroup()
	local isGroup = PlayerCardAchievementSelectListModel.instance.isGroup
	local needSave = PlayerCardAchievementSelectListModel.instance:checkDirty(isGroup)

	if needSave then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, self.switchGroupWithoutCheck, nil, nil, self, nil)
	else
		self:switchGroupWithoutCheck()
	end
end

function PlayerCardAchievementSelectController:switchGroupAfterSave()
	self.sendSave(self, self.switchGroupWithoutCheck, self)
end

function PlayerCardAchievementSelectController:switchGroupWithoutCheck()
	local isGroup = PlayerCardAchievementSelectListModel.instance.isGroup

	PlayerCardAchievementSelectListModel.instance:resumeToOriginSelect()

	if not isGroup then
		PlayerCardAchievementSelectListModel.instance:setTab(AchievementEnum.Type.Activity)
	end

	PlayerCardAchievementSelectListModel.instance:setIsSelectGroup(not isGroup)
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:resumeToOriginSelect()
	PlayerCardAchievementSelectListModel.instance:resumeToOriginSelect()
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:clearAllSelect()
	PlayerCardAchievementSelectListModel.instance:clearAllSelect()
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:changeGroupSelect(groupId)
	local isSelected = PlayerCardAchievementSelectListModel.instance:isGroupSelected(groupId)
	local curCount = PlayerCardAchievementSelectListModel.instance:getGroupSelectedCount()
	local isSupportSingleSelect = AchievementEnum.ShowMaxGroupCount <= 1

	if isSupportSingleSelect then
		PlayerCardAchievementSelectListModel.instance:clearAllSelect()
	elseif not isSelected and curCount >= AchievementEnum.ShowMaxGroupCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxGroupCount, AchievementEnum.ShowMaxGroupCount)

		return
	end

	PlayerCardAchievementSelectListModel.instance:setGroupSelect(groupId, not isSelected)
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:changeSingleSelect(taskId)
	if PlayerCardAchievementSelectListModel.instance:getNamePlateSelectedCount() > 0 then
		PlayerCardAchievementSelectListModel.instance:clearNamePlateAllSelect()
	end

	local isSelected = PlayerCardAchievementSelectListModel.instance:isSingleSelected(taskId)
	local curCount = PlayerCardAchievementSelectListModel.instance:getSingleSelectedCount()

	if not isSelected and curCount >= AchievementEnum.ShowMaxSingleCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, AchievementEnum.ShowMaxSingleCount)

		return
	end

	PlayerCardAchievementSelectListModel.instance:setSingleSelect(taskId, not isSelected)
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:handlePlayerInfoChanged()
	PlayerCardAchievementSelectListModel.instance:decodeShowAchievement()
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:handleAchievementUpdated()
	PlayerCardAchievementSelectListModel.instance:refreshTabData()
	self:notifyUpdateView()
end

function PlayerCardAchievementSelectController:checkSave(isGroup, cancelCall, cancelCallObj)
	GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, self.switchGroupAfterSave, cancelCall, nil, self, cancelCallObj)
end

function PlayerCardAchievementSelectController:sendSave(callback, callbackObj)
	local taskIdList, groupId = PlayerCardAchievementSelectListModel.instance:getSaveRequestParam()

	AchievementRpc.instance:sendShowAchievementRequest(taskIdList, groupId, callback, callbackObj)
end

function PlayerCardAchievementSelectController:notifyUpdateView()
	self:dispatchEvent(AchievementEvent.SelectViewUpdated)
	PlayerCardAchievementSelectListModel.instance:onModelUpdate()
end

function PlayerCardAchievementSelectController:popUpMessageBoxIfNeedSave(yesCB, noCB, unPopUpCB, yesCBObj, noCBObj, unPopUpObj)
	local isGroup = PlayerCardAchievementSelectListModel.instance.isGroup
	local needSave = PlayerCardAchievementSelectListModel.instance:checkDirty(isGroup)

	if needSave then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, yesCB, noCB, nil, yesCBObj, noCBObj)
	elseif unPopUpCB then
		unPopUpCB(unPopUpObj)
	end
end

function PlayerCardAchievementSelectController:isCurrentShowGroupInPlayerView()
	local showStr = PlayerCardModel.instance:getShowAchievement()
	local _, groupSet = AchievementUtils.decodeShowStr(showStr)

	if groupSet and tabletool.len(groupSet) > 0 then
		return true
	end
end

PlayerCardAchievementSelectController.instance = PlayerCardAchievementSelectController.New()

LuaEventSystem.addEventMechanism(PlayerCardAchievementSelectController.instance)

return PlayerCardAchievementSelectController
