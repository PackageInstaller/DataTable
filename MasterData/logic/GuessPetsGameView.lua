-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsGameView.lua

module("logic.extensions.goddessglory.view.GuessPetsGameView", package.seeall)

local GuessPetsGameView = class("GuessPetsGameView", ViewComponent)
local UnityTime = UnityEngine.Time

function GuessPetsGameView:buildUI()
	GuessPetsGameView.super.buildUI(self)

	self._imgNode = self:getGo("con")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._bubbleNode = self:getGo("bubble")
	self._bubbleDesc = self:getTxt("bubble/txtDesc")
	self._btnImage = Framework.UIClickTrigger.Get(self:getGo("btnImage"))
	self._txtCurNum = self:getTxt("txtCurNum")
	self._txtTotalNum = self:getTxt("txtTotalNum")
	self._emptyImage = self:getGo("empty")
	self._petNode = self:getGo("pet")
	self._petImage = self:getGo("pet/image"):GetComponent(ComponentType.RawImage)

	self:_buildPlayerViews()

	self._modelCamera = self:getGo("ModelCamera"):GetComponent(typeof(UnityEngine.Camera))
	self._countdownNode = self:getGo("countdown")
	self._countdownTime = self:getGo("countdown/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._questionsNode = self:getGo("questions")
	self._answersNode = self:getGo("questions/choose")
	self._waitingFirstTip = self:getGo("waitingFirstTip")
	self._waitingFirstTipTxt = self:getTxt("waitingFirstTip/txt")
	self._waitingNextTip = self:getGo("waitingNextTip")
	self._waitingNextTipTxt = self:getTxt("waitingNextTip/txt")
	self._waitingOtherAnswer = self:getGo("waitingOtherAnswer")
	self._flyEffPool = GuessPetsWorldScoreEffPool.New(self.mainGO)
end

function GuessPetsGameView:_buildPlayerViews()
	self._playersLayout = self:getGo("players"):GetComponent(ComponentType.UILayoutSingleLine)
	self._playerViews = {}

	local player = self._playersLayout.transform:GetChild(0).gameObject

	for i = 1, 3 do
		local playerNode

		if i <= self._playersLayout.transform.childCount then
			playerNode = self._playersLayout.transform:GetChild(i - 1).gameObject
		end

		playerNode = playerNode or goutil.clone(player)

		playerNode.transform:SetParent(self._playersLayout.transform, false)

		self._playerViews[i] = GuessGamePlayerView.New(playerNode, self)
	end
end

function GuessPetsGameView:bindEvents()
	GuessPetsGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnImage:AddClickListener(self._onClickImage, self)
end

function GuessPetsGameView:unbindEvents()
	GuessPetsGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnImage:RemoveClickListener()
end

function GuessPetsGameView:onEnter()
	GuessPetsGameView.super.onEnter(self)
	self._modelCamera.transform:SetParent(nil, false)
	Framework.TransformUtil.SetPos(self._modelCamera.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._modelCamera.transform, 1, 1, 1)

	self._rendererTex = UnityEngine.RenderTexture.GetTemporary(512, 512)
	self._modelCamera.targetTexture = self._rendererTex
	self._petImage.texture = self._rendererTex
	self._gameStatus = GuessPetModel.GameStatus_None

	self:_buildNumberQuestionEff()
	self:_buildAnswerEffects()
	self:_resetImageRotation()
	self:_createMainImage()
	self:_refreshPlayerView()
	self:_startQuestion()
	settimer(0, self._tickQuestion, self)
	ViewMgr.instance:close(ViewName.GuessPetsMatching)
	settimer(1, self._autoShowBubble, self)
	self:_showBubble()
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsGameResult, self._onGuessPetsGameResult, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsGameAbort, self._onGuessPetsGameAbort, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsExitGameSucces, self._onGuessPetsExitGameSucces, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsPlayerExitGame, self._onGuessPetsPlayerExitGame, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsNextQuestion, self._onGuessPetsNextQuestion, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsPlayerAnswer, self._onGuessPetsPlayerAnswer, self)
end

function GuessPetsGameView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsGameResult, self._onGuessPetsGameResult, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsGameAbort, self._onGuessPetsGameAbort, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsExitGameSucces, self._onGuessPetsExitGameSucces, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsPlayerExitGame, self._onGuessPetsPlayerExitGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsNextQuestion, self._onGuessPetsNextQuestion, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsPlayerAnswer, self._onGuessPetsPlayerAnswer, self)
	GuessPetsGameView.super.onExit(self)
	self:_clearCameraRenderTexture()
	self._flyEffPool:clear()

	self._currShowingQuestion = nil
	self._gameStatus = nil
	self._curModelGo = nil
	self._curshowRect = nil
	self._maxShowRect = nil
	self._tempRect = nil
	self._effCurrQuestionNum = nil
	self._lastShowBubbleTime = nil

	if self._goMainImage then
		goutil.destroy(self._goMainImage)

		self._goMainImage = nil
	end

	for i = 1, #self._playerViews do
		self._playerViews[i]:clear()
	end

	self:_clearAnswerEffects()
	self:_clearQuestionStartingEff()
	self:_clearNumberQuestionEff()
	self:_clearModels()
	removetimer(self._autoShowBubble, self)
	removetimer(self._tickQuestion, self)

	local answerCnt = self._answersNode.transform.childCount

	for i = 1, answerCnt do
		local go = self._answersNode.transform:GetChild(i - 1).gameObject
		local bg = goutil.findChild(go, "bg")
		local btnSel = Framework.UIClickTrigger.Get(bg)

		btnSel:RemoveClickListener()
	end
end

function GuessPetsGameView:_buildAnswerEffects()
	local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)
	local res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.wrongAnswerEff)

	self._answerWrongEff = goutil.clone(res:GetMainAsset())

	self._answerWrongEff.transform:SetParent(self.mainGO.transform, false)
	self._answerWrongEff:SetActive(false)
	GoUtil.SetSortingOrder(self._answerWrongEff, sortingOrder)

	res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.rightAnswerEff)
	self._answerRightEff = goutil.clone(res:GetMainAsset())

	self._answerRightEff.transform:SetParent(self.mainGO.transform, false)
	self._answerRightEff:SetActive(false)
	GoUtil.SetSortingOrder(self._answerRightEff, sortingOrder)
end

function GuessPetsGameView:_clearAnswerEffects()
	if self._answerWrongEff then
		goutil.destroy(self._answerWrongEff)

		self._answerWrongEff = nil
	end

	if self._answerRightEff then
		goutil.destroy(self._answerRightEff)

		self._answerRightEff = nil
	end
end

function GuessPetsGameView:_autoShowBubble()
	local timeDelta = GuessPetModel.instance:getGameViewTipsTime()

	if not self._lastShowBubbleTime or timeDelta <= UnityTime.realtimeSinceStartup - self._lastShowBubbleTime then
		self:_showBubble()
	end
end

function GuessPetsGameView:_showBubble()
	self._lastShowBubbleTime = UnityTime.realtimeSinceStartup

	self._bubbleNode:SetActive(true)

	local tipsPlan = GuessPetModel.instance:getGameViewTipsPlan()
	local bubbles = GuessPetConfig.instance:getBubbles(tipsPlan)

	if not bubbles then
		return
	end

	local cfg = bubbles[math.random(1, #bubbles)]

	if not cfg then
		return
	end

	self._bubbleDesc.text = cfg.content
end

function GuessPetsGameView:_clearCameraRenderTexture()
	self._modelCamera.targetTexture = nil
	self._petImage.texture = nil

	if self._rendererTex then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rendererTex)

		self._rendererTex = nil
	end

	self._modelCamera.transform:SetParent(self.mainGO.transform, false)
end

function GuessPetsGameView:_clearModels()
	if self._currLoadedRes then
		for k, v in pairs(self._currLoadedRes) do
			v:Release()
		end

		self._currLoadedRes = nil
	end

	if self._curCacheModels then
		for k, v in pairs(self._curCacheModels) do
			goutil.destroy(v)
		end

		self._curCacheModels = nil
	end

	self:_stopLoadingRes()
end

function GuessPetsGameView:_refreshPlayerView()
	local gameMO = GuessPetModel.instance:getGuessGameMo()
	local players = gameMO.players
	local maxPlayer = #players

	while maxPlayer > #self._playerViews do
		local playerNode = goutil.clone(self._playersLayout.transform:GetChild(0).gameObject)

		playerNode.transform:SetParent(self._playersLayout.transform, false)
		table.insert(self._playerViews, GuessGamePlayerView.New(playerNode))
	end

	for i = 1, #players do
		local playerView = self._playerViews[i]

		playerView:setActive(true)
		playerView:setPlayer(players[i])
	end

	for i = #players + 1, #self._playerViews do
		local playerView = self._playerViews[i]

		playerView:setActive(false)
	end

	self._playersLayout:Layout()
end

function GuessPetsGameView:_resetPlayersView()
	for i = 1, #self._playerViews do
		local playerView = self._playerViews[i]

		playerView:setFirstTips()
		playerView:setAnswer()
		playerView:setResult()
	end
end

function GuessPetsGameView:_createMainImage()
	local imgPath = GuessPetModel.instance:getMainImage()

	if string.nilorempty(imgPath) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(imgPath)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._goMainImage = goutil.clone(mainAsset)

	self._goMainImage.transform:SetParent(self._imgNode.transform, false)

	local x, y, scale = GuessPetModel.instance:getGameImagePose()

	Framework.TransformUtil.SetLocalPos(self._imgNode.transform, x, y, 0)
	Framework.TransformUtil.SetLocalScale(self._imgNode.transform, scale, scale, scale)
end

function GuessPetsGameView:_startQuestion()
	if self._gameStatus == GuessPetModel.GameStatus_GameOver then
		return
	end

	local gameMO = GuessPetModel.instance:getGuessGameMo()
	local curQuestion = gameMO.curQuestion

	if curQuestion:isWaitingPreparing() and not self._currShowingQuestion then
		self:_onWaitingFirstQuestion()

		return
	end

	self._currShowingQuestion = curQuestion
	self._txtCurNum.text = string.format("第%s题", GameUtil.getChineseNumber(gameMO.currProblemSeq))
	self._txtTotalNum.text = gameMO.currProblemSeq .. "/" .. gameMO.problemCount

	self:_updateEffectCurQuestionNum()

	if curQuestion:isPassed() then
		self:_onWaitingNextQuestion()

		return
	end

	self:_checkCurQuestionStatus()
end

function GuessPetsGameView:_onWaitingFirstQuestion()
	self._gameStatus = GuessPetModel.GameStatus_None

	self:_resetQuestionsView()
	self._waitingFirstTip:SetActive(true)
	self:_updateWaitingFirstQuestion()
end

function GuessPetsGameView:_checkCurQuestionStatus()
	local curQuestion = self._currShowingQuestion

	if not curQuestion then
		return
	end

	local resPath = GuessPetModel.instance:getQuestionResPath(curQuestion.raceId)

	if not self:_isQuestionResourceLoaded(resPath) then
		self:_startLoadQuestionRes(resPath)
	else
		local now = ServerTime.now()
		local startTime = curQuestion.questStartStamp
		local endTime = curQuestion.questEndStamp

		if now < startTime then
			if startTime - now >= 2 then
				self:_startPreparingQuestion()
			else
				self:_startQuestionStarting()
			end
		elseif endTime <= now then
			self:_startFinishedQuestion()
		else
			self:_startDoingQuestion()
		end
	end
end

function GuessPetsGameView:_onWaitingNextQuestion()
	self._gameStatus = GuessPetModel.GameStatus_WaitingQuestion

	self:_resetQuestionsView()
	self._waitingNextTip:SetActive(true)
	self:_updateWaitingNextQuestion()
end

function GuessPetsGameView:_startPreparingQuestion()
	if self._gameStatus == GuessPetModel.GameStatus_PerparingQuestion then
		return
	end

	self:_foreceImageCorrectly()

	self._gameStatus = GuessPetModel.GameStatus_PerparingQuestion

	self._emptyImage:SetActive(true)
	self._countdownNode:SetActive(false)
	self._waitingNextTip:SetActive(false)
	self._waitingFirstTip:SetActive(false)
	self._waitingOtherAnswer:SetActive(false)
	self._petNode:SetActive(true)
	self:_resetPlayersView()
	UnityTweens.TweenRotate.StopTween(self._emptyImage)
	UnityTweens.TweenRotate.StopTween(self._petNode)

	local imageRotation = self._petNode.transform.localEulerAngles
	local emptyRotation = self._emptyImage.transform.localEulerAngles

	UnityTweens.TweenRotate.StartTween(self._petNode, imageRotation, Vector3.New(0, 90, 0), 0.125):AddListener(function()
		self._questionsNode:SetActive(false)
	end)
	UnityTweens.TweenRotate.StartTween(self._emptyImage, emptyRotation, Vector3.New(0, 0, 0), 0.125, UnityTweens.EaseType.linear, 0.125):AddListener(function()
		self:_startAppearingQuestion()
	end)
	self:_playNumberQuestionEff()
end

function GuessPetsGameView:_foreceImageCorrectly()
	if not self._currShowingQuestion then
		return
	end

	local resPath = GuessPetModel.instance:getQuestionResPath(self._currShowingQuestion.raceId)

	if self:_isQuestionResourceLoaded(resPath) then
		self:_buildPicture(resPath)
	end
end

function GuessPetsGameView:_resetQuestionsView()
	self:_resetImageRotation()
	self._questionsNode:SetActive(false)
	self._petNode:SetActive(false)
	self._emptyImage:SetActive(true)
	self._countdownNode:SetActive(false)
	self._waitingFirstTip:SetActive(false)
	self._waitingNextTip:SetActive(false)
	self._waitingOtherAnswer:SetActive(false)
	self:_resetPlayersView()
	self:_stopAnswerEffect()
end

function GuessPetsGameView:_resetImageRotation()
	UnityTweens.TweenRotate.StopTween(self._emptyImage)
	UnityTweens.TweenRotate.StopTween(self._petNode)
	Framework.TransformUtil.SetLocalRotation(self._emptyImage.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self._petNode.transform, 0, 90, 0)
end

function GuessPetsGameView:_resetDodingQuestionImageRotation()
	UnityTweens.TweenRotate.StopTween(self._emptyImage)
	UnityTweens.TweenRotate.StopTween(self._petNode)
	Framework.TransformUtil.SetLocalRotation(self._emptyImage.transform, 0, -90, 0)
	Framework.TransformUtil.SetLocalRotation(self._petNode.transform, 0, 0, 0)
end

function GuessPetsGameView:_startAppearingQuestion()
	self:_resetImageRotation()
	self._questionsNode:SetActive(true)
	self._petNode:SetActive(true)
	self._emptyImage:SetActive(true)

	local imageRotation = self._petNode.transform.localEulerAngles
	local emptyRotation = self._emptyImage.transform.localEulerAngles

	UnityTweens.TweenRotate.StartTween(self._emptyImage, emptyRotation, Vector3.New(0, -90, 0), 0.125, UnityTweens.EaseType.linear, 0.5):RemoveListener()
	UnityTweens.TweenRotate.StartTween(self._petNode, imageRotation, Vector3.New(0, 0, 0), 0.125, UnityTweens.EaseType.linear, 0.625):AddListener(function()
		self:_startQuestionStarting()
	end)
	self:_stopAnswerEffect()
	self:_refreshAnswers()
	self:_resetPlayersView()
end

function GuessPetsGameView:_buildNumberQuestionEff()
	if not self._numberQuestionEff then
		local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)
		local res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.numberQusetionEff)

		self._numberQuestionEff = goutil.clone(res:GetMainAsset())

		self._numberQuestionEff.transform:SetParent(self.mainGO.transform, false)
		GoUtil.SetSortingOrder(self._numberQuestionEff, sortingOrder)

		self._effCurrQuestionNum = goutil.findChildTextComponent(self._numberQuestionEff, "dati/kaishititi")

		self:_updateEffectCurQuestionNum()
		self._numberQuestionEff:SetActive(false)
	end
end

function GuessPetsGameView:_updateEffectCurQuestionNum()
	if self._effCurrQuestionNum then
		self._effCurrQuestionNum.text = self._txtCurNum.text
	end
end

function GuessPetsGameView:_playNumberQuestionEff()
	if not self._numberQuestionEff then
		self:_buildNumberQuestionEff()
	end

	self._numberQuestionEff:SetActive(false)
	self._numberQuestionEff:SetActive(true)
end

function GuessPetsGameView:_stopNumberQuestionEff()
	if self._numberQuestionEff then
		self._numberQuestionEff:SetActive(false)
	end
end

function GuessPetsGameView:_clearNumberQuestionEff()
	if self._numberQuestionEff then
		goutil.destroy(self._numberQuestionEff)

		self._numberQuestionEff = nil
	end
end

function GuessPetsGameView:_startQuestionStarting()
	if self._gameStatus == GuessPetModel.GameStatus_StartQuestion then
		return
	end

	self:_foreceImageCorrectly()
	self:_stopAnswerEffect()
	self._questionsNode:SetActive(true)
	self:_refreshAnswers()

	self._gameStatus = GuessPetModel.GameStatus_StartQuestion

	self:_resetDodingQuestionImageRotation()
	self:_playQuestionStartingEff()
end

function GuessPetsGameView:_playQuestionStartingEff()
	if not self._questionStartingEff then
		local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)
		local res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.startQusetionEff)

		self._questionStartingEff = goutil.clone(res:GetMainAsset())

		self._questionStartingEff.transform:SetParent(self.mainGO.transform, false)
		GoUtil.SetSortingOrder(self._questionStartingEff, sortingOrder)
	end

	self._questionStartingEff:SetActive(false)
	self._questionStartingEff:SetActive(true)
end

function GuessPetsGameView:_stopQuestionStartingEff()
	if self._questionStartingEff then
		self._questionStartingEff:SetActive(false)
	end
end

function GuessPetsGameView:_clearQuestionStartingEff()
	if self._questionStartingEff then
		goutil.destroy(self._questionStartingEff)

		self._questionStartingEff = nil
	end
end

function GuessPetsGameView:_refreshAnswers()
	local answers = self._currShowingQuestion.answers
	local childCount = self._answersNode.transform.childCount
	local answerCnt = #answers

	while childCount < answerCnt do
		childCount = childCount + 1

		UGUIToolHelper.AddChild(self._answersNode.gameObject, self._answersNode.transform:GetChild(0).gameObject)
	end

	local myAnswer = self._currShowingQuestion:getPlayerAnswer(RoleModel.instance:getUserId())
	local correctAnswer = self._currShowingQuestion.raceId

	for i = 1, answerCnt do
		local go = self._answersNode.transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local questionCo = GuessPetConfig.instance:getQuestionCo(answers[i])
		local txtAnswer = goutil.findChildTextComponent(go, "txtDesc")
		local resultTrue = goutil.findChild(go, "true")
		local resultFalse = goutil.findChild(go, "false")
		local bg = goutil.findChild(go, "bg")
		local btnSel = Framework.UIClickTrigger.Get(bg)
		local colorChange = bg:GetComponent(ComponentType.UIImageColorChange)

		if not myAnswer then
			resultTrue:SetActive(false)
			resultFalse:SetActive(false)
		else
			resultTrue:SetActive(myAnswer.answer == answers[i] and myAnswer.answer == correctAnswer)
			resultFalse:SetActive(myAnswer.answer == answers[i] and myAnswer.answer ~= correctAnswer)
		end

		txtAnswer.text = GuessPetModel.instance:getAnswerTag(i) .. " " .. questionCo.name

		btnSel:RemoveClickListener()
		btnSel:AddClickListener(function()
			if self._gameStatus ~= GuessPetModel.GameStatus_DoingQuestion then
				return
			end

			if not self._currShowingQuestion:getPlayerAnswer(RoleModel.instance:getUserId()) then
				GuessPetController.instance:requestGuessGameGuessPicture(answers[i])
			end
		end)

		if not myAnswer or myAnswer.answer == correctAnswer then
			colorChange:SetState(0)
		else
			colorChange:SetState(1)
		end
	end

	for i = answerCnt + 1, childCount do
		local go = self._answersNode.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self:_playAnswerEffect()
end

function GuessPetsGameView:_startDoingQuestion()
	if self._gameStatus == GuessPetModel.GameStatus_DoingQuestion then
		return
	end

	self:_foreceImageCorrectly()

	self._gameStatus = GuessPetModel.GameStatus_DoingQuestion

	self._emptyImage:SetActive(false)
	self._petNode:SetActive(true)
	self._questionsNode:SetActive(true)
	self._countdownNode:SetActive(true)
	self._waitingNextTip:SetActive(false)
	self._waitingFirstTip:SetActive(false)
	self._waitingOtherAnswer:SetActive(false)
	self:_stopAnswerEffect()
	self:_refreshAnswers()
	self:_resetDodingQuestionImageRotation()
	self:_updateDoingTimer()
	self:_resetPlayersView()
end

function GuessPetsGameView:_updateDoingTimer()
	local deltaTime = self._currShowingQuestion:getEndDeltaTime()

	self._countdownTime:SetNum(math.ceil(math.max(0, deltaTime)))

	if deltaTime <= 0 then
		-- block empty
	end
end

function GuessPetsGameView:_startFinishedQuestion()
	if self._gameStatus == GuessPetModel.GameStatus_FinishQuestion then
		return
	end

	self:_foreceImageCorrectly()
	self._waitingOtherAnswer:SetActive(false)

	self._gameStatus = GuessPetModel.GameStatus_FinishQuestion
	self._currMaxRectTime = 0

	self:_playPlayerFinishedEffects()
end

function GuessPetsGameView:_playPlayerFinishedEffects()
	local curQuestion = self._currShowingQuestion

	for i = 1, #self._playerViews do
		local playerView = self._playerViews[i]
		local playerInfo = playerView:getPlayerInfo()

		if playerInfo then
			local answerResult = curQuestion:getPlayerAnswer(playerInfo.playerHeadInfo.userId)

			if answerResult then
				playerView:setScores(playerInfo.scores)

				if answerResult.isFirstCorrect then
					local firstScore = GuessPetModel.instance:getFirstScore()

					playerView:setFirstTips(tostring(firstScore))
				end

				if answerResult.addScores > 0 then
					-- block empty
				end
			end
		end
	end
end

function GuessPetsGameView:_playAnswerEffect()
	self:_stopAnswerEffect()

	local answers = self._currShowingQuestion.answers
	local answerCnt = #answers
	local myAnswer = self._currShowingQuestion:getPlayerAnswer(RoleModel.instance:getUserId())
	local correctAnswer = self._currShowingQuestion.raceId

	for i = 1, answerCnt do
		if myAnswer and myAnswer.answer == answers[i] then
			local go = self._answersNode.transform:GetChild(i - 1).gameObject
			local answerEff = myAnswer.answer == correctAnswer and self._answerRightEff or self._answerWrongEff

			if answerEff then
				answerEff.transform:SetParent(go.transform, false)
				Framework.TransformUtil.SetLocalPos(answerEff.transform, 0, 3.47, 0)
				Framework.TransformUtil.SetLocalScale(answerEff.transform, 1, 2, 1)
				answerEff:SetActive(true)
			end

			break
		end
	end
end

function GuessPetsGameView:_stopAnswerEffect()
	self._answerRightEff:SetActive(false)
	self._answerWrongEff:SetActive(false)
end

function GuessPetsGameView:_startGameOver()
	if self._gameStatus == GuessPetModel.GameStatus_GameOver then
		return
	end

	self:_resetQuestionsView()

	self._gameStatus = GuessPetModel.GameStatus_GameOver

	ViewMgr.instance:open(ViewName.GuessPetsGameResult)
end

function GuessPetsGameView:_startLoadQuestionRes(resPath)
	self._gameStatus = GuessPetModel.GameStatus_LoadingQuestion

	self:_resetQuestionsView()
	self:_loadQuestionResource(resPath)
end

function GuessPetsGameView:_isQuestionResourceLoaded(resPath)
	if not self._currLoadedRes then
		return false
	end

	return self._currLoadedRes[resPath] ~= nil
end

function GuessPetsGameView:_stopLoadingRes()
	if self._curLoadingRes then
		removeresl(self._curLoadingRes, self._onResLoaded, self)

		self._curLoadingRes = nil
	end
end

function GuessPetsGameView:_loadQuestionResource(resPath)
	if self._curLoadingRes == resPath then
		return
	end

	self:_stopLoadingRes()

	self._curLoadingRes = resPath

	getres(resPath, self._onResLoaded, self)
end

function GuessPetsGameView:_onResLoaded(res)
	local resPath = res.ResPath

	if resPath ~= self._curLoadingRes then
		return
	end

	self._curLoadingRes = nil

	res:Retain()

	self._currLoadedRes = self._currLoadedRes or {}
	self._currLoadedRes[resPath] = res

	self:_buildPicture(resPath)

	if self._currShowingQuestion and self._gameStatus == GuessPetModel.GameStatus_LoadingQuestion then
		self:_checkCurQuestionStatus()
	end
end

function GuessPetsGameView:_getModelGameObject(resPath)
	self._curCacheModels = self._curCacheModels or {}

	local go = self._curCacheModels[resPath]

	if not go then
		local res = self._currLoadedRes[resPath]

		if res then
			local mainAsset = res:GetMainAsset()

			if mainAsset then
				go = goutil.clone(mainAsset)
			end
		end
	end

	if go then
		self._curCacheModels[resPath] = go
	end

	return go
end

function GuessPetsGameView:_buildPicture(resPath)
	local go = self:_getModelGameObject(resPath)

	for k, v in pairs(self._curCacheModels) do
		v:SetActive(k == resPath)
	end

	self._curModelGo = go

	if not self._curModelGo then
		return
	end

	self._curshowRect = self:_getModelShowRect()
	self._maxShowRect = self:_calFullCameraRect()

	self:_updateCameraRect(go, self._curshowRect)

	local skeletonAnimation = go:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	skeletonAnimation.AnimationName = "idle"

	skeletonAnimation:Update(0)
	skeletonAnimation:LateUpdate()

	skeletonAnimation.timeScale = 0
end

function GuessPetsGameView:_updateCameraRect(go, showRect)
	go.transform:SetParent(self._modelCamera.transform, false)
	Framework.TransformUtil.SetLocalPos(go.transform, -showRect.x, -showRect.y, 5)

	go.layer = SceneLayer.UI3DEx_Value
	self._modelCamera.orthographicSize = showRect.height * 0.5
end

function GuessPetsGameView:_calFullCameraRect()
	local centerX, centerY, width, height = self:_getModelBoxSize()
	local showRect = {}

	showRect.x = centerX
	showRect.y = centerY
	showRect.width = width
	showRect.height = height

	return showRect
end

function GuessPetsGameView:_getModelShowRect()
	local centerX, centerY, width, height = self:_getModelBoxSize()
	local widthDelta = width / 3
	local heightDelta = height / 3
	local showRect = {}

	if self._currShowingQuestion.pictureId == 1 then
		showRect.x = centerX
		showRect.y = centerY + heightDelta
	elseif self._currShowingQuestion.pictureId == 2 then
		showRect.x = centerX - widthDelta
		showRect.y = centerY
	elseif self._currShowingQuestion.pictureId == 3 then
		showRect.x = centerX
		showRect.y = centerY
	elseif self._currShowingQuestion.pictureId == 4 then
		showRect.x = centerX + widthDelta
		showRect.y = centerY
	else
		showRect.x = centerX
		showRect.y = centerY - heightDelta
	end

	showRect.width = widthDelta
	showRect.height = heightDelta

	return showRect
end

function GuessPetsGameView:_getModelBoxSize()
	local questionCo = GuessPetConfig.instance:getQuestionCo(self._currShowingQuestion.raceId)
	local centerX = 0
	local centerY = 0
	local width = 0
	local height = 0

	if not questionCo.boxCollider or #questionCo.boxCollider == 0 then
		local boxCollider = self._curModelGo:GetComponent(ComponentType.BoxCollider)
		local center = boxCollider.center
		local size = boxCollider.size

		centerX = center.x
		centerY = center.y
		width = size.x
		height = size.y
	else
		centerX = questionCo.boxCollider[1]
		centerY = questionCo.boxCollider[2]
		width = questionCo.boxCollider[3]
		height = questionCo.boxCollider[4]
	end

	return centerX, centerY, width, height
end

function GuessPetsGameView:_tickQuestion()
	if self._gameStatus == GuessPetModel.GameStatus_None then
		self:_updateWaitingFirstQuestion()
	elseif self._gameStatus == GuessPetModel.GameStatus_WaitingQuestion then
		self:_updateWaitingNextQuestion()
	elseif self._gameStatus == GuessPetModel.GameStatus_StartQuestion then
		local now = ServerTime.now()
		local questStartStamp = self._currShowingQuestion.questStartStamp

		if questStartStamp - now <= 0 then
			self:_checkCurQuestionStatus()
		end
	elseif self._gameStatus == GuessPetModel.GameStatus_DoingQuestion then
		self:_updateDoingTimer()
	elseif self._gameStatus == GuessPetModel.GameStatus_PerparingQuestion then
		local now = ServerTime.now()
		local questStartStamp = self._currShowingQuestion.questStartStamp

		if questStartStamp - now <= 1 then
			self:_checkCurQuestionStatus()
		end
	elseif self._gameStatus == GuessPetModel.GameStatus_FinishQuestion then
		self:_updateFinishTime()
		self:_updateShowMaxRect()
	end
end

function GuessPetsGameView:_updateShowMaxRect()
	local percent = self._currMaxRectTime / 0.5
	local percent = math.min(math.max(0, percent), 1)
	local centerX = Mathf.Lerp(self._curshowRect.x, self._maxShowRect.x, percent)
	local centerY = Mathf.Lerp(self._curshowRect.y, self._maxShowRect.y, percent)

	self._tempRect = self._tempRect or {}
	self._tempRect.x = centerX
	self._tempRect.y = centerY
	self._tempRect.width = Mathf.Lerp(self._curshowRect.width, self._maxShowRect.width, percent)
	self._tempRect.height = Mathf.Lerp(self._curshowRect.height, self._maxShowRect.height, percent)

	self:_updateCameraRect(self._curModelGo, self._tempRect)
end

function GuessPetsGameView:_updateFinishTime()
	local deltaTime = UnityTime.deltaTime

	self._currMaxRectTime = self._currMaxRectTime + deltaTime

	local gameMO = GuessPetModel.instance:getGuessGameMo()

	if gameMO.guessGameResult then
		if self._currMaxRectTime >= 2 then
			self:_startGameOver()
		end
	else
		local curQuestion = gameMO.curQuestion

		if curQuestion ~= self._currShowingQuestion and not curQuestion:isWaitingPreparing() then
			self:_startQuestion()
		end
	end
end

function GuessPetsGameView:_updateWaitingFirstQuestion()
	local gameMO = GuessPetModel.instance:getGuessGameMo()
	local curQuestion = gameMO.curQuestion
	local now = ServerTime.now()
	local remainTime = math.max(0, curQuestion.questPreparingStamp - now)

	self._waitingFirstTipTxt.text = string.format("距离游戏开始还有%s秒", math.floor(remainTime))

	if remainTime <= 0 then
		self:_startQuestion()
	end
end

function GuessPetsGameView:_updateWaitingNextQuestion()
	local gameMO = GuessPetModel.instance:getGuessGameMo()
	local curQuestion = self._currShowingQuestion
	local now = ServerTime.now()
	local remainTime = math.max(0, curQuestion.nextQuestionRecvTime - now)

	self._waitingFirstTipTxt.text = string.format("等待下一题：%s秒", math.floor(remainTime))

	if gameMO.curQuestion ~= curQuestion then
		self:_startQuestion()
	end
end

function GuessPetsGameView:_onClickClose()
	local gameMO = GuessPetModel.instance:getGuessGameMo()

	if not gameMO then
		self:close()

		return
	end

	if gameMO.guessGameResult then
		self:_startGameOver()

		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), "是否退出游戏？", function()
		GuessPetController.instance:requestGuessGameLeaveGame()
	end, function()
		return
	end, "确定", "取消")
end

function GuessPetsGameView:_onClickTips()
	TipsFacade.instance:openRulesView(GuessPetModel.instance:getTipsKey())
end

function GuessPetsGameView:_onClickImage()
	self:_showBubble()
end

function GuessPetsGameView:_onGuessPetsNextQuestion()
	self:_startFinishedQuestion()
end

function GuessPetsGameView:_getPlayerView(userId)
	for i = 1, #self._playerViews do
		local playerView = self._playerViews[i]
		local playerInfo = playerView:getPlayerInfo()

		if playerInfo and playerInfo.playerHeadInfo.userId == userId then
			return playerView
		end
	end
end

function GuessPetsGameView:_onGuessPetsPlayerAnswer(userId, curQuestion)
	if curQuestion ~= self._currShowingQuestion then
		return
	end

	self:_refreshAnswers()

	local playerView = self:_getPlayerView(userId)

	if not playerView then
		return
	end

	local myPlayerId = RoleModel.instance:getUserId()
	local answerResult = curQuestion:getPlayerAnswer(userId)
	local answerIndex = table.indexof(curQuestion.answers, answerResult.answer)
	local setAnswerTag = GuessPetModel.instance:getAnswerTag(answerIndex)

	playerView:setAnswer(setAnswerTag)
	playerView:setResult(answerResult.answer == curQuestion.raceId, userId == myPlayerId)

	if userId == myPlayerId then
		self._waitingOtherAnswer:SetActive(true)
	end
end

function GuessPetsGameView:_onGuessPetsPlayerExitGame(userId)
	local playerView = self:_getPlayerView(userId)

	if not playerView then
		return
	end

	playerView:setOffline(true)
end

function GuessPetsGameView:_onGuessPetsExitGameSucces()
	self:close()
end

function GuessPetsGameView:_onGuessPetsGameAbort()
	self:close()
end

function GuessPetsGameView:_onGuessPetsGameResult()
	self:_startFinishedQuestion()
end

return GuessPetsGameView
