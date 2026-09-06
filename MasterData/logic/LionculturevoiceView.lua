-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturevoiceView.lua

module("logic.extensions.lionculture.view.LionculturevoiceView", package.seeall)

local LionculturevoiceView = class("LionculturevoiceView", ViewComponent)

function LionculturevoiceView:buildUI()
	LionculturevoiceView.super.buildUI(self)

	self._btnMusic = goutil.findChild(self.mainGO, "btnMusic")
	self._txtMusic = goutil.findChildTextComponent(self.mainGO, "btnMusic/Text")
	self._downCount = goutil.findChild(self.mainGO, "downCount")
	self._endTitleImg = goutil.findChild(self.mainGO, "endTitleImg")
	self._endMask = goutil.findChild(self.mainGO, "endMask")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._symbolRoot = goutil.findChild(self.mainGO, "lineCol/symbolRoot")
	self._progressCol = goutil.findChild(self.mainGO, "progressCol")
	self._txtTotalDesc = goutil.findChildTextComponent(self.mainGO, "progressCol/totalCol/txtTotalDesc")
	self._progressBar = goutil.findChild(self.mainGO, "progressCol/progressBar")
	self._progressSlider = self._progressBar:GetComponent(ComponentType.Slider)
	self._comobGo = goutil.findChild(self.mainGO, "comobGo")
	self._comobCell = goutil.findChild(self.mainGO, "comobCell")
	self._comobTweenScaComp = self._comobCell:GetComponent(UnityTweensType.TweenScale)
	self._imgNumComp = goutil.findChild(self.mainGO, "comobCell/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._btnTest1 = goutil.findChild(self.mainGO, "testCol/btnTest1")
	self._btnTest2 = goutil.findChild(self.mainGO, "testCol/btnTest2")
	self._btnTest3 = goutil.findChild(self.mainGO, "testCol/btnTest3")
	self._btnTest4 = goutil.findChild(self.mainGO, "testCol/btnTest4")
	self._btnTest5 = goutil.findChild(self.mainGO, "testCol/btnTest5")
	self._btnTest6 = goutil.findChild(self.mainGO, "testCol/btnTest6")
	self._txtState = goutil.findChildTextComponent(self.mainGO, "testCol/txtState")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "testCol/txtTime")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "testCol/txtCount")
	self._txtMaxCount = goutil.findChildTextComponent(self.mainGO, "testCol/txtMaxCount")
	self._txtCombo = goutil.findChildTextComponent(self.mainGO, "testCol/txtCombo")
	self._txtMaxCombo = goutil.findChildTextComponent(self.mainGO, "testCol/txtMaxCombo")
	self._txtCurProgress = goutil.findChildTextComponent(self.mainGO, "testCol/txtCurProgress")
	self._txtSymbolAnimSpeed = goutil.findChildTextComponent(self.mainGO, "testCol/txtSymbolAnimSpeed")
end

function LionculturevoiceView:bindEvents()
	LionculturevoiceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnMusic, self._onClickBtnMusic, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._endMask, self._onClickEndMask, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnTest1, self._onClickBtnTest1, self)
	GameUtil.addClickHandler(self._btnTest2, self._onClickBtnTest2, self)
	GameUtil.addClickHandler(self._btnTest3, self._onClickBtnTest3, self)
	GameUtil.addClickHandler(self._btnTest4, self._onClickBtnTest4, self)
	GameUtil.addClickHandler(self._btnTest5, self._onClickBtnTest5, self)
	GameUtil.addClickHandler(self._btnTest6, self._onClickBtnTest6, self)
end

function LionculturevoiceView:unbindEvents()
	LionculturevoiceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._endMask)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTest1)
	GameUtil.rmClickHandler(self._btnTest2)
	GameUtil.rmClickHandler(self._btnTest3)
	GameUtil.rmClickHandler(self._btnTest4)
	GameUtil.rmClickHandler(self._btnTest5)
	GameUtil.rmClickHandler(self._btnTest6)
end

function LionculturevoiceView:onEnter()
	LionculturevoiceView.super.onEnter(self)

	self._gameId = 3
	self.destroyed = false
	self._isOver = LioncultureModel.instance.gameFinishs[self._gameId]
	self._gamePlanId = PlayMusicConfig.instance:getCurGamePlanId()

	if self._gamePlanId == 0 then
		printError("当前gamePlanId错误,请检查[x-小游戏演奏音乐.xlsx]配置表")
		self:_closeWin()

		return
	end

	self._planData = PlayMusicConfig.instance:getPmPlanData(self._gamePlanId)

	if self._pmMgr == nil then
		self._pmMgr = PlayMusicMgr.New(self._gamePlanId, self._symbolRoot)
	end

	settimer(0, self._onTicking, self)

	self.typeConfig = LioncultureConfig.instance:getGameData(LioncultureModel.instance.activityId, 3)

	if not GameUtil.getUserData(ViewName.LionculturevoiceView) then
		UIStateManager.instance:push(ViewName.LionculturetipView, self.typeConfig.desc)
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule4")
		GameUtil.saveUserData(ViewName.LionculturevoiceView, true)
	end

	self:_resetGame()
	self:_onSetUI()
	self:_onUpdate()
end

function LionculturevoiceView:onExit()
	LionculturevoiceView.super.onExit(self)
	removetimer(self._onTicking, self)

	if self._readyCounterComp then
		self._readyCounterComp:stop()

		self.destroyed = false
	end

	self._pmMgr:clear()
	self._comobTweenScaComp:RemoveListener()
end

function LionculturevoiceView:destroyUI()
	LionculturevoiceView.super.destroyUI(self)

	if self._readyCounterComp then
		self._readyCounterComp:dispose()

		self._readyCounterComp = nil
	end

	self._pmMgr:destroy()

	self._pmMgr = nil
end

function LionculturevoiceView:_onClickBtnMusic()
	if self._isOver then
		FloatWordMgr.instance:show("已通关~")

		return
	end

	GlobalDispatcher:addListener(WakingLionGameAgent.handlePM_WakingLionGameStartGameRes, self._startGame, self)
	LioncultureController.instance:sendPM_WakingLionGameStartGameReq(self._gameId)
	self:_openGameUI()
	AudioPlayerEx.instance:playMusic(12003)
end

function LionculturevoiceView:_openGameUI()
	GameUtil.SetActive(self._comobGo, true)
	GameUtil.SetActive(self._comobCell, true)
	GameUtil.SetActive(self._progressCol, true)
end

function LionculturevoiceView:_onSetUI()
	GameUtil.SetActive(self._comobGo, false)
	GameUtil.SetActive(self._comobCell, false)
	GameUtil.SetActive(self._progressCol, false)
	self._imgNumComp:SetNum(0)

	self._txtMusic.text = self._isOver and "已完成" or "擂鼓助阵"
end

function LionculturevoiceView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function LionculturevoiceView:_onUpdateData()
	return
end

function LionculturevoiceView:_onUpdateUI()
	self:_onUpdatePlaneUI()
end

function LionculturevoiceView:_onUpdatePlaneUI()
	return
end

function LionculturevoiceView:_onUpdateProgressCol()
	self._totalProgress = self._pmMgr:getCurTotalProgress()
	self._txtTotalDesc.text = string.format("%d", self._totalProgress * 100) .. "%"
	self._progressSlider.value = self._totalProgress
end

function LionculturevoiceView:_onClickBtnClose()
	if self._isOver then
		self:_closeWin()

		return
	end

	self._pmMgr:stopGame()

	local tipsContent = "退出游戏将丢失本次进度，是否继续退出？"

	local function okFunc()
		self:_closeWin()
	end

	local function cencelFunc()
		self:_continueGame()
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function LionculturevoiceView:_onClickEndMask()
	self:_closeWin()
end

function LionculturevoiceView:_onClickTips()
	UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule4")
end

function LionculturevoiceView:_closeWin()
	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end

	self:close()
end

function LionculturevoiceView:_stopGame()
	self._pmMgr:stopGame()

	local text = "游戏暂停中"

	local function func()
		self:_continueGame()
	end

	local btnText = "继续游戏"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
end

function LionculturevoiceView:_continueGame()
	self._pmMgr:continueGame()
end

function LionculturevoiceView:_endingGame()
	if self._isRuningEndAnim == true then
		return
	else
		self._isRuningEndAnim = true
	end

	ViewBlockMgr.instance:blockClick(true, self)
	self:_showEndGameTitle()
end

function LionculturevoiceView:_showEndGameTitle()
	GameUtil.setLocalScale(self._endTitleImg, 0.4, 0.4, 0.4)
	GameUtil.SetActive(self._endTitleImg, true)

	local function callback()
		self._isRuningEndAnim = false

		ViewBlockMgr.instance:blockClick(false, self)
		self:_endedGame()
	end

	self._endTitleImg.transform:DOScale(1, 2):SetEase(DG.Tweening.Ease.OutBounce):OnComplete(callback)
end

function LionculturevoiceView:_endedGame()
	self._pmMgr:endedGame()

	local settleValue = 1

	LioncultureController.instance:sendPM_WakingLionGameEndGameReq(self._gameId, settleValue)
	GameUtil.SetActive(self._endMask, true)
end

function LionculturevoiceView:_resetGame()
	self._isRuningEndAnim = false
	self._comobCount = self._pmMgr:getCurComboNum()

	GameUtil.SetActive(self._endTitleImg, false)
	GameUtil.SetActive(self._endMask, false)
	GameUtil.SetActive(self._comobCell, true)
	self._pmMgr:resetGame()
	GameUtil.SetActive(self._btnMusic, true)
end

function LionculturevoiceView:_startGame()
	GlobalDispatcher:removeListener(WakingLionGameAgent.handlePM_WakingLionGameStartGameRes, self._startGame, self)
	GameUtil.SetActive(self._btnMusic, false)

	if self._readyCounterComp == nil then
		self._readyCounterComp = WBB_UITimeCounter.New(self._downCount)
	end

	self._readyCounterComp:play(3, self._continueGame, self)
end

function LionculturevoiceView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime

	if not self._pmMgr:onTicking(self._deltaTime) then
		return
	end

	local state = self._pmMgr:getCurState()

	self._txtCount.text = string.format("运行数量：%s", self._pmMgr:getCurSymbolCellCount())
	self._txtMaxCount.text = string.format("运行数量上限：%s", self._pmMgr._maxRunningSymbolCellCount)
	self._txtSymbolAnimSpeed.text = string.format("全局音符动画速度：%s", self._pmMgr._gobalSymbolAnimSpeed)
	self._txtCombo.text = string.format("当前连击数：%s", self._pmMgr:getCurComboNum())
	self._txtMaxCombo.text = string.format("单局最大连击数：%s", self._pmMgr:getMaxComboNum())
	self._txtCurProgress.text = string.format("当前进度：%s", self._pmMgr:getCurTotalScore())
	self._txtTime.text = string.format("时间:%.1f秒", self._pmMgr:getCurGameTime())

	self:_onUpdateProgressCol()

	if self._comobCount ~= self._pmMgr:getCurComboNum() then
		self._comobCount = self._pmMgr:getCurComboNum()

		self._imgNumComp:SetNum(Mathf.Max(self._comobCount, 0))

		if self._comobCount ~= 0 then
			GameUtil.SetActive(self._comobCell, true)
			self._comobTweenScaComp:Begin()
		end
	end

	if state == PlayMusicMgr.State.Standing then
		self._txtState.text = "待机"
	elseif state == PlayMusicMgr.State.Readying then
		self._txtState.text = "准备开始"
	elseif state == PlayMusicMgr.State.Runing then
		self._txtState.text = "游戏运行中"
	elseif state == PlayMusicMgr.State.Stoping then
		self._txtState.text = "游戏暂停"
	elseif state == PlayMusicMgr.State.Ending then
		self._txtState.text = "游戏结束中"

		self:_endingGame()
	elseif state == PlayMusicMgr.State.Ended then
		self._txtState.text = "游戏结束完成"
	end
end

function LionculturevoiceView:_onClickBtnTest1()
	if self._pmMgr._maxRunningSymbolCellCount == nil then
		return
	end

	self._pmMgr._maxRunningSymbolCellCount = Mathf.Max(self._pmMgr._maxRunningSymbolCellCount + 1, 1)
end

function LionculturevoiceView:_onClickBtnTest2()
	if self._pmMgr._maxRunningSymbolCellCount == nil then
		return
	end

	self._pmMgr._maxRunningSymbolCellCount = Mathf.Max(self._pmMgr._maxRunningSymbolCellCount - 1, 1)
end

function LionculturevoiceView:_onClickBtnTest3()
	self:_resetGame()
end

function LionculturevoiceView:_onClickBtnTest4()
	self:_continueGame()
end

function LionculturevoiceView:_onClickBtnTest5()
	self:_stopGame()
end

function LionculturevoiceView:_onClickBtnTest6()
	self._pmMgr:endingGame()
end

return LionculturevoiceView
