-- chunkname: @modules/logic/achievement/view/AchievementSelectItem.lua

module("modules.logic.achievement.view.AchievementSelectItem", package.seeall)

local AchievementSelectItem = class("AchievementSelectItem", ListScrollCellExtend)

function AchievementSelectItem:onInitView()
	self._gosingle = gohelper.findChild(self.viewGO, "#go_single")
	self._gogroup = gohelper.findChild(self.viewGO, "#go_group")
	self._gosingleitem = gohelper.findChild(self.viewGO, "#go_single/#go_singleitem")
	self._gogroupselected = gohelper.findChild(self.viewGO, "#go_group/#go_groupselected")
	self._btngroupselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_group/#btn_groupselect")
	self._gogroupcontainer = gohelper.findChild(self.viewGO, "#go_group/#go_groupcontainer")
	self._simagegroupbg = gohelper.findChildSingleImage(self.viewGO, "#go_group/#simage_groupbg")
	self._goallcollect = gohelper.findChild(self.viewGO, "#go_group/#go_allcollect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementSelectItem:addEvents()
	self._btngroupselect:AddClickListener(self._btngroupselectOnClick, self)
end

function AchievementSelectItem:removeEvents()
	self._btngroupselect:RemoveClickListener()
end

function AchievementSelectItem:_editableInitView()
	self._anim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function AchievementSelectItem:onDestroy()
	if self._singleItems then
		for _, item in pairs(self._singleItems) do
			item:dispose()
		end

		self._singleItems = nil
	end

	if self._groupItems then
		for _, item in pairs(self._groupItems) do
			item:dispose()
		end

		self._groupItems = nil
	end

	self._simagegroupbg:UnLoadImage()
	TaskDispatcher.cancelTask(self._playItemOpenAim, self)
end

function AchievementSelectItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function AchievementSelectItem:refreshUI()
	local isGroup = self._mo.groupId ~= 0

	gohelper.setActive(self._gosingle, not isGroup)
	gohelper.setActive(self._gogroup, isGroup)

	if isGroup then
		self:refreshGroup()
	else
		self:refreshSingle()
	end

	self:_playAnim()
end

function AchievementSelectItem:refreshSingle()
	self:checkInitSingle()

	for i = 1, AchievementEnum.MainListLineCount do
		local item = self._singleItems[i]
		local achievementCO = self._mo.achievementCfgs[i]

		gohelper.setActive(item.viewGO, achievementCO ~= nil)

		if achievementCO then
			local achievementId = achievementCO.id
			local taskCO = AchievementController.instance:getMaxLevelFinishTask(achievementId)

			if taskCO then
				item:setData(taskCO)
			else
				gohelper.setActive(item.viewGO, false)
			end
		end
	end
end

function AchievementSelectItem:refreshGroup()
	local groupId = self._mo.groupId
	local groupCO = AchievementConfig.instance:getGroup(groupId)

	if groupCO then
		local isUnLockAchievementFinished = AchievementModel.instance:isAchievementTaskFinished(groupCO.unLockAchievement)
		local groupBgUrl = AchievementConfig.instance:getGroupBgUrl(groupId, AchievementEnum.GroupParamType.List, isUnLockAchievementFinished)

		self._simagegroupbg:LoadImage(groupBgUrl)
		self:refreshSingleInGroup()
	end

	gohelper.setActive(self._gogroupselected, AchievementSelectListModel.instance:isGroupSelected(groupId))
end

function AchievementSelectItem:refreshSingleInGroup()
	local idTab = AchievementConfig.instance:getGroupParamIdTab(self._mo.groupId, AchievementEnum.GroupParamType.List)
	local usefulList = {}

	if idTab then
		local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(self._mo.groupId)

		for k, v in ipairs(idTab) do
			local item = self:getOrCreateSingleItemInGroup(k)

			usefulList[item] = true

			self:_setGroupAchievementPosAndScale(item.viewGO, self._mo.groupId, k)

			local cfg = achievementCfgs[v]

			gohelper.setActive(item.viewGO, cfg ~= nil)

			if cfg then
				local taskCO = AchievementController.instance:getMaxLevelFinishTask(cfg.id)

				if taskCO then
					item:setData(taskCO)
					item:setNameTxtVisible(false)
					item:setSelectIconVisible(false)
					item:setBgVisible(false)

					local isLocked = AchievementModel.instance:achievementHasLocked(cfg.id)

					gohelper.setActive(item.viewGO, not isLocked)
				else
					gohelper.setActive(item.viewGO, false)
				end
			end
		end
	end

	if usefulList and self._groupItems then
		for _, v in pairs(self._groupItems) do
			if not usefulList[v] then
				gohelper.setActive(v.viewGO, false)
			end
		end
	end

	local isGroupFinish = AchievementModel.instance:isGroupFinished(self._mo.groupId)

	gohelper.setActive(self._goallcollect, isGroupFinish)
end

function AchievementSelectItem:getOrCreateSingleItemInGroup(index)
	self._groupItems = self._groupItems or {}

	local item = self._groupItems[index]

	if not item then
		item = AchievementMainIcon.New()

		local goIcon = self._view:getResInst(AchievementEnum.MainIconPath, self._gogroupcontainer, "#go_icon" .. index)

		item:init(goIcon)

		self._groupItems[index] = item
	end

	return item
end

function AchievementSelectItem:_setGroupAchievementPosAndScale(go, groupId, index)
	local posX, posY, scaleX, scaleY = AchievementConfig.instance:getAchievementPosAndScaleInGroup(groupId, index, AchievementEnum.GroupParamType.List)

	if go then
		recthelper.setAnchor(go.transform, posX or 0, posY or 0)
		transformhelper.setLocalScale(go.transform, scaleX or 1, scaleY or 1, 1)
	end
end

AchievementSelectItem.IconStartX = -535
AchievementSelectItem.IconIntervalX = 265

function AchievementSelectItem:checkInitSingle()
	if self._singleItems then
		return
	end

	self._singleItems = {}

	for i = 1, AchievementEnum.MainListLineCount do
		local item = AchievementSelectIcon.New()
		local goItem = gohelper.cloneInPlace(self._gosingleitem, "item" .. tostring(i))
		local goIcon = self._view:getResInst(AchievementEnum.MainIconPath, goItem, "#go_icon")

		item:init(goItem, goIcon)

		local rect = goItem.transform

		recthelper.setAnchorX(rect, AchievementSelectItem.IconStartX + (i - 1) * AchievementSelectItem.IconIntervalX)

		self._singleItems[i] = item
	end
end

function AchievementSelectItem:_btngroupselectOnClick()
	AchievementSelectController.instance:changeGroupSelect(self._mo.groupId)

	local isSelected = AchievementSelectListModel.instance:isGroupSelected(self._mo.groupId)

	AudioMgr.instance:trigger((isSelected or nil) and (AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone))
end

AchievementSelectItem.AnimDelayDelta = 0.06
AchievementSelectItem.OneScreenItemCountInSingle = 3
AchievementSelectItem.OneScreenItemCountInGroup = 2

function AchievementSelectItem:_playAnim()
	TaskDispatcher.cancelTask(self._playItemOpenAim, self)
	self._anim:Play("close", 0, 0)

	local hasShownIndex = AchievementSelectListModel.instance:getItemAniHasShownIndex()

	if self._mo.groupId ~= 0 then
		if not AchievementSelectItem.OneScreenItemCountInGroup then
			local maxCanPlayAnimItemCount = AchievementSelectItem.OneScreenItemCountInSingle

			if maxCanPlayAnimItemCount >= self._index and hasShownIndex < self._index then
				TaskDispatcher.runDelay(self._playItemOpenAim, self, AchievementSelectItem.AnimDelayDelta * (self._index - 1))
			else
				self._anim:Play("idle", 0, 0)
			end
		end
	end
end

function AchievementSelectItem:_playItemOpenAim()
	self._anim:Play("open", 0, 0)
	AchievementSelectListModel.instance:setItemAniHasShownIndex(self._index)
end

return AchievementSelectItem
