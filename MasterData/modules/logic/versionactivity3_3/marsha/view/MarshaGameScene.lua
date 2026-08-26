-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaGameScene.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaGameScene", package.seeall)

local MarshaGameScene = class("MarshaGameScene", BaseView)

function MarshaGameScene:onInitView()
	self.goExpLayer = gohelper.findChild(self.viewGO, "Scene/go_ExpLayer")
	self.goBallLayer = gohelper.findChild(self.viewGO, "Scene/go_BallLayer")
	self.itemMap = {
		[MarshaEnum.UnitType.Player] = gohelper.findChild(self.goBallLayer, "go_PlayerItem"),
		[MarshaEnum.UnitType.Speed] = gohelper.findChild(self.goBallLayer, "go_RepressItem"),
		[MarshaEnum.UnitType.Debuff] = gohelper.findChild(self.goBallLayer, "go_DespairItem"),
		[MarshaEnum.UnitType.Inverse] = gohelper.findChild(self.goBallLayer, "go_StressItem"),
		[MarshaEnum.UnitType.SubWeight] = gohelper.findChild(self.goBallLayer, "go_PainItem"),
		[MarshaEnum.UnitType.Dead] = gohelper.findChild(self.goBallLayer, "go_CrashItem"),
		[MarshaEnum.UnitType.Exp] = gohelper.findChild(self.goExpLayer, "go_ScrapItem")
	}

	if self._editableInitView then
		self:_editableInitView()
	end
end

MarshaGameScene.BoundRate = Vector2(0.45, 0.4)

function MarshaGameScene:_editableInitView()
	MarshaEntityMgr.instance:setRoot(self.goExpLayer, self.goBallLayer, self.itemMap)

	self.sceneTrans = gohelper.findChild(self.viewGO, "Scene").transform
	self.mapSize = MarshaEnum.MapSize
	self.mapMaxX = 0
	self.mapMaxY = 0

	self:onScreenSizeChanged()

	self.uiCamera = CameraMgr.instance:getUICamera()
end

function MarshaGameScene:onOpen()
	if not self.viewParam then
		return
	end

	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GameStart, self.startGame, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GamePause, self.pauseGame, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GameResume, self.startGame, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GameReset, self.resetGame, self)
	self:loadMapEntity()

	self.playerEntity = MarshaEntityMgr.instance:getPlayerEntity()

	TaskDispatcher.runRepeat(self.followPlayer, self, 0.5)
end

function MarshaGameScene:onDestroyView()
	TaskDispatcher.cancelTask(self.followPlayer, self)
	TaskDispatcher.cancelTask(self.initExpEntity, self)
	MarshaEntityMgr.instance:clear()
end

function MarshaGameScene:onScreenSizeChanged()
	local canvasGo = ViewMgr.instance:getUIRoot()
	local rootTrans = canvasGo.transform

	self.viewWidth = recthelper.getWidth(rootTrans)
	self.viewHeight = recthelper.getHeight(rootTrans)
	self.mapMinX = self.viewWidth - self.mapSize.x
	self.mapMinY = self.viewHeight - self.mapSize.y
end

function MarshaGameScene:startGame()
	MarshaEntityMgr.instance:beginTick()

	self.isRunning = true
end

function MarshaGameScene:pauseGame()
	self.isRunning = false

	MarshaEntityMgr.instance:pauseTick()
end

function MarshaGameScene:resetGame()
	MarshaEntityMgr.instance:clear()
	self:loadMapEntity()

	self.playerEntity = MarshaEntityMgr.instance:getPlayerEntity()
end

function MarshaGameScene:loadMapEntity()
	local mapId = self.viewParam

	MarshaEntityMgr.instance:initParam(mapId)

	local mapCo = MarshaConfig.instance:getMapConfig(mapId)

	if mapCo then
		for _, unit in pairs(mapCo.units) do
			MarshaEntityMgr.instance:addEntity(unit)
		end

		local gameCo = MarshaConfig.instance:getGameConfig(mapId)

		self._maxPaperScraps = string.splitToNumber(gameCo.type7Num, "#")[2]

		local loopCnt = math.ceil(self._maxPaperScraps / 200)

		self.expCnt = 0

		TaskDispatcher.runRepeat(self.initExpEntity, self, 0.01, loopCnt)
	end
end

function MarshaGameScene:initExpEntity()
	for _ = 1, 200 do
		self.expCnt = self.expCnt + 1

		if self.expCnt <= self._maxPaperScraps then
			MarshaEntityMgr.instance:addExpEntity()
		else
			break
		end
	end
end

function MarshaGameScene:followPlayer()
	if not self.playerEntity then
		return
	end

	local playerX, playerY = recthelper.getAnchor(self.playerEntity.trans)
	local point = self.uiCamera:WorldToViewportPoint(self.playerEntity.trans.position)
	local mapX, mapY = recthelper.getAnchor(self.sceneTrans)
	local targetPos = Vector2(mapX, mapY)

	if point.x ~= 0.5 then
		targetPos.x = self.viewWidth / 2 - playerX
	end

	if point.y ~= 0.5 then
		targetPos.y = self.viewHeight / 2 - playerY
	end

	targetPos.x = Mathf.Clamp(targetPos.x, self.mapMinX, self.mapMaxX)
	targetPos.y = Mathf.Clamp(targetPos.y, self.mapMinY, self.mapMaxY)

	if mapX ~= targetPos.x or mapY ~= targetPos.y then
		self:setMapPosSafety(targetPos, true)
	end
end

function MarshaGameScene:setMapPosSafety(targetPos, tween)
	if not self.sceneTrans then
		return
	end

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	if tween then
		self.tweenId = ZProj.TweenHelper.DOAnchorPos(self.sceneTrans, targetPos.x, targetPos.y, 0.5, self._localMoveDone, self, nil, EaseType.Linear)
	else
		recthelper.setAnchor(self.sceneTrans, targetPos.x, targetPos.y)
	end
end

function MarshaGameScene:_localMoveDone()
	self.tweenId = nil
end

return MarshaGameScene
