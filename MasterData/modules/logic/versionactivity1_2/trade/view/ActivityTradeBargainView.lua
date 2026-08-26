-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeBargainView.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainView", package.seeall)

local ActivityTradeBargainView = class("ActivityTradeBargainView", BaseView)

function ActivityTradeBargainView:onInitView()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gobar = gohelper.findChild(self.viewGO, "#go_bar")
	self._btndaily = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bar/#btn_daily")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bar/#btn_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotalkarea = gohelper.findChild(self.viewGO, "left/#go_talkarea")
	self._animtalkarea = self._gotalkarea:GetComponent(typeof(UnityEngine.Animator))
	self._txtdate = gohelper.findChildText(self.viewGO, "left/layout/#go_lefttop/#txt_date")
	self._txtcurprogress = gohelper.findChildText(self.viewGO, "#go_progress/horizontal/#txt_curprogress")

	gohelper.setActive(self._gotalkarea, false)

	self._txtchatinfo = gohelper.findChildText(self.viewGO, "left/#go_talkarea/txt_chatinfo")
	self._goDot = gohelper.findChild(self._gotalkarea, "vx_dot")
	self._simagebossicon = gohelper.findChildSingleImage(self.viewGO, "left/#go_boss/#simage_bossicon")
	self._goleftBottom = gohelper.findChild(self.viewGO, "left/layout/#go_leftbottom")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityTradeBargainView:addEvents()
	self._btndaily:AddClickListener(self._btndailyOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.BargainStatusChange, self.onBargainStatusChanged, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveDeal, self.updateView, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.PlayTalk, self.playTalk, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveInfos, self.updateView, self)
end

function ActivityTradeBargainView:removeEvents()
	self._btndaily:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.BargainStatusChange, self.onBargainStatusChanged, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveDeal, self.updateView, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.PlayTalk, self.playTalk, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveInfos, self.updateView, self)
end

ActivityTradeBargainView.TabNum = 2

function ActivityTradeBargainView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("bg"))
	self._simagebossicon:LoadImage(ResUrl.getVersionTradeBargainBg("img_juese"))

	self._selectTabs = self:getUserDataTb_()
	self._unselectTabs = self:getUserDataTb_()
	self._selectTabs[1] = gohelper.findChild(self._btndaily.gameObject, "go_selected")
	self._unselectTabs[1] = gohelper.findChild(self._btndaily.gameObject, "go_unselected")
	self._selectTabs[2] = gohelper.findChild(self._btnreward.gameObject, "go_selected")
	self._unselectTabs[2] = gohelper.findChild(self._btnreward.gameObject, "go_unselected")
	self._gorewardreddot1 = gohelper.findChild(self._btnreward.gameObject, "go_selected/txt_titlecn/go_reddot1")
	self._gorewardreddot2 = gohelper.findChild(self._btnreward.gameObject, "go_unselected/txt_titlecn/go_reddot2")

	RedDotController.instance:addRedDot(self._gorewardreddot1, RedDotEnum.DotNode.TradeReward)
	RedDotController.instance:addRedDot(self._gorewardreddot2, RedDotEnum.DotNode.TradeReward)
end

function ActivityTradeBargainView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagebossicon:UnLoadImage()

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function ActivityTradeBargainView:onOpen()
	self:onRefreshView()
end

function ActivityTradeBargainView:onUpdateParam()
	self:onRefreshView()
end

function ActivityTradeBargainView:onRefreshView()
	self.actId = self.viewParam and self.viewParam.actId

	self.viewContainer:setActId(self.actId)

	if self.viewParam then
		if not self.viewParam.tabIndex then
			local tabIndex = 1

			self:changeTab(tabIndex)
			self:updateView()
		end
	end
end

function ActivityTradeBargainView:updateView()
	local remain = Activity117Model.instance:getRemainDay(self.actId)

	self._txtdate.text = formatLuaLang("versionactivity_1_2_117daytxt", remain)
	self._txtcurprogress.text = tostring(Activity117Model.instance:getCurrentScore(self.actId))
end

function ActivityTradeBargainView:onClose()
	Activity117Model.instance:setSelectOrder(self.actId)
	Activity117Model.instance:setInQuote(self.actId)
end

function ActivityTradeBargainView:onSwitchTab(tabIndex)
	for i = 1, ActivityTradeBargainView.TabNum do
		gohelper.setActive(self._selectTabs[i], tabIndex == i)
		gohelper.setActive(self._unselectTabs[i], tabIndex ~= i)
	end

	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabIndex)

	if not self.playContent then
		self.playContent = true

		local co = Activity117Config.instance:getTalkCo(self.actId, Activity117Enum.PriceType.Talk)

		self:playTalk(self.actId, co and co.content1)
	end
end

function ActivityTradeBargainView:playTalk(actId, content, isWait)
	if actId ~= self.actId then
		return
	end

	gohelper.setActive(self._gotalkarea, true)

	if content then
		self._animtalkarea:Play(UIAnimationName.Open)
		gohelper.setActive(self._goDot, isWait and true or false)

		if self.tweenId then
			ZProj.TweenHelper.KillById(self.tweenId)

			self.tweenId = nil
		end

		self._txtchatinfo.text = ""

		if not string.nilorempty(content) then
			self.tweenId = ZProj.TweenHelper.DOText(self._txtchatinfo, content, 2)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_auctionhouses_lvhutooth)
	else
		self._animtalkarea:Play(UIAnimationName.Close)
	end
end

function ActivityTradeBargainView:onBargainStatusChanged(actId)
	if actId ~= self.actId then
		return
	end

	local isSelect = Activity117Model.instance:isSelectOrder(self.actId)

	if isSelect == self.isSelect then
		return
	end

	self.isSelect = isSelect

	if self.isSelect then
		self._anim:Play("go")
	else
		self._anim:Play("back")
	end
end

function ActivityTradeBargainView:_btndailyOnClick()
	self:changeTab(Activity117Enum.OpenTab.Daily)
end

function ActivityTradeBargainView:_btnrewardOnClick()
	self:changeTab(Activity117Enum.OpenTab.Reward)
end

function ActivityTradeBargainView:changeTab(tabIndex)
	if self.tabIndex == tabIndex then
		return
	end

	self.tabIndex = tabIndex

	self:onSwitchTab(tabIndex)
end

function ActivityTradeBargainView:_onDailyRefresh()
	if self.actId then
		Activity117Controller.instance:initAct(self.actId)
	end
end

return ActivityTradeBargainView
