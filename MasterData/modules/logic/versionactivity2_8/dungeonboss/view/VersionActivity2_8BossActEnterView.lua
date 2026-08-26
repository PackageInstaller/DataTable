-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossActEnterView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActEnterView", package.seeall)

local VersionActivity2_8BossActEnterView = class("VersionActivity2_8BossActEnterView", BaseView)

function VersionActivity2_8BossActEnterView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/title/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	self._goswitch = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch")
	self._gotype1 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	self._gotype2 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	self._gotype3 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	self._gotype4 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	self._gotype0 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	self._gorightarrow = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow/#go_right_arrow")
	self._gorightarrowdisable = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow/#go_right_arrow_disable")
	self._btnactivityreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/go_rewards/#btn_activityreward")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "anim/versionactivity/right/go_rewards/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/go_rewards/#scroll_rewards/Viewport/#go_rewards")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "anim/versionactivity/right/go_rewards/#scroll_rewards/Viewport/#go_rewards/#go_activityrewarditem")
	self._btnnormalStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	self._btnlockedStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_lockedStart")
	self._txtlocked = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_lockedStart/#txt_locked")
	self._golefttop = gohelper.findChild(self.viewGO, "anim/#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8BossActEnterView:addEvents()
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
	self._btnactivityreward:AddClickListener(self._btnactivityrewardOnClick, self)
	self._btnnormalStart:AddClickListener(self._btnnormalStartOnClick, self)
	self._btnlockedStart:AddClickListener(self._btnlockedStartOnClick, self)
end

function VersionActivity2_8BossActEnterView:removeEvents()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
	self._btnactivityreward:RemoveClickListener()
	self._btnnormalStart:RemoveClickListener()
	self._btnlockedStart:RemoveClickListener()
end

function VersionActivity2_8BossActEnterView:_btnleftarrowOnClick()
	self._index = self._index - 1

	self:_updateBtnStatus()
	self:_showEpisodeInfo()
end

function VersionActivity2_8BossActEnterView:_btnrightarrowOnClick()
	if not self._rightInteractable then
		GameFacade.showToast(ToastEnum.ToughBattleDiffcultLock)

		return
	end

	self._index = self._index + 1

	self:_updateBtnStatus()
	self:_showEpisodeInfo()
end

function VersionActivity2_8BossActEnterView:_btnactivityrewardOnClick()
	return
end

function VersionActivity2_8BossActEnterView:_btnnormalStartOnClick()
	local episodeConfig = self._episodeList[self._index]

	DungeonFightController.instance:enterFight(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity2_8BossActEnterView:_btnlockedStartOnClick()
	return
end

function VersionActivity2_8BossActEnterView:_editableInitView()
	self:_initChapterList()
	gohelper.setActive(self._goactivityrewarditem, false)
	gohelper.setActive(self._gotype0, false)
end

function VersionActivity2_8BossActEnterView:onUpdateParam()
	return
end

function VersionActivity2_8BossActEnterView:onOpen()
	self:_selectTargetEpisode()
	self:_unlockEpisode()
	self:_updateBtnStatus()
	self:_initEpisodeOpenTime()
	self:_showEpisodeInfo()
end

function VersionActivity2_8BossActEnterView:_selectTargetEpisode()
	if self.viewParam then
		local episodeId = self.viewParam.episodeId

		if not self.viewParam then
			local value = VersionActivity2_8DungeonBossController.getPrefsString(VersionActivity2_8BossEnum.PrefsKey.BossActSelected)

			episodeId = tonumber(value)
		end

		if self.viewParam then
			for i, v in ipairs(self._episodeList) do
				if v.id == self.viewParam then
					self._index = i

					break
				end
			end
		end
	end
end

function VersionActivity2_8BossActEnterView:_unlockEpisode()
	local isUnlock = false

	for i, v in ipairs(self._episodeList) do
		if i ~= 1 and DungeonModel.instance:hasPassLevel(v.preEpisode) and not VersionActivity2_8DungeonBossController.hasOnceActionKey(VersionActivity2_8BossEnum.PrefsKey.BossActUnlock, v.id) then
			VersionActivity2_8DungeonBossController.setOnceActionKey(VersionActivity2_8BossEnum.PrefsKey.BossActUnlock, v.id)

			self._index = i
			isUnlock = true
		end

		if DungeonModel.instance:hasPassLevel(v.id) then
			self._maxIndex = math.min(i + 1, #self._episodeList)
		end
	end

	if isUnlock then
		VersionActivity2_8DungeonBossController.instance:checkBossActReddot()
		GameFacade.showToast(ToastEnum.ToughBattleDiffcultUnLock, luaLang("p_versionactivitydungeonmaplevelview_type" .. self._index))
		TaskDispatcher.cancelTask(self._playUnlockAnim, self)
		TaskDispatcher.runDelay(self._playUnlockAnim, self, 0.6)
	end
end

function VersionActivity2_8BossActEnterView:_playUnlockAnim()
	gohelper.setActive(self._gotype0, true)

	local animator = self._gotype0:GetComponent("Animator")

	animator:Play("unlock", 0, 0)
end

function VersionActivity2_8BossActEnterView:_initEpisodeOpenTime()
	self._singleModeEpisodeConfig = lua_single_mode_episode.configDict[VersionActivity2_8BossEnum.BossActChapterId]

	local actStartTime = ActivityModel.instance:getActStartTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000
	local actEndTime = ActivityModel.instance:getActEndTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000

	self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(actEndTime - ServerTime.now())

	local firstOpenDay = 0
	local secondOpenDay = firstOpenDay + tonumber(lua_boss_fight_mode_const.configDict[1].value)
	local thirdOpenDay = firstOpenDay + tonumber(lua_boss_fight_mode_const.configDict[2].value)

	self._openTimeList = {
		actStartTime + firstOpenDay * TimeUtil.OneDaySecond,
		actStartTime + secondOpenDay * TimeUtil.OneDaySecond,
		actStartTime + thirdOpenDay * TimeUtil.OneDaySecond
	}
end

function VersionActivity2_8BossActEnterView:_initChapterList()
	self._episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity2_8BossEnum.BossActChapterId)
	self._index = 1
	self._maxIndex = 1
	self._totalIndex = #self._episodeList
end

function VersionActivity2_8BossActEnterView:_updateBtnStatus()
	gohelper.setActive(self._btnleftarrow, self._index ~= 1)
	gohelper.setActive(self._btnrightarrow, self._index ~= self._totalIndex)

	local interactable = self._index < self._maxIndex

	gohelper.setActive(self._gorightarrow, interactable)
	gohelper.setActive(self._gorightarrowdisable, not interactable)

	self._rightInteractable = interactable
end

function VersionActivity2_8BossActEnterView:_showEpisodeInfo()
	TaskDispatcher.cancelTask(self._checkOpen, self)

	local episodeConfig = self._episodeList[self._index]

	self._txtactivitydesc.text = episodeConfig.desc

	for i = 1, 4 do
		gohelper.setActive(self["_gotype" .. i], false)
	end

	gohelper.setActive(self["_gotype" .. self._index], true)
	self:_showRewards(episodeConfig)

	local isOpen = self._openTimeList[self._index] <= ServerTime.now()

	gohelper.setActive(self._btnnormalStart, isOpen)
	gohelper.setActive(self._btnlockedStart, not isOpen)
	TaskDispatcher.cancelTask(self._updateCountDownTxt, self)

	if not isOpen then
		TaskDispatcher.runRepeat(self._updateCountDownTxt, self, 1)
		self:_updateCountDownTxt()

		local time = self._openTimeList[self._index] - ServerTime.now()

		TaskDispatcher.runDelay(self._checkOpen, self, time)
	end

	VersionActivity2_8DungeonBossController.setPrefsString(VersionActivity2_8BossEnum.PrefsKey.BossActSelected, episodeConfig.id)
end

function VersionActivity2_8BossActEnterView:_updateCountDownTxt()
	local time = self._openTimeList[self._index] - ServerTime.now()
	local timeStr = TimeUtil.SecondToActivityTimeFormat(time)

	self._txtlocked.text = formatLuaLang("test_task_unlock_time", timeStr)
end

function VersionActivity2_8BossActEnterView:_checkOpen()
	self:_showEpisodeInfo()
end

function VersionActivity2_8BossActEnterView:_showRewards(episodeConfig)
	if self._itemList then
		for i, v in ipairs(self._itemList) do
			gohelper.setActive(v, false)
		end
	end

	local list = DungeonConfig.instance:getRewardItems(episodeConfig.firstBonus)
	local hasPassed = DungeonModel.instance:hasPassLevel(episodeConfig.id)

	for k, v in ipairs(list) do
		local go = self:_getItemGo(k)

		gohelper.setActive(go, true)

		local hasGet = gohelper.findChild(go, "go_receive")

		gohelper.setActive(hasGet, hasPassed)

		local icon = gohelper.findChild(go, "go_icon")

		gohelper.destroyAllChildren(icon)

		local cell_component = IconMgr.instance:getCommonItemIcon(icon)

		gohelper.setAsFirstSibling(cell_component.go)
		cell_component:setMOValue(v[1], v[2], v[3], nil, true)
		cell_component:setCountFontSize(32)
		cell_component:showStackableNum()

		local countBg = cell_component:getCountBg()

		recthelper.setAnchorY(countBg.transform, 50)
	end

	self._scrollrewards.horizontalNormalizedPosition = 0
end

function VersionActivity2_8BossActEnterView:_getItemGo(index)
	self._itemList = self._itemList or self:getUserDataTb_()
	self._itemList[index] = self._itemList[index] or gohelper.cloneInPlace(self._goactivityrewarditem, index)

	return self._itemList[index]
end

function VersionActivity2_8BossActEnterView:onClose()
	TaskDispatcher.cancelTask(self._checkOpen, self)
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
	TaskDispatcher.cancelTask(self._updateCountDownTxt, self)
end

function VersionActivity2_8BossActEnterView:onDestroyView()
	return
end

return VersionActivity2_8BossActEnterView
