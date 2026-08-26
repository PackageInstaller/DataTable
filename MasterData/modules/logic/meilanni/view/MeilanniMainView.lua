-- chunkname: @modules/logic/meilanni/view/MeilanniMainView.lua

module("modules.logic.meilanni.view.MeilanniMainView", package.seeall)

local MeilanniMainView = class("MeilanniMainView", BaseView)

function MeilanniMainView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simageheroup1 = gohelper.findChildSingleImage(self.viewGO, "#simage_hero_up1")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "#simage_hero")
	self._goday = gohelper.findChild(self.viewGO, "remaintime/#go_day")
	self._txtremainday = gohelper.findChildText(self.viewGO, "remaintime/#go_day/#txt_remainday")
	self._gohour = gohelper.findChild(self.viewGO, "remaintime/#go_hour")
	self._txtremainhour = gohelper.findChildText(self.viewGO, "remaintime/#go_hour/#txt_remainhour")
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._gomaplist = gohelper.findChild(self.viewGO, "#go_maplist")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_maplist/#btn_end")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._imageremainday = gohelper.findChildImage(self.viewGO, "#go_lock/horizontal/part2/#image_remainday")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._gotaskredpoint = gohelper.findChild(self.viewGO, "#btn_task/#go_taskredpoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniMainView:addEvents()
	self._btnend:AddClickListener(self._btnendOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
end

function MeilanniMainView:removeEvents()
	self._btnend:RemoveClickListener()
	self._btntask:RemoveClickListener()
end

function MeilanniMainView:_btnendOnClick()
	MeilanniMapItem.playStoryList(MeilanniEnum.endStoryBindIndex)
end

function MeilanniMainView:_btntaskOnClick()
	MeilanniController.instance:openMeilanniTaskView()
end

function MeilanniMainView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getMeilanniIcon("full/bg_beijing"))
	self._simagehero:LoadImage(ResUrl.getMeilanniIcon("bg_renwu"))
	gohelper.addUIClickAudio(self._btntask.gameObject, AudioEnum.UI.play_ui_common_pause)
	RedDotController.instance:addRedDot(self._gotaskredpoint, RedDotEnum.DotNode.MeilanniTaskBtn)
	UIBlockMgr.instance:endAll()
end

function MeilanniMainView:_checkFinishAllMapStory()
	for i, v in ipairs(lua_activity108_map.configList) do
		local mapId = v.id

		if MeilanniModel.instance:getMapHighestScore(mapId) <= 0 then
			self:_forceUpdateTime()

			return
		end
	end

	local storyList = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.finishAllMap)

	for i, v in ipairs(storyList) do
		local config = v[1]
		local storyId = config.story

		if not StoryModel.instance:isStoryFinished(storyId) then
			StoryController.instance:playStory(storyId, nil, self._finishAllMapCallback, self)

			return
		end
	end

	self:_forceUpdateTime()
end

function MeilanniMainView:_finishAllMapCallback()
	self:_forceUpdateTime()
end

function MeilanniMainView:_forceUpdateTime()
	local seconds = self:_getLockTime()

	if seconds > 0 then
		self:_showMapList()
	end

	self._openMeilanniView = false

	self:_updateTime()
end

function MeilanniMainView:_checkOpenDayAndFinishMapStory()
	local storyId = MeilanniMainView.getOpenDayAndFinishMapStory()

	if storyId then
		StoryController.instance:playStory(storyId)
	end
end

function MeilanniMainView.getOpenDayAndFinishMapStory()
	local actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
	local seconds = ServerTime.now() - actMO:getRealStartTimeStamp()

	if seconds <= 0 then
		return
	end

	local storyList = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.openDayAndFinishMap)
	local day = math.ceil(seconds / 86400)

	for i, v in ipairs(storyList) do
		local mapInfo = MeilanniModel.instance:getMapInfo(v[3])

		if day >= v[2] and mapInfo and (mapInfo:checkFinish() or mapInfo.highestScore > 0) then
			local config = v[1]
			local storyId = config.story

			if not StoryModel.instance:isStoryFinished(storyId) then
				return storyId
			end

			break
		end
	end
end

function MeilanniMainView:_checkOpenDayStory()
	local seconds = ServerTime.now() - self._actMO:getRealStartTimeStamp()

	if seconds <= 0 then
		return
	end

	local storyList = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.openDay)
	local day = math.ceil(seconds / 86400)

	for i, v in ipairs(storyList) do
		if day >= v[2] then
			local config = v[1]
			local storyId = config.story

			if not StoryModel.instance:isStoryFinished(storyId) then
				StoryController.instance:playStory(storyId)
			end

			break
		end
	end
end

function MeilanniMainView:_checkStory()
	if self.viewParam then
		if not self.viewParam then
			return
		end

		self:_checkOpenDayStory()
		self:_checkOpenDayAndFinishMapStory()
		self:_checkFinishAllMapStory()
	end
end

function MeilanniMainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.MeilanniView then
		TaskDispatcher.runDelay(self._checkFinishAllMapStory, self, 0)
	end

	if viewName == ViewName.StoryView and not self._hasOpenMeilanniView then
		local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

		animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function MeilanniMainView:_onOpenViewFinish(viewName)
	if viewName == ViewName.MeilanniView then
		self._openMeilanniView = true
		self._hasOpenMeilanniView = true
	end
end

function MeilanniMainView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
	self._endTime = self._actMO:getRealEndTimeStamp()
	self._mapItemList = self:getUserDataTb_()

	self:_showMapList()

	self._unlockMapConfig = lua_activity108_map.configDict[MeilanniEnum.unlockMapId]
	self._unlockStartTime = self._actMO:getRealStartTimeStamp() + (self._unlockMapConfig.onlineDay - 1) * 86400

	self:_updateTime()
	TaskDispatcher.runRepeat(self._updateTime, self, 1)
	self:_checkStory()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_cardappear)
end

function MeilanniMainView:_updateTime()
	local remainTimeSec = self._endTime - ServerTime.now()

	if remainTimeSec <= 0 then
		ViewMgr.instance:closeView(ViewName.MeilanniTaskView)
		ViewMgr.instance:closeView(ViewName.MeilanniEntrustView)
		ViewMgr.instance:closeView(ViewName.MeilanniView)
		ViewMgr.instance:closeView(ViewName.MeilanniSettlementView)
		ViewMgr.instance:closeView(ViewName.MeilanniMainView)

		return
	end

	if self._openMeilanniView then
		return
	end

	local day, hour = TimeUtil.secondsToDDHHMMSS(remainTimeSec)
	local showDay = day > 0

	if showDay then
		self._txtremainday.text = day
	else
		self._txtremainhour.text = hour
	end

	gohelper.setActive(self._goday, showDay)
	gohelper.setActive(self._gohour, not showDay)

	local seconds = self:_getLockTime()

	if seconds > 0 then
		local day = math.ceil(seconds / 86400)

		day = math.max(math.min(day, 6), 1)

		UISpriteSetMgr.instance:setMeilanniSprite(self._imageremainday, "bg_daojishi_" .. day)
		self._simageheroup1:LoadImage(ResUrl.getMeilanniIcon("bg_renwu_2"))
	else
		gohelper.setActive(self._golock, false)
		self._simageheroup1:LoadImage(ResUrl.getMeilanniIcon("bg_renwu_1"))
		self:_showMapList()
	end
end

function MeilanniMainView:_getLockTime()
	return self._unlockStartTime - ServerTime.now()
end

function MeilanniMainView:_showMapList()
	for i, v in ipairs(lua_activity108_map.configList) do
		local go = gohelper.findChild(self._gomaplist, "pos" .. i)

		if not self._mapItemList[v.id] then
			local mapItem = self:_getMapItem(go, v)

			self._mapItemList[v.id] = self._mapItemList[v.id]

			self._mapItemList[v.id]:updateLockStatus()

			if v.id == 104 then
				local mapInfo = MeilanniModel.instance:getMapInfo(v.id)

				gohelper.setActive(self._btnend, mapInfo and mapInfo.highestScore > 0)
			end
		end
	end
end

function MeilanniMainView:_getMapItem(go, mapConfig)
	local itemGo = gohelper.findChild(go, "item")

	return (MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MeilanniMapItem, mapConfig))
end

function MeilanniMainView:onClose()
	TaskDispatcher.cancelTask(self._updateTime, self)
	TaskDispatcher.cancelTask(self._checkFinishAllMapStory, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function MeilanniMainView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simageheroup1:UnLoadImage()
	self._simagehero:UnLoadImage()
end

return MeilanniMainView
