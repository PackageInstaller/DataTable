-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsGameView.lua

module("logic.extensions.catchprops.view.CatchPropsGameView", package.seeall)

local CatchPropsGameView = class("CatchPropsGameView", ViewComponent)
local stage_waitingGameStart = 1
local stage_gamimg = 2
local stage_gameFinished = 3
local unityTime = UnityEngine.Time

function CatchPropsGameView:buildUI()
	CatchPropsGameView.super.buildUI(self)

	self._bgImage = self:getGo("bg")
	self._txtTitle = self:getTxt("CanvasViewInfo/txtTitle")
	self._btnClose = self:getBtn("CanvasViewInfo/btnClose")
	self._itemsNum = self:getTxt("CanvasViewInfo/rightBottom/itemsNum")
	self._btnWaitingStart = Framework.UIClickTrigger.Get(self:getGo("CanvasViewInfo/waitingStart"))
	self._waitingStartTips = self:getTxt("CanvasViewInfo/waitingStart/waitingStartText")

	local canvasViewInfo = self:getGo("CanvasViewInfo")

	self._gamingTime = self:getTxt("CanvasViewInfo/rightBottom/gamingTime")

	GameUtil.expandRectTransform(canvasViewInfo.transform)

	self._canvasUnit = self:getGo("CanvasUnit")

	local thrower = self:getGo("CanvasUnit/thrower")
	local catcher = self:getGo("CanvasUnit/catcher")

	self._moveRange = self:getGo("CanvasUnit/catcherMoveRange")
	self._catcher = CatchPropsGameCatcher.New(catcher)
	self._thrower = CatchPropsThrower.New(thrower)
	self._defaultProp = self:getGo("defaultProp")

	self._defaultProp:SetActive(false)

	self._rightBottom = self:getGo("CanvasViewInfo/rightBottom")
	self._addScore = self:getGo("CanvasViewInfo/rightBottom/addScore")
	self._addTime = self:getGo("CanvasViewInfo/rightBottom/addGamingTime")

	self._addScore:SetActive(false)
	self._addTime:SetActive(false)

	self._testCollider = self:getGo("CanvasUnit/testCollider")

	self._testCollider:SetActive(false)

	self._canvasEffs = self:getGo("CanvasEffs")

	local canvasUnit = self:getGo("CanvasUnit")

	GameUtil.expandRectTransform(canvasUnit.transform)
	GameUtil.expandRectTransform(self._canvasEffs.transform)

	self._crazyTip = self:getGo("crazyTip")
end

function CatchPropsGameView:bindEvents()
	CatchPropsGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnWaitingStart:AddClickListener(self._onClickStartGame, self)
end

function CatchPropsGameView:unbindEvents()
	CatchPropsGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnWaitingStart:RemoveClickListener()
end

function CatchPropsGameView:onEnter()
	CatchPropsGameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._choosePetRaceId = checknumber(params[1])

	self:_initParams()
	uGuiUtil.setSpriteToImage(self._bgImage, uGuiUtil.LoaderType_BigBg, CatchPropsModel.instance:getGameBgImage())
	self:_refreshGameName()
	self:_refreshPropsNum()
	self:_startWaitingGameStart()
	self:_refreshGamingTime()
	self._catcher:loadSpine(CatchPropsModel.instance:getCatcherImage())
	self._thrower:loadSpine(CatchPropsModel.instance:getThrowerImage())
	self._catcher:onEnter()
	self._thrower:onEnter()

	self._propsSpawner = CatchPropsPropSpawner.New(self._defaultProp, self, self._canvasEffs, self._choosePetRaceId)

	self:_updateMoveRange()
	settimer(0, self._tickCatcherGame, self)
	self:_crazyModelTipOver()
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsAddScores, self._onCatchPropsAddScores, self)
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsAddTime, self._onCatchPropsAddTime, self)
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsCrazyTip, self._crazyModelEvent, self)
end

function CatchPropsGameView:_initParams()
	self._isGamePause = false
	self._txtAddTimePool = {}
	self._txtAddScorePool = {}
end

function CatchPropsGameView:_updateMoveRange()
	local halfWidth, halfHeight = self._moveRange.transform.rect.width * 0.5, self._moveRange.transform.rect.height * 0.5
	local mx, my, mz = Framework.TransformUtil.GetLocalPos(self._moveRange.transform, nil, nil, nil)
	local rangeMinX = mx - halfWidth
	local rangeMaxX = mx + halfWidth
	local rangeMinY = my - halfHeight
	local rangeMaxY = my + halfHeight

	self._catcher:setMoveRange(rangeMinX, rangeMaxX)
	self._propsSpawner:setMoveRange(rangeMinX, rangeMaxX, rangeMinY, rangeMaxY)

	local _, cyPos = self._catcher:getColliderPos()

	self._propsSpawner:setCollisionYPos(cyPos)
	self._propsSpawner:setObjectParent(self._canvasUnit.transform)
end

function CatchPropsGameView:_refreshGameName()
	local activityId = CatchPropsModel.instance:getActivityId()
	local activityCo = CatchPropsConfig.instance:getActivityCo(activityId)

	self._txtTitle.text = activityCo.gameName
end

function CatchPropsGameView:_startWaitingGameStart()
	self._currGameStage = stage_waitingGameStart
	self._waitingStartTips.text = CatchPropsModel.instance:getGameWaitingStartTips()

	self._btnWaitingStart.gameObject:SetActive(true)
end

function CatchPropsGameView:_startPlayGame()
	self._currGameStage = stage_gamimg

	self._btnWaitingStart.gameObject:SetActive(false)
	self._catcher:startGame()
	self._thrower:startGame()
end

function CatchPropsGameView:_startGameResult()
	self._catcher:stopGame()
	self._thrower:stopGame()

	self._isGamePause = true
	self._currGameStage = stage_gameFinished

	CatchPropsController.instance:sendPM_MoYanPreheatEndGameReq()
end

function CatchPropsGameView:_refreshPropsNum()
	self._itemsNum.text = string.format(lang("catch_props_propsnum"), CatchPropsModel.instance:getGamePropsNum())
end

function CatchPropsGameView:_refreshGamingTime()
	local gamingTime = CatchPropsModel.instance:getGamingTime()

	self._gamingTime.text = string.format(lang("catch_props_countingdown_time"), math.floor(math.max(gamingTime, 0)))
end

function CatchPropsGameView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsAddScores, self._onCatchPropsAddScores, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsAddTime, self._onCatchPropsAddTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsCrazyTip, self._crazyModelEvent, self)
	removetimer(self._tickCatcherGame, self)
	removetimer(self._crazyModelTipOver, self)
	self._catcher:onExit()
	self._thrower:onExit()
	self:_clearAllTxtPools()
	self._propsSpawner:clear()
	CatchPropsGameView.super.onExit(self)
end

function CatchPropsGameView:onExitFinished()
	uGuiUtil.clearImage(self._bgImage)
	CatchPropsGameView.super.onExitFinished(self)
end

function CatchPropsGameView:_onClickClose()
	self._isGamePause = true

	self._catcher:pauseGame(true)
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("catch_props_exitgame_tips"), function()
		self:close()
	end, function()
		self._catcher:pauseGame(false)

		self._isGamePause = false
	end, lang("confirm"), lang("mail_cancel"))
end

function CatchPropsGameView:_onClickStartGame()
	self:_startPlayGame()
end

function CatchPropsGameView:_tickCatcherGame()
	if self._isGamePause then
		return
	end

	if self._currGameStage == stage_waitingGameStart then
		-- block empty
	elseif self._currGameStage == stage_gamimg then
		local deltaTime = unityTime.deltaTime

		self:_tickGamingTime(deltaTime)
		self._propsSpawner:CrazyModelTips(deltaTime)
		self._propsSpawner:update(deltaTime)
		self:_checkCollision()
	end
end

function CatchPropsGameView:_tickGamingTime(deltaTime)
	local gamingTime = CatchPropsModel.instance:getGamingTime() - deltaTime

	CatchPropsModel.instance:setGamingTime(gamingTime)
	self:_refreshGamingTime()

	if gamingTime <= 0 then
		self:_startGameResult()
	end
end

function CatchPropsGameView:_checkCollision()
	local catcherBox = self._catcher:getBoundingBox()
	local props = self._propsSpawner:getProps()

	if props then
		for i = 1, #props do
			local box = props[i]:getBoundingBox()

			if catcherBox:intersects(box) then
				props[i]:onCatached()
				self._propsSpawner:returnObject(props[i])
			end
		end
	end
end

function CatchPropsGameView:_onCatchPropsAddScores(score)
	self:_refreshPropsNum()

	local addScore = self:_popTextItem(self._txtAddScorePool, self._addScore)
	local txt = addScore:GetComponent(goutil.Type_UIText)

	txt.text = "+" .. score

	addScore.transform:SetParent(self._rightBottom.transform)
	Framework.TransformUtil.SetLocalScale(addScore.transform, 1, 1, 1)

	local startPosX, startPosY, startPosZ = Framework.TransformUtil.GetLocalPos(self._addScore.transform, 0, 0, 0)

	UnityTweens.TweenPosition.StartTween(addScore, Vector3.New(startPosX, startPosY, startPosZ), Vector3.New(startPosX, startPosY + 30, startPosZ), 0.5, UnityTweens.EaseType.easeOutSine, 0.3):AddListener(function()
		self:_recycleTextItem(self._txtAddScorePool, addScore)

		self._movingAddScore[addScore] = nil
	end)

	self._movingAddScore = self._movingAddScore or {}
	self._movingAddScore[addScore] = addScore

	addScore:SetActive(true)
end

function CatchPropsGameView:_onCatchPropsAddTime(time)
	self:_refreshGamingTime()

	local addTime = self:_popTextItem(self._txtAddTimePool, self._addTime)
	local txt = addTime:GetComponent(goutil.Type_UIText)

	txt.text = "+" .. time

	addTime.transform:SetParent(self._rightBottom.transform)
	Framework.TransformUtil.SetLocalScale(addTime.transform, 1, 1, 1)

	local startPosX, startPosY, startPosZ = Framework.TransformUtil.GetLocalPos(self._addTime.transform, 0, 0, 0)

	UnityTweens.TweenPosition.StartTween(addTime, Vector3.New(startPosX, startPosY, startPosZ), Vector3.New(startPosX, startPosY + 50, startPosZ), 0.5, UnityTweens.EaseType.easeOutSine, 0.3):AddListener(function()
		self:_recycleTextItem(self._txtAddTimePool, addTime)

		self._movingAddTime[addTime] = nil
	end)

	self._movingAddTime = self._movingAddTime or {}
	self._movingAddTime[addTime] = addTime

	addTime:SetActive(true)
end

function CatchPropsGameView:_popTextItem(pool, prefab)
	local go

	if pool then
		local go = pool[1]

		if go then
			table.remove(pool, 1)
		end
	end

	go = go or goutil.clone(prefab)

	return go
end

function CatchPropsGameView:_recycleTextItem(pool, go)
	table.insert(pool, go)
	go:SetActive(false)
end

function CatchPropsGameView:_clearAllTxtPools()
	for i = 1, #self._txtAddTimePool do
		goutil.destroy(self._txtAddTimePool[i])
	end

	self._txtAddTimePool = nil

	for i = 1, #self._txtAddScorePool do
		goutil.destroy(self._txtAddScorePool[i])
	end

	self._txtAddScorePool = nil

	if self._movingAddTime then
		for k, v in pairs(self._movingAddTime) do
			goutil.destroy(v)
		end

		self._movingAddTime = nil
	end

	if self._movingAddScore then
		for k, v in pairs(self._movingAddScore) do
			goutil.destroy(v)
		end

		self._movingAddScore = nil
	end
end

function CatchPropsGameView:_crazyModelEvent()
	goutil.setActive(self._crazyTip, true)

	local time = CatchPropsConfig.instance:getCrazyTipTime()

	settimer(time, self._crazyModelTipOver, self, false)
end

function CatchPropsGameView:_crazyModelTipOver()
	goutil.setActive(self._crazyTip, false)
end

return CatchPropsGameView
