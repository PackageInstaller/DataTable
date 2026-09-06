-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingMainView.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingMainView", package.seeall)

local WeakPathFindingMainView = class("WeakPathFindingMainView", ViewComponent)

function WeakPathFindingMainView:buildUI()
	WeakPathFindingMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnSearch = self:getGo("btnSearch")
	self._goPrize = self:getGo("prize")
	self._goCell = goutil.findChild(self._goPrize, "cell")
	self._goTableview = goutil.findChild(self._goPrize, "tableview")
	self._clipRect = goutil.findChild(self._goTableview, "ViewPort"):GetComponent(goutil.Type_RectTransform)
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtActTime = self:getTxt("actTime/txt")
	self._txtTimeToday = self:getTxt("timeToday/txt")
	self._txtTimeTotal = self:getTxt("timeTotal/txt")
	self._txtCurProgress = goutil.findChildTextComponent(self._goPrize, "txtCurProgress")
	self._txtSearch = goutil.findChildTextComponent(self._btnSearch, "txt")
	self._sldPrgress = self:getSlider("prize/tableview/ViewPort/Content/progressSlider")
end

function WeakPathFindingMainView:bindEvents()
	WeakPathFindingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickSearch, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function WeakPathFindingMainView:unbindEvents()
	WeakPathFindingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnTip)
end

function WeakPathFindingMainView:onEnter()
	WeakPathFindingMainView.super.onEnter(self)

	self._actTimeCfg = WeakPathFindingModel.instance:getCurActTimeCfg()

	if self._actTimeCfg then
		self:refreshViewByCfg()
		WeakPathFindingController.instance:getInfo()

		local userData = GameUtil.getUserData("weakpathfindingmainview" .. self._actId)

		if checkint(userData) <= 0 then
			GameUtil.saveUserData("weakpathfindingmainview" .. self._actId, 1)

			if self._actCfg.copyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._actCfg.copyId, StoryModel.StoryType.SCCopy)
			end
		end
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	GlobalDispatcher:addListener(GlobalNotify.WeakPathFindingUpdateInfo, self.refreshViewByInfo, self)
	self:_createEff("fx_scene_zhengjiuxuruojingling/fx_ui_xuruojingling.prefab", self.mainGO, "mainEff", true)
end

function WeakPathFindingMainView:onExit()
	WeakPathFindingMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WeakPathFindingUpdateInfo, self.refreshViewByInfo, self)
	self._tableview:dispose()
	self:_removeAllEffect()
end

function WeakPathFindingMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtNum.text = data.progress

	local proxy = MaterialMgr.setCellByCfg(data.prize, cell.item)

	if self._totalTimes then
		local isMatchProgress = self._totalTimes >= data.progress
		local isHasGain = WeakPathFindingModel.instance:getIsGainPrizeState(data.id)

		goutil.setActive(cell.mark, isHasGain)

		if isMatchProgress and not isHasGain then
			self.moveIdx = self.moveIdx or data.id - 1

			self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.item, cell.go, true, self._clipRect)
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				WeakPathFindingController.instance:gainPrize(data.id)

				self.moveIdx = nil
			end)
		end
	end
end

function WeakPathFindingMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item/itemcell")
	cell.mark = goutil.findChild(cell.go, "item/received")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")

	goutil.setActive(cell.mark, false)
	MaterialMgr.resetAll(cell.item)
	self:_removeEffect(cell.go)

	return cell
end

function WeakPathFindingMainView:refreshViewByCfg()
	self._actId = WeakPathFindingModel.instance:getCurActId()

	if self._actId ~= self._actTimeCfg.activityId then
		WeakPathFindingModel.instance:onReset()
		WeakPathFindingModel.instance:setCurActId(self._actTimeCfg.activityId)
	end

	self._actCfg = WeakPathFindingConfig.instance:getActCfgById(self._actId)
	self._prizeCfgs = WeakPathFindingConfig.instance:getPrizeCfgsByPlanId(self._actCfg.prizePlanId)

	self._tableview:reloadData(self._prizeCfgs)

	local startTime = GameUtil.string2time(self._actTimeCfg.startTime)
	local endTime = GameUtil.string2time(self._actTimeCfg.endTime)

	self._txtActTime.text = langPara("%s-%s", GameUtil.formatTimeStamp("%Y.%m.%d 5:00", startTime), GameUtil.formatTimeStamp("%Y.%m.%d 5:00", endTime))
end

function WeakPathFindingMainView:refreshViewByInfo()
	self._todayTimes = WeakPathFindingModel.instance:getCurTodayTimes()
	self._totalTimes = WeakPathFindingModel.instance:getCurTotalTimes()

	local showTimes = self._actCfg.dailyTimes - self._todayTimes

	if showTimes > self._actCfg.allTimes - self._totalTimes then
		showTimes = self._actCfg.allTimes - self._totalTimes
	end

	self._txtTimeToday.text = langPara("%s次", showTimes)
	self._txtTimeTotal.text = langPara("%s/%s", self._totalTimes, self._actCfg.allTimes)
	self._txtCurProgress.text = self._totalTimes
	self._curGameState = WeakPathFindingModel.instance:getCurState()
	self._txtSearch.text = self._curGameState == 0 and lang("立即搜索") or lang("继续搜索")

	self._tableview:reloadData(self._prizeCfgs)

	if self.moveIdx then
		self._tableview:MoveCellInView(self.moveIdx)
	end

	local sldValue = 0
	local stepNum = #self._prizeCfgs
	local stepValue = checknumber(1) / checknumber(stepNum)
	local addValue = 0

	if self._totalTimes >= self._prizeCfgs[1].progress then
		sldValue = sldValue + stepValue
	end

	for i = 1, stepNum - 1 do
		local cfg = self._prizeCfgs[i]
		local nextCfg = self._prizeCfgs[i + 1]

		if self._totalTimes >= nextCfg.progress then
			addValue = stepValue
			sldValue = sldValue + stepValue

			if self._totalTimes == nextCfg.progress then
				break
			end
		else
			sldValue = sldValue + checknumber(self._totalTimes - cfg.progress) / checknumber(nextCfg.progress - cfg.progress) * stepValue

			break
		end
	end

	self._sldPrgress:SetValue(sldValue)
end

function WeakPathFindingMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "weakpathfindingrule")
end

function WeakPathFindingMainView:_onClickSearch()
	if self._totalTimes >= self._actCfg.allTimes then
		FloatWordMgr.instance:show(lang("属于你的追踪任务已全部完成，去参与别的活动吧~"))

		return
	end

	if self._todayTimes >= self._actCfg.dailyTimes then
		FloatWordMgr.instance:show(lang("今日已无剩余次数，明天再来吧~"))

		return
	end

	self:close()
	UIStateManager.instance:clear()

	if self._curGameState == 0 then
		UIStateManager.instance:push(ViewName.WeakPathFindingSearchView)
	else
		WeakPathFindingController.instance:gotoFindNPC()
	end
end

function WeakPathFindingMainView:_createEff(effPath, effParent, effKey, isLoop, clipRect)
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

		if clipRect then
			eff:setClipping(clipRect)
		end
	end)
end

function WeakPathFindingMainView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function WeakPathFindingMainView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

return WeakPathFindingMainView
