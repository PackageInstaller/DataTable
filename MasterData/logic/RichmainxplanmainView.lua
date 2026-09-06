-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RichmainxplanmainView.lua

module("logic.extensions.richmanxplan.view.RichmainxplanmainView", package.seeall)

local RichmainxplanmainView = class("RichmainxplanmainView", ViewComponent)

RichmainxplanmainView.LeftBtnFold = false
RichmainxplanmainView.isSkipAnim = false

function RichmainxplanmainView:ctor()
	RichmainxplanmainView.super.ctor(self)
end

function RichmainxplanmainView:unbindEvents()
	RichmainxplanmainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRandomDice:RemoveClickListener()
	self._btnFixDice:RemoveClickListener()
	self._btnDiceAnim:RemoveClickListener()
	self._btnMap:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnNiuma:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnQingbao:RemoveClickListener()
	self._btnFold:RemoveClickListener()
	self._btnRate:RemoveClickListener()
end

function RichmainxplanmainView:bindEvents()
	RichmainxplanmainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRandomDice:AddClickListener(self._onClickbtnRandomDice, self)
	self._btnFixDice:AddClickListener(self._onClickbtnFixDice, self)
	self._btnDiceAnim:AddClickListener(self._onClickbtnDiceAnim, self)
	self._btnMap:AddClickListener(self._onClickbtnMap, self)
	self._btnTask:AddClickListener(self._onClickbtnTask, self)
	self._btnNiuma:AddClickListener(self._onClickbtnNiuma, self)
	self._btnExchange:AddClickListener(self._onClickbtnExchange, self)
	self._btnQingbao:AddClickListener(self._onClickbtnQingbao, self)
	self._btnFold:AddClickListener(self._onClickbtnFold, self)
	self._btnRate:AddClickListener(self._onClickbtnRate, self)
end

function RichmainxplanmainView:buildUI()
	RichmainxplanmainView.super.buildUI(self)

	self._btnTip = self:getBtn("lefttop/btnTip")
	self._btnClose = self:getBtn("lefttop/btnClose")
	self._mapScrollview = {}

	local mainGo = goutil.findChild(self.mainGO, "uiBottomCol/mapScrollview")

	self._mapScrollview._mainGo = mainGo
	self._mapScrollview._viewport = goutil.findChild(mainGo, "Viewport")
	self._mapScrollview._content = goutil.findChild(mainGo, "Viewport/Content")
	self._mapScrollview._bgCol = goutil.findChild(mainGo, "Viewport/Content/bgCol")
	self._mapScrollview._bgCell1 = {}
	self._mapScrollview._bgCell1._mainGo = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell1")
	self._mapScrollview._bgCell1._bgView = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell1/bgView")
	self._mapScrollview._bgCell1._bgEffRoot = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell1/bgEffRoot")
	self._mapScrollview._darkMask = goutil.findChild(mainGo, "Viewport/Content/darkMask")
	self._playerCellGo = goutil.findChild(self._mapScrollview._content, "playerCell")
	self._gridCols = {}

	for i = 1, 3 do
		local mainGo = goutil.findChild(self._mapScrollview._content, "gridCol" .. i)

		self._gridCols[i] = {
			_mainGo = mainGo,
			_view = goutil.findChild(mainGo, "view"),
			_cell = goutil.findChild(mainGo, "cell")
		}
	end

	self._masterCol = {}

	local mainGo = goutil.findChild(self._mapScrollview._content, "masterCol")

	self._masterCol._mainGo = mainGo
	self._masterCol._view = goutil.findChild(mainGo, "view")
	self._masterCol._cell = goutil.findChild(mainGo, "cell")
	self._btnRandomDice = self:getBtn("rightbottom/btnRandomDice")
	self._btnFixDice = self:getBtn("rightbottom/btnFixDice")
	self._clickMask = goutil.findChild(self.mainGO, "uiTopCol/clickMask")
	self._diceCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/diceCol")

	self._diceCol._mainGo = mainGo
	self._diceCol._diceHandlerList = {}

	for idx = 1, 3 do
		local diceView = goutil.findChild(mainGo, string.format("diceView_%s", 1))
		local diceHandler = RichManXplanDiceHandler.New()

		diceHandler:initFromGo(diceView, 3)

		self._diceCol._diceHandlerList[idx] = diceHandler
	end

	local cameraGo = self:getGo("uiTopCol/diceCol/diceView_1/camera")

	self._diceGos = {}

	for idx = 1, cameraGo.transform.childCount do
		self._diceGos[idx] = goutil.findChild(cameraGo, "go_" .. idx)

		goutil.setActive(self._diceGos[idx], false)
	end

	self._btnDiceAnim = self:getBtn("rightbottom/btnDiceAnim")
	self._checkmarkGo = self:getGo("rightbottom/btnDiceAnim/Checkmark")
	self._txtFixDiceHave = self:getTxt("rightbottom/btnFixDice/txtDiceHave")
	self._txtNormalDiceHave = self:getTxt("rightbottom/btnRandomDice/txtDiceHave")
	self._btnMap = self:getBtn("btnmask/leftbottom/btns/btnMap")
	self._btnTask = self:getBtn("btnmask/leftbottom/btns/btnTask")
	self._btnNiuma = self:getBtn("btnmask/leftbottom/btns/btnNiuma")
	self._btnExchange = self:getBtn("btnmask/leftbottom/btns/btnExchange")
	self._btnQingbao = self:getBtn("btnmask/leftbottom/btns/btnQingbao")
	self._btnFold = self:getBtn("btnmask/leftbottom/btnFold")
	self._leftbottomTr = self:getGo("btnmask/leftbottom").transform
	self._btnRate = self:getBtn("rightbottom/btnRate")
	self._txtBuffRate = self:getTxt("rightbottom/btnRate/txt")
	self._txtMat = self:getTxt("matCell/txtMat")
	self._gridcontentTr = self:getGo("uiBottomCol/mapScrollview/Viewport/Content/gridcontent").transform
	self._imgRedRandomGo = self:getGo("rightbottom/btnRandomDice/imgRed")
	self._imgRedFixedGo = self:getGo("rightbottom/btnFixDice/imgRed")
	self._redpointGo = self:getGo("btnmask/leftbottom/btns/btnTask/redpoint")
	self._txtFold = self:getTxt("btnmask/leftbottom/btnFold/txt")
	self._redpointTabGo = self:getGo("btnmask/leftbottom/btnFold/redpoint")
	self._effectGo = self:getGo("effect")
	self._redpointNuimaGo = self:getGo("btnmask/leftbottom/btns/btnNiuma/redpoint")
	self._bgMask3Go = self:getGo("uiBottomCol/mapScrollview/Viewport/Content/bgCol/bgCell1/bgMask3")
	self._bgMask2Go = self:getGo("uiBottomCol/mapScrollview/Viewport/Content/bgCol/bgCell1/bgMask2")
	self._bgMask1Go = self:getGo("uiBottomCol/mapScrollview/Viewport/Content/bgCol/bgCell1/bgMask1")
end

function RichmainxplanmainView:onExit()
	RichmainxplanmainView.super.onExit(self)
	self._playerMgr:onExit()
	self:_clearDice()
	RedPointController.instance:unregRedPoint(self._redpointGo)
	RedPointController.instance:unregRedPoint(self._redpointTabGo)
	RedPointController.instance:unregRedPoint(self._redpointNuimaGo)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._gridEffectHandler then
		UIEffectManager.instance:stopEffect(self._gridEffectHandler)

		self._gridEffectHandler = nil
	end

	if self._evetFinishEffectHandler then
		UIEffectManager.instance:stopEffect(self._evetFinishEffectHandler)

		self._evetFinishEffectHandler = nil
	end
end

function RichmainxplanmainView:onEnter()
	RichmainxplanmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanInfoRes, self._onRichManXPlanInfoRes, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanDiceRes, self._onRichManXPlanDiceRes, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanRunRes, self._onRichManXPlanRunRes, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanCloseOpenLottery, self._onRichManXPlanCloseOpenLottery, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._RichManXPlanEventRes, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanRefreshMainView, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.NotifyRichManXPlanScoreChangeRes, self._updateMat, self)
	self.addGEvent(self, GlobalNotify.PM_EventTaskTabUpdate, self._updateDiceHave, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateDiceHave, self)
	self:_setActId()

	if self._activityId <= 0 then
		printError("活动id错误")
		self:close()

		return
	end

	self:_tryBuildPlayer()
	self:_updateLeftBtnsState()
	self:_onUpdateGridColUI()
	RichManXPlanAgent.instance:sendPM_RichManXPlanInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redpointGo, 474)
	RedPointController.instance:regRedPoint(self._redpointTabGo, 474, "c29")
	RedPointController.instance:regRedPoint(self._redpointNuimaGo, "c29")
	self:_setEffect()
	self:_updateLockMask()
end

function RichmainxplanmainView:_onClickbtnTip()
	local ruleKey = RichmanxplanConfig.instance:getRuleKey(self._activityId, "mainviewRule")

	TipsFacade.instance:openRulesView(ruleKey)
end

function RichmainxplanmainView:_onClickbtnClose()
	self:close()
end

function RichmainxplanmainView:_onClickbtnMap()
	UIStateManager.instance:push(ViewName.RmxplanmappreView, self._activityId)
end

function RichmainxplanmainView:_onClickbtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function RichmainxplanmainView:_onClickbtnNiuma()
	UIStateManager.instance:push(ViewName.RmxplanworkView, self._activityId)
end

function RichmainxplanmainView:_onClickbtnExchange()
	FuncOpenController.instance:openFunc(191, GameEnum.ActivityType.RichManXPlan, self._activityId)
end

function RichmainxplanmainView:_onClickbtnQingbao()
	UIStateManager.instance:push(ViewName.XplanarchivesmainView)
end

function RichmainxplanmainView:_onClickbtnFold()
	RichmainxplanmainView.LeftBtnFold = not RichmainxplanmainView.LeftBtnFold

	self:_updateLeftBtnsState()
end

function RichmainxplanmainView:_onClickbtnRate()
	UIStateManager.instance:push(ViewName.RmxplanratebuffView, self._activityId)
end

function RichmainxplanmainView:_onRichManXPlanInfoRes()
	local info = RichmanxplanModel.instance:getInfo(self._activityId)

	self._curZoneId = info.location.zoneId
	self._curGridId = info.location.gridId

	self:_updateUI()
end

function RichmainxplanmainView:_onRichManXPlanDiceRes(status, dice)
	self:_updateUI()

	if status ~= 0 then
		self:_blockClick(false)

		return
	end

	local stepNum, diceValueList = self:_getStepNumAbdDiceValueListByDiceData(dice)
	local location = RichmanxplanModel.instance:getLocation(self._activityId)

	self:_setDataBeforePlayDiceAnim(location.zoneId, location.gridId, stepNum, diceValueList)
	self:_tryPlayDiceAnim()
end

function RichmainxplanmainView:_onRichManXPlanRunRes(msg)
	if msg.lotteryResult and #msg.lotteryResult > 0 then
		self._event = msg.event

		UIStateManager.instance:push(ViewName.RmxplanopenlotteryView, self._activityId, msg.lotteryResult)

		return
	else
		self:_handleEvent(msg.event)
	end
end

function RichmainxplanmainView:_onRichManXPlanCloseOpenLottery()
	if self._event then
		self:_handleEvent(self._event)

		self._event = nil
	end
end

function RichmainxplanmainView:_RichManXPlanEventRes(msg)
	if msg.isEnd or msg.eventType == RichmanxplanController.EventType.Baochong then
		self:_playEventFinishAnim()
	end

	if msg.eventType == RichmanxplanController.EventType.Baochong then
		local result = GameUtil.jsonToTable(msg.resultParam)
		local diceValueList = {}
		local stepNum = 0

		for i, v in ipairs(result.stepNum) do
			diceValueList[i] = v
			stepNum = stepNum + v
		end

		local location = RichmanxplanModel.instance:getLocation(self._activityId)

		self:_setDataBeforePlayDiceAnim(location.zoneId, location.gridId, stepNum, diceValueList)
		self:_tryPlayDiceAnim()
	end
end

function RichmainxplanmainView:_setActId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.RichManXPlan)
	end
end

function RichmainxplanmainView:_tryBuildPlayer()
	if self._playerMgr == nil then
		self._playerMgr = RichManXplanPlayerMgr.New()
	end

	local mapScrollerRect = self._mapScrollview._mainGo:GetComponent(ComponentType.ScrollRect)
	local bgViewRect = self._mapScrollview._bgCell1._bgView:GetComponent(goutil.Type_RectTransform)
	local mapScrollerSize = {
		x = bgViewRect.sizeDelta.x,
		y = bgViewRect.sizeDelta.y
	}

	self._playerMgr:onEnter(self, mapScrollerRect, mapScrollerSize, self._playerCellGo)
end

function RichmainxplanmainView:_updateUI()
	self._info = RichmanxplanModel.instance:getInfo(self._activityId)
	self._curZoneId = self._info.location.zoneId
	self._curGridId = self._info.location.gridId

	self:_resetPlayerToCurGrid()
	self:_updateGridsData()
	self:_doLegacyEvent()
	self:_setSkipState()
	self:_updateDiceHave()
	self:_updateBuffState()
	self:_updateMat()
	self:_updateDiceRedDot()
end

function RichmainxplanmainView:_onUpdateGridColUI()
	if self._gridCellList and table.nums(self._gridCellList) > 1 then
		return
	end

	if self._gridCellList == nil then
		self._gridCellList = {}
	end

	local zoneCfgs = RichmanxplanConfig.instance:getZoneCfgs(self._activityId)

	for i, zoneCfg in ipairs(zoneCfgs) do
		self._gridCellList[zoneCfg.zoneId] = self._gridCellList[zoneCfg.zoneId] or {}

		local gridCfgs = RichmanxplanConfig.instance:getGridCfgs(self._activityId, zoneCfg.zoneId)
		local gridCol = self._gridCols[i]
		local parentView = gridCol._view
		local childGo = gridCol._cell

		for i, list in ipairs(self._gridCellList[zoneCfg.zoneId]) do
			for _, cell in ipairs(list) do
				cell._mainGo.transform:SetParent(parentView.transform)
			end
		end

		local children = GameUtil.getChildren(parentView)

		GameUtil.SetActive(childGo, false)

		for idx, gridCfg in ipairs(gridCfgs) do
			if not children[idx] then
				local mainGo = goutil.clone(childGo, string.format("%s_%s_%s", childGo.name, gridCfg.zoneId, gridCfg.gridId))

				goutil.addChildToParent(mainGo, parentView)
			end
		end

		parentView:GetComponent(ComponentType.TestRecordPos):LoadPlan(0)

		local children = GameUtil.getChildren(parentView)
		local cnt = #gridCfgs

		for idx, gridCfg in ipairs(gridCfgs) do
			local mainGo = children[idx]
			local cell = {}

			cell._mainGo = mainGo
			cell._btnIcon = goutil.findChild(mainGo, "btnIcon")
			cell._icon = goutil.findChild(mainGo, "btnIcon/icon")
			cell._colliderBox = goutil.findChild(mainGo, "colliderBox")
			self._gridCellList[gridCfg.zoneId] = self._gridCellList[gridCfg.zoneId] or {}
			self._gridCellList[zoneCfg.zoneId][gridCfg.gridId] = cell

			mainGo.transform:SetParent(self._gridcontentTr)
		end

		for _, cells in ipairs(self._gridCellList) do
			for idx, cell in ipairs(cells) do
				GameUtil.SetActive(cell._mainGo, idx <= cnt)
			end
		end
	end
end

function RichmainxplanmainView:_updateGridsData()
	self:_cacheTudiPurchased()

	local zoneCfgs = RichmanxplanConfig.instance:getZoneCfgs(self._activityId)

	for i, zoneCfg in ipairs(zoneCfgs) do
		local gridCfgs = RichmanxplanConfig.instance:getGridCfgs(self._activityId, zoneCfg.zoneId)

		for _, gridCfg in ipairs(gridCfgs) do
			self:_updateGridCellUI(gridCfg)
		end
	end
end

function RichmainxplanmainView:_updateGridCellUI(gridCfg)
	local cell = self:_getGridCell(gridCfg.zoneId, gridCfg.gridId)

	if cell == nil then
		return
	end

	local path = gridCfg.pictureUrl
	local bgGo = cell._icon

	uGuiUtil.clearImage(bgGo)

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg

		if gridCfg.eventType == RichmanxplanController.EventType.Tudi then
			local hasBuy, eventId = self:_checkHasBuy(gridCfg.zoneId, gridCfg.gridId)

			if hasBuy then
				local landEventCfg = RichmanxplanConfig.instance:getLandEventCfg(self._activityId, eventId)

				path = string.format("icon/items/%s", landEventCfg.iconRes)
			end
		end

		local spriteName = string.format("ui/%s.png", path)

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName)
	end

	GameUtil.addClickHandler(cell._btnIcon, GameUtil.handler(self._onClickGridCell, self, gridCfg))
end

function RichmainxplanmainView:_getGridCell(zoneId, gridId)
	if self._gridCellList then
		return self._gridCellList[zoneId][gridId]
	end
end

function RichmainxplanmainView:_onClickGridCell(gridCfg)
	return
end

function RichmainxplanmainView:_onClickbtnRandomDice()
	if self:_doLegacyEvent() then
		return
	end

	local diceCfg = RichmanxplanConfig.instance:getDiceCfg(self._activityId, RichmanxplanController.DiceType.Normal)

	if not MaterialMgr.getMatEnough(diceCfg.cost) then
		FloatWordMgr.instance:show("道具不足")

		return
	end

	self:_blockClick(true)
	RichManXPlanAgent.instance:sendPM_RichManXPlanDiceReq(self._activityId, RichmanxplanController.DiceType.Normal, 0)
end

function RichmainxplanmainView:_onClickbtnFixDice()
	if self:_doLegacyEvent() then
		return
	end

	local diceCfg = RichmanxplanConfig.instance:getDiceCfg(self._activityId, RichmanxplanController.DiceType.Fixed)

	if not MaterialMgr.getMatEnough(diceCfg.cost) then
		FloatWordMgr.instance:show("道具不足")

		return
	end

	UIStateManager.instance:push(ViewName.RmxplanfixeddiceView, self._activityId)
end

function RichmainxplanmainView:_onClickbtnDiceAnim()
	RichmainxplanmainView.isSkipAnim = not RichmainxplanmainView.isSkipAnim

	self:_setSkipState()
end

function RichmainxplanmainView:_blockClick(isNeedBlock)
	GameUtil.SetActive(self._clickMask, isNeedBlock)
end

function RichmainxplanmainView:_regEvent(key, totalNum, endCallBack)
	if self._eventQueue == nil then
		self._eventQueue = {}
	end

	self._eventQueue[key] = {
		curNum = 0,
		totalNum = totalNum,
		endCallBack = endCallBack
	}
end

function RichmainxplanmainView:_calcNode(key, delta)
	if self._eventQueue[key] == nil then
		return
	end

	local curNum = self._eventQueue[key].curNum

	curNum = curNum + delta

	if curNum >= self._eventQueue[key].totalNum then
		self:_endEvent(key, true)
	else
		self._eventQueue[key].curNum = curNum
	end
end

function RichmainxplanmainView:_endEvent(key, isNeedCallBack)
	local node = self._eventQueue[key]

	if isNeedCallBack then
		GameUtil.callBack(node.endCallBack)
	end

	table.clear(self._eventQueue[key])

	self._eventQueue[key] = nil
end

function RichmainxplanmainView:_tryPlayerMove()
	self:_startPlayerMove()
end

function RichmainxplanmainView:_onPlayerMove(conveyData)
	self._conveyData = conveyData

	table.insert(self._runFinishReqDatas, self._conveyData)

	local speedRatio = 0.3

	local function finishCallBack()
		self:_onPlayerMoveFinish()
	end

	self._playerMgr:playPathMove(self._playerCellGo, self:_getGridCellPosList(conveyData), speedRatio, nil, finishCallBack)
end

function RichmainxplanmainView:_onPlayerMoveFinish()
	if self._conveyData.leftStepNum <= 0 then
		self:_playGridEffect()

		return
	end

	local gridCfg = RichmanxplanConfig.instance:getGridCfg(self._activityId, self._conveyData.targetZoneId, self._conveyData.targetGridId)

	if self._conveyData.needSelectConvey and not string.nilorempty(gridCfg.convey) then
		UIStateManager.instance:push(ViewName.RmxplanconveytipView, self._activityId, self._conveyData, function(isConvey)
			self:_onPlayerSelectDirectionFinish(isConvey)
		end)
	else
		local conveyData = self:_getConveyData(self._conveyData.targetZoneId, self._conveyData.targetGridId, self._conveyData.leftStepNum)

		self:_onPlayerMove(conveyData)
	end
end

function RichmainxplanmainView:_onPlayerSelectDirectionFinish(isConvey)
	local lastData = self._runFinishReqDatas[#self._runFinishReqDatas]

	lastData.isConvey = checkbool(isConvey)

	if lastData.leftStepNum <= 0 then
		self:_playGridEffect()

		return
	end

	local conveyData
	local curGridCfg = RichmanxplanConfig.instance:getGridCfg(self._activityId, lastData.targetZoneId, lastData.targetGridId)

	if isConvey then
		local arr = string.split(curGridCfg.convey, ",")
		local jumpZoneId = checknumber(arr[1])
		local jumpGridId = checknumber(arr[2])

		self:_changeMap(jumpZoneId, jumpGridId)

		conveyData = self:_getConveyData(jumpZoneId, jumpGridId, lastData.leftStepNum, true)
	else
		conveyData = self:_getConveyData(lastData.targetZoneId, lastData.targetGridId, lastData.leftStepNum, true)
	end

	self:_onPlayerMove(conveyData)
end

function RichmainxplanmainView:_playGridEffect()
	local effName = "20240531/dafuweng/fx_ui_luodian_dfw.prefab"

	self._gridEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self:_sendRunFinishReq()
	end)

	self._gridEffectHandler:setEffTime(0.5)
	self._gridEffectHandler:setParent(self._playerMgr:getMainGo().transform)
	self._gridEffectHandler:setScale(1)
	self._gridEffectHandler:setLocalPos(0, 0, 0)
end

function RichmainxplanmainView:_sendRunFinishReq()
	if self._gridEffectHandler then
		UIEffectManager.instance:stopEffect(self._gridEffectHandler)

		self._gridEffectHandler = nil
	end

	RichManXPlanAgent.instance:sendPM_RichManXPlanRunReq(self._activityId, self._runFinishReqDatas)
end

function RichmainxplanmainView:_setDataBeforePlayDiceAnim(startZoneId, startGridId, stepNum, diceValueList)
	self._startZoneId = startZoneId
	self._startGridId = startGridId
	self._stemNum = stepNum
	self._diceValueList = diceValueList
end

function RichmainxplanmainView:_tryPlayDiceAnim()
	self:_playDiceAnim()
end

function RichmainxplanmainView:_playDiceAnim()
	self:_blockClick(true)

	for k, v in pairs(self._diceGos) do
		goutil.setActive(v, false)
	end

	local valueList = self._diceValueList

	local function autoHideSelfCallback()
		self:_tryPlayerMove()
	end

	local key = "PlayDice"
	local num = #valueList

	self:_regEvent(key, num, autoHideSelfCallback)

	local saiziIds = {}

	if num == 1 then
		saiziIds = {
			2
		}
	elseif num == 2 then
		saiziIds = {
			1,
			3
		}
	elseif num == 3 then
		saiziIds = {
			1,
			2,
			3
		}
	end

	for idx, val in ipairs(valueList) do
		local params = {
			autoHideSelfSec = 1,
			value = val,
			useSaiZiId = saiziIds[idx],
			autoHideSelfCallback = function()
				self:_calcNode(key, num)
			end,
			thisArg = self,
			bNotPlayAnim = RichmainxplanmainView.isSkipAnim
		}
		local diceHandler = self:_getDiceHandler(idx)

		if diceHandler then
			diceHandler:play(params)
		else
			printError("缺失")
		end
	end
end

function RichmainxplanmainView:_startPlayerMove()
	self._runFinishReqDatas = {}

	local conveyData = self:_getConveyData(self._startZoneId, self._startGridId, self._stemNum)

	self:_onPlayerMove(conveyData)
end

function RichmainxplanmainView:_getConveyData(zoneId, gridId, stepNum, ignoreFirst)
	local conveyData
	local gridCfgs = RichmanxplanConfig.instance:getGridCfgs(self._activityId, zoneId)
	local oneRoundStepNum = #gridCfgs
	local startGridId = gridId
	local targetGridId = startGridId + stepNum
	local endGridId = targetGridId

	if oneRoundStepNum < endGridId then
		endGridId = oneRoundStepNum
	end

	local useStepNum = -1
	local hasChangeIndex = false
	local canChange = ignoreFirst

	if not canChange then
		if string.nilorempty(gridCfgs[oneRoundStepNum].convey) then
			canChange = true
		else
			local arr = string.split(gridCfgs[oneRoundStepNum].convey, ",")
			local conveyZoneId = checknumber(arr[1])
			local zoneCfg = RichmanxplanConfig.instance:getZoneCfg(self._activityId, conveyZoneId)
			local startTime = GameUtil.string2time(zoneCfg.openDateTime)

			canChange = startTime > ServerTime.now() and true or canChange
		end
	end

	if startGridId == endGridId and endGridId == oneRoundStepNum and canChange then
		hasChangeIndex = true
		startGridId = 1
		useStepNum = useStepNum + 1
		targetGridId = startGridId + stepNum - 1
		endGridId = startGridId + stepNum - 1

		if oneRoundStepNum < startGridId + stepNum - 1 then
			endGridId = oneRoundStepNum
		end
	end

	for i = startGridId, endGridId do
		useStepNum = useStepNum + 1

		local curGridCfg = gridCfgs[i]
		local enough = false

		if not string.nilorempty(curGridCfg.convey) then
			enough = true

			local arr = string.split(curGridCfg.convey, ",")
			local conveyZoneId = checknumber(arr[1])
			local zoneCfg = RichmanxplanConfig.instance:getZoneCfg(self._activityId, conveyZoneId)
			local startTime = GameUtil.string2time(zoneCfg.openDateTime)

			if startTime > ServerTime.now() then
				enough = false
			end
		end

		if enough and (not ignoreFirst or i ~= startGridId) and i ~= targetGridId then
			conveyData = {
				isConvey = false,
				needSelectConvey = true,
				targetZoneId = curGridCfg.zoneId,
				targetGridId = curGridCfg.gridId,
				startGridId = startGridId,
				useStepNum = useStepNum,
				leftStepNum = stepNum - useStepNum
			}

			break
		end
	end

	if not conveyData then
		local addNum = hasChangeIndex and 1 or 0
		local useStepNum = endGridId - startGridId + addNum
		local curGridCfg = gridCfgs[endGridId]

		conveyData = {
			isConvey = false,
			needSelectConvey = false,
			targetZoneId = curGridCfg.zoneId,
			targetGridId = curGridCfg.gridId,
			startGridId = startGridId,
			useStepNum = useStepNum,
			leftStepNum = stepNum - useStepNum
		}
	end

	return conveyData
end

function RichmainxplanmainView:_getDiceHandler(handlerIdx)
	return self._diceCol._diceHandlerList[handlerIdx]
end

function RichmainxplanmainView:_doLegacyEvent()
	if self._info.event.state == RichmanxplanController.RichmanState.WaitingRun then
		local stepNum, diceValueList = self:_getStepNumAbdDiceValueListByDiceData(self._info.event.dice)
		local location = RichmanxplanModel.instance:getLocation(self._activityId)

		self:_setDataBeforePlayDiceAnim(location.zoneId, location.gridId, stepNum, diceValueList)
		self:_tryPlayerMove()
	elseif self._info.event.state == RichmanxplanController.RichmanState.WaitingEvent then
		self:_handleEvent(self._info.event.event)
	else
		return false
	end

	return true
end

function RichmainxplanmainView:_getGridCellPosList(conveyData)
	local list = {}

	for gridId = conveyData.startGridId, conveyData.targetGridId do
		table.insert(list, self:_getGridCellLocalPos(conveyData.targetZoneId, gridId))
	end

	return list
end

function RichmainxplanmainView:_getGridCellLocalPos(zoneId, gridId)
	local cell = self:_getGridCell(zoneId, gridId)

	return GameUtil.getLocalPos(cell._mainGo)
end

function RichmainxplanmainView:_handleEvent(event)
	self:_blockClick(false)

	local viewName

	if event.eventType == RichmanxplanController.EventType.Tudi then
		viewName = ViewName.RmxplantudieventView
	elseif event.eventType == RichmanxplanController.EventType.Zhaomu then
		viewName = ViewName.RmxplanzhaomueventView
	elseif event.eventType == RichmanxplanController.EventType.Shangpu then
		viewName = ViewName.RmxplanshangpueventView
	elseif event.eventType == RichmanxplanController.EventType.Boyi then
		viewName = ViewName.RmxplanboyieventView
	elseif event.eventType == RichmanxplanController.EventType.Yaojiang then
		viewName = ViewName.RmxplanyaojiangeventView
	elseif event.eventType == RichmanxplanController.EventType.Zhanbu then
		viewName = ViewName.RmxplanzhanbueventView
	elseif event.eventType == RichmanxplanController.EventType.Baochong then
		viewName = ViewName.RmxplanbaochongeventView
	elseif event.eventType == RichmanxplanController.EventType.Ziyuan then
		viewName = ViewName.RmxplanziyuaneventView
	elseif event.eventType == RichmanxplanController.EventType.Caipiao then
		viewName = ViewName.RmxplancaipiaoeventView
	else
		printError("还有事件没处理 eventType:", event.eventType)
	end

	if viewName then
		UIStateManager.instance:push(viewName, self._activityId, event)
	end
end

function RichmainxplanmainView:_resetPlayerToCurGrid()
	local curGridId = self._curGridId
	local curZoneId = self._curZoneId
	local curGridPos = self:_getGridCellLocalPos(curZoneId, curGridId)
	local gridCfgs = RichmanxplanConfig.instance:getGridCfgs(self._activityId, self._curZoneId)
	local nextGridId = curGridId + 1
	local maxGridId = #gridCfgs

	nextGridId = nextGridId % maxGridId

	if nextGridId == 0 then
		nextGridId = maxGridId
	end

	local nextGridPos = self:_getGridCellLocalPos(curZoneId, nextGridId)

	self._playerMgr:setPlayerLocalPos(curGridPos)
	self._playerMgr:setToward(nextGridPos)
	self._playerMgr._scrollerViewCtrl:viewTo(self._playerMgr:getPlayerLocalPos())
end

function RichmainxplanmainView:_setSkipState()
	goutil.setActive(self._checkmarkGo, RichmainxplanmainView.isSkipAnim)
end

function RichmainxplanmainView:_updateDiceHave()
	local cfgNor = RichmanxplanConfig.instance:getDiceCfg(self._activityId, RichmanxplanController.DiceType.Normal)
	local cfgFixed = RichmanxplanConfig.instance:getDiceCfg(self._activityId, RichmanxplanController.DiceType.Fixed)
	local _, _, costNor = MaterialMgr.getMatParams(cfgNor.cost)
	local _, _, costFixed = MaterialMgr.getMatParams(cfgFixed.cost)

	self._txtNormalDiceHave.text = string.format("剩余:%s", math.floor(MaterialMgr.getMatCount(cfgNor.cost) / costNor))
	self._txtFixDiceHave.text = string.format("剩余:%s", math.floor(MaterialMgr.getMatCount(cfgFixed.cost) / costFixed))

	self:_updateDiceRedDot()
end

function RichmainxplanmainView:_updateLeftBtnsState()
	local posx = RichmainxplanmainView.LeftBtnFold and -138 or -30

	Framework.TransformUtil.SetAnchoredPos(self._leftbottomTr, posx, 0)

	self._txtFold.text = RichmainxplanmainView.LeftBtnFold and "展\n开" or "收\n起"
end

function RichmainxplanmainView:_updateBuffState()
	local rateValue = RichmanxplanModel.instance:getBuffRate(self._activityId)

	self._txtBuffRate.text = string.format("当前收益\n%s%%", rateValue * 100)
end

function RichmainxplanmainView:_getStepNumAbdDiceValueListByDiceData(dice)
	local diceValueList = {}

	if dice.diceType == RichmanxplanController.DiceType.Normal then
		table.insert(diceValueList, dice.stepNum[1])
	elseif dice.diceType == RichmanxplanController.DiceType.Fixed then
		table.insert(diceValueList, dice.stepNum[1])
	elseif dice.diceType == RichmanxplanController.DiceType.Rush then
		for i, v in ipairs(dice.stepNum) do
			table.insert(diceValueList, v)
		end
	end

	local stepNum = 0

	for i, v in ipairs(diceValueList) do
		stepNum = stepNum + v
	end

	return stepNum, diceValueList
end

function RichmainxplanmainView:_clearDice()
	for _, v in ipairs(self._diceCol._diceHandlerList) do
		v:dispose()
	end
end

function RichmainxplanmainView:_changeMap(zoneId, gridId)
	self._curZoneId = zoneId
	self._curGridId = gridId

	self:_onUpdateGridColUI()
	self:_resetPlayerToCurGrid()
end

function RichmainxplanmainView:_updateMat()
	local info = RichmanxplanModel.instance:getInfo(self._activityId)

	if info then
		self._info = info
		self._txtMat.text = info.score
	end
end

function RichmainxplanmainView:_updateDiceRedDot()
	local cfgs = RichmanxplanConfig.instance:getDiceCfgs(self._activityId)

	goutil.setActive(self._imgRedFixedGo, MaterialMgr.getMatEnough(cfgs[RichmanxplanController.DiceType.Fixed].cost))
	goutil.setActive(self._imgRedRandomGo, MaterialMgr.getMatEnough(cfgs[RichmanxplanController.DiceType.Normal].cost))
end

function RichmainxplanmainView:_checkHasBuy(zoneId, gridId)
	if self._tudiPurchased[zoneId] and self._tudiPurchased[zoneId][gridId] then
		local gridData = self._tudiPurchased[zoneId][gridId]

		if gridData.eventType == RichmanxplanController.EventType.Tudi then
			local param = GameUtil.jsonToTable(gridData.param)

			if not param then
				printError("报错：", zoneId, gridId, " 参数：", tostring(gridData.param))
			end

			return param and param.purchased, gridData.eventId
		end
	end

	return false
end

function RichmainxplanmainView:_cacheTudiPurchased()
	self._tudiPurchased = {}

	local info = RichmanxplanModel.instance:getInfo(self._activityId)

	if info then
		for i, v in ipairs(info.zones) do
			self._tudiPurchased[v.zoneId] = self._tudiPurchased[v.zoneId] or {}

			for i, gridData in ipairs(v.grids) do
				self._tudiPurchased[v.zoneId][gridData.gridId] = gridData
			end
		end
	end
end

function RichmainxplanmainView:_setEffect()
	local effName = "20240531/dafuweng/fx_ui_tongyongfenwei_dfw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function RichmainxplanmainView:_playEventFinishAnim()
	self:_playEventFinishEffect()
	self._playerMgr:playHuanhuAnim()
end

function RichmainxplanmainView:_playEventFinishEffect()
	local effName = "20240531/dafuweng/fx_ui_chaopiao_dfw.prefab"

	self._evetFinishEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._evetFinishEffectHandler:setParent(self._playerMgr:getMainGo().transform)
	self._evetFinishEffectHandler:setScale(1)
	self._evetFinishEffectHandler:setLocalPos(0, 0, 0)
end

function RichmainxplanmainView:_updateLockMask()
	local zoneCfgs = RichmanxplanConfig.instance:getZoneCfgs(self._activityId)
	local nowTime = ServerTime.now()

	for i, zoneCfg in ipairs(zoneCfgs) do
		local time = GameUtil.string2time(zoneCfg.openDateTime)

		goutil.setActive(self["_bgMask" .. zoneCfg.zoneId .. "Go"], nowTime < time)
	end
end

return RichmainxplanmainView
