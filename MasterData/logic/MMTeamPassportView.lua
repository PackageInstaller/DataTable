-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportView.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportView", package.seeall)

local MMTeamPassportView = class("MMTeamPassportView", TableViewComponent)
local TEAM_PRIZE_EFFECT = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function MMTeamPassportView:ctor()
	MMTeamPassportView.super.ctor(self)

	self._passPortFuncId = PassportModel.ID_MMTeamPassport
end

function MMTeamPassportView:_getPath()
	return {
		cellPath = "container/mid/tablecell",
		viewPath = "container/mid/tableview"
	}
end

function MMTeamPassportView:buildUI()
	MMTeamPassportView.super.buildUI(self)

	self._goOneKey = self:getGo("container/btnOneKey")
	self._txtOneKey = goutil.findChildTextComponent(self._goOneKey, "txt")
	self._redpoint = goutil.findChild(self._goOneKey, "imgredpoint")
	self._btnHelp = self:getGo("container/btnHelp")
	self._btnGoTo = self:getGo("container/btnGoTo")
	self._goBuyProgress = self:getGo("container/btnBuyProgress")
	self._btnBuyProgress = self._goBuyProgress and GameUtil.asBtn(self._goBuyProgress)
	self._goBuyPassport = self:getGo("container/btnBuyPassport")
	self._btnBuyPassport = self._goBuyPassport and GameUtil.asBtn(self._goBuyPassport)
	self._txtBuyPassport = goutil.findChildTextComponent(self._goBuyPassport, "txt")
	self._goLock = self:getGo("container/mid/LeftBottom/iconBottom/btnLock")
	self._btnLock = self._goLock and GameUtil.asBtn(self._goLock)
	self._sldProgress = self:getSlider("container/mid/tableview/Viewport/Content/sldProgress")
	self._scrollRect = self:getGo("container/mid/tableview"):GetComponent(ComponentType.ScrollRect)
	self._txtProgress = self:getTxt("container/mid/LeftTop/txtProgress")
	self._txtProgressTips = self:getTxt("container/mid/LeftTop/txtProgressTips")
	self._txtBottomTips = self:getTxt("container/txtBottomTips")
	self._timeTips = self:getGo("container/timeTips")
	self._txtTime = self:getTxt("container/timeTips/txt")
	self._goIconBottom = self:getGo("container/mid/LeftBottom/iconBottom")
	self._showcell = self:getGo("showcell")
	self._txtProgressShow = goutil.findChildTextComponent(self._showcell, "txtProgress")
	self._freePrizeShow = goutil.findChild(self._showcell, "freePrize")
	self._superPrizeShow_1 = goutil.findChild(self._showcell, "superPrize_1")
	self._superPrizeShow_2 = goutil.findChild(self._showcell, "superPrize_2")
	self._teamPrizeItems = {
		self:_buildTeamPrizeItem("invitePrizeOne", 1),
		self:_buildTeamPrizeItem("invitePrizeTwo", 2)
	}
end

function MMTeamPassportView:bindEvents()
	MMTeamPassportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._goOneKey, self._onClickBtnOneKey, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickBtnHelp, self)
	GameUtil.addClickHandler(self._btnGoTo, self._onClickBtnGoTo, self)

	if self._btnBuyProgress then
		self._btnBuyProgress:AddClickListener(self._onClickBtnBuyProgress, self)
	end

	if self._btnBuyPassport then
		self._btnBuyPassport:AddClickListener(self._onClickBtnBuyPassport, self)
	end

	if self._btnLock then
		self._btnLock:AddClickListener(self._onClickBtnBuyPassport, self)
	end

	for _, item in ipairs(self._teamPrizeItems) do
		GameUtil.addClickHandler(item.btnGet, GameUtil.handler(self._onClickTeamPrize, self, item.prizeId))
	end
end

function MMTeamPassportView:unbindEvents()
	MMTeamPassportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._goOneKey)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnGoTo)

	if self._btnBuyProgress then
		self._btnBuyProgress:RemoveClickListener()
	end

	if self._btnBuyPassport then
		self._btnBuyPassport:RemoveClickListener()
	end

	if self._btnLock then
		self._btnLock:RemoveClickListener()
	end

	for _, item in ipairs(self._teamPrizeItems) do
		GameUtil.rmClickHandler(item.btnGet)
	end
end

function MMTeamPassportView:onEnter()
	MMTeamPassportView.super.onEnter(self)

	self._activityId = MMTeamPassportController.instance:getActivityId()
	self._canGetRewardIndex = 0

	self:_resetView()
	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._onPassportStateUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_MMTeamPassportGainTeamPrizeRes, self._refreshTeamPrizes, self)

	if checknumber(self._activityId) <= 0 then
		return
	end

	MMTeamPassportController.instance:sendPM_MMTeamPassportGetInfoReq(self._activityId)
end

function MMTeamPassportView:onExit()
	MMTeamPassportView.super.onExit(self)
	self:_resetView()
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._onPassportStateUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_MMTeamPassportGainTeamPrizeRes, self._refreshTeamPrizes, self)
end

function MMTeamPassportView:_buildTeamPrizeItem(rootPath, prizeId)
	local root = self:getGo(rootPath)

	return {
		root = root,
		prizeId = prizeId,
		item = goutil.findChild(root, "item"),
		btnGet = goutil.findChild(root, "btnGet"),
		tipsTxt = goutil.findChildTextComponent(root, "tips/txt"),
		tagHasGain = goutil.findChild(root, "tagHasGain"),
		effRoot = goutil.findChild(root, "effRoot")
	}
end

function MMTeamPassportView:_resetView()
	self._curData = nil
	self._showId = nil
	self._lastHasPay = nil

	GameUtil.SetActive(self._timeTips, false)
	GameUtil.SetActive(self._redpoint, false)

	if self._sldProgress then
		self._sldProgress:SetValue(0)
	end

	removetimer(self._updatePerSec, self)
	ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updatePerHour, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updatePerDay, self)
	self:_resetShowCell()
	self:_clearTeamPrizes()
end

function MMTeamPassportView:_refreshUI()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	if not self._curData or not self._curData.funcCfg then
		return
	end

	self:_updateTexts()
	self:_updateBuyState()
	self:_updateOneKeyGainState()
	self:_updateTime()
	self:_refreshTeamPrizes()

	self._curViewDatas = self:_createCellDataList()

	self._tableview:ReloadData()

	self._lastHasPay = self._curData.hasPay == true
end

function MMTeamPassportView:_onPassportStateUpdate()
	local lastHasPay = self._lastHasPay

	self:_refreshUI()

	if lastHasPay == false and self._lastHasPay == true then
		FloatWordMgr.instance:show("通行证已解锁")
	end
end

function MMTeamPassportView:_updateTexts()
	local funcCfg = self._curData.funcCfg

	if self._txtProgressTips and not string.nilorempty(funcCfg.progressTips) then
		self._txtProgressTips.text = funcCfg.progressTips
	end

	if self._txtBottomTips and not string.nilorempty(funcCfg.bottomTips) then
		self._txtBottomTips.text = funcCfg.bottomTips
	end

	if self._txtProgress and not string.nilorempty(self._curData.progressTxt) then
		self._txtProgress.text = self._curData.progressTxt
	end

	if self._sldProgress then
		self._sldProgress:SetValue(self._curData.sldValue)
	end

	if self._goIconBottom then
		uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, not self._curData.hasPay)
	end

	GameUtil.SetActive(self._goBuyProgress, funcCfg.isShowBuy and self._curData.progressAbletToBuy > 0)
end

function MMTeamPassportView:_updateBuyState()
	local hasPay = self._curData.hasPay

	GameUtil.SetGray(self._btnBuyPassport, hasPay)
	GameUtil.SetActive(self._goLock, not hasPay)

	if hasPay then
		self._txtBuyPassport.text = "已购买"

		return
	end

	local price = PayConfig.instance:getPayMoneyYuan(self._curData.actCfg.goodsId) or ""

	self._txtBuyPassport.text = string.format("%s元购买", price)
end

function MMTeamPassportView:_updateOneKeyGainState()
	local isCanGet = self:_hasOneKeyReward()

	GameUtil.SetActive(self._goOneKey, true)
	GameUtil.SetActive(self._redpoint, isCanGet)

	if self._txtOneKey then
		self._txtOneKey.text = "一键领取"
	end
end

function MMTeamPassportView:_hasOneKeyReward()
	if not self._curData or self._curData.unlockIndex <= 1 then
		return false
	end

	for i = 1, self._curData.unlockIndex - 1 do
		if not self._curData.normalPrizeState[i] then
			return true
		end

		if self._curData.hasPay and not self._curData.superPrizeState[i] then
			return true
		end
	end

	return false
end

function MMTeamPassportView:_createCellDataList()
	local dataList = {}

	self._canGetRewardIndex = 0

	for index, cfg in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = cfg.thresholdParam
		data.freePrize = cfg.freePrize
		data.payedPrize = cfg.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]

		if self._canGetRewardIndex == 0 and index < self._curData.unlockIndex and (not data.freeState or self._curData.hasPay and not data.superState) then
			self._canGetRewardIndex = index
		end

		table.insert(dataList, data)
	end

	return dataList
end

function MMTeamPassportView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PassportCellItem)

	if self._scrollRect and self._curData and data then
		component:setData(self, self._scrollRect, self._curData, data)

		if component._effs then
			for _, eff in pairs(component._effs) do
				self:_keepTabEffectVisible(eff)
			end
		end
	end

	if cell.index then
		self:_refreshShowCell(cell.index + 1)
	end
end

function MMTeamPassportView:_onReloadFinish()
	if not self._curViewDatas or #self._curViewDatas == 0 then
		return
	end

	if self._canGetRewardIndex > 0 then
		local var_18_0 = self._canGetRewardIndex

		if not self._canGetRewardIndex then
			if self._curData then
				var_18_0 = self._curData.unlockIndex

				if not self._curData.unlockIndex then
					local index = 1

					index = math.max(1, math.min(index, #(self._curViewDatas or {})))

					self:moveCellToCenter(index, 200)
					self:_refreshShowCell(index)
				end
			end
		end
	end
end

function MMTeamPassportView:_refreshShowCell(dataId)
	if not self._showcell or not self._curData then
		return
	end

	local cfg = self._curData.prizeCfgs[dataId]

	if cfg then
		if not cfg.showId then
			local showId = dataId

			if self._showId == showId then
				return
			end

			self._showId = showId

			local data = self._curData.prizeCfgs[checknumber(showId)]

			if not data then
				goutil.setActive(self._showcell, false)

				return
			end

			self:_resetShowCell()
			MaterialMgr.setCellByCfg(data.freePrize, self._freePrizeShow)

			local supersPrizes = string.split(data.payedPrize or "", "#")

			MaterialMgr.setCellByCfg(supersPrizes[1], self._superPrizeShow_1)
			MaterialMgr.setCellByCfg(supersPrizes[2], self._superPrizeShow_2)

			if self._txtProgressShow then
				self._txtProgressShow.text = langPara("%s勋章奖励", data.thresholdParam)
			end

			goutil.setActive(self._showcell, true)
		end
	end
end

function MMTeamPassportView:_resetShowCell()
	if self._freePrizeShow then
		MaterialMgr.resetAll(self._freePrizeShow)
	end

	if self._superPrizeShow_1 then
		MaterialMgr.resetAll(self._superPrizeShow_1)
	end

	if self._superPrizeShow_2 then
		MaterialMgr.resetAll(self._superPrizeShow_2)
	end
end

function MMTeamPassportView:_refreshTeamPrizes()
	local subMo = self:_getSubMo()

	for _, item in ipairs(self._teamPrizeItems) do
		local cfg = MMTeamPassportConfig.instance:getTeamPrizeData(self._activityId, item.prizeId)
		local prize = cfg.prize
		local isHasGain = subMo:isGainTeamPrize(item.prizeId) == true
		local isCanGet = subMo:isCanGetTeamPrize(item.prizeId) == true

		MaterialMgr.setCellByCfg(prize, item.item)

		item.tipsTxt.text = string.format("邀请%s名队员可领", cfg.memberCount)

		GameUtil.SetActive(item.btnGet, isCanGet)
		GameUtil.SetActive(item.tagHasGain, isHasGain)

		if isCanGet then
			local function loadedHandler(_, eff)
				self:_keepTabEffectVisible(eff)
			end

			self:playViewEffectUniGo(TEAM_PRIZE_EFFECT, item.effRoot, nil, true, nil, loadedHandler)
		else
			self:stopViewEffectUniGo(item.effRoot)
		end
	end
end

function MMTeamPassportView:_clearTeamPrizes()
	for _, item in ipairs(self._teamPrizeItems or {}) do
		MaterialMgr.resetAll(item.item)
		self:stopViewEffectUniGo(item.effRoot)
	end
end

function MMTeamPassportView:_getSubMo()
	return MMTeamPassportController.instance:getSubMo(self._activityId)
end

function MMTeamPassportView:_onClickBtnHelp()
	if self._curData and self._curData.funcCfg then
		ViewMgr.instance:open(ViewName.RulesView, self._curData.funcCfg.rule)
	end
end

function MMTeamPassportView:_onClickBtnGoTo()
	UIStateManager.instance:push(ViewName.diamondtask, GameEnum.TaskViewTab.Daily)
end

function MMTeamPassportView:_onClickBtnOneKey()
	if not self._curData then
		return
	end

	if not self:_hasOneKeyReward() then
		FloatWordMgr.instance:show("暂无可领取奖励")

		return
	end

	PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)
end

function MMTeamPassportView:_onClickBtnBuyProgress()
	if not self._curData or self._curData.progressAbletToBuy <= 0 then
		GameUtil.SetActive(self._goBuyProgress, false)

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyporgressView, self._curData.funcCfg, self._curData.actCfg, self._curData.progressAbletToBuy)
end

function MMTeamPassportView:_onClickBtnBuyPassport()
	if not self._curData then
		return
	end

	if self._curData.hasPay then
		FloatWordMgr.instance:show("已购买")

		return
	end

	local buyEndTime = self._curData.actCfg.buyEndTime

	if not string.nilorempty(buyEndTime) and ServerTime.now() >= GameUtil.string2time(buyEndTime) then
		FloatWordMgr.instance:show("已到截止购买时间")

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue)
end

function MMTeamPassportView:_onClickTeamPrize(prizeId)
	local subMo = self:_getSubMo()

	if subMo:isGainTeamPrize(prizeId) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not subMo:isCanGetTeamPrize(prizeId) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	MMTeamPassportController.instance:sendPM_MMTeamPassportGainTeamPrizeReq(self._activityId, prizeId)
end

function MMTeamPassportView:_updateTime()
	if not self._curData or checknumber(self._curData.endTime) <= 0 then
		return
	end

	removetimer(self._updatePerSec, self)
	ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updatePerHour, self)

	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)

		return
	end

	GameUtil.SetActive(self._timeTips, true)

	if countDownTime > 86400 then
		ClockMgr.instance:addListener(ClockMgr.TickHour, self._updatePerHour, self)

		self._txtTime.text = TimeUtil:timeConvert(countDownTime, "DD天HH时", true)
	else
		settimer(1, self._updatePerSec, self)

		self._txtTime.text = TimeUtil:timeConvert2(countDownTime, "HH:MM:SS", true)
	end
end

function MMTeamPassportView:_updatePerSec()
	if not self._curData then
		return
	end

	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)

		return
	end

	self._txtTime.text = TimeUtil:timeConvert2(countDownTime, "HH:MM:SS", true)
end

function MMTeamPassportView:_updatePerHour()
	if not self._curData then
		return
	end

	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)

		return
	end

	if countDownTime > 86400 then
		self._txtTime.text = TimeUtil:timeConvert(countDownTime, "DD天HH时", true)
	else
		ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updatePerHour, self)
		settimer(1, self._updatePerSec, self)
	end
end

function MMTeamPassportView:_updatePerDay()
	if checknumber(self._activityId) <= 0 then
		return
	end

	MMTeamPassportController.instance:sendPM_MMTeamPassportGetInfoReq(self._activityId)
end

function MMTeamPassportView:_keepTabEffectVisible(eff)
	if not eff then
		return
	end

	eff.hideEffWhileNotOnTop = false

	eff:setVisible(true, true)
end

return MMTeamPassportView
