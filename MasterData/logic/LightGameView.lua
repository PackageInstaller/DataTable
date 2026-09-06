-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/LightGameView.lua

module("logic.extensions.duolalight.view.LightGameView", package.seeall)

local LightGameView = class("LightGameView", ViewComponent)

function LightGameView:buildUI()
	LightGameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
	self._gridView = goutil.findChild(self.mainGO, "gridCol/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "gridCol/gridCell")
	self._gridLayoutGroup = self._gridView:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	GameUtil.SetActive(self._gridCell, false)

	self._testCol = {}

	local mainGo = goutil.findChild(self.mainGO, "testCol")

	self._testCol._mainGo = mainGo
	self._testCol._btnView = goutil.findChild(mainGo, "btnView")
	self._testCol._txtTest = goutil.findChildTextComponent(mainGo, "txtTest")
	self._testCol._dropdown = goutil.findChild(mainGo, "dropdown")
	self._testCol._dropdownComp = DropDownAdapter.Get(self._testCol._dropdown)
	self._btnTestList = GameUtil.getChildren(self._testCol._btnView)
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._txtLeftStep = goutil.findChildTextComponent(self.mainGO, "txtLeftStep/txt")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._startMask = goutil.findChild(self.mainGO, "startMask")
end

function LightGameView:bindEvents()
	LightGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for idx, go in ipairs(self._btnTestList) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickBtnTest, self, idx))
	end

	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._startMask, self._onClickBtnStartMask, self)
end

function LightGameView:unbindEvents()
	LightGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx, go in ipairs(self._btnTestList) do
		GameUtil.rmClickHandler(go)
	end

	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._startMask)
end

function LightGameView:onEnter()
	LightGameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._exParams = params[1] or {}
	self._mapId = checknumber(self._exParams.mapId)
	self._activityId = checknumber(self._exParams.activityId)
	self._activityType = checknumber(self._exParams.activityType)
	self._difficultyId = checknumber(self._exParams.difficultyId)
	self._isTestMode = checkbool(self._exParams.isTestMode)

	if self._mapId <= 0 then
		printError("缺失mapId")
		TipsFacade.instance:openTipWindowNoX("提示", "出现错误,界面即将关闭", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	if self._lightGameMgr == nil then
		self._lightGameMgr = LightGameMgr.New()
	end

	local mgrParams = {}

	self._lightGameMgr:onEnter(mgrParams)
	self:_resetGame()

	self._isHasReqGame = false

	self.addGEvent(self, GlobalNotify.LightGameUpdateGameUI, self._onUpdatePlaneUI, self)
	self:_onSetUI()
	self:_onUpdateTestCol()
	GameUtil.SetActive(self._startMask, true)
	settimer(0, self._onTicking, self)
end

function LightGameView:onExit()
	LightGameView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearMapUI()

	self._isHasReqGame = false

	if self._lightGameMgr then
		self._lightGameMgr:onExit()
	end

	self:_clearAllGridTrunEff()
	self:_clearMarkGridEffs()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function LightGameView:destroyUI()
	LightGameView.super.destroyUI(self)

	if self._lightGameMgr then
		self._lightGameMgr:onDestroy()

		self._lightGameMgr = nil
	end
end

function LightGameView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityType > 0 and self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local skinId = self:_getSkinId()

	if skinId > 0 then
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
	else
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end
end

function LightGameView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function LightGameView:_getSkinId()
	return DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_PET_SKINID", true)
end

function LightGameView:_reqStartGame()
	if self._isHasReqGame == false and self._activityId > 0 and self._difficultyId > 0 and not self._isTestMode then
		self._isHasReqGame = true

		self.addGEvent(self, GlobalNotify.DuoLaGameStartGameRes, self._handleGameStartGameReq, self)
		DuoLaLightController.instance:sendPM_DuoLaGameStartGameReq(self._activityId, self._difficultyId)
	else
		self:_handleGameStartGameReq()
	end
end

function LightGameView:_handleGameStartGameReq(status, msg)
	GameUtil.SetActive(self._startMask, false)
	self:_continueGame()
end

function LightGameView:_reqEndGame()
	ViewBlockMgr.instance:blockClick(true, self)

	local isPass = self._lightGameMgr:isPass()
	local buyTimes = self._lightGameMgr:getBuyTimes()

	if self._isHasReqGame == true and self._activityId > 0 and self._difficultyId > 0 and not self._isTestMode then
		self._isHasReqGame = false

		self.addGEvent(self, GlobalNotify.DuoLaGameEndGameRes, self._handleGameEndGameReq, self)
		DuoLaLightController.instance:sendPM_DuoLaGameEndGameReq(self._activityId, self._difficultyId, isPass, buyTimes)
	else
		self:_handleGameEndGameReq()
	end
end

function LightGameView:_handleGameEndGameReq(status, msg)
	ViewBlockMgr.instance:blockClick(false, self)
	self:_popResultWin()
end

function LightGameView:_popResultWin()
	local isPass = self._lightGameMgr:isPass()
	local text = isPass and "游戏胜利" or "游戏失败"

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function LightGameView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime

	self._lightGameMgr:onTicking(self._deltaTime)

	self._state = self._lightGameMgr:getCurState()

	if self._state == LightGameMgr.State.Readying then
		-- block empty
	elseif self._state == LightGameMgr.State.Runing then
		if self._lightGameMgr:isPass() then
			self:_endGame()
		elseif self._lightGameMgr:getLeftStep() <= 0 then
			if self._activityId > 0 then
				self:_popBuyTimesTips()
			elseif self._isTestMode then
				self:_stopGame()

				local text = "测试模式，自动为你购买次数+1，步数+5"

				local function func()
					self:_finfishStepAdd()
				end

				TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
			end
		end
	elseif self._state == LightGameMgr.State.Stoping then
		-- block empty
	elseif self._state == LightGameMgr.State.Ended then
		-- block empty
	end

	if self._isTestMode then
		local str = {}

		str[1] = "测试："
		str[2] = string.format("\n当前地图Id：%s", self._lightGameMgr:getMapId())
		str[3] = string.format("\n当前游戏时间：%.1fs", self._lightGameMgr:getCurGameTime())
		str[4] = string.format("\n当前步数：( %s / %s ) ", self._lightGameMgr:getCurStep(), self._lightGameMgr:getMaxStep())
		str[5] = string.format("\n当前购买次数：%s", self._lightGameMgr:getBuyTimes())

		if self._lightGameMgr:isEditorMode() then
			str[1] = "---> 编辑模式中 <---"
		end

		local fs = ""

		for i = 1, #str do
			fs = fs .. str[i]
		end

		self._testCol._txtTest.text = fs
	end
end

function LightGameView:_resetGame()
	self._lightGameMgr:resetGame(self._mapId)
	self:onResetMapUI()
	self:_onUpdatePlaneUI()
	GameUtil.SetActive(self._startMask, true)
end

function LightGameView:_stopGame()
	self._lightGameMgr:stopGame()
end

function LightGameView:_continueGame()
	self._lightGameMgr:continueGame()
end

function LightGameView:_endGame()
	self._lightGameMgr:endGame()
	self:_reqEndGame()
end

function LightGameView:_onUpdatePlaneUI()
	self._txtLeftStep.text = string.format("剩余步数：%s", self._lightGameMgr:getLeftStep())
end

function LightGameView:onResetMapUI()
	local partentTran = self._gridView.transform
	local childGo = self._gridCell
	local rowCount = self._lightGameMgr:getRowCount()
	local colCount = self._lightGameMgr:getColCount()
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
	local children = GameUtil.getChildren(partentTran)

	for idx, go in ipairs(children) do
		GameUtil.SetActive(go, false)
	end

	self._gridCellPool = self._gridCellPool or {}
	self._gridCellMap = self._gridCellMap or {}

	for x = 1, rowCount do
		self._gridCellMap[x] = self._gridCellMap[x] or {}

		for y = 1, colCount do
			local idx = (x - 1) * rowCount + y

			if not children[idx] then
				local mainGo = goutil.cloneAndSetParent(childGo, partentTran, string.format("%s_%s_(%s,%s)", childGo.name, idx, x, y))

				if not self._gridCellPool[children[idx]] then
					local cell = {}

					if cell._mainGo == nil then
						cell._mainGo = children[idx]
						cell._icon = goutil.findChild(children[idx], "icon")
						cell._effRoot = goutil.findChild(children[idx], "effRoot")
					end

					self._gridCellMap[x][y] = cell
					self._gridCellPool[children[idx]] = cell

					GameUtil.setLocalScale(cell._effRoot, cellScaleSize.x, cellScaleSize.y)
					self:_updateGridCell(x, y)
				end
			end
		end
	end

	self._gridLayoutGroup.constraintCount = colCount
	self._gridLayoutGroup.cellSize = pointSize
	self._gridLayoutGroup.spacing = pointSpacing

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(partentTran:GetComponent(goutil.Type_RectTransform))
end

function LightGameView:_onClearMapUI()
	if self._gridCellPool == nil then
		return
	end

	for _, cell in ipairs(self._gridCellPool) do
		self:_clearGridCell(cell)
	end

	table.clear(self._gridCellPool)
end

function LightGameView:_getGridCell(x, y)
	return self._gridCellMap[x][y]
end

function LightGameView:_updateGridCell(x, y)
	local cell = self:_getGridCell(x, y)

	GameUtil.SetActive(cell._mainGo, true)

	local gridType = self._lightGameMgr:getGridType(x, y)

	GameUtil.SetActive(cell._icon, gridType ~= LightGameMapMo.GridType.Empty)

	if gridType ~= LightGameMapMo.GridType.Empty then
		GameUtil.setUIGroupIdx(cell._mainGo, gridType)
	end

	if self:_isMarkedOfGridEff(x, y) then
		self:_loadGridTrunEff(x, y, cell._effRoot)
		self:_rmMarkGridEff(x, y)
	else
		self:_clearGridTrunEff(cell._effRoot)
	end

	GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickGridCell, self, x, y))
end

function LightGameView:_clearGridCell(cell)
	GameUtil.rmClickHandler(cell._mainGo)
	self:_clearGridTrunEff(cell._effRoot)
end

function LightGameView:_onClickGridCell(x, y)
	local result = self:_getTryNewStepResultAndTips(x, y)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local gridVecList = self._lightGameMgr:finfishPath(x, y)

	for _, vec in ipairs(gridVecList) do
		self:_addMarkGridEff(vec.x, vec.y, self._lightGameMgr:getGridType(vec.x, vec.y))
		self:_updateGridCell(vec.x, vec.y)
	end
end

function LightGameView:_getTryNewStepResultAndTips(x, y)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self._lightGameMgr:getCurState() ~= LightGameMgr.State.Runing then
		result = GameEnum.ResultCode.IsNil
	elseif self._lightGameMgr:getLeftStep() <= 0 then
		result = GameEnum.ResultCode.IsNil
	end

	return result, tips
end

function LightGameView:_popBuyTimesTips()
	if self._activityId < 0 then
		return
	end

	self:_stopGame()

	local curBuyTimes = self._lightGameMgr:getBuyTimes()
	local nextBuyTimes = curBuyTimes + 1
	local maxTimes = DuoLaLightConfig.instance:getMaxDlBuyTimes(self._activityId)
	local curLeftStep = self._lightGameMgr:getLeftStep()
	local curStep = self._lightGameMgr:getCurStep()
	local maxStep = self._lightGameMgr:getMaxStep()

	if maxTimes < nextBuyTimes then
		local text = "购买次数已达上限，无法进行购买，游戏将会进行重置。(注：购买次数所需的物资不会被扣款)"

		local function func()
			self:_resetGame()
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	else
		local data = DuoLaLightConfig.instance:getDlBuyData(self._activityId, nextBuyTimes)

		if data and not string.nilorempty(data.cost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)
			local matName = MaterialMgr.getMaterialsName(matType, matId)
			local iconContent = MaterialMgr.getContentMatCfg(matType, matId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
			local cosMatNum = 0
			local nextHasAddStep = 0
			local addStep = self:getAddStep(nextBuyTimes)
			local nextLeftStep = Mathf.Max(curStep + addStep - maxStep, 0)
			local cfg = DuoLaLightConfig.instance:getDlBuyCfg(self._activityId)

			for _, v in ipairs(cfg) do
				if nextBuyTimes >= v.times then
					local v1, v2, v3 = MaterialMgr.getMatParams(data.cost)

					cosMatNum = cosMatNum + checknumber(v3)
					nextHasAddStep = nextHasAddStep + self:getAddStep(v.times)
				end
			end

			local content = string.format("是否需要消耗%s%s增加%s步？增加后则剩余步数为%s。\n取消则游戏重新开始，物资不会被消耗。", cosMatNum, iconContent, nextHasAddStep, nextLeftStep)

			local function successCallBack(state)
				return
			end

			local toggleFunc, togTxt
			local alignment = UnityEngine.TextAnchor.MiddleCenter

			local function otherCallBack(state)
				if state == TipsFacade.STATE_CANCEL then
					self:_resetGame()
				elseif state == TipsFacade.STATE_OK then
					-- block empty
				elseif state == TipsFacade.STATE_FAIL then
					local text = string.format("%s不足，游戏将会重置", matName)

					local function func()
						self:_resetGame()
					end

					TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
				elseif state == TipsFacade.STATE_SUCCESS then
					self:_finfishStepAdd()
				end
			end

			local autoOpenSource

			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, cosMatNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
		else
			FloatWordMgr.instance:show("购买次数没有配置，自动重置游戏")
			self:_resetGame()
		end
	end
end

function LightGameView:_finfishStepAdd()
	FloatWordMgr.instance:show("步数增加成功")

	local nextBuyTimes = self._lightGameMgr:getBuyTimes() + 1

	self._lightGameMgr:setMaxStep(self._lightGameMgr:getMaxStep() + self:getAddStep(nextBuyTimes))
	self._lightGameMgr:setBuyTimes(nextBuyTimes)
	self:_continueGame()
end

function LightGameView:getAddStep(times)
	local addStep = 5

	if self._activityId > 0 then
		local data = DuoLaLightConfig.instance:getDlBuyData(self._activityId, times)

		addStep = data and data.addStep or addStep
	end

	return addStep
end

function LightGameView:_isMarkedOfGridEff(x, y)
	return self:_getMarkGridEffInfo(x, y) ~= nil
end

function LightGameView:_getMarkGridEffToGridType(x, y)
	local info = self:_getMarkGridEffInfo(x, y)

	return (info or nil) and (info.toGridType or LightGameMapMo.GridType.Empty)
end

function LightGameView:_getMarkGridEffInfo(x, y)
	if self._gridEffMarks then
		return self._gridEffMarks[self:_getMarkGridEffKey(x, y)]
	end
end

function LightGameView:_addMarkGridEff(x, y, toGridType)
	if self._gridEffMarks == nil then
		self._gridEffMarks = {}
	end

	self._gridEffMarks[self:_getMarkGridEffKey(x, y)] = {
		x = x,
		y = y,
		toGridType = toGridType
	}
end

function LightGameView:_rmMarkGridEff(x, y)
	if self._gridEffMarks then
		self._gridEffMarks[self:_getMarkGridEffKey(x, y)] = nil
	end
end

function LightGameView:_clearMarkGridEffs()
	if self._gridEffMarks then
		for k, v in pairs(self._gridEffMarks) do
			self._gridEffMarks[k] = nil
		end
	end
end

function LightGameView:_getMarkGridEffKey(x, y)
	return string.format("%s,%s", x, y)
end

function LightGameView:_loadGridTrunEff(x, y, mainGo)
	local effParent = mainGo
	local toGridType = self:_getMarkGridEffToGridType(x, y)
	local pathName = self:_getGridTrunEffPath(toGridType)

	self:_clearGridTrunEff(mainGo)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._gridTurnEffs == nil then
			self._gridTurnEffs = {}
		end

		self._gridTurnEffs[mainGo] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function LightGameView:_clearGridTrunEff(mainGo)
	if self._gridTurnEffs then
		UIEffectManager.instance:stopEffect(self._gridTurnEffs[mainGo])

		self._gridTurnEffs[mainGo] = nil
	end
end

function LightGameView:_clearAllGridTrunEff()
	if self._gridTurnEffs then
		for k, v in pairs(self._gridTurnEffs) do
			self:_clearGridTrunEff(k)
		end
	end
end

function LightGameView:_getGridTrunEffPath(toGridType)
	local path = ""

	if toGridType == LightGameMapMo.GridType.White then
		path = "20230630/shenyaoduolaxiaoyouxi/fx_ui_shenyaoduola_an_liang"
	elseif toGridType == LightGameMapMo.GridType.Black then
		path = "20230630/shenyaoduolaxiaoyouxi/fx_ui_shenyaoduola_liang_an"
	end

	return path
end

function LightGameView:_onClickBtnTip()
	local value = DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_MAIN_RULE_KEY", false)

	TipsFacade.instance:openRulesView(value)
end

function LightGameView:_onClickBtnClose()
	local tipsContent = "现在退出不会保存进度，是否确认退出？"

	local function okFunc()
		self:_reqEndGame()
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function LightGameView:_onClickBtnReset()
	self:_stopGame()

	local tipsContent = "就差一点点了，确认重置回初始状态吗？"

	local function okFunc()
		self:_resetGame()
	end

	local function cencelFunc()
		self:_continueGame()
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function LightGameView:_onClickBtnStartMask()
	self:_reqStartGame()
end

function LightGameView:_onUpdateTestCol()
	GameUtil.SetActive(self._testCol._mainGo, self._isTestMode)

	if not self._isTestMode then
		return
	end

	local comp = self._testCol._dropdownComp

	comp:RemoveOnValueChanged()
	comp:ClearOptions()
	comp:AddOnValueChanged(function(handler, value)
		if value > 0 then
			self._mapId = value

			self:_resetGame()
		end
	end, self)
	comp:AddOptions("选择地图")

	local cfg = DuoLaLightConfig.instance:getDlMapCfg()

	if cfg then
		for _, data in ipairs(cfg) do
			comp:AddOptions(data.mapId)
		end
	end

	comp:SetValue(self._mapId)
end

function LightGameView:_onClickBtnTest(idx)
	if idx == 1 then
		self:_resetGame()
	elseif idx == 2 then
		self:_continueGame()
	elseif idx == 3 then
		self:_stopGame()
	elseif idx == 4 then
		self:_endGame()
	elseif idx == 5 then
		self._lightGameMgr:setEditorMode(not self._lightGameMgr:isEditorMode())
	elseif idx == 6 then
		printError(self._lightGameMgr._lightGameMapMo:getCurMapBuildStr())
	end
end

return LightGameView
