-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawScoreStateView.lua

module("logic.extensions.luckydraw.view.LuckyDrawScoreStateView", package.seeall)

local LuckyDrawScoreStateView = class("LuckyDrawScoreStateView", ViewComponent)

function LuckyDrawScoreStateView:buildUI()
	LuckyDrawScoreStateView.super.buildUI(self)

	self._goCon = self:getGo("con")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._prizeCells = {}

	for i = 1, 13 do
		local cell = {}

		cell.go = self:getGo("cells/cell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.effGain = goutil.findChild(cell.go, "effGain")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		cell.matStr = nil
		self._prizeCells[i] = cell
	end

	self._sldPrgress = self:getSlider("progress/slider")
	self._txtTips = {}

	for i = 1, 5 do
		self._txtTips[i] = goutil.findChildTextComponent(self._sldPrgress.gameObject, "txt" .. i)
	end

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
	self._btnMask = self:getBtn("mask")
	self._goGoldBarCon = self:getGo("goldBarCon")
	self._goMarkGain = self:getGo("markGain")
	self._btnTipMin = self:getBtn("progress/total/btnTip")
	self._tagDiscount = self:getGo("btnStart/tag")
end

function LuckyDrawScoreStateView:bindEvents()
	LuckyDrawScoreStateView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnTipMin:AddClickListener(self._onClickTipMin, self)
	self._btnStart:AddClickListener(self._onClickStart, self)

	for k, v in pairs(self._prizeCells) do
		GameUtil.addClickHandler(v.icon, GameUtil.handler(self._onClickPrizeCell, self, k))
	end

	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnMask:AddClickListener(self._onClickMark, self)
end

function LuckyDrawScoreStateView:unbindEvents()
	LuckyDrawScoreStateView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnStart:RemoveClickListener()

	for k, v in pairs(self._prizeCells) do
		GameUtil.rmClickHandler(v.icon)
	end

	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._btnTipMin:RemoveClickListener()
end

function LuckyDrawScoreStateView:onEnter()
	LuckyDrawScoreStateView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawGetInfo, self._updateViewByData, self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawDrawRes, self._startDrawAni, self)

	local curActId = LuckyDrawConfig.instance:getLuckDrawPointActId()

	LuckyDrawController.instance:refreshActivtyId(curActId)
	LuckyDrawController.instance:resetLuckDrawPointStateRedPoint()

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

function LuckyDrawScoreStateView:onExit()
	LuckyDrawScoreStateView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawGetInfo, self._updateViewByData, self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawDrawRes, self._startDrawAni, self)

	for i = 1, #self._prizeCells do
		MaterialMgr.resetAll(self._prizeCells[i].icon)
	end

	MaterialMgr.resetAll(self._iconCost)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	self:_endDrawAni()
	removetimer(self._timerCountDown, self)
	removetimer(self._showNewRank, self)
	self:_removeAllEffect()
end

function LuckyDrawScoreStateView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawscorestaterule")
end

function LuckyDrawScoreStateView:_onClickTipMin()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawscorestateminrule")
end

function LuckyDrawScoreStateView:_onClickStart()
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

function LuckyDrawScoreStateView:_onClickPrizeCell(id)
	local matStr = self._prizeCells[id].matStr

	if not string.nilorempty(matStr) then
		CommonTipsMgr.instance:openTipsByConfStr(self._prizeCells[id].icon, matStr)
	end
end

function LuckyDrawScoreStateView:_onClickInfo()
	if self._showSkinCfg then
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self._showSkinCfg.skinId)
	end
end

function LuckyDrawScoreStateView:_onClickSkill()
	if self._showSkinCfg then
		PetbookController.instance:previewBattle(self._showSkinCfg.raceId, self._showSkinCfg.skinId)
	end
end

function LuckyDrawScoreStateView:_onClickMark()
	FloatWordMgr.instance:show("抽奖中，请稍等")
end

function LuckyDrawScoreStateView:_setViewByCfg()
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.LuckyDraw, self._actId)
	self._actCommonCfg = LuckyDrawConfig.instance:getActCfg(self._actId)
	self._prizeCfgs = LuckyDrawConfig.instance:getPrizeCfg(self._actId)
	self._drawTimesCfgs = LuckyDrawConfig.instance:getLuckyDrawPointPlanCfg(self._actId)

	self:_setPrizeCellsByCfg()
	self:_setProgressTipsByCfg()
	self:_setCostMatByCfg()
	self:_setCountTimerByCfg()

	if self._actCommonCfg then
		if not self._actCommonCfg.mainEffPath then
			local mainEffPath = ""

			if not string.nilorempty(mainEffPath) then
				self:_createEff(string.format("%s.prefab", mainEffPath), self.mainGO, "mainEff", true)
			end

			self._showSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._actCommonCfg.skinId)

			if self._showSkinCfg then
				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._showSkinCfg.skinId, self._goCon, 0.3)
			end
		end
	end
end

function LuckyDrawScoreStateView:_setPrizeCellsByCfg()
	self._curGaintPrizeId = 0

	if self._prizeCfgs then
		for i = 1, #self._prizeCells do
			local cell = self._prizeCells[i]

			cell.cfg = self._prizeCfgs[i]
			cell.matStr = cell.cfg.prize

			local effPath = "20220128/choujiang/fx_ui_choupifu_small.prefab"
			local effGainPath = "20220128/choujiang/fx_ui_choupifu_chouzhong_small.prefab"

			if cell.cfg then
				if cell.cfg.prizeType ~= 1 then
					local matType, matId, matNum = MaterialMgr.getMatParams(cell.matStr)

					MaterialMgr.setIcon(cell.icon, matType, matId)

					cell.txtNum.text = matNum
				else
					self._curGaintPrizeId = i
					effPath = "20220128/choujiang/fx_ui_choupifu_big.prefab"
					effGainPath = "20220128/choujiang/fx_ui_choupifu_chouzhong_big.prefab"
				end
			end

			goutil.setActive(cell.select, false)
			goutil.setActive(cell.effGain, false)
			self:_createEff(effPath, cell.select, "select_" .. i, true)
			self:_createEff(effGainPath, cell.effGain, "select_gain_" .. i, true)
		end
	end
end

function LuckyDrawScoreStateView:_setProgressTipsByCfg()
	if self._drawTimesCfgs then
		for i = 1, #self._txtTips do
			local cell = self._txtTips[i]

			if self._drawTimesCfgs[i] then
				cell.text = self._drawTimesCfgs[i + 1].beginScore
			end
		end
	end
end

function LuckyDrawScoreStateView:_setCostMatByCfg()
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

function LuckyDrawScoreStateView:_setCountTimerByCfg()
	if self._actTimeCfg then
		removetimer(self._timerCountDown, self)

		self._curEndTime = GameUtil.string2time(self._actTimeCfg.endTime)

		self:_timerCountDown()
		settimer(1, self._timerCountDown, self)
	end
end

function LuckyDrawScoreStateView:_timerCountDown()
	local timeLeft = self._curEndTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

function LuckyDrawScoreStateView:_updateViewByData()
	if not self._actCommonCfg then
		return
	end

	if self._actId then
		self:_setProgressInfo()
		self:_setGaintPrizeState()
		self:_setRankInfo()
	end
end

function LuckyDrawScoreStateView:_setProgressInfo()
	local totalTimes = LuckyDrawModel.instance:getTotalDrawtimes()
	local totalScore = LuckyDrawModel.instance:getCurLuckyScore()

	if self._drawTimesCfgs and #self._drawTimesCfgs > 1 then
		local sldValue = 0
		local stepNum = #self._drawTimesCfgs - 1
		local stepValue = checknumber(1) / checknumber(stepNum)
		local addValue = 0

		for i = 1, stepNum do
			local cfg = self._drawTimesCfgs[i]
			local nextCfg = self._drawTimesCfgs[i + 1]

			if totalScore >= nextCfg.beginScore then
				addValue = stepValue
				sldValue = sldValue + stepValue

				if totalScore == nextCfg.beginScore then
					break
				end
			else
				sldValue = sldValue + checknumber(totalScore - cfg.beginScore) / checknumber(nextCfg.beginScore - cfg.beginScore) * stepValue

				break
			end
		end

		self._sldPrgress:SetValue(sldValue)
	end

	self._txtTotalTime.text = langPara("%s分", totalScore)
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

function LuckyDrawScoreStateView:_setGaintPrizeState()
	goutil.setActive(self._goMarkGain, false)

	if self._curGaintPrizeId ~= 0 then
		local curGianNum = LuckyDrawModel.instance:getPrizeDrawNum(self._curGaintPrizeId)

		if curGianNum >= self._prizeCfgs[self._curGaintPrizeId].limit then
			if self._actCommonCfg.isResetPrize then
				LuckyDrawController.instance:refreshActivtyId(self._actId)
				LuckyDrawController.instance:sendGetInfo()
			else
				goutil.setActive(self._goMarkGain, true)
			end
		end
	end

	local aniPath = self._actCommonCfg.aniPath

	if not string.nilorempty(aniPath) then
		local playerDataKey = "lucky_draw_score_state_animation" .. self._actId

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

function LuckyDrawScoreStateView:_setRankInfo()
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

function LuckyDrawScoreStateView:_showNewRank()
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

function LuckyDrawScoreStateView:getCurTotalCostNum(time)
	local curTime = checkint(time)
	local curCostNum = 0

	if self._actCommonCfg then
		for i = 1, curTime do
			curCostNum = self._actCommonCfg and i >= self._actCommonCfg[1] and i <= self._actCommonCfg[2] and curCostNum + self._costDiscountNum or curCostNum + self._costMatNum
		end

		return curCostNum
	end
end

function LuckyDrawScoreStateView:_startDrawAni(prizeIds)
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

function LuckyDrawScoreStateView:_endDrawAni()
	goutil.setActive(self._btnMask.gameObject, false)

	self._selectIds = nil

	for k, v in pairs(self._prizeCells) do
		goutil.setActive(v.select, false)
		goutil.setActive(v.effGain, false)
	end

	removetimer(self._rorateEff, self)
	removetimer(self._rorateEffNext, self)
	removetimer(self._endDrawAni, self)
	LuckyDrawController.instance:showMonopolyCI()
	self:_setProgressInfo()
	self:_setGaintPrizeState()
end

function LuckyDrawScoreStateView:_rorateEff()
	if self._rorateStepNums <= 0 then
		removetimer(self._rorateEff, self)

		for k, v in pairs(self._prizeCells) do
			goutil.setActive(v.select, false)
		end

		for k, v in ipairs(self._selectIds) do
			goutil.setActive(self._prizeCells[v].effGain, true)
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

function LuckyDrawScoreStateView:_rorateEffNext()
	local lastSelectId = self._curSelectId

	if self._prizeCells[lastSelectId] and not table.keyof(self._selectIds, lastSelectId) then
		goutil.setActive(self._prizeCells[lastSelectId].select, false)
	end

	if self._rorateStepNums >= self._lastSelectId then
		self:_endDrawAni()

		return
	end

	self._rorateStepNums = self._rorateStepNums + 1
	self._curSelectId = self._curSelectId + 1

	if self._curSelectId > #self._prizeCells then
		self._curSelectId = 1
	end

	goutil.setActive(self._prizeCells[self._curSelectId].select, true)
end

function LuckyDrawScoreStateView:_createEff(effPath, effParent, effKey, isLoop)
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

function LuckyDrawScoreStateView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function LuckyDrawScoreStateView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

return LuckyDrawScoreStateView
