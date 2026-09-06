-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleMainView.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleMainView", package.seeall)

local WishTreeBottleMainView = class("WishTreeBottleMainView", ViewComponent)

function WishTreeBottleMainView:ctor()
	WishTreeBottleMainView.super.ctor(self)
end

function WishTreeBottleMainView:unbindEvents()
	WishTreeBottleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnWish)
	GameUtil.rmClickHandler(self._btnPutIn)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnTask)
end

function WishTreeBottleMainView:bindEvents()
	WishTreeBottleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnWish, self._onClickWish, self)
	GameUtil.addClickHandler(self._btnPutIn, self._onClickPutIn, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickRefresh, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
end

function WishTreeBottleMainView:buildUI()
	WishTreeBottleMainView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._rewardCell = self:getGo("rewardCell")
	self._clippRect = self:getGo("tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._txtTime = self:getTxt("time/txt")
	self._txtProgress = self:getTxt("progress/txt")
	self._btnWish = self:getBtn("btnWish")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._txtRefreshRound = self:getTxt("btnRefresh/txt")
	self._mask = self:getGo("progressCon/mask")
	self._btnPutIn = self:getBtn("btnPutIn")
	self._redPoint = self:getGo("btnPutIn/redpoint")
	self._btnTask = self:getBtn("btnTask")
	self._redPointTask = self:getGo("btnTask/redpoint")
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._goldBar = self:getGo("goldBarCon")
	self._stepDot = self:getGo("progressCon/stepDot")
	self._txtWishState = self:getTxt("btnWish/txt")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._towerViewGo = self:getGo("progressCon/tableview")
	self._towerCell = self:getGo("progressCon/wishCell")
	self._towerView = ScrollerList.create(self._towerViewGo, self._towerCell, GameUtil.handler(self._updateTowerCell, self), GameUtil.handler(self._clearTowerCell, self))

	self._towerView:regGetCellSize(GameUtil.handler(self._cellSize, self))
end

function WishTreeBottleMainView:onExit()
	WishTreeBottleMainView.super.onExit(self)

	for _, cell in pairs(self._effectList) do
		if cell then
			for _, eff in pairs(cell) do
				UIEffectManager.instance:stopEffect(eff)
			end
		end
	end

	UIEffectManager.instance:stopEffect(self._fireEff)

	self._bottleData = {}

	removetimer(self._sendRankReq, self)
	removetimer(self._bottleFadeOut, self)
	removetimer(self._bottleFadeIn, self)
	removetimer(self._anim, self)
	GameUtil.saveUserData(self._animSaveKey, {
		self._curAnimStep,
		self._curAnimDot,
		self._curProgressId
	})
	GameUtil.SetActive(self._mask, false)
	RedPointController.instance:unregRedPoint(self._redPoint)
	RedPointController.instance:unregRedPoint(self._redPointTask)
end

function WishTreeBottleMainView:onEnter()
	WishTreeBottleMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleInfoRes, self._refreshInfo, self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleSendRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleViewRes, self._refreshRankInfo, self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleLikeRes, self._refreshWishData, self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleRefresh, self._refreshBottleIng, self)
	self.addGEvent(self, GlobalNotify.GetActivityPluginProgressInfoRes, self._refreshReward, self)
	self.addGEvent(self, GlobalNotify.GainActivityPluginProgressPrizeRes, self._sendPluginReq, self)
	self.addGEvent(self, MaterialAgent.UseMaterialRes, self._sendPluginReq, self)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_WISHTREEBOTTLE)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._progressId = checknumber(params[2])

	if self._activityId <= 0 or self._progressId <= 0 then
		FloatWordMgr.instance:show("没有活动id或进度id~")
		self:close()
	end

	GameUtil.SetActive(self._mask, false)

	self._planCfg = OperationSummaryConfig.instance:getPluginProgressPlanCfg(self._activityId, self._progressId)
	self._prizeCfg = OperationSummaryConfig.instance:getPluginProgressPrizeCfg(self._planCfg.planId)
	self._actCfg = WiShTreeBottleConfig.instance:getWtbActCfg(self._activityId)
	self._prizeCfgCount = #self._prizeCfg
	self._curProgressId = Mathf.Clamp(OpSummaryController.instance:pluginProgressId(self._activityId), 0, self._prizeCfg[self._prizeCfgCount].needScore)
	self._progressInfo = OpSummaryModel.instance:getAdmireMoonInfo()
	self._effectRewardList = {}
	self._effectList = {}

	self._tableview:reloadData(self._prizeCfg)

	local objList = {
		{
			showAdd = true,
			id = self._planCfg.materialId
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._dotCount = self._planCfg.towerStarCount
	self._stepScoreList = {}
	self._spaceX = self._planCfg.spaceX
	self._spaceY = self._planCfg.spaceY
	self._animSaveKey = ViewName.WishTreeBottleMainView .. self._activityId
	self._animStep = GameUtil.getUserData(self._animSaveKey)

	if self._animStep then
		self._curAnimStep = checknumber(self._animStep[1])
		self._curAnimDot = checknumber(self._animStep[2])
		self._curAnimProgress = checknumber(self._animStep[3])
	else
		self._curAnimStep = 1
		self._curAnimDot = 0
		self._curAnimProgress = 0
	end

	self:_calStepData()
	self:_sendGetInfoReq()
	self:_sendRankReq()
	self:_sendPluginReq()

	self._curWishBottleId = 0
	self._bottleData = {}
	self._curRoundIds = 0

	local totalBottle = self._prizeCfgCount

	self._refreshRound = Mathf.Ceil(totalBottle / 10)
	self._refreshBottleCount = totalBottle
	self._txtRefreshRound.text = string.format("刷新%d轮", self._curRoundIds)
	self._fadeCellList = {}
	self._fadeValue = 1

	self:_refreshRoundTime()

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redPointTask, taskRedId)
	else
		goutil.setActive(self._redPointTask, false)
	end
end

function WishTreeBottleMainView:_sendGetInfoReq()
	WiShTreeBottleController.instance:sendPM_WishTreeBottleInfoReq(self._activityId)
end

function WishTreeBottleMainView:_sendRankReq()
	WiShTreeBottleController.instance:sendPM_WishTreeBottleViewReq(self._activityId)
end

function WishTreeBottleMainView:_sendPluginReq()
	OpSummaryController.instance:sendPM_GetActivityPluginProgressInfoReq(self._activityId)
end

function WishTreeBottleMainView:_refreshReward()
	local idx = -1
	local gainPrizeList = {}

	for i, v in ipairs(self._prizeCfg) do
		local isCanGet = self._curProgressId >= v.needScore
		local isGainPrize = OpSummaryController.instance:isGainPrize(self._activityId, v.id)

		gainPrizeList[i] = isGainPrize

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	if idx == -1 then
		for i = 1, self._prizeCfgCount do
			if gainPrizeList[i] == nil or gainPrizeList[i] == false then
				idx = i - 1

				break
			end
		end
	end

	self._curProgressId = Mathf.Clamp(OpSummaryController.instance:pluginProgressId(self._activityId), 0, self._prizeCfg[self._prizeCfgCount].needScore)
	self._txtProgress.text = string.format("当前放飞蝴蝶：<color=#20b376>%d</color>/%d", self._curProgressId, self._prizeCfg[self._prizeCfgCount].needScore)

	self._tableview:refresh()
	self._tableview:MoveCellToCenter(idx == -1 and 0 or idx)
	self:_moveCellToCenter(self._curAnimStep)

	if self._curProgressId > self._curAnimProgress then
		self:_stepAnim()
	end
end

function WishTreeBottleMainView:_refreshInfo()
	self._isSendWish = WiShTreeBottleController.instance:isSendWish()
	self._txtWishState.text = self._isSendWish and "我的愿望" or "发布愿望"
end

function WishTreeBottleMainView:_refreshRankInfo()
	local refreshBottleList = {}

	self._fadeCellList = {}

	if self._curRoundIds > 0 then
		for i = 1, self._refreshRound do
			local id = (i - 1) * 10 + self._curRoundIds

			if self._bottleData[id] then
				table.insert(refreshBottleList, id)

				local cell = self._towerView._tableview:GetCellAtIndex(id - 1)

				if cell then
					table.insert(self._fadeCellList, cell)
				end
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.WishTreeBottleRefresh, self._fadeCellList)

		if #self._fadeCellList > 0 then
			settimer(0.1, self._bottleFadeOut, self, true)
		end
	end

	self._bottleData = WiShTreeBottleController.instance:bottleRefreshData(self._activityId, self._bottleData, self._refreshBottleCount, refreshBottleList)
	self._myBottleIndex = WiShTreeBottleController.instance:getMyBottleIdInTree(self._bottleData)

	if self._curRoundIds <= 0 then
		self._towerView:reloadData(self._bottleData)
	end

	self._curRoundIds = (self._curRoundIds + 1) % 10 < 1 and 1 or (self._curRoundIds + 1) % 10
	self._txtRefreshRound.text = string.format("刷新%d轮", self._curRoundIds)
end

function WishTreeBottleMainView:_refreshRoundTime()
	settimer(self._actCfg.refreshTime, self._sendRankReq, self, true)
end

function WishTreeBottleMainView:_bottleFadeOut()
	self._fadeValue = self._fadeValue - 0.2

	for i, cell in ipairs(self._fadeCellList) do
		local canvasGroup = goutil.findChild(cell.gameObject, "btnWish"):GetComponent(ComponentType.CanvasGroup)

		canvasGroup.alpha = self._fadeValue
	end

	if self._fadeValue <= 0 then
		self._towerView:reloadData(self._bottleData)
		removetimer(self._bottleFadeOut, self)
		settimer(0.1, self._bottleFadeIn, self, true)
	end
end

function WishTreeBottleMainView:_bottleFadeIn()
	self._fadeValue = self._fadeValue + 0.2

	for i, cell in ipairs(self._fadeCellList) do
		local canvasGroup = goutil.findChild(cell.gameObject, "btnWish"):GetComponent(ComponentType.CanvasGroup)

		canvasGroup.alpha = self._fadeValue
	end

	if self._fadeValue >= 1 then
		removetimer(self._bottleFadeIn, self)
	end
end

function WishTreeBottleMainView:_onClickRefresh()
	self:_sendRankReq()
end

function WishTreeBottleMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.WishTreeBottleTaskFrameView, self._activityId)
end

function WishTreeBottleMainView:_updateTowerCell(view, cell, data)
	local id = cell.index
	local wishIndex = id % 2
	local wishParent = goutil.findChild(cell, "wishCon_" .. wishIndex + 1)
	local stepCon = goutil.findChild(cell, "stepCon")
	local down = goutil.findChild(cell, "down")
	local middleL = goutil.findChild(cell, "middleL")
	local middleR = goutil.findChild(cell, "middleR")
	local top = goutil.findChild(cell, "top")
	local stepDownPos = goutil.findChild(cell, "stepDownPos")
	local stepDownPosL = goutil.findChild(cell, "stepDownPosL")
	local stepMiddleLPos = goutil.findChild(cell, "stepMiddleLPos")
	local stepMiddleRPos = goutil.findChild(cell, "stepMiddleRPos")
	local win = goutil.findChild(cell, "top/win")
	local stepParent

	if id == 0 then
		stepParent = stepDownPos
	elseif id == 1 then
		stepParent = stepDownPosL
	elseif wishIndex < 1 and id ~= 0 then
		stepParent = stepMiddleRPos
	elseif wishIndex >= 1 then
		stepParent = stepMiddleLPos
	end

	local wishPos = GameUtil.getLocalPos((id == 0 or nil) and goutil.findChild(cell, "wishCon_" .. 3))
	local stepPos = GameUtil.getLocalPos(stepParent)
	local btnWish = goutil.findChildButtonComponent(cell, "btnWish")
	local txtTitle = goutil.findChildTextComponent(cell, "btnWish/txtTitle")
	local txtKoiNum = goutil.findChildTextComponent(cell, "btnWish/koiNum/txtNum")
	local change = goutil.findChild(cell, "btnWish"):GetComponent("UIImageSpriteChange")
	local canvasGroup = goutil.findChild(cell, "btnWish"):GetComponent(ComponentType.CanvasGroup)

	for i = 1, self._dotCount do
		local stepDot = goutil.findChild(stepCon, "step_" .. i)

		if stepDot == nil then
			stepDot = goutil.cloneAndSetParent(self._stepDot, stepCon.transform, "step_" .. i)
		end

		GameUtil.setLocalPos(stepDot, (i - 1) * self._spaceX, (i - 1) * self._spaceY, 0)

		local stepChange = stepDot:GetComponent("UIImageSpriteChange")
		local value = self._stepScoreList[id + 1][i]

		stepChange:SetState(value <= self._curAnimProgress and 1 or 0)
	end

	GameUtil.SetActive(win, self._curAnimProgress >= self._prizeCfg[self._prizeCfgCount].needScore)
	cell.gameObject.transform:SetSiblingIndex(id)
	GameUtil.SetActive(down, false)
	GameUtil.SetActive(top, false)
	GameUtil.SetActive(middleL, false)
	GameUtil.SetActive(middleR, false)

	if id == 0 then
		GameUtil.SetActive(down, true)
	elseif id == self._prizeCfgCount - 1 then
		GameUtil.SetActive(top, true)
	elseif id < 2 then
		-- block empty
	elseif id % 2 == 0 then
		GameUtil.SetActive(middleL, true)
	end

	GameUtil.setLocalPos(btnWish.gameObject, wishPos.x, wishPos.y, 0)
	GameUtil.setLocalPos(stepCon, stepPos.x, stepPos.y, 0)

	local scaleX = wishIndex > 0 and 1 or -1

	GameUtil.setLocalScale(stepCon, scaleX, 1, 1)

	local typeCfg = WiShTreeBottleConfig.instance:getWtbTypeCfgById(self._activityId, checknumber(data.typeId))

	change:ChangeSprite(typeCfg.pic)

	txtKoiNum.text = data.likeNum
	txtTitle.text = WiShTreeBottleConfig.instance:getWtbTitleCfgById(self._activityId, data.titleId).content

	GameUtil.addClickHandler(btnWish, GameUtil.handler(self._onClickWishCell, self, data, id + 1))
end

function WishTreeBottleMainView:_cellSize(view, index)
	if index < 2 then
		return 944, 191
	elseif index == self._prizeCfgCount - 1 then
		return 944, 266
	end

	return 944, 133
end

function WishTreeBottleMainView:_calStepData()
	local score = 0

	for i, v in ipairs(self._prizeCfg) do
		scoreArea = v.needScore - score
		value = scoreArea / self._dotCount
		self._stepScoreList[i] = {}

		for k = 1, self._dotCount do
			self._stepScoreList[i][k] = score + k * value
		end

		score = v.needScore
	end
end

function WishTreeBottleMainView:_stepAnim()
	self._animRecord = {}
	self._animRecord[1] = 1
	self._animRecord[2] = 0
	self._animRecord[3] = 1
	self._animRecord[4] = 0

	for stepId, stepScores in ipairs(self._stepScoreList) do
		for dotId, score in ipairs(stepScores) do
			if score > self._curAnimProgress and self._animRecord[1] <= 0 then
				self._animRecord[1] = stepId
				self._animRecord[2] = dotId
			end

			if score <= self._curProgressId then
				self._animRecord[3] = stepId
				self._animRecord[4] = dotId
			end
		end
	end

	GameUtil.SetActive(self._mask, true)
	settimer(self._planCfg.animTime, self._anim, self, true)
end

function WishTreeBottleMainView:_anim()
	if self._curAnimStep > self._prizeCfgCount then
		GameUtil.saveUserData(self._animSaveKey, {
			self._curAnimStep,
			self._curAnimDot,
			self._curProgressId
		})
		GameUtil.SetActive(self._mask, false)
		removetimer(self._anim, self)

		self._curAnimProgress = self._curProgressId

		self._towerView:reloadData(self._bottleData)

		return
	end

	if self._curAnimStep == self._animRecord[3] and self._curAnimDot == self._animRecord[4] then
		GameUtil.saveUserData(self._animSaveKey, {
			self._curAnimStep,
			self._curAnimDot,
			self._curProgressId
		})
		removetimer(self._anim, self)
		GameUtil.SetActive(self._mask, false)

		self._curAnimProgress = self._curProgressId

		self._towerView:reloadData(self._bottleData)

		return
	end

	if self._curAnimDot + 1 > self._dotCount and self._curAnimStep <= self._prizeCfgCount then
		self._curAnimStep = self._curAnimStep + 1
		self._curAnimDot = 1

		self:_moveCellToCenter(self._curAnimStep)
	else
		self._curAnimDot = self._curAnimDot + 1
	end

	local cell = self._towerView._tableview:GetCellAtIndex(self._curAnimStep - 1)
	local stepCon = goutil.findChild(cell, "stepCon")
	local stepDot = goutil.findChild(stepCon, "step_" .. self._curAnimDot)
	local stepChange = stepDot:GetComponent("UIImageSpriteChange")

	stepChange:SetState(1)
end

function WishTreeBottleMainView:_moveCellToCenter(id)
	local showId = id

	if self._prizeCfgCount <= 0 then
		return
	else
		showId = Mathf.Clamp(id, 0, self._prizeCfgCount - 1)
	end

	local offset = self._towerView._tableview:GetOffsetByIndex(showId)
	local viewSize = self._towerView._tableview:GetViewSize()
	local cellSize = self._towerView._tableview:GetCellSize(showId)
	local offsetTo = offset - viewSize * 0.5 + cellSize * 0.5

	self._towerView._tableview:SetOffset(offsetTo, true)
end

function WishTreeBottleMainView:_clearTowerCell()
	local btnWish = goutil.findChildButtonComponent(cell, "btnWish")

	GameUtil.rmClickHandler(btnWish)
end

function WishTreeBottleMainView:_refreshBottleIng(bottleList)
	for _, v in pairs(bottleList) do
		if v.index + 1 == self._curWishBottleId then
			self._curWishBottleId = -1

			return
		end
	end
end

function WishTreeBottleMainView:_refreshWishData()
	if self._curWishBottleId <= 0 or self._curWishBottleId > #self._bottleData then
		return
	end

	local num = checknumber(self._bottleData[self._curWishBottleId].likeNum)

	self._bottleData[self._curWishBottleId].likeNum = num + 1

	self._towerView:reloadData(self._bottleData)
end

function WishTreeBottleMainView:_updateCell(view, cell, data)
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local txtTip = goutil.findChildTextComponent(cell, "txtTip")
	local btnReceive = goutil.findChildButtonComponent(cell, "btnReceive")
	local receive = goutil.findChild(cell, "received")
	local rewardCon = goutil.findChild(cell, "rewardCon")
	local layout = goutil.findChild(cell, "rewardCon"):GetComponent(ComponentType.UILayoutSingleLine)
	local rewardCell = {}

	for i = 1, 3 do
		local reward = {}

		reward.go = goutil.findChild(cell, "rewardCon/item_" .. i)
		reward.con = goutil.findChild(cell, "rewardCon/item_" .. i .. "/con")
		reward.effect = goutil.findChild(cell, "rewardCon/item_" .. i .. "/effect")

		table.insert(rewardCell, reward)
	end

	local isGainPrize = OpSummaryController.instance:isGainPrize(self._activityId, data.id)
	local isCanGet = self._curProgressId >= data.needScore
	local prizeStr = string.split(data.prize, "#")

	if self._effectList[cell.gameObject] ~= nil then
		self:_removeRewardEffect(cell.gameObject)
	end

	for i, v in ipairs(rewardCell) do
		local prize = prizeStr[i]

		if prize then
			GameUtil.SetActive(rewardCell[i].go, true)
			MaterialMgr.setCellByCfg(prize, rewardCell[i].con)

			if isCanGet and not isGainPrize then
				self:_playRewardEffect(rewardCell[i].effect, cell.gameObject, i)
			end
		else
			GameUtil.SetActive(rewardCell[i].go, false)
			MaterialMgr.resetAll(rewardCell[i].con)
		end
	end

	layout:Layout()

	txtLevel.text = "第" .. data.id .. "层"
	txtTip.text = string.format("放飞蝴蝶达到%d只\n可解锁本层", data.needScore)

	GameUtil.SetActive(btnReceive.gameObject, isCanGet and not isGainPrize)
	GameUtil.SetActive(receive, isGainPrize)
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickReceive, self, data.id))
end

function WishTreeBottleMainView:_clearCell(cell)
	self:_removeRewardEffect(cell.gameObject)

	for i = 1, 3 do
		MaterialMgr.resetAll(goutil.findChild(cell, "rewardCon/item_" .. i .. "/con"))
	end
end

function WishTreeBottleMainView:_playFireEffect(x, y, scale)
	local effPath = "20231222/hudiegu/fx_ui_hudiegu_hudiefeiguo.prefab"

	self._fireEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, x, y, false, nil, nil, nil, self)

	self._fireEff:setParent(self.mainGO.transform)
	self._fireEff:setLocalPos(x, y, 0)
	self._fireEff:setScale(scale)
end

function WishTreeBottleMainView:_playRewardEffect(parent, cell, id)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	if self._effectList[cell] == nil then
		self._effectList[cell] = {}
	end

	self._effectList[cell][id] = self:_playEffect(effectPath, parent, true)
end

function WishTreeBottleMainView:_removeRewardEffect(cell)
	local effects = self._effectList[cell]

	if effects then
		for _, eff in ipairs(effects) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._effectList[cell] = nil
end

function WishTreeBottleMainView:_playEffect(path, parent, isClip)
	local effect = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, true, nil, nil, function(target, eff)
		if isClip then
			eff:setClipping(self._clippRect)
		end
	end, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

function WishTreeBottleMainView:_onClickPutIn()
	local itemStr = OperationSummaryConfig.instance:getPluginProgressPlanCfg(self._activityId, self._progressId).materialId
	local matType, matId, matNum = MaterialMgr.getMatParams(itemStr)
	local hasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasCount <= 0 then
		FloatWordMgr.instance:show(lang("wtbm_not_enough"))
	else
		local count = Mathf.Clamp(hasCount, 1, 99999)

		MaterialFacade.instance:useItem(matType, matId, count, nil, nil, MaterialController.CI_SHOW_TYPE_FLY)
		self:_playFireEffect(0, 0, 0)
	end
end

function WishTreeBottleMainView:_onClickWish()
	if self._isSendWish then
		local data = WiShTreeBottleModel.instance:getWishBottle()

		self._curWishBottleId = self._myBottleIndex

		UIStateManager.instance:push(ViewName.WishTreeBottleInfoView, data)
	else
		UIStateManager.instance:push(ViewName.WishTreeBottleEditView)
	end
end

function WishTreeBottleMainView:_onClickTip()
	TipsFacade.instance:openRulesView("wishtreebottle_rule")
end

function WishTreeBottleMainView:_onClickReceive(prizeId)
	OpSummaryController.instance:sendPM_GainActivityPluginProgressPrizeReq(self._activityId, self._progressId, prizeId)
end

function WishTreeBottleMainView:_onClickWishCell(data, id)
	self._curWishBottleId = id

	UIStateManager.instance:push(ViewName.WishTreeBottleInfoView, data)
end

return WishTreeBottleMainView
