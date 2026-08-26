-- chunkname: @modules/logic/activity/view/V2a9_FreeMonthCard_PanelView.lua

module("modules.logic.activity.view.V2a9_FreeMonthCard_PanelView", package.seeall)

local V2a9_FreeMonthCard_PanelView = class("V2a9_FreeMonthCard_PanelView", BaseView)

function V2a9_FreeMonthCard_PanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttime = gohelper.findChildText(self.viewGO, "root/#go_time/#txt_time")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_Reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "root/#btn_hasget")
	self._godoneget = gohelper.findChild(self.viewGO, "root/#btn_doneget")
	self._txtcanget = gohelper.findChildText(self.viewGO, "root/Limit/canget/#txt_canget")
	self._txthasget = gohelper.findChildText(self.viewGO, "root/Limit/hasget/#txt_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_FreeMonthCard_PanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
end

function V2a9_FreeMonthCard_PanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncheck:RemoveClickListener()
	self._btncanget:RemoveClickListener()
end

function V2a9_FreeMonthCard_PanelView:_btncloseOnClick()
	self:closeThis()
end

function V2a9_FreeMonthCard_PanelView:_btncheckOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.FreeMonthCardTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.FreeMonthCardDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function V2a9_FreeMonthCard_PanelView:_btncangetOnClick()
	self:_setRewardGet()
end

function V2a9_FreeMonthCard_PanelView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refreshUI()
	end
end

function V2a9_FreeMonthCard_PanelView:_editableInitView()
	self._rewardItems = {}
end

function V2a9_FreeMonthCard_PanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.VersionActivity2_9FreeMonthCard.play_ui_cikeshang_yueka_unfold)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)

	self._actId = ActivityEnum.Activity.V2a9_FreeMonthCard

	gohelper.setActive(self._gorewarditem, false)
	self:_refreshTimeTick()
	self:_refreshUI()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	local couldGet = V2a9FreeMonthCardModel.instance:isCurDayCouldGet()

	if couldGet then
		UIBlockMgr.instance:startBlock("waitShowMonthCardIn")
		TaskDispatcher.runDelay(self._setRewardGet, self, 0.87)
	end
end

function V2a9_FreeMonthCard_PanelView:_setRewardGet()
	UIBlockMgr.instance:endBlock("waitShowMonthCardIn")

	local couldGet = V2a9FreeMonthCardModel.instance:isCurDayCouldGet()

	if couldGet then
		for _, item in pairs(self._rewardItems) do
			gohelper.setActive(item.gocanget, false)
			gohelper.setActive(item.goreceive, true)
			item.getAnim:Play("go_hasget_in", 0, 0)
		end

		UIBlockMgr.instance:startBlock("waitShowMonthCardReward")
		TaskDispatcher.runDelay(self._startGetBonus, self, 1)
	end
end

function V2a9_FreeMonthCard_PanelView:_startGetBonus()
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")

	local curDay = V2a9FreeMonthCardModel.instance:getCurDay()

	if curDay > 0 then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, curDay)
	end

	local loginDay = ActivityType101Model.instance:getType101LoginCount(self._actId)

	if loginDay > V2a9FreeMonthCardModel.LoginMaxDay then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, loginDay)
	end
end

function V2a9_FreeMonthCard_PanelView:_refreshTimeTick()
	self._txttime.text = self:getRemainTimeStr()
end

function V2a9_FreeMonthCard_PanelView:getRemainTimeStr()
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

function V2a9_FreeMonthCard_PanelView:_refreshUI()
	local rewardGetDayCount = V2a9FreeMonthCardModel.instance:getRewardTotalDay()
	local loginDay = ActivityType101Model.instance:getType101LoginCount(self._actId)
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(self._actId, loginDay)
	local curDay = V2a9FreeMonthCardModel.instance:getCurDay()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, curDay)

	self._txthasget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("freemonthcard_hasget_day"), {
		rewardGetDayCount
	})
	self._txtcanget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("freemonthcard_canget_day"), {
		V2a9FreeMonthCardModel.LoginMaxDay - rewardGetDayCount
	})

	gohelper.setActive(self._btncanget.gameObject, not rewardGet and rewardGetDayCount < V2a9FreeMonthCardModel.LoginMaxDay)
	gohelper.setActive(self._gohasget, rewardGet and rewardGetDayCount < V2a9FreeMonthCardModel.LoginMaxDay)
	gohelper.setActive(self._godoneget, rewardGetDayCount >= V2a9FreeMonthCardModel.LoginMaxDay)

	local rewardDay = curDay > 0 and curDay or 1
	local actRewardConfig = ActivityConfig.instance:getNorSignActivityCo(self._actId, rewardDay)
	local rewards = string.split(actRewardConfig.bonus, "|")

	for i, reward in ipairs(rewards) do
		if not self._rewardItems[i] then
			local item = {}
			local go = gohelper.cloneInPlace(self._gorewarditem)

			item.goRoot = go
			item.goIcon = gohelper.findChild(go, "go_icon")
			item.gocanget = gohelper.findChild(go, "go_canget")
			item.goreceive = gohelper.findChild(go, "go_receive")
			item.gohasget = gohelper.findChild(go, "go_receive/go_hasget")
			item.getAnim = item.gohasget:GetComponent(typeof(UnityEngine.Animator))
			item.btn = gohelper.getClickWithAudio(item.gocanget)

			item.btn:AddClickListener(self._btncangetOnClick, self)
			table.insert(self._rewardItems, item)
		end

		gohelper.setActive(self._rewardItems[i].goRoot, true)

		self._rewardItems[i].item = nil

		gohelper.destroyAllChildren(self._rewardItems[i].goIcon)

		self._rewardItems[i].item = self._rewardItems[i].item or IconMgr.instance:getCommonItemIcon(self._rewardItems[i].goIcon)

		local props = string.splitToNumber(reward, "#")

		self._rewardItems[i].item:setMOValue(props[1], props[2], props[3], nil, true)
		self._rewardItems[i].item:isShowName(false)
		gohelper.setActive(self._rewardItems[i].gocanget, couldGet)
		gohelper.setActive(self._rewardItems[i].goreceive, not couldGet)
	end
end

function V2a9_FreeMonthCard_PanelView:onClose()
	UIBlockMgr.instance:endBlock("waitShowMonthCardIn")
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.cancelTask(self._startGetBonus, self)
	TaskDispatcher.cancelTask(self._setRewardGet, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function V2a9_FreeMonthCard_PanelView:onDestroyView()
	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			v.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return V2a9_FreeMonthCard_PanelView
