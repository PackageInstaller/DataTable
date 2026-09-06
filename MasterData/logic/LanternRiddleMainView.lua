-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/view/LanternRiddleMainView.lua

module("logic.extensions.lanternriddle.view.LanternRiddleMainView", package.seeall)

local LanternRiddleMainView = class("LanternRiddleMainView", ViewComponent)

function LanternRiddleMainView:ctor()
	LanternRiddleMainView.super.ctor(self)
end

function LanternRiddleMainView:buildUI()
	LanternRiddleMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("leftTop/time/txt")

	local stagecell1 = self:getGo("scorollStage/stagecell1")
	local stagecell2 = self:getGo("scorollStage/stagecell2")
	local tableviewGo = self:getGo("scorollStage/tableview")
	local tagGoList = {
		stagecell1,
		stagecell2
	}

	self._scrollerList = ScrollerList.create(tableviewGo, tagGoList, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regGetTagByIdx(function(data, idx)
		return data.stageId % 2 == 0 and 2 or 1
	end)

	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollRewardList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
end

function LanternRiddleMainView:bindEvents()
	LanternRiddleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function LanternRiddleMainView:unbindEvents()
	LanternRiddleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function LanternRiddleMainView:onEnter()
	LanternRiddleMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LanternRiddleGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_LanternRiddleStartGameRes, self._onStartGameRes, self)
	self.addGEvent(self, GlobalNotify.PM_LanternRiddleEndGameRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_LanternRiddleGainPrizeRes, self._onUpdate, self)

	self._activityType = LanternRiddleController.instance:getActivityType()

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = LanternRiddleController.instance:getActivityId()
	end

	self._actCfg = LanternRiddleConfig.instance:getLanternRiddleActCfg(self._activityId)
	self._stageCfg = LanternRiddleConfig.instance:getLanternRiddleStageCfg(self._activityId)
	self._progressCfg = LanternRiddleConfig.instance:getLanternRiddleProgressPrizeCfg(self._activityId)
	self._info = LanternRiddleModel.instance:getInfo(self._activityId)

	self:_onSetUI()
	LanternRiddleController.instance:sendPM_LanternRiddleGetInfoReq(self._activityId)
end

function LanternRiddleMainView:onExit()
	LanternRiddleMainView.super.onExit(self)
	self._scrollerList:dispose()
	self._scrollRewardList:dispose()
end

function LanternRiddleMainView:_onSetUI()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function LanternRiddleMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function LanternRiddleMainView:_updateData()
	self._info = LanternRiddleModel.instance:getInfo(self._activityId)
end

function LanternRiddleMainView:_updateUI()
	self._scrollerList:reloadData(self._stageCfg)
	self._scrollRewardList:reloadData(self._progressCfg)

	self._txtProgress.text = self._info.passedStageId or 0

	local scoreList = {}

	for i, v in ipairs(self._progressCfg) do
		table.insert(scoreList, v.progress)
	end

	self._scrollRewardList:updateUnderSlider(self._progressSlider, self._info.passedStageId, scoreList)
	self._scrollerList:MoveCellToCenter(self._info.passedStageId, false)
end

function LanternRiddleMainView:_updateCell(view, cell, data, tag)
	if data.gameType == 1 then
		self:_updateCellTypeOne(cell, data)
	else
		self:_updateCellTypeTwo(cell, data)
	end
end

function LanternRiddleMainView:_updateCellTypeOne(cell, data)
	local btnPlay = goutil.findChild(cell, "btnPlay")
	local hasPassGo = goutil.findChild(cell, "hasPass")
	local hasLock = goutil.findChild(cell, "hasLock")
	local descTimeGo = goutil.findChild(cell, "descTime")
	local descTxt = goutil.findChildTextComponent(cell, "descTime/txt")
	local startTimeStamp = GameUtil.string2time(data.startTime)
	local curTimeStamp = ServerTime.now()
	local onOpenTime = startTimeStamp <= curTimeStamp

	if not self._info.passedStageId then
		local passedStageId = 0
		local hasPassed = passedStageId >= data.stageId

		if hasPassed then
			GameUtil.SetActive(hasLock, false)
			GameUtil.SetActive(hasPassGo, true)
			GameUtil.SetActive(descTimeGo, false)
		elseif onOpenTime then
			GameUtil.SetActive(hasLock, false)
			GameUtil.SetActive(hasPassGo, false)
			GameUtil.SetActive(descTimeGo, false)
		else
			local startTimeStr = self._stageCfg[data.stageId].startTime
			local startDateStamp = GameUtil.string2time(startTimeStr)
			local startDate = GameUtil.time2date(startDateStamp)

			descTxt.text = string.format("%02d-%02d %02d:%02d解锁", startDate.month, startDate.day, startDate.hour, startDate.min)

			GameUtil.SetActive(hasLock, true)
			GameUtil.SetActive(descTimeGo, true)
			GameUtil.SetActive(hasPassGo, false)
		end

		GameUtil.rmClickHandler(btnPlay)
		GameUtil.addClickHandler(btnPlay, GameUtil.handler(self._onClickBtnPlay, self, data, LanternRiddleModel.PICK_DIFFERENCE))
	end
end

function LanternRiddleMainView:_updateCellTypeTwo(cell, data)
	local btnPlay = goutil.findChild(cell, "btnPlay")
	local hasPassGo = goutil.findChild(cell, "hasPass")
	local hasLock = goutil.findChild(cell, "hasLock")
	local descTimeGo = goutil.findChild(cell, "descTime")
	local descTxt = goutil.findChildTextComponent(cell, "descTime/txt")
	local startTimeStamp = GameUtil.string2time(data.startTime)
	local curTimeStamp = ServerTime.now()
	local onOpenTime = startTimeStamp <= curTimeStamp

	if not self._info.passedStageId then
		local passedStageId = 0
		local hasPassed = passedStageId >= data.stageId

		if hasPassed then
			GameUtil.SetActive(hasLock, false)
			GameUtil.SetActive(hasPassGo, true)
			GameUtil.SetActive(descTimeGo, false)
		elseif onOpenTime then
			GameUtil.SetActive(hasLock, false)
			GameUtil.SetActive(hasPassGo, false)
			GameUtil.SetActive(descTimeGo, false)
		else
			local startTimeStr = self._stageCfg[data.stageId].startTime
			local startDateStamp = GameUtil.string2time(startTimeStr)
			local startDate = GameUtil.time2date(startDateStamp)

			descTxt.text = string.format("%02d-%02d %02d:%02d解锁", startDate.month, startDate.day, startDate.hour, startDate.min)

			GameUtil.SetActive(hasLock, true)
			GameUtil.SetActive(descTimeGo, true)
			GameUtil.SetActive(hasPassGo, false)
		end

		GameUtil.rmClickHandler(btnPlay)
		GameUtil.addClickHandler(btnPlay, GameUtil.handler(self._onClickBtnPlay, self, data, LanternRiddleModel.LANTERN_RIDDLE))
	end
end

function LanternRiddleMainView:_clearCell(cell)
	return
end

function LanternRiddleMainView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._info.passedStageId then
		local finishIds = {}
		local isCanGet = finishIds >= data.progress

		if not self._info.gainPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false
			txtScore.text = data.progress

			MaterialMgr.setCellByCfg(data.prize, item)
			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

function LanternRiddleMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function LanternRiddleMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function LanternRiddleMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function LanternRiddleMainView:_onClickGetPrize(data)
	if not self._info.gainPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			if not self._info.passedStageId then
				local finishIds = {}
				local isCanGet = finishIds >= data.progress

				if isCanGet then
					LanternRiddleController.instance:sendPM_LanternRiddleGainPrizeReq(self._activityId, data.prizeId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

function LanternRiddleMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function LanternRiddleMainView:_onClickBtnPlay(data, gameType)
	local passedStageId = self._info.passedStageId
	local hasPassed = passedStageId >= data.stageId
	local startTimeStamp = GameUtil.string2time(data.startTime)
	local curTimeStamp = ServerTime.now()
	local onOpenTime = startTimeStamp <= curTimeStamp
	local isCurStage = self._info.passedStageId == data.stageId - 1

	if not onOpenTime then
		FloatWordMgr.instance:show("未到关卡开放时间")

		return
	end

	if hasPassed then
		FloatWordMgr.instance:show("已经通关,无需再次挑战")

		return
	end

	if not isCurStage then
		FloatWordMgr.instance:show("未通关完成之前关卡，请先完成")

		return
	end

	self._curPickData = data
	self._curPickGameType = gameType

	LanternRiddleController.instance:sendPM_LanternRiddleStartGameReq(self._activityId, data.stageId)
end

function LanternRiddleMainView:_onStartGameRes()
	if self._curPickGameType == LanternRiddleModel.PICK_DIFFERENCE then
		UIStateManager.instance:push(ViewName.FindDifferenceGameView, self._activityId, self._curPickData.stageId)
	else
		local problemId = self._info.problemId

		UIStateManager.instance:push(ViewName.LanternGuessGameView, self._activityId, self._curPickData.stageId, problemId, self._actCfg.problemPlanId)
	end
end

return LanternRiddleMainView
