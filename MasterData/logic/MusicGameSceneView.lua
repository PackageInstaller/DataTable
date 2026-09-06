-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/view/MusicGameSceneView.lua

module("logic.extensions.musicgame.view.MusicGameSceneView", package.seeall)

local MusicGameSceneView = class("MusicGameSceneView", ViewComponent)

function MusicGameSceneView:ctor()
	MusicGameSceneView.super.ctor(self)

	self._symbolCellList = {}
	self._symbolCellDic = {}
	self._lineHitBox2Ds = {}
	self._comobCount = 0
	self._curDischargeCount = 0
	self._maxGameTime = 0
	self._dischargeTime = 0
	self._totalDischargeCount = 0
	self._dischargeIntervalSec = 0
	self._dischargeCd = 0
	self._curGameTime = 0
	self.destroyed = false
end

function MusicGameSceneView:buildUI()
	MusicGameSceneView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._downCount = goutil.findChild(self.mainGO, "downCount")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "score/txt")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._symbolView = goutil.findChild(self.mainGO, "symbolView")
	self._symbolPool = goutil.findChild(self.mainGO, "symbolPool")
	self._mapBound = goutil.findChild(self.mainGO, "mapBound")
	self._hitPointView = goutil.findChild(self.mainGO, "hitPointView")
	self._hitPoint = goutil.findChild(self.mainGO, "hitPoint")
	self._lineView = goutil.findChild(self.mainGO, "lineView")
	self._lineCell = goutil.findChild(self.mainGO, "lineCell")
	self._comobCell = goutil.findChild(self.mainGO, "comobCell")
	self._txtCombo = goutil.findChildTextComponent(self.mainGO, "combo/txt")
	self._readyCounterComp = WBB_UITimeCounter.New(self._downCount)

	local boxX, boxY, boxZ = Framework.TransformUtil.GetLocalPos(self._mapBound.transform, nil, nil, nil)

	self._mapBoundBox2D = BoundingBox2D.New()

	self._mapBoundBox2D:setSize(self._mapBound.transform.sizeDelta.x, self._mapBound.transform.sizeDelta.y)
	self._mapBoundBox2D:setCenter(boxX, boxY)
end

function MusicGameSceneView:bindEvents()
	MusicGameSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._exitGame, self)
end

function MusicGameSceneView:unbindEvents()
	MusicGameSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MusicGameSceneView:onEnter()
	MusicGameSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._mgViewParam = params[1] or MusicGameViewParam.New()
	self._stageId = self._mgViewParam:getStageId()

	self:_onInitGameMgr()
	self.addGEvent(self, GlobalNotify.MusicGameOnClickSymbolCell, self._handleMusicGameOnClickSymbolCell, self)
	self.addGEvent(self, GlobalNotify.MusicGameSceneViewSatusOp, self._handleMusicGameSceneViewSatusOp, self)
	self:_startTicking()
end

function MusicGameSceneView:onExit()
	MusicGameSceneView.super.onExit(self)
	self:_stopTicking()
	GameUtil.clearCells(self._hitPointView, self._clearHitPoint, self)
	GameUtil.clearCells(self._lineView, self._clearLineCell, self)
	table.clear(self._lineHitBox2Ds)
	self:_doGameEndCallBack(MusicGameEnum.GameEndRes_ForceExit)

	self._gameMgr = nil

	self:_clearSymbolCellPool()
	self._readyCounterComp:stop()

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId = 0

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

function MusicGameSceneView:destroyUI()
	MusicGameSceneView.super.destroyUI(self)
	self._readyCounterComp:dispose()

	self._readyCounterComp = nil
end

function MusicGameSceneView:_handleMusicGameSceneViewSatusOp(gameStatusOp)
	if gameStatusOp == MusicGameEnum.GameStatusOp_Close then
		self:close()
	elseif gameStatusOp == MusicGameEnum.GameStatusOp_Continue then
		self:_continueGame()
	end
end

function MusicGameSceneView:_onInitGameMgr()
	self._gameMgr = MusicGameController.instance:getGameMgr(self._stageId)
	self._stageData = MusicGameConfig.instance:getStageData(self._stageId)
	self._audioId = self._stageData.audioId
	self._speedRate = self._stageData.speedRate

	self:_creatSymbolCellPool(self._stageData.symbolPrefabName)

	local lineIdList = {}

	for lineId = 1, self._gameMgr:getLineCount() do
		table.insert(lineIdList, lineId)
	end

	self._lineHitBox2Ds = {}

	GameUtil.updateCellsList(self._hitPointView, self._hitPoint, lineIdList, self._updateHitPoint, self)
	GameUtil.updateCellsList(self._lineView, self._lineCell, lineIdList, self._updateLineCell, self)
	self:_resetGame()
end

function MusicGameSceneView:_stopGame()
	AudioPlayerEx.instance:pauseMusic(self._audioId, true)
	self._gameMgr:stopGame()

	local text = "游戏暂停中"

	local function func()
		self:_continueGame()
	end

	local btnText = "继续游戏"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
end

function MusicGameSceneView:_continueGame()
	if self._audioId > 0 then
		AudioPlayerEx.instance:pauseMusic(self._audioId, false)
	end

	self._gameMgr:continueGame()
end

function MusicGameSceneView:_finishGame()
	AudioPlayerEx.instance:pauseMusic(self._audioId, true)
	self._gameMgr:endGame()
	self:_doGameEndCallBack(MusicGameEnum.GameEndRes_Finish)
end

function MusicGameSceneView:_exitGame()
	AudioPlayerEx.instance:pauseMusic(self._audioId, true)
	self._gameMgr:stopGame()
	self:_doGameEndCallBack(MusicGameEnum.GameEndRes_Exit)
end

function MusicGameSceneView:_doGameEndCallBack(gameEndRes)
	self._mgViewParam:doGameEndCallBack(gameEndRes, self._stageId)
end

function MusicGameSceneView:_resetGame()
	self._isRuningEndAnim = false

	self._gameMgr:resetGame()

	self._comobCount = self._gameMgr:getCurComboNum()
	self._curDischargeCount = self._gameMgr:getCurDischargeCount()
	self._curGameTime = self._gameMgr:getCurGameTime()
	self._maxGameTime = self._gameMgr:getMaxGameTime()
	self._dischargeTime = self._gameMgr:getDischargeTime()
	self._totalDischargeCount = self._gameMgr:getTotalDischargeCount()
	self._dischargeIntervalSec = self._dischargeTime / self._totalDischargeCount
	self._dischargeCd = 0
	self._txtCombo.text = 0
	self._txtScore.text = 0

	if self._audioId > 0 then
		AudioPlayerEx.instance:playMusic(self._audioId)
		settimer(0, function()
			AudioPlayerEx.instance:pauseMusic(self._audioId, true)
		end, self, false)
	end

	self._txtScore.text = self._gameMgr:getCurTotalScore()
	self._txtTime.text = checkint(self._gameMgr:getLeftGameTime())

	self._readyCounterComp:play(3, self._continueGame, self)
end

function MusicGameSceneView:_updateHitPoint(mainGo, lineId, index)
	local endVec = self._gameMgr:getLineEndVec(lineId)

	GameUtil.setLocalPos(mainGo, endVec.x, endVec.y, endVec.z)

	local comp = self._lineHitBox2Ds[lineId]

	if comp == nil then
		comp = BoundingBox2D.New()
		self._lineHitBox2Ds[lineId] = comp
	end

	comp:setSize(mainGo.transform.sizeDelta.x, mainGo.transform.sizeDelta.y)
	comp:setCenter(endVec.x, endVec.y)
	GameUtil.SetActive(mainGo, self._mgViewParam:isTestMode())
end

function MusicGameSceneView:_clearHitPoint(mainGo)
	return
end

function MusicGameSceneView:_updateLineCell(mainGo, lineId, index)
	local startVec = self._gameMgr:getLineStartVec(lineId)
	local endVec = self._gameMgr:getLineEndVec(lineId)
	local distance = Vector2.Distance(startVec, endVec)
	local dx = startVec.x - endVec.x
	local dy = startVec.y - endVec.y
	local angle = math.deg(math.atan2(dy, dx))

	angle = angle - 90

	GameUtil.setHeight(mainGo, distance)
	GameUtil.setLocalRotation(mainGo, 0, 0, angle)
	GameUtil.setLocalPos(mainGo, startVec.x, startVec.y, 0)
end

function MusicGameSceneView:_clearLineCell(mainGo)
	return
end

function MusicGameSceneView:_startTicking()
	self:_onTicking()
	settimer(0, self._onTicking, self, true)
end

function MusicGameSceneView:_stopTicking()
	removetimer(self._onTicking, self)
end

function MusicGameSceneView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime

	if self._gameMgr:getCurState() ~= MusicGameEnum.State_Runing then
		return
	end

	self._gameMgr:setCurGameTime(self._gameMgr:getCurGameTime() + self._deltaTime)

	self._dischargeCd = self._dischargeCd + self._deltaTime

	local dischargeCount = 0

	if self._gameMgr:getCurDischargeCount() < self._gameMgr:getTotalDischargeCount() and self._dischargeCd >= self._dischargeIntervalSec then
		self._dischargeCd = 0

		self._gameMgr:setCurDischargeCount(self._gameMgr:getCurDischargeCount() + 1)

		dischargeCount = 1
	end

	local x, y = 0, 0

	for _, symbolCell in ipairs(self._symbolCellList) do
		local var_24_0

		var_24_0, y = symbolCell:getLocalPos()

		if not self._mapBoundBox2D:contains(var_24_0, y) or y <= self._gameMgr:getLineEndVec(symbolCell:getLineId()).y then
			symbolCell:trickOutBound()
			self._gameMgr:resetComboNum()
		end
	end

	local tempSymbolCellList = {}

	table.insertto(tempSymbolCellList, self._symbolCellList)

	for _, symbolCell in ipairs(tempSymbolCellList) do
		if symbolCell:getState() == MusicGameEnum.SymbolState_Ended then
			self:_returnSymbolCell(symbolCell)
		end
	end

	for _, symbolCell in ipairs(self._symbolCellList) do
		symbolCell:onTicking(self._deltaTime)
	end

	if dischargeCount > 0 then
		local count = self._gameMgr:getDischargeType(self._gameMgr:getCurDischargeCount())
		local randomLineIds = MathUtil.randomEx(1, self._gameMgr:getLineCount(), count)

		for idx = 1, count do
			local lineId = randomLineIds[idx]
			local symbolCell = self:_fetchSymbolCell(lineId)

			symbolCell:startRunning()
		end
	end

	if self._comobCount ~= self._gameMgr:getCurComboNum() then
		self._comobCount = self._gameMgr:getCurComboNum()
		self._txtCombo.text = Mathf.Max(self._comobCount, 0)
	end

	local leftGameTime = self._gameMgr:getLeftGameTime()

	self._txtScore.text = self._gameMgr:getCurTotalScore()
	self._txtTime.text = checkint(leftGameTime)

	if leftGameTime <= 0 then
		self:_finishGame()
	end
end

function MusicGameSceneView:_handleMusicGameOnClickSymbolCell(entityId)
	if self._gameMgr:getCurState() ~= MusicGameEnum.State_Runing then
		return
	end

	local symbolCell = self._symbolCellDic[entityId]

	if symbolCell == nil then
		printError(string.format("获取音符组件失败，请检查entityId是否正确( entityId = %s )", entityId))

		return
	end

	if symbolCell:getState() == MusicGameEnum.SymbolState_Running then
		local lineId = symbolCell:getLineId()
		local symbolCellBox2D = symbolCell:getBoundingBox2D()
		local lineHitBox2D = self._lineHitBox2Ds[lineId]

		symbolCell:trickHit(lineHitBox2D)

		if symbolCell:isHit() then
			self._gameMgr:addHitNum(1)
			self._gameMgr:addComboNum(1)
		else
			self._gameMgr:resetComboNum()
		end
	end
end

function MusicGameSceneView:_fetchSymbolCell(lineId)
	local symbolCell = self._symbolCompPool:fetchObject()
	local go = self._symbolGoPool:fetchObject()

	goutil.addChildToParent(go, self._symbolView)
	GameUtil.SetActive(go, true)
	symbolCell:init(go, lineId, self._speedRate, self)
	symbolCell:setLocalPos(self._gameMgr:getLineStartVec(lineId))

	local entityId = symbolCell:getEntityId()

	table.insert(self._symbolCellList, symbolCell)

	self._symbolCellDic[entityId] = symbolCell

	return symbolCell
end

function MusicGameSceneView:_returnSymbolCell(symbolCell)
	local entityId = symbolCell:getEntityId()
	local pos = 0

	for idx, v in ipairs(self._symbolCellList) do
		if v:getEntityId() == entityId then
			pos = idx

			break
		end
	end

	table.remove(self._symbolCellList, pos)

	self._symbolCellDic[entityId] = nil

	local go = symbolCell:getGameObject()

	self._symbolGoPool:returnObject(go)
	self._symbolCompPool:returnObject(symbolCell)
end

function MusicGameSceneView:_creatSymbolCellPool(prefabName)
	self:_creatSymbolGoPool(prefabName)
	self:_creatSymbolCompPool()
end

function MusicGameSceneView:_clearSymbolCellPool()
	local list = {}

	table.insertto(list, self._symbolCellList)

	for _, symbolCell in ipairs(list) do
		self:_returnSymbolCell(symbolCell)
	end

	self._symbolPoolName = nil

	if self._symbolGoPool then
		self._symbolGoPool:clear()

		self._symbolGoPool = nil
	end

	if self._symbolCompPool then
		self._symbolCompPool:clear()

		self._symbolCompPool = nil
	end
end

function MusicGameSceneView:_creatSymbolGoPool(prefabName)
	if self._symbolPoolName == prefabName then
		return
	end

	local assetPath = string.format(MusicGameSceneViewPresentor.PathPre, prefabName)

	local function createFunc()
		local res = rescache:GetResourceNoLoadIfNotExists(assetPath)

		if not res then
			return
		end

		local mainAsset = res:GetMainAsset()

		if not mainAsset then
			return
		end

		return (goutil.clone(mainAsset))
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		GameUtil.SetActive(go, false)
		goutil.addChildToParent(go, self._symbolPool)
	end

	if self._symbolGoPool then
		self._symbolGoPool:clear()
	end

	self._symbolPoolName = prefabName
	self._symbolGoPool = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function MusicGameSceneView:_creatSymbolCompPool()
	if self._symbolCompPool ~= nil then
		return
	end

	self._curMaxEntityId = 0
	self._recycleEntityIdList = {}

	local function createFunc()
		local entityId = self._recycleEntityIdList[#self._recycleEntityIdList]

		if entityId == nil then
			self._curMaxEntityId = self._curMaxEntityId + 1
			entityId = self._curMaxEntityId
		else
			self._recycleEntityIdList[#self._recycleEntityIdList] = nil
		end

		return MusicGameSymbolCell.New(entityId)
	end

	local function disposeFunc(comp)
		table.insert(self._recycleEntityIdList, comp:getEntityId())
		comp:dispose()
	end

	local function resetFunc(comp)
		comp:reset()
	end

	self._symbolCompPool = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

return MusicGameSceneView
