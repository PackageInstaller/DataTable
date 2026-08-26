-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardPanelView.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardPanelView", package.seeall)

local VersionActivity3_8FreeMonthCardPanelView = class("VersionActivity3_8FreeMonthCardPanelView", BaseView)

function VersionActivity3_8FreeMonthCardPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "root/simage_title/#btn_tip")
	self._golimittime = gohelper.findChild(self.viewGO, "root/#go_limittime")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "root/#go_limittime/#txt_limittime")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/scroll_reward/Viewport/Content/#go_rewarditem")
	self._gobackdate = gohelper.findChild(self.viewGO, "root/#go_backdate")
	self._gocanpatch = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_canpatch")
	self._gocanbackdate = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_canpatch/#go_canbackdate")
	self._gonobackdate = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_canpatch/#go_nobackdate")
	self._golimittxt = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_canpatch/limittxt")
	self._txtcanpatch = gohelper.findChildText(self.viewGO, "root/#go_backdate/#go_canpatch/#txt_canpatch")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_backdate/#btn_jump")
	self._btnbuqian = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_backdate/#btn_buqian")
	self._godeadline = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_deadline")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "root/#go_backdate/#go_deadline/#txt_deadline")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_reddot")
	self._gobuy = gohelper.findChild(self.viewGO, "root/#go_buy")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#btn_buy")
	self._gohasget = gohelper.findChild(self.viewGO, "root/#go_buy/#go_hasget")
	self._txtlimitsigncount = gohelper.findChildText(self.viewGO, "root/#go_buy/tip01/#txt_limitsigncount")
	self._txtclaimcount = gohelper.findChildText(self.viewGO, "root/#go_buy/tip02/#txt_claimcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_8FreeMonthCardPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnbuqian:AddClickListener(self._btnbuqianOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function VersionActivity3_8FreeMonthCardPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btntip:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btnbuqian:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
end

function VersionActivity3_8FreeMonthCardPanelView:_btntipOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.V3a8FreeMonthCardTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.V3a8FreeMonthCardDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function VersionActivity3_8FreeMonthCardPanelView:_btnjumpOnClick()
	MonthCardController.instance:openV3a8TaskView()
end

function VersionActivity3_8FreeMonthCardPanelView:_btnbuqianOnClick()
	local totalDayCount = VersionActivity3_8FreeMonthCardModel.instance:getCanBackdateTotalDayCount(self._actId)

	if totalDayCount <= 0 then
		GameFacade.showToast(ToastEnum.V3a8MonthCardNoDayBackdate)

		return
	end

	local itemCount = VersionActivity3_8FreeMonthCardModel.instance:getCanBackdateDayItemCount(self._actId)

	if itemCount <= 0 then
		GameFacade.showToast(ToastEnum.V3a8MonthCardNoItemBackdate)

		return
	end

	Activity240Rpc.instance:sendAct240BackdateRequest(self._actId)
end

function VersionActivity3_8FreeMonthCardPanelView:_btnbuyOnClick()
	UIBlockMgr.instance:endBlock("VersionActivity3_8FreeMonthCardGetReward")

	local curDay = VersionActivity3_8FreeMonthCardModel.instance:getCurSignDay()
	local couldGet = VersionActivity3_8FreeMonthCardModel.instance:isDayCanSign(curDay)

	if not couldGet then
		return
	end

	self:_showRewardGet()
end

function VersionActivity3_8FreeMonthCardPanelView:_showRewardGet()
	for _, item in pairs(self._rewardItems) do
		gohelper.setActive(item.gocanget, false)
		gohelper.setActive(item.gohasget, true)
	end

	TaskDispatcher.runDelay(self._startGetBonus, self, 0.5)
end

function VersionActivity3_8FreeMonthCardPanelView:_startGetBonus()
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	Activity240Rpc.instance:sendAct240SignInRequest(self._actId)
end

function VersionActivity3_8FreeMonthCardPanelView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity3_8FreeMonthCardPanelView:_editableInitView()
	self:_initData()
	self:_addSelfEvents()
end

function VersionActivity3_8FreeMonthCardPanelView:_initData()
	self._actId = VersionActivity3_8Enum.ActivityId.FreeMonthCard

	gohelper.setActive(self._gorewarditem, false)
	gohelper.setActive(self._btnjump.gameObject, false)

	self._buyAnim = self._gobuy:GetComponent(typeof(UnityEngine.Animator))
	self._rewardItems = self:getUserDataTb_()
end

function VersionActivity3_8FreeMonthCardPanelView:_addSelfEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, MonthCardController.instance, MonthCardEvent.onInfoChanged, self._refresh, self)
	self.addEventCb(self, MonthCardController.instance, MonthCardEvent.onSignStateChanged, self._refresh, self)
end

function VersionActivity3_8FreeMonthCardPanelView:_removeSelfEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.removeEventCb(self, MonthCardController.instance, MonthCardEvent.onInfoChanged, self._refresh, self)
	self.removeEventCb(self, MonthCardController.instance, MonthCardEvent.onSignStateChanged, self._refresh, self)
end

function VersionActivity3_8FreeMonthCardPanelView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refresh()
	end
end

function VersionActivity3_8FreeMonthCardPanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_8.FreeMonthCard.play_ui_mln_unlock)
	self:_refreshTime()
	self._buyAnim:Play("receive", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitShowMonthCardReward")
	TaskDispatcher.runDelay(self._playGetAudio, self, 0.7)
	TaskDispatcher.runDelay(self._btnbuyOnClick, self, 1.5)
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	Activity240Rpc.instance:sendAct240GetInfoRequest(self._actId)
end

function VersionActivity3_8FreeMonthCardPanelView:_playGetAudio()
	AudioMgr.instance:trigger(AudioEnum3_8.FreeMonthCard.play_ui_wulu_kerandian_monster02_stand)
end

function VersionActivity3_8FreeMonthCardPanelView:_refreshTime()
	self._txtlimittime.text = self:getRemainTimeStr()

	self:_refreshBackdateTime()
end

function VersionActivity3_8FreeMonthCardPanelView:_refreshBackdateTime()
	local backdateCo = Activity240Config.instance:getActivity240BackdateCo()
	local itemCos = string.splitToNumber(backdateCo.cost, "#")
	local itemCount = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])

	gohelper.setActive(self._godeadline, itemCount > 0)

	if itemCount <= 0 then
		return
	end

	local itemDeadline = ItemExpireModel.instance:getSpecialExpireItemEarliestExpireTime(itemCos[2])

	if itemDeadline and itemDeadline > 0 then
		local limitSec = itemDeadline - ServerTime.now()
		local date, dateFormat = TimeUtil.secondToRoughTime(limitSec, true)

		self._txtdeadline.text = string.format("%s%s", date, dateFormat)
	end
end

function VersionActivity3_8FreeMonthCardPanelView:getRemainTimeStr()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(self._actId) or 0

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function VersionActivity3_8FreeMonthCardPanelView:_refresh()
	self:_refreshUI()
	self:_refreshRewards()
end

function VersionActivity3_8FreeMonthCardPanelView:_refreshUI()
	local itemCount = VersionActivity3_8FreeMonthCardModel.instance:getCanBackdateDayItemCount()
	local canBackdateDayCount = VersionActivity3_8FreeMonthCardModel.instance:getCanBackdateDayCount()

	gohelper.setActive(self._gocanbackdate, canBackdateDayCount > 0 and itemCount > 0)
	gohelper.setActive(self._gonobackdate, canBackdateDayCount <= 0 or itemCount <= 0)

	local maxDay = VersionActivity3_8FreeMonthCardModel.instance:getMaxSignDay()
	local rewardGetDayCount = VersionActivity3_8FreeMonthCardModel.instance:getRewardGetDayCount()
	local allSign = maxDay <= rewardGetDayCount

	gohelper.setActive(self._gobackdate, not allSign)

	self._txtlimitsigncount.text = maxDay - rewardGetDayCount
	self._txtclaimcount.text = rewardGetDayCount

	if allSign then
		gohelper.setActive(self._gobackdate, false)
		gohelper.setActive(self._gohasget, true)

		return
	end

	local curDay = VersionActivity3_8FreeMonthCardModel.instance:getCurSignDay()
	local canSign = VersionActivity3_8FreeMonthCardModel.instance:isDayCanSign(curDay)

	gohelper.setActive(self._btnbuy.gameObject, canSign)
	gohelper.setActive(self._gohasget, not canSign)
	gohelper.setActive(self._txtcanpatch.gameObject, canBackdateDayCount > 0)
	gohelper.setActive(self._golimittxt, canBackdateDayCount > 0)

	self._txtcanpatch.text = tostring(canBackdateDayCount)
end

function VersionActivity3_8FreeMonthCardPanelView:_refreshRewards()
	local curDay = VersionActivity3_8FreeMonthCardModel.instance:getCurSignDay()
	local couldGet = VersionActivity3_8FreeMonthCardModel.instance:isDayCanSign(curDay)
	local act240Config = Activity240Config.instance:getActivity240Co(curDay, self._actId)
	local rewards = string.split(act240Config.bonus, "|")

	for i, reward in ipairs(rewards) do
		if not self._rewardItems[i] then
			local item = {}

			item.go = gohelper.cloneInPlace(self._gorewarditem)
			item.goicon = gohelper.findChild(item.go, "go_icon")
			item.item = IconMgr.instance:getCommonItemIcon(item.goicon)
			item.gocanget = gohelper.findChild(item.go, "go_canget")
			item.btn = gohelper.getClickWithAudio(item.gocanget)

			item.btn:AddClickListener(self._btnbuyOnClick, self)

			item.gohasget = gohelper.findChild(item.go, "go_hasget")

			table.insert(self._rewardItems, item)
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local props = string.splitToNumber(reward, "#")

		self._rewardItems[i].item:setMOValue(props[1], props[2], props[3], nil, true)
		self._rewardItems[i].item:setCountFontSize(46)
		self._rewardItems[i].item:isShowName(false)
		gohelper.setActive(self._rewardItems[i].gocanget, couldGet)
		gohelper.setActive(self._rewardItems[i].gohasget, not couldGet)
	end
end

function VersionActivity3_8FreeMonthCardPanelView:onClose()
	return
end

function VersionActivity3_8FreeMonthCardPanelView:onDestroyView()
	self:_removeSelfEvents()
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	TaskDispatcher.cancelTask(self._playGetAudio, self)
	TaskDispatcher.cancelTask(self._startGetBonus, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)
	TaskDispatcher.cancelTask(self._btnbuyOnClick, self)

	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			v.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return VersionActivity3_8FreeMonthCardPanelView
