-- chunkname: @modules/logic/versionactivity2_2/act101/view/VersionActivity2_2RoomSignItem.lua

module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignItem", package.seeall)

local VersionActivity2_2RoomSignItem = class("VersionActivity2_2RoomSignItem", ListScrollCellExtend)

function VersionActivity2_2RoomSignItem:init(go)
	self.viewGO = go
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "Root/#txt_title")
	self._goLock = gohelper.findChild(self.viewGO, "Root/lock")
	self._txtTime = gohelper.findChildTextMesh(self.viewGO, "Root/lock/#txt_LimitTime")
	self._goUnlock = gohelper.findChild(self.viewGO, "Root/unlock")
	self._simagePic = gohelper.findChildSingleImage(self.viewGO, "Root/unlock/#image_pic")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "Root/unlock/#scroll_ItemList/Viewport/Content/#txt_dec")
	self._goIcon = gohelper.findChild(self.viewGO, "Root/unlock/#go_reward/go_icon")
	self._goHasGet = gohelper.findChild(self.viewGO, "Root/unlock/#go_reward/hasget")
	self._goCanGet = gohelper.findChild(self.viewGO, "Root/unlock/#go_reward/canget")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "Root/lock/btn_click")
	self._btnGetReward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/unlock/#go_reward/canget")
end

function VersionActivity2_2RoomSignItem:addEventListeners()
	self.addClickCb(self, self._btnLock, self.onClickBtnLock, self)
	self.addClickCb(self, self._btnGetReward, self.onClickBtnReward, self)
end

function VersionActivity2_2RoomSignItem:removeEventListeners()
	self:removeClickCb(self._btnLock)
	self:removeClickCb(self._btnGetReward)
end

function VersionActivity2_2RoomSignItem:onClickBtnLock()
	self:onClickBtn()
end

function VersionActivity2_2RoomSignItem:onClickBtnReward()
	self:onClickBtn()
end

function VersionActivity2_2RoomSignItem:onClickBtn()
	if not self.id then
		return
	end

	local unlock, remainDay = self.actInfo:isEpisodeDayOpen(self.id)
	local hasGet = self.actInfo:isEpisodeFinished(self.id)
	local canGet = unlock and not hasGet

	if canGet then
		Activity125Rpc.instance:sendFinishAct125EpisodeRequest(self.activityId, self.id, self.config.targetFrequency)
	end

	if not unlock then
		GameFacade.showToastString(formatLuaLang("versionactivity_1_2_119_unlock", remainDay))
	end
end

function VersionActivity2_2RoomSignItem:onUpdateMO(config, actInfo)
	self.config = config
	self.actInfo = actInfo
	self.activityId = nil
	self.id = nil

	gohelper.setActive(self.viewGO, config ~= nil)

	if not config then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

		return
	end

	self.activityId = self.config.activityId
	self.id = self.config.id

	if self.actInfo:isEpisodeDayOpen(self.id) and not self.actInfo:checkLocalIsPlay(self.id) then
		self:refreshItem(false)
		TaskDispatcher.runDelay(self.refreshItem, self, 0.4)
	else
		self:refreshItem()
	end
end

function VersionActivity2_2RoomSignItem:refreshItem(unlock)
	local x = 506 * self._index - 488
	local y = -28

	recthelper.setAnchor(self.viewGO.transform, x, y)
	transformhelper.setEulerAngles(self.viewGO.transform, 0, 0, self._index % 2 == 1 and -1.64 or 0)

	self._txtTitle.text = self.config.name
	self._txtDesc.text = self.config.text

	if unlock == nil then
		unlock = self.actInfo:isEpisodeDayOpen(self.id)
	end

	if unlock and not self.actInfo:checkLocalIsPlay(self.id) then
		self.actInfo:setLocalIsPlay(self.id)
		self._anim:Play("unlock")
	end

	gohelper.setActive(self._goLock, not unlock)
	gohelper.setActive(self._txtTime, not unlock)
	gohelper.setActive(self._goUnlock, unlock)

	local hasGet = self.actInfo:isEpisodeFinished(self.id)
	local canGet = unlock and not hasGet

	gohelper.setActive(self._goHasGet, hasGet)
	gohelper.setActive(self._goCanGet, canGet)

	if unlock then
		self._simagePic:LoadImage(string.format("singlebg/v2a2_mainactivity_singlebg/v2a2_room_pic%s.png", self.id))
		self:refreshIcon()
	end

	self:_showDeadline()
end

function VersionActivity2_2RoomSignItem:refreshIcon()
	local bounds = GameUtil.splitString2(self.config.bonus, true)

	self.itemIcon = self.itemIcon or IconMgr.instance:getCommonPropItemIcon(self._goIcon)

	local reward1 = bounds[1]

	if reward1 then
		self.itemIcon:setMOValue(reward1[1], reward1[2], reward1[3], nil, true)
		self.itemIcon:setScale(0.5)
	end
end

function VersionActivity2_2RoomSignItem:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
end

function VersionActivity2_2RoomSignItem:_onRefreshDeadline()
	local unlock, remainDay, remainTime = self.actInfo:isEpisodeDayOpen(self.id)

	if unlock then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
		gohelper.setActive(self._txtTime, false)

		return
	end

	if remainTime < TimeUtil.OneDaySecond then
		local timeStr = TimeUtil.getFormatTime2(remainTime)

		self._txtTime.text = formatLuaLang("season123_overview_unlocktime_custom", timeStr)
	else
		self._txtTime.text = formatLuaLang("season123_overview_unlocktime", remainDay)
	end
end

function VersionActivity2_2RoomSignItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshItem, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	self._simagePic:UnLoadImage()
end

return VersionActivity2_2RoomSignItem
