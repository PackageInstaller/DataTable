-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalMainView.lua

module("logic.extensions.lanternfestival.view.LanternFestivalMainView", package.seeall)

local LanternFestivalMainView = class("LanternFestivalMainView", ViewComponent)

function LanternFestivalMainView:ctor()
	LanternFestivalMainView.super.ctor(self)
end

function LanternFestivalMainView:unbindEvents()
	LanternFestivalMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJumpShop)
	GameUtil.rmClickHandler(self._btnJumpExchange)
	GameUtil.rmClickHandler(self._btnChannel)
	GameUtil.rmClickHandler(self._btnPerson)
	GameUtil.rmClickHandler(self._btnGetExtra)
end

function LanternFestivalMainView:bindEvents()
	LanternFestivalMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJumpShop, self._onClickBtnJumpShop, self)
	GameUtil.addClickHandler(self._btnJumpExchange, self._onClickBtnJumpExchange, self)
	GameUtil.addClickHandler(self._btnChannel, self._onClickBtnChannel, self)
	GameUtil.addClickHandler(self._btnPerson, self._onClickBtnPerson, self)
	GameUtil.addClickHandler(self._btnGetExtra, self._onClickBtnGetExtra, self)
end

function LanternFestivalMainView:buildUI()
	LanternFestivalMainView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnJumpShop = self:getGo("btnJumpShop")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnJumpExchange = self:getGo("btnJumpExchange")
	self._channel = self:getGo("channel")
	self._btnChannel = self:getGo("channel/btn")
	self._tipsChannel = self:getGo("channel/tips")

	local tabChannel = self:getGo("channel/prize/tableview")
	local cellChannel = self:getGo("channel/prize/tableview/tablecell")

	self._tableviewChannel = ScrollerList.create(tabChannel, cellChannel, GameUtil.handler(self._updateCellChannel, self), GameUtil.handler(self._clearCellChannel, self))
	self._txtTitlePrizeChannel = self:getTxt("channel/prize/txtTitle")
	self._txtTimesChannel = self:getTxt("channel/txtTimes")
	self._txtOpenTimeChannel = self:getTxt("channel/txtOpenTime")
	self._person = self:getGo("person")
	self._btnPerson = self:getGo("person/btn")
	self._tipsPerson = self:getGo("person/tips")

	local tabPerson = self:getGo("person/prize/tableview")
	local cellPerson = self:getGo("person/prize/tableview/tablecell")

	self._tableviewPerson = ScrollerList.create(tabPerson, cellPerson, GameUtil.handler(self._updateCellPerson, self), GameUtil.handler(self._clearCellPerson, self))
	self._btnGetExtra = self:getGo("person/extraPrzie/btnGet")
	self._txtTipsExtra = self:getTxt("person/extraPrzie/txtTips")
	self._showprizeExtra = self:getGo("person/extraPrzie/showprize")
	self._gainExtra = self:getGo("person/extraPrzie/gain")
end

function LanternFestivalMainView:onExit()
	LanternFestivalMainView.super.onExit(self)
	self._tableviewChannel:dispose()
	self._tableviewPerson:dispose()
	MaterialMgr.resetAll(self._showprizeExtra)

	if self._gainExtEff then
		UIEffectManager.instance:stopEffect(self._gainExtEff)

		self._gainExtEff = nil
	end
end

function LanternFestivalMainView:onEnter()
	LanternFestivalMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 566001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalFinishPersionQuestionRes, self._updatePersonByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalGainExtPrizeRes, self._updateExtraByInfo, self)
	LanternFestivalController.instance:getInfo(self._activityId)
end

function LanternFestivalMainView:_updateUIByCfg()
	self._actCfg = LanternFestivalConfig.instance:getActivityCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local curWeekDay = LanternFestivalController.instance:getCurrentWeekDay()
	local addWeekdayStr = GameUtil.getChineseNumber(curWeekDay)

	if curWeekDay == 0 then
		curWeekDay = 7
		addWeekdayStr = "日"
	end

	self._txtTitlePrizeChannel.text = string.format("周%s掉落灯谜奖励", addWeekdayStr)

	local prizeChannel = LanternFestivalConfig.instance:getChannelPrize(self._activityId, curWeekDay)
	local prizeChannelAttr = string.split(prizeChannel, "#")

	self._tableviewChannel:reloadData(prizeChannelAttr)
	self._tableviewChannel:setCenterMode(true)

	if not self._actCfg.personLanternPrize then
		local personPrizeStr = ""
		local personPrizeAttr = string.split(personPrizeStr, "#")

		self._tableviewPerson:reloadData(personPrizeAttr)
		self._tableviewPerson:setCenterMode(true)

		if not self._actCfg.personExtPrize then
			MaterialMgr.setCellByCfg(self._actCfg.personExtPrize, self._showprizeExtra)

			self._groupCfgs = LanternFestivalConfig.instance:getGroupCfgs(self._activityId)

			local showStr = "每日"

			for i, cfg in ipairs(self._groupCfgs) do
				if not cfg.showTimeStr then
					showStr = i == 1 and showStr .. cfg.showTimeStr or showStr .. "、" .. cfg.showTimeStr
				end
			end

			self._txtOpenTimeChannel.text = showStr
			self._channelAnswerMaxCount = self._actCfg.dailyChannelPrizeLimit or 0
		end
	end
end

function LanternFestivalMainView:_updateUIByInfo()
	self._curChannelAnswerCount = 0

	local info = LanternFestivalModel.instance:getInfoByActId(self._activityId)

	if info then
		self._curChannelAnswerCount = info.todayChannelPrizeTimes or 0
	end

	self._curChannelAnswerCount = Mathf.Min(self._curChannelAnswerCount, self._channelAnswerMaxCount)

	local leftCount = Mathf.Max(0, self._channelAnswerMaxCount - self._curChannelAnswerCount)

	self._txtTimesChannel.text = string.format("今日剩余奖答题次数：<color=#20b367>%s/%s</color>", leftCount, self._channelAnswerMaxCount)

	goutil.setActive(self._tipsChannel, leftCount <= 0)
	GameUtil.SetGray(self._btnChannel, leftCount <= 0)
	self:_updatePersonByInfo()
end

function LanternFestivalMainView:_updatePersonByInfo()
	self._todayGainPersonPrize = false

	local info = LanternFestivalModel.instance:getInfoByActId(self._activityId)

	if info then
		self._todayGainPersonPrize = info.todayGainPersonPrize or false
	end

	GameUtil.SetGray(self._btnPerson, self._todayGainPersonPrize)
	goutil.setActive(self._tipsPerson, self._todayGainPersonPrize)
	self:_updateExtraByInfo()
end

function LanternFestivalMainView:_updateExtraByInfo()
	if not self._actCfg.checkInDays then
		local checkInDays = 0

		self._curProgressExtra = 0
		self._gainExtPrize = false

		local info = LanternFestivalModel.instance:getInfoByActId(self._activityId)

		if info then
			self._curProgressExtra = info.gainPersonPrizeDayCount or 0
			self._gainExtPrize = info.hasGainExtPrize or false
		end

		goutil.setActive(self._gainExtra, self._gainExtPrize)
		goutil.setActive(self._btnGetExtra, not self._gainExtPrize and checkInDays <= self._curProgressExtra)

		self._txtTipsExtra.text = string.format("累计%s天完成可领取\n(%s/%s)", checkInDays, Mathf.Min(self._curProgressExtra, checkInDays), checkInDays)

		if self._gainExtEff then
			UIEffectManager.instance:stopEffect(self._gainExtEff)

			self._gainExtEff = nil
		end

		if not self._gainExtPrize and checkInDays <= self._curProgressExtra then
			self._gainExtEff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._btnGetExtra.transform, 0, 0, true, false, nil, function(target, effect)
				effect:setClipping(self._btnGetExtra.transform)
			end)

			self._gainExtEff:setParent(self._btnGetExtra.transform)
			self._gainExtEff:setScale(1)
			self._gainExtEff:setLocalPos(0, 0, 0)
		end
	end
end

function LanternFestivalMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LanternFestivalMainView:_onClickBtnJumpShop()
	local jumpToStr = self._actCfg.gotoShop

	GotoMgr.gotoByString(jumpToStr)
end

function LanternFestivalMainView:_onClickBtnJumpExchange()
	local jumpToStr = self._actCfg.gotoCollect

	GotoMgr.gotoByString(jumpToStr)
end

function LanternFestivalMainView:_onClickBtnChannel()
	UIStateManager.instance:clear()
	UIStateManager.instance:push(ViewName.chat, GameEnum.ChatChannel.LanternFestival)
end

function LanternFestivalMainView:_onClickBtnPerson()
	if self._todayGainPersonPrize then
		FloatWordMgr.instance:show("今日个人奖励已领取，明日再来吧~")

		return
	end

	UIStateManager.instance:push(ViewName.LanternFestivalAnswerView, self._activityId)
end

function LanternFestivalMainView:_onClickBtnGetExtra()
	if self._gainExtPrize then
		goutil.setActive(self._gainExtra, false)
		FloatWordMgr.instance:show("已领取该奖励")

		return
	end

	if self._curProgressExtra < (self._actCfg.checkInDays or 0) then
		goutil.setActive(self._gainExtra, false)
		FloatWordMgr.instance:show("未达到领取条件")

		return
	end

	LanternFestivalController.instance:gainExtPrize(self._activityId)
end

function LanternFestivalMainView:_updateCellChannel(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function LanternFestivalMainView:_clearCellChannel(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function LanternFestivalMainView:_updateCellPerson(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function LanternFestivalMainView:_clearCellPerson(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

return LanternFestivalMainView
