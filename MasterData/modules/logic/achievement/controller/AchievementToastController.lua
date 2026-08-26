-- chunkname: @modules/logic/achievement/controller/AchievementToastController.lua

module("modules.logic.achievement.controller.AchievementToastController", package.seeall)

local AchievementToastController = class("AchievementToastController", BaseController)

function AchievementToastController:onInit()
	return
end

function AchievementToastController:onInitFinish()
	return
end

function AchievementToastController:addConstEvents()
	self.registerCallback(self, AchievementEvent.LoginShowToast, self.handleLoginEnterMainScene, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.checkToastTrigger, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.checkToastWithOpenView, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self.checkToastTrigger, self)
end

function AchievementToastController:reInit()
	self._isLoginScene = false
	self._isToastShowing = false

	if self._toastLoader then
		self._toastLoader:dispose()

		self._toastLoader = nil
	end

	AchievementToastModel.instance:release()
end

function AchievementToastController:onUpdateAchievements()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if not playerInfo or playerInfo.userId == 0 then
		return
	end

	if self:canPopUpToast() then
		self:showNextToast()
	end
end

function AchievementToastController:handleLoginEnterMainScene()
	self._isLoginScene = true

	if self:canPopUpToast() then
		self:showNextToast()
	end
end

function AchievementToastController:checkToastTrigger()
	if self:canPopUpToast() then
		self:showNextToast()
	end
end

function AchievementToastController:checkToastWithOpenView()
	if self:canPopUpToastWithOpenView() then
		self:showNextToast()
	end
end

function AchievementToastController:canPopUpToastWithOpenView()
	return ViewMgr.instance:isOpen(ViewName.TowerPermanentResultView) or ViewMgr.instance:isOpen(ViewName.TowerDeepResultView) or ViewMgr.instance:isOpen(ViewName.TowerDeepHeroGroupFightView)
end

function AchievementToastController:canPopUpToast()
	return self._isLoginScene and not ViewMgr.instance:isOpen(ViewName.StoryView) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) and not ViewMgr.instance:isOpen(ViewName.AiZiLaGameView) and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or ViewMgr.instance:isOpen(ViewName.TowerDeepHeroGroupFightView)
end

function AchievementToastController:showNextToast()
	local waitToastList = AchievementToastModel.instance:getWaitToastList()
	local waitNamePlateToastList = AchievementToastModel.instance:getWaitNamePlateToastList()

	if waitToastList and #waitToastList > 0 then
		self:tryShowToast(waitToastList)
		AchievementToastModel.instance:onToastFinished()
	end

	if waitNamePlateToastList and #waitNamePlateToastList > 0 then
		self:tryShowNamePlateToast(waitNamePlateToastList)
		AchievementToastModel.instance:onToastFinished()
	end
end

function AchievementToastController:tryShowNamePlateToast(waitNamePlateToastList)
	local taskCo = waitNamePlateToastList[1]

	ViewMgr.instance:openView(ViewName.AchievementNamePlateUnlockView, taskCo)
end

function AchievementToastController:tryShowToast(waitToastList)
	if waitToastList then
		local waitToastCount = #waitToastList
		local startToastIndex = waitToastCount - AchievementEnum.ShowMaxToastCount + 1

		startToastIndex = Mathf.Clamp(startToastIndex, 1, waitToastCount)

		for i = startToastIndex, waitToastCount do
			local toastMo = waitToastList[i]
			local taskId = toastMo.taskId
			local toastType = toastMo.toastType

			self:showToastByTaskId(taskId, toastType)
		end
	end
end

function AchievementToastController:showToastByTaskId(taskId, toastType)
	local taskCfg = AchievementConfig.instance:getTask(taskId)
	local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
	local toastShowFunc = self:getToastShowFunction(toastType)

	return (toastShowFunc and AchievementUtils.isShowByAchievementCfg(achievementCfg) or nil) and toastShowFunc(self, taskCfg, achievementCfg)
end

function AchievementToastController:getToastShowFunction(toastType)
	return AchievementToastController.AchievementToastShowFuncTab[toastType]
end

function AchievementToastController:onShowTaskFinishedToast(taskCfg, achievementCfg)
	local isToastSucc = false

	if taskCfg then
		local toastTip = formatLuaLang("achievementtoastitem_achievementcompleted", self:getToastName(achievementCfg, taskCfg.level))
		local iconPath = ResUrl.getAchievementIcon("badgeicon/" .. taskCfg.icon)
		local toastParam = {
			toastTip = toastTip,
			icon = iconPath
		}

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementCompleted, self.fillToastObj, self, toastParam, toastTip)

		isToastSucc = true
	end

	return isToastSucc
end

function AchievementToastController:onShowGroupUnlockedToast(taskCfg, achievementCfg)
	local isToastSucc = false

	if taskCfg and achievementCfg then
		local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
		local groupId = achievementCfg and achievementCfg.groupId

		isToastSucc = self:showToastByGroupId(groupId, ToastEnum.AchievementUnLockGroup)
	end

	return isToastSucc
end

function AchievementToastController:onShowGroupUpgrade(taskCfg, achievementCfg)
	local groupCfg = AchievementConfig.instance:getGroup(achievementCfg.groupId)
	local isToastSucc = false

	if groupCfg then
		local toastTipInfo = formatLuaLang("achievementtoastitem_upgradegroup", groupCfg.name)
		local iconPath = ResUrl.getAchievementIcon("badgeicon/achievementgroupicon")
		local toastParam = {
			toastTip = toastTipInfo,
			icon = iconPath
		}

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementGroupUpGrade, self.fillToastObj, self, toastParam, groupCfg.name)

		isToastSucc = true
	end

	return isToastSucc
end

function AchievementToastController:onShowGroupFinishedToast(taskCfg, achievementCfg)
	local groupId = achievementCfg and achievementCfg.groupId

	return (groupId ~= 0 or nil) and self:showToastByGroupId(groupId, ToastEnum.AchievementGroupCollect)
end

function AchievementToastController:getToastName(achievementCo, level)
	local taskCoList = AchievementModel.instance:getAchievementTaskCoList(achievementCo.id)

	if taskCoList and #taskCoList == 1 then
		return achievementCo.name
	end

	return string.format("%s%s", achievementCo.name, GameUtil.getRomanNums(level))
end

function AchievementToastController:fillToastObj(toastObj, toastParam)
	local callbackGroup = ToastCallbackGroup.New()

	callbackGroup.onClose = self.onCloseWhenToastRemove
	callbackGroup.onCloseObj = self
	callbackGroup.onCloseParam = toastParam
	callbackGroup.onOpen = self.onOpenToast
	callbackGroup.onOpenObj = self
	callbackGroup.onOpenParam = toastParam
	toastObj.callbackGroup = callbackGroup
end

function AchievementToastController:onOpenToast(toastParam, toastItem)
	toastParam.item = AchievementToastItem.New()

	toastParam.item:init(toastItem, toastParam)
end

function AchievementToastController:onCloseWhenToastRemove(toastParam, toastItem)
	if toastParam.item then
		toastParam.item:dispose()

		toastParam.item = nil
	end
end

function AchievementToastController:showToastByGroupId(groupId, toastId)
	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	if groupCfg then
		ToastController.instance:showToast(toastId, groupCfg.name)

		return true
	end
end

function AchievementToastController:tryGetToastAsset()
	if self._toastLoader and not self._toastLoader.isLoading then
		local assetItem = self._toastLoader:getAssetItem(AchievementEnum.AchievementToastPath)

		return (assetItem:GetResource(AchievementEnum.AchievementToastPath))
	end

	if not self._toastLoader then
		self._toastLoader = self._toastLoader or MultiAbLoader.New()

		self._toastLoader:addPath(AchievementEnum.AchievementToastPath)
		self._toastLoader:startLoad()
	end

	return nil
end

AchievementToastController.AchievementToastShowFuncTab = {
	[AchievementEnum.ToastType.TaskFinished] = AchievementToastController.onShowTaskFinishedToast,
	[AchievementEnum.ToastType.GroupUnlocked] = AchievementToastController.onShowGroupUnlockedToast,
	[AchievementEnum.ToastType.GroupUpgrade] = AchievementToastController.onShowGroupUpgrade,
	[AchievementEnum.ToastType.GroupFinished] = AchievementToastController.onShowGroupFinishedToast
}
AchievementToastController.instance = AchievementToastController.New()

return AchievementToastController
