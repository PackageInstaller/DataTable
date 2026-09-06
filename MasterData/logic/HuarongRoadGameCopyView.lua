-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/copygame/HuarongRoadGameCopyView.lua

module("logic.extensions.maintainpowerpilla.view.copygame.HuarongRoadGameCopyView", package.seeall)

local HuarongRoadGameCopyView = class("HuarongRoadGameCopyView", ViewComponent)

function HuarongRoadGameCopyView:ctor()
	self._moveSpeed = 0.2
	self._recoverSpeed = 0.5
	self._picShowSpeed = 0.6
end

function HuarongRoadGameCopyView:buildUI()
	self._gameMove = self:getGo("pictureInfoGo/gameMove")
	self._block = self:getGo("pictureInfoGo/gridGo")
	self._btnClose = self:getBtn("btnClose")
	self._txtClock = self:getTxt("countDown/txtTime")
	self._effectStartGo = self:getGo("effectStart")
	self._beginGameGo = self:getGo("beginGame")
	self._customInputBegin = UICustomInput.Get(self._beginGameGo)
	self._btnPic = GameUtil.asBtn(self:getGo("preview/picture"))
	self._imgPicMinGo = self:getGo("preview/picture/pictureCon")
	self._previewPicGo = self:getGo("preview/mask")
	self._imgPicBgGo = self:getGo("preview/mask/pictureCon")
	self._customInputPic = UICustomInput.Get(self._imgPicBgGo)
	self._blocks = ItemGroup.New(self._gameMove, self._block, nil, nil, true)
	self._lastBlock = self:getGo("pictureInfoGo/gameMove/lastGridGo")
	self._lastBlockImg = self:getImg("pictureInfoGo/gameMove/lastGridGo/img")
	self._lastBlockImgGo = self:getGo("pictureInfoGo/gameMove/lastGridGo/img")
	self._guideFingerGo = self:getGo("guideFinger")
	self._btnPass = self:getBtn("btnCost")
	self._btnPassGO = self:getGo("btnCost")
	self._txtCost = self:getTxt("btnCost/cost/textNum")
	self._iconCost = self:getGo("btnCost/cost/icon")
	self._btnReset = self:getBtn("btnReset")
	self._imgResultGo = self:getGo("pictureInfoGo/imgResult")
end

function HuarongRoadGameCopyView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._customInputBegin:AddListener(self._onCustomInputBeginCallback, self)
	self._btnPic:AddClickListener(self._onClickBgPic, self)
	self._customInputPic:AddListener(self._onCustomInputBgPicCallback, self)
	self._btnPass:AddClickListener(self._onClickPass, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function HuarongRoadGameCopyView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._customInputBegin:RemoveListener()
	self._btnPic:RemoveClickListener()
	self._customInputPic:RemoveListener()
	self._btnPass:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function HuarongRoadGameCopyView:onEnter()
	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadPassRes, self._PM_HuarongRoadPassRes, self)
	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadBuyQuickPassRes, self._PM_HuarongRoadBuyQuickPassRes, self)
	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadIncreaseSecondRes, self._PM_HuarongRoadIncreaseSecondRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NetConnected, self._saveGameProgress, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPDoGridEventRes, self._handlePM_MPPDoGridEventEndRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stateId = checknumber(params[2])
	self._exParams = params[3]

	HuarongRoadModel.instance:setGameProgress(self._activityId, self._stateId, nil)

	self._cfg = HuarongRoadConfig.instance:getGameStageCfg(self._activityId, self._stateId)
	self._picList = HuarongRoadConfig.instance:getStagePicCfg(self._cfg.levelId)
	self._timePlan = HuarongRoadConfig.instance:getTime(self._activityId)
	self._timeAddCount = 1
	self._isShowOpenEffect = false

	self:_buildMap(self._cfg.rule[1], self._cfg.rule[2], self._cfg.maxTime)

	self._serverKey = nil
	self._clientKey = nil

	if self._cfg.picName and not string.nilorempty(self._cfg.picName) then
		local picPath = GameUrl.getBigbgFolderUrl("saintknight/xiaonuo", self._cfg.picName)

		uGuiUtil.setSpriteToImage(self._imgPicMinGo, uGuiUtil.SpriteType.BigBg, picPath)
		uGuiUtil.setSpriteToImage(self._imgPicBgGo, uGuiUtil.SpriteType.BigBg, picPath)
		uGuiUtil.setSpriteToImage(self._imgResultGo, uGuiUtil.SpriteType.BigBg, picPath)
	end

	local costType, costId, costNum
	local var_5_0, var_5_1, var_5_2 = MaterialMgr.getMatParams(self._cfg.passCost)

	costId = var_5_1
	costType = var_5_0
	self._txtCost.text = langPara("%d", checknumber(var_5_2))

	MaterialMgr.setIcon(self._iconCost, costType, var_5_1)

	self._pathCompleteEffect = "20220729/fx_ui_shengqixiaonuo_pt.prefab"
	self._guideList = {}

	local maxLevel = HuarongRoadModel.instance:getMaxLevel(self._activityId)
	local activityConf = HuarongRoadConfig.instance:getActivityCfg(self._activityId)

	self._haveGuide = activityConf.bNeedGuide and maxLevel < 1
end

function HuarongRoadGameCopyView:onExit()
	HuarongRoadGameCopyView.super.onExit(self)
	GlobalDispatcher:removeListener(HuarongRoadController.PM_HuarongRoadPassRes, self._PM_HuarongRoadPassRes, self)
	GlobalDispatcher:removeListener(HuarongRoadController.PM_HuarongRoadBuyQuickPassRes, self._PM_HuarongRoadBuyQuickPassRes, self)
	GlobalDispatcher:removeListener(HuarongRoadController.PM_HuarongRoadIncreaseSecondRes, self._PM_HuarongRoadIncreaseSecondRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NetConnected, self._saveGameProgress, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPDoGridEventRes, self._handlePM_MPPDoGridEventEndRes, self)
	self._blocks:dispose(function(item)
		local btn = GameUtil.asBtn(item.mainGO)

		btn:RemoveClickListener()

		local imgGo = goutil.findChild(item.mainGO, "img")

		uGuiUtil.clearImage(imgGo)
	end)
	uGuiUtil.clearImage(self._imgPicMinGo)
	uGuiUtil.clearImage(self._imgPicBgGo)
	uGuiUtil.clearImage(self._imgResultGo)
	removetimer(self._moveBlock, self)
	removetimer(self._gameTimeMove, self)
	removetimer(self._showStory, self)
	removetimer(self._showResult, self)
	MaterialMgr.resetAll(self._iconCost)
	UIEffectManager.instance:stopEffect(self._completeEffect)
	UIEffectManager.instance:stopEffect(self._startEffect)
	self:_saveGameProgress()

	self._isShowOpenEffect = false
end

function HuarongRoadGameCopyView:_handlePM_MPPDoGridEventEndRes()
	local param = PowerPillaModel.instance:getResultParam()

	if string.nilorempty(param) then
		return
	end

	local resultJson = GameUtil.jsonToTable(param)

	if resultJson.serverKey then
		self._serverKey = resultJson.serverKey

		self:_startGame()
	end
end

function HuarongRoadGameCopyView:_buildMap(width, height, time)
	local rt = self._gameMove:GetComponent(goutil.Type_RectTransform)

	self._moveTotal = {
		width = rt.rect.width,
		height = rt.rect.height
	}
	self._blockNum = {
		width = width,
		height = height
	}
	self._blockScale = {
		width = 1 / self._blockNum.width,
		height = 1 / self._blockNum.height
	}
	self._maxCount = self._blockNum.width * self._blockNum.height

	local maxCount = self._blockNum.width * self._blockNum.height

	self._gameList = {}

	for i = 1, self._blockNum.height do
		for j = 1, self._blockNum.width do
			local posW = self._moveTotal.width / self._blockNum.width * (j - 0.5) - self._moveTotal.width / 2
			local posH = self._moveTotal.height / 2 - self._moveTotal.height / self._blockNum.height * (i - 0.5)

			table.insert(self._gameList, {
				num = (i - 1) * self._blockNum.width + j,
				posW = posW,
				posH = posH
			})
		end
	end

	self._blockInfo = {}

	for i, v in ipairs(self._gameList) do
		if v.num and maxCount > v.num then
			table.insert(self._blockInfo, i)
		end
	end

	self._blocks:updateWithMoArray(self._blockInfo, function(item, data, i)
		self:_updateBlock(item, data, i)
	end)

	self._txtClock.text = time

	if self._lastBlockImgGo and self._picList[maxCount] and not string.nilorempty(self._picList[maxCount]) then
		uGuiUtil.clearImage(self._lastBlockImgGo)

		local lastBlockPath = GameUrl.getBigbgFolderUrl("saintknight/xiaonuo", self._picList[maxCount])

		uGuiUtil.setSpriteToImage(self._lastBlockImgGo, uGuiUtil.SpriteType.BigBg, lastBlockPath)
	end

	GameUtil.setAnchoredPos(self._lastBlock, self._gameList[maxCount].posW, self._gameList[maxCount].posH)
	Framework.TransformUtil.SetLocalScale(self._lastBlock.transform, self._blockScale.width, self._blockScale.height, 1)
	UnityTweens.UITweenFadeIn.StopTween(self._lastBlockImgGo)
	UnityTweens.UITweenFadeIn.StartTween(self._lastBlockImgGo, 0.01)
	goutil.setActive(self._guideFingerGo, false)
	goutil.setActive(self._beginGameGo, true)
	goutil.setActive(self._imgResultGo, true)

	self._isEnding = false
	self._isMoving = true

	removetimer(self._gameTimeMove, self)

	local recordData = HuarongRoadModel.instance:getGameProgress(self._activityId, self._stateId)

	self._gameTime = recordData and recordData.time and recordData.time > 0 and recordData.time or time
	self._txtClock.text = self._gameTime
end

function HuarongRoadGameCopyView:_reqStartGame()
	if self._exParams.isTrigger or checknumber(self._clientKey) > 0 then
		self:_startGame()
	else
		local activityId = self._exParams.activityId
		local stageId = self._exParams.stageId
		local eventGridId = self._exParams.eventGridId
		local playerGridId = self._exParams.playerGridId
		local form
		local param = {}

		param.startGame = true
		self._clientKey = math.random(1, 100000)
		param.clientKey = self._clientKey

		local jsonParam = GameUtil.jsonToString(param)

		MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(activityId, stageId, eventGridId, playerGridId, form, jsonParam)
	end
end

function HuarongRoadGameCopyView:_sendEndGameReq(isPass)
	if self._exParams.isTrigger then
		return
	end

	if checknumber(self._clientKey) <= 0 then
		return
	end

	if checknumber(self._serverKey) <= 0 then
		return
	end

	local activityId = self._exParams.activityId
	local stageId = self._exParams.stageId
	local eventGridId = self._exParams.eventGridId
	local playerGridId = self._exParams.playerGridId
	local form
	local param = {}

	param.encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {})
	param.isPass = isPass

	local jsonParam = GameUtil.jsonToString(param)

	MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(activityId, stageId, eventGridId, playerGridId, form, jsonParam)
end

function HuarongRoadGameCopyView:_startGame()
	self._isShowOpenEffect = false

	local width = self._cfg.rule[1]
	local height = self._cfg.rule[2]
	local gameList = HuarongRoadConfig.instance:getGameStageList(self._activityId, self._stateId)
	local time = self._cfg.maxTime
	local recordData = HuarongRoadModel.instance:getGameProgress(self._activityId, self._stateId)

	if recordData and recordData.time and recordData.time > 0 then
		time = recordData.time
	else
		HuarongRoadModel.instance:setGameProgress(self._activityId, self._stateId, nil)
	end

	goutil.setActive(self._beginGameGo, false)
	goutil.setActive(self._imgResultGo, false)
	UnityTweens.UITweenFadeOut.StopTween(self._lastBlockImgGo)
	UnityTweens.UITweenFadeOut.StartTween(self._lastBlockImgGo, 0.01)
	self._blocks:dispose(function(item)
		local btn = GameUtil.asBtn(item.mainGO)

		btn:RemoveClickListener()

		local imgGo = goutil.findChild(item.mainGO, "img")

		uGuiUtil.clearImage(imgGo)
	end)

	local randomList
	local recordData = HuarongRoadModel.instance:getGameProgress(self._activityId, self._stateId)

	randomList = recordData and recordData.list and recordData.time and recordData.time > 0 and recordData.list or (not gameList or #gameList < width * height) and self:_createRandomGameByMath(self._blockNum.width, self._blockNum.height) or gameList

	for i, v in ipairs(self._gameList) do
		v.num = randomList[i]
	end

	local maxCount = self._blockNum.width * self._blockNum.height

	self._blockInfo = {}

	for i, v in ipairs(self._gameList) do
		if v.num and maxCount > v.num then
			table.insert(self._blockInfo, i)
		end
	end

	self._blocks:updateWithMoArray(self._blockInfo, function(item, data, i)
		self:_updateBlock(item, data, i, true)
	end)
	goutil.setActive(self._block, false)

	for i = 1, self._blockNum.height do
		for j = 1, self._blockNum.width do
			if self._gameList[(i - 1) * self._blockNum.width + j].num == maxCount then
				self._emptyPosH = i
				self._emptyPosW = j
			end
		end
	end

	self._emptyPosH = self._emptyPosH or self._blockNum.height
	self._emptyPosW = self._emptyPosW or self._blockNum.width
	self._guideList = {
		5,
		6,
		9
	}

	if self._haveGuide and #self._guideList > 0 then
		self._guidePos = self._guideList[1]

		table.remove(self._guideList, 1)
		GameUtil.setAnchoredPos(self._guideFingerGo, self._gameList[self._guidePos].posW, self._gameList[self._guidePos].posH)
	else
		self._haveGuide = false
	end

	goutil.setActive(self._guideFingerGo, self._haveGuide)
	GameUtil.SetActive(self._btnReset, true)

	self._isMoving = false
	self._gameTime = time
	self._txtClock.text = self._gameTime

	removetimer(self._gameTimeMove, self)
	settimer(1, self._gameTimeMove, self, true)
end

function HuarongRoadGameCopyView:_updateBlock(item, data, i, clickAble)
	local btn = GameUtil.asBtn(item.mainGO)
	local gameListIdx = self._gameList[data].num
	local imgGo = goutil.findChild(item.mainGO, "img")

	GameUtil.setHeight(item.mainGO, self._moveTotal.height * self._blockScale.height)
	GameUtil.setWidth(item.mainGO, self._moveTotal.width * self._blockScale.width)
	GameUtil.setAnchoredPos(item.mainGO, self._gameList[data].posW, self._gameList[data].posH)
	Framework.TransformUtil.SetLocalScale(imgGo.transform, 0.99, 0.99, 1)

	local txt = goutil.findChildTextComponent(item.mainGO, "txtNum")

	if txt then
		txt.text = self._gameList[data].num
	end

	if imgGo then
		uGuiUtil.clearImage(imgGo)

		if self._picList[gameListIdx] and not string.nilorempty(self._picList[gameListIdx]) then
			local path = GameUrl.getBigbgFolderUrl("saintknight/xiaonuo", self._picList[gameListIdx])

			uGuiUtil.setSpriteToImage(imgGo, uGuiUtil.SpriteType.BigBg, path)
		end
	end

	if clickAble then
		btn:AddClickListener(function()
			self:_onClickBlock(i)
		end)
	else
		btn:RemoveClickListener()
	end
end

function HuarongRoadGameCopyView:_moveBlock()
	if self._haveGuide and #self._guideList > 0 then
		self._guidePos = self._guideList[1]

		table.remove(self._guideList, 1)
		GameUtil.setAnchoredPos(self._guideFingerGo, self._gameList[self._guidePos].posW, self._gameList[self._guidePos].posH)
	else
		self._haveGuide = false
	end

	goutil.setActive(self._guideFingerGo, self._haveGuide)

	self._isMoving = false

	local temp = 0

	for i = 1, self._blockNum.height * self._blockNum.width do
		if temp < self._gameList[i].num then
			temp = self._gameList[i].num
		else
			return
		end
	end

	self:_winGame(true)
end

function HuarongRoadGameCopyView:_winGame(moveWin)
	removetimer(self._moveBlock, self)
	removetimer(self._gameTimeMove, self)

	self._isMoving = true
	self._isEnding = true
	self._moveWin = moveWin

	local itmes = self._blocks:getItems()

	for i, v in pairs(itmes) do
		local imgGo = goutil.findChild(v.mainGO, "img")

		UnityTweens.TweenScale.StopTween(imgGo)
		UnityTweens.TweenScale.StartTween(imgGo, Vector3.New(0.99, 0.99, 1), Vector3.New(1, 1, 1), self._recoverSpeed)
	end

	UnityTweens.UITweenFadeIn.StopTween(self._lastBlockImgGo)
	UnityTweens.UITweenFadeIn.StartTween(self._lastBlockImgGo, self._recoverSpeed)

	if self._completeEffect then
		UIEffectManager.instance:stopEffect(self._completeEffect)
	end

	self._completeEffect = UIEffectManager.instance:playEffect(self, self._pathCompleteEffect, nil, 0, 0, false)

	self._completeEffect:setParent(self._gameMove.transform)
	self._completeEffect:setScale(1, 1, 1)

	self._completeEffect.hideEffWhileNotOnTop = false

	settimer(self._picShowSpeed, self._showResult, self, false)
	GameUtil.SetActive(self._btnReset, false)
	goutil.setActive(self._guideFingerGo, false)
	removetimer(self._showStory, self)
	settimer(self._recoverSpeed + 2, self._showStory, self, false)
	self:_sendEndGameReq(true)
end

function HuarongRoadGameCopyView:_completeGame()
	removetimer(self._gameTimeMove, self)

	self._isMoving = true

	if not self._isEnding then
		removetimer(self._moveBlock, self)
		removetimer(self._gameTimeMove, self)
		removetimer(self._showStory, self)
		removetimer(self._showResult, self)

		local text = "游戏失败"

		local function func()
			self:_endGameFail()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade:openTipWindowNoX("提示", text, func, btnText, alignment)
	end
end

function HuarongRoadGameCopyView:_gameTimeMove()
	if self._gameTime > 0 then
		self._gameTime = self._gameTime - 1
		self._txtClock.text = self._gameTime
	end

	if self._gameTime <= 0 then
		self._txtClock.text = 0

		removetimer(self._gameTimeMove, self)
		self:_completeGame()
	end
end

function HuarongRoadGameCopyView:_showStory()
	local completeLevel = HuarongRoadModel.instance:getCompletLevelCount(self._activityId) + 1
	local cfg = HuarongRoadConfig.instance:getProgressCfg(self._activityId, completeLevel)
	local storyId

	if cfg then
		storyId = cfg.operaId
	end

	if storyId then
		GlobalDispatcher:addListener(GlobalNotify.EndStory, self._endStory, self)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
	else
		self:_endStory()
	end
end

function HuarongRoadGameCopyView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)

	if self._moveWin == false then
		self:close()
	elseif self._moveWin == true then
		self:close()
	end

	self._isEnding = false
end

function HuarongRoadGameCopyView:_showResult()
	goutil.setActive(self._imgResultGo, true)
end

function HuarongRoadGameCopyView:_onClickBlock(idx)
	local gameListIdx = self._blockInfo[idx]
	local posH = math.ceil(gameListIdx / self._blockNum.width)
	local posW = gameListIdx - (posH - 1) * self._blockNum.width
	local emptyIdx = (self._emptyPosH - 1) * self._blockNum.width + self._emptyPosW

	if not self._isMoving and (posH == self._emptyPosH and math.abs(posW - self._emptyPosW) == 1 or posW == self._emptyPosW and math.abs(posH - self._emptyPosH) == 1) and (not self._haveGuide or gameListIdx == self._guidePos) then
		self._gameList[emptyIdx].num = self._gameList[gameListIdx].num
		self._gameList[gameListIdx].num = self._maxCount

		local items = self._blocks:getItems()

		if items[idx] then
			self._isMoving = true

			UnityTweens.TweenPosition.StopTween(items[idx].mainGO)
			UnityTweens.TweenPosition.StartTween(items[idx].mainGO, Vector3.New(self._gameList[gameListIdx].posW, self._gameList[gameListIdx].posH, 0), Vector3.New(self._gameList[emptyIdx].posW, self._gameList[emptyIdx].posH, 0), self._moveSpeed)
			removetimer(self._moveBlock, self)
			settimer(self._moveSpeed + 0.1, self._moveBlock, self, false)
		end

		self._blockInfo[idx] = emptyIdx
		self._emptyPosW = posW
		self._emptyPosH = posH
	end
end

function HuarongRoadGameCopyView:_onCustomInputBeginCallback(hover)
	if hover then
		GameUtil.SetActive(self._beginGameGo, false)
		UIEffectManager.instance:stopEffect(self._startEffect)

		local effectPath = "20220729/xiaoyouxi_sqxn/fx_ui_sqxn_xiaoyouxi.prefab"
		local recordData = HuarongRoadModel.instance:getGameProgress(self._activityId, self._stateId)

		if effectPath and not recordData then
			self._isShowOpenEffect = true
			self._startEffect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false, nil, GameUtil.handler(self._reqStartGame, self))

			self._startEffect:setParent(self._effectStartGo.transform)
			self._startEffect:setScale(1, 1, 1)
		else
			self:_reqStartGame()
		end
	end
end

function HuarongRoadGameCopyView:_onClickBgPic()
	if not self._isEnding then
		goutil.setActive(self._previewPicGo, true)
	end
end

function HuarongRoadGameCopyView:_onCustomInputBgPicCallback(hover)
	if not hover then
		goutil.setActive(self._previewPicGo, false)
	end
end

function HuarongRoadGameCopyView:_onClickPass()
	local type, id, num
	local var_30_0, var_30_1, var_30_2 = MaterialMgr.getMatParams(self._cfg.passCost)

	TipsFacade.instance:openPopupCostMatViewNew(var_30_0, var_30_1, var_30_2, langPara("确定要花费%d神钻，直接一键通过%s?", var_30_2, self._cfg.name), function()
		self:_buyCompleteGame()
	end)
end

function HuarongRoadGameCopyView:_onClickReset()
	local tipStr = "重置后将重新开始倒计时，但是会【清除当前进度】，需要从头开始修复场景，是否重置？"
	local title = "提示"

	TipsFacade.instance:openPopupWindow(title, tipStr, function()
		self:_resetGame()
	end)
end

function HuarongRoadGameCopyView:_resetGame()
	HuarongRoadModel.instance:setGameProgress(self._activityId, self._stateId, nil)
	removetimer(self._moveBlock, self)
	removetimer(self._gameTimeMove, self)
	self:_buildMap(self._cfg.rule[1], self._cfg.rule[2], self._cfg.maxTime)
end

function HuarongRoadGameCopyView:_buyCompleteGame()
	if MaterialFacade.instance:isMatsEnough(self._cfg.passCost) then
		for i, v in ipairs(self._gameList) do
			v.num = i
		end

		self._blockInfo = {}

		for i, v in ipairs(self._gameList) do
			if v.num and v.num < self._maxCount then
				table.insert(self._blockInfo, i)
			end
		end

		self._blocks:updateWithMoArray(self._blockInfo, function(item, data, i)
			self:_updateBlock(item, data, i)
		end)
		self:_winGame(false)
	end
end

function HuarongRoadGameCopyView:_buyAddTime()
	HuarongRoadAgent.instance:sendPM_HuarongRoadIncreaseSecondReq(self._activityId, self._stateId)
end

function HuarongRoadGameCopyView:_saveGameProgress()
	local recordList = {}

	for i, v in ipairs(self._gameList) do
		table.insert(recordList, v.num)
	end

	if not self._haveGuide and not self._isShowOpenEffect then
		HuarongRoadModel.instance:setGameProgress(self._activityId, self._stateId, recordList, self._gameTime)
	end
end

function HuarongRoadGameCopyView:_PM_HuarongRoadIncreaseSecondRes()
	self._isMoving = false
	self._isEnding = false
	self._gameTime = self._gameTime + self._timePlan[self._timeAddCount].time
	self._txtClock.text = self._gameTime

	removetimer(self._gameTimeMove, self)
	settimer(1, self._gameTimeMove, self, true)
end

function HuarongRoadGameCopyView:_PM_HuarongRoadBuyQuickPassRes()
	SurveyController.instance:reportBehavior(201110, self._stateId)
	self:close()
end

function HuarongRoadGameCopyView:_PM_HuarongRoadPassRes()
	SurveyController.instance:reportBehavior(201110, self._stateId)
	self:close()
end

function HuarongRoadGameCopyView:_onClickClose()
	if not self._isEnding then
		self:_endGameFail()
	end
end

function HuarongRoadGameCopyView:_endGameFail()
	if not self._isEnding then
		self:_sendEndGameReq(false)
		self:close()
	end
end

function HuarongRoadGameCopyView:_createRandomGame(width, height, startPosW, startPosH, randomNum)
	return HuarongRoadModel.instance:createRandomGame(width, height, startPosW, startPosH, randomNum)
end

function HuarongRoadGameCopyView:_createRandomGameByMath(width, height, startPosW, startPosH, randomNum)
	return HuarongRoadModel.instance:createRandomGameByMath(width, height, startPosW, startPosH, randomNum)
end

return HuarongRoadGameCopyView
