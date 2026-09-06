-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/LightGameCopyView.lua

module("logic.extensions.duolalight.view.LightGameCopyView", package.seeall)

local LightGameCopyView = class("LightGameCopyView", ViewComponent)

function LightGameCopyView:buildUI()
	LightGameCopyView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
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
	self._txtLeftStep = goutil.findChildTextComponent(self.mainGO, "txtLeftStep/txt")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._startMask = goutil.findChild(self.mainGO, "startMask")
end

function LightGameCopyView:bindEvents()
	LightGameCopyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for idx, go in ipairs(self._btnTestList) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickBtnTest, self, idx))
	end

	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._startMask, self._onClickBtnStartMask, self)
end

function LightGameCopyView:unbindEvents()
	LightGameCopyView.super.unbindEvents(self)

	for idx, go in ipairs(self._btnTestList) do
		GameUtil.rmClickHandler(go)
	end

	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._startMask)
end

function LightGameCopyView:onEnter()
	LightGameCopyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._mapId = checknumber(params[1])
	self._finishCallBack = params[2]
	self._isTestMode = false

	if self._mapId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "出现错误,界面即将关闭", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	if self._lightGameMgr == nil then
		self._lightGameMgr = LightGameMgr.New()
	end

	self._lightGameMgr:onEnter()
	self:_resetGame()
	self.addGEvent(self, GlobalNotify.LightGameUpdateGameUI, self._onUpdatePlaneUI, self)
	self:_onSetUI()
	self:_onUpdateTestCol()
	GameUtil.SetActive(self._startMask, true)
	settimer(0, self._onTicking, self)
end

function LightGameCopyView:onExit()
	LightGameCopyView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearMapUI()

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

function LightGameCopyView:destroyUI()
	LightGameCopyView.super.destroyUI(self)

	if self._lightGameMgr then
		self._lightGameMgr:onDestroy()

		self._lightGameMgr = nil
	end
end

function LightGameCopyView:_onSetUI()
	local skinId = 16019

	self._role = skinId > 0 and RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil) or RoleObjectPool.instance:removeRole(self._role)
end

function LightGameCopyView:_reqStartGame()
	self:_handleGameStartGameReq()
end

function LightGameCopyView:_handleGameStartGameReq(status, msg)
	GameUtil.SetActive(self._startMask, false)
	self:_continueGame()
end

function LightGameCopyView:_reqEndGame()
	ViewBlockMgr.instance:blockClick(true, self)
	self:_handleGameEndGameReq()
end

function LightGameCopyView:_handleGameEndGameReq(status, msg)
	ViewBlockMgr.instance:blockClick(false, self)
	self:_popResultWin()
end

function LightGameCopyView:_popResultWin()
	local isPass = self._lightGameMgr:isPass()
	local text = isPass and "游戏胜利" or "游戏失败"

	local function func()
		local info = {}

		info.isPass = true
		info.gameScore = 1

		GameUtil.callBack(self._finishCallBack, info)
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function LightGameCopyView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime

	self._lightGameMgr:onTicking(self._deltaTime)

	self._state = self._lightGameMgr:getCurState()

	if self._state == LightGameMgr.State.Readying then
		-- block empty
	elseif self._state == LightGameMgr.State.Runing then
		if self._lightGameMgr:isPass() then
			self:_endGame()
		elseif self._lightGameMgr:getLeftStep() <= 0 then
			self:_popBuyTimesTips()
		end
	elseif self._state == LightGameMgr.State.Stoping then
		-- block empty
	elseif self._state == LightGameMgr.State.Ended then
		-- block empty
	end
end

function LightGameCopyView:_resetGame()
	self._lightGameMgr:resetGame(self._mapId)
	self:onResetMapUI()
	self:_onUpdatePlaneUI()
	GameUtil.SetActive(self._startMask, true)
end

function LightGameCopyView:_stopGame()
	self._lightGameMgr:stopGame()
end

function LightGameCopyView:_continueGame()
	self._lightGameMgr:continueGame()
end

function LightGameCopyView:_endGame()
	self._lightGameMgr:endGame()
	self:_reqEndGame()
end

function LightGameCopyView:_onUpdatePlaneUI()
	self._txtLeftStep.text = string.format("剩余步数：%s", self._lightGameMgr:getLeftStep())
end

function LightGameCopyView:onResetMapUI()
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

function LightGameCopyView:_onClearMapUI()
	if self._gridCellPool == nil then
		return
	end

	for _, cell in ipairs(self._gridCellPool) do
		self:_clearGridCell(cell)
	end

	table.clear(self._gridCellPool)
end

function LightGameCopyView:_getGridCell(x, y)
	return self._gridCellMap[x][y]
end

function LightGameCopyView:_updateGridCell(x, y)
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

function LightGameCopyView:_clearGridCell(cell)
	GameUtil.rmClickHandler(cell._mainGo)
	self:_clearGridTrunEff(cell._effRoot)
end

function LightGameCopyView:_onClickGridCell(x, y)
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

function LightGameCopyView:_getTryNewStepResultAndTips(x, y)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self._lightGameMgr:getCurState() ~= LightGameMgr.State.Runing then
		result = GameEnum.ResultCode.IsNil
	elseif self._lightGameMgr:getLeftStep() <= 0 then
		result = GameEnum.ResultCode.IsNil
	end

	return result, tips
end

function LightGameCopyView:_popBuyTimesTips()
	self:_stopGame()

	local function func()
		self:_resetGame()
	end

	TipsFacade.instance:openTipWindow("提示", "步数耗尽，重置挑战", func, "重置", UnityEngine.TextAnchor.MiddleCenter)
	self:_resetGame()
end

function LightGameCopyView:_isMarkedOfGridEff(x, y)
	return self:_getMarkGridEffInfo(x, y) ~= nil
end

function LightGameCopyView:_getMarkGridEffToGridType(x, y)
	local info = self:_getMarkGridEffInfo(x, y)

	return (info or nil) and (info.toGridType or LightGameMapMo.GridType.Empty)
end

function LightGameCopyView:_getMarkGridEffInfo(x, y)
	if self._gridEffMarks then
		return self._gridEffMarks[self:_getMarkGridEffKey(x, y)]
	end
end

function LightGameCopyView:_addMarkGridEff(x, y, toGridType)
	if self._gridEffMarks == nil then
		self._gridEffMarks = {}
	end

	self._gridEffMarks[self:_getMarkGridEffKey(x, y)] = {
		x = x,
		y = y,
		toGridType = toGridType
	}
end

function LightGameCopyView:_rmMarkGridEff(x, y)
	if self._gridEffMarks then
		self._gridEffMarks[self:_getMarkGridEffKey(x, y)] = nil
	end
end

function LightGameCopyView:_clearMarkGridEffs()
	if self._gridEffMarks then
		for k, v in pairs(self._gridEffMarks) do
			self._gridEffMarks[k] = nil
		end
	end
end

function LightGameCopyView:_getMarkGridEffKey(x, y)
	return string.format("%s,%s", x, y)
end

function LightGameCopyView:_loadGridTrunEff(x, y, mainGo)
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

function LightGameCopyView:_clearGridTrunEff(mainGo)
	if self._gridTurnEffs then
		UIEffectManager.instance:stopEffect(self._gridTurnEffs[mainGo])

		self._gridTurnEffs[mainGo] = nil
	end
end

function LightGameCopyView:_clearAllGridTrunEff()
	if self._gridTurnEffs then
		for k, v in pairs(self._gridTurnEffs) do
			self:_clearGridTrunEff(k)
		end
	end
end

function LightGameCopyView:_getGridTrunEffPath(toGridType)
	local path = ""

	if toGridType == LightGameMapMo.GridType.White then
		path = "20230630/shenyaoduolaxiaoyouxi/fx_ui_shenyaoduola_an_liang"
	elseif toGridType == LightGameMapMo.GridType.Black then
		path = "20230630/shenyaoduolaxiaoyouxi/fx_ui_shenyaoduola_liang_an"
	end

	return path
end

function LightGameCopyView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("duola_game_rule")
end

function LightGameCopyView:_onClickBtnClose()
	local tipsContent = "现在退出不会保存进度，是否确认退出？"

	local function okFunc()
		local info = {}

		info.isPass = false
		info.gameScore = 0

		GameUtil.callBack(self._finishCallBack, info)
		self:close()
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function LightGameCopyView:_onClickBtnReset()
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

function LightGameCopyView:_onClickBtnStartMask()
	self:_reqStartGame()
end

function LightGameCopyView:_onUpdateTestCol()
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

function LightGameCopyView:_onClickBtnTest(idx)
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

return LightGameCopyView
