-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/DuoLaLightStageView.lua

module("logic.extensions.duolalight.view.DuoLaLightStageView", package.seeall)

local DuoLaLightStageView = class("DuoLaLightStageView", ViewComponent)

function DuoLaLightStageView:buildUI()
	DuoLaLightStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
	self._diffScrollercell = goutil.findChild(self.mainGO, "diffCol/diffScrollercell")
	self._diffScrollerview = goutil.findChild(self.mainGO, "diffCol/diffScrollerview")
	self._diffScrollList = ScrollerList.create(self._diffScrollerview, self._diffScrollercell, GameUtil.handler(self._updateDiffCell, self), GameUtil.handler(self._clearDiffCell, self))
	self._itemScrollListDic = {}
	self._tipsRoot = goutil.findChild(self.mainGO, "tipsRoot")
end

function DuoLaLightStageView:bindEvents()
	DuoLaLightStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DuoLaLightStageView:unbindEvents()
	DuoLaLightStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DuoLaLightStageView:onEnter()
	DuoLaLightStageView.super.onEnter(self)

	self._activityId = DuoLaLightController.instance:getActivityId()
	self._activityType = DuoLaLightController.instance:getActivityType()

	local isInTime = DuoLaLightController.instance:isInActivityTimeAsDuoLa(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	if self._lightGameMapMo == nil then
		self._lightGameMapMo = LightGameMapMo.New()
	end

	self._lightGameMapMo:onEnter()

	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.DuoLaGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.DuoLaGameSweepRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.DuoLaGameEndGameRes, self._handleDuoLaGameEndGameRes, self)
	self:_sendInfoReq()
end

function DuoLaLightStageView:onExit()
	DuoLaLightStageView.super.onExit(self)
	self:_onClearDiffCol()
	self._lightGameMapMo:onExit()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function DuoLaLightStageView:destroyUI()
	DuoLaLightStageView.super.destroyUI(self)
	self._lightGameMapMo:onDestroy()
end

function DuoLaLightStageView:_handleDuoLaGameEndGameRes()
	self:_sendInfoReq()
end

function DuoLaLightStageView:_sendInfoReq()
	DuoLaLightController.instance:sendPM_DuoLaGameInfoReq(self._activityId)
end

function DuoLaLightStageView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local skinId = self:_getSkinId()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function DuoLaLightStageView:_onUpdate()
	self:_onUpdateDiffColUI()
end

function DuoLaLightStageView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DuoLaLightStageView:_getSkinId()
	return DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_PET_SKINID", true)
end

function DuoLaLightStageView:_onUpdateDiffColUI()
	local difficultyIds = {}
	local cfg = DuoLaLightConfig.instance:getDlDiffCfg(self._activityId)

	for _, data in ipairs(cfg) do
		table.insert(difficultyIds, data.difficultyId)
	end

	self._diffScrollList:reloadData(difficultyIds)
end

function DuoLaLightStageView:_onClearDiffCol()
	self._diffScrollList:dispose()
end

function DuoLaLightStageView:_updateDiffCell(view, cell, difficultyId, tag)
	local mainGo = cell.gameObject
	local gameId = DuoLaLightModel.instance:getGameIdOfDiff(difficultyId)
	local isFinished = DuoLaLightModel.instance:isFinishedOfDiff(difficultyId)
	local diffData = DuoLaLightConfig.instance:getDlDiffData(self._activityId, difficultyId)
	local stageData = DuoLaLightConfig.instance:getDlStageData(self._activityId, difficultyId, gameId)
	local mapId = checknumber(stageData and stageData.mapId)
	local isEmptyMap = mapId <= 0
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local imgPassYeah = goutil.findChild(mainGo, "imgPassYeah")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local txtDiff = goutil.findChildTextComponent(mainGo, "txtDiff/txt")
	local gridCol = goutil.findChild(mainGo, "gridCol")
	local gridView = goutil.findChild(mainGo, "gridCol/gridView")
	local gridCell = goutil.findChild(mainGo, "gridCol/gridCell")
	local itemScrollerview = goutil.findChild(mainGo, "itemCol/itemScrollerview")
	local itemScrollercell = goutil.findChild(mainGo, "itemCol/itemScrollercell")

	if mapId > 0 then
		self:_updateMapUI(gridView.transform, gridCell, mapId)
	end

	txtDiff.text = diffData.diffName

	if itemScrollerview and itemScrollercell then
		local prizeStrArr = string.split(diffData.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(imgPass, isFinished or isEmptyMap)
	GameUtil.SetActive(imgPassYeah, isFinished or isEmptyMap)
	GameUtil.SetActive(btnEnter, not isFinished and not isEmptyMap)
	GameUtil.SetActive(gridCol, not isFinished and not isEmptyMap)
	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickDiffBtnEnter, self, difficultyId, gameId))
end

function DuoLaLightStageView:_updateMapUI(partentTran, childGo, mapId)
	if checknumber(mapId) < 0 then
		return
	end

	GameUtil.SetActive(childGo, false)
	self._lightGameMapMo:onReset(mapId)

	local rowCount, colCount = self._lightGameMapMo:getRowCount(), self._lightGameMapMo:getColCount()
	local children = GameUtil.getChildren(partentTran)

	for idx, go in ipairs(children) do
		GameUtil.SetActive(go, false)
	end

	for x = 1, rowCount do
		for y = 1, colCount do
			local idx = (x - 1) * rowCount + y

			if not children[idx] then
				local mainGo = goutil.cloneAndSetParent(childGo, partentTran, string.format("%s_%s_(%s,%s)", childGo.name, idx, x, y))
				local icon = goutil.findChild(mainGo, "icon")
				local gridType = self._lightGameMapMo:getGridType(x, y)

				GameUtil.SetActive(mainGo, true)
				GameUtil.SetActive(icon, gridType ~= LightGameMapMo.GridType.Empty)

				if gridType ~= LightGameMapMo.GridType.Empty then
					GameUtil.setUIGroupIdx(mainGo, gridType)
				end
			end
		end
	end

	local pointPrefabSize = Vector2.New(GameUtil.getWidth(childGo), GameUtil.getHeight(childGo))
	local boardSize = Vector2.New(GameUtil.getWidth(partentTran), GameUtil.getHeight(partentTran))
	local pointSpacing = Vector2.New(pointPrefabSize.x * (0.25 / colCount), pointPrefabSize.y * (0.25 / rowCount))
	local tempPointSizeX = (boardSize.x - (colCount - 1) * pointSpacing.x) / colCount
	local tempPointSizeY = (boardSize.y - (rowCount - 1) * pointSpacing.y) / rowCount
	local pointSize = pointPrefabSize:Clone()

	if tempPointSizeX < pointPrefabSize.x or tempPointSizeY < pointPrefabSize.y then
		local ratX = tempPointSizeX / pointPrefabSize.x
		local ratY = tempPointSizeY / pointPrefabSize.y
		local rat = Mathf.Min(ratX, ratY)

		pointSize:Set(pointPrefabSize.x * rat, pointPrefabSize.y * rat)
	end

	local gridPrefabSize = Vector2.New(GameUtil.getWidth(childGo), GameUtil.getHeight(childGo))
	local gridSize = Vector2.New(pointSize.x / (pointPrefabSize.x / gridPrefabSize.x), pointSize.y / (pointPrefabSize.y / gridPrefabSize.y))

	self._defaultGridCellScale = Vector3.New(gridSize.x / gridPrefabSize.x, gridSize.y / gridPrefabSize.y, 1)

	local cellScaleSize = Vector2.New(gridSize.x / gridPrefabSize.x, gridSize.y / gridPrefabSize.y)
	local gridLayoutGroup = partentTran:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	gridLayoutGroup.constraintCount = colCount
	gridLayoutGroup.cellSize = pointSize
	gridLayoutGroup.spacing = pointSpacing
end

function DuoLaLightStageView:_clearDiffCell(cell)
	local mainGo = cell.gameObject
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnEnter)
end

function DuoLaLightStageView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function DuoLaLightStageView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function DuoLaLightStageView:_onClickBtnTip()
	local value = DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_MAIN_RULE_KEY", false)

	TipsFacade.instance:openRulesView(value)
end

function DuoLaLightStageView:_onClickDiffBtnEnter(difficultyId, gameId)
	local isHasPassFirst = DuoLaLightModel.instance:isSweepable(difficultyId)

	if self._isBelongSweep and isHasPassFirst then
		local isInitInfo = YearCardModel.instance:isInitInfo()

		if not isInitInfo then
			FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

			return
		end

		local sweepResult = self:_getTrySweepGameResultAndTips(false, self._activityId, difficultyId, gameId, 1)

		if sweepResult == GameEnum.ResultCode.Success then
			local descTxt = "您已首通完毕，是否扫荡直接通关？"

			local function sureCallBack(view)
				self:_sweepGame(self._activityId, difficultyId, gameId, view:getCurTimes())
			end

			local function cancelCallBack(view)
				self:_enterGame(self._activityId, difficultyId, gameId)
			end

			local otherCallBack

			local function updateCoinTxtCallBack(view)
				view:getTxtCoin().text = ""
			end

			local updateDescTxtCallBack
			local left = self:_getLeftTimes(difficultyId)

			TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
		else
			self:_enterGame(self._activityId, difficultyId, gameId)
		end
	else
		self:_enterGame(self._activityId, difficultyId, gameId)
	end
end

function DuoLaLightStageView:_enterGame(activityId, difficultyId, gameId)
	local result = self:_getTryEnterGameResultAndTips(true, activityId, difficultyId, gameId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local stageData = DuoLaLightConfig.instance:getDlStageData(self._activityId, difficultyId, gameId)

	if stageData then
		if not stageData.mapId then
			local mapId = 0

			if mapId <= 0 then
				printError("mapId <= 0")

				return
			end

			local params = {}

			params.activityId = self._activityId
			params.activityType = self._activityType
			params.difficultyId = difficultyId
			params.gameId = gameId
			params.mapId = mapId

			self:_openLigthView(params)
		end
	end
end

function DuoLaLightStageView:_sweepGame(activityId, difficultyId, gameId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, difficultyId, gameId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DuoLaLightController.instance:sendPM_DuoLaGameSweepReq(activityId, difficultyId)
end

function DuoLaLightStageView:_getTryEnterGameResultAndTips(isNeedTips, activityId, difficultyId, gameId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not DuoLaLightController.instance:isInActivityTimeAsDuoLa(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes(difficultyId)

		if leftTimes <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DuoLaLightStageView:_getTrySweepGameResultAndTips(isNeedTips, activityId, difficultyId, gameId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not DuoLaLightController.instance:isInActivityTimeAsDuoLa(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes(difficultyId)

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DuoLaLightStageView:_getLeftTimes(difficultyId)
	local isFinished = DuoLaLightModel.instance:isFinishedOfDiff(difficultyId)

	return isFinished and 0 or 1
end

function DuoLaLightStageView:_openLigthView(params)
	UIStateManager.instance:push(ViewName.LightGameView, params)
end

return DuoLaLightStageView
