-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipGiftItem.lua

module("logic.extensions.vip.view.VipGiftItem", package.seeall)

local VipGiftItem = class("VipGiftItem")

function VipGiftItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:OnEnter()
end

function VipGiftItem:OnDestroy()
	self:OnExit()
end

function VipGiftItem:buildUI()
	self._txtLevel = goutil.findChild(self.mainGO, "txtLevel/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._daily = goutil.findChild(self.mainGO, "daily")
	self._goReceiveDaily = goutil.findChild(self._daily, "btnReceive")
	self._btnReceiveDaily = GameUtil.asBtn(self._goReceiveDaily)
	self._dotReceiveDaily = goutil.findChild(self._goReceiveDaily, "redPoint")
	self._cellDaily = goutil.findChild(self._daily, "cell")
	self._tableDaily = goutil.findChild(self._daily, "table")
	self._countDown = goutil.findChild(self._daily, "txtCountDown")
	self._txtCountDown = self._countDown:GetComponent("Text")
	self._txtTitle = goutil.findChildTextComponent(self._daily, "txtTitle")
	self._tableViewDaily = ScrollerList.create(self._tableDaily, self._cellDaily, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableViewDaily:regReloadFinish(function()
		if self._init and self._mainView then
			self._init = false
		end
	end)

	self._dragDaily = Framework.UIDragTrigger.Get(self._tableDaily)
	self._exclusive = goutil.findChild(self.mainGO, "exclusive")
	self._bgBigItem = goutil.findChild(self._exclusive, "bigItem")
	self._iconBigItem = goutil.findChild(self._exclusive, "bigItem/icon")
	self._btnBigItem = GameUtil.asBtn(goutil.findChild(self._exclusive, "bigItem/btn"))
	self._markSkin = goutil.findChild(self._bgBigItem, "markSkin")
	self._txtNameBigItem = goutil.findChildTextComponent(self._exclusive, "bigItem/txtName")
	self._txtChange = goutil.findChild(self._exclusive, "bigItem/txtName"):GetComponent("UITextColorChange")
	self._mark = goutil.findChild(self._exclusive, "mark")
	self._goReceiveExclusive = goutil.findChild(self._exclusive, "btnReceive")
	self._btnReceiveExclusive = GameUtil.asBtn(self._goReceiveExclusive)
	self._dotReceiveExclusive = goutil.findChild(self._goReceiveExclusive, "redPoint")
	self._txtReceiveExclusive = goutil.findChildTextComponent(self._goReceiveExclusive, "Text")
	self._cellExclusive = goutil.findChild(self._exclusive, "cell")
	self._tableExclusive = goutil.findChild(self._exclusive, "table")
	self._tableViewExclusive = ScrollerList.create(self._tableExclusive, self._cellExclusive, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._dragExclusive = Framework.UIDragTrigger.Get(self._tableExclusive)
	self._btnGoto = goutil.findChild(self.mainGO, "btnGoto")
end

function VipGiftItem:setData(view, data, scrollRect)
	self._scrollRect = scrollRect
	self._mainView = view

	if self._curData ~= data then
		self._curData = data

		self._txtLevel:SetText(tostring(self._curData.vipLv))

		self._txtTitle.text = langPara("VIP %s 每周可领取", self._curData.vipLv)

		if not self._curData.weeklyBonus then
			local dailyPrizeStr = ""
			local dailyPrizes = string.split(dailyPrizeStr, "#")
			local dataList = {}

			for i, data in pairs(dailyPrizes) do
				if not GameUtil.isEmptyString(data) then
					table.insert(dataList, data)
				end
			end

			self._tableViewDaily:reloadData(dataList)
		end
	end

	self:updateState()
end

function VipGiftItem:updateState()
	self._curLv = VipModel.instance:getCurVipLv()

	GameUtil.SetGray(self._goReceiveExclusive, self._curLv < self._curData.vipLv)
	GameUtil.SetGray(self._goReceiveDaily, self._curLv < self._curData.vipLv)
	goutil.setActive(self._goReceiveDaily, not VipModel.instance:getGainDailyBonusStateByLv(self._curData.vipLv))
	goutil.setActive(self._dotReceiveDaily, not VipModel.instance:getGainDailyBonusStateByLv(self._curData.vipLv) and self._curLv >= self._curData.vipLv)
	removetimer(self._updateTimer, self)

	if self._curLv == self._curData.vipLv then
		if VipModel.instance:getGainDailyBonusStateByLv(self._curData.vipLv) then
			goutil.setActive(self._countDown, true)
			goutil.setActive(self._goReceiveDaily, false)
			self:_initCountTimer()
		else
			goutil.setActive(self._countDown, false)
			goutil.setActive(self._goReceiveDaily, true)
		end
	else
		goutil.setActive(self._countDown, false)
		goutil.setActive(self._goReceiveDaily, false)
	end

	self._curBonusProgress = VipModel.instance:getGainBonusStateByLv(self._curData.vipLv)
	self._curBonusCfgs = VipConfig.instance:getBonusCfgsByLv(self._curData.vipLv)

	local dataList = {}

	for _, cfg in pairs(self._curBonusCfgs) do
		table.insert(dataList, cfg)
	end

	self._curBonusCfgs = dataList

	table.sort(self._curBonusCfgs, function(a, b)
		return a.bonusId < b.bonusId
	end)

	self._isGainAll = self._curBonusProgress == table.nums(self._curBonusCfgs)

	goutil.setActive(self._mark, self._isGainAll)
	goutil.setActive(self._goReceiveExclusive, not self._isGainAll)

	if self._isGainAll then
		self._curBounsCfg = self._curBonusCfgs[self._curBonusProgress] or self._curBonusCfgs[self._curBonusProgress + 1]
	end

	self._exclusivePayGoodsId = self._curBounsCfg.payGoodsId
	self._isCurExclusiveFree = GameUtil.isEmptyString(self._exclusivePayGoodsId)
	self._isOpenTime = false

	if self._curBounsCfg and self._curBounsCfg.openTime then
		do
			local openTime = self._curBounsCfg.openTime
			local openTimeStamp = GameUtil.string2time(openTime)
			local curTime = ServerTime.now()

			self._isOpenTime = openTimeStamp <= curTime
		end
	else
		self._isOpenTime = true
	end

	goutil.setActive(self._dotReceiveExclusive, self._isCurExclusiveFree and self._curLv >= self._curData.vipLv and self._isOpenTime)

	if self._isCurExclusiveFree then
		self._txtReceiveExclusive.text = "领取"
	else
		local price = string.sub(self._exclusivePayGoodsId, GameUtil.getStrLen("rmb_") + 1, -1)

		self._txtReceiveExclusive.text = "￥ " .. price
	end

	if not self._curBounsCfg.prize then
		local prizeStr = ""
		local curPrizes = MaterialMgr.changeItemStrArr(prizeStr)
		local dataList = {}

		for i, data in pairs(curPrizes) do
			if not GameUtil.isEmptyString(data) then
				table.insert(dataList, data)
			end
		end

		local firstMat = table.remove(dataList, 1)

		MaterialMgr.updateItemByStr(self._iconBigItem, firstMat)

		local matType, id, matNum = MaterialMgr.getMatParams(firstMat)

		goutil.setActive(self._markSkin, matType == MatType.PET_SKIN)

		self._bigItemMatStr = firstMat

		if #dataList <= 0 then
			local matList = {
				firstMat
			}

			self._tableViewExclusive:reloadData(matList)
		else
			self._tableViewExclusive:reloadData(dataList)
		end

		self._txtNameBigItem.text = MaterialMgr.getMaterialsName(matType, id)

		local cfg = MaterialMgr.getMatCfg(matType, id)
		local quality = 0

		quality = matType == MatType.Equipment and (cfg.qualityBase or 0) or cfg.quality or 0

		self._txtChange:SetState(1 + math.min(quality, 4))

		if self._curLv == self._curData.vipLv then
			UIEffectManager.instance:stopEffect(self._selectEff)

			self._selectEff = UIEffectManager.instance:playEffect(self._mainView, "fx_ui_vip/fx_ui_vip_xuanzekuang.prefab", self.mainGO, 0, 0, true, false, nil, function(target, eff)
				eff.effGo.transform:SetParent(self.mainGO.transform)
				eff:setScrollRectClipping(self._scrollRect)
				GameUtil.setLocalScale(eff.effGo, 1, 1, 1)
				GameUtil.setLocalPos(eff.effGo, 0, 0, 0)

				eff.hideEffWhileNotOnTop = true
			end)
		elseif self._selectEff then
			UIEffectManager.instance:stopEffect(self._selectEff)

			self._selectEff = nil
		end

		local gotoStr = self._curBounsCfg.gotoStr

		GameUtil.SetActive(self._btnGoto, not string.nilorempty(gotoStr))
	end
end

function VipGiftItem:_initCountTimer()
	local now = GameUtil.time2date(ServerTime.now())
	local endDay = now.day
	local wday = now.wday - 1
	local curWeekDay = wday == 0 and 7 or wday

	if curWeekDay < 5 then
		endDay = endDay + (5 - curWeekDay)
	elseif curWeekDay == 5 then
		if now.hour >= 5 then
			endDay = endDay + 7
		end
	else
		endDay = endDay + 5 + (7 - curWeekDay)
	end

	self._endTime = os.time({
		hour = 5,
		second = 0,
		minute = 0,
		day = endDay,
		month = now.month,
		year = now.year
	})
	self._countDownTime = self._endTime - ServerTime.now()

	if not self._countDownTime or self._countDownTime <= 0 then
		self:updateState()

		return
	end

	self:_updateTimer()
	settimer(1, self._updateTimer, self)
end

function VipGiftItem:_updateTimer()
	local hour, min, sec = GameUtil.getTimeHHMMSS(self._countDownTime)

	self._txtCountDown.text = string.format("倒计时：%02d:%02d:%02d", hour, min, sec)
	self._countDownTime = self._endTime - ServerTime.now()

	if self._countDownTime <= 0 then
		removetimer(self._updateTimer, self)
		VipController.instance:sendGetVipInfoReq()
	end
end

function VipGiftItem:OnEnter()
	self._init = true

	self._btnBigItem:AddClickListener(self._onClickBigItem, self)
	self._btnReceiveDaily:AddClickListener(self._onClickBtnReceiveDaily, self)
	self._btnReceiveExclusive:AddClickListener(self._onClickBtnReceiveExclusive, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickBtnGoto, self)
	GlobalDispatcher:addListener(GlobalNotify.BroadcastCurVipLevel, self.updateState, self)
	self._dragDaily:AddDragListener(self._onDrag, self)
	self._dragDaily:AddBeginDragListener(self._onBeginDrag, self)
	self._dragDaily:AddEndDragListener(self._onEndDrag, self)
	self._dragExclusive:AddDragListener(self._onDrag, self)
	self._dragExclusive:AddBeginDragListener(self._onBeginDrag, self)
	self._dragExclusive:AddEndDragListener(self._onEndDrag, self)
end

function VipGiftItem:OnExit()
	self._btnBigItem:RemoveClickListener()
	self._btnReceiveDaily:RemoveClickListener()
	self._btnReceiveExclusive:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnGoto)
	GlobalDispatcher:removeListener(GlobalNotify.BroadcastCurVipLevel, self.updateState, self)
	self._tableViewDaily:dispose()
	self._tableViewExclusive:dispose()
	self._dragDaily:RemoveDragListener()
	self._dragDaily:RemoveBeginDragListener()
	self._dragDaily:RemoveEndDragListener()
	self._dragExclusive:RemoveDragListener()
	self._dragExclusive:RemoveBeginDragListener()
	self._dragExclusive:RemoveEndDragListener()
	MaterialMgr.clearIcon(self._iconBigItem)
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end

	removetimer(self._updateTimer, self)

	self._curData = nil
	self._mainView = nil
end

function VipGiftItem:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function VipGiftItem:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function VipGiftItem:_onClickBtnReceiveDaily()
	if self._curLv >= self._curData.vipLv and not VipModel.instance:getGainDailyBonusStateByLv(self._curData.vipLv) then
		VipController.instance:sendGainVipDailyBonusReq(self._curData.vipLv, self.updateState, self)
	else
		FloatWordMgr.instance:show("只有VIP" .. self._curData.vipLv .. "以上的用户才能领取该礼包")
	end
end

function VipGiftItem:_onClickBtnReceiveExclusive()
	if self._curLv < self._curData.vipLv then
		FloatWordMgr.instance:show("只有VIP等级" .. self._curData.vipLv .. "以上的用户才能领取该礼包")
		GameUtil.SetGray(self._goReceiveExclusive, true)
		goutil.setActive(self._goReceiveExclusive, true)
		goutil.setActive(self._mark, false)
	elseif self._isGainAll then
		FloatWordMgr.instance:show(string.format("VIP%s的专属礼包已全部领取", self._curData.vipLv))
		goutil.setActive(self._mark, true)
		goutil.setActive(self._goReceiveExclusive, false)
	else
		goutil.setActive(self._goReceiveExclusive, true)

		if self._isCurExclusiveFree then
			if self._isOpenTime then
				VipController.instance:sendGainVipBonusReq(self._curData.vipLv, self.updateState, self)
			else
				local openTime = self._curBounsCfg.openTime
				local timeStr = GameUtil.formatTimeString("%Y年%m月%d日%H:%M:%S后可领取", openTime)

				FloatWordMgr.instance:show(timeStr)
			end
		else
			PayController.instance:pay(self._exclusivePayGoodsId, GameEnum.PaySubGoodsType.Privilege_GIFT, self._curBounsCfg.bonusId)
		end
	end
end

function VipGiftItem:_onClickBigItem()
	if GameUtil.isEmptyString(self._bigItemMatStr) then
		return
	end

	CommonTipsMgr.instance:openTipsByConfStr(self._iconBigItem, self._bigItemMatStr)
end

function VipGiftItem:_onClickBtnGoto()
	local gotoStr = self._curBounsCfg.gotoStr

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function VipGiftItem:_onDrag(eventData)
	if self._mainView then
		self._mainView:dragCellChild(eventData)
	end
end

function VipGiftItem:_onBeginDrag(eventData)
	if self._mainView then
		self._mainView:dragBegingCellChild(eventData)
	end
end

function VipGiftItem:_onEndDrag(eventData)
	if self._mainView then
		self._mainView:dragEndCellChild(eventData)
	end
end

return VipGiftItem
