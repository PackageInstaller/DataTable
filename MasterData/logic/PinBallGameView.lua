-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallGameView.lua

module("logic.extensions.pinball.view.PinBallGameView", package.seeall)

local PinBallGameView = class("PinBallGameView", ViewComponent)
local BOARD_INIT_Y = -261.43
local STATE_INIT = "STATE_INIT"
local STATE_READY = "STATE_READY"
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"

function PinBallGameView:ctor()
	PinBallGameView.super.ctor(self)
end

function PinBallGameView:unbindEvents()
	PinBallGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	BeginDragHandler.Get(self._boardDrag.gameObject):RemoveLuaHandler(self._boardHandler.beginDragHandler)
	DragHandler.Get(self._boardDrag.gameObject):RemoveLuaHandler(self._boardHandler.moveDragHandler)
	EndDragHandler.Get(self._boardDrag.gameObject):RemoveLuaHandler(self._boardHandler.endDragHandler)
end

function PinBallGameView:bindEvents()
	PinBallGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)

	self._boardHandler = {}
	self._boardHandler.beginDragHandler = BeginDragHandler.Get(self._boardDrag.gameObject):AddLuaHandler(function(go, edata)
		self:_OnDragBegin(edata)
	end)
	self._boardHandler.moveDragHandler = DragHandler.Get(self._boardDrag.gameObject):AddLuaHandler(function(go, edata)
		self:_OnDrag(edata)
	end)
	self._boardHandler.endDragHandler = EndDragHandler.Get(self._boardDrag.gameObject):AddLuaHandler(function(go, edata)
		self:_OnDragEnd(edata)
	end)
end

function PinBallGameView:buildUI()
	PinBallGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._boardGo = self:getGo("board")
	self._boardDrag = self:getGo("boardDrag")
	self._btnStart = self:getGo("btnStart")
	self._templete_brick_default = self:getGo("templateBricks/brickCellBase")
	self._templete_brick_line = self:getGo("templateBricks/brickCellLine")
	self._templete_brick_wall = self:getGo("templateBricks/brickCellWall")
	self._map = self:getGo("map")
	self._template_lineUI = self:getGo("templateBrickUI/templateLineUI")
	self._brickUIRoot = self:getGo("brickUIRoot")
	self._ballGo = self:getGo("ball")
	self._boardGo = self:getGo("board")
	self._templete_prop_addBall = self:getGo("templateProps/propAddBall")
	self._templete_prop_addBoardLen = self:getGo("templateProps/propAddBoardLen")
	self._templete_prop_getPrize = self:getGo("templateProps/propGetPrize")
	self._extPrize = self:getGo("extPrize")
	self._txtExtPrize = self:getTxt("extPrize/txtExtPrize")

	self:_initFSM()

	local btnTip = self:getGo("leftTop/btnTip")

	goutil.setActive(btnTip, false)
end

function PinBallGameView:onExit()
	PinBallGameView.super.onExit(self)
	self._stateMachine:gotoState(STATE_GAME_END)
	self._stateMachine:stopTimer()
	removetimer(self._endGame, self)
	PinBallBrickMapMgr.instance:clear()
	PinBallPropMgr.instance:clear()
	PinBallMgr.instance:clear()
	PinBallBrickUIMgr.instance:clear()
	self:_clearMapUI()
end

function PinBallGameView:onEnter()
	PinBallGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PinBallAddExtPrizeNum, self._updateMapUI, self)
	self.addGEvent(self, GlobalNotify.PinBallAddBall, self._onPinBallAddBall, self)
	self.addGEvent(self, GlobalNotify.PM_PinBallStartGameRes, self._startGameRes, self)
	self.addGEvent(self, GlobalNotify.PM_PinBallEndGameRes, self.close, self)
	PinBallBrickMapMgr.instance:setComplateInstance(PinBallEnum.BrickType.Default, self._templete_brick_default)
	PinBallBrickMapMgr.instance:setComplateInstance(PinBallEnum.BrickType.Wall, self._templete_brick_wall)
	PinBallBrickMapMgr.instance:setComplateInstance(PinBallEnum.BrickType.Line, self._templete_brick_line)
	PinBallPropMgr.instance:setComplateInstance(PinBallEnum.PropType.AddBall, self._templete_prop_addBall)
	PinBallPropMgr.instance:setComplateInstance(PinBallEnum.PropType.AddBoardLen, self._templete_prop_addBoardLen)
	PinBallPropMgr.instance:setComplateInstance(PinBallEnum.PropType.GetPrize, self._templete_prop_getPrize)
	PinBallBrickUIMgr.instance:setComplateInstance(PinBallEnum.BrickType.Line, self._template_lineUI)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 554001
	end

	PinBallController.instance:setActId(self._activityId)

	self._stageId = params[2] and checknumber(params[2]) or 1
	self._stageCfg = PinBallConfig.instance:getStageCfgById(self._activityId, self._stageId)
	self._hasEndGame = false
	self._exitGame = false

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_INIT)
end

function PinBallGameView:_initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_INIT, GameUtil.handler(self._onEnterInit, self), nil, nil)
	self._stateMachine:addState(STATE_READY, nil, nil, nil)
	self._stateMachine:addState(STATE_RUNING, nil, nil, GameUtil.handler(self._onRunning, self))
	self._stateMachine:addState(STATE_PAUSE, nil, nil, nil)
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._onEnterGameEnd, self))

	local linkedList = {
		[STATE_INIT] = {
			STATE_READY
		},
		[STATE_READY] = {
			STATE_RUNING,
			STATE_INIT
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

function PinBallGameView:_OnDragBegin(edata)
	local pScreenPos = edata.position
	local mainCamera = GlobalModel.instance.uiCamera
	local worldPos = mainCamera:ScreenToWorldPoint(pScreenPos)
	local localPos = self._boardDrag.gameObject.transform:InverseTransformPoint(worldPos)

	self._boardBeginPos = GameUtil.getLocalPos(self._boardGo)
	self._beginDragPos = worldPos
end

function PinBallGameView:_OnDrag(edata)
	local pScreenPos = edata.position
	local mainCamera = GlobalModel.instance.uiCamera
	local worldPos = mainCamera:ScreenToWorldPoint(pScreenPos)
	local localPos = self._boardDrag.gameObject.transform:InverseTransformPoint(worldPos)
	local diffX = localPos.x - self._beginDragPos.x

	GameUtil.setLocalPos(self._boardGo, self._boardBeginPos.x + diffX, BOARD_INIT_Y, 0)
	PinBallBoardMgr.instance:updateBoardPos(self._boardBeginPos.x + diffX, BOARD_INIT_Y)
end

function PinBallGameView:_OnDragEnd(edata)
	local boardPos = GameUtil.getLocalPos(self._boardGo)

	GameUtil.setLocalPos(self._boardDrag, boardPos.x, BOARD_INIT_Y, 0)
end

function PinBallGameView:_startGameRes()
	GameUtil.SetActive(self._btnStart, false)
	self._stateMachine:gotoState(STATE_RUNING)
end

function PinBallGameView:_onClickBtnStart()
	PinBallController.instance:sendPM_PinBallStartGameReq(self._activityId, self._stageId)
end

function PinBallGameView:_onEnterInit()
	self:_initGamePram()
	GameUtil.SetActive(self._btnStart, true)
	self._stateMachine:gotoState(STATE_READY)
end

function PinBallGameView:_endGame()
	self._stateMachine:gotoState(STATE_GAME_END)
	removetimer(self._endGame, self)
end

function PinBallGameView:_onRunning()
	PinBallMgr.instance:update()
	PinBallPropMgr.instance:update()

	local curBallNum = PinBallMgr.instance:getCurBallNum()
	local brickNum = PinBallBrickMapMgr.instance:getBrickNum()

	if (curBallNum <= 0 or brickNum <= 0) and not self._hasEndGame then
		settimer(1, self._endGame, self, false)

		self._hasEndGame = true
	end
end

function PinBallGameView:_onEnterGameEnd()
	local curBallNum = PinBallMgr.instance:getCurBallNum()
	local tipStr = "游戏结束，通关成功！"
	local score = 0

	if self._exitGame then
		PinBallController.instance:sendPM_PinBallEndGameReq(self._activityId, self._stageId, 0, {})

		return
	end

	if curBallNum > 0 then
		score = self._stageCfg.score
		tipStr = tipStr .. string.format("\n本次获得积分：%d", self._stageCfg.score)
	else
		tipStr = "弹球掉出界外，游戏结束，本次闯关失败！\n注：通关失败不扣除游戏次数。"
	end

	TipsFacade.instance:openTipWindowNoX("提示", tipStr, function()
		local gainPrizeList = PinBallController.instance:getCurGainExtPrizeList(self._activityId)

		PinBallController.instance:sendPM_PinBallEndGameReq(self._activityId, self._stageId, score, gainPrizeList)
	end)
end

function PinBallGameView:_initGamePram()
	PinBallBrickUIMgr.instance:initParam(self._brickUIRoot)
	PinBallBrickMapMgr.instance:initParam(self._stageCfg, self._map)
	PinBallBrickMapMgr.instance:createMap()
	GameUtil.SetActive(self._templete_brick_default, false)
	GameUtil.SetActive(self._templete_brick_line, false)

	local boardWidth = self._stageCfg.boardWidth
	local boardHeight = self._stageCfg.boardHeight

	self._board = PinBallBoard.New()

	self._board:init(self._boardGo, self._boardDrag, 0, BOARD_INIT_Y, boardWidth, boardHeight)
	PinBallBoardMgr.instance:init(self._board)

	local speed = self._stageCfg.ballSpeed
	local curWidth, curHeight = 1280, 720
	local ballRadius = GameUtil.getWidth(self._ballGo) / 2
	local ballYOffset = 4.8

	PinBallMgr.instance:initParamas(self._ballGo, self.mainGO, ballRadius, speed, curWidth / 2, curHeight / 2)
	PinBallMgr.instance:createBall(1, 0, BOARD_INIT_Y + ballRadius + boardHeight / 2 + ballYOffset)
	GameUtil.SetActive(self._ballGo, false)
	GameUtil.setWidth(self._templete_prop_addBall, self._stageCfg.propWidth)
	GameUtil.setWidth(self._templete_prop_addBoardLen, self._stageCfg.propWidth)
	GameUtil.setHeight(self._templete_prop_addBall, self._stageCfg.propHeight)
	GameUtil.setHeight(self._templete_prop_addBoardLen, self._stageCfg.propHeight)
	PinBallPropMgr.instance:initParamas(self.mainGO)
	GameUtil.SetActive(self._templete_prop_addBall, false)
	GameUtil.SetActive(self._templete_prop_addBoardLen, false)
	self:_setInitMapUI()
end

function PinBallGameView:_setInitMapUI()
	local maxCollectNum = PinBallController:getMaptotalExtPrizeNum(self._activityId, self._stageId)
	local curCollectNum = PinBallController.instance:getCurPrizeNum(self._activityId)
	local hasPrize = maxCollectNum > 0

	self._prizeDescGoList = {}
	self._txtExtPrize.text = string.format("掉落奖励已收集：%d/%d", curCollectNum, maxCollectNum)

	GameUtil.SetActive(self._extPrize, hasPrize)
end

function PinBallGameView:_updateMapUI()
	local maxCollectNum = PinBallController:getMaptotalExtPrizeNum(self._activityId, self._stageId)
	local curCollectNum = PinBallController.instance:getCurPrizeNum(self._activityId)

	self._txtExtPrize.text = string.format("掉落奖励已收集：%d/%d", curCollectNum, maxCollectNum)
end

function PinBallGameView:_clearMapUI()
	for i, go in ipairs(self._prizeDescGoList) do
		goutil.destroy(go)
	end
end

function PinBallGameView:_onPinBallAddBall()
	local brickNum = PinBallBrickMapMgr.instance:getBrickNum()

	if brickNum > 0 then
		removetimer(self._endGame, self)
	end
end

function PinBallGameView:_onClickBtnClose()
	if self._stateMachine.currStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)

		local tipsContent = "确定要退出当前游戏吗？"

		PinBallMgr.instance:pauseGame()
		PinBallPropMgr.instance:pauseGame()

		local function okFunc()
			self._exitGame = true

			self._stateMachine:gotoState(STATE_GAME_END)
		end

		local function cencelFunc()
			self._exitGame = false

			self._stateMachine:gotoState(STATE_RUNING)
			PinBallMgr.instance:continueGame()
			PinBallPropMgr.instance:continueGame()
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	elseif self._stateMachine.currStateName == STATE_READY then
		local tipsContent = "确定要退出当前游戏吗？"

		local function okFunc()
			self:close()
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	end
end

return PinBallGameView
