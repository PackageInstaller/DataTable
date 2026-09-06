-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerholidayscheckin/view/SummerholidayscheckinmainView.lua

module("logic.extensions.summerholidayscheckin.view.SummerholidayscheckinmainView", package.seeall)

local SummerholidayscheckinmainView = class("SummerholidayscheckinmainView", ViewComponent)

function SummerholidayscheckinmainView:ctor()
	SummerholidayscheckinmainView.super.ctor(self)
end

function SummerholidayscheckinmainView:unbindEvents()
	SummerholidayscheckinmainView.super.unbindEvents(self)
	self._btnGaizhang:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function SummerholidayscheckinmainView:bindEvents()
	SummerholidayscheckinmainView.super.bindEvents(self)
	self._btnGaizhang:AddClickListener(self._onClickbtnGaizhang, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function SummerholidayscheckinmainView:buildUI()
	SummerholidayscheckinmainView.super.buildUI(self)

	self._txtLoginDay = self:getTxt("txtLoginDay")
	self._btnGaizhang = self:getBtn("btnGaizhang")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._recordPosGo = self:getGo("recordPosCon")
	self._itemCell = self:getGo("recordPosCon/itemCell")
	self._recordPos = self._recordPosGo:GetComponent("TestRecordPos")
	self._txtTime = self:getTxt("time/txt")
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self._redpointGo = self:getGo("btnGaizhang/redpoint")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemCellList = ItemGroup.New(self._recordPosGo, self._itemCell)
	self._bg = self:getGo("bg")
end

function SummerholidayscheckinmainView:onExit()
	SummerholidayscheckinmainView.super.onExit(self)
	self:_clearList()
	RedPointController.instance:unregRedPoint(self._redpointGo)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onDailyRefresh, self)
	uGuiUtil.clearImage(self._bg.gameObject)
end

function SummerholidayscheckinmainView:onEnter()
	SummerholidayscheckinmainView.super.onEnter(self)
	self.addGEvent(self, SummerHolidaysCheckInAgent.SummerHolidaysCheckInGetInfoRes, self._updateUI, self)
	self.addGEvent(self, SummerHolidaysCheckInAgent.SummerHolidaysCheckInStampRes, self._updateUI, self)
	self.addGEvent(self, SummerHolidaysCheckInAgent.SummerHolidaysCheckInGainPrizeRes, self._updateUI, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onDailyRefresh, self)

	self._activityType = GameEnum.ActivityType.SummerHolidaysCheckIn
	self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动暂未开放")
		self:close()

		return
	end

	self._actCfg = SummerholidayscheckinConfig.instance:getActCfg(self._activityId)
	self._planId = self._actCfg.Locationusage

	self:_setUI()
	self:_ShowList()

	self._effectHandlers = {}

	self:_updateUI()
	self:_setActTime()
	SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInGetInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redpointGo, RedPointModel.ID_SUMMERHOLIDAY_GAIZHANG)
end

function SummerholidayscheckinmainView:_setUI()
	if not self._actCfg.bg then
		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, "ui/bigbg/views/huodong/qiandao/" .. self._actCfg.bg .. ".png")
	end
end

function SummerholidayscheckinmainView:_ShowList()
	local planToPos = self._planId == 1

	GameUtil.SetActive(self._tableviewGo, not planToPos)
	GameUtil.SetActive(self._recordPosGo, planToPos)
end

function SummerholidayscheckinmainView:_onClickbtnGaizhang()
	local times = SummerholidayscheckinModel.instance:getTodayCheckInTimes()

	if times >= self._actCfg.dailyCheckInLimit then
		FloatWordMgr.instance:show(string.format("每天只能盖章%s次", self._actCfg.dailyCheckInLimit))

		return
	end

	SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInStampReq(self._activityId)
end

function SummerholidayscheckinmainView:_onClickbtnClose()
	self:close()
end

function SummerholidayscheckinmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("summerholidayscheckin")
end

function SummerholidayscheckinmainView:_updateCell(view, cell, prizeCfg, tag)
	local goGain = goutil.findChild(cell.gameObject, "receive")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goGaizhang = goutil.findChild(cell.gameObject, "gaizhang")
	local goTimeBg = goutil.findChild(cell.gameObject, "timeBg")
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local txtGainTime = goutil.findChildTextComponent(cell.gameObject, "txtGainTime")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local txtDay = goutil.findChildTextComponent(cell.gameObject, "txtDay")
	local daybgChange = goutil.findChild(cell.gameObject, "daybg"):GetComponent(ComponentType.UIImageSpriteChange)
	local bgChange = goutil.findChild(cell.gameObject, "bg"):GetComponent(ComponentType.UIImageColorChange)
	local isGain = SummerholidayscheckinModel.instance:isGainPrize(prizeCfg.checkInId)
	local isGaizhang = SummerholidayscheckinModel.instance:getCheckInDays() >= prizeCfg.checkInId
	local openTime = GameUtil.string2time(prizeCfg.startGainPrizeTime)
	local isOpen = openTime <= ServerTime.now()
	local checkInDays = SummerholidayscheckinModel.instance:getCheckInDays()
	local isCanGain = not isGain and isOpen and checkInDays >= prizeCfg.needDays

	goutil.setActive(goGain, isGain)
	goutil.setActive(goGaizhang, isGaizhang)

	txtDay.text = string.format("第%s天", cell.data)

	bgChange:SetState(cell.data % 3 == 0 and 1 or 0)
	daybgChange:SetState(cell.data % 3 == 0 and 1 or 0)

	local showTime = not isOpen and prizeCfg.showTime

	goutil.setActive(goTimeBg, showTime)
	goutil.setActive(txtGainTime.gameObject, showTime)

	if showTime then
		local date = GameUtil.string2date(prizeCfg.startGainPrizeTime)

		txtGainTime.text = string.format("%s月%s日后可领", date.month, date.day)
	end

	MaterialMgr.resetAll(goItem)

	local mt, mid, mn = MaterialMgr.getMatParams(prizeCfg.prize)
	local proxy = MaterialMgr.setCellByCfg(prizeCfg.prize, goItem)

	proxy.binder:setBgActive(false)

	txtNum.text = mn

	proxy.binder:setAutoTips(false)
	proxy.binder:setEffStatus(false)
	proxy.binder:setNum(0)
	proxy.binder:setCallBack(function()
		if isGain or not isGaizhang or not isOpen then
			local level, awaken = GameUtil.getPetDefaultLevelAndAwakenLv(prizeCfg.prize)

			CommonTipsMgr.instance:openMaterialTips(goItem, mt, mid, level, awaken)
		end

		if isGaizhang and not isOpen then
			local date = GameUtil.string2date(prizeCfg.startGainPrizeTime)
			local str = string.format("%s月%s日后可领", date.month, date.day)

			FloatWordMgr.instance:show(str)

			return
		end

		if isCanGain then
			SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInGainPrizeReq(self._activityId)
		end
	end)
	goutil.setActive(goEffect, isCanGain)
	self:_playCellEffect(goEffect, isCanGain)
end

function SummerholidayscheckinmainView:_clearCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	self._effectHandlers[goEffect] = nil

	MaterialMgr.resetAll(goItem)
end

function SummerholidayscheckinmainView:_updateUI()
	local cfgs = SummerholidayscheckinConfig.instance:getPrizeCfgs(self._activityId)
	local planToPos = self._planId == 1

	if planToPos then
		self._itemCellList:updateWithMoArray(cfgs, self._updatePosCell, self)
		self._recordPos:LoadPlan(0)
	else
		self._scrollerList:reloadData(cfgs)
	end

	self:_setLoginDays()
end

function SummerholidayscheckinmainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function SummerholidayscheckinmainView:_setLoginDays()
	local loginDay = SummerholidayscheckinModel.instance:getCheckInDays()

	self._txtLoginDay.text = string.format("已累计登录天数：%s天", loginDay)
end

function SummerholidayscheckinmainView:_playCellEffect(goEffect, isCanGain)
	self:_removeCellEffect(goEffect)

	if not isCanGain then
		return
	end

	local handler
	local effName = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true, nil, nil, function()
		handler:setScrollRectClipping(self._scrollRect)
	end)
	self._effectHandlers[goEffect] = handler

	handler:setParent(goEffect.transform)
	handler:setLocalPos(0, 0, 0)
	handler:setScale(1)
end

function SummerholidayscheckinmainView:_removeCellEffect(goEffect)
	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	self._effectHandlers[goEffect] = nil
end

function SummerholidayscheckinmainView:_onDailyRefresh()
	if self._activityId and self._activityId > 0 then
		SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInGetInfoReq(self._activityId)
	end
end

function SummerholidayscheckinmainView:_updatePosCell(cell, prizeCfg, i)
	local go = cell.mainGO
	local goGain = goutil.findChild(go, "receive")
	local goItem = goutil.findChild(go, "item")
	local goGaizhang = goutil.findChild(go, "gaizhang")
	local goTimeBg = goutil.findChild(go, "timeBg")
	local goEffect = goutil.findChild(go, "effect")
	local txtGainTime = goutil.findChildTextComponent(go, "txtGainTime")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtDay = goutil.findChildTextComponent(go, "txtDay")
	local daybgChange = goutil.findChild(go, "daybg"):GetComponent(ComponentType.UIImageSpriteChange)
	local bgChange = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageColorChange)
	local btnItem = Framework.ButtonAdapter.GetFrom(go, "item")
	local isGain = SummerholidayscheckinModel.instance:isGainPrize(prizeCfg.checkInId)
	local isGaizhang = SummerholidayscheckinModel.instance:getCheckInDays() >= prizeCfg.checkInId
	local openTime = GameUtil.string2time(prizeCfg.startGainPrizeTime)
	local isOpen = openTime <= ServerTime.now()
	local checkInDays = SummerholidayscheckinModel.instance:getCheckInDays()
	local isCanGain = not isGain and isOpen and checkInDays >= prizeCfg.needDays

	goutil.setActive(goGain, isGain)
	goutil.setActive(goGaizhang, isGaizhang)

	txtDay.text = string.format("第%s天", i)

	bgChange:SetState(i % 3 == 0 and 1 or 0)
	daybgChange:SetState(i % 3 == 0 and 1 or 0)

	local showTime = not isOpen and prizeCfg.showTime

	goutil.setActive(goTimeBg, showTime)
	goutil.setActive(txtGainTime.gameObject, showTime)

	if showTime then
		local date = GameUtil.string2date(prizeCfg.startGainPrizeTime)

		txtGainTime.text = string.format("%s月%s日后可领", date.month, date.day)
	end

	MaterialMgr.resetAll(goItem)

	local mt, mid, mn = MaterialMgr.getMatParams(prizeCfg.prize)
	local proxy = MaterialMgr.setCell(mt, mid, goItem)

	proxy.binder:setBgActive(false)
	proxy.binder:setNumBg(false)
	proxy.binder:setEffStatus(false)

	txtNum.text = mn

	proxy.binder:setAutoTips(not isCanGain)

	if isCanGain then
		proxy.binder:setCallBack(function()
			SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInGainPrizeReq(self._activityId)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	btnItem:AddClickListener(function()
		if isGain or not isGaizhang or not isOpen then
			local level, awaken = GameUtil.getPetDefaultLevelAndAwakenLv(prizeCfg.prize)

			CommonTipsMgr.instance:openMaterialTips(btnItem.gameObject, mt, mid, level, awaken)
		end

		if isGaizhang and not isOpen then
			local date = GameUtil.string2date(prizeCfg.startGainPrizeTime)
			local str = string.format("%s月%s日后可领", date.month, date.day)

			FloatWordMgr.instance:show(str)

			return
		end

		if isCanGain then
			SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInGainPrizeReq(self._activityId)
		end
	end)
	goutil.setActive(goEffect, isCanGain)
	self:_playCellEffect(goEffect, isCanGain)
end

function SummerholidayscheckinmainView:_clearItemCell(item)
	local go = item.mainGO
	local con = goutil.findChild(go, "item")
	local goEffect = goutil.findChild(go, "effect")
	local btnItem = Framework.ButtonAdapter.GetFrom(go, "item")
	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	self._effectHandlers[goEffect] = nil

	btnItem:RemoveClickListener()
	MaterialMgr.resetAll(con)
end

function SummerholidayscheckinmainView:_clearList()
	local planToPos = self._planId == 1

	if planToPos then
		self._itemCellList:dispose(self._clearItemCell, self)
	else
		self._scrollerList:dispose()
	end
end

return SummerholidayscheckinmainView
