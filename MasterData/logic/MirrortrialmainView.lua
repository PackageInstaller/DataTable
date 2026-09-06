-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialmainView.lua

module("logic.extensions.mirrortrial.view.MirrortrialmainView", package.seeall)

local MirrortrialmainView = class("MirrortrialmainView", ViewComponent)

function MirrortrialmainView:ctor()
	MirrortrialmainView.super.ctor(self)
end

function MirrortrialmainView:buildUI()
	MirrortrialmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._goBuyScore = self:getGo("btnBuyScore")
	self._btnBuyScore = GameUtil.asBtn(self._goBuyScore)
	self._btnBox = self:getBtn("box")
	self._changeBox = self:getGo("box"):GetComponent("UIImageSpriteChange")
	self._btnGetPrize = self:getBtn("btnGetPrize")
	self._sldProgress = self:getSlider("prizeTableView/Viewport/Content/sldProgress")
	self._txtProgress = self:getTxt("txtProgress")
	self._showInfo = self:getGo("showChapterInfo")
	self._buffIcon = goutil.findChild(self._showInfo, "icon")
	self._txtInfo = goutil.findChildTextComponent(self._showInfo, "txtInfo")
	self._btnEnterBattle = self:getBtn("showChapterInfo/btn")
	self._txtTimeTips = self:getTxt("timeTips")
	self._goPrizeCell = self:getGo("prizeTableCell")
	self._goPrizeTable = self:getGo("prizeTableView")
	self._tableviewPrize = ScrollerList.create(self._goPrizeTable, self._goPrizeCell, GameUtil.handler(self._updateCellPrize, self), GameUtil.handler(self._clearCellPrize, self))
	self._goChapterCell = self:getGo("chapterTableCell")
	self._goChapterTable = self:getGo("chapterTableView")
	self._tableviewChapter = ScrollerList.create(self._goChapterTable, self._goChapterCell, GameUtil.handler(self._updateCellChapter, self), GameUtil.handler(self._clearCellChapter, self))
	self._goldBar = self:getGo("goldBar")
	self._effClipMask = self:getGo("prizeTableView/Viewport")
	self._effectList = {}
end

function MirrortrialmainView:bindEvents()
	MirrortrialmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)
	self._btnBuyScore:AddClickListener(self._onClickBtnBuyScore, self)
	self._btnGetPrize:AddClickListener(self._onClickBtnGetPrize, self)
	self._btnEnterBattle:AddClickListener(self._onClickBtnEnterBattle, self)
	self._btnBox:AddClickListener(self._onClickBtnGetPrize, self)
end

function MirrortrialmainView:unbindEvents()
	MirrortrialmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnBuyScore:RemoveClickListener()
	self._btnGetPrize:RemoveClickListener()
	self._btnEnterBattle:RemoveClickListener()
	self._btnBox:RemoveClickListener()
end

function MirrortrialmainView:destroyUI()
	MirrortrialmainView.super.destroyUI(self)
end

function MirrortrialmainView:onEnter()
	MirrortrialmainView.super.onEnter(self)

	self._curSelectChapter = nil

	self:_updateCurCfg()

	if self._curActCfg then
		self:_updateUI()

		local mat = self._curActBaseCfg.showEnergy
		local list = {
			{
				showAdd = true,
				id = mat,
				showAddCallBack = function()
					EnergyController.instance:openBuyView(string.splitToNumber(mat, ":")[2])
				end
			},
			{
				showAdd = true,
				id = GameEnum.GoldType.Diamond
			}
		}

		MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, list)
		MirrorTrialAgent:sendPM_GetMirrorTrialInfoReq(self._curActId)
	else
		TipsFacade.instance:openCommonTips("活动未开启")
		self:close()
	end

	GlobalDispatcher:addListener(MirrorTrialController.HandleGetInfo, self._handleGetInfo, self)
	GlobalDispatcher:addListener(MirrorTrialController.HandleGainPrize, self._handleGetPrize, self)
	GlobalDispatcher:addListener(MirrorTrialController.HandleBuyScore, self._handleGetPrize, self)
	GlobalDispatcher:addListener(MirrorTrialController.NotifyFightResult, self._handleFinishFight, self)
	GlobalDispatcher:addListener(MirrorTrialController.NotifyPaySuc, self._handlePaySuc, self)
	GlobalDispatcher:addListener(MirrorTrialController.DailyReset, self._dailyReset, self)
end

function MirrortrialmainView:onEnterFinished()
	MirrortrialmainView.super.onEnterFinished(self)
end

function MirrortrialmainView:onExit()
	MirrortrialmainView.super.onExit(self)
	self._tableviewPrize:dispose()
	self._tableviewChapter:dispose()

	for k, v in pairs(self._effectList) do
		UIEffectManager.instance:stopEffect(v)

		v = nil
	end

	self._effectList = {}

	GlobalDispatcher:removeListener(MirrorTrialController.HandleGetInfo, self._handleGetInfo, self)
	GlobalDispatcher:removeListener(MirrorTrialController.HandleGainPrize, self._handleGetPrize, self)
	GlobalDispatcher:removeListener(MirrorTrialController.HandleBuyScore, self._handleGetPrize, self)
	GlobalDispatcher:removeListener(MirrorTrialController.NotifyFightResult, self._handleFinishFight, self)
	GlobalDispatcher:removeListener(MirrorTrialController.NotifyPaySuc, self._handlePaySuc, self)
	GlobalDispatcher:removeListener(MirrorTrialController.DailyReset, self._dailyReset, self)
	uGuiUtil.clearImage(self._buffIcon)
end

function MirrortrialmainView:onExitFinished()
	MirrortrialmainView.super.onExitFinished(self)
end

function MirrortrialmainView:_updateCurCfg()
	self._curActCfg = MirrorTrialModel.instance:getCurActCfg()

	if self._curActCfg then
		self._curActId = self._curActCfg.activityId
		self._curActBaseCfg = MirrorTrialConfig.instance:getActBaseCfgById(self._curActId)
		self._curChapterCfgs = MirrorTrialConfig.instance:getChapterCfgsById(self._curActId)
		self._curPrizePlanCfgs = MirrorTrialConfig.instance:getPrizePlanCfgsById(self._curActId)
		self._curMax = MirrorTrialModel.instance:getCurMaxScore()
	end
end

function MirrortrialmainView:_updateData()
	self._isPay = MirrorTrialModel.instance:getIsPay()
	self._freeProcess, self._payProcess = MirrorTrialModel.instance:getCurProcess()
	self._freeProcessScore = self._curPrizePlanCfgs[self._freeProcess] and self._curPrizePlanCfgs[self._freeProcess].score
	self._payProcessScore = self._curPrizePlanCfgs[self._payProcess] and self._curPrizePlanCfgs[self._payProcess].score
	self._totalScore = MirrorTrialModel.instance:getCurTotalScore()
	self._curStage = MirrorTrialModel.instance:getCurStage()
	self._isAbleToBuy, self._leftTimes, self._isTimeAble, self._isMax = MirrorTrialModel.instance:getIsAbleToBuyScoreParms()
	self._curStageCfg = MirrorTrialConfig.instance:getStageCfgsById(self._curActId, self._curStage + 1)
	self.isAllPass = checkint(self._curStage) > 0 and not self._curStageCfg

	if not self.isAllPass then
		self._curChapter = self._curStageCfg.chapterId
		self._curChapterStageCfg = MirrorTrialConfig.instance:getStageCfgsByChapterId(self._curActId, self._curChapter)

		local dataList = {}

		for k, v in pairs(self._curChapterStageCfg) do
			table.insert(dataList, v)
		end

		table.sort(dataList, function(a, b)
			return a.stageId < b.stageId
		end)

		self._curChapterTotalStage = table.nums(self._curChapterStageCfg)
		self._curChapterCurStage = 0

		for k, v in ipairs(dataList) do
			if v.stageId == self._curStage then
				self._curChapterCurStage = k
			end
		end
	else
		self._curChapter = #self._curChapterCfgs + 1
	end

	self._curSelectChapter = self._curChapter

	local freePrize = {}
	local payPrize = {}
	local totalPrize = {}

	self._moveIndex = nil

	for k, v in ipairs(self._curPrizePlanCfgs) do
		if self._freeProcessScore then
			local hasGainFree = self._freeProcessScore >= v.score

			if self._payProcessScore then
				local hasGainPay = self._payProcessScore >= v.score

				if v.score <= self._totalScore then
					if not hasGainFree then
						table.insert(freePrize, v.prize)
					end

					if not hasGainPay then
						table.insert(payPrize, v.rechargePrize)
					end
				else
					self._moveIndex = self._moveIndex or k - 1
				end

				table.insert(totalPrize, v.rechargePrize)
			end
		end
	end

	self._moveIndex = self._moveIndex or #self._curPrizePlanCfgs - 1

	if #freePrize > 0 or #payPrize > 0 then
		self._changeBox:SetState(1)
	else
		self._changeBox:SetState(0)
	end

	self._freePrize = MaterialMgr.changeItemStrArr(MaterialMgr.combineStrs(unpack(freePrize)))
	self._payPrize = MaterialMgr.changeItemStrArr(MaterialMgr.combineStrs(unpack(payPrize)))
	self._totalPrize = MaterialMgr.changeItemStrArr(MaterialMgr.combineStrs(unpack(totalPrize)))
end

function MirrortrialmainView:_updateUI()
	self:_updateData()

	self._txtTimeTips.text = langPara("活动时间：%s-%s", GameUtil.formatTimeStamp("%Y/%m/%d", GameUtil.string2time(self._curActCfg.startTime)), GameUtil.formatTimeStamp("%Y/%m/%d", GameUtil.string2time(self._curActCfg.endTime)))

	self._sldProgress:SetValue(0)

	self._txtProgress.text = 0

	self:_updatePrizeView()
	self:_updateStageView()
	self:_dailyReset()
end

function MirrortrialmainView:_dailyReset()
	self._curActCfg = MirrorTrialModel.instance:getCurActCfg()

	if self._curActCfg then
		self:_updateData()
		goutil.setActive(self._goBuyScore, self._isTimeAble)
	else
		TipsFacade.instance:openCommonTips("活动已结束")
		self:close()
	end
end

function MirrortrialmainView:_handleGetInfo()
	self:_updateData()
	self:_updatePrizeView()
	self:_updateStageView()
end

function MirrortrialmainView:_handleGetPrize()
	self:_updateData()
	self:_updatePrizeView()
end

function MirrortrialmainView:_handleFinishFight()
	self:_updateData()
	self:_updateStageView()
end

function MirrortrialmainView:_handlePaySuc()
	MirrorTrialAgent.instance:sendPM_MirrorTrialGainPrizeReq(self._curActId)
end

function MirrortrialmainView:_updateStageView()
	local dataList = {}

	for k, v in ipairs(self._curChapterCfgs) do
		table.insert(dataList, v)

		if v.chapterId == self._curSelectChapter then
			table.insert(dataList, {})
			table.insert(dataList, {})
		end
	end

	self._tableviewChapter:reloadData(dataList)

	if self._curSelectChapter > #self._curChapterCfgs then
		self._tableviewChapter:MoveCellToCenter(#self._curChapterCfgs)
	else
		self._tableviewChapter:MoveCellToCenter(self._curSelectChapter)
	end
end

function MirrortrialmainView:_updatePrizeView()
	self._tableviewPrize:reloadData(self._curPrizePlanCfgs)
	self._sldProgress:SetValue(self._totalScore / self._curMax)

	self._txtProgress.text = self._totalScore

	self._tableviewPrize:MoveCellToCenter(self._moveIndex)
end

function MirrortrialmainView:_clearCellPrize(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtScore = goutil.findChildTextComponent(goCell, "txtScore")
	cell.freePrize = self:initPrizeCell(cell.go, "freePrize")
	cell.payPrize = self:initPrizeCell(cell.go, "payPrize")

	MaterialMgr.resetAll(cell.freePrize.go)
	MaterialMgr.resetAll(cell.payPrize.go)

	return cell
end

function MirrortrialmainView:initPrizeCell(go, path)
	local cell = {}

	cell.go = goutil.findChild(go, path)
	cell.item = goutil.findChild(cell.go, "item")
	cell.eff = goutil.findChild(cell.go, "eff")
	cell.mark = goutil.findChild(cell.go, "mark")

	if self._effectList[cell.eff] then
		UIEffectManager.instance:stopEffect(self._effectList[cell.eff])

		self._effectList[cell.eff] = nil
	end

	return cell
end

function MirrortrialmainView:_updateCellPrize(view, goCell, data)
	local cell = self:_clearCellPrize(goCell)

	cell.txtScore.text = data.score

	local showPrizes = MaterialMgr.changeItemStrArr(data.prize)

	MaterialMgr.setCellByCfg(showPrizes[1], cell.freePrize.item)

	showPrizes = MaterialMgr.changeItemStrArr(data.rechargePrize)

	MaterialMgr.setCellByCfg(showPrizes[1], cell.payPrize.item)

	if self._freeProcessScore then
		local hasGainFree = self._freeProcessScore >= data.score

		if self._payProcessScore then
			local hasGainPay = self._payProcessScore >= data.score

			goutil.setActive(cell.freePrize.mark, hasGainFree)
			goutil.setActive(cell.payPrize.mark, hasGainPay)

			if data.score <= self._totalScore then
				if not hasGainFree then
					self:_createEff(cell.freePrize.eff)
				end

				if not hasGainPay then
					self:_createEff(cell.payPrize.eff)
				end
			end
		end
	end
end

function MirrortrialmainView:_createEff(go)
	if not go then
		return
	end

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	self._effectList[go] = UIEffectManager.instance:playEffect(self, effPath, go, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(go.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(self._effClipMask:GetComponent(goutil.Type_RectTransform))
	end)
end

function MirrortrialmainView:_clearCellChapter(goCell)
	local cell = {}

	cell.go = goCell
	cell.con = goutil.findChild(cell.go, "con")
	cell.container = goutil.findChild(cell.go, "container")
	cell.btn = goutil.findChild(cell.container, "btn")

	GameUtil.rmClickHandler(cell.btn)

	cell.txtChapter = goutil.findChildTextComponent(cell.container, "txtChapter")
	cell.txtName = goutil.findChildTextComponent(cell.container, "txtName")
	cell.txtProgress = goutil.findChildTextComponent(cell.container, "txtProgress")
	cell.markNew = goutil.findChild(cell.container, "markNew")
	cell.markHasPass = goutil.findChild(cell.container, "markHasPass")
	cell.markNoPass = goutil.findChild(cell.container, "markNoPass")

	return cell
end

function MirrortrialmainView:_updateCellChapter(view, goCell, data)
	local cell = self:_clearCellChapter(goCell)

	if data.chapterId then
		goutil.setActive(cell.container, true)

		cell.txtName.text = data.stageName
		cell.txtChapter.text = data.chapterId

		goutil.setActive(cell.markNew, data.chapterId == self._curChapter)
		goutil.setActive(cell.markHasPass, data.chapterId < self._curChapter)
		goutil.setActive(cell.markNoPass, data.chapterId > self._curChapter)
		goutil.setActive(cell.txtProgress.gameObject, data.chapterId == self._curChapter)
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickChapterCell, self, data))
		goutil.setActive(cell.con, data.chapterId == self._curChapter)

		if data.chapterId == self._curChapter then
			cell.txtProgress.text = langPara("%s/%s", self._curChapterCurStage, self._curChapterTotalStage)

			self._showInfo.transform:SetParent(cell.con.transform)
			Framework.TransformUtil.SetLocalPos(self._showInfo.transform, 0, 0, 0)
			self:_setCurChaperData(data)
		end
	else
		goutil.setActive(cell.container, false)
	end
end

function MirrortrialmainView:_onClickChapterCell(data)
	if self._curChapter > data.chapterId then
		TipsFacade.instance:openCommonTips("已通关")
	end

	if self._curChapter < data.chapterId then
		TipsFacade.instance:openCommonTips("需要完成上一章节开启")
	end
end

function MirrortrialmainView:_setCurChaperData(data)
	self._txtInfo.text = data.description

	uGuiUtil.clearImage(self._buffIcon)

	local icon = MirrorTrialConfig.instance:getPropertyIcon(data.propertyPlanId)

	uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceBuffIconUrl(icon))
end

function MirrortrialmainView:_onClickBtnRule()
	ViewMgr.instance:open(ViewName.RulesView, "mirrortrial")
end

function MirrortrialmainView:_onClickBtnBuyScore()
	if self._isTimeAble then
		if self._isMax then
			TipsFacade.instance:openCommonTips("当前活动积分已达到最高值")
		elseif self._leftTimes > 0 then
			UIStateManager.instance:push(ViewName.MirrortrialbuyscoreView, self._curActBaseCfg, self._totalScore)
		else
			TipsFacade.instance:openCommonTips("今日购买次数已耗尽")
		end
	else
		goutil.setActive(self._goBuyScore, false)
	end
end

function MirrortrialmainView:_onClickBtnGetPrize()
	if self._isPay then
		if not self._payPrize or #self._payPrize == 0 then
			return TipsFacade.instance:openCommonTips("当前无奖励可领取")
		end

		MirrorTrialAgent.instance:sendPM_MirrorTrialGainPrizeReq(self._curActId)
	else
		UIStateManager.instance:push(ViewName.MirrortrialbuyView, self._curActBaseCfg, self._freePrize, self._payPrize, self._totalPrize)
	end
end

function MirrortrialmainView:_onClickBtnEnterBattle()
	UIStateManager.instance:push(ViewName.MirrortrialchapterView)
end

return MirrortrialmainView
