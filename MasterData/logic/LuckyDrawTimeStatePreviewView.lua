-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawTimeStatePreviewView.lua

module("logic.extensions.luckydraw.view.LuckyDrawTimeStatePreviewView", package.seeall)

local LuckyDrawTimeStatePreviewView = class("LuckyDrawTimeStatePreviewView", ViewComponent)

function LuckyDrawTimeStatePreviewView:buildUI()
	LuckyDrawTimeStatePreviewView.super.buildUI(self)

	self._goCon = self:getGo("con")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._btnPreview = self:getBtn("btnPreview")
	self._tipCells = {}

	for i = 1, 5 do
		local tipCell = {}

		tipCell.go = self:getGo("progress/cell_" .. i)
		tipCell.txtWish = goutil.findChildTextComponent(tipCell.go, "txtWish")
		tipCell.txtAward = goutil.findChildTextComponent(tipCell.go, "txtAward")
		self._tipCells[i] = tipCell
	end

	self._sldPrgress = self:getSlider("progress/slider")
	self._txtTotalTime = self:getTxt("progress/total/txtNum")
	self._txtCost = self:getTxt("txtCost")
	self._txtDiscount = self:getTxt("txtCost/txtDiscount")
	self._goLine = self:getGo("txtCost/line")
	self._iconCost = self:getGo("txtCost/icon")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtInfo = self:getTxt("rank/txtInfo")
	self._tipEmpty = self:getGo("rank/tipEmpty")
	self._fadeOut = self._txtInfo.gameObject:GetComponent("UITweenFadeOut")
	self._txtTime = self:getTxt("time/txt")
	self._btnMask = self:getBtn("btnmask")
	self._goGoldBarCon = self:getGo("goldBarCon")
	self._goMarkGain = self:getGo("markGain")
	self._btnTipMin = self:getBtn("progress/btnTip")
	self._tagDiscount = self:getGo("btnStart/tag")
end

function LuckyDrawTimeStatePreviewView:bindEvents()
	LuckyDrawTimeStatePreviewView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnTipMin:AddClickListener(self._onClickTipMin, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnMask:AddClickListener(self._onClickMark, self)
	self._btnPreview:AddClickListener(self._onClickPreview, self)
end

function LuckyDrawTimeStatePreviewView:unbindEvents()
	LuckyDrawTimeStatePreviewView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._btnTipMin:RemoveClickListener()
	self._btnPreview:RemoveClickListener()
end

function LuckyDrawTimeStatePreviewView:onEnter()
	LuckyDrawTimeStatePreviewView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawGetInfo, self._updateViewByData, self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawDrawRes, self._startDrawAni, self)
	self:dealWithActIdAndRDId()

	self._actId = LuckyDrawModel.instance:getActId()

	if self._actId and ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LuckyDraw, self._actId) then
		self:_setViewByCfg()
		LuckyDrawController.instance:sendGetInfo()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	MainUIController.instance:showGlodBar(self._goGoldBarCon, self._viewPresentor, btnList)
end

function LuckyDrawTimeStatePreviewView:onExit()
	LuckyDrawTimeStatePreviewView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawGetInfo, self._updateViewByData, self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawDrawRes, self._startDrawAni, self)
	MaterialMgr.resetAll(self._iconCost)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	removetimer(self._timerCountDown, self)
	removetimer(self._showNewRank, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._baoxiangEff then
		UIEffectManager.instance:stopEffect(self._baoxiangEff)

		self._baoxiangEff = nil
	end

	removetimer(self._startDraw, self)
end

function LuckyDrawTimeStatePreviewView:dealWithActIdAndRDId()
	local curActId = checkint(self:getFirstParam())

	LuckyDrawController.instance:refreshActivtyId(curActId)
	LuckyDrawController.instance:resetLuckDrawTimeStateRedPoint()
	LuckyDrawController.instance:refreshActivtyId(curActId)
	LuckyDrawController.instance:resetLuckDrawTimeStateRedPoint()
end

function LuckyDrawTimeStatePreviewView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawtimestatepreviewrule")
end

function LuckyDrawTimeStatePreviewView:_onClickTipMin()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawtimestatepreviewminrule")
end

function LuckyDrawTimeStatePreviewView:_onClickStart()
	if self._goMarkGain.activeSelf then
		FloatWordMgr.instance:show(lang("您已获得本次活动的大奖，无法再进行许愿"))

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
				local content = langPara("确定花费%s%s购买%s%s，并进行1次许愿吗？", curCostNum, costName, extPrizeNum, extName)

				TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, curCostNum, content, function()
					LuckyDrawController.instance:sendDraw()
				end)
			end
		end
	end
end

function LuckyDrawTimeStatePreviewView:_onClickInfo()
	if self._showSkinCfg then
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self._showSkinCfg.skinId)
	end
end

function LuckyDrawTimeStatePreviewView:_onClickSkill()
	if self._showSkinCfg then
		PetbookController.instance:previewBattle(self._showSkinCfg.raceId, self._showSkinCfg.skinId)
	end
end

function LuckyDrawTimeStatePreviewView:_onClickMark()
	FloatWordMgr.instance:show("抽奖中，请稍等")
end

function LuckyDrawTimeStatePreviewView:_setViewByCfg()
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.LuckyDraw, self._actId)
	self._actCommonCfg = LuckyDrawConfig.instance:getActCfg(self._actId)
	self._prizeCfgs = LuckyDrawConfig.instance:getPrizeCfg(self._actId)
	self._drawTimesCfgs = LuckyDrawConfig.instance:getDrawTimesPlanCfg(self._actId)

	self:_setPrizeCellsByCfg()
	self:_setProgressTipsByCfg()
	self:_setCostMatByCfg()
	self:_setCountTimerByCfg()

	if self._actCommonCfg then
		if not self._actCommonCfg.mainEffPath then
			local mainEffPath = ""

			if not string.nilorempty(mainEffPath) then
				local effPath = string.format("%s.prefab", mainEffPath)

				if self._mainEff then
					UIEffectManager.instance:stopEffect(self._mainEff)

					self._mainEff = nil
				end

				self._mainEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, false, nil, function(target, eff)
					eff:setParent(self.mainGO.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1)

					eff.hideEffWhileNotOnTop = true
				end)
			end

			self._showSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._actCommonCfg.skinId)

			if self._showSkinCfg then
				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._showSkinCfg.skinId, self._goCon, 0.3)
			end
		end
	end
end

function LuckyDrawTimeStatePreviewView:_setPrizeCellsByCfg()
	self._curGaintPrizeId = 0

	if self._prizeCfgs then
		for i = 1, #self._prizeCfgs do
			local cfg = self._prizeCfgs[i]

			if cfg.prizeType ~= 1 then
				-- block empty
			else
				self._curGaintPrizeId = i
			end
		end
	end
end

function LuckyDrawTimeStatePreviewView:_setProgressTipsByCfg()
	if self._drawTimesCfgs then
		for i = 1, #self._tipCells do
			local cell = self._tipCells[i]

			if self._drawTimesCfgs[i] then
				cell.txtWish.text = self._drawTimesCfgs[i].startTimes
				cell.txtAward.text = self._drawTimesCfgs[i].prizeNum
			end
		end
	end
end

function LuckyDrawTimeStatePreviewView:_setCostMatByCfg()
	if self._actCommonCfg then
		local costItem = self._actCommonCfg.cost

		self._costMatType, self._costMatId, self._costMatNum = MaterialMgr.getMatParams(costItem)

		MaterialMgr.setIcon(self._iconCost, self._costMatType, self._costMatId)

		self._txtCost.text = self._costMatNum

		local costDiscount = self._actCommonCfg.discountCost

		self._costDiscountType, self._costDiscountId, self._costDiscountNum = MaterialMgr.getMatParams(costDiscount)
		self._txtDiscount.text = self._costDiscountNum
	end
end

function LuckyDrawTimeStatePreviewView:_setCountTimerByCfg()
	if self._actTimeCfg then
		removetimer(self._timerCountDown, self)

		self._curEndTime = GameUtil.string2time(self._actTimeCfg.endTime)

		self:_timerCountDown()
		settimer(1, self._timerCountDown, self)
	end
end

function LuckyDrawTimeStatePreviewView:_timerCountDown()
	local timeLeft = self._curEndTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

function LuckyDrawTimeStatePreviewView:_updateViewByData()
	if not self._actCommonCfg then
		return
	end

	self:_setProgressInfo()
	self:_setGaintPrizeState()
	self:_setRankInfo()
end

function LuckyDrawTimeStatePreviewView:_setProgressInfo()
	local totalTimes = LuckyDrawModel.instance:getTotalDrawtimes()

	if self._drawTimesCfgs and #self._drawTimesCfgs > 1 then
		local sldValue = 0
		local stepNum = #self._drawTimesCfgs
		local stepValue = checknumber(1) / checknumber(stepNum)
		local addValue = 0

		if totalTimes >= self._drawTimesCfgs[1].startTimes then
			sldValue = sldValue + stepValue
		end

		for i = 1, stepNum - 1 do
			local cfg = self._drawTimesCfgs[i]
			local nextCfg = self._drawTimesCfgs[i + 1]

			if totalTimes >= nextCfg.startTimes then
				addValue = stepValue
				sldValue = sldValue + stepValue

				if totalTimes == nextCfg.startTimes then
					break
				end
			else
				sldValue = sldValue + checknumber(totalTimes - cfg.startTimes) / checknumber(nextCfg.startTimes - cfg.startTimes) * stepValue

				break
			end
		end

		self._sldPrgress:SetValue(sldValue)
	end

	self._txtTotalTime.text = langPara("%s次", totalTimes)
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
	end
end

function LuckyDrawTimeStatePreviewView:_setGaintPrizeState()
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

function LuckyDrawTimeStatePreviewView:_setRankInfo()
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

function LuckyDrawTimeStatePreviewView:_showNewRank()
	self._curRankId = self._curRankId + 1

	if #self._rankList < self._curRankId then
		self._curRankId = 1
	end

	local data = self._rankList[self._curRankId]

	if self._prizeCfgs[data.prizeId] then
		local prizeMat = self._prizeCfgs[data.prizeId].prize

		if string.nilorempty(prizeMat) then
			removetimer(self._showNewRank, self)
			printError("奖品未定义")

			return
		end

		local prizeName = MaterialMgr.getMaterialsNameByCfg(prizeMat)

		self._txtInfo.text = langPara("%s服的%s花费%s%s获得%s", data.areaName, data.userName, self:getCurTotalCostNum(data.totalDrawTimes), MaterialMgr.getMaterialsName(self._costMatType, self._costMatId), prizeName)
		self._fadeOut.enabled = true
	end
end

function LuckyDrawTimeStatePreviewView:getCurTotalCostNum(time)
	local curTime = checkint(time)
	local curCostNum = 0

	if self._actCommonCfg then
		for i = 1, curTime do
			curCostNum = self._actCommonCfg and i >= self._actCommonCfg[1] and i <= self._actCommonCfg[2] and curCostNum + self._costDiscountNum or curCostNum + self._costMatNum
		end

		return curCostNum
	end
end

function LuckyDrawTimeStatePreviewView:_startDrawAni()
	goutil.setActive(self._btnMask.gameObject, true)
	settimer(0.2, self._startDraw, self, false)
end

function LuckyDrawTimeStatePreviewView:_startDraw()
	goutil.setActive(self._btnMask.gameObject, true)

	local animConfig = {
		animName = "fx_story_lihebaokai",
		passable = false,
		animFinishCallback = function()
			self:_endDrawAni()
		end,
		callbackTarget = self
	}

	ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
end

function LuckyDrawTimeStatePreviewView:_endDrawAni()
	goutil.setActive(self._btnMask.gameObject, false)
	LuckyDrawController.instance:showMonopolyCI()
	self:_updateViewByData()
end

function LuckyDrawTimeStatePreviewView:_onClickPreview()
	UIStateManager.instance:push(ViewName.LuckyDrawPreviewView)
end

return LuckyDrawTimeStatePreviewView
