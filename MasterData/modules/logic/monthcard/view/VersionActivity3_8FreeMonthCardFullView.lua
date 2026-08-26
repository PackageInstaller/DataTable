-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardFullView.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardFullView", package.seeall)

local VersionActivity3_8FreeMonthCardFullView = class("VersionActivity3_8FreeMonthCardFullView", BaseView)

function VersionActivity3_8FreeMonthCardFullView:onInitView()
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
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/#go_backdate/#btn_jump/#go_taskreddot")
	self._btnbuqian = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_backdate/#btn_buqian")
	self._godeadline = gohelper.findChild(self.viewGO, "root/#go_backdate/#go_deadline")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "root/#go_backdate/#go_deadline/#txt_deadline")
	self._gobuy = gohelper.findChild(self.viewGO, "root/#go_buy")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#btn_buy")
	self._gohasget = gohelper.findChild(self.viewGO, "root/#go_buy/#go_hasget")
	self._txthasget = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_hasget/#txt_hasget")
	self._txtlimitsigncount = gohelper.findChildText(self.viewGO, "root/#go_buy/tip01/#txt_limitsigncount")
	self._txtclaimcount = gohelper.findChildText(self.viewGO, "root/#go_buy/tip02/#txt_claimcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_8FreeMonthCardFullView:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnbuqian:AddClickListener(self._btnbuqianOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function VersionActivity3_8FreeMonthCardFullView:removeEvents()
	self._btntip:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btnbuqian:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
end

function VersionActivity3_8FreeMonthCardFullView:_btntipOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.V3a8FreeMonthCardTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.V3a8FreeMonthCardDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function VersionActivity3_8FreeMonthCardFullView:_btnjumpOnClick()
	MonthCardController.instance:openV3a8TaskView()
end

function VersionActivity3_8FreeMonthCardFullView:_btnbuqianOnClick()
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

function VersionActivity3_8FreeMonthCardFullView:_btnbuyOnClick()
	local curDay = VersionActivity3_8FreeMonthCardModel.instance:getCurSignDay()
	local couldGet = VersionActivity3_8FreeMonthCardModel.instance:isDayCanSign(curDay)

	if not couldGet then
		return
	end

	self:_showRewardGet()
end

function VersionActivity3_8FreeMonthCardFullView:_showRewardGet()
	for _, item in pairs(self._rewardItems) do
		gohelper.setActive(item.gocanget, false)
		gohelper.setActive(item.gohasget, true)
	end

	UIBlockMgr.instance:startBlock("waitShowMonthCardReward")
	TaskDispatcher.runDelay(self._startGetBonus, self, 1)
end

function VersionActivity3_8FreeMonthCardFullView:_startGetBonus()
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	Activity240Rpc.instance:sendAct240SignInRequest(self._actId)
end

function VersionActivity3_8FreeMonthCardFullView:_editableInitView()
	self:_initData()
	self:_addSelfEvents()
end

function VersionActivity3_8FreeMonthCardFullView:_initData()
	self._actId = VersionActivity3_8Enum.ActivityId.FreeMonthCard

	gohelper.setActive(self._gorewarditem, false)

	self._jumpAnim = self._btnjump.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._rewardItems = self:getUserDataTb_()
end

function VersionActivity3_8FreeMonthCardFullView:_addSelfEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, MonthCardController.instance, MonthCardEvent.onInfoChanged, self._refresh, self)
	self.addEventCb(self, MonthCardController.instance, MonthCardEvent.onSignStateChanged, self._refresh, self)
end

function VersionActivity3_8FreeMonthCardFullView:_removeSelfEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.removeEventCb(self, MonthCardController.instance, MonthCardEvent.onInfoChanged, self._refresh, self)
	self.removeEventCb(self, MonthCardController.instance, MonthCardEvent.onSignStateChanged, self._refresh, self)
end

function VersionActivity3_8FreeMonthCardFullView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refresh()
	end
end

function VersionActivity3_8FreeMonthCardFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum3_8.FreeMonthCard.play_ui_mln_unlock)
	self:_initReddot()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	self:_refresh()
end

function VersionActivity3_8FreeMonthCardFullView:_initReddot()
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.V3a8FreeMonthCardDailyBackdate, false)
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V3a8FreeMonthCardTask)
end

function VersionActivity3_8FreeMonthCardFullView:_refreshTime()
	self._txtlimittime.text = self:getRemainTimeStr()

	self:_refreshBackdateTime()
end

function VersionActivity3_8FreeMonthCardFullView:_refreshBackdateTime()
	local backdateCo = Activity240Config.instance:getActivity240BackdateCo()
	local itemCos = string.splitToNumber(backdateCo.cost, "#")
	local itemCount = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])

	gohelper.setActive(self._godeadline, itemCount > 0)

	if itemCount <= 0 then
		return
	end

	local itemDeadline = ItemExpireModel.instance:getSpecialExpireItemEarliestExpireTime(itemCos[2])

	if not itemDeadline or itemDeadline <= 0 then
		return
	end

	local limitSec = itemDeadline - ServerTime.now()
	local date, dateFormat = TimeUtil.secondToRoughTime(limitSec, true)

	self._txtdeadline.text = string.format("%s%s", date, dateFormat)
end

function VersionActivity3_8FreeMonthCardFullView:getRemainTimeStr()
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

function VersionActivity3_8FreeMonthCardFullView:_refresh()
	self:_refreshUI()
	self:_refreshRewards()
end

function VersionActivity3_8FreeMonthCardFullView:_refreshUI()
	local canBackdateDayCount = VersionActivity3_8FreeMonthCardModel.instance:getCanBackdateDayCount()
	local itemCount = VersionActivity3_8FreeMonthCardModel.instance:getCanBackdateDayItemCount()

	gohelper.setActive(self._gocanbackdate, canBackdateDayCount > 0 and itemCount > 0)
	gohelper.setActive(self._gonobackdate, canBackdateDayCount <= 0 or itemCount <= 0)

	local allTaskFinished = VersionActivity3_8FreeMonthCardModel.instance:isAllTasksFinished()
	local jumpAnimName = allTaskFinished and "idle" or "receive"

	self._jumpAnim:Play(jumpAnimName)

	local maxDay = VersionActivity3_8FreeMonthCardModel.instance:getMaxSignDay()
	local rewardGetDayCount = VersionActivity3_8FreeMonthCardModel.instance:getRewardGetDayCount()
	local allSign = maxDay <= rewardGetDayCount

	gohelper.setActive(self._gobackdate, not allSign)

	self._txtlimitsigncount.text = maxDay - rewardGetDayCount
	self._txtclaimcount.text = rewardGetDayCount

	if allSign then
		gohelper.setActive(self._gobackdate, false)
		gohelper.setActive(self._gohasget, true)

		self._txthasget.text = luaLang("p_v2a4_actxmasview_txt_Claimed")

		return
	end

	local curDay = VersionActivity3_8FreeMonthCardModel.instance:getCurSignDay()
	local canSign = VersionActivity3_8FreeMonthCardModel.instance:isDayCanSign(curDay)

	gohelper.setActive(self._btnbuy.gameObject, canSign)
	gohelper.setActive(self._gohasget, not canSign)

	if not canSign then
		self._txthasget.text = luaLang("p_v2a9_monthcard_panelview_txt_hasget")
	end

	gohelper.setActive(self._txtcanpatch.gameObject, canBackdateDayCount > 0)
	gohelper.setActive(self._golimittxt, canBackdateDayCount > 0)

	self._txtcanpatch.text = tostring(canBackdateDayCount)
end

function VersionActivity3_8FreeMonthCardFullView:_refreshRewards()
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

function VersionActivity3_8FreeMonthCardFullView:onClose()
	return
end

function VersionActivity3_8FreeMonthCardFullView:onDestroyView()
	self:_removeSelfEvents()
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	TaskDispatcher.cancelTask(self._startGetBonus, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)

	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			v.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return VersionActivity3_8FreeMonthCardFullView
