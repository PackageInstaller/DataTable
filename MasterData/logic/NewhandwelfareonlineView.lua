-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareonlineView.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareonlineView", package.seeall)

local NewhandwelfareonlineView = class("NewhandwelfareonlineView", ViewComponent)

function NewhandwelfareonlineView:ctor()
	NewhandwelfareonlineView.super.ctor(self)
end

function NewhandwelfareonlineView:unbindEvents()
	NewhandwelfareonlineView.super.unbindEvents(self)
	self._btnOneKey:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnDetail)
end

function NewhandwelfareonlineView:bindEvents()
	NewhandwelfareonlineView.super.bindEvents(self)
	self._btnOneKey:AddClickListener(self._onClickbtnOneKey, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickbtnDetail, self)
end

function NewhandwelfareonlineView:buildUI()
	NewhandwelfareonlineView.super.buildUI(self)

	self._txtOnlineTime = goutil.findChildTextComponent(self.mainGO, "txtOnlineTime")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._60GoChange = self:getGo("onlineAnim/60"):GetComponent(ComponentType.UIImageSpriteChange)
	self._15GoChange = self:getGo("onlineAnim/15"):GetComponent(ComponentType.UIImageSpriteChange)
	self._30GoChange = self:getGo("onlineAnim/30"):GetComponent(ComponentType.UIImageSpriteChange)
	self._45GoChange = self:getGo("onlineAnim/45"):GetComponent(ComponentType.UIImageSpriteChange)
	self._animTr = self:getGo("onlineAnim/anim").transform
	self._btnClose = self:getBtn("btnClose")
	self._txtLeftTime = self:getTxt("leftTime/txt")
	self._effectHandlers = {}
	self._txtTip = self:getTxt("txtTip")
	self._btnDetail = self:getGo("txtTip/btnDetail")

	self:_buildRewardItems()
end

function NewhandwelfareonlineView:_buildRewardItems()
	self._rewardItems = {}

	local rewardsGo = self:getGo("rewards")

	for i = 1, 7 do
		local cell = goutil.findChild(rewardsGo, "reward_" .. i)
		local goItem = goutil.findChild(cell, "item")
		local goEffect = goutil.findChild(cell, "effect")
		local goReceived = goutil.findChild(cell, "received")
		local txtNum = goutil.findChildTextComponent(cell, "txtNum")
		local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
		local btn = Framework.ButtonAdapter.Get(cell)
		local btnIcon = Framework.ButtonAdapter.Get(goItem)

		self._rewardItems[i] = {
			goItem = goItem,
			goReceived = goReceived,
			txtNum = txtNum,
			txtTitle = txtTitle,
			goEffect = goEffect,
			btn = btn,
			btnIcon = btnIcon
		}
	end
end

function NewhandwelfareonlineView:onExit()
	NewhandwelfareonlineView.super.onExit(self)
	removetimer(self._setOnlineTime, self)
	removetimer(self._updateTimer, self)

	for k, handler in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(handler)
	end

	self._effectHandlers = {}

	for i, cell in ipairs(self._rewardItems) do
		MaterialMgr.resetAll(cell.goItem)
	end
end

function NewhandwelfareonlineView:onEnter()
	NewhandwelfareonlineView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGetInfoRes, self._handleRes, self)
	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGainOnlinePrizeRes, self._handleRes, self)
	self.addGEvent(self, NewhandwelfareController.NewHandWelfareOneKeyGainOnlinePrizeRes, self._handleRes, self)
	settimer(1, self._setOnlineTime, self, true)
	self:_setOnlineTime()
	self:_onUpdate()
end

function NewhandwelfareonlineView:_handleRes(status)
	if status == 0 then
		self:_onUpdate()
	end
end

function NewhandwelfareonlineView:_onUpdate()
	self:_setRewards()
	self:_setOnlineTime()
	self:_setLeftTime()
	self:_setDayTips()
end

function NewhandwelfareonlineView:_getCurDay()
	return NewhandwelfareModel.instance:getNewHandActiveDays()
end

function NewhandwelfareonlineView:_onClickbtnOneKey()
	local day = self:_getCurDay()
	local cfg = NewhandwelfareConfig.instance:getOnlineRewardCfg(self._periodId, day) or {}
	local list = {}

	for i, data in ipairs(cfg) do
		if NewhandwelfareModel.instance:checkCanGainOnlinePrize(self._periodId, day, data.prizeId) then
			table.insert(list, data.prizeId)
		end
	end

	if #list > 0 then
		NewHandWelfareAgent.instance:sendNewHandWelfareOneKeyGainOnlinePrizeReq()
	else
		FloatWordMgr.instance:show("暂无奖励可领")
	end
end

function NewhandwelfareonlineView:_setOnlineTime()
	local maxTime = 3600
	local time = NewhandwelfareModel.instance:getOnlineTime()

	time = Mathf.Min(time, maxTime)

	local min = math.floor(time / 60)
	local sec = time % 60

	Framework.TransformUtil.SetLocalRotation(self._animTr, 0, 0, -math.min(min, 30) / 60 * 360)
	self._60GoChange:SetState(maxTime <= time and 1 or 0)
	self._45GoChange:SetState(time >= 2700 and 1 or 0)
	self._30GoChange:SetState(time >= 1800 and 1 or 0)
	self._15GoChange:SetState(time >= 900 and 1 or 0)

	self._txtOnlineTime.text = string.format("累计在线时间：%s分%s秒", min, sec)

	self:_checkOneKeyBtn()

	if maxTime <= time then
		removetimer(self._setOnlineTime, self)
	end
end

function NewhandwelfareonlineView:_onClickbtnClose()
	self:close()
end

function NewhandwelfareonlineView:_onClickbtnDetail()
	UIStateManager.instance:push(ViewName.NewHandWelfareOnlineDetailView, self._periodId)
end

function NewhandwelfareonlineView:_onClickRewardCell(index)
	if NewhandwelfareModel.instance:isGainOnlinePrize(index) then
		FloatWordMgr.instance:show("奖励已领取")

		return
	end

	local day = self:_getCurDay()

	if NewhandwelfareModel.instance:checkCanGainOnlinePrize(self._periodId, day, index) then
		NewHandWelfareAgent.instance:sendNewHandWelfareGainOnlinePrizeReq(index)
	else
		FloatWordMgr.instance:show("奖励暂时无法领取")
	end
end

function NewhandwelfareonlineView:_checkOneKeyBtn()
	local day = self:_getCurDay()
	local cfg = NewhandwelfareConfig.instance:getOnlineRewardCfg(self._periodId, day) or {}
	local list = {}

	for i, data in ipairs(cfg) do
		if NewhandwelfareModel.instance:checkCanGainOnlinePrize(self._periodId, day, data.prizeId) then
			table.insert(list, data.prizeId)
		end
	end

	GameUtil.SetGray(self._btnOneKey.gameObject, #list <= 0)
end

function NewhandwelfareonlineView:_setRewards()
	local day = self:_getCurDay()
	local cfgs = NewhandwelfareConfig.instance:getOnlineRewardCfg(self._periodId, day) or {}

	for i, cfg in ipairs(cfgs) do
		local cell = self._rewardItems[i]
		local isGinPrize = NewhandwelfareModel.instance:isGainOnlinePrize(cfg.prizeId)
		local canGainPrize = NewhandwelfareModel.instance:checkCanGainOnlinePrize(self._periodId, day, cfg.prizeId)

		goutil.setActive(cell.goReceived, isGinPrize)

		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)

		MaterialMgr.setIcon(cell.goItem, matType, matId)

		cell.txtTitle.text = string.format("%s分钟", cfg.onlineTime)
		cell.txtNum.text = matNum

		local handler = self._effectHandlers[cell.goEffect]

		if handler then
			UIEffectManager.instance:stopEffect(handler)
		end

		if canGainPrize then
			local effName = "fx_ui_xinshourenwu/fx_ui_chongzhidailingqu.prefab"

			handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

			handler:setParent(cell.goEffect.transform)
			handler:setLocalPos(5, -6, 0)
			handler:setScale(1)
			handler:setLocalEulerAngle(0, 0, 3)

			self._effectHandlers[cell.goEffect] = handler
		end

		cell.btn:AddClickListener(function()
			self:_onClickRewardCell(i)
		end)
		cell.btnIcon:AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(cell.btnIcon.gameObject, matType, matId)
		end)
	end
end

function NewhandwelfareonlineView:_setLeftTime()
	self._destTime = NewhandwelfareModel.instance:getOnlineTimeActEndTime()

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function NewhandwelfareonlineView:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtLeftTime.text = self:_formatLeftTimeStr(self._leftTime)
	else
		self:_actEndOp()
	end
end

function NewhandwelfareonlineView:_formatLeftTimeStr(leftTime)
	local d, h, m, s = GameUtil.getTimeDDHHMMSS(leftTime)
	local hstr = h
	local mstr = m
	local sstr = s

	if h < 10 then
		hstr = "0" .. h
	end

	if m < 10 then
		mstr = "0" .. m
	end

	if s < 10 then
		sstr = "0" .. s
	end

	return d > 0 and string.format("时间剩余:%s天%s时%s分", d, hstr, mstr) or h > 0 and string.format("时间剩余:%s时%s分%s秒", hstr, mstr, sstr) or string.format("时间剩余:%s分%s秒", mstr, sstr)
end

function NewhandwelfareonlineView:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function NewhandwelfareonlineView:_setDayTips()
	local cfg = NewhandwelfareConfig.instance:getPeriodCfg(self._periodId)

	self._txtTip.text = cfg and string.format("活动%s天内在线满足时长，可领取当前奖励", cfg.newHandOnlinePrizeDays) or ""
end

return NewhandwelfareonlineView
