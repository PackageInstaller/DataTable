-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardPerMonthView.lua

module("logic.extensions.yearcard.view.YearCardPerMonthView", package.seeall)

local YearCardPerMonthView = class("YearCardPerMonthView", TableViewComponent)

function YearCardPerMonthView:ctor()
	YearCardPerMonthView.super.ctor(self)
end

function YearCardPerMonthView:buildUI()
	YearCardPerMonthView.super.buildUI(self)

	self._btnSummary = self:getBtn("reward/btnSummary")
	self._btnSure = self:getBtn("reward/btnSure")
	self._getedGo = self:getGo("reward/btnSure/geted")
	self._txtDesc = self:getTxt("reward/txtDesc")
	self._btnWeek = self:getBtn("reward/btnWeek")
	self._effectParent = self:getGo("reward/btnWeek/effect")
	self._txtTotalPrice = self:getTxt("reward/btnWeek/txt2")
	self._btnTip = self:getBtn("reward/btnWeek/btnTip")
	self._imgText = self:getGo("reward/title/img1"):GetComponent(typeof(UIImgNumeralText))
	self._txtTip = self:getTxt("reward/txtTip")
end

function YearCardPerMonthView:_getPath()
	return {
		cellPath = "reward/cell",
		viewPath = "reward/tableview"
	}
end

function YearCardPerMonthView:bindEvents()
	YearCardPerMonthView.super.bindEvents(self)
	self._btnSummary:AddClickListener(self._onClickSummary, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnWeek:AddClickListener(self._onClickWeek, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function YearCardPerMonthView:unbindEvents()
	YearCardPerMonthView.super.unbindEvents(self)
	self._btnSummary:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnWeek:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function YearCardPerMonthView:onEnter()
	YearCardPerMonthView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityGainMonthPrize, self._onGainMonthPrize, self)

	local param = self:getOpenParam()

	self._cfg = param[1]
	self._isCurMonth = param[2]

	self:_refreshReward()
end

function YearCardPerMonthView:onExit()
	YearCardPerMonthView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityGainMonthPrize, self._onGainMonthPrize, self)
end

function YearCardPerMonthView:_onClickSummary()
	UIStateManager.instance:push(ViewName.YearCardSummaryView)
end

function YearCardPerMonthView:_onClickWeek()
	YearCardController.instance:onClickWeekReward(self._activityId)
end

function YearCardPerMonthView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "yearcarddiamond")
end

function YearCardPerMonthView:_onClickBottomTip()
	UIStateManager.instance:open(ViewName.RulesView, "yearcardmonth")
end

function YearCardPerMonthView:_onClickSure()
	local activityId = self._activityId
	local annuityInfo = YearCardModel.instance:getAnnuityInfo(activityId)

	if annuityInfo and annuityInfo.active then
		local cfg = self._cfg
		local isCanGet = YearCardController.instance:isCanGet(activityId, cfg)

		if cfg and isCanGet then
			if not YearCardModel.instance:getIsGainMonthPrize(activityId, cfg.prizeId) then
				AnnuityAgent.instance:sendPM_AnnuityGainMonthPrizeReq(activityId, cfg.prizeId)
			else
				FloatWordMgr.instance:show("奖励已领取")
			end
		else
			FloatWordMgr.instance:show("未在对应领取时间！")
		end
	else
		FloatWordMgr.instance:show("成为2021年费可领取！")
	end
end

function YearCardPerMonthView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txtTag")

	txtTag.text = "已领"

	tag:SetActive(data.isGeted)
	MaterialMgr.setCellByCfg(data.rewardStr, item)
end

function YearCardPerMonthView:_clearTableview(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function YearCardPerMonthView:_refresh()
	self:_refreshReward()
end

function YearCardPerMonthView:_onGainMonthPrize()
	self:_refreshReward()
end

function YearCardPerMonthView:_refreshReward()
	self._activityId = YearCardModel.instance:getCurAnnuityId()

	local timestamp = ServerTime.now()
	local dateTime = GameUtil.time2date(timestamp)

	if self._cfg then
		self:_setText(self._cfg.startTime)

		local targetList = {}
		local preList = {}

		if self._cfg.campaignConsumeId > 0 then
			local planId = AccumulategiftConfig.instance:GetActivityPlanID(self._cfg.campaignConsumeId)
			local cfgs = AccumulategiftConfig.instance:GetConsumeGiftCfg(planId)

			if cfgs then
				for i = 1, 4 do
					if cfgs[i] and not string.nilorempty(cfgs[i].gift) then
						local isGeted = YearCardModel.instance:getIsGetedRewardById(self._activityId, self._cfg.prizeId, i)
						local list = string.split(cfgs[i].gift, "#")

						for k, v in ipairs(list) do
							local element = {}

							element.isGeted = isGeted
							element.rewardStr = v

							if string.sub(v, 1, 3) == "4:3" then
								table.insert(preList, element)
							else
								table.insert(targetList, element)
							end
						end
					end
				end
			end
		elseif not string.nilorempty(self._cfg.prize) then
			local list = string.split(self._cfg.prize, "#")

			for i, v in ipairs(list) do
				local element = {}

				element.isGeted = YearCardModel.instance:getIsGainMonthPrize(self._activityId, self._cfg.prizeId)
				element.rewardStr = v

				table.insert(targetList, element)
			end
		end

		if #preList > 0 then
			table.insertto(targetList, preList)
		end

		GameUtil.reverse(targetList)
		self:updateListData(targetList)
	end

	self:_refreshBtnSure()
	self:_refreshBtnWeek()
	self:_setImgText()
	self:_setBottomText()
end

function YearCardPerMonthView:_refreshBtnSure()
	local activityId = self._activityId
	local annuityInfo = YearCardModel.instance:getAnnuityInfo(activityId)

	if annuityInfo and annuityInfo.active then
		local cfg = self._cfg
		local isCanGet = YearCardController.instance:isCanGet(activityId, cfg)

		if cfg and isCanGet then
			GameUtil.SetGray(self._btnSure, false)

			if not YearCardModel.instance:getIsGainMonthPrize(activityId, cfg.prizeId) then
				self._getedGo.gameObject:SetActive(false)
			else
				self._getedGo:SetActive(true)
			end
		else
			self._getedGo:SetActive(false)
			GameUtil.SetGray(self._btnSure, true)
		end
	else
		self._getedGo:SetActive(false)
		GameUtil.SetGray(self._btnSure, false)
	end
end

function YearCardPerMonthView:_setText(startTimeStr)
	local dateStart = GameUtil.string2date(startTimeStr)
	local activityId = self._activityId
	local dateEnd = GameUtil.time2date(YearCardModel.instance:getEndTime(activityId))

	self._txtDesc.text = "领取时间：" .. string.format("<color=#FAD68E>%d.%02d.%02d 05:00-%d.%02d.%02d 05:00</color>", dateStart.year, dateStart.month, dateStart.day, dateEnd.year, dateEnd.month, dateEnd.day)
end

function YearCardPerMonthView:_playEffect()
	self:_removeEffect()

	self.effectHandler = UIEffectManager.instance:playEffect(self, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", nil, nil, nil, true)

	self.effectHandler:setParent(self._effectParent.transform)
	self.effectHandler:setScale(1)
	self.effectHandler:setLocalPos(0, 0, 0)
end

function YearCardPerMonthView:_removeEffect()
	if self.effectHandler then
		UIEffectManager.instance:stopEffect(self.effectHandler)

		self.effectHandler = nil
	end
end

function YearCardPerMonthView:_refreshBtnWeek()
	if self._isCurMonth then
		self._btnWeek.gameObject:SetActive(true)
	else
		self._btnWeek.gameObject:SetActive(false)

		return
	end

	local cfg = PayShopConfig.instance:getAnnuityCfgById(self._activityId)

	if cfg then
		local arr = string.split(cfg.weeklyGain, ":")

		self._txtTotalPrice.text = checknumber(arr[3])
	end

	local hasGainWeeklyPrize = YearCardModel.instance:getHasGainWeeklyPrize(self._activityId)

	if YearCardModel.instance:isActiveAnnuity(self._activityId) and not hasGainWeeklyPrize then
		self:_playEffect()
	else
		self:_removeEffect()
	end
end

function YearCardPerMonthView:_setImgText()
	if self._cfg then
		if self._cfg.month == 5 then
			self._imgText:SetText("5&6")
		else
			self._imgText:SetNum(self._cfg.month)
		end
	end
end

function YearCardPerMonthView:_setBottomText()
	self._txtTip.text = lang("yearcard_tips")
end

return YearCardPerMonthView
