-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/cutfruit/CutFruitSceneView.lua

module("logic.extensions.godlongyan.view.cutfruit.CutFruitSceneView", package.seeall)

local CutFruitSceneView = class("CutFruitSceneView", ViewComponent)

function CutFruitSceneView:ctor()
	CutFruitSceneView.super.ctor(self)
end

function CutFruitSceneView:buildUI()
	CutFruitSceneView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._endTitleImg = goutil.findChild(self.mainGO, "endTitleImg")
	self._topEffGo = goutil.findChild(self.mainGO, "topEff")
	self._tipsCol = goutil.findChild(self.mainGO, "tipsCol")
	self._txtScoreRoot = goutil.findChild(self.mainGO, "tipsCol/score/txtRoot")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "tipsCol/score/txtRoot/txt")
	self._txtGameTime = goutil.findChildTextComponent(self.mainGO, "tipsCol/gameTimer/txt")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tipsCol/gameTimer/txtTips")
	self._gameCol = goutil.findChild(self.mainGO, "gameCol")
	self._propPool = goutil.findChild(self.mainGO, "gameCol/propPool")
	self._propCell = goutil.findChild(self.mainGO, "gameCol/propCell")
	self._propView = goutil.findChild(self.mainGO, "gameCol/propView")
	self._effView = goutil.findChild(self.mainGO, "gameCol/effView")

	GameUtil.SetActive(self._propCell, false)

	self._propEffs = {}
	self._topEff = nil
end

function CutFruitSceneView:bindEvents()
	CutFruitSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CutFruitSceneView:unbindEvents()
	CutFruitSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutFruitSceneView:destroyUI()
	CutFruitSceneView.super.destroyUI(self)
end

function CutFruitSceneView:onEnter()
	CutFruitSceneView.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())
	self._glyData = GodLongYanConfig.instance:getGlyData(self._challengeId)
	self._gamePlanId = self._glyData.gamePlanId

	if self._gamePlanId == 0 or self._gamePlanId == nil then
		printError("缺失或读取错误,gamePlanId错误")
		self:close()

		return
	end

	local dayGameTimes = GodLongYanConfig.instance:getDayGameTimes()
	local hasPlayTimes = GodLongYanModel.instance:getGameHasPlayTimes()

	if dayGameTimes <= hasPlayTimes then
		FloatWordMgr.instance:show("达到每日次数限制")
		self:close()

		return
	end

	self._curStageIdx = GodLongYanModel.instance:getCurStageIdx()
	self._gameData = GodLongYanConfig.instance:getGameDataById(self._gamePlanId)

	self:_onSetUI()
	self:_onReset()
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeStartGameRes, self._playStartEff, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeEndGameRes, self._handleEndGameRes, self)
	GodLongYanController.instance:onSendGodLongYanChallengeStartGameReq()
end

function CutFruitSceneView:onExit()
	CutFruitSceneView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeStartGameRes, self._playStartEff, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeEndGameRes, self._handleEndGameRes, self)
	removetimer(self._startNextArea, self)
	removetimer(self._doDropAreaAnim, self)
	removetimer(self._startStageTimer, self)
	self:_clearPool()
	GodLongYanModel.instance:clearCutFruitDataMo()

	for _, eff in pairs(self._propEffs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	UIEffectManager.instance:stopEffect(self._topEff)

	self._topEff = nil
end

function CutFruitSceneView:_onSetUI()
	local effParent = self._topEffGo
	local pathName = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_huanjing"

	UIEffectManager.instance:stopEffect(self._topEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(_, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._topEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, nil)
	end
end

function CutFruitSceneView:_onReset()
	GameUtil.SetActive(self._endTitleImg, false)
	GameUtil.SetActive(self._txtTips.gameObject, false)

	self._cfDataMo = GodLongYanModel.instance:getCutFruitDataMo()

	self._cfDataMo:init(self._gamePlanId, self._curStageIdx)

	self._txtGameTime.text = self._cfDataMo:getCurMaxStageTime() .. "秒"
	self._txtScore.text = "0"
end

function CutFruitSceneView:_playStartEff()
	local pathName = "20220401/zhouniandangaohuodong/fx_ui_kaishidati_cjl.prefab"
	local effGo = self.mainGO

	local function finishHandler(handlerTarget, eff)
		self:_startGame()
	end

	local function loadedHandler(_, eff)
		eff:setParent(effGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, finishHandler, loadedHandler, nil)
end

function CutFruitSceneView:_startGame()
	ViewBlockMgr.instance:blockClick(false, self)
	removetimer(self._startStageTimer, self)
	settimer(1, self._startStageTimer, self, true)
	self:_startNextArea()
end

function CutFruitSceneView:_startNextArea()
	self._cfDataMo:startNextArea()

	self._rowIdx = 0

	self:_doDropAreaAnim()
end

function CutFruitSceneView:_startStageTimer()
	if self._cfDataMo:getCurStageTime() - 1 < 0 then
		self:_endGame()

		return
	end

	self._cfDataMo:addCurStageTime(-1)
	self:_updateTxtGameTime(self._cfDataMo:getCurStageTime())
end

function CutFruitSceneView:_doDropAreaAnim()
	self._rowIdx = self._rowIdx + 1

	local rowNum = self._cfDataMo:getCurRowNum()

	if rowNum < self._rowIdx then
		local areaInterval = self._cfDataMo:getCurAreaInterval()

		removetimer(self._startNextArea, self)
		settimer(areaInterval, self._startNextArea, self, false)

		return
	end

	local areaPropFmt = self._cfDataMo:getCurAreaPropFmt()
	local propList = areaPropFmt[self._rowIdx]

	self:_doDropRowAnim(propList)

	local rowInterval = self._cfDataMo:getCurRowInterval()

	removetimer(self._doDropAreaAnim, self)
	settimer(rowInterval, self._doDropAreaAnim, self, false)
end

function CutFruitSceneView:_doDropRowAnim(propList)
	local rowNum = self._cfDataMo:getCurRowNum()
	local colNum = self._cfDataMo:getCurColNum()
	local areaWidth = GameUtil.getWidth(self._propView)
	local perPosX = areaWidth / colNum
	local height = GameUtil.getHeight(self._propView)

	for colIdx, propId in ipairs(propList) do
		if propId ~= 0 then
			local posX = perPosX * colIdx
			local floatPosX = 0

			if Mathf.Random(0, 1) == 1 then
				local delta = Mathf.Random(1, 3)
				local floatColIdx = Mathf.Random(colIdx - delta, colIdx + delta)

				floatColIdx = Mathf.Clamp(floatColIdx, 1, colNum)
				floatPosX = perPosX * floatColIdx
			end

			self:_doDropPropAnim(posX, floatPosX, height, propId)
		end
	end
end

function CutFruitSceneView:_doDropPropAnim(posX, floatPosX, height, propId)
	local cell = self:_getPropCell(propId)
	local moveDuration = self._cfDataMo:getCurMoveDuration()
	local EaseType = DG.Tweening.Ease.Linear

	local function finishHandler()
		self:_putToPool(cell)
	end

	GameUtil.setLocalPos(cell, posX, 0, 0)

	local tarPosY = -height
	local tarVec = Vector3.New(posX, tarPosY, 0)

	if floatPosX ~= 0 then
		cell.transform:DOLocalMoveX(floatPosX, moveDuration):SetEase(DG.Tweening.Ease.Linear)
	end

	cell.transform:DOLocalMoveY(tarVec.y, moveDuration):SetEase(EaseType):OnComplete(finishHandler)
end

function CutFruitSceneView:_getPropCell(propId)
	local propCell = self:_getGoFromPool()
	local itemImg = goutil.findChild(propCell, "itemImg")
	local clickArea = goutil.findChild(propCell, "clickArea")
	local propData = GodLongYanConfig.instance:getGamePropData(propId)

	goutil.addChildToParent(propCell, self._propView)
	GameUtil.setLocalPos(propCell, 0, 0, 0)
	GameUtil.setLocalScale(propCell, 1, 1, 1)

	local path = propData.imgPath
	local bgGo = itemImg

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	if not propData.imgScaleArray then
		local imgScaleArray = {}
		local scaleX, scaleY, scaleZ = imgScaleArray[1] or 1, imgScaleArray[2] or 1, 1

		GameUtil.setLocalScale(itemImg, scaleX, scaleY, scaleZ)

		if not propData.clickScaleArray then
			local scaleX, scaleY, scaleZ = propData.clickScaleArray[1] or 1, propData.clickScaleArray[2] or 1, 1

			GameUtil.setLocalScale(clickArea, scaleX, scaleY, scaleZ)
			GameUtil.addClickHandler(clickArea, GameUtil.handler(self._onClickPropCell, self, propCell, propData))
			GameUtil.SetActive(clickArea, true)
			GameUtil.SetActive(itemImg, true)
			GameUtil.SetActive(propCell, true)

			return propCell
		end
	end
end

function CutFruitSceneView:_onClickPropCell(cell, data)
	cell.transform:DOPause()

	local clickArea = goutil.findChild(cell, "clickArea")

	GameUtil.SetActive(clickArea, false)

	local curStageIdx = self._cfDataMo:getCurStageIdx()

	self._cfDataMo:addStageScore(data.score)
	self._cfDataMo:addCurStageTime(data.second)

	local curScore = self._cfDataMo:getStageScore()
	local curStageTime = self._cfDataMo:getCurStageTime()

	if data.second ~= 0 then
		self:_updateTxtGameTime(curStageTime, data.second)
	end

	local effGo = self._effView
	local path = data.clickEffPath

	UIEffectManager.instance:stopEffect(self._propEffs[cell])

	local isNeedEff = effGo and not string.nilorempty(path)

	if isNeedEff then
		GameUtil.SetActive(cell, false)

		local pathName = path .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self:_updateTxtScore(curScore, data.score)
			cell.transform:DOKill(false)
			self:_putToPool(cell)
		end

		local function loadedHandler(_, eff)
			eff:setParent(effGo.transform)

			local pos = GameUtil.getPos(cell)

			eff:setPos(pos.x, pos.y, pos.z)
			eff:setScale(1, 1, 1)
		end

		self._propEffs[cell] = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, finishHandler, loadedHandler, nil)
	elseif data.score > 0 then
		self:_flyToHeaven(cell, self._txtScore.gameObject, function()
			self:_updateTxtScore(curScore, data.score)
		end)
	else
		self:_updateTxtScore(curScore, data.score)
		cell.transform:DOKill(false)
		self:_putToPool(cell)
	end
end

function CutFruitSceneView:_flyToHeaven(go, tarGo, finishHandler)
	local goPos = GameUtil.getPos(go)
	local tarGoPos = GameUtil.getPos(tarGo)

	local function callBack()
		if finishHandler then
			finishHandler()
		end

		go.transform:DOKill(false)
		self:_putToPool(go)
	end

	go.transform:DOScale(Vector3.New(0.4, 0.4, 0.4), 0.6):SetEase(DG.Tweening.Ease.InQuad)
	go.transform:DOMove(tarGoPos, 0.7):SetEase(DG.Tweening.Ease.InQuart):OnComplete(callBack)
end

function CutFruitSceneView:_updateTxtScore(value, delta)
	if delta == 0 then
		return
	end

	self._txtScore.text = value

	self._txtScoreRoot.transform:DOShakePosition(0.3, Vector3.New(1, 1.2, 1), 3, 90)
	self._txtScoreRoot.transform:DOScale(Vector3.New(1.2, 1.2, 1.2), 0.1):SetLoops(2, DG.Tweening.LoopType.Yoyo)
end

function CutFruitSceneView:_updateTxtGameTime(value, delta)
	self._txtGameTime.text = value .. "秒"

	if value < 10 then
		self._txtGameTime.transform:DOKill(true)
		self._txtGameTime.transform:DOScale(Vector3.New(1.2, 1.2, 1.2), 0.3):SetEase(DG.Tweening.Ease.OutQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo)
	end

	if delta == nil or delta == 0 then
		return
	end

	if delta < 0 then
		self._txtTips.text = string.format("<color=#FF4D4DFF>%s</color>", delta)
	elseif delta > 0 then
		self._txtTips.text = string.format("<color=#41E156FF>%s</color>", "+" .. delta)
	end

	self._txtTips.transform:DOKill(true)
	GameUtil.SetActive(self._txtTips.gameObject, true)

	local function callBack()
		GameUtil.SetActive(self._txtTips.gameObject, false)
	end

	self._txtTips.transform:DOScale(Vector3.New(1.1, 1.1, 1.1), 0.2):SetEase(DG.Tweening.Ease.OutQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo):OnComplete(callBack)
end

function CutFruitSceneView:_stopAllPropAnim()
	local children = GameUtil.getChildren(self._propView)

	for _, go in ipairs(children) do
		go.transform:DOKill(false)
		self:_putToPool(go)
	end
end

function CutFruitSceneView:_getGoFromPool()
	local childCount = self._propPool.transform.childCount

	if childCount >= 1 then
		local trans = self._propPool.transform:GetChild(0)

		return (trans or nil) and (trans.gameObject or nil)
	else
		return goutil.cloneAndSetParent(self._propCell, self._propPool.transform)
	end
end

function CutFruitSceneView:_putToPool(go)
	if go == nil then
		printError("警告:试图存入不存在的实例")

		return
	end

	local eff = self._propEffs[go]

	if eff then
		UIEffectManager.instance:stopEffect(eff)
	end

	GameUtil.SetActive(go, false)
	goutil.addChildToParent(go, self._propPool)
end

function CutFruitSceneView:_clearPool()
	self:_stopAllPropAnim()

	if self._propPool == nil then
		printError("错误:实例池丢失,务必检查！！！")

		return
	end

	local children = GameUtil.getChildren(self._propPool)

	for _, go in ipairs(children) do
		self._propEffs[go] = nil

		goutil.destroy(go)
	end
end

function CutFruitSceneView:_endGame()
	ViewBlockMgr.instance:blockClick(true, self)
	removetimer(self._startStageTimer, self)
	removetimer(self._doDropAreaAnim, self)
	removetimer(self._startNextArea, self)
	self:_stopAllPropAnim()
	GodLongYanController.instance:onSendGodLongYanChallengeEndGameReq()
end

function CutFruitSceneView:_handleEndGameRes(changeSetId, prizeStrList)
	GameUtil.setLocalScale(self._endTitleImg, 0.4, 0.4, 0.4)
	GameUtil.SetActive(self._endTitleImg, true)

	local function callback()
		ViewBlockMgr.instance:blockClick(false, self)
		self:_showResult(changeSetId, prizeStrList)
	end

	self._endTitleImg.transform:DOScale(1, 2):SetEase(DG.Tweening.Ease.OutBounce):OnComplete(callback)
end

function CutFruitSceneView:_showResult(changeSetId, prizeStrList)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
	self:close()
end

return CutFruitSceneView
