-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/view/OriginDuoLaGameClgView.lua

module("logic.extensions.originduolagame.view.OriginDuoLaGameClgView", package.seeall)

local OriginDuoLaGameClgView = class("OriginDuoLaGameClgView", ViewComponent)
local STATE_INIT = "STATE_INIT"
local STATE_READY = "STATE_READY"
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"
local STATE_END = {
	SUCCESS = "STATE_END_SUCCESS",
	TIME_UP = "STATE_END_TIME_UP",
	SURRENDER = "STATE_END_SURRENDER",
	HP_DEPLETED = "STATE_END_HP_DEPLETED",
	NONE = "STATE_END_NONE"
}
local DEFAULT_MAP_SIZE = 5
local GRID_SIZE_CONFIG = {
	[4] = {
		spacing = 1,
		cellSize = 112
	},
	[5] = {
		spacing = 1,
		cellSize = 90
	},
	[6] = {
		spacing = 0.5,
		cellSize = 80
	},
	[7] = {
		spacing = 1,
		cellSize = 64
	},
	[8] = {
		spacing = 0.5,
		cellSize = 60
	},
	[9] = {
		spacing = 0.5,
		cellSize = 50
	},
	[10] = {
		spacing = 0.05,
		cellSize = 45
	}
}
local DRAG_TRIGGER_MODE = {
	Row = "Row",
	Column = "Column",
	Empty = "Empty"
}

function OriginDuoLaGameClgView:ctor()
	OriginDuoLaGameClgView.super.ctor(self)
end

function OriginDuoLaGameClgView:unbindEvents()
	OriginDuoLaGameClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSwitchMode)
	BeginDragHandler.Get(self._conGirds):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(self._conGirds):RemoveLuaHandler(self._endDragHandler)
	DragHandler.Get(self._conGirds):RemoveLuaHandler(self._dragHandler)
	PointerDownHandler.Get(self._conGirds):RemoveLuaHandler(self._clickDownHandler)
end

function OriginDuoLaGameClgView:bindEvents()
	OriginDuoLaGameClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSwitchMode, self._onClickBtnSwitchMode, self)

	self._beginDragHandler = BeginDragHandler.Get(self._conGirds):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(self._conGirds):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
	self._dragHandler = DragHandler.Get(self._conGirds):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData)
	end)
	self._clickDownHandler = PointerDownHandler.Get(self._conGirds):AddLuaHandler(function(_go, eventData)
		self:_onClickDownHandler(_go, eventData)
	end)
end

function OriginDuoLaGameClgView:buildUI()
	OriginDuoLaGameClgView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._txtCurHp = self:getTxt("gameInfo/curHp/txt")
	self._conCurHp = self:getGo("gameInfo/curHp")
	self._conCurTimer = self:getGo("gameInfo/curtimer")
	self._txtCurTimer = self:getTxt("gameInfo/curtimer/txt")
	self._btnSwitchMode = self:getGo("btnSwitchMode")
	self._markRight = self:getGo("btnSwitchMode/markRight")
	self._markError = self:getGo("btnSwitchMode/markError")
	self._selectError = self:getGo("btnSwitchMode/selectError")
	self._selectRight = self:getGo("btnSwitchMode/selectRight")
	self._conGirds = self:getGo("conGame/conGirds")
	self._girdCell = self:getGo("girdCell")
	self._conTopTips = self:getGo("conGame/conTopTips")
	self._cellTopTips = self:getGo("cellTopTips")
	self._conLeftTips = self:getGo("conGame/conLeftTips")
	self._cellLeftTips = self:getGo("cellLeftTips")

	GameUtil.setAnchoredPos(self._conGirds, 0, 0)
end

function OriginDuoLaGameClgView:onExit()
	OriginDuoLaGameClgView.super.onExit(self)
	self._stateMachine:stopTimer()
	GameUtil.clearCells(self._conGirds, self._clearGridCell, self)
	GameUtil.clearCells(self._conTopTips, self._clearColTxtCell, self)
	GameUtil.clearCells(self._conLeftTips, self._clearRowTxtCell, self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function OriginDuoLaGameClgView:onEnter()
	OriginDuoLaGameClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDuoLaGameStartGameRes, self._handleStartGame, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDuoLaGameEndGameRes, self._handleEndGame, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = OriginDuoLaGameController.instance:getDefaultActivityId() or 0
	end

	self._stageId = checknumber(params[2])

	local ok = self:_updateUIByCfg()

	if not ok then
		self:close()

		return
	end

	self:_initFSM()
	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_INIT)
end

function OriginDuoLaGameClgView:_handleStartGame()
	TipsFacade.instance:openCommonTips(lang("挑战开始"))
	self._stateMachine:gotoState(STATE_READY)
end

function OriginDuoLaGameClgView:_handleEndGame()
	if self._curEndState == STATE_END.SUCCESS then
		TipsFacade.instance:openCommonTips(lang("挑战成功"))
	elseif self._curEndState == STATE_END.TIME_UP then
		TipsFacade.instance:openCommonTips(lang("挑战失败，时间到"))
	elseif self._curEndState == STATE_END.HP_DEPLETED then
		TipsFacade.instance:openCommonTips(lang("挑战失败，血量耗尽"))
	elseif self._curEndState == STATE_END.SURRENDER then
		TipsFacade.instance:openCommonTips(lang("挑战失败，中途退出"))
	else
		TipsFacade.instance:openCommonTips(lang("挑战结束"))
	end

	self:close()
end

function OriginDuoLaGameClgView:_updateUIByCfg()
	self._actCfg = OriginDuoLaGameConfig.instance:getActivityCfg(self._activityId) or {}

	if not self._actCfg.skinId then
		local skinId = 0
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if petSkinCfg then
			local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", skinId)

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
		end

		self._stageCfgs = OriginDuoLaGameConfig.instance:getStageCfgListByActivityId(self._activityId) or {}
		self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

		local stageCount = #self._stageCfgs

		if stageCount <= 0 then
			printError("关卡配置为空，activityId:", self._activityId)
			TipsFacade.instance:openCommonTips(lang("关卡配置异常"))

			return false
		end

		local curMaxPassId = OriginDuoLaGameModel.instance:getMaxPassStageId(self._activityId)
		local defaultStageId = Mathf.Clamp(curMaxPassId + 1, 1, stageCount)

		if self._stageId == 0 then
			self._stageId = defaultStageId
		elseif self._stageId < 1 or stageCount < self._stageId then
			printError("传入关卡ID越界，activityId:", self._activityId, "stageId:", self._stageId, "stageCount:", stageCount)

			self._stageId = defaultStageId
		end

		local stageCfg = self._stageCfgs[self._stageId]

		if not stageCfg then
			printError("关卡配置不存在，activityId:", self._activityId, "stageId:", self._stageId)
			TipsFacade.instance:openCommonTips(lang("关卡配置异常"))

			return false
		end

		local planId = checknumber(stageCfg.gamePlanId)

		self._gamePlanCfg = OriginDuoLaGameConfig.instance:getGamePlanCfg(planId)

		if not self._gamePlanCfg then
			printError("关卡配置错误，找不到对应的游戏方案，activityId:", self._activityId, "stageId:", self._stageId, "planId:", planId)
			TipsFacade.instance:openCommonTips(lang("关卡配置异常"))

			return false
		end

		return true
	end
end

function OriginDuoLaGameClgView:_updateGameLimitStatus()
	goutil.setActive(self._conCurHp, self._hpLimit)
	goutil.setActive(self._conCurTimer, self._timeLimit)
	self:_updateUIHp()
	self:_updateUITimer()
	self:_updateUITriggerMode()
end

function OriginDuoLaGameClgView:_updateUIByMapCfg()
	GameUtil.updateCellsList(self._conTopTips, self._cellTopTips, self._curTipsCol, self._updateColTxtCell, self)
	GameUtil.updateCellsList(self._conLeftTips, self._cellLeftTips, self._curTipsRow, self._updateRowTxtCell, self)
	GameUtil.updateCellsList(self._conGirds, self._girdCell, self._girdDatas, self._updateGridCellPosAndSize, self)
end

function OriginDuoLaGameClgView:_updateUIByMap()
	GameUtil.updateCellsList(self._conGirds, self._girdCell, self._girdDatas, self._updateGridCell, self)
end

function OriginDuoLaGameClgView:_updateUITimer()
	if self._timeLimit then
		self._txtCurTimer.text = langPara("倒计时：%s秒", Mathf.Ceil(self._curTimer))
	end
end

function OriginDuoLaGameClgView:_updateUIHp()
	if self._hpLimit then
		self._txtCurHp.text = langPara("生命剩余：%d/%d", self._curHp, self._hpMax)
	end
end

function OriginDuoLaGameClgView:_updateUITriggerMode()
	if self._curTriggerMode == OriginDuoLaGameGridData.TRIGGER_MODE.MatchRight then
		GameUtil.SetGray(self._markRight, false)
		GameUtil.SetGray(self._markError, true)
		goutil.setActive(self._selectRight, true)
		goutil.setActive(self._selectError, false)
	elseif self._curTriggerMode == OriginDuoLaGameGridData.TRIGGER_MODE.MatchError then
		GameUtil.SetGray(self._markRight, true)
		GameUtil.SetGray(self._markError, false)
		goutil.setActive(self._selectRight, false)
		goutil.setActive(self._selectError, true)
	else
		GameUtil.SetGray(self._markRight, false)
		GameUtil.SetGray(self._markError, false)
		goutil.setActive(self._selectRight, false)
		goutil.setActive(self._selectError, false)
	end
end

function OriginDuoLaGameClgView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginDuoLaGameClgView:_onClickBtnClose()
	if self._stateMachine.currStateName == STATE_READY then
		return
	end

	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否返回关卡界面？退出界面不保存当前进度！"), function()
			self:onGameSurrender()
		end, function()
			self._stateMachine:gotoState(STATE_RUNING)
		end)
	elseif self._stateMachine.currStateName == STATE_PAUSE then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否返回主界面？退出界面不保存当前进度！"), function()
			self:onGameSurrender()
		end)
	else
		self:close()
	end
end

function OriginDuoLaGameClgView:_onClickBtnSwitchMode()
	self._curTriggerMode = self._curTriggerMode == OriginDuoLaGameGridData.TRIGGER_MODE.MatchRight and OriginDuoLaGameGridData.TRIGGER_MODE.MatchError or OriginDuoLaGameGridData.TRIGGER_MODE.MatchRight

	self:_updateUITriggerMode()
end

function OriginDuoLaGameClgView:_updateGridCell(cellGo, data, index)
	local go = cellGo.gameObject
	local changer = go:GetComponent("UIImageSpriteChange")

	changer:SetState(data:isTriggered() and (data:isTriggeredError() and (data:isError() and 3 or 4) or data:isError() and 2 or 1) or 0)
end

function OriginDuoLaGameClgView:_clearGridCell(cellGo)
	return
end

function OriginDuoLaGameClgView:_updateGridCellPosAndSize(cellGo, data, index)
	local row, col = data:getRowCol()
	local posX = self._gridStartPosX + (col - 1) * (self._gridCellSize + self._gridCellSpacing)
	local posY = self._gridStartPosY - (row - 1) * (self._gridCellSize + self._gridCellSpacing)

	GameUtil.setAnchoredPos(cellGo, posX, posY)
	GameUtil.setHeight(cellGo, self._gridCellSize)
	GameUtil.setWidth(cellGo, self._gridCellSize)
end

function OriginDuoLaGameClgView:_updateColTxtCell(cellGo, data, index)
	local txt = goutil.findChildTextComponent(cellGo, "txt")

	txt.text = data.tip or ""

	if not data.sortId then
		local sortId = 0
		local posX = self._gridStartPosX + (sortId - 1) * (self._gridCellSize + self._gridCellSpacing)

		GameUtil.setAnchoredPos(cellGo, posX, 0)

		local width = self._gridCellSize - 4

		GameUtil.setWidth(cellGo, width)
	end
end

function OriginDuoLaGameClgView:_updateRowTxtCell(cellGo, data, index)
	local txt = goutil.findChildTextComponent(cellGo, "txt")

	txt.text = data.tip or ""

	if not data.sortId then
		local sortId = 0
		local posY = self._gridStartPosY - (sortId - 1) * (self._gridCellSize + self._gridCellSpacing)

		GameUtil.setAnchoredPos(cellGo, 0, posY)

		local width = self._gridCellSize - 4

		GameUtil.setWidth(cellGo, width)
	end
end

function OriginDuoLaGameClgView:_clearColTxtCell(cellGo)
	return
end

function OriginDuoLaGameClgView:_clearRowTxtCell(cellGo)
	return
end

function OriginDuoLaGameClgView:_initFSM()
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

function OriginDuoLaGameClgView:_onEnterInit()
	self._curTriggerMode = OriginDuoLaGameGridData.TRIGGER_MODE.MatchRight
	self._hpLimit = false
	self._timeLimit = false
	self._hpMax = 0
	self._timeMax = 0
	self._initGirdTypeMap = {}
	self._girdDatas = {}
	self._girdDatasByRowCol = {}
	self._rowCount = 0
	self._colCount = 0
	self._gridStartPosX = 0
	self._gridStartPosY = 0
	self._totalWidth = 0
	self._totalHeight = 0
	self._curTipsCol = {}
	self._curTipsRow = {}

	if self._gamePlanCfg then
		if not self._gamePlanCfg.hpMax then
			do
				local hpMax = 0

				if hpMax > 0 then
					self._hpLimit = true
					self._hpMax = hpMax
				end

				if not self._gamePlanCfg.gameTime then
					local timeMax = 0

					if timeMax > 0 then
						self._timeLimit = true
						self._timeMax = timeMax
					end

					if not self._gamePlanCfg.gameMap then
						local mapCfg = {}

						self._initGirdTypeMap = mapCfg
						self._rowCount = #mapCfg

						if #mapCfg > 0 then
							self._colCount = #mapCfg[1] or 0
						end

						local giridId = 0

						for row = 1, self._rowCount do
							self._girdDatasByRowCol[row] = {}

							for col = 1, self._colCount do
								giridId = giridId + 1

								if mapCfg[row] then
									if not mapCfg[row][col] then
										local gridType = 0
										local gridData = OriginDuoLaGameGridData.New()

										gridData:initData(gridType, row, col, giridId)
										table.insert(self._girdDatas, gridData)

										self._girdDatasByRowCol[row][col] = gridData
									end
								end
							end
						end

						for row = 1, self._rowCount do
							local tip = ""
							local isNeedAddCount = true
							local count = 0
							local addCount = 0

							for col = 1, self._colCount do
								if self._girdDatasByRowCol[row] then
									local gridData = self._girdDatasByRowCol[row][col]

									if gridData and not gridData:isError() then
										isNeedAddCount = isNeedAddCount or true

										if isNeedAddCount then
											count = count + 1
										end
									elseif isNeedAddCount then
										isNeedAddCount = false

										if count > 0 then
											addCount = addCount + 1
											tip = tip == "" and tostring(count) or addCount % 2 == 0 and tip .. " " .. string.format("<color=#FDF8A0FF>%s</color>", tostring(count)) or tip .. " " .. tostring(count)
										end

										count = 0
									end
								end
							end

							if isNeedAddCount and count > 0 then
								addCount = addCount + 1
								tip = tip == "" and tostring(count) or addCount % 2 == 0 and tip .. " " .. string.format("<color=#FDF8A0FF>%s</color>", tostring(count)) or tip .. " " .. tostring(count)
							end

							if tip == "" then
								tip = "0"
							end

							table.insert(self._curTipsRow, {
								tip = tip,
								sortId = row
							})
						end

						for col = 1, self._colCount do
							local tip = ""
							local isNeedAddCount = true
							local count = 0
							local addCount = 0

							for row = 1, self._rowCount do
								if self._girdDatasByRowCol[row] then
									local gridData = self._girdDatasByRowCol[row][col]

									if gridData and not gridData:isError() then
										isNeedAddCount = isNeedAddCount or true

										if isNeedAddCount then
											count = count + 1
										end
									elseif isNeedAddCount then
										addCount = addCount + 1
										isNeedAddCount = false

										if count > 0 then
											tip = tip == "" and tostring(count) or addCount % 2 == 0 and tip .. "\n" .. string.format("<color=#FDF8A0FF>%s</color>", tostring(count)) or tip .. "\n" .. tostring(count)
										end

										count = 0
									end
								end
							end

							if isNeedAddCount and count > 0 then
								addCount = addCount + 1
								tip = tip == "" and tostring(count) or addCount % 2 == 0 and tip .. "\n" .. string.format("<color=#FDF8A0FF>%s</color>", tostring(count)) or tip .. "\n" .. tostring(count)
							end

							if tip == "" then
								tip = "0"
							end

							table.insert(self._curTipsCol, {
								tip = tip,
								sortId = col
							})
						end
					end
				end
			end

			local size = Mathf.Max(self._rowCount, self._colCount)

			if not GRID_SIZE_CONFIG[size] then
				local gridSizeCfg = GRID_SIZE_CONFIG[DEFAULT_MAP_SIZE]

				self._gridCellSize = gridSizeCfg.cellSize
				self._gridCellSpacing = gridSizeCfg.spacing
				self._totalWidth = self._colCount * self._gridCellSize + (self._colCount - 1) * self._gridCellSpacing
				self._totalHeight = self._rowCount * self._gridCellSize + (self._rowCount - 1) * self._gridCellSpacing
				self._gridStartPosX = -self._totalWidth / 2 + self._gridCellSize / 2
				self._gridStartPosY = self._totalHeight / 2 - self._gridCellSize / 2
				self._gridBoundaryLeft = self._gridStartPosX - self._gridCellSize / 2 - self._gridCellSpacing / 2
				self._gridBoundaryRight = self._gridStartPosX + (self._colCount - 1) * (self._gridCellSize + self._gridCellSpacing) + self._gridCellSize / 2 + self._gridCellSpacing / 2
				self._gridBoundaryTop = self._gridStartPosY + self._gridCellSize / 2 + self._gridCellSpacing / 2
				self._gridBoundaryBottom = self._gridStartPosY - (self._rowCount - 1) * (self._gridCellSize + self._gridCellSpacing) - self._gridCellSize / 2 - self._gridCellSpacing / 2

				self:_updateUIByMapCfg()
				OriginDuoLaGameController.instance:startGame(self._activityId, self._stageId)
			end
		end
	end
end

function OriginDuoLaGameClgView:_onEnterReady()
	self._curHp = self._hpMax
	self._curTimer = self._timeMax
	self._curEndState = STATE_END.NONE

	self:_updateGameLimitStatus()

	for _, gridData in ipairs(self._girdDatas) do
		gridData:resetState()
	end

	self:_updateUIByMap()
	self._stateMachine:gotoState(STATE_RUNING)
end

function OriginDuoLaGameClgView:_onExistReady()
	return
end

function OriginDuoLaGameClgView:_onEnterRunning()
	return
end

function OriginDuoLaGameClgView:_onRunning()
	if self._timeLimit then
		self._curTimer = self._curTimer - UnityEngine.Time.deltaTime

		if self._curTimer <= 0 then
			self._curTimer = 0

			self:onGameTimeFail()
		end

		self:_updateUITimer()
	end
end

function OriginDuoLaGameClgView:_onEnterPause()
	return
end

function OriginDuoLaGameClgView:_onExitPause()
	return
end

function OriginDuoLaGameClgView:_onEnterGameEnd()
	if self._curEndState ~= STATE_END.SUCCESS then
		OriginDuoLaGameController.instance:endGame(self._activityId, self._stageId, false)
	else
		OriginDuoLaGameController.instance:endGame(self._activityId, self._stageId, true)
	end
end

function OriginDuoLaGameClgView:onClickGrid(gridData)
	if self._stateMachine.currStateName ~= STATE_RUNING then
		return
	end

	local isTrigger = gridData:trigger(self._curTriggerMode)

	if isTrigger then
		if gridData:isTriggeredError() then
			self:onHpChange(-1)
			TipsFacade.instance:openCommonTips(lang("踩到地雷了，掉一血！"))

			self._draging = false
		end

		if not gridData:isError() then
			local row, col = gridData:getRowCol()

			self:_checkIsClearRow(row)
			self:_checkIsClearCol(col)
			self:_checkIsClearAll()
		end

		self:_updateUIByMap()
	end
end

function OriginDuoLaGameClgView:_checkIsClearRow(row)
	local needClearNum = 0
	local curClearNum = 0

	for col = 1, self._colCount do
		if self._girdDatasByRowCol[row] then
			local gridData = self._girdDatasByRowCol[row][col]

			if gridData and not gridData:isError() then
				needClearNum = needClearNum + 1

				if gridData:isTriggered() then
					curClearNum = curClearNum + 1
				end
			end
		end
	end

	if needClearNum > 0 and needClearNum <= curClearNum then
		for col = 1, self._colCount do
			if self._girdDatasByRowCol[row] then
				local gridData = self._girdDatasByRowCol[row][col]

				gridData:triggerSafe()
			end
		end
	end

	self:_updateUIByMap()
end

function OriginDuoLaGameClgView:_checkIsClearCol(col)
	local needClearNum = 0
	local curClearNum = 0

	for row = 1, self._rowCount do
		if self._girdDatasByRowCol[row] then
			local gridData = self._girdDatasByRowCol[row][col]

			if gridData and not gridData:isError() then
				needClearNum = needClearNum + 1

				if gridData:isTriggered() then
					curClearNum = curClearNum + 1
				end
			end
		end
	end

	if needClearNum > 0 and needClearNum <= curClearNum then
		for row = 1, self._rowCount do
			if self._girdDatasByRowCol[row] then
				local gridData = self._girdDatasByRowCol[row][col]

				gridData:triggerSafe()
			end
		end
	end

	self:_updateUIByMap()
end

function OriginDuoLaGameClgView:_checkIsClearAll()
	local needClearNum = 0
	local curClearNum = 0

	for _, gridData in ipairs(self._girdDatas) do
		if gridData and not gridData:isError() then
			needClearNum = needClearNum + 1

			if gridData:isTriggered() then
				curClearNum = curClearNum + 1
			end
		end
	end

	if needClearNum > 0 and needClearNum <= curClearNum then
		self._curEndState = STATE_END.SUCCESS

		self:_updateUIByMap()
		self:onGameSuccess()
	end
end

function OriginDuoLaGameClgView:onHpChange(hpChange)
	if self._hpLimit then
		self._curHp = self._curHp + hpChange
		self._curHp = Mathf.Clamp(self._curHp, 0, self._hpMax)

		if self._curHp <= 0 then
			self:onGameHpFail()
		end

		self:_updateUIHp()
	end
end

function OriginDuoLaGameClgView:onGameSurrender()
	self._curEndState = STATE_END.SURRENDER

	self:onGameFail()
end

function OriginDuoLaGameClgView:onGameTimeFail()
	self._curEndState = STATE_END.TIME_UP

	self:onGameFail()
end

function OriginDuoLaGameClgView:onGameHpFail()
	self._curEndState = STATE_END.HP_DEPLETED

	self:onGameFail()
end

function OriginDuoLaGameClgView:onGameFail()
	self._stateMachine:gotoState(STATE_GAME_END)
end

function OriginDuoLaGameClgView:onGameSuccess()
	self._curEndState = STATE_END.SUCCESS

	self._stateMachine:gotoState(STATE_GAME_END)
end

function OriginDuoLaGameClgView:_getGridDataByClick(eventData)
	local vec = goutil.screenToLocalPos(eventData.position, self._conGirds.transform)
	local pos = self._conGirds.transform:TransformPoint(vec)
	local localPos = self._conGirds.transform:InverseTransformPoint(pos)
	local clickX = localPos.x
	local clickY = localPos.y

	if clickX < self._gridBoundaryLeft or clickX > self._gridBoundaryRight or clickY > self._gridBoundaryTop or clickY < self._gridBoundaryBottom then
		return nil
	end

	local col = math.floor((clickX - self._gridBoundaryLeft) / (self._gridCellSize + self._gridCellSpacing)) + 1
	local row = math.floor((self._gridBoundaryTop - clickY) / (self._gridCellSize + self._gridCellSpacing)) + 1

	if row >= 1 and row <= self._rowCount and col >= 1 and col <= self._colCount then
		return self._girdDatasByRowCol[row] and self._girdDatasByRowCol[row][col]
	end

	return nil
end

function OriginDuoLaGameClgView:_onClickDownHandler(_go, eventData)
	if self._stateMachine.currStateName ~= STATE_RUNING then
		return
	end

	self._curCheckDragMode = DRAG_TRIGGER_MODE.Empty
	self._firstDragData = nil
	self._draging = false

	local gridData = self:_getGridDataByClick(eventData)

	if gridData then
		if gridData:isTriggered() then
			return
		end

		self._firstDragData = gridData

		self:onClickGrid(gridData)
	end
end

function OriginDuoLaGameClgView:_onBeginDragHandler(_go, eventData)
	if self._stateMachine.currStateName ~= STATE_RUNING then
		return
	end

	if self._firstDragData then
		self._draging = true
	end
end

function OriginDuoLaGameClgView:_onEndDragHandler(_go, eventData)
	if self._stateMachine.currStateName ~= STATE_RUNING then
		return
	end

	self._draging = false
	self._firstDragData = nil
	self._curCheckDragMode = DRAG_TRIGGER_MODE.Empty
end

function OriginDuoLaGameClgView:_onDragHandler(_go, eventData)
	if self._stateMachine.currStateName ~= STATE_RUNING then
		return
	end

	if not self._draging then
		return
	end

	local gridData = self:_getGridDataByClick(eventData)

	if gridData and self._firstDragData and gridData ~= self._firstDragData then
		local firstRow, firstCol = self._firstDragData:getRowCol()
		local currentRow, currentCol = gridData:getRowCol()

		if firstRow ~= currentRow and firstCol ~= currentCol then
			return
		end

		if self._curCheckDragMode == DRAG_TRIGGER_MODE.Empty then
			if firstRow == currentRow then
				self._curCheckDragMode = DRAG_TRIGGER_MODE.Row
			elseif firstCol == currentCol then
				self._curCheckDragMode = DRAG_TRIGGER_MODE.Column
			end
		end

		if self._curCheckDragMode == DRAG_TRIGGER_MODE.Row and firstRow ~= currentRow then
			return
		end

		if self._curCheckDragMode == DRAG_TRIGGER_MODE.Column and firstCol ~= currentCol then
			return
		end

		if gridData:isTriggered() then
			return
		end

		self:onClickGrid(gridData)
	end
end

return OriginDuoLaGameClgView
