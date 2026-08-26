-- chunkname: @modules/logic/meilanni/view/MeilanniMapItem.lua

module("modules.logic.meilanni.view.MeilanniMapItem", package.seeall)

local MeilanniMapItem = class("MeilanniMapItem", ListScrollCellExtend)

function MeilanniMapItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "go_finish/btn_story")
	self._golock = gohelper.findChild(self.viewGO, "go_lock")
	self._godoing = gohelper.findChild(self.viewGO, "go_doing")
	self._gofinish = gohelper.findChild(self.viewGO, "go_finish")
	self._imagegrade = gohelper.findChildImage(self.viewGO, "image_grade")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniMapItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
end

function MeilanniMapItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnstory:RemoveClickListener()
end

function MeilanniMapItem:_btnstoryOnClick()
	MeilanniMapItem.playStoryList(self._mapIndex)
end

function MeilanniMapItem.playStoryList(mapIndex)
	local storyList = {}

	for i, v in ipairs(lua_activity108_story.configList) do
		if v.bind == mapIndex then
			table.insert(storyList, v.story)
		end
	end

	if not storyList or #storyList < 1 then
		return
	end

	StoryController.instance:playStories(storyList)
end

function MeilanniMapItem:_btnclickOnClick()
	if self._lockStatus then
		self:_showLockToast(self._mapConfig)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	MeilanniMapItem.gotoMap(self._mapId)
end

function MeilanniMapItem.gotoMap(mapId)
	local mapInfo = MeilanniModel.instance:getMapInfo(mapId)

	if not mapInfo or mapInfo:checkFinish() then
		MeilanniController.instance:openMeilanniEntrustView({
			mapId = mapId
		})

		return
	end

	MeilanniController.instance:openMeilanniView({
		mapId = mapId
	})
end

function MeilanniMapItem:ctor(mapConfig)
	self._mapConfig = mapConfig
	self._mapId = self._mapConfig.id
	self._mapIndex = self._mapId - 100
end

function MeilanniMapItem:_editableInitView()
	return
end

function MeilanniMapItem:updateLockStatus()
	if self._needPlayUnlockAnim then
		return
	end

	gohelper.setActive(self._godoing, false)
	gohelper.setActive(self._gofinish, false)

	local oldStatus = self._lockStatus

	self._lockStatus = MeilanniMapItem.isLock(self._mapConfig)

	gohelper.setActive(self._golock, self._lockStatus)
	gohelper.setActive(self._imagegrade.gameObject, false)

	if self._lockStatus then
		return
	end

	local mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)

	if mapInfo and mapInfo.highestScore > 0 then
		gohelper.setActive(self._imagegrade.gameObject, true)

		local scoreIndex = MeilanniConfig.instance:getScoreIndex(mapInfo.highestScore)

		UISpriteSetMgr.instance:setMeilanniSprite(self._imagegrade, "bg_pingfen_xiao_" .. tostring(scoreIndex))
		gohelper.setActive(self._gofinish, true)
		gohelper.setActive(self._godoing, false)
	else
		gohelper.setActive(self._gofinish, false)
		gohelper.setActive(self._godoing, true)
	end

	if oldStatus then
		self._needPlayUnlockAnim = true
	end

	if self._needPlayUnlockAnim then
		gohelper.setActive(self._golock, true)
		TaskDispatcher.runDelay(self._playUnlockAnim, self, 0.5)
	end
end

function MeilanniMapItem:_playUnlockAnim()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._animatorPlayer:Play("unlock", self._unlockDone, self)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
end

function MeilanniMapItem:_unlockDone()
	self._needPlayUnlockAnim = nil

	gohelper.setActive(self._golock, false)
end

function MeilanniMapItem.isLock(mapConfig)
	if mapConfig.preId <= 0 then
		return false
	end

	local mapInfo = MeilanniModel.instance:getMapInfo(mapConfig.id)

	if mapInfo then
		return false
	end

	if mapConfig.onlineDay > 0 then
		local actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
		local unlockStartTime = actMO:getRealStartTimeStamp() + (mapConfig.onlineDay - 1) * 86400
		local seconds = unlockStartTime - ServerTime.now()

		if seconds > 0 then
			return true
		end
	end

	local mapInfo = MeilanniModel.instance:getMapInfo(mapConfig.preId)

	return not mapInfo or mapInfo.highestScore <= 0
end

function MeilanniMapItem:_showLockToast(mapConfig)
	if mapConfig.onlineDay > 0 then
		local actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
		local unlockStartTime = actMO:getRealStartTimeStamp() + (mapConfig.onlineDay - 1) * 86400
		local seconds = unlockStartTime - ServerTime.now()

		if seconds > 86400 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock2, math.ceil(seconds / 86400))

			return
		elseif seconds > 3600 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock3, math.ceil(seconds / 3600))

			return
		elseif seconds > 0 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock4)

			return
		end
	end

	if mapConfig.preId <= 0 then
		return
	end

	local mapInfo = MeilanniModel.instance:getMapInfo(mapConfig.preId)

	if not mapInfo or mapInfo.highestScore <= 0 then
		GameFacade.showToast(ToastEnum.MeilanniEntranceLock5)
	end
end

function MeilanniMapItem:_editableAddEvents()
	return
end

function MeilanniMapItem:_editableRemoveEvents()
	return
end

function MeilanniMapItem:onDestroyView()
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
end

return MeilanniMapItem
