-- chunkname: @modules/logic/achievement/view/AchievementGroupPreView.lua

module("modules.logic.achievement.view.AchievementGroupPreView", package.seeall)

local AchievementGroupPreView = class("AchievementGroupPreView", BaseView)

function AchievementGroupPreView:onInitView()
	self._btnview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_view")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._simagegroupbg = gohelper.findChildSingleImage(self.viewGO, "#simage_groupbg")
	self._goherogroupcontainer = gohelper.findChild(self.viewGO, "#go_groupcontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementGroupPreView:addEvents()
	self._btnview:AddClickListener(self._btnviewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
end

function AchievementGroupPreView:removeEvents()
	self._btnview:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function AchievementGroupPreView:_editableInitView()
	self.addEventCb(self, AchievementController.instance, AchievementEvent.UpdateAchievements, self.refreshGroup, self)
end

function AchievementGroupPreView:onDestroyView()
	self:disposeAchievementMainIcon()
end

function AchievementGroupPreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achievementgrouppreview_open)
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
	self:refreshGroup()
end

AchievementGroupPreView.LockedIconColor = "#808080"
AchievementGroupPreView.UnLockedIconColor = "#FFFFFF"
AchievementGroupPreView.LockedNameAlpha = 0.5
AchievementGroupPreView.UnLockedNameAlpha = 1

function AchievementGroupPreView:refreshGroup()
	self:refreshGroupBg()
	self:refreshAchievementInGroup()
end

function AchievementGroupPreView:refreshGroupBg()
	local groupCO = AchievementConfig.instance:getGroup(self.viewParam.groupId)

	if groupCO then
		local isUnLockAchievementFinished = AchievementModel.instance:isAchievementTaskFinished(groupCO.unLockAchievement)
		local groupBgUrl = AchievementConfig.instance:getGroupBgUrl(self.viewParam.groupId, AchievementEnum.GroupParamType.List, isUnLockAchievementFinished)

		self._simagegroupbg:LoadImage(groupBgUrl)

		local isLocked = AchievementModel.instance:achievementGroupHasLocked(self.viewParam.groupId)

		SLFramework.UGUI.GuiHelper.SetColor(self._groupBgImage, (isLocked or nil) and (AchievementGroupPreView.LockedGroupBgColor or AchievementGroupPreView.UnLockedGroupBgColor))
	end
end

function AchievementGroupPreView:refreshAchievementInGroup()
	local idTabs = AchievementConfig.instance:getGroupParamIdTab(self.viewParam.groupId, AchievementEnum.GroupParamType.List)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(self.viewParam.groupId)
	local useMap = {}
	local isNeedPlayEffectAudio = false

	for i = 1, #idTabs do
		local index = idTabs[i]

		if achievementCfgs[index] then
			local achievementId = achievementCfgs[index].id
			local icon = self:getOrCreateAchievementIcon(self.viewParam.groupId, index, i)

			useMap[icon] = true

			local taskCO = AchievementController.instance:getMaxLevelFinishTask(achievementId)

			gohelper.setActive(icon.viewGO, taskCO ~= nil)

			if taskCO then
				icon:setData(taskCO)

				local isLocked = AchievementModel.instance:achievementHasLocked(achievementId)

				icon:setIsLocked(isLocked)
				icon:setIconColor((isLocked or nil) and (AchievementGroupPreView.LockedIconColor or AchievementGroupPreView.UnLockedIconColor))
				icon:setSelectIconVisible(false)
				icon:setNameTxtVisible(false)
				icon:setBgVisible(false)

				local isPlayNewClip = self:playIconAnim(icon, achievementId)

				isNeedPlayEffectAudio = isNeedPlayEffectAudio or isPlayNewClip
			end
		end
	end

	if isNeedPlayEffectAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
	end

	if self._iconItems then
		for _, v in pairs(self._iconItems) do
			if not useMap[v] then
				gohelper.setActive(v.viewGO, false)
			end
		end
	end
end

function AchievementGroupPreView:playIconAnim(icon, achievementId)
	local isNew = AchievementModel.instance:achievementHasNew(achievementId)
	local isPlayingNewAnim = icon:isPlaingAnimClip(AchievementMainIcon.AnimClip.New)
	local isPlayingLoopAnim = icon:isPlaingAnimClip(AchievementMainIcon.AnimClip.Loop)
	local isPlayNewClip = false

	if isNew then
		if not isPlayingNewAnim and not isPlayingLoopAnim then
			icon:playAnim(AchievementMainIcon.AnimClip.New)

			isPlayNewClip = true
		end
	else
		icon:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	return isPlayNewClip
end

function AchievementGroupPreView:getOrCreateAchievementIcon(groupId, configIndex, viewGOIndex)
	self._iconItems = self._iconItems or {}

	local icon = self._iconItems[viewGOIndex]

	if not icon then
		icon = AchievementMainIcon.New()

		local go = self:getResInst(AchievementEnum.MainIconPath, self._goherogroupcontainer, "icon" .. tostring(viewGOIndex))

		icon:init(go)
		icon:setClickCall(self.onClickAchievementIcon, self, configIndex)

		self._iconItems[viewGOIndex] = icon
	end

	self:setGroupAchievementPosAndScale(icon.viewGO, groupId, viewGOIndex)

	return icon
end

function AchievementGroupPreView:onClickAchievementIcon(index)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(self.viewParam.groupId)
	local achievementCO = achievementCfgs and achievementCfgs[index]

	if achievementCO then
		local achievemenIdList = {}

		for _, v in ipairs(achievementCfgs) do
			table.insert(achievemenIdList, v.id)
		end

		local viewParam = {}

		viewParam.achievementId = achievementCO.id
		viewParam.achievementIds = achievemenIdList

		ViewMgr.instance:openView(ViewName.AchievementLevelView, viewParam)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
		self:cleanAchievementNewFlag(achievementCO.id)
	end
end

function AchievementGroupPreView:setGroupAchievementPosAndScale(go, groupId, index)
	local posX, posY, scaleX, scaleY = AchievementConfig.instance:getAchievementPosAndScaleInGroup(groupId, index, AchievementEnum.GroupParamType.List)

	if go then
		recthelper.setAnchor(go.transform, posX or 0, posY or 0)
		transformhelper.setLocalScale(go.transform, scaleX or 1, scaleY or 1, 1)
	end
end

function AchievementGroupPreView:disposeAchievementMainIcon()
	if self._iconItems then
		for _, v in pairs(self._iconItems) do
			if v.dispose then
				v:dispose()
			end
		end
	end
end

function AchievementGroupPreView:cleanGroupNewFlag()
	local coList = AchievementConfig.instance:getAchievementsByGroupId(self.viewParam.groupId)
	local taskIds = {}

	if coList then
		for _, achievementCo in ipairs(coList) do
			local taskCoList = AchievementModel.instance:getAchievementTaskCoList(achievementCo.id)

			if taskCoList then
				for _, taskCo in ipairs(taskCoList) do
					local taskMo = AchievementModel.instance:getById(taskCo.id)

					if taskMo and taskMo.isNew then
						table.insert(taskIds, taskCo.id)
					end
				end
			end
		end
	end

	if #taskIds > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(taskIds)
	end
end

function AchievementGroupPreView:cleanAchievementNewFlag(achievementId)
	local taskCoList = AchievementConfig.instance:getTasksByAchievementId(achievementId)
	local taskIds = {}

	if taskCoList then
		for _, taskCo in ipairs(taskCoList) do
			local taskMo = AchievementModel.instance:getById(taskCo.id)

			if taskMo and taskMo.isNew then
				table.insert(taskIds, taskCo.id)
			end
		end
	end

	if #taskIds > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(taskIds)
	end
end

function AchievementGroupPreView:onClose()
	self:cleanGroupNewFlag()
end

function AchievementGroupPreView:_btnviewOnClick()
	if self.viewParam then
		AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Group, self.viewParam)
	end
end

function AchievementGroupPreView:_btncloseOnClick()
	self:closeThis()
end

function AchievementGroupPreView:_btnclose2OnClick()
	self:closeThis()
end

return AchievementGroupPreView
