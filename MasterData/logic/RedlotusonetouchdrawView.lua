-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotusonetouchdrawView.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotusonetouchdrawView", package.seeall)

local RedlotusonetouchdrawView = class("RedlotusonetouchdrawView", OneTouchDrawView)

function RedlotusonetouchdrawView:ctor()
	RedlotusonetouchdrawView.super.ctor(self)
end

function RedlotusonetouchdrawView:unbindEvents()
	RedlotusonetouchdrawView.super.unbindEvents(self)
end

function RedlotusonetouchdrawView:bindEvents()
	RedlotusonetouchdrawView.super.bindEvents(self)
end

function RedlotusonetouchdrawView:buildUI()
	RedlotusonetouchdrawView.super.buildUI(self)
end

function RedlotusonetouchdrawView:onExit()
	RedlotusonetouchdrawView.super.onExit(self)
end

function RedlotusonetouchdrawView:onEnter()
	local params = self:getOpenParam()

	self._activityId = params[1]
	self._gameId = params[2]
	self._clientKey = params[3]
	self._serverKey = params[4]
	self._stageId = params[5]
	self._isCrazy = false

	local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
	local actCfg = RedLotusDinnerPartyConfig.instance:getActivityCfgById(activityId) or {}
	local performPlanId = actCfg.performPlanId
	local performCfg = RedLotusDinnerPartyConfig.instance:getPerformPlanCfg(performPlanId, self._gameId) or {}
	local stagePlanId = performCfg.stagePlanId
	local stageCfg = RedLotusDinnerPartyConfig.instance:getStageCfg(stagePlanId, self._stageId) or {}

	self._stageGroupId = stageCfg.stageGroupId
	self._curLevelIndex = math.max(checknumber(stageCfg.smallStageId), 1)
	self._pic = stageCfg.pic

	self:_addAllMsgListener()
	LuoShiQiOrdealModel.instance:resetTemp()
	self:_initGame()
	settimer(1, self._onSecond, self)
end

function RedlotusonetouchdrawView:_initGame()
	self._maxTime = 1
	self._totalTime = 60
	self._cfgStages = {}
	self._totalLevelNum = 1

	if not self._isCrazy then
		self._maxTime = self._totalTime
		self._cfgStages = LuoShiQiOrdealConfig.instance:getStageCfgList(self._stageGroupId)
	else
		self._cfgStages = LuoShiQiOrdealConfig.instance:getStageCfgList(self._stageGroupId)
		self._maxTime = self._totalTime
	end

	self._totalLevelNum = #self._cfgStages

	self:_initGameObject()
end

function RedlotusonetouchdrawView:_onClickBeginGame()
	self:_onBeginGame()
end

function RedlotusonetouchdrawView:_addAllMsgListener()
	return
end

function RedlotusonetouchdrawView:_removeAllMsgListener()
	return
end

function RedlotusonetouchdrawView:_sendNormalEndGame(curScore)
	RedLotusDinnerPartyController.instance:sendEndGame(self._activityId, self._gameId, 1, curScore, self._clientKey, self._serverKey)
	self:_showGameOverPopupView(true)
end

function RedlotusonetouchdrawView:_sendCrazyEndGame(stageNum)
	RedLotusDinnerPartyController.instance:sendEndGame(self._activityId, self._gameId, 1, stageNum, self._clientKey, self._serverKey)
	self:_showGameOverPopupView(true)
end

function RedlotusonetouchdrawView:_initParams()
	self._cellLength = 88
	self._cellHalfLength = self._cellLength / 2
	self._cellSpacing = 6
	self._lineWidth = 70
	self._lineHeight = 70
end

function RedlotusonetouchdrawView:setTouchCellExt(go, oneTouchCellMo)
	if oneTouchCellMo.cellType == 2 then
		-- block empty
	elseif oneTouchCellMo.cellType == 1 then
		-- block empty
	else
		goutil.setActive(go, false)
	end

	local icon = goutil.findChild(go, "icon")

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._pic))
end

function RedlotusonetouchdrawView:_updateLines()
	RedlotusonetouchdrawView.super._updateLines(self)

	for i, go in ipairs(self._cellGosList) do
		local mo = GameUtil.GetLua(go, OneTouchCellMo)

		if mo.cellType == 1 or mo.cellType == 2 then
			local icon = goutil.findChild(go, "icon")

			GameUtil.SetActive(icon, true)
		end
	end

	local list = self._oneTouchDrawMo:getStepRecordList()

	for i, v in ipairs(list) do
		local icon = goutil.findChild(self._cellGosList[v + 1], "icon")

		GameUtil.SetActive(icon, false)
	end
end

function RedlotusonetouchdrawView:_onGameOver(isFail, isForceQuit)
	self:_clearCells()
	self:_clearLines()
	goutil.setActive(self._headGo, false)

	self._isPlaying = false
	self._isDouble = false

	if not self._isCrazy then
		if self._totalTime > 0 then
			self._totalTime = self._totalTime or 0
		end

		self._totalTime = self._totalTime + 1

		local curScore = 0

		curScore = isFail and 0 or curScore

		if not isForceQuit then
			LuoShiQiOrdealModel.instance:setCurScore(curScore)
			self:_sendNormalEndGame(curScore)
		else
			self:_showGameOverPopupView(false)
		end
	else
		local stageNum = self._curLevelIndex - 1

		if isForceQuit and stageNum < 1 then
			self:_showGameOverPopupView(false)
		else
			LuoShiQiOrdealModel.instance:setPassStage(stageNum)
			self:_sendCrazyEndGame(stageNum)
		end
	end
end

function RedlotusonetouchdrawView:_showGameOverPopupView(isSuccess)
	goutil.setActive(self._gameOver, true)

	if self._isCrazy then
		local passNum = LuoShiQiOrdealModel.instance:getCrazyPassLevelNum()
		local score = isSuccess and LuoShiQiOrdealModel.instance:getCurScore() or 0

		self._txtGameOver.text = lang("游戏结束！")
	else
		local score = isSuccess and LuoShiQiOrdealModel.instance:getCurScore() or 0

		self._txtGameOver.text = self._isDouble and lang("游戏结束！") or lang("游戏结束！")
	end
end

function RedlotusonetouchdrawView:_onClickGameOver()
	GlobalDispatcher:dispatch("open_redlotusgala_view")
	self:close()
end

return RedlotusonetouchdrawView
