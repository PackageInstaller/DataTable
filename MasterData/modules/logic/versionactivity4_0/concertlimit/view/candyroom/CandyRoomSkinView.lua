-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomSkinView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomSkinView", package.seeall)

local CandyRoomSkinView = class("CandyRoomSkinView", BaseView)

function CandyRoomSkinView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Bg")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Root/skin/#btn_click")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/title/#simage_Title")
	self._goreward1 = gohelper.findChild(self.viewGO, "Root/reward/#go_reward1")
	self._goreward2 = gohelper.findChild(self.viewGO, "Root/reward/#go_reward2")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/btn/#btn_claim")
	self._golock = gohelper.findChild(self.viewGO, "Root/btn/#go_lock")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/btn/#go_lock/image_LimitTimeBG/#txt_LimitTime")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/btn/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CandyRoomSkinView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
end

function CandyRoomSkinView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
end

function CandyRoomSkinView:_btncloseOnClick()
	self:closeThis()
end

function CandyRoomSkinView:_btnclickOnClick()
	return
end

function CandyRoomSkinView:_btnclaimOnClick()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if not couldGet then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
end

function CandyRoomSkinView:_editableInitView()
	self._actId = CandyRoomModel.instance:getLoginActivityId(VersionActivity4_0Enum.ActivityId.ConcertCandyRoom)

	self:_addSelfEvents()
end

function CandyRoomSkinView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function CandyRoomSkinView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function CandyRoomSkinView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_fuleyuan_tansuo_bag_open)
	self:_refresh()
	self:_refreshRewards()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function CandyRoomSkinView:_refresh()
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	gohelper.setActive(self._btnclaim.gameObject, couldGet)
	gohelper.setActive(self._gohasget, rewardGet)
	gohelper.setActive(self._golock, not rewardGet and not couldGet)
end

function CandyRoomSkinView:_refreshRewards()
	local isGet = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)
	local rewardCos = CandyRoomModel.instance:getLoginActRewardCos(self._actId)

	for index, rewardCo in ipairs(rewardCos) do
		local goitem = gohelper.findChild(self["_goreward" .. tostring(index)], "go_item")
		local item = IconMgr.instance:getCommonItemIcon(goitem)

		item:setMOValue(rewardCo[1], rewardCo[2], rewardCo[3], nil, true)

		local gohasGet = gohelper.findChild(self["_goreward" .. tostring(index)], "go_hasget")

		gohelper.setActive(gohasGet, isGet)
	end
end

function CandyRoomSkinView:_refreshTime()
	local startTime = ActivityModel.instance:getActStartTime(self._actId)
	local remainTimeSec = startTime / 1000 - ServerTime.now()

	if remainTimeSec <= 0 then
		self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

		TaskDispatcher.cancelTask(self._refreshTime, self)
		Activity101Rpc.instance:sendGet101InfosRequest(self._actId)

		return
	end

	self._txtLimitTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_bubble"), TimeUtil.SecondToActivityTimeFormat(remainTimeSec))
end

function CandyRoomSkinView:onClose()
	return
end

function CandyRoomSkinView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self:_removeSelfEvents()
end

return CandyRoomSkinView
