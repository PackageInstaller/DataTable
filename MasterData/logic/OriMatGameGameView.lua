-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameGameView.lua

module("logic.extensions.orimatgame.view.OriMatGameGameView", package.seeall)

local OriMatGameGameView = class("OriMatGameGameView", ViewComponent)
local STATE_INIT = "STATE_INIT"
local STATE_READY = "STATE_READY"
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"
local CELL_SIZE = 98

function OriMatGameGameView:ctor()
	OriMatGameGameView.super.ctor(self)
end

function OriMatGameGameView:unbindEvents()
	OriMatGameGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReturn)
	GameUtil.rmClickHandler(self._btnUpgrade)
	GameUtil.rmClickHandler(self._btnPause)
	GameUtil.rmClickHandler(self._btnSpecial)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTimeRate)

	if self._clickEventHandler then
		PointerClickHandler.Get(self._eventclicker):RemoveLuaHandler(self._clickEventHandler)

		self._clickEventHandler = nil
	end
end

function OriMatGameGameView:bindEvents()
	OriMatGameGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnReturn, self._onClickReturnWeapon, self)
	GameUtil.addClickHandler(self._btnUpgrade, self._onClickUpgrade, self)
	GameUtil.addClickHandler(self._btnPause, self._onClickPause, self)
	GameUtil.addClickHandler(self._btnSpecial, self._onClickSpecialGrid, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnTimeRate, self._onClickTimeRate, self)

	self._clickEventHandler = PointerClickHandler.Get(self._eventclicker):AddLuaHandler(function(go, eventData)
		self:_onClickEvent(eventData)
	end)

	self._blessingViewCustomInput:AddListener(function(view, hover)
		if not hover then
			self:_showBlessingView(false)
		end
	end, self)
end

function OriMatGameGameView:buildUI()
	OriMatGameGameView.super.buildUI(self)

	self._imgBg = self:getGo("imgBg")
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
	self._btnPause = self:getGo("topBtns/btnPause")
	self._imgState = self:getGo("topBtns/btnPause/imgState"):GetComponent("UIImageSpriteChange")
	self._btnSpecial = self:getGo("topBtns/btnSpecial")
	self._txtBtnTimeRate = self:getTxt("topBtns/btnTimeRate/txt")
	self._btnTimeRate = self:getGo("topBtns/btnTimeRate")
	self._txtCurCoin = self:getTxt("topBtns/curCoin/txt")
	self._txtBlessingEnergy = self:getTxt("blessingEnergy/txt")
	self._blessingEnergySliderComp = self:getSlider("blessingEnergy/slider")
	self._txtBlessingCount = self:getTxt("blessingEnergy/txtCount")
	self._curWave = self:getGo("otherInfo/curWave")
	self._txtCurWave = self:getTxt("otherInfo/curWave/txt")
	self._buildGo = self:getGo("gamelayers/buildGo")
	self._buildInfo = self:getGo("gamelayers/buildGo/build")
	self._buildTableviewGo = self:getGo("gamelayers/buildGo/build/tableview")
	self._weaponCellGo = self:getGo("gamelayers/buildGo/build/tableview/tablecell")
	self._buildTableview = ScrollerList.create(self._buildTableviewGo, self._weaponCellGo, GameUtil.handler(self._updateBuildCell, self), GameUtil.handler(self._clearBuildCell, self))
	self._roulette = self:getGo("gamelayers/buildGo/roulette")
	self._radiusWeapon = self:getGo("gamelayers/buildGo/roulette/radius")
	self._btnReturn = self:getGo("gamelayers/buildGo/roulette/return/btn")
	self._txtReturnCoin = self:getTxt("gamelayers/buildGo/roulette/return/coin/txt")
	self._btnUpgrade = self:getGo("gamelayers/buildGo/roulette/upgrade/btn")
	self._iconCoinUpgrade = self:getGo("gamelayers/buildGo/roulette/upgrade/coin/icon")
	self._txtCoinUpgrade = self:getTxt("gamelayers/buildGo/roulette/upgrade/coin/txt")

	local blessingScrView = self:getGo("blessingCol/scrView")
	local blessingScrCell = self:getGo("blessingCol/scrCell")

	self._blessingScrollerList = ScrollerList.create(blessingScrView, blessingScrCell, GameUtil.handler(self._updateBlessingCell, self), GameUtil.handler(self._clearBlessingCell, self))
	self._blessingView = self:getGo("blessingView")
	self._blessingItemScrView = self:getGo("blessingView/scrView")

	local blessingItemScrCell = self:getGo("blessingView/scrView/scrCell")

	self._blessingItemScrollerList = ScrollerList.create(self._blessingItemScrView, blessingItemScrCell, GameUtil.handler(self._updateBlessingItemCell, self), GameUtil.handler(self._clearBlessingItemCell, self))
	self._blessingViewCustomInput = UICustomInput.Get(self._blessingView)
	self._heightBlessingViewTwo = GameUtil.getHeight(self._blessingItemScrView)
	self._heightBlessingViewOne = GameUtil.getHeight(blessingItemScrCell)
	self._flyitem = self:getGo("flyitem")
	self._flyitem2 = self:getGo("flyitem2")
	self._flyitem3 = self:getGo("flyitem3")
	self._textCon = self:getGo("gamelayers/textCon")
	self._hpGo = self:getGo("gamelayers/layer_Hp/hp")
	self._txtCurHp = self:getTxt("gamelayers/layer_Hp/hp/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._layer_eff = self:getGo("gamelayers/layer_eff")
	self._ready = self:getGo("ready")
	self._imgNumReady = self:getGo("ready/imgNum"):GetComponent(ComponentType.UIImgNumeralText)

	goutil.setActive(self._ready, false)
	OriMatGameGameController.instance:initGame()
	OriMatGameGameController.instance:setUnitComTemplate(OriMatGameEnum.UnitType.Monster, self._template_monster)
	OriMatGameGameController.instance:setUnitComTemplate(OriMatGameEnum.UnitType.Obstacle, self._template_obstacle)
	OriMatGameGameController.instance:setUnitComTemplate(OriMatGameEnum.UnitType.Weapon, self._template_weapon)
	OriMatGameGameController.instance:setUnitComTemplate(OriMatGameEnum.UnitType.Bullet, self._template_bullet)
	self:_initFSM()
end

function OriMatGameGameView:destroyUI()
	OriMatGameGameController.instance:destroyGame()
end

function OriMatGameGameView:_initFSM()
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

function OriMatGameGameView:onExit()
	OriMatGameGameView.super.onExit(self)
	OriMatGameController.instance:stopGameBgMusic()
	uGuiUtil.clearImage(self._imgBg)
	OriMatGameGameController.instance:resetGame()
	self._stateMachine:stopTimer()
	AQAFSimpleFloatTipsMgr.instance:clearAll()
	self._buildTableview:dispose()
	removetimer(self._onReadyCountDown, self)
	self:_onClearBlessingCol()
	self:_onClearBlessingView()
	ResGcMgr.instance:gc()
	self:resetAllEff()
end

function OriMatGameGameView:onEnter()
	OriMatGameGameView.super.onEnter(self)
	OriMatGameController.instance:playGameBgMusic(20200)
	self.addGEvent(self, GlobalNotify.OriMatGameUpdateWave, self._updateCurWave, self)
	self.addGEvent(self, GlobalNotify.OriMatGameChangeCoin, self._changeCoin, self)
	self.addGEvent(self, GlobalNotify.OriMatGameChangeHP, self._changeHp, self)
	self.addGEvent(self, GlobalNotify.OriMatGameResumesRunning, self._resumesRunning, self)
	self.addGEvent(self, GlobalNotify.OriMatGameShowAlertTxt, self._onShowAlertTips, self)
	self.addGEvent(self, GlobalNotify.OriMatGameUpdateWeaponBuildInfo, self._onUpdateWeaponInfo, self)
	self.addGEvent(self, GlobalNotify.OriMatGameUpgradeWeapon, self._onWeaponUpgrade, self)
	self.addGEvent(self, GlobalNotify.OriMatGamePlayEffect, self.playEffect, self)
	self.addGEvent(self, GlobalNotify.OriMatGamePlayXiaoShiEffect, self.playHurtEffect, self)
	self.addGEvent(self, GlobalNotify.OriMatGameChangeBlessingEnergy, self._updateCurBlessingEnergy, self)
	self.addGEvent(self, GlobalNotify.OriMatGameBlessingSelect, self._onBlessingSelect, self)
	self.addGEvent(self, GlobalNotify.OriMatGameBlessingActive, self._oriMatGameBlessingActive, self)

	local params = self:getOpenParam()

	self._seasonId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	if self._seasonId <= 0 then
		self._seasonId = 1

		printError("缺失赛季id")
	end

	self:_updateUIByCfg()

	if not self:_checkCfgValid() then
		self:close()

		return
	end

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_INIT)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, self._flyitem, AQAFFloatItem, 100)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_ENERGY_TEXT, self._flyitem3, FloatWordItem, 100)
end

function OriMatGameGameView:_onGameGc()
	ResGcMgr.instance:gc()
end

function OriMatGameGameView:_onShowAlertTips(content, x, y, type)
	if type == nil then
		AQAFSimpleFloatTipsMgr.instance:flyText(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, content, self._textCon, x + math.random(-40, 40), y)
	else
		AQAFSimpleFloatTipsMgr.instance:flyText(type, content, self._textCon, x + math.random(-40, 40), y)
	end
end

function OriMatGameGameView:_oriMatGameBlessingActive()
	self:_onUpdateBlessingCol()
	self:_updateCurBlessingEnergy()
end

function OriMatGameGameView:_checkCfgValid()
	if not self._gameCfg then
		printError("OriMatGameGameView:_checkCfgValid no gameCfg")

		return false
	end

	return true
end

function OriMatGameGameView:_updateUIByCfg()
	self._gameCfg = nil

	goutil.setActive(self._curWave, true)

	local seasonData = OriMatGameConfig.instance:getSeasonData(self._seasonId)
	local stageCfg = OriMatGameConfig.instance:getStageCfgByStageId(seasonData.stagePlanId, self._stageId)

	if stageCfg then
		self._gameCfg = OriMatGameConfig.instance:getGamePlanCfg(stageCfg.gamePlanId)
	end

	if not self._gameCfg then
		return
	end

	if string.nilorempty(self._gameCfg.bgPath) then
		uGuiUtil.clearImage(self._imgBg)
	else
		local spriteName = GameUrl.getBigbgPngUrl(self._gameCfg.bgPath)

		uGuiUtil.setSpriteToImage(self._imgBg, uGuiUtil.SpriteType.BigBg, spriteName, function()
			self._imgBg:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
	end

	OriMatGameGameController.instance:setMapCellWidth(CELL_SIZE)
	OriMatGameGameController.instance:setGameConfig(self._gameCfg)
	self:_onClickHide()

	local selectedWeaponIds = OriMatGameGameController.instance:getSelectedWeaponIds()

	if #selectedWeaponIds == 0 then
		printError(">>>>>>>>>>>>>> 玩家未选择武器！")
	else
		self._buildTableview:reloadData(selectedWeaponIds)
	end

	self._mapBuffIdList = OriMatGameConfig.instance:getMapBuffIdListInMapData(self._gameCfg.gamePlanId)

	GameUtil.SetActive(self._btnSpecial, #self._mapBuffIdList > 0)
end

function OriMatGameGameView:_onEnterInit()
	self:_updatePauseBtn()
	self:_restartGame()
end

function OriMatGameGameView:_onEnterReady()
	goutil.setActive(self._ready, true)

	self._readyTimer = 3

	self._imgNumReady:SetNum(self._readyTimer)
	settimer(1, self._onReadyCountDown, self, true)
	TipsFacade.instance:openCommonTips("怪物即将来袭，请做好准备！")
end

function OriMatGameGameView:_onReadyCountDown()
	self._readyTimer = self._readyTimer - 1

	if self._readyTimer <= 0 then
		self._stateMachine:gotoState(STATE_RUNING)
	else
		self._imgNumReady:SetNum(self._readyTimer)
	end
end

function OriMatGameGameView:_onExistReady()
	goutil.setActive(self._ready, false)
	removetimer(self._onReadyCountDown, self)
end

function OriMatGameGameView:_onEnterRunning()
	self:_updatePauseBtn()
end

function OriMatGameGameView:_onRunning()
	if OriMatGameGameController.instance:isGameOver() then
		self._stateMachine:gotoState(STATE_GAME_END)
	else
		OriMatGameGameController.instance:updateGame()
	end
end

function OriMatGameGameView:_onEnterPause()
	self:_updatePauseBtn()
end

function OriMatGameGameView:_onExitPause()
	self:_updatePauseBtn()
end

function OriMatGameGameView:_onEnterGameEnd()
	self:_onClickHide()

	local isOver = OriMatGameGameController.instance:isGameOver()
	local isWin = OriMatGameGameController.instance:getCurCarrotHp() > 0
	local isPass = isOver and isWin or false

	if OriMatGameController.instance:getIsInGame() then
		UIStateManager.instance:push(ViewName.OriMatGameResultView, self._seasonId, self._stageId, isPass)
	else
		self:close()
	end
end

function OriMatGameGameView:resetMapCell()
	goutil.clearChildren(self._layer_map)
	goutil.clearChildren(self._layer_bubble)

	self._bubbleCellMap = {}

	local gridRowNum, gridColNum = OriMatGameGameController.instance:getCurRowNumAndColNum()

	for i = 1, gridRowNum do
		for j = 1, gridColNum do
			local gridData = OriMatGameGameController.instance:getGridDataByRowCol(i, j)
			local typeCfg = gridData:getCellTypeCfg()
			local gridState = gridData:getGridState()

			if gridState == OriMatGameEnum.GridState.RoadFirst or gridState == OriMatGameEnum.GridState.RoadMiddle or gridState == OriMatGameEnum.GridState.RoadEnd or gridState == OriMatGameEnum.GridState.Wall then
				local mapCell = self:createMapCell(i, j)
				local bgRoadChange = goutil.findChildComponent(mapCell, "bgRoad", "UIImageSpriteChange")

				bgRoadChange:ChangeSprite(typeCfg.resPath)

				local img = goutil.findChildComponent(mapCell, "bgRoad", "Image")

				img:SetNativeSize()

				if gridState == OriMatGameEnum.GridState.RoadEnd then
					local posX, posY = OriMatGameGameController.instance:rowCol2Pos(i, j)

					GameUtil.setAnchoredPos(self._hpGo, posX, posY)
				end
			elseif gridData:isObstaclePos() then
				OriMatGameGameController.instance:createObstacle(i, j, typeCfg)
			end

			local addParam = gridData:getAddParam()
			local specialGridCfg = OriMatGameConfig.instance:getMapBuffCfg(addParam)

			if specialGridCfg then
				local bubbleCell = {}

				bubbleCell.go = goutil.cloneAndSetParent(self._template_bubble, self._layer_bubble.transform, "bubble_" .. i .. "_" .. j)
				bubbleCell.bubble = goutil.findChild(bubbleCell.go, "bubble")
				bubbleCell.iconChange = goutil.findChildComponent(bubbleCell.go, "icon", "UIImageSpriteChange")
				bubbleCell.weaponId = specialGridCfg.weaponId

				local weaponCfg = OriMatGameConfig.instance:getWeaponCfg(specialGridCfg.weaponId)

				if weaponCfg then
					bubbleCell.iconChange:ChangeSprite(weaponCfg.weaponPic)

					local img = bubbleCell.iconChange:GetComponent(goutil.Type_UIImage)

					img:SetNativeSize()
				end

				local posX, posY = OriMatGameGameController.instance:rowCol2Pos(i, j)

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

function OriMatGameGameView:createMapCell(i, j)
	local mapCell = goutil.cloneAndSetParent(self._template_map, self._layer_map.transform, "map_" .. i .. "_" .. j)
	local xx, yy = OriMatGameGameController.instance:rowCol2Pos(i, j)

	GameUtil.setAnchoredPos(mapCell, xx, yy)
	goutil.setActive(mapCell, true)

	return mapCell
end

function OriMatGameGameView:_onClickClose()
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

function OriMatGameGameView:_onClickEvent(eventData)
	if self._stateMachine.currStateName ~= STATE_RUNING and self._stateMachine.currStateName ~= STATE_PAUSE and self._stateMachine.currStateName ~= STATE_READY then
		return
	end

	self:_onClickHide()

	local vec = goutil.screenToLocalPos(eventData.position, self._gamelayersCom.transform)
	local i, j = OriMatGameGameController.instance:pos2RowCol(vec.x + CELL_SIZE / 2, vec.y + CELL_SIZE / 2)
	local posX, posY = OriMatGameGameController.instance:rowCol2Pos(i, j)

	if self._curSelectCol == j and self._curSelectRow == i then
		self._curSelectRow = nil
		self._curSelectCol = nil

		return
	end

	self._curSelectRow = i
	self._curSelectCol = j

	local gridData = OriMatGameGameController.instance:getGridDataByRowCol(i, j)

	if gridData then
		local state = gridData:getGridState()

		if state == OriMatGameEnum.GridState.ExistUnit then
			local unit = gridData:getUnit()

			if unit:getType() == OriMatGameEnum.UnitType.Weapon then
				GameUtil.SetActive(self._roulette, true)
				GameUtil.SetActive(self._buildInfo, false)

				self._txtReturnCoin.text = unit:getResetReturn()

				local radius = unit:getRadius()

				self._txtCoinUpgrade.text = unit:isMaxLevel() and "已满级" or unit:getUpgradeCost()

				GameUtil.setWidth(self._radiusWeapon, 2 * radius)
				GameUtil.setHeight(self._radiusWeapon, 2 * radius)
				GameUtil.setAnchoredPos(self._buildGo, posX, posY)
				GameUtil.SetActive(self._buildGo, true)
			end
		elseif state == OriMatGameEnum.GridState.Empty then
			GameUtil.SetActive(self._roulette, false)
			GameUtil.SetActive(self._buildInfo, true)
			GameUtil.setAnchoredPos(self._buildGo, posX, posY)
			GameUtil.SetActive(self._buildGo, true)
		else
			OriMatGameGameController.instance:getNearestTarget(vec.x, vec.y, 60)
		end
	end
end

function OriMatGameGameView:_restartGame()
	self:resetAllEff()
	OriMatGameGameController.instance:resetGame()
	self:resetMapCell()
	self:_updateCurCoin()
	self:_updateCurBlessingEnergy()
	self:_updateCurHp()
	self:_updateCurWave()
	self:_onUpdateBlessingCol()
	self:_showBlessingView(false)
	self:_updateBtnTimeRateUI()
	GameUtil.SetActive(self._btnSpecial, #self._mapBuffIdList > 0)

	local key = string.format("orimatgamegameview_rule_%s", self._seasonId)

	GameUtil.doCallbackWhenFirst(key, function()
		local key = OriMatGameConfig.instance:getCommonValue("IMAGE_RULEKEY_GAME")

		TipsFacade.instance:openImageRuleViewByKey(key, "游戏规则", function()
			self._stateMachine:gotoState(STATE_READY)
		end)
	end, function()
		self._stateMachine:gotoState(STATE_READY)
	end)
end

function OriMatGameGameView:_onClickBuild(weaponId)
	self:_onClickHide()
	OriMatGameGameController.instance:buildWeaponAtRowCol(self._curSelectRow, self._curSelectCol, weaponId)

	self._curSelectRow = nil
	self._curSelectCol = nil
end

function OriMatGameGameView:_onClickReturnWeapon()
	self:_onClickHide()
	OriMatGameGameController.instance:recycleWeaponAt(self._curSelectRow, self._curSelectCol)

	self._curSelectRow = nil
	self._curSelectCol = nil
end

function OriMatGameGameView:_onClickUpgrade()
	self:_onClickHide()
	OriMatGameGameController.instance:upgradeWeaponAt(self._curSelectRow, self._curSelectCol)

	self._curSelectRow = nil
	self._curSelectCol = nil
end

function OriMatGameGameView:_onClickHide()
	goutil.setActive(self._buildGo, false)
end

function OriMatGameGameView:_onClickPause()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	elseif self._stateMachine.currStateName == STATE_PAUSE then
		self._stateMachine:gotoState(STATE_RUNING)
	end
end

function OriMatGameGameView:_updatePauseBtn()
	if self._stateMachine.currStateName == STATE_PAUSE then
		self._imgState:SetState(0)
	else
		self._imgState:SetState(1)
	end
end

function OriMatGameGameView:_updateCurWave()
	local curWave, totalWave = OriMatGameGameController.instance:getCurWave()

	self._txtCurWave.text = string.format("第%d/%d波怪物", curWave, totalWave)
end

function OriMatGameGameView:_changeCoin(changeValue)
	self:_updateCurCoin()
	self:_refreshAllWeaponUpgradeFlag()
end

function OriMatGameGameView:_updateCurCoin()
	self._txtCurCoin.text = OriMatGameGameController.instance:getCurCoin()
end

function OriMatGameGameView:_updateCurBlessingEnergy()
	local count = OriMatGameGameController.instance:getCurBlessingCount()
	local maxCount = OriMatGameGameController.instance:getMaxBlessingCount()
	local energy = OriMatGameGameController.instance:getCurBlessingEnergy()
	local maxEnergy = OriMatGameGameController.instance:getMaxBlessingEnergy()

	if self._txtBlessingCount then
		self._txtBlessingCount.text = string.format("数量：%s/%s", count, maxCount)
	end

	if maxCount <= count then
		self._txtBlessingEnergy.text = "祝福已满"

		self._blessingEnergySliderComp:SetValue(1)
	else
		self._txtBlessingEnergy.text = string.format("%s/%s", energy, maxEnergy)

		self._blessingEnergySliderComp:SetValue((maxEnergy ~= 0 or nil) and energy / maxEnergy)
	end
end

function OriMatGameGameView:_changeHp()
	self:_updateCurHp()
end

function OriMatGameGameView:_updateCurHp()
	self._txtCurHp.text = OriMatGameGameController.instance:getCurCarrotHp()
end

function OriMatGameGameView:_resumesRunning()
	if self._stateMachine.currStateName == STATE_PAUSE then
		self:_onClickHide()
		self._stateMachine:gotoState(STATE_RUNING)
	elseif self._stateMachine.currStateName == STATE_INIT then
		self._stateMachine:gotoState(STATE_READY)
	end
end

function OriMatGameGameView:_onClickSpecialGrid()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	UIStateManager.instance:push(ViewName.OriMatGameSpecialGridView, self._mapBuffIdList)
end

function OriMatGameGameView:_updateBuildCell(view, cell, data, tag)
	local weaponLv = 1
	local weaponCfg = OriMatGameConfig.instance:getWeaponLevelCfgByWeapon(data, weaponLv)

	if not weaponCfg then
		printError("OriMatGameGameView:_updateBuildCell 武器等级空配置 id:", data, " lv:", weaponLv)

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

function OriMatGameGameView:_clearBuildCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function OriMatGameGameView:_onClickTips()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	local key = OriMatGameConfig.instance:getCommonValue("IMAGE_RULEKEY_GAME")

	TipsFacade.instance:openImageRuleViewByKey(key, "游戏规则", function()
		if self._stateMachine.currStateName == STATE_PAUSE then
			self._stateMachine:gotoState(STATE_RUNING)
		end
	end)
end

function OriMatGameGameView:_onUpdateWeaponInfo(row, col, weaponType)
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

function OriMatGameGameView:_onWeaponUpgrade(row, col, weaponId)
	local unit = OriMatGameGameController.instance:getUnitByRowCol(row, col)

	if unit then
		self:playEffect(unit.position.x, unit.position.y)
	end
end

function OriMatGameGameView:playEffect(x, y)
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

function OriMatGameGameView:playHurtEffect(x, y)
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

function OriMatGameGameView:resetEff(playEffId)
	self._playEffList = self._playEffList or {}

	local eff = self._playEffList[playEffId]

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._playEffList[playEffId] = nil
	end
end

function OriMatGameGameView:resetAllEff()
	if self._playEffList then
		for k, v in pairs(self._playEffList) do
			if v then
				UIEffectManager.instance:stopEffect(v)
			end
		end

		self._playEffList = {}
	end
end

function OriMatGameGameView:_onBlessingSelect()
	self:_updateCurBlessingEnergy()

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	UIStateManager.instance:push(ViewName.OriMatGameBuffSelectView)
end

function OriMatGameGameView:_onUpdateBlessingCol()
	local activeBlessings = OriMatGameGameController.instance:getActiveBlessings()
	local infos = {}

	for _, blessingId in ipairs(activeBlessings) do
		local blessingCfg = OriMatGameConfig.instance:getBlessingCfg(blessingId)

		if blessingCfg then
			local weaponId = blessingCfg.weaponId

			if not infos[weaponId] then
				infos[weaponId].weaponId = blessingCfg.weaponId
				infos[weaponId].num = (infos[weaponId].num or 0) + 1
				infos[weaponId] = infos[weaponId]
			end
		end
	end

	local infoList = TableUtil.toList(infos)

	table.sort(infoList, function(a, b)
		return a.weaponId < b.weaponId
	end)
	self._blessingScrollerList:reloadData(infoList)
end

function OriMatGameGameView:_onClearBlessingCol()
	self._blessingScrollerList:dispose()
end

function OriMatGameGameView:_updateBlessingCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local weaponCfg = OriMatGameConfig.instance:getWeaponCfg(info.weaponId)
	local icon = goutil.findChild(mainGo, "icon")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local weaponSpriteChange = GameUtil.getUIImageSpriteChange(icon)

	weaponSpriteChange:ChangeSprite(weaponCfg.weaponPic)
	icon:GetComponent(goutil.Type_UIImage):SetNativeSize()

	txtNum.text = info.num

	GameUtil.addClickHandler(mainGo, function()
		self:_showBlessingView(true, info.weaponId)
	end)
end

function OriMatGameGameView:_clearBlessingCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function OriMatGameGameView:_showBlessingView(isVisible, weaponId)
	if not isVisible then
		self:_onClearBlessingView()
		GameUtil.SetActive(self._blessingView, false)

		return
	end

	GameUtil.SetActive(self._blessingView, true)

	local activeBlessings = OriMatGameGameController.instance:getActiveBlessings()
	local blessingDataList = {}

	for _, blessingId in ipairs(activeBlessings) do
		local blessingCfg = OriMatGameConfig.instance:getBlessingCfg(blessingId)

		if blessingCfg and blessingCfg.weaponId == weaponId then
			table.insert(blessingDataList, blessingCfg)
		end
	end

	table.sort(blessingDataList, function(a, b)
		return a.blessingId < b.blessingId
	end)

	if #blessingDataList > 3 then
		GameUtil.setHeight(self._blessingItemScrView, self._heightBlessingViewTwo)
	else
		GameUtil.setHeight(self._blessingItemScrView, self._heightBlessingViewOne)
	end

	self._blessingItemScrollerList:reloadData(blessingDataList)
end

function OriMatGameGameView:_onClearBlessingView()
	self._blessingItemScrollerList:dispose()
end

function OriMatGameGameView:_updateBlessingItemCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local weaponId = data.weaponId
	local weaponCfg = OriMatGameConfig.instance:getWeaponCfg(weaponId)
	local buffData = OriMatGameConfig.instance:getBuffCfg(data.buffId)
	local weapIcon = goutil.findChild(mainGo, "weapIcon")
	local icon = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtName.text = data.name
	txtDesc.text = data.desc

	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)

	local weaponSpriteChange = GameUtil.getUIImageSpriteChange(weapIcon)

	weaponSpriteChange:ChangeSprite(weaponCfg.weaponPic)
	weapIcon:GetComponent(goutil.Type_UIImage):SetNativeSize()
end

function OriMatGameGameView:_clearBlessingItemCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function OriMatGameGameView:_refreshAllWeaponUpgradeFlag()
	local weaponMap = OriMatGameGameController.instance:getUnitMapByType(OriMatGameEnum.UnitType.Weapon)

	if weaponMap then
		local curCoin = OriMatGameGameController.instance:getCurCoin()

		for _, weapon in pairs(weaponMap) do
			if weapon._containerCom then
				weapon._containerCom:updateUpgradeFlag(curCoin)
			end
		end
	end
end

function OriMatGameGameView:_onClickTimeRate()
	if self._stateMachine.currStateName == STATE_PAUSE then
		return
	end

	local gameSpeedRate = OriMatGameGameController.instance:getGameSpeedRate()

	gameSpeedRate = gameSpeedRate % 2 + 1

	OriMatGameGameController.instance:setGameSpeedRate(gameSpeedRate)
	self:_updateBtnTimeRateUI()
end

function OriMatGameGameView:_updateBtnTimeRateUI()
	local gameSpeedRate = OriMatGameGameController.instance:getGameSpeedRate()

	self._txtBtnTimeRate.text = string.format("x%d", gameSpeedRate)
end

return OriMatGameGameView
