-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotGameView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotGameView", package.seeall)

local DefendCarrotGameView = class("DefendCarrotGameView", ViewComponent)
local STATE_INIT = "STATE_INIT"
local STATE_READY = "STATE_READY"
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"
local CELL_SIZE = 98

function DefendCarrotGameView:ctor()
	DefendCarrotGameView.super.ctor(self)
end

function DefendCarrotGameView:unbindEvents()
	DefendCarrotGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReturn)
	GameUtil.rmClickHandler(self._btnPause)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnSpecial)
	GameUtil.rmClickHandler(self._btnTips)

	if self._clickEventHandler then
		PointerClickHandler.Get(self._eventclicker):RemoveLuaHandler(self._clickEventHandler)

		self._clickEventHandler = nil
	end
end

function DefendCarrotGameView:bindEvents()
	DefendCarrotGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnReturn, self._onClickReturnWeapon, self)
	GameUtil.addClickHandler(self._btnPause, self._onClickPause, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnSpecial, self._onClickSpecialGrid, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)

	self._clickEventHandler = PointerClickHandler.Get(self._eventclicker):AddLuaHandler(function(go, eventData)
		self:_onClickEvent(eventData)
	end)
end

function DefendCarrotGameView:buildUI()
	DefendCarrotGameView.super.buildUI(self)

	self._template_obstacle = self:getGo("gamelayers/layer_obstacle/template_obstacle")
	self._template_monster = self:getGo("gamelayers/layer_monster/template_monster")
	self._template_weapon = self:getGo("gamelayers/layer_weapon/template_weapon")
	self._template_bullet = self:getGo("gamelayers/layer_bullet/template_bullet")
	self._template_map = self:getGo("template_map")
	self._layer_map = self:getGo("gamelayers/layer_map")

	goutil.setActive(self._template_map, false)

	self._template_bubble = self:getGo("template_bubble")
	self._layer_bubble = self:getGo("gamelayers/layer_bubble")

	goutil.setActive(self._template_bubble, false)

	self._gamelayersCom = self:getGo("gamelayers")
	self._eventclicker = self:getGo("gamelayers/eventclicker")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnPause = self:getGo("btnPause")
	self._imgState = self:getGo("btnPause/imgState"):GetComponent("UIImageSpriteChange")
	self._btnTask = self:getGo("btnTask")
	self._btnSpecial = self:getGo("btnSpecial")
	self._txtCurCoin = self:getTxt("otherInfo/curCoin/txt")
	self._curWave = self:getGo("otherInfo/curWave")
	self._txtCurWave = self:getTxt("otherInfo/curWave/txt")
	self._curPrize = self:getGo("otherInfo/curPrize")
	self._txtCurPrize = self:getTxt("otherInfo/curPrize/txt")
	self._iconCurPrize = self:getGo("otherInfo/curPrize/txt/icon")
	self._curtimer = self:getGo("otherInfo/curtimer")
	self._txtTimer = self:getTxt("otherInfo/curtimer/txt")
	self._buildGo = self:getGo("gamelayers/buildGo")
	self._buildInfo = self:getGo("gamelayers/buildGo/build")
	self._buildTableviewGo = self:getGo("gamelayers/buildGo/build/tableview")
	self._weaponCellGo = self:getGo("gamelayers/buildGo/build/tableview/tablecell")
	self._buildTableview = ScrollerList.create(self._buildTableviewGo, self._weaponCellGo, GameUtil.handler(self._updateBuildCell, self), GameUtil.handler(self._clearBuildCell, self))
	self._returnInfo = self:getGo("gamelayers/buildGo/return")
	self._btnReturn = self:getGo("gamelayers/buildGo/return/btnReturn")
	self._radiusWeapon = self:getGo("gamelayers/buildGo/return/radius")
	self._txtReturnCoin = self:getTxt("gamelayers/buildGo/return/coin/txt")
	self._flyitem = self:getGo("flyitem")
	self._flyitem2 = self:getGo("flyitem2")
	self._textCon = self:getGo("gamelayers/textCon")
	self._hpGo = self:getGo("gamelayers/layer_Hp/hp")
	self._txtCurHp = self:getTxt("gamelayers/layer_Hp/hp/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._layer_eff = self:getGo("gamelayers/layer_eff")
	self._ready = self:getGo("ready")
	self._imgNumReady = self:getGo("ready/imgNum"):GetComponent(ComponentType.UIImgNumeralText)

	goutil.setActive(self._ready, false)
	DefendCarrotGameController.instance:initGame()
	DefendCarrotGameController.instance:setUnitComTemplate(DefendCarrotEnum.UnitType.Monster, self._template_monster)
	DefendCarrotGameController.instance:setUnitComTemplate(DefendCarrotEnum.UnitType.Obstacle, self._template_obstacle)
	DefendCarrotGameController.instance:setUnitComTemplate(DefendCarrotEnum.UnitType.Weapon, self._template_weapon)
	DefendCarrotGameController.instance:setUnitComTemplate(DefendCarrotEnum.UnitType.Bullet, self._template_bullet)
	self:_initFSM()
end

function DefendCarrotGameView:destroyUI()
	DefendCarrotGameController.instance:destroyGame()
end

function DefendCarrotGameView:_initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_INIT, GameUtil.handler(self._onEnterInit, self), nil, nil)
	self._stateMachine:addState(STATE_READY, GameUtil.handler(self._onEnterReady, self), GameUtil.handler(self._onExistReady, self), nil)
	self._stateMachine:addState(STATE_RUNING, GameUtil.handler(self._onEnterRunning, self), nil, GameUtil.handler(self._onRunning, self))
	self._stateMachine:addState(STATE_PAUSE, GameUtil.handler(self._onEnterPause, self), GameUtil.handler(self._onExitPause, self), nil)
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._onEnterGameEnd, self))

	local linkedList = {
		[STATE_INIT] = {
			STATE_READY
		},
		[STATE_READY] = {
			STATE_RUNING
		},
		[STATE_RUNING] = {
			STATE_PAUSE,
			STATE_GAME_END
		},
		[STATE_PAUSE] = {
			STATE_RUNING,
			STATE_GAME_END
		},
		[STATE_GAME_END] = {
			STATE_INIT
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function DefendCarrotGameView:onExit()
	DefendCarrotGameView.super.onExit(self)
	DefendCarrotGameController.instance:resetGame()
	self._stateMachine:stopTimer()

	if DefendCarrotController.instance:getIsInGame() then
		self:_sendEndGameToServer(false)
	end

	AQAFSimpleFloatTipsMgr.instance:clearAll()
	self._buildTableview:dispose()
	MaterialMgr.resetAll(self._iconCurPrize)
	removetimer(self._onReadyCountDown, self)
	ResGcMgr.instance:gc()
	self:resetAllEff()
end

function DefendCarrotGameView:onEnter()
	DefendCarrotGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DefendCarrotGameUpdateWave, self._updateCurWave, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotGameChangeCoin, self._changeCoin, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotGameChangeHP, self._changeHp, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotEndGame, self._handleGameEnd, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotMaterialClgEndGame, self._handleMaterialClgEndGame, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotGameResumesRunning, self._resumesRunning, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotShowAlertTxt, self._onShowAlertTips, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotUpdateWeaponBuildInfo, self._onUpdateWeaponInfo, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotPlayEffect, self.playEffect, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotPlayXiaoShiEffect, self.playHurtEffect, self)

	self._curActivityId = 0
	self._curStageId = 0
	self._curMode = 0

	local params = self:getOpenParam()

	if params then
		self._curActivityId = checknumber(params[1])
		self._curStageId = checknumber(params[2])
		self._curMode = params[3]
	end

	if self._curActivityId <= 0 then
		self._curActivityId = 517001
	end

	self:_updateUIByCfg()

	if not self:_checkCfgValid() then
		self:close()

		return
	end

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_INIT)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, self._flyitem, AQAFFloatItem, 100)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_TEXT, self._flyitem2, FloatWordItem, 100)
end

function DefendCarrotGameView:_onGameGc()
	ResGcMgr.instance:gc()
end

function DefendCarrotGameView:_onShowAlertTips(content, x, y, type)
	if type == nil then
		AQAFSimpleFloatTipsMgr.instance:flyText(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, content, self._textCon, x + math.random(-40, 40), y)
	else
		AQAFSimpleFloatTipsMgr.instance:flyText(type, content, self._textCon, x + math.random(-40, 40), y)
	end
end

function DefendCarrotGameView:_checkCfgValid()
	if not self._gameCfg then
		printError("DefendCarrotGameView:_checkCfgValid no gameCfg")

		return false
	end

	return true
end

function DefendCarrotGameView:_updateUIByCfg()
	self._gameCfg = nil

	goutil.setActive(self._curtimer, false)
	goutil.setActive(self._curWave, false)
	goutil.setActive(self._curPrize, false)

	if self._curMode == DefendCarrotEnum.LevelMode_Normal then
		local stageCfg = DefendCarrotConfig.instance:getStageCfgByStageId(self._curActivityId, self._curStageId)

		if stageCfg then
			self._gameCfg = DefendCarrotConfig.instance:getStagePlanCfg(stageCfg.stagePlanId)
		end

		goutil.setActive(self._curWave, true)
	elseif self._curMode == DefendCarrotEnum.LevelMode_Material then
		local stageCfg = DefendCarrotConfig.instance:getMaterialClgByStageId(self._curActivityId, self._curStageId)

		if stageCfg then
			self._gameCfg = DefendCarrotConfig.instance:getStagePlanCfg(stageCfg.stagePlanId)
		end

		goutil.setActive(self._curtimer, true)
		goutil.setActive(self._curPrize, true)
	end

	goutil.setActive(self._btnTask, self._curMode == DefendCarrotEnum.LevelMode_Normal)

	if not self._gameCfg then
		return
	end

	DefendCarrotGameController.instance:setActivityId(self._curActivityId)
	DefendCarrotGameController.instance:setMapCellWidth(CELL_SIZE)
	DefendCarrotGameController.instance:setGameConfig(self._gameCfg)
	self:_onClickHide()

	if not self._gameCfg.typelimit then
		local weaponTypeLimitStr = ""

		if GameUtil.isEmptyString(weaponTypeLimitStr) then
			printError(">>>>>>>>>>>>>> 必须有配置！！！")
		else
			local limitWeaponIds = string.splitToNumber(weaponTypeLimitStr, "#")

			self._buildTableview:reloadData(limitWeaponIds)
		end
	end
end

function DefendCarrotGameView:_onEnterInit()
	self:_updatePauseBtn()
	self:_restartGame()
end

function DefendCarrotGameView:_onEnterReady()
	goutil.setActive(self._ready, true)

	self._readyTimer = 3

	self._imgNumReady:SetNum(self._readyTimer)
	settimer(1, self._onReadyCountDown, self, true)
	TipsFacade.instance:openCommonTips("怪物即将来袭，请做好准备！")
end

function DefendCarrotGameView:_onReadyCountDown()
	self._readyTimer = self._readyTimer - 1

	if self._readyTimer <= 0 then
		self._stateMachine:gotoState(STATE_RUNING)
	else
		self._imgNumReady:SetNum(self._readyTimer)
	end
end

function DefendCarrotGameView:_onExistReady()
	goutil.setActive(self._ready, false)
	removetimer(self._onReadyCountDown, self)
end

function DefendCarrotGameView:_onEnterRunning()
	self:_updatePauseBtn()
end

function DefendCarrotGameView:_onRunning()
	if DefendCarrotGameController.instance:isGameOver() then
		self._stateMachine:gotoState(STATE_GAME_END)
	else
		DefendCarrotGameController.instance:updateGame()

		if self._curMode == DefendCarrotEnum.LevelMode_Material then
			local curTimer = DefendCarrotGameController.instance:getCurGameTimer()

			if curTimer >= 0 then
				self._txtTimer.text = string.format("倒计时:%dS", curTimer)
			end
		end
	end
end

function DefendCarrotGameView:_onEnterPause()
	self:_updatePauseBtn()
end

function DefendCarrotGameView:_onExitPause()
	self:_updatePauseBtn()
end

function DefendCarrotGameView:_onEnterGameEnd()
	self:_onClickHide()

	if self._curMode == DefendCarrotEnum.LevelMode_Material then
		self:_sendEndGameToServer(true)
	elseif self._curMode == DefendCarrotEnum.LevelMode_Normal then
		self:_handleGameEnd()

		local isOver = DefendCarrotGameController.instance:isGameOver()
		local isWin = DefendCarrotGameController.instance:getCurCarrotHp() > 0

		if isOver and isWin then
			self:_sendEndGameToServer(true)
		else
			self:_sendEndGameToServer(false)
		end
	end
end

function DefendCarrotGameView:_sendEndGameToServer(isWin)
	if DefendCarrotController.instance:getIsInGame() then
		if self._curMode == DefendCarrotEnum.LevelMode_Normal then
			local killInfos = DefendCarrotGameController.instance:getCurkillInfos()
			local buildInfos = DefendCarrotGameController.instance:getBuildInfos()
			local lastBuildInfos = DefendCarrotGameController.instance:getLastBuildInfos()

			DefendCarrotController.instance:endGame(self._curActivityId, self._curStageId, isWin, killInfos, buildInfos, lastBuildInfos)
		elseif self._curMode == DefendCarrotEnum.LevelMode_Material then
			local curWave, totalWave = DefendCarrotGameController.instance:getCurWave()

			DefendCarrotController.instance:endMaterialGame(self._curActivityId, self._curStageId, isWin, curWave - 1)
		end
	else
		self:close()
	end
end

function DefendCarrotGameView:resetMapCell()
	goutil.clearChildren(self._layer_map)
	goutil.clearChildren(self._layer_bubble)

	self._bubbleCellMap = {}

	local gridRowNum, gridColNum = DefendCarrotGameController.instance:getCurRowNumAndColNum()

	for i = 1, gridRowNum do
		for j = 1, gridColNum do
			local gridData = DefendCarrotGameController.instance:getGridDataByRowCol(i, j)
			local typeCfg = gridData:getCellTypeCfg()
			local gridState = gridData:getGridState()

			if gridState == DefendCarrotEnum.GridState.RoadFirst or gridState == DefendCarrotEnum.GridState.RoadMiddle or gridState == DefendCarrotEnum.GridState.RoadEnd or gridState == DefendCarrotEnum.GridState.Wall then
				local mapCell = self:createMapCell(i, j)
				local bgRoadChange = goutil.findChildComponent(mapCell, "bgRoad", "UIImageSpriteChange")

				bgRoadChange:ChangeSprite(typeCfg.resPath)

				local img = goutil.findChildComponent(mapCell, "bgRoad", "Image")

				img:SetNativeSize()

				if gridState == DefendCarrotEnum.GridState.RoadEnd then
					local posX, posY = DefendCarrotGameController.instance:rowCol2Pos(i, j)

					GameUtil.setAnchoredPos(self._hpGo, posX, posY)
				end
			elseif gridData:isObstaclePos() then
				DefendCarrotGameController.instance:createObstacle(i, j, typeCfg)
			end

			local addParam = gridData:getAddParam()
			local specialGridCfg = DefendCarrotConfig.instance:getMapBuffCfg(addParam)

			if specialGridCfg then
				local bubbleCell = {}

				bubbleCell.go = goutil.cloneAndSetParent(self._template_bubble, self._layer_bubble.transform, "bubble_" .. i .. "_" .. j)
				bubbleCell.bubble = goutil.findChild(bubbleCell.go, "bubble")
				bubbleCell.iconChange = goutil.findChildComponent(bubbleCell.go, "icon", "UIImageSpriteChange")
				bubbleCell.weaponId = specialGridCfg.weaponId

				local weaponCfg = DefendCarrotConfig.instance:getWeaponCfg(self._curActivityId, specialGridCfg.weaponId)

				if weaponCfg then
					bubbleCell.iconChange:ChangeSprite(weaponCfg.weaponPic)

					local img = bubbleCell.iconChange:GetComponent(goutil.Type_UIImage)

					img:SetNativeSize()
				end

				local posX, posY = DefendCarrotGameController.instance:rowCol2Pos(i, j)

				GameUtil.setAnchoredPos(bubbleCell.go, posX, posY)

				if self._bubbleCellMap[i] == nil then
					self._bubbleCellMap[i] = {}
				end

				self._bubbleCellMap[i][j] = bubbleCell

				GameUtil.SetGray(bubbleCell.bubble, false)
				goutil.setActive(bubbleCell.go, true)
			end
		end
	end
end

function DefendCarrotGameView:createMapCell(i, j)
	local mapCell = goutil.cloneAndSetParent(self._template_map, self._layer_map.transform, "map_" .. i .. "_" .. j)
	local xx, yy = DefendCarrotGameController.instance:rowCol2Pos(i, j)

	GameUtil.setAnchoredPos(mapCell, xx, yy)
	goutil.setActive(mapCell, true)

	return mapCell
end

function DefendCarrotGameView:_onClickClose()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
		TipsFacade.instance:openPopupWindow("提示", "是否返回主界面？该操作将立即结算当前奖励！", function()
			self._stateMachine:gotoState(STATE_GAME_END)
		end, function()
			self._stateMachine:gotoState(STATE_RUNING)
		end)
	elseif self._stateMachine.currStateName == STATE_PAUSE then
		TipsFacade.instance:openPopupWindow("提示", "是否返回主界面？该操作将立即结算当前奖励", function()
			self._stateMachine:gotoState(STATE_GAME_END)
		end)
	else
		self:close()
	end
end

function DefendCarrotGameView:_onClickEvent(eventData)
	if self._stateMachine.currStateName ~= STATE_RUNING and self._stateMachine.currStateName ~= STATE_PAUSE and self._stateMachine.currStateName ~= STATE_READY then
		return
	end

	self:_onClickHide()

	local vec = goutil.screenToLocalPos(eventData.position, self._gamelayersCom.transform)
	local i, j = DefendCarrotGameController.instance:pos2RowCol(vec.x + CELL_SIZE / 2, vec.y + CELL_SIZE / 2)
	local posX, posY = DefendCarrotGameController.instance:rowCol2Pos(i, j)

	if self._curSelectCol == j and self._curSelectRow == i then
		self._curSelectRow = nil
		self._curSelectCol = nil

		return
	end

	self._curSelectRow = i
	self._curSelectCol = j

	local gridData = DefendCarrotGameController.instance:getGridDataByRowCol(i, j)

	if gridData then
		local state = gridData:getGridState()

		if state == DefendCarrotEnum.GridState.ExistUnit then
			local unit = gridData:getUnit()

			if unit:getType() == DefendCarrotEnum.UnitType.Weapon then
				GameUtil.SetActive(self._buildInfo, false)
				GameUtil.SetActive(self._returnInfo, true)

				self._txtReturnCoin.text = unit:getResetReturn()

				local radius = unit:getRadius()

				GameUtil.setWidth(self._radiusWeapon, 2 * radius)
				GameUtil.setHeight(self._radiusWeapon, 2 * radius)
				GameUtil.setAnchoredPos(self._buildGo, posX, posY)
				GameUtil.SetActive(self._buildGo, true)
			end
		elseif state == DefendCarrotEnum.GridState.Empty then
			GameUtil.SetActive(self._buildInfo, true)
			GameUtil.SetActive(self._returnInfo, false)
			GameUtil.setAnchoredPos(self._buildGo, posX, posY)
			GameUtil.SetActive(self._buildGo, true)
		else
			DefendCarrotGameController.instance:getNearestTarget(vec.x, vec.y, 60)
		end
	end
end

function DefendCarrotGameView:_restartGame()
	self:resetAllEff()
	DefendCarrotGameController.instance:resetGame()
	self:resetMapCell()
	self:_updateCurCoin()
	self:_updateCurHp()
	self:_updateCurWave()

	local ruleKey = "defendcarrotgameview_" .. self._curMode
	local key = string.format("%s_mode_%s_%s", self._viewPresentor.viewName, self._curMode, self._curActivityId)

	GameUtil.doCallbackWhenFirst(key, function()
		TipsFacade.instance:openImageRuleViewByKey(ruleKey, "游戏规则", function()
			if self._curMode == DefendCarrotEnum.LevelMode_Normal then
				self:_onClickTask()
			else
				self._stateMachine:gotoState(STATE_READY)
			end
		end)
	end, function()
		if self._curMode == DefendCarrotEnum.LevelMode_Normal then
			self:_onClickTask()
		else
			self._stateMachine:gotoState(STATE_READY)
		end
	end)
end

function DefendCarrotGameView:_onClickBuild(weaponId)
	self:_onClickHide()
	DefendCarrotGameController.instance:buildWeaponAtRowCol(self._curSelectRow, self._curSelectCol, weaponId)
end

function DefendCarrotGameView:_onClickReturnWeapon()
	self:_onClickHide()
	DefendCarrotGameController.instance:recycleWeaponAt(self._curSelectRow, self._curSelectCol)
end

function DefendCarrotGameView:_onClickHide()
	goutil.setActive(self._buildGo, false)
end

function DefendCarrotGameView:_onClickPause()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	elseif self._stateMachine.currStateName == STATE_PAUSE then
		self._stateMachine:gotoState(STATE_RUNING)
	end
end

function DefendCarrotGameView:_updatePauseBtn()
	if self._stateMachine.currStateName == STATE_PAUSE then
		self._imgState:SetState(0)
	else
		self._imgState:SetState(1)
	end
end

function DefendCarrotGameView:_updateCurWave()
	local curWave, totalWave = DefendCarrotGameController.instance:getCurWave()

	self._txtCurWave.text = string.format("第%d/%d波怪物", curWave, totalWave)

	MaterialMgr.resetAll(self._iconCurPrize)

	local curPrizeType, curPrizeId, curNum = DefendCarrotConfig.instance:getMaterialClgPrizeParams(self._curActivityId, self._curStageId, curWave - 1)

	if curNum > 0 then
		self._txtCurPrize.text = string.format("第%d波怪物,累计 %d", curWave, curNum)

		MaterialMgr.setIcon(self._iconCurPrize, curPrizeType, curPrizeId)
	else
		self._txtCurPrize.text = string.format("第%d波怪物", curWave)
	end
end

function DefendCarrotGameView:_changeCoin(changeValue)
	self:_updateCurCoin()
end

function DefendCarrotGameView:_updateCurCoin()
	self._txtCurCoin.text = DefendCarrotGameController.instance:getCurCoin()
end

function DefendCarrotGameView:_changeHp()
	self:_updateCurHp()
end

function DefendCarrotGameView:_updateCurHp()
	self._txtCurHp.text = DefendCarrotGameController.instance:getCurCarrotHp()
end

function DefendCarrotGameView:_resumesRunning()
	if self._stateMachine.currStateName == STATE_PAUSE then
		self:_onClickHide()
		self._stateMachine:gotoState(STATE_RUNING)
	elseif self._stateMachine.currStateName == STATE_INIT then
		self._stateMachine:gotoState(STATE_READY)
	end
end

function DefendCarrotGameView:_onClickTask()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	UIStateManager.instance:push(ViewName.DefendCarrotTaskView, self._curActivityId, self._curStageId)
end

function DefendCarrotGameView:_onClickSpecialGrid()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	UIStateManager.instance:push(ViewName.DefendCarrotSpecialGridView, self._curActivityId, self._curStageId)
end

function DefendCarrotGameView:_handleGameEnd()
	UIStateManager.instance:push(ViewName.DefendCarrotResultView, self._curActivityId, self._curStageId)
end

function DefendCarrotGameView:_handleMaterialClgEndGame()
	local addstr = ""
	local curHp = DefendCarrotGameController.instance:getCurCarrotHp()
	local hpMax = DefendCarrotGameController.instance:getCarrotHpMax()
	local curWave = DefendCarrotGameController.instance:getCurWave()
	local stageCfg = DefendCarrotConfig.instance:getMaterialClgByStageId(self._curActivityId, self._curStageId)
	local curPrizeType, curPrizeId, curNum = DefendCarrotConfig.instance:getMaterialClgPrizeParams(self._curActivityId, self._curStageId, curWave - 1)

	if curNum > 0 then
		local addMatStr = MaterialMgr.getContentMatStr(curPrizeType .. ":" .. curPrizeId, 60, 0, true)

		addstr = string.format("\n获得：%s%s", curNum, addMatStr)
	end

	local str = string.format("恭喜您成功通关资源关卡-%s\n\n奥奇剩余血量：%s/%s\n击杀怪物：%s波次%s", (stageCfg or nil) and stageCfg.stagename, curHp, hpMax, curWave - 1, addstr)

	TipsFacade.instance:openTipWindowNoX("挑战成功", str, function()
		self:close()
	end, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function DefendCarrotGameView:_updateBuildCell(view, cell, data, tag)
	local weaponLv = DefendCarrotModel.instance:getWeaponLevel(self._curActivityId, data)
	local weaponCfg = DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, data, weaponLv)

	if not weaponCfg then
		printError("DefendCarrotGameView:_updateBuildCell 武器等级空配置 id:", data, " lv:", weaponLv)

		return
	end

	local go = cell.gameObject
	local iconWeapon = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")
	local imageIcon = iconWeapon:GetComponent(goutil.Type_UIImage)
	local txtCoin = goutil.findChildTextComponent(go, "coin/txt")
	local txtLv = goutil.findChildTextComponent(go, "lv/txt")

	iconWeapon:ChangeSprite(weaponCfg.resPath)
	imageIcon:SetNativeSize()

	txtCoin.text = weaponCfg.setCost
	txtLv.text = weaponCfg.level

	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickBuild, self, data))
	GameUtil.SetActive(go, true)
end

function DefendCarrotGameView:_clearBuildCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function DefendCarrotGameView:_onClickTips()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	local key = "defendcarrotgameview_" .. self._curMode

	TipsFacade.instance:openImageRuleViewByKey(key, "游戏规则", function()
		if self._stateMachine.currStateName == STATE_PAUSE then
			self._stateMachine:gotoState(STATE_RUNING)
		end
	end)
end

function DefendCarrotGameView:_onUpdateWeaponInfo(row, col, weaponType)
	local bubbleCell

	if self._bubbleCellMap and self._bubbleCellMap[row] then
		bubbleCell = self._bubbleCellMap[row][col]
	end

	if bubbleCell then
		if weaponType < 0 then
			GameUtil.SetGray(bubbleCell.go, false)
			GameUtil.SetActive(bubbleCell.iconChange.gameObject, true)
		else
			GameUtil.SetActive(bubbleCell.iconChange.gameObject, false)

			if weaponType == bubbleCell.weaponId then
				GameUtil.SetGray(bubbleCell.go, false)
			else
				GameUtil.SetGray(bubbleCell.go, true)
			end
		end
	end
end

function DefendCarrotGameView:playEffect(x, y)
	if self._playEffId == nil then
		self._playEffId = 0
	end

	self._playEffId = self._playEffId + 1
	self._playEffList = self._playEffList or {}

	local effPath = "20250926/baoweiluobo/fx_ui_chuxian.prefab"

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(self._layer_eff.transform)
		eff:setLocalPos(x, y, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	local function onComplete()
		self:resetEff(self._playEffId)
	end

	self._playEffList[self._playEffId] = UIEffectManager.instance:playEffect(self, effPath, self._layer_eff.transform, 0, 0, false, false, onComplete, loadedHandler)
end

function DefendCarrotGameView:playHurtEffect(x, y)
	if self._playEffId == nil then
		self._playEffId = 0
	end

	self._playEffId = self._playEffId + 1
	self._playEffList = self._playEffList or {}

	local effPath = "20250926/baoweiluobo/fx_ui_xiaoshi.prefab"

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(self._layer_eff.transform)
		eff:setLocalPos(x, y, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	local function onComplete()
		self:resetEff(self._playEffId)
	end

	self._playEffList[self._playEffId] = UIEffectManager.instance:playEffect(self, effPath, self._layer_eff.transform, 0, 0, false, false, onComplete, loadedHandler)
end

function DefendCarrotGameView:resetEff(playEffId)
	self._playEffList = self._playEffList or {}

	local eff = self._playEffList[playEffId]

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._playEffList[playEffId] = nil
	end
end

function DefendCarrotGameView:resetAllEff()
	if self._playEffList then
		for k, v in pairs(self._playEffList) do
			if v then
				UIEffectManager.instance:stopEffect(v)
			end
		end

		self._playEffList = {}
	end
end

return DefendCarrotGameView
