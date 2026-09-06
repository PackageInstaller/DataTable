-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckydrawtimestatemultipleView.lua

module("logic.extensions.luckydraw.view.LuckydrawtimestatemultipleView", package.seeall)

local LuckydrawtimestatemultipleView = class("LuckydrawtimestatemultipleView", ViewComponent)

function LuckydrawtimestatemultipleView:buildUI()
	LuckydrawtimestatemultipleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
	self._rare = self:getGo("petInfo/imgRare")
	self._txtInfo = self:getTxt("rank/txtInfo")
	self._tipEmpty = self:getGo("rank/tipEmpty")
	self._fadeOut = self._txtInfo.gameObject:GetComponent("UITweenFadeOut")
	self._txtTime = self:getTxt("time/txt")
	self._btnMask = self:getBtn("btnmask")
	self._goGoldBarCon = self:getGo("goldBarCon")
	self._goMarkGain = self:getGo("markGain")
	self._tagDiscount = self:getGo("btnStart/tag")
	self._txtTagDiscount = self:getTxt("btnStart/tag/Text")
	self._tableviewGo = self:getGo("petIconList")
	self._tablecellGo = self:getGo("petIconCell")
	self._petscrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSkipAni = self:getBtn("skipani/btnSkipAni")
	self._gouGo = self:getGo("skipani/btnSkipAni/gou")
	self._rewardtableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardtableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self._bg1Go = self:getGo("bg1")
	self._bg2Go = self:getGo("bg2")
	self._bgGos = {
		self._bg1Go,
		self._bg2Go
	}
	self._tipstableviewGo = self:getGo("itemtips/tableview")
	self._itemtipsGo = self:getGo("itemtips")
	self._tipsitemtipsGo = self:getGo("itemtips/tablecell")

	goutil.setActive(self._itemtipsGo, false)

	self._tipsscrollerList = ScrollerList.create(self._tipstableviewGo, self._tipsitemtipsGo, GameUtil.handler(self._updateTipsCell, self), GameUtil.handler(self._clearTipsCell, self))
	self._inputGo = self:getGo("itemtips/inputGo")
	self._goLine = self:getGo("costcon/costDis")
	self._txtCost = self:getTxt("costcon/cost/txt")
	self._txtDiscount = self:getTxt("costcon/costDis/txt")
	self._iconCost = self:getGo("costcon/cost/icon")
	self._iconDisCost = self:getGo("costcon/costDis/icon")
	self._txtTimesTip = self:getTxt("txtTimesTip")
	self._txtTotalCostTip = self:getTxt("txtTotalCostTip")
	self._btnRank = self:getBtn("rank/btnRank")
	self._singleLine = self:getGo("costcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._roleImgGo = self:getGo("roleImg")
	self._petPhoto = PetPhotoShow.Get(self._roleImgGo)
	self._cellGo = self:getGo("cell")
	self._cellsconGo = self:getGo("cellscon")

	goutil.setActive(self._cellGo, false)

	self._cellRecordPos = self._cellsconGo:GetComponent(typeof(TestRecordPos))

	self:_buildCells()

	self._txtTip = self:getTxt("txtTip")
	self._txtBtnJump = self:getTxt("btnJump/txt")
	self._btnJump = self:getBtn("btnJump")
	self._btnJumpWandererPass = self:getGo("btnJumpWandererPass")
	self._btnQuan = self:getGo("btnQuan")
	self._imgSelect = self:getGo("btnQuan/imgSelect")
end

function LuckydrawtimestatemultipleView:_buildCells()
	self._prizeCells = {}

	for i = 1, 8 do
		local cell = {}

		cell.go = goutil.cloneAndSetParent(self._cellGo, self._cellsconGo.transform)
		cell.select = goutil.findChild(cell.go, "select")
		cell.item = goutil.findChild(cell.go, "item")
		cell.matStr = nil

		goutil.setActive(cell.go, true)

		self._prizeCells[i] = cell
	end

	self._cellRecordPos:LoadPlan(0)
end

function LuckydrawtimestatemultipleView:onEnter()
	LuckydrawtimestatemultipleView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.LuckyDrawGainProcessPirzeRes, self._onLuckyDrawGainProcessPirzeRes, self)
	self.addGEvent(self, GlobalNotify.LuckyDrawDrawRes, self._onLuckyDrawDrawRes, self)
	self.addGEvent(self, GlobalNotify.LuckyDrawGetInfo, self._updateViewByData, self)
	self:dealWithActIdAndRDId()

	self._actId = LuckyDrawModel.instance:getActId()

	if self._actId and ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LuckyDraw, self._actId) then
		self:_setViewByCfg()
		LuckyDrawController.instance:sendGetInfo()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	self._activityId = self._actId

	local tipStr = self._actCommonCfg.tipStr
	local hasStr = not string.nilorempty(tipStr)

	self._txtTip.text = tipStr

	GameUtil.SetActive(self._txtTip.gameObject, hasStr)

	local btnList = {}
	local actCfg = LuckyDrawConfig.instance:getActCfg(self._activityId) or {}

	table.insert(btnList, {
		showAdd = true,
		id = GameEnum.GoldType.GodDiamondCoin
	})
	table.insert(btnList, {
		showAdd = true,
		id = actCfg.coupon
	})
	MainUIController.instance:showGlodBar(self._goGoldBarCon, self._viewPresentor, btnList)
	self:_updateBtnJumpState()
	GameUtil.SetActive(self._btnJumpWandererPass, false)

	local activityId = WandererpassController.CURR_ACTIVITY_ID

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		GameUtil.SetActive(self._btnJumpWandererPass, true)
	end

	self:_updateCoupon()
end

function LuckydrawtimestatemultipleView:_updateCoupon(isShowTips)
	GameUtil.SetActive(self._btnQuan, false)

	local actCfg = LuckyDrawConfig.instance:getActCfg(self._activityId) or {}

	if not string.nilorempty(actCfg.coupon) then
		GameUtil.SetActive(self._btnQuan, true)

		if not MaterialMgr.getMatEnough(actCfg.coupon) then
			GameUtil.SetActive(self._imgSelect, false)
			WandererpassController.instance:setCouponSelect(self._activityId, false)

			if isShowTips then
				TipsFacade.instance:openCommonTips(langPara("%s不足", MaterialMgr.getMaterialsNameByCfg(actCfg.coupon)))
			end
		else
			local boo = WandererpassController.instance:getCouponSelect(self._activityId)

			GameUtil.SetActive(self._imgSelect, boo)
		end
	else
		WandererpassController.instance:setCouponSelect(self._activityId, false)
	end
end

function LuckydrawtimestatemultipleView:dealWithActIdAndRDId()
	local curActId = checkint(self:getFirstParam())

	LuckyDrawController.instance:refreshActivtyId(curActId)
	LuckyDrawController.instance:resetLuckDrawTimeStateRedPoint()
end

function LuckydrawtimestatemultipleView:onExit()
	LuckydrawtimestatemultipleView.super.onExit(self)

	for i = 1, #self._prizeCells do
		MaterialMgr.resetAll(self._prizeCells[i].item)
	end

	MaterialMgr.resetAll(self._iconCost)
	MaterialMgr.resetAll(self._iconDisCost)
	self:_endDrawAni(false)
	removetimer(self._timerCountDown, self)
	removetimer(self._showNewRank, self)
	self:_removeAllEffect()
	self._petscrollerList:dispose()
	self._rewardScrollList:dispose()
	self._tipsscrollerList:dispose()
	self._petPhoto:destroy()

	self._showSkinCfg = nil
end

function LuckydrawtimestatemultipleView:bindEvents()
	LuckydrawtimestatemultipleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnMask:AddClickListener(self._onClickMark, self)
	self._btnSkipAni:AddClickListener(self._onClickbtnSkipAni, self)

	local customInput = UICustomInput.Get(self._itemtipsGo)

	customInput:AddListener(self._onCustomInputCallback, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnJump:AddClickListener(self._onClickbtnJump, self)
	GameUtil.addClickHandler(self._btnJumpWandererPass, self._onClickJumpWandererPass, self)
	GameUtil.addClickHandler(self._btnQuan, self._onClickQuanSelect, self)
end

function LuckydrawtimestatemultipleView:unbindEvents()
	LuckydrawtimestatemultipleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._btnSkipAni:RemoveClickListener()

	local customInput = UICustomInput.Get(self._inputGo)

	customInput:RemoveListener()
	self._btnRank:RemoveClickListener()
	self._btnJump:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnJumpWandererPass)
	GameUtil.rmClickHandler(self._btnQuan)
end

function LuckydrawtimestatemultipleView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawtimestaterule")
end

function LuckydrawtimestatemultipleView:_onClickStart()
	if self._goMarkGain.activeSelf then
		FloatWordMgr.instance:show(lang("您已获得本次活动的大奖，无法再进行许愿"))

		return
	end

	if self:_checkCanGainPrize() then
		FloatWordMgr.instance:show("请先领取进度奖励")

		return
	end

	if not self._actCommonCfg.extPrize then
		local extPrize = "8:1:1000"
		local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(extPrize)
		local extName = MaterialMgr.getMaterialsName(extPrizeType, extPrizeId)
		local costName = MaterialMgr.getMaterialsName(self._costMatType, self._costMatId)

		if self._isDiscount then
			if not self._costDiscountNum then
				local curCostNum = self._costMatNum
				local isExpendMoneyActivity = FemaleGodController.instance:isExpendMoneyActivity(self._actId)

				self:_updateCoupon()

				local boo = WandererpassController.instance:getCouponSelect(self._activityId)

				if boo then
					local activityId = WandererpassController.CURR_ACTIVITY_ID

					if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
						local actCfg = LuckyDrawConfig.instance:getActCfg(self._activityId) or {}
						local mt, id, num = MaterialMgr.getMatParams(actCfg.coupon)
						local name = MaterialMgr.getMaterialsNameByCfg(actCfg.coupon)
						local content = langPara("确定消耗%sx%s，直接进行本次抽奖？\n可抵消%s%s", name, num, curCostNum, costName)

						TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
							LuckyDrawController.instance:sendDraw(isExpendMoneyActivity, boo)
						end)

						return
					end
				end

				if isExpendMoneyActivity then
					FemaleGodController.instance:showCostTipType(self._actId, self._actCommonCfg.cost, curCostNum, "进行一次许愿吗？", function()
						local hasEnoughMoney = FemaleGodController.instance:hasEnoughMoney(self._actId, curCostNum, self._actCommonCfg.cost)

						if hasEnoughMoney then
							LuckyDrawController.instance:sendDraw(isExpendMoneyActivity, boo)
						else
							FloatWordMgr.instance:show(langPara("%s不足", costName))
						end
					end)
				else
					local content = langPara("确定花费%s%s购买%s%s，并进行1次许愿吗？", curCostNum, costName, extPrizeNum, extName)

					TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, curCostNum, content, function()
						LuckyDrawController.instance:sendDraw(isExpendMoneyActivity, boo)
					end)
				end
			end
		end
	end
end

function LuckydrawtimestatemultipleView:_onClickInfo()
	if self._showSkinCfg then
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self._showSkinCfg.skinId)
	end
end

function LuckydrawtimestatemultipleView:_onClickSkill()
	if self._showSkinCfg then
		PetbookController.instance:previewBattle(self._showSkinCfg.raceId, self._showSkinCfg.skinId)
	end
end

function LuckydrawtimestatemultipleView:_onClickMark()
	FloatWordMgr.instance:show("抽奖中，请稍等")
end

function LuckydrawtimestatemultipleView:_setViewByCfg()
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.LuckyDraw, self._actId)
	self._actCommonCfg = LuckyDrawConfig.instance:getActCfg(self._actId)
	self._prizeCfgs = LuckyDrawConfig.instance:getPrizeCfg(self._actId)
	self._drawTimesCfgs = LuckyDrawConfig.instance:getDrawTimesPlanCfg(self._actId)

	self:_setPrizeCellsByCfg()
	self:_setCostMatByCfg()
	self:_setCountTimerByCfg()

	if self._actCommonCfg then
		if not self._actCommonCfg.mainEffPath then
			local mainEffPath = ""

			if not string.nilorempty(mainEffPath) then
				self:_createEff(string.format("%s.prefab", mainEffPath), self.mainGO, "mainEff", true)
			end

			self:_setPets()
			self:_setSkipState()
			self:_setProgressReward()
			self:_calGetBigPrizeCostDesc()
			self:_calTimesDesc()
		end
	end
end

function LuckydrawtimestatemultipleView:_setPrizeCellsByCfg()
	self._curGaintPrizeId = 0

	if self._prizeCfgs then
		for i = 1, #self._prizeCells do
			local cell = self._prizeCells[i]

			cell.cfg = self._prizeCfgs[i]
			cell.matStr = cell.cfg.prize

			if cell.cfg then
				MaterialMgr.setCellByCfg(cell.matStr, cell.item)

				if cell.cfg.prizeType ~= 1 then
					-- block empty
				else
					self._curGaintPrizeId = i
				end
			end

			goutil.setActive(cell.select, false)
		end
	end
end

function LuckydrawtimestatemultipleView:_setCostMatByCfg()
	if self._actCommonCfg then
		local costItem = self._actCommonCfg.cost

		self._costMatType, self._costMatId, self._costMatNum = MaterialMgr.getMatParams(costItem)

		MaterialMgr.setIcon(self._iconCost, self._costMatType, self._costMatId)
		MaterialMgr.setIcon(self._iconDisCost, self._costMatType, self._costMatId)

		local costDiscount = self._actCommonCfg.discountCost

		self._costDiscountType, self._costDiscountId, self._costDiscountNum = MaterialMgr.getMatParams(costDiscount)

		if self._isDiscount then
			self._txtDiscount.text = self._costMatNum
			self._txtCost.text = self._costDiscountNum
		else
			self._txtCost.text = self._costMatNum
		end
	end
end

function LuckydrawtimestatemultipleView:_setCountTimerByCfg()
	if self._actTimeCfg then
		removetimer(self._timerCountDown, self)

		self._curEndTime = GameUtil.string2time(self._actTimeCfg.endTime)

		self:_timerCountDown()
		settimer(1, self._timerCountDown, self)
	end
end

function LuckydrawtimestatemultipleView:_timerCountDown()
	local timeLeft = self._curEndTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

function LuckydrawtimestatemultipleView:_updateViewByData()
	if not self._actCommonCfg then
		return
	end

	self:_setProgressInfo()
	self:_setGaintPrizeState()
	self:_setRankInfo()
	self:_setProgressReward()
	self:_calTimesDesc()
end

function LuckydrawtimestatemultipleView:_setProgressInfo()
	local totalTimes = LuckyDrawModel.instance:getTotalDrawtimes()

	self._isDiscount = false

	if self._actCommonCfg then
		local discountRange = self._actCommonCfg.discountTimesRange

		if discountRange then
			local curNextTime = totalTimes + 1

			if curNextTime >= discountRange[1] and curNextTime <= discountRange[2] then
				self._isDiscount = true
			end
		end

		goutil.setActive(self._txtDiscount.gameObject, self._isDiscount)
		goutil.setActive(self._goLine, self._isDiscount)
		goutil.setActive(self._tagDiscount, self._isDiscount)
		self._singleLine:Layout()

		if self._isDiscount then
			local str = ""
			local percent = ""

			if self._costMatNum <= 0 then
				str = "免费"
			else
				local p = self._costDiscountNum / self._costMatNum * 100

				percent = p == math.floor(p) and p or string.format("%.2f", p)
			end

			if discountRange then
				str = discountRange[1] == discountRange[2] and string.format("第%s次%s折", discountRange[1], percent) or discountRange[1] == 1 and string.format("前%s次%s折", discountRange[2], percent) or string.format("第%s-%s次%s折", discountRange[1], discountRange[2], percent)
			end
		end

		self:_setCostMatByCfg()
	end
end

function LuckydrawtimestatemultipleView:_setGaintPrizeState()
	goutil.setActive(self._goMarkGain, false)

	if self._curGaintPrizeId ~= 0 then
		local curGianNum = LuckyDrawModel.instance:getPrizeDrawNum(self._curGaintPrizeId)

		if curGianNum >= self._prizeCfgs[self._curGaintPrizeId].limit then
			if self._actCommonCfg.isResetPrize then
				self:dealWithActIdAndRDId()
				LuckyDrawController.instance:sendGetInfo()
			else
				goutil.setActive(self._goMarkGain, true)
			end
		end
	end

	local aniPath = self._actCommonCfg.aniPath

	if not string.nilorempty(aniPath) then
		local playerDataKey = "lucky_draw_time_state_animation" .. self._actId

		if checknumber(GameUtil.getUserDayData(playerDataKey)) <= 0 then
			GameUtil.saveUserDayData(playerDataKey, 1)

			local animConfig = {
				passable = false,
				animName = aniPath,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
		end
	end
end

function LuckydrawtimestatemultipleView:_setRankInfo()
	removetimer(self._showNewRank, self)

	self._curRankId = 0
	self._rankList = LuckyDrawModel.instance:getRecordList()

	if #self._rankList <= 0 then
		goutil.setActive(self._txtInfo.gameObject, false)
		goutil.setActive(self._tipEmpty, true)

		self._fadeOut.enabled = false
	else
		goutil.setActive(self._txtInfo.gameObject, true)
		goutil.setActive(self._tipEmpty, false)
		settimer(3, self._showNewRank, self)
		self:_showNewRank()
	end
end

function LuckydrawtimestatemultipleView:_showNewRank()
	self._curRankId = self._curRankId + 1

	if #self._rankList < self._curRankId then
		self._curRankId = 1
	end

	local data = self._rankList[self._curRankId]
	local prizeName = LuckyDrawConfig.instance:getCommonValue("Client_Big_Prize_Name")

	self._txtInfo.text = langPara("%s服的%s在第%s次许愿成功获得%s", data.areaName, data.userName, data.totalDrawTimes, prizeName)
	self._fadeOut.enabled = true
end

function LuckydrawtimestatemultipleView:getCurTotalCostNum(time)
	local curTime = checkint(time)
	local curCostNum = 0

	if self._actCommonCfg then
		for i = 1, curTime do
			curCostNum = self._actCommonCfg and i >= self._actCommonCfg[1] and i <= self._actCommonCfg[2] and curCostNum + self._costDiscountNum or curCostNum + self._costMatNum
		end

		return curCostNum
	end
end

function LuckydrawtimestatemultipleView:_startDrawAni(prizeIds)
	goutil.setActive(self._btnMask.gameObject, true)

	self._selectIds = prizeIds or {}
	self._lastSelectId = 1

	local count = 0

	for k, v in ipairs(self._selectIds) do
		count = count + 1

		if v > self._lastSelectId then
			self._lastSelectId = v
		end
	end

	if count <= 0 then
		return self:_endDrawAni()
	end

	self._rorateRounds = 2
	self._curSelectId = 0
	self._rorateStepNums = #self._prizeCells * self._rorateRounds

	settimer(0.1, self._rorateEff, self)
end

function LuckydrawtimestatemultipleView:_endDrawAni(updateData)
	goutil.setActive(self._btnMask.gameObject, false)

	self._selectIds = nil

	for k, v in pairs(self._prizeCells) do
		goutil.setActive(v.select, false)
	end

	removetimer(self._rorateEff, self)
	removetimer(self._rorateEffNext, self)
	removetimer(self._endDrawAni, self)
	LuckyDrawController.instance:showMonopolyCI()

	if updateData == nil then
		updateData = true
	end

	if updateData then
		self:_updateViewByData()
	end
end

function LuckydrawtimestatemultipleView:_rorateEff()
	if self._rorateStepNums <= 0 then
		removetimer(self._rorateEff, self)

		for k, v in pairs(self._prizeCells) do
			goutil.setActive(v.select, false)
		end

		for k, v in ipairs(self._selectIds) do
			goutil.setActive(self._prizeCells[v].select, true)
		end

		settimer(1, self._endDrawAni, self, false)

		return
	end

	local lastSelectId = self._curSelectId

	if self._prizeCells[lastSelectId] then
		goutil.setActive(self._prizeCells[lastSelectId].select, false)
	end

	self._rorateStepNums = self._rorateStepNums - 1
	self._curSelectId = self._curSelectId + 1

	if self._curSelectId > #self._prizeCells then
		self._curSelectId = 1
	end

	goutil.setActive(self._prizeCells[self._curSelectId].select, true)
end

function LuckydrawtimestatemultipleView:_rorateEffNext()
	local lastSelectId = self._curSelectId

	if self._prizeCells[lastSelectId] and not table.keyof(self._selectIds, lastSelectId) then
		goutil.setActive(self._prizeCells[lastSelectId].select, false)
	end

	if self._rorateStepNums >= self._lastSelectId then
		self:_endDrawAni()
		self:_updateViewByData()

		return
	end

	self._rorateStepNums = self._rorateStepNums + 1
	self._curSelectId = self._curSelectId + 1

	if self._curSelectId > #self._prizeCells then
		self._curSelectId = 1
	end

	goutil.setActive(self._prizeCells[self._curSelectId].select, true)
end

function LuckydrawtimestatemultipleView:_createEff(effPath, effParent, effKey, isLoop)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	self._exictEffs[effKey] = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
	end)
end

function LuckydrawtimestatemultipleView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function LuckydrawtimestatemultipleView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function LuckydrawtimestatemultipleView:_updateCell(view, cell, skinId, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local withTag = goutil.findChild(cell, "withTag")
	local isWith = MaterialMgr.isWithInSkinPrize(MatType.PET_SKIN, skinId)

	goutil.setActive(withTag, isWith)

	local cfg = CharacterConfig.instance:getModelCo(skinId)
	local spriteName = GameUrl.getCharacterIconUrl(cfg.headName)

	goutil.setActive(goSelect, self._showSkinCfg and self._showSkinCfg.skinId == skinId)
	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, spriteName)
	btn:AddClickListener(function()
		self:_onClickSkin(skinId)
	end)
end

function LuckydrawtimestatemultipleView:_clearCell(cell)
	return
end

function LuckydrawtimestatemultipleView:_onClickSkin(skinId)
	self._showSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if self._showSkinCfg then
		local posx, posy, scale
		local posScaleCfg = LuckyDrawConfig.instance:getSkinPosScale(skinId)

		if posScaleCfg and posScaleCfg.pos then
			posy = posScaleCfg.pos[2]
			posx = posScaleCfg.pos[1]

			if posScaleCfg.scale > 0 then
				scale = posScaleCfg.scale
			end
		end

		self._petPhoto:showPetEffect(self._showSkinCfg.skinId, true)

		if posx then
			self._petPhoto:setPetLocalPosAndScale(posx, posy, scale)
		end

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._showSkinCfg.skinId)

		if skinCfg then
			self._txtName.text = skinCfg.skinName

			GameUtil.setUIImageSpriteIdx(self._rare, self._showSkinCfg.quality)
		end

		local bgName = LuckyDrawConfig.instance:getBgName(self._showSkinCfg.skinId)

		if not bgName then
			printError("没有配置背景")

			return
		end

		local path = GameUrl.getBigbgFolderUrl("bgskin", bgName)

		for i, v in ipairs(self._bgGos) do
			uGuiUtil.clearImage(v)
			uGuiUtil.setSpriteToImage(v, nil, path)
		end

		self._petscrollerList:refresh()
	end
end

function LuckydrawtimestatemultipleView:_setPets()
	if self._actCommonCfg.skinIds then
		self._petscrollerList:reloadData(self._actCommonCfg.skinIds)

		if self._showSkinCfg then
			self:_onClickSkin(self._showSkinCfg.skinId)
		else
			self:_onClickSkin(self._actCommonCfg.skinIds[1])
		end
	else
		self._petscrollerList:reloadData()
	end
end

function LuckydrawtimestatemultipleView:_onClickbtnSkipAni()
	self._skipAni = not self._skipAni

	local key = "LuckydrawtimestatemultipleView" .. self._actId

	GameUtil.saveUserData(key, self._skipAni)
	goutil.setActive(self._gouGo, self._skipAni)
end

function LuckydrawtimestatemultipleView:_setSkipState()
	local key = "LuckydrawtimestatemultipleView" .. self._actId

	self._skipAni = checkbool(GameUtil.getUserData(key))

	goutil.setActive(self._gouGo, self._skipAni)
end

function LuckydrawtimestatemultipleView:_onLuckyDrawDrawRes(prizeIds)
	if self._skipAni then
		self:_endDrawAni()
	else
		self:_startDrawAni(prizeIds)
	end
end

function LuckydrawtimestatemultipleView:_setProgressReward()
	local prizeList = LuckyDrawConfig.instance:getProgressRewardCfgs(self._actId)

	self._gainProgressPrizeId = LuckyDrawModel.instance:getGainProcessPrizeBit()
	self._lotteryCount = LuckyDrawModel.instance:getTotalDrawtimes()

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.needLotteryCount)

		local isCanGet = self._lotteryCount >= v.needLotteryCount
		local isGainPrize = table.indexof(self._gainProgressPrizeId, v.prizeId) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._lotteryCount, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = self._lotteryCount
end

function LuckydrawtimestatemultipleView:_updateRewardCell(view, cell, data, tag)
	local btnItem = goutil.findChild(cell, "item/btnItem")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	uGuiUtil.setSpriteToImage(btnItem, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.showIcon))
	GameUtil.addClickHandler(btnItem, function()
		self:_setItemTips(btnItem, data)
	end)

	txtScore.text = data.needLotteryCount

	local isCanGet = self._lotteryCount >= data.needLotteryCount
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function LuckydrawtimestatemultipleView:_onClickGetPrize(data)
	local isCanGet = self._lotteryCount >= data.needLotteryCount
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		LuckyDrawAgent.instance:sendPM_LuckyDrawGainProcessPirzeReq(self._actId, data.prizeId)
	end
end

function LuckydrawtimestatemultipleView:_clearRewardCell(cell)
	local btnItem = goutil.findChild(cell, "item/btnItem")
	local effect = goutil.findChild(cell, "effect")

	uGuiUtil.clearImage(btnItem)
	GameUtil.rmClickHandler(btnItem)
	self:_clearEffect(effect)
end

function LuckydrawtimestatemultipleView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function LuckydrawtimestatemultipleView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function LuckydrawtimestatemultipleView:_setItemTips(attachGo, data)
	goutil.setActive(self._itemtipsGo, true)

	local x, y, z = Framework.TransformUtil.GetPos(attachGo.transform, 0, 0, 0)

	x = x + 0.05555555555555555
	y = y + 0.2777777777777778

	Framework.TransformUtil.SetPos(self._itemtipsGo.transform, x, y, z)

	local datas = {}
	local data1 = {
		prize = data.bigPrize,
		rate = data.bigPrizeShowRate
	}
	local data2 = {
		prize = data.normalPrize,
		rate = data.normalPrizeShowRate
	}

	table.insert(datas, data1)
	table.insert(datas, data2)
	self._tipsscrollerList:reloadData(datas)
end

function LuckydrawtimestatemultipleView:_updateTipsCell(view, cell, data, tag)
	local goItem = goutil.findChild(cell, "item")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(data.prize, goItem)

	txtDesc.text = string.format("%s%%", data.rate)
end

function LuckydrawtimestatemultipleView:_clearTipsCell(cell)
	local goItem = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(goItem)
end

function LuckydrawtimestatemultipleView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._itemtipsGo, false)
	end
end

function LuckydrawtimestatemultipleView:_calGetBigPrizeCostDesc()
	self._txtTotalCostTip.text = self._actCommonCfg.drawDesc
end

function LuckydrawtimestatemultipleView:_calTimesDesc()
	local totalTimes = LuckyDrawModel.instance:getTotalDrawtimes() + 1
	local currGetPrizeNum = 0
	local nextGetStartTime = 0
	local nextGetPrizeNum = 0

	if self._drawTimesCfgs then
		for i = #self._drawTimesCfgs, 1, -1 do
			local cfg = self._drawTimesCfgs[i]

			if totalTimes >= cfg.startTimes then
				currGetPrizeNum = cfg.prizeNum

				local nextCfg = self._drawTimesCfgs[i + 1]

				if nextCfg then
					nextGetStartTime = nextCfg.startTimes
					nextGetPrizeNum = nextCfg.prizeNum
				end

				break
			end
		end

		if currGetPrizeNum == 0 and nextGetPrizeNum == 0 then
			local cfg = self._drawTimesCfgs[1]

			self._txtTimesTip.text = string.format("第<color=#68ffe6>%s</color>次抽奖可获得<color=#68ffe6>%s</color>个奖励", cfg.startTimes, cfg.prizeNum)
		else
			self._txtTimesTip.text = nextGetPrizeNum == 0 and string.format("本次抽奖可获得<color=#68ffe6>%s</color>个奖励", currGetPrizeNum) or string.format("本次抽奖可获得<color=#68ffe6>%s</color>个奖励\n第<color=#68ffe6>%s</color>次抽奖可获得<color=#68ffe6>%s</color>个奖励", currGetPrizeNum, nextGetStartTime, nextGetPrizeNum)
		end
	end
end

function LuckydrawtimestatemultipleView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.LuckydrawtimestaterankView, self._actId)
end

function LuckydrawtimestatemultipleView:_checkCanGainPrize()
	local prizeList = LuckyDrawConfig.instance:getProgressRewardCfgs(self._actId)
	local gainProgressPrizeId = LuckyDrawModel.instance:getGainProcessPrizeBit()
	local lotteryCount = LuckyDrawModel.instance:getTotalDrawtimes()
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.needLotteryCount)

		local isCanGet = lotteryCount >= v.needLotteryCount
		local isGainPrize = table.indexof(gainProgressPrizeId, v.prizeId) ~= false

		if isCanGet and not isGainPrize then
			return true
		end
	end
end

function LuckydrawtimestatemultipleView:_tickChangeSkin()
	if self._actCommonCfg.skinIds and #self._actCommonCfg.skinIds > 1 then
		if self._showSkinCfg then
			local index = 1

			for i, v in ipairs(self._actCommonCfg.skinIds) do
				if self._showSkinCfg.skinId == v then
					index = i

					break
				end
			end

			local nextIndex = index + 1

			if not self._actCommonCfg.skinIds[nextIndex] then
				nextIndex = 1
			end

			self:_onClickSkin(self._actCommonCfg.skinIds[nextIndex])
		else
			self:_onClickSkin(self._actCommonCfg.skinIds[1])
		end
	end
end

function LuckydrawtimestatemultipleView:_onLuckyDrawGainProcessPirzeRes()
	self:_setProgressInfo()
	self:_setProgressReward()
	self:_calTimesDesc()
end

function LuckydrawtimestatemultipleView:_onClickbtnJump()
	local value = LuckyDrawConfig.instance:getCommonValue("CustomJump" .. self._actId)
	local arr = string.split(value, ",")

	GotoMgr.gotoByString(arr[2])
end

function LuckydrawtimestatemultipleView:_updateBtnJumpState()
	local isShow = false
	local isExist = LuckyDrawConfig.instance:isExistCommonValue("CustomJump" .. self._actId)

	if isExist then
		local value = LuckyDrawConfig.instance:getCommonValue("CustomJump" .. self._actId)
		local arr = string.split(value, ",")

		isShow = #arr > 1
		self._txtBtnJump.text = arr[1]
	end

	goutil.setActive(self._btnJump.gameObject, isShow)
end

function LuckydrawtimestatemultipleView:_onClickJumpWandererPass()
	local activityId = WandererpassController.CURR_ACTIVITY_ID

	UIStateManager.instance:push(ViewName.WandererpassmainView, activityId, 2)
end

function LuckydrawtimestatemultipleView:_onClickQuanSelect()
	local boo = WandererpassController.instance:getCouponSelect(self._activityId)

	WandererpassController.instance:setCouponSelect(self._activityId, not boo)
	self:_updateCoupon(true)
end

return LuckydrawtimestatemultipleView
