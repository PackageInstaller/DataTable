-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpMapView.lua

module("logic.extensions.expedition.view.ExpMapView", package.seeall)

local ExpMapView = class("ExpMapView", ViewComponent)
local compSpriteChange = typeof(UIImageSpriteChange)
local yPosOffset = -80

function ExpMapView:unbindEvents()
	ExpMapView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnPet:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnRules:RemoveClickListener()
	self._btnUseHeart:RemoveClickListener()
	self._btnExplainCustomInput:RemoveListener()
	self._btnGridMapToEvent:RemoveClickListener()
	self._btnEventToGridMap:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
end

function ExpMapView:bindEvents()
	ExpMapView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._btnPet:AddClickListener(self._onClickPet, self)
	self._btnShop:AddClickListener(self._onClicShop, self)
	self._btnRules:AddClickListener(self._onClickRules, self)
	self._btnUseHeart:AddClickListener(self._onClickUseHeart, self)
	self._btnExplainCustomInput:AddListener(self._onClickExplain, self)
	self._btnGridMapToEvent:AddClickListener(self._onClickGridMapToEvent, self)
	self._btnEventToGridMap:AddClickListener(self._onClickEventToGridMap, self)
	self._btnSweep:AddClickListener(self._onClickBtnSweep, self)
end

function ExpMapView:onExit()
	removetimer(self._delayRequestExpedData, self)
	removetimer(self._checkShowFinish, self)

	self._isShakingGrid = nil
	self._lastSelectGrid = nil
	self._isOpeningView = nil

	self:_recyleAllGrids()
	MaterialMgr.resetAll(self._sweepGridHead)

	if self._restartEffects then
		for k, v in pairs(self._restartEffects) do
			goutil.destroy(v)
		end

		self._restartEffects = nil
	end

	if self._restartEffectRes then
		for k, v in pairs(self._restartEffectRes) do
			v:Release()
		end

		self._restartEffectRes = nil
	end

	TaskController.instance:resume()
	removetimer(self._updateRefresh, self)
	ExpMapView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnExpeditionWeeklyInfo, self._onExpeditionWeeklyInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
	GlobalDispatcher:removeListener(GlobalNotify.OnExpedSelectGrid, self._onExpedSelectGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetExpeditionInfo, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMapUpdate, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnExeExpMapEvent, self._onExeExpMapEvent, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnExpedSweepLevel, self._onExpedSweepLevel, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	removetimer(self._updateActivityTipState, self)
	UIEffectManager.instance:stopEffect(self._currSelectEff)
end

function ExpMapView:buildUI()
	ExpMapView.super.buildUI(self)

	self._closeButton = self:getBtn("lefttop/btn_back")
	self._refreshTimeNode = self:getGo("righttop/RefreshTimeNode")
	self._refreshTime = self:getTxt("righttop/RefreshTimeNode/RefreshTime")

	local rightbottom = goutil.findChild(self.mainGO, "rightbottom")

	self._btnBuff = Framework.ButtonAdapter.GetFrom(rightbottom, "btnBuff")
	self._btnPet = Framework.ButtonAdapter.GetFrom(rightbottom, "btnPet")
	self._btnShop = Framework.ButtonAdapter.GetFrom(rightbottom, "btnShop")
	self._btnRules = self:getBtn("lefttop/btn_tip")
	self._btnHome = self:getBtn("lefttop/btn_home")
	self._doubleRewardTip = self:getGo("doubleRewardTip")

	self._doubleRewardTip:SetActive(false)

	self._tip = self:getGo("doubleRewardTip/tip")
	self._btnExplainCustomInput = UICustomInput.Get(self:getGo("doubleRewardTip/btnExplain"))
	self._txtTime = self:getTxt("doubleRewardTip/bg/txtTime")
	self._tipsTxt = self:getTxt("doubleRewardTip/bg/tipsTxt")
	self._txtDesc = self:getTxt("doubleRewardTip/bg/txt")
	self._newHandDoubleRewardTip = self:getGo("newHandDoubleRewardTip")

	self._newHandDoubleRewardTip:SetActive(false)

	self._txtTipsNewHand = self:getTxt("newHandDoubleRewardTip/txtTips")
	self._txtTimeNewHand = self:getTxt("newHandDoubleRewardTip/txtTime")
	self._txtDescNewHand = self:getTxt("newHandDoubleRewardTip/txtDesc")

	self:_initEventsView()
	self:_initGridmapsView()
	self._eventsNode:SetActive(false)
	self:_initSweepNode()
end

function ExpMapView:_initEventsView()
	self._eventsNode = self:getGo("eventsView")
	self._finishAllTips = self:getGo("eventsView/FinishAllTips")

	self._finishAllTips:SetActive(false)

	self._cloneGrid = self:getGo("eventsView/center/sv/Viewport/Content/grid")

	self._cloneGrid:SetActive(false)

	self._gridPool = {}
	self._gridList = {}
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "eventsView/righttop/TxtLvNode/txtLevel")
	self._teamView = goutil.findChildComponent(self.mainGO, "eventsView/center/sv", "ScrollRect")
	self._teamViewContent = goutil.findChild(self.mainGO, "eventsView/center/sv/Viewport/Content").transform
	self._teamVPSizeWidth = goutil.findChild(self.mainGO, "eventsView/center/sv/Viewport").transform.rect.width
	self._teamVPSizeHeight = goutil.findChild(self.mainGO, "eventsView/center/sv/Viewport").transform.rect.height
	self._btnEventToGridMap = self:getBtn("eventsView/leftbottom/btnMapView")
	self._btnSweep = self:getBtn("eventsView/leftbottom/btnSweep")
	self._sweepTips = self:getTxt("eventsView/sweepTips")
end

function ExpMapView:_initGridmapsView()
	self._gridMapViewNode = self:getGo("gridMapView")
	self._txtHeartNum = goutil.findChildTextComponent(self.mainGO, "gridMapView/reviveItem/heart/Num")
	self._btnUseHeart = self:getBtn("gridMapView/reviveItem/heart/btnUse")
	self._btnGridMapToEvent = self:getBtn("gridMapView/leftbottom/btnEventView")
end

function ExpMapView:_initSweepNode()
	self._sweepNode = self:getGo("sweepNode")
	self._sweepGrid = self:getGo("eventsView/center/sv/Viewport/Content/sweepGrid")
	self._sweepGridHead = self:getGo("eventsView/center/sv/Viewport/Content/sweepGrid/Head/mask/img_head")

	self._sweepGrid:SetActive(false)
	self._sweepNode:SetActive(false)
end

function ExpMapView:onEnter()
	self._eventsNode:SetActive(true)
	self._btnEventToGridMap.gameObject:SetActive(false)

	self._isInGridMapView = ExpeditionTilingModel.instance:isInTilingMapScene()
	self._targetsView = self._viewPresentor:getViewByName("ExpedLevelTargetsView")
	self._clearRestartEff = false

	ExpMapView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnExpeditionWeeklyInfo, self._onExpeditionWeeklyInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.OnExpedSelectGrid, self._onExpedSelectGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetExpeditionInfo, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMapUpdate, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnExeExpMapEvent, self._onExeExpMapEvent, self)
	GlobalDispatcher:addListener(GlobalNotify.OnExpedSweepLevel, self._onExpedSweepLevel, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	self.addGEvent(self, GlobalNotify.OnExpedOneKeySweep, self._onOneKeySweep, self)
	self._finishAllTips:SetActive(false)

	self._hasReset = nil
	self._isOpeningView = true

	UIStateManager.instance:updateParms(self._viewPresentor.viewName, nil)
	settimer(1, self._updateRefresh, self)
	self:_refreshRefreshCD()

	if not ExpeditionModel.instance:isInfoValid() then
		self._btnEventToGridMap.gameObject:SetActive(false)
		self._btnGridMapToEvent.gameObject:SetActive(false)

		self._isWaittingData = true

		settimer(0, self._delayRequestExpedData, self, false)
	else
		self:_refresh()

		self._isWaittingData = nil
	end

	self:_initActivityTipState()
	self:_setupSweepNode()
end

function ExpMapView:_setupSweepNode()
	HeadItemController.instance:setMyHeadCell(self._sweepGridHead)
	self._sweepNode:SetActive(false)
	self._sweepGrid:SetActive(false)
end

function ExpMapView:_delayRequestExpedData()
	removetimer(self._delayRequestExpedData, self)
	ExpeditionController.instance:sendGetWeekCanPlayInfo()
end

function ExpMapView:_refresh()
	self._isWaittingData = false
	self._hasReset = nil
	self._lastSelectGrid = nil

	removetimer(self._checkShowFinish, self)
	self:_setupHearNum()

	if self._isInGridMapView then
		self._btnSweep.gameObject:SetActive(false)
		GlobalModel.instance:visibleMainCamera(true)
		self._btnGridMapToEvent.gameObject:SetActive(true)
		self._eventsNode:SetActive(false)
		self._targetsView:updateTargets()
	else
		GlobalModel.instance:visibleMainCamera(false)
		self._eventsNode:SetActive(true)
		self:_setupMap()

		local info = ExpeditionModel.instance:getInfo()
		local nextLevelCo = ExpeditionConfig.instance:getNextLevelCo(info.level + 1)

		self._txtTitle.text = nextLevelCo.levelName

		self._btnSweep.gameObject:SetActive(ExpeditionSweepModel.instance:isLevelSweepable())

		if not ExpeditionController.instance:checkSweepEvents() and not ExpeditionController.instance:checkPopSweep(info.level + 1) then
			self:showAutoBuffViwe()
		end
	end

	self:_refreshRefreshCD()

	if not self._isInGridMapView then
		settimer(0.2, self._checkShowFinish, self)
	end
end

function ExpMapView:_onMatChange()
	self:_setupHearNum()
end

function ExpMapView:_refreshRefreshCD()
	local info = ExpeditionModel.instance:getInfo()

	if not info or not info.endTime or info.endTime == 0 then
		if self._refreshTimeNode.activeSelf then
			self._refreshTimeNode:SetActive(false)
		end
	else
		if not self._refreshTimeNode.activeSelf then
			self._refreshTimeNode:SetActive(true)
		end

		local leftTime = math.floor(math.max(0, (info.endTime - ServerTime.nowMs()) * 0.001))

		if leftTime <= 0 then
			self._refreshTime.text = "刷新中，请稍后..."
		else
			local hour, min, sec = GameUtil.getTimeHHMMSS(math.ceil(leftTime))
			local timeStr = string.format("%02d:%02d:%02d", hour, min, sec)

			self._refreshTime.text = string.format(lang("text_refreshtime"), timeStr)
		end
	end
end

function ExpMapView:_updateRefresh()
	self:_refreshRefreshCD()
end

function ExpMapView:_onExpeditionWeeklyInfo()
	ExpeditionController.instance:resetSweepsInfo()
	ExpeditionController.instance:leaveGridMap()

	if ExpeditionController.instance.canPlay then
		ExpeditionAgent.instance:sendPM_ExpeditionGetInfoReq()
	else
		self:_onClickClose()
	end
end

function ExpMapView:_setupHearNum()
	local itemNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, ExpeditionConfig.ReviveItemId)

	self._txtHeartNum.text = "x" .. itemNum
end

function ExpMapView:_setupMap()
	self:_recyleAllGrids()

	self._lastSelectGrid = nil

	local gridList = ExpeditionModel.instance:getGridList()

	UIEffectManager.instance:stopEffect(self._currSelectEff)

	for k, v in ipairs(gridList) do
		self:_setupGrid(v)
	end

	self:_sortGrids()
	self:_setupPositions()
	self:_checkShowAllFinishTips()
end

function ExpMapView:_checkShowAllFinishTips()
	local info = ExpeditionModel.instance:getInfo()
	local mapCos = ExpeditionConfig.instance:getExpeditionMapCo(info.level + 1)
	local isMaxLv = ExpeditionModel.instance:isMaxLevel(info.level + 1)
	local isAllFinished = isMaxLv and info.xAxis >= #mapCos

	self._finishAllTips:SetActive(isAllFinished)
	self._sweepTips.gameObject:SetActive(not isAllFinished)
end

function ExpMapView:_setUpRestartGrid(restartGrid)
	local info = ExpeditionModel.instance:getInfo()
	local isMaxLv = ExpeditionModel.instance:isMaxLevel(info.level + 1)
	local lastXAxis = restartGrid.xAxis - 1

	restartGrid.go:SetActive(true)
	restartGrid.icon.gameObject:SetActive(false)

	if not isMaxLv and info.xAxis == lastXAxis then
		restartGrid.btn:AddClickListener(function()
			if ExpeditionController.instance:checkSweepEvents() then
				return
			end

			local nextLevelCo = ExpeditionConfig.instance:getNextLevelCo(info.level + 1)

			if not ExpeditionModel.instance:isNeededSelectNextLevel() then
				ExpeditionAgent.instance:sendPM_ExpeditionNextLevelReq(restartGrid.nextLevelId - 1)

				return
			end

			ViewMgr.instance:open(ViewName.ExpSelNextLevel, restartGrid.eventIndex, restartGrid.nextLevelId - 1)
		end)
		self:_playRestartEffect(restartGrid)

		local px, py, pz = Framework.TransformUtil.GetLocalPos(restartGrid.go.transform, nil, nil, nil)

		Framework.TransformUtil.SetLocalPos(restartGrid.go.transform, px, py + yPosOffset, pz)
		self:_setNodeState(restartGrid, true, false, false)
	end
end

function ExpMapView:_playRestartEffect(restartGrid)
	self._clearRestartEff = false

	if restartGrid.gridData.gridType ~= ExpeditionModel.GridType.END then
		return
	end

	local resPath
	local index = restartGrid.eventIndex + 1

	resPath = (not ExpeditionModel.instance:isNeededSelectNextLevel() or index == 2) and "effect/prefabs/ui/fx_ui_shiluoyiji/fx_ui_chuansongmen_lan_shiluoyiji.prefab" or "effect/prefabs/ui/fx_ui_shiluoyiji/fx_ui_chuansongmen_hong_shiluoyiji.prefab"

	if self._restartEffects and self._restartEffects[resPath] then
		self._restartEffects[resPath]:SetActive(true)
		self:_updateRestartEffect(self._restartEffects[resPath], restartGrid.go)

		return
	end

	if self._restartEffectRes and self._restartEffectRes[resPath] then
		local prefab = self._restartEffectRes[resPath]:GetMainAsset()
		local restartEffect = goutil.clone(prefab)

		self:_updateRestartEffect(restartEffect, restartGrid.go)

		self._restartEffects = self._restartEffects or {}
		self._restartEffects[resPath] = restartEffect
	else
		getres(resPath, function(res)
			if not self._isOpeningView then
				return
			end

			self._restartEffectRes = self._restartEffectRes or {}

			if self._restartEffectRes[resPath] then
				return
			end

			self._restartEffectRes[resPath] = res

			res:Retain()

			if self._clearRestartEff then
				return
			end

			self:_playRestartEffect(restartGrid)
		end)
	end
end

function ExpMapView:_updateRestartEffect(restartEffect, parent)
	restartEffect.transform:SetParent(parent.transform)
	Framework.TransformUtil.SetLocalPos(restartEffect.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(restartEffect.transform, 1, 1, 1)
	GoUtil.SetSortingOrder(restartEffect, 230)
	Framework.GameObjectUtil.SetLayerRecursively(restartEffect, SceneLayer.UI_Value)
end

function ExpMapView:_sortGrids()
	table.sort(self._gridList, function(x, y)
		if x == y then
			return false
		end

		if x.yAxis < y.yAxis then
			return false
		end

		if x.yAxis > y.yAxis then
			return true
		end

		if x.xAxis > y.xAxis then
			return false
		end

		if x.xAxis < y.xAxis then
			return true
		end

		return false
	end)

	for i = 1, #self._gridList do
		self._gridList[i].go.transform:SetSiblingIndex(i - 1)
	end
end

function ExpMapView:_setupPositions()
	local minX = 99999
	local maxX = -99999
	local minY = 99999
	local maxY = -99999

	for i = 1, #self._gridList do
		local gridData = self._gridList[i]

		if minX > gridData.xAxis then
			minX = gridData.xAxis
		end

		if maxX < gridData.xAxis then
			maxX = gridData.xAxis
		end

		if minY > gridData.yAxis then
			minY = gridData.yAxis
		end

		if maxY < gridData.yAxis then
			maxY = gridData.yAxis
		end
	end

	local xDelta = maxX - minX + 1
	local yDelta = maxY - minY + 1
	local posDeltaX = 123
	local posDeltaY = 70
	local startX = self:_getStartPosition(xDelta, posDeltaX)
	local startY = 0

	for i = 1, #self._gridList do
		local gridData = self._gridList[i]
		local x = startX + gridData.xAxis * posDeltaX
		local y = startY + gridData.yAxis * posDeltaY

		Framework.TransformUtil.SetLocalPos(gridData.go.transform, x, y + yPosOffset, 0)
	end

	self:_calculateViewSize(startX, startY, xDelta, yDelta, posDeltaX, posDeltaY, maxX)
end

function ExpMapView:_calculateViewSize(startX, startY, xDelta, yDelta, posDeltaX, posDeltaY, maxX)
	local teamView = self._teamView
	local teamViewContent = self._teamViewContent
	local teamVPWidth = self._teamVPSizeWidth
	local teamVPHeight = self._teamVPSizeHeight
	local xMargin = 300
	local yMargin = 100
	local contentSizeWidth = xDelta * posDeltaX + xMargin
	local contentSizeHeight = yDelta * posDeltaY + yMargin
	local sizeDelta = teamViewContent.sizeDelta
	local info = ExpeditionModel.instance:getInfo()

	sizeDelta.x = contentSizeWidth
	sizeDelta.y = contentSizeHeight

	local currX = startX + info.xAxis * posDeltaX

	teamViewContent.sizeDelta = sizeDelta

	if contentSizeWidth <= teamVPWidth and contentSizeHeight <= teamVPHeight then
		teamView.enabled = false

		Framework.TransformUtil.SetAnchoredPos(teamViewContent, 0, 0)
	elseif teamVPWidth < contentSizeWidth and teamVPHeight < contentSizeHeight then
		teamView.enabled = true
		teamView.horizontal = true
		teamView.vertical = true

		Framework.TransformUtil.SetAnchoredPos(teamViewContent, -currX, 0)
	elseif contentSizeWidth <= teamVPWidth then
		teamView.enabled = true
		teamView.horizontal = false
		teamView.vertical = true

		Framework.TransformUtil.SetAnchoredPos(teamViewContent, 0, 0)
	else
		teamView.enabled = true
		teamView.horizontal = true
		teamView.vertical = false

		Framework.TransformUtil.SetAnchoredPos(teamViewContent, -currX, 0)
	end
end

function ExpMapView:_getStartPosition(count, delta)
	local mod = count % 2
	local half = math.floor(count / 2)
	local startPos = 0

	if mod == 0 then
		half = half - 1
		startPos = -half * delta - 0.5 * delta
	else
		startPos = -half * delta
	end

	return startPos
end

function ExpMapView:_setupGrid(gridData)
	local grid = self:_getOneGrid()

	table.insert(self._gridList, grid)

	grid.gridData = gridData

	self:_fillGrid(grid)

	return grid
end

function ExpMapView:_fillGrid(grid)
	local gridData = grid.gridData

	grid.xAxis = gridData.xAxis
	grid.yAxis = gridData.yAxis
	grid.nextLevelId = gridData.nextLevelId
	grid.eventIndex = gridData.eventIndex
	grid.go.name = gridData.xAxis .. "_" .. gridData.yAxis

	grid.btn:RemoveClickListener()
	grid.go:SetActive(true)

	if gridData.gridType == ExpeditionModel.GridType.END then
		self:_setUpRestartGrid(grid)

		return grid
	end

	if gridData.gridType ~= ExpeditionModel.GridType.START then
		local cfg = ExpeditionConfig.instance:getMapGripTypeCfg(gridData.eventId)

		grid.icon:ChangeSprite(cfg.eventPic)
		grid.icon.gameObject:SetActive(true)
	end

	local info = ExpeditionModel.instance:getInfo()
	local needMask = false
	local sight = ExpeditionConfig.instance:getMaxSight()

	HeadItemController.instance:setMyHeadCell(grid.iconHead)

	local canOpen = false
	local canDo = false

	if info.xAxis == gridData.xAxis and info.yAxis == gridData.yAxis then
		self:_setNodeState(grid, false, true, true)
	elseif gridData.xAxis <= info.xAxis then
		if ExpeditionModel.instance:isHistoricalPath(gridData.xAxis, gridData.eventIndex) then
			self:_setNodeState(grid, false, true, false)
		else
			self:_setNodeState(grid, false, false, false)
		end
	elseif gridData.xAxis <= info.xAxis + sight or not needMask then
		canOpen = true

		self:_setNodeState(grid, true, false, false)

		if info.xAxis + 1 == gridData.xAxis then
			local hasSel = ExpeditionTilingModel.instance:hasGetTilingMapInfos()

			if hasSel then
				if info.nextYAixs == gridData.yAxis and info.nextXAixs == gridData.xAxis then
					canDo = true
				else
					self:_setNodeState(grid, false, false, false)

					canOpen = false
				end
			elseif info.yAxis + 1 == gridData.yAxis or info.yAxis - 1 == gridData.yAxis or info.yAxis == gridData.yAxis then
				canDo = true
			end
		end
	else
		self:_setNodeState(grid, false, true, false)
	end

	if gridData.xAxis + gridData.yAxis > 0 and ExpeditionTilingModel.instance:isTilingMapValid(gridData.xAxis, gridData.yAxis, gridData.eventIndex) then
		local effResPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self._currSelectEff = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(grid.go.gameObject.transform)
			GameUtil.setAnchoredPos(eff.effGo, 0, 0)
			GameUtil.setLocalScale(eff.effGo, 1, 1, 1)
			eff:setScrollRectClipping(self:getGo("eventsView/center/sv"):GetComponent(typeof(UnityEngine.UI.ScrollRect)))
		end)
	end

	if canOpen then
		grid.btn:AddClickListener(function()
			if self._isShakingGrid then
				return
			end

			self._lastSelectGrid = grid

			self:_openEventView(gridData, canDo)
		end, self)
	end
end

function ExpMapView:_clearGrid(grid)
	grid.btn:RemoveClickListener()
	self:_setNodeState(grid, false, true, false)
end

function ExpMapView:_setNodeState(grid, open, unopen, head)
	grid.openNode:SetActive(open)
	grid.unOpenNode:SetActive(unopen)
	grid.headNode:SetActive(head)
end

function ExpMapView:_openEventView(gridData, canDo)
	if self._isWaittingData then
		return
	end

	ExpeditionModel.instance.needShowFinish = true

	if ExpeditionTilingModel.instance:isTilingMapValid(gridData.xAxis, gridData.yAxis, gridData.eventIndex) then
		self:_goDoEvent()
	else
		UIStateManager.instance:open(ViewName.ExpMapEvent, gridData, canDo)
	end
end

function ExpMapView:_goDoEvent()
	local gridData = self:getCurGridData()

	if gridData == nil then
		ExpeditionController.instance:leaveGridMap()

		if ExpeditionModel.instance.isGridDone then
			ExpeditionModel.instance.isGridDone = nil

			TipsFacade.instance:openCommonTips(lang("请继续探索吧"))
		end
	else
		ExpeditionController.instance:showEventViewByData(gridData)
	end
end

function ExpMapView:getCurGridData()
	local mapData = ExpeditionTilingModel.instance:getTilingMapInfos()
	local evtId, count = ExpeditionTilingModel.instance:getCurEventId()

	if evtId == -1 then
		return nil
	else
		local gridData

		for k, v in pairs(mapData.gridList or {}) do
			local eventId

			if v.eventId and not ExpeditionModel.instance:isEventCompeleted(v.eventId, v.progress) and evtId == v.eventId then
				return v
			end
		end

		return nil
	end
end

function ExpMapView:showAutoBuffViwe()
	local gridData = self:getCurGridData()

	if gridData then
		local id = gridData.eventId
		local viewName

		if id == ExpeditionModel.EventType.FIGHT then
			if ExpeditionController.instance:isBattleBuffEvent(gridData) then
				self:_goDoEvent()
			end
		elseif id == ExpeditionModel.EventType.BUFF then
			self:_goDoEvent()
		end
	else
		self:_goDoEvent()
	end
end

function ExpMapView:_checkShowFinish()
	removetimer(self._checkShowFinish, self)

	if not ExpeditionModel.instance.needShowFinish then
		return
	end

	if ExpeditionModel.instance:isAllFinished() then
		ExpeditionModel.instance.needShowFinish = nil

		ViewMgr.instance:open(ViewName.ExpAllPassView)
	end
end

function ExpMapView:_onExeExpMapEvent(gridData, hanlderFunc)
	local needShaked = not ExpeditionTilingModel.instance:hasGetTilingMapInfos()

	if self._lastSelectGrid and needShaked then
		self:_startSelectGrid(self._lastSelectGrid, gridData, hanlderFunc)
	elseif hanlderFunc then
		hanlderFunc()
	end
end

function ExpMapView:_onOneKeySweep(msg)
	self:_goPlayCurrSweep()
end

function ExpMapView:_goPlayCurrSweep()
	local footPrints = ExpeditionModel.instance:doAndGetCurrOneKeySweepData()

	if footPrints ~= nil then
		self:_setupMap()

		local info = ExpeditionModel.instance:getInfo()
		local nextLevelCo = ExpeditionConfig.instance:getNextLevelCo(info.level + 1)

		self._txtTitle.text = nextLevelCo.levelName

		self:_goPlayCurrSweep()
	else
		ExpeditionModel.instance:oneKeySweepJumpToLastPoint()
		self:_refresh()
		ExpeditionController.instance:checkOneKeySweepEnd()
	end
end

function ExpMapView:_onExpedSweepLevel(msg)
	self:_onPlayExpedSweepLevel(msg.footPrints, function()
		self:_refresh()
	end)
end

function ExpMapView:_onPlayExpedSweepLevel(footPrints, callBack)
	local info = ExpeditionModel.instance:getInfo()
	local currxAxis = 0
	local mapCos = ExpeditionConfig.instance:getExpeditionMapCo(info.level + 1)
	local sweepPath = {}

	for i = currxAxis, #mapCos do
		if not footPrints[i] then
			local evtIndex = 0
			local yAxis = ExpeditionModel.instance:getYAxisByGridIndex(i, evtIndex)

			table.insert(sweepPath, {
				xAxis = i,
				yAxis = yAxis
			})
		end
	end

	self._btnSweep.gameObject:SetActive(false)
	self._sweepNode:SetActive(true)
	self._sweepGrid:SetActive(true)
	UnityTweens.TweenBase.DestroyAll(self._sweepGrid)
	self._sweepGrid.transform:SetAsLastSibling()

	local width = self._teamVPSizeWidth
	local cwidth = goutil.findChild(self.mainGO, "eventsView/center/sv/Viewport/Content").transform.rect.width
	local hcw = cwidth * 0.5
	local vector3Start = Vector3.New()
	local vector3End = Vector3.New()
	local delay = 0
	local pathCount = #sweepPath - 1

	for i = 1, pathCount do
		local sGrid = self:_getGrid(sweepPath[i].xAxis, sweepPath[i].yAxis)
		local dGrid = self:_getGrid(sweepPath[i + 1].xAxis, sweepPath[i + 1].yAxis)

		if sGrid == nil or dGrid == nil then
			break
		end

		local sx, sy, sz = Framework.TransformUtil.GetLocalPos(sGrid.go.transform, 0, 0, 0)
		local ex, ey, ez = Framework.TransformUtil.GetLocalPos(dGrid.go.transform, 0, 0, 0)

		vector3Start.x = sx
		vector3Start.y = sy
		vector3Start.z = sz
		vector3End.x = ex
		vector3End.y = ey
		vector3End.z = ez

		local idx = i

		if idx == 1 then
			self:_clearGrid(sGrid)
		end

		local tweenPos = UnityTweens.TweenPosition.Create(self._sweepGrid, vector3Start, vector3End, 0.3, UnityTweens.EaseType.linear, delay)

		if idx == pathCount then
			tweenPos:AddListener(function()
				self._teamView.horizontalNormalizedPosition = Mathf.Clamp01((hcw + ex - width * 0.5) / width)

				self:_fillGrid(dGrid)
				self:_startSelectGrid(dGrid, nil, function()
					self._sweepNode:SetActive(false)
					self._sweepGrid:SetActive(false)
					GameUtil.callBack(callBack)
				end)
			end)
		else
			tweenPos:AddListener(function()
				self._teamView.horizontalNormalizedPosition = Mathf.Clamp01((hcw + ex - width * 0.5) / width)

				self:_clearGrid(dGrid)
				self:_startSelectGrid(dGrid)
			end)
		end

		local shakeTime = 0.1

		if self:_needShakeGrid(sweepPath[i + 1].xAxis, sweepPath[i + 1].yAxis) then
			shakeTime = shakeTime + 0.2
		end

		delay = delay + 0.3 + shakeTime
	end
end

function ExpMapView:_onViewClose(view)
	if view.viewName ~= ViewName.ItemGet or ExpeditionTilingModel.instance:isInTilingMapScene() then
		return
	end

	local topView = GlobalModel.instance:getTopView()

	if topView and topView.viewName == ViewName.ExpMap then
		ExpeditionModel.instance.needShowFinish = true

		ExpeditionController.instance:checkSweepEvents()
		self:_checkShowFinish()
	end
end

function ExpMapView:_getGrid(xAxis, yAxis)
	for i = 1, #self._gridList do
		if self._gridList[i].xAxis == xAxis and self._gridList[i].yAxis == yAxis then
			return self._gridList[i]
		end
	end
end

function ExpMapView:_needShakeGrid(xAxis, yAxis)
	for i = 1, #self._gridList do
		local g = self._gridList[i]

		if g.xAxis == g.xAxis and g.yAxis ~= yAxis then
			return true
		end
	end

	return false
end

function ExpMapView:_startSelectGrid(grid, gridData, hanlderFunc)
	self._isShakingGrid = true

	local hasGrid, hasSetCallback

	for i = 1, #self._gridList do
		local g = self._gridList[i]

		if g ~= grid and grid.xAxis == g.xAxis then
			hasGrid = true

			local shake = UnityTweens.UITweenShake.StartTween(g.go, Vector3.New(5, 5, 5), 0.01, 0.4)

			shake:AddListener(function()
				local pos = g.go.transform.localPosition
				local destPos = Vector3.New(pos.x, pos.y - 100, 0)

				UnityTweens.TweenPosition.StartTween(g.go, pos, destPos, 0.2)

				local scale = UnityTweens.TweenScale.StartTween(g.go, Vector3.New(1, 1, 1), Vector3.New(0, 0, 0), 0.2)

				if not hasSetCallback then
					hasSetCallback = true

					scale:AddListener(function()
						self._isShakingGrid = nil

						if hanlderFunc then
							hanlderFunc()
						end
					end, nil)
				end
			end, nil)
		end
	end

	if not hasGrid then
		self._isShakingGrid = nil

		if hanlderFunc then
			hanlderFunc()
		end
	end
end

function ExpMapView:_getOneGrid()
	local len = #self._gridPool
	local grid

	if len > 0 then
		grid = self._gridPool[len]
		self._gridPool[len] = nil
	else
		grid = {}

		local gridGo = goutil.cloneAndSetParent(self._cloneGrid, self._teamViewContent.transform)

		grid.go = gridGo
		grid.openNode = goutil.findChild(gridGo, "Open")
		grid.unOpenNode = goutil.findChild(gridGo, "UnOpen")
		grid.headNode = goutil.findChild(gridGo, "Head")
		grid.icon = goutil.findChild(gridGo, "Open/Icon"):GetComponent(compSpriteChange)
		grid.iconHead = goutil.findChild(gridGo, "Head/mask/img_head")
		grid.btn = Framework.ButtonAdapter.GetFrom(grid.go, "Btn")
	end

	UnityTweens.UITweenShake.StopTween(grid.go)
	UnityTweens.TweenScale.StopTween(grid.go)
	UnityTweens.TweenPosition.StopTween(grid.go)
	Framework.TransformUtil.SetLocalScale(grid.go.transform, 1.1, 1.1, 1.1)

	return grid
end

function ExpMapView:_recyleAllGrids()
	if self._restartEffects then
		for k, v in pairs(self._restartEffects) do
			v:SetActive(false)
		end
	end

	for i = 1, #self._gridList do
		local grid = self._gridList[i]
		local tweenShake = grid.go:GetComponent(UnityTweensType.UITweenShake)
		local tweenScale = grid.go:GetComponent(UnityTweensType.TweenScale)

		if tweenShake then
			tweenShake:RemoveListener()
		end

		if tweenScale then
			tweenScale:RemoveListener()
		end

		MaterialMgr.resetAll(grid.iconHead)
		grid.go:SetActive(false)
		table.insert(self._gridPool, grid)
	end

	self._clearRestartEff = true
	self._gridList = {}
end

function ExpMapView:_onClicShop()
	GotoMgr.gotoByString("func#470#ExchangeLostRuins")
end

function ExpMapView:_onClickBuff()
	UIStateManager.instance:open(ViewName.ExpAllBuff)
end

function ExpMapView:_onClickPet()
	UIStateManager.instance:open(ViewName.ExpAllPet)
end

function ExpMapView:_onClickRules()
	ViewMgr.instance:open(ViewName.RulesView, "expedition")
end

function ExpMapView:_onClickClose()
	ExpeditionModel.instance:setRunBattleGridData(nil)

	if ExpeditionTilingModel.instance:isInTilingMapScene() then
		SceneStatusMgr.instance:popStatus()
	else
		self:close()
	end
end

function ExpMapView:_onClickUseHeart()
	ViewMgr.instance:open(ViewName.ExpRevive)
end

function ExpMapView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function ExpMapView:_initActivityTipState()
	goutil.setActive(self._tip, false)
	self:_updateActivityTipState()
	settimer(3, self._updateActivityTipState, self)
end

function ExpMapView:_updateActivityTipState()
	local isInTime, desc, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Expedition)

	if isInTime and cfg and not self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(true)
		self._tip:SetActive(false)

		self._tipsTxt.text = string.format("奖励掉落+%s%%", (checknumber(cfg.featureParam) - 1) * 100)
		self._txtDesc.text = desc

		local startTable = GameUtil.time2date(startTime)
		local endTable = GameUtil.time2date(endTime)

		self._txtTime.text = string.format("(%02d.%02d 5:00 - %02d.%02d 5:00)", startTable.month, startTable.day, endTable.month, endTable.day)
	elseif not isInTime and self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(false)
		self._tip:SetActive(false)
	end

	local isInNewPrivilegeTime = NewhandwelfareController.instance:isInNewPrivilegeTime()

	if isInNewPrivilegeTime then
		local doubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

		self._txtTipsNewHand.text = string.format("奖励掉落+%s%%", checknumber(doubleValue) * 100)

		local startStamp, endStamp = NewhandwelfareModel.instance:getPrivilegeTimeActStartEndTime()
		local startDate, endDate = GameUtil.time2date(startStamp), GameUtil.time2date(endStamp)

		self._txtTimeNewHand.text = string.format("(%02d.%02d %d:%02d - %02d.%02d %d:%02d)", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	self._newHandDoubleRewardTip:SetActive(isInNewPrivilegeTime)
end

function ExpMapView:_onClickExplain(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function ExpMapView:_onExpedSelectGrid()
	self:_onClickEventToGridMap()
end

function ExpMapView:_onClickBtnSweep()
	local sweepLv = ExpeditionSweepModel.instance:getSweepOpenedLevel()

	if sweepLv > MofangModel.instance:getCurLv() then
		FloatWordMgr.instance:show(lang("expedition_sweep_lv_tips"))

		return
	end

	ViewMgr.instance:open(ViewName.ExpSweepEvent)
end

function ExpMapView:_onSceneLoadedFinish(sceneType, sceneId)
	if sceneType == SceneType.ExpedScene then
		self:_refresh()
	end
end

function ExpMapView:_onClickGridMapToEvent()
	local topView = GlobalModel.instance:getTopView()

	if topView.viewName ~= self._viewPresentor.viewName then
		return
	end

	self._isInGridMapView = false

	TaskController.instance:pause()
	self:_refresh()
end

function ExpMapView:_onClickEventToGridMap()
	if not ExpeditionTilingModel.instance:isInTilingMapScene() then
		self:_refresh()
		TaskController.instance:resume()
		self:_goDoEvent()
	else
		self:_refresh()
		TaskController.instance:resume()
	end
end

return ExpMapView
