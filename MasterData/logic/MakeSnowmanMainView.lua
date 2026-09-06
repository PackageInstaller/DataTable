-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/view/MakeSnowmanMainView.lua

module("logic.extensions.makesnowman.view.MakeSnowmanMainView", package.seeall)

local MakeSnowmanMainView = class("MakeSnowmanMainView", ViewComponent)

function MakeSnowmanMainView:ctor()
	MakeSnowmanMainView.super.ctor(self)
end

function MakeSnowmanMainView:buildUI()
	MakeSnowmanMainView.super.buildUI(self)

	self._posRoot = self:getGo("unitView")
	self._viewRoot = self:getGo("unitView/viewRoot")
	self._tableview = self:getGo("unitView/viewRoot/tableview")
	self._tablecell = self:getGo("unitView/viewRoot/stageCell")
	self._btnRule = self:getBtn("btnRule")
	self._btnClose = self:getBtn("btnClose")

	local playerRoot = self:getGo("playerRoot")

	self._rewardSliderMo = PlayerSliderMo.New(playerRoot)
	self._btnTask = self:getBtn("btnTask")
	self._txtGetNum = self:getTxt("tipGet/txtNum")
	self._conProgress = self:getGo("tipGet/txtDesc/con")
	self._txtTime = self:getTxt("time/txt")
	self._redPointTask = self:getGo("btnTask/redpoint")
	self._guideFinger = self:getGo("guideFinger")
	self._guideFingerScaleTween = goutil.findChildComponent(self._guideFinger, "img", "TweenScale")
	self._bgEffectCon = self:getGo("bgEffect")
	self._scrollrect = goutil.findChildComponent(self.mainGO, "playerRoot/tableview", "ScrollRect")
end

function MakeSnowmanMainView:bindEvents()
	MakeSnowmanMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MakeSnowmanMainView:unbindEvents()
	MakeSnowmanMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnClose)
end

function MakeSnowmanMainView:destroyUI()
	MakeSnowmanMainView.super.destroyUI(self)
end

function MakeSnowmanMainView:onEnter()
	MakeSnowmanMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.MakeSnowmanShowUnit, self._showUnitSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.MakeSnowmanShowGetInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.MakeSnowmanShowGetPrize, self._PM_MakeSnowmanGainProgressPrizeReq, self)

	self._table = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._table:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._dragCellStart, self), nil, nil, nil, nil)
	self._table:getView():RegisterDragEndedCallback(self._dragCellEnd, self)

	self._activityId = MakeSnowmanModel.instance:getCurrActId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show(lang("活动已结束"))
		self:close()

		return
	end

	self._activityCfg = MakeSnowmanConfig.instance:getActivityCfg(self._activityId)

	local startTime, endTime = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.MAKE_SNOWMAN, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = langPara("活动时间：%s月%s日 %02d:%02d-%s月%s日 %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	MaterialMgr.setIcon(self._conProgress, MatType.ACTIVITY_ITEM, checknumber(self._activityCfg.progressItemId))
	RedPointController.instance:regRedPoint(self._redPointTask, EventTaskSummaryConfig.instance:getPlanCfg(self._activityId).redPointId)
	GameUtil.SetActive(self._posRoot, false)
	self:initSlider()
	MakeSnowmanAgent.instance:sendPM_MakeSnowmanGetInfoReq(self._activityId)

	self.bgEffect1 = UIEffectManager.instance:playEffect(self, "20221223/xuerenduiduile/fx_ui_xuerenduiduile_zjm.prefab", nil, 0, 0, true)

	self.bgEffect1:setParent(self._bgEffectCon.transform)
	self.bgEffect1:setLocalPos(0, 0, 0)
	self.bgEffect1:setScale(1, 1, 1)

	self.bgEffect2 = UIEffectManager.instance:playEffect(self, "20221223/xuerenduiduile/fx_ui_xuerenduiduile_zmc.prefab", nil, 0, 0, true)

	self.bgEffect2:setParent(self._bgEffectCon.transform)
	self.bgEffect2:setLocalPos(0, 0, 0)
	self.bgEffect2:setScale(1, 1, 1)
end

function MakeSnowmanMainView:onExit()
	MakeSnowmanMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MakeSnowmanShowUnit, self._showUnitSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.MakeSnowmanShowGetInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.MakeSnowmanShowGetPrize, self._PM_MakeSnowmanGainProgressPrizeReq, self)
	RedPointController.instance:unregRedPoint(self._redPointTask)

	if self._guideFingerMove then
		UnityTweens.TweenPosition.StopTween(self._guideFinger)
	end

	UIEffectManager.instance:stopEffect(self.bgEffect1)
	UIEffectManager.instance:stopEffect(self.bgEffect2)
	removetimer(self._loopFingerMove, self)
	MaterialMgr.resetAll(self._conProgress)
	self._table:getView():UnRegisterDraggingCallback()
	self._table:dispose()
	self._rewardSliderMo:onExit()
end

function MakeSnowmanMainView:_updateView()
	self._txtGetNum.text = checknumber(MakeSnowmanModel.instance:getProgress())

	self._rewardSliderMo:updatePlayerReward()
	removetimer(self._loopFingerMove, self)

	if MakeSnowmanModel.instance:getProgress() <= 0 then
		self._guideFingerScaleTween.enabled = true

		GameUtil.SetActive(self._guideFinger, true)

		local pos = GameUtil.getAnchoredPos(self._btnTask)

		GameUtil.setAnchoredPos(self._guideFinger, pos.x, pos.y)

		self._isGuiding = false
		self._scrollrect.enabled = false
	elseif not MakeSnowmanModel.instance:isGetedProgressReward(self._activityId, 1) then
		if MakeSnowmanModel.instance:getCurBuildSnowman() > 0 and MakeSnowmanModel.instance:getUnits() and MakeSnowmanModel.instance:getUnits()[1] == true then
			self._guideFingerScaleTween.enabled = false

			self:_loopFingerMove()
			removetimer(self._loopFingerMove, self)
			settimer(0.7, self._loopFingerMove, self, true)
			GameUtil.SetActive(self._guideFinger, true)

			self._isGuiding = true
			self._scrollrect.enabled = false
		elseif MakeSnowmanModel.instance:getCurBuildSnowman() == 0 then
			self._guideFingerScaleTween.enabled = true

			GameUtil.setAnchoredPos(self._guideFinger, 164, -65)
			GameUtil.SetActive(self._guideFinger, true)

			self._isGuiding = false
			self._scrollrect.enabled = false
		else
			if self._isGuiding == true then
				FloatWordMgr.instance:show(lang("小奥奇，恭喜你已经掌握堆雪人的方法了，快堆好去领取大礼吧！"))

				self._isGuiding = false
			end

			self._isGuiding = false

			GameUtil.SetActive(self._guideFinger, false)

			self._scrollrect.enabled = true
		end
	else
		if self._isGuiding == true then
			FloatWordMgr.instance:show(lang("小奥奇，恭喜你已经掌握堆雪人的方法了，快堆好去领取大礼吧！"))

			self._isGuiding = false
		end

		self._isGuiding = false

		GameUtil.SetActive(self._guideFinger, false)

		self._scrollrect.enabled = true
	end
end

function MakeSnowmanMainView:_loopFingerMove()
	if self._guideFingerMove then
		UnityTweens.TweenPosition.StopTween(self._guideFinger)

		self._guideFingerMove = nil
	end

	self._guideFingerMove = UnityTweens.TweenPosition.StartTween(self._guideFinger, Vector3.New(73.5, 159, 0), Vector3.New(154, 37.5, 0), 0.5)
end

function MakeSnowmanMainView:_dragCellStart(startContainer, cell)
	local indexsString = string.split(cell.gameObject.name, "_")
	local cellIndex = checknumber(indexsString[2])

	MakeSnowmanModel.instance:setDragCellIndex(cellIndex)
	self._rewardSliderMo:updatePlayerReward()
end

function MakeSnowmanMainView:_dragCellEnd(startContainer, cell, endContainer)
	if endContainer then
		local indexsString = string.split(cell.gameObject.name, "_")
		local cellIndex = checknumber(indexsString[2])

		indexsString = string.split(endContainer.gameObject.name, "_")

		local endIndex = checknumber(indexsString[2])

		if cellIndex == endIndex then
			MakeSnowmanModel.instance:removeUnit(cellIndex)
			self._table:refresh()

			local haveUnits = false

			for i, v in ipairs(MakeSnowmanModel.instance:getUnits()) do
				if v == true then
					haveUnits = true

					break
				end
			end

			if haveUnits == false then
				MakeSnowmanAgent.instance:sendPM_MakeSnowmanGainProgressPrizeReq(self._activityId, MakeSnowmanModel.instance:getCurBuildSnowman())
				GameUtil.SetActive(self._posRoot, false)
				self._posRoot.transform:SetParent(self.mainGO.transform)
			end
		end
	end

	MakeSnowmanModel.instance:setDragCellIndex(nil)
	self:_updateView()

	return true
end

function MakeSnowmanMainView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = MakeSnowmanConfig.instance:getProgressCfg(self._activityCfg.prizePlanId)

	function sliderParam.getPlayerProgress()
		return MakeSnowmanModel.instance:getProgress()
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return MakeSnowmanModel.instance:isCanGetProgressReward(self._activityId, rewardCfg.prizeId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return MakeSnowmanModel.instance:isGetedProgressReward(self._activityId, rewardCfg.prizeId)
	end

	sliderParam.playerSliderCellClass = MakeSnowmanSliderCell
	sliderParam.playerWidthSpace = 320
	sliderParam.playerSliderEndOffset = 200

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function MakeSnowmanMainView:_showUnitSelect(snowmanGo, id)
	GameUtil.SetActive(self._posRoot, true)

	local pos = GameUtil.getPos(snowmanGo)

	GameUtil.setPos(self._posRoot, pos.x, pos.y, pos.z)
	self._posRoot.transform:SetParent(snowmanGo.transform)

	local prizeCfg = MakeSnowmanConfig.instance:getPrizeCfg(self._activityCfg.prizePlanId, id)
	local snowmanCfg = MakeSnowmanConfig.instance:getSnowmanCfg(prizeCfg.snowmanId)

	if MakeSnowmanModel.instance:getCurBuildSnowman() == 0 then
		MakeSnowmanModel.instance:setCurBuildSnowman(id)
		self:_resetUnitSelect(snowmanCfg, id)
	end

	self._table:reloadData(snowmanCfg)
	self:_updateView()
end

function MakeSnowmanMainView:_resetUnitSelect(snowmanCfg, id)
	local unitsIndex = {}

	for i, v in ipairs(snowmanCfg) do
		table.insert(unitsIndex, v.posId)
	end

	MakeSnowmanModel.instance:startUnits(unitsIndex)
end

function MakeSnowmanMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	go.name = "cell_" .. data.posId

	local cellGo = goutil.findChild(go, "cellGo")
	local cellBubble = goutil.findChild(go, "cellGoBubble")
	local txt = goutil.findChildTextComponent(cellGo, "txt")

	txt.text = ""

	local imgChange = goutil.findChildComponent(go, "cellGo", "UIImageSpriteChange")
	local units = MakeSnowmanModel.instance:getUnits()

	if units[data.posId] == true then
		GameUtil.SetActive(cellGo, true)
		GameUtil.SetActive(cellBubble, true)
	else
		GameUtil.SetActive(cellGo, false)
		GameUtil.SetActive(cellBubble, false)
	end

	imgChange:ChangeSprite(data.pickRes)
end

function MakeSnowmanMainView:_clearCell(cell)
	return
end

function MakeSnowmanMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.MakeSnowmanTaskView, self._activityId)
end

function MakeSnowmanMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, self._activityCfg.ruleKey)
end

function MakeSnowmanMainView:_PM_MakeSnowmanGainProgressPrizeReq()
	MakeSnowmanAgent.instance:sendPM_MakeSnowmanGetInfoReq(self._activityId)
end

return MakeSnowmanMainView
