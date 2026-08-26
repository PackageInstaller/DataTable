-- chunkname: @modules/logic/achievement/view/AchievementSelectCommonItem.lua

module("modules.logic.achievement.view.AchievementSelectCommonItem", package.seeall)

local AchievementSelectCommonItem = class("AchievementSelectCommonItem", ListScrollCellExtend)

function AchievementSelectCommonItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementSelectCommonItem:addEventListeners()
	return
end

function AchievementSelectCommonItem:removeEventListeners()
	return
end

function AchievementSelectCommonItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self._isFirstEnter = true
end

function AchievementSelectCommonItem:onDestroy()
	self:releaseAchievementMainIcons()
	TaskDispatcher.cancelTask(self.playItemOpenAim, self)
end

function AchievementSelectCommonItem:onUpdateMO(mo)
	self._mo = mo

	self:buildAchievementCfgs()
	self:refreshUI()
end

function AchievementSelectCommonItem:onSelect(isSelect)
	return
end

function AchievementSelectCommonItem:refreshUI()
	self:refreshAchievements()
	self:playAchievementOpenAnim()
end

AchievementSelectCommonItem.LockedIconColor = "#808080"
AchievementSelectCommonItem.UnLockedIconColor = "#FFFFFF"
AchievementSelectCommonItem.LockedNameAlpha = 0.5
AchievementSelectCommonItem.UnLockedNameAlpha = 1

function AchievementSelectCommonItem:refreshAchievements()
	local achievementCfgs = self:getAchievementCfgs()
	local achievementCount = achievementCfgs and #achievementCfgs
	local useMap = {}

	for index = 1, achievementCount do
		local achievementCfg = achievementCfgs[index]
		local achievementIcon = self:getOrCreateAchievementIcon(index)

		gohelper.setActive(achievementIcon.viewGO, true)

		useMap[achievementIcon] = true

		self:refreshAchievement(achievementIcon, achievementCfg, index)
		self:refreshAchievementIconPositionAndScale(achievementIcon, achievementCfg, index)
	end

	self:recycleUnuseAchievementIcon(useMap)
end

function AchievementSelectCommonItem:buildAchievementCfgs()
	self._achievementCfgs = self._mo.achievementCfgs
end

function AchievementSelectCommonItem:getAchievementCfgs()
	return self._achievementCfgs
end

function AchievementSelectCommonItem:refreshAchievement(achievementIcon, achievementCfg, index)
	if not achievementIcon then
		return
	end

	local achievementId = achievementCfg.id
	local taskCfg = AchievementController.instance:getMaxLevelFinishTask(achievementId)

	if taskCfg then
		achievementIcon:setData(taskCfg)
		achievementIcon:setNameTxtVisible(false)
		achievementIcon:setBgVisible(false)

		local isLocked = AchievementModel.instance:achievementHasLocked(achievementId)

		gohelper.setActive(achievementIcon.viewGO, not isLocked)
	else
		gohelper.setActive(achievementIcon.viewGO, false)
	end
end

function AchievementSelectCommonItem:refreshAchievementIconPositionAndScale(achievementIcon, achievementCfg, index)
	return
end

function AchievementSelectCommonItem:getOrCreateAchievementIcon(index)
	self._achievementIconTab = self._achievementIconTab or self:getUserDataTb_()

	local achievementIcon = self._achievementIconTab[index]

	if not achievementIcon then
		achievementIcon = self:createAchievementIcon(index)
		self._achievementIconTab[index] = achievementIcon
	end

	return achievementIcon
end

function AchievementSelectCommonItem:createAchievementIcon(index)
	local achievementIcon = AchievementMainIcon.New()
	local parentGO = self:getAchievementIconParentGO()
	local achievementIconUrl = self:getAchievementIconResUrl()
	local achievementGO = self._view:getResInst(achievementIconUrl, parentGO, "icon" .. tostring(index))

	achievementIcon:init(achievementGO)
	achievementIcon:setClickCall(self.onClickSingleAchievementIcon, self, index)

	return achievementIcon
end

function AchievementSelectCommonItem:getAchievementIconParentGO()
	return self.viewGO
end

function AchievementSelectCommonItem:getAchievementIconResUrl()
	return AchievementEnum.MainIconPath
end

function AchievementSelectCommonItem:recycleUnuseAchievementIcon(useMap)
	if useMap and self._achievementIconTab then
		for _, achievementIcon in pairs(self._achievementIconTab) do
			if not useMap[achievementIcon] then
				gohelper.setActive(achievementIcon.viewGO, false)
			end
		end
	end
end

function AchievementSelectCommonItem:releaseAchievementMainIcons()
	if self._achievementIconTab then
		for _, achievementIcon in pairs(self._achievementIconTab) do
			if achievementIcon and achievementIcon.dispose then
				achievementIcon:dispose()
			end
		end
	end

	self._achievementIconTab = nil
end

AchievementSelectCommonItem.AnimDelayDelta = 0.06

function AchievementSelectCommonItem:playAchievementAnim(viewTopIndex)
	self:playAchievementOpenAnim(viewTopIndex)
end

function AchievementSelectCommonItem:playAchievementOpenAnim(viewTopIndex)
	TaskDispatcher.cancelTask(self.playItemOpenAim, self)

	if self._isNeedPlayOpenAnim then
		self._animator:Play("close", 0, 0)

		viewTopIndex = viewTopIndex or 1

		local delayPlayAnimTime = AchievementSelectCommonItem.AnimDelayDelta * Mathf.Clamp(self._index - viewTopIndex, 0, self._index)

		TaskDispatcher.runDelay(self.playItemOpenAim, self, delayPlayAnimTime)

		self._isNeedPlayOpenAnim = false
	else
		self._animator:Play("idle", 0, 0)
	end
end

function AchievementSelectCommonItem:playItemOpenAim()
	self._animator:Play("open", 0, 0)

	self._isFirstEnter = false
end

function AchievementSelectCommonItem:resetFistEnter(viewTopIndex)
	self._isNeedPlayOpenAnim = true

	self:playAchievementAnim(viewTopIndex)
end

return AchievementSelectCommonItem
