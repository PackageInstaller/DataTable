-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/category/Act183DungeonBaseGroupItem.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.category.Act183DungeonBaseGroupItem", package.seeall)

local Act183DungeonBaseGroupItem = class("Act183DungeonBaseGroupItem", LuaCompBase)

function Act183DungeonBaseGroupItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(self.go, "go_select")
	self._txtselecttitle = gohelper.findChildText(self.go, "go_select/txt_title")
	self._gounselect = gohelper.findChild(self.go, "go_unselect")
	self._txtunselecttitle = gohelper.findChildText(self.go, "go_unselect/txt_title")
	self._golock = gohelper.findChild(self.go, "go_lock")
	self._imagelockicon = gohelper.findChildImage(self.go, "go_lock/icon")
	self._txtlocktitle = gohelper.findChildText(self.go, "go_lock/txt_title")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self._imageselect = gohelper.findChildImage(self.go, "go_select/image_Selected")
	self._imageunselect = gohelper.findChildImage(self.go, "go_unselect/image_UnSelected")
	self._imagelock = gohelper.findChildImage(self.go, "go_lock/image_Locked")
	self._gofinished = gohelper.findChild(self.go, "go_finished")
	self._goselect_normaleffect = gohelper.findChild(self.go, "go_select/vx_normal")
	self._goselect_hardeffect = gohelper.findChild(self.go, "go_select/vx_hard")
	self._animfinish = gohelper.onceAddComponent(self._gofinished, gohelper.Type_Animator)
end

function Act183DungeonBaseGroupItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnClickSwitchGroup, self._onClickSwitchGroup, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnGroupAllTaskFinished, self._onGroupAllTaskFinished, self)
end

function Act183DungeonBaseGroupItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function Act183DungeonBaseGroupItem:_btnclickOnClick()
	if not self._isUnlock then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	gohelper.setActive(self._goselect_normaleffect, self._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(self._goselect_hardeffect, self._groupType == Act183Enum.GroupType.HardMain)

	if self._groupType ~= Act183Enum.GroupType.Daily then
		local activityId = Act183Model.instance:getActivityId()

		Act183Helper.saveLastEnterMainGroupTypeInLocal(activityId, self._groupType)
	end

	Act183Controller.instance:dispatchEvent(Act183Event.OnClickSwitchGroup, self._groupId)
end

function Act183DungeonBaseGroupItem:_onClickSwitchGroup(groupId)
	self:onSelect(self._groupId == groupId)
end

function Act183DungeonBaseGroupItem:onUpdateMO(groupMo, index)
	self._groupMo = groupMo
	self._groupId = groupMo:getGroupId()
	self._groupType = groupMo:getGroupType()
	self._status = groupMo:getStatus()
	self._index = index
	self._isUnlock = self._status ~= Act183Enum.GroupStatus.Locked

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._golock, not self._isUnlock)
	self:refreshTitleAndBg()
	self:refreshGroupTaskProgress()
end

function Act183DungeonBaseGroupItem:refreshTitleAndBg()
	local titleStr = ""
	local titleColor = "#E1E1E1"
	local lockIconColor = "#969696"
	local selectBgName = ""
	local unselectBgName = ""

	if self._groupType == Act183Enum.GroupType.NormalMain then
		titleStr = luaLang("act183dungeonview_normalmainepisode")
		selectBgName = "v2a5_challenge_dungeon_normaltabselected"
		unselectBgName = "v2a5_challenge_dungeon_normaltabunselected"
	elseif self._groupType == Act183Enum.GroupType.HardMain then
		titleStr = luaLang("act183dungeonview_hardmainepisode")
		titleColor = "#C04E40"
		lockIconColor = "#C04E40"
		selectBgName = "v2a5_challenge_dungeon_hardtabselected"
		unselectBgName = "v2a5_challenge_dungeon_hardtabunselected"
	else
		titleStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act183dungeonview_dailyepisode"), GameUtil.getRomanNums(self._index))
		selectBgName = "v2a5_challenge_dungeon_dailytabselected"
		unselectBgName = "v2a5_challenge_dungeon_dailytabunselected"
	end

	self._txtselecttitle.text = titleStr
	self._txtunselecttitle.text = titleStr
	self._txtlocktitle.text = titleStr

	SLFramework.UGUI.GuiHelper.SetColor(self._txtselecttitle, titleColor)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtunselecttitle, titleColor)
	SLFramework.UGUI.GuiHelper.SetColor(self._imagelockicon, lockIconColor)
	ZProj.UGUIHelper.SetColorAlpha(self._txtselecttitle, 1)
	ZProj.UGUIHelper.SetColorAlpha(self._txtunselecttitle, 0.5)
	UISpriteSetMgr.instance:setChallengeSprite(self._imageselect, selectBgName)
	UISpriteSetMgr.instance:setChallengeSprite(self._imageunselect, unselectBgName)
	UISpriteSetMgr.instance:setChallengeSprite(self._imagelock, unselectBgName)
	gohelper.setActive(self._goselect_normaleffect, self._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(self._goselect_hardeffect, self._groupType == Act183Enum.GroupType.HardMain)
end

function Act183DungeonBaseGroupItem:_onFinishTask()
	self:refreshGroupTaskProgress()
end

function Act183DungeonBaseGroupItem:refreshGroupTaskProgress()
	local actId = Act183Model.instance:getActivityId()
	local taskCount, taskFinishCount = Act183Helper.getGroupEpisodeTaskProgress(actId, self._groupId)
	local isFinished = taskCount <= taskFinishCount

	gohelper.setActive(self._gofinished, isFinished)
end

function Act183DungeonBaseGroupItem:_onGroupAllTaskFinished(groupId)
	if self._groupId ~= groupId then
		return
	end

	self._animfinish:Play("in", 0, 0)
end

function Act183DungeonBaseGroupItem:onUnlock()
	return
end

function Act183DungeonBaseGroupItem:onLocked()
	return
end

function Act183DungeonBaseGroupItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, self._isUnlock and isSelect)
	gohelper.setActive(self._gounselect, self._isUnlock and not isSelect)
end

function Act183DungeonBaseGroupItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

function Act183DungeonBaseGroupItem:destroySelf()
	gohelper.destroy(self.go)
end

function Act183DungeonBaseGroupItem:onDestroy()
	return
end

return Act183DungeonBaseGroupItem
