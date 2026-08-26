-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErGameView.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErGameView", package.seeall)

local BeiLiErGameView = class("BeiLiErGameView", BaseView)

function BeiLiErGameView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._simagecrystal = gohelper.findChildSingleImage(self.viewGO, "#simage_crystal")
	self._imagecrystal = gohelper.findChildImage(self.viewGO, "#simage_crystal")
	self._simagecrystallight = gohelper.findChildSingleImage(self.viewGO, "#simage_crystal/#simage_crystal_light")
	self._imagecrystallight = gohelper.findChildImage(self.viewGO, "#simage_crystal/#simage_crystal_light")
	self._simagecrystalhuaguang = gohelper.findChildSingleImage(self.viewGO, "#simage_crystal/#simage_crystal_huaguang")
	self._imagecrystalhuaguang = gohelper.findChildImage(self.viewGO, "#simage_crystal/#simage_crystal_huaguang")
	self._simagecrystalframe = gohelper.findChildSingleImage(self.viewGO, "#simage_crystalframe")
	self._imagecrystalframe = gohelper.findChildImage(self.viewGO, "#simage_crystalframe")
	self._simagecrystalframelight = gohelper.findChildSingleImage(self.viewGO, "#simage_crystalframe/#simage_crystalframe_light")
	self._imagecrystalframelight = gohelper.findChildImage(self.viewGO, "#simage_crystalframe/#simage_crystalframe_light")
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._gotopright = gohelper.findChild(self.viewGO, "topright")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "topright/#btn_reset")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "topright/#btn_tip")
	self._txttipcount = gohelper.findChildText(self.viewGO, "topright/#btn_tip/num")
	self._gopuzzleroot = gohelper.findChild(self.viewGO, "puzzleroot")
	self._gopuzzle = gohelper.findChild(self.viewGO, "puzzleroot/puzzle")
	self._goComplete = gohelper.findChild(self.viewGO, "#go_Complete")
	self._simageCompleteframelight = gohelper.findChildSingleImage(self.viewGO, "#go_Complete/complete_light")
	self._imageCompleteframelight = gohelper.findChildImage(self.viewGO, "#go_Complete/complete_light")
	self._goFailed = gohelper.findChild(self.viewGO, "#go_Failed")
	self._goexcessive = gohelper.findChild(self.viewGO, "excessive")
	self._goblack = gohelper.findChild(self.viewGO, "excessive/anim")
	self._gotips = gohelper.findChild(self.viewGO, "#txt_Tips")
	self._goclosetips = gohelper.findChild(self.viewGO, "#txt_Close")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Complete/#btn_close")
	self._canDrag = false
	self._puzzlemovetime = 0.25
	self._showTipTime = 2
	self._animtip = self._btntip.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._animblack = self._goblack:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BeiLiErGameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnclose:AddClickListener(self._gameFinish, self)
	self.addEventCb(self, BeiLiErController.instance, BeiLiErEvent.FinishGame, self._finishGame, self)
end

function BeiLiErGameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btntip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function BeiLiErGameView:_btnresetOnClick()
	if self._isblack or self._isNextLevel then
		return
	end

	gohelper.setActive(self._goexcessive, true)
	self._animblack:Play("chessmap_guodu01", 0, 0)

	self._isblack = true

	BeiLiErStatHelper.instance:sendGameReset()
	TaskDispatcher.runDelay(self._afterReset, self, 0.5)
end

function BeiLiErGameView:_afterReset()
	TaskDispatcher.cancelTask(self._afterReset, self)

	self._isblack = false

	self:resetPuzzle()
end

function BeiLiErGameView:_btntipOnClick()
	if self._isMoving or self._isblack or self._isNextLevel then
		return
	end

	local tipcount = BeiLiErGameModel.instance:getTipCount()

	if tipcount > 0 then
		local id = BeiLiErGameModel.instance:getNextPuzzleMoId()
		local tempmo = self._gameMo:getOnPlacePuzzleMo(id)
		local puzzleComp = self._puzzleItem[id].comp
		local puzzleTrs = self._puzzleItem[id].trs
		local mo = self._puzzleItem[id].mo

		if tempmo then
			local x, y = tempmo:getPosXY()

			self:showTempPuzzle(tempmo)
			puzzleComp:tweenRotation(tempmo:getRotation())

			self._isMoving = true

			ZProj.TweenHelper.DOLocalMove(puzzleTrs, x, y, 0, self._puzzlemovetime, self._tipPuzzleMoveDone, self, mo, EaseType.Linear)
		end

		self:_refreshTipBtn()
		self._animtip:Play("tip_light", 0, 0)
		BeiLiErStatHelper.instance:sendGameTip()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
	else
		GameFacade.showToast(ToastEnum.BeiLiErGameNoTipCount)
	end
end

function BeiLiErGameView:_tipPuzzleMoveDone(mo)
	self._isMoving = false

	mo:_initCorrectPuzzle()
	self._puzzleItem[mo.id].comp:clearBgState()
	self._puzzleItem[mo.id].comp:playCorrectAnim()
	self:_resetTempPuzzle()
	self:checkGameFinish()
end

function BeiLiErGameView:_refreshTipBtn()
	self._txttipcount.text = BeiLiErGameModel.instance:getTipCount()
end

function BeiLiErGameView:onOpen()
	self._episodeId = self.viewParam
	self._episodeconfig = BeiLiErConfig.instance:getBeiLiErEpisodeConfigById(VersionActivity3_2Enum.ActivityId.BeiLiEr, self._episodeId)
	self._gameMo = BeiLiErGameModel.instance:getGameMo()
	self._gameId = BeiLiErGameModel.instance:getCurGameId()
	self._gameConfig = BeiLiErConfig.instance:getBeiLiErGameConfigById(self._gameId)

	self:_initGame()
end

function BeiLiErGameView:_initGame()
	self:_loadBg()
	self:_initPuzzle()
	gohelper.setActive(self._gopuzzleroot, true)
	self:_refreshTipBtn()
end

function BeiLiErGameView:_loadBg()
	local levelId = BeiLiErGameModel.instance:getCurrentLevelId()
	local levelConfig = self._gameConfig[levelId]

	self._simagecrystal:LoadImage(ResUrl.getBeilierIcon(levelConfig.img), self._finishloadBg, self)
	self._simagecrystallight:LoadImage(ResUrl.getBeilierIcon(levelConfig.img), self._finishloadBglight, self)
	self._simagecrystalhuaguang:LoadImage(ResUrl.getBeilierIcon(levelConfig.img), self._finishloadBghuaguang, self)
	self._simagecrystalframe:LoadImage(ResUrl.getBeilierIcon(levelConfig.bg), self._finishloadBgFrame, self)
	self._simagecrystalframelight:LoadImage(ResUrl.getBeilierIcon(levelConfig.bg), self._finishloadBgFramelight, self)
	self._simageCompleteframelight:LoadImage(ResUrl.getBeilierIcon(levelConfig.bg), self._finishloadCompleteFramelight, self)
	gohelper.setActive(self._simagecrystal.gameObject, false)
	gohelper.setActive(self._simagecrystalframe.gameObject, true)
	gohelper.setActive(self._simagecrystalframelight.gameObject, true)
	gohelper.setActive(self._simageCompleteframelight.gameObject, true)
end

function BeiLiErGameView:_finishloadBg()
	self._imagecrystal:SetNativeSize()
end

function BeiLiErGameView:_finishloadBglight()
	self._imagecrystallight:SetNativeSize()
end

function BeiLiErGameView:_finishloadBghuaguang()
	self._imagecrystalhuaguang:SetNativeSize()
end

function BeiLiErGameView:_finishloadBgFrame()
	self._imagecrystalframe:SetNativeSize()
end

function BeiLiErGameView:_finishloadBgFramelight()
	self._imagecrystalframelight:SetNativeSize()
end

function BeiLiErGameView:_finishloadCompleteFramelight()
	self._imageCompleteframelight:SetNativeSize()
end

function BeiLiErGameView:_onDragBeginPuzzle(param)
	if self._isMoving then
		return
	end

	local puzzleId = param.id
	local puzzleMo = BeiLiErGameModel.instance:getPuzzleById(puzzleId)

	if not puzzleMo or BeiLiErGameModel.instance:getCurrentPuzzleId() then
		return
	end

	if puzzleMo:getCanMove() then
		BeiLiErGameModel.instance:setCurrentPuzzleId(puzzleId)
	end
end

function BeiLiErGameView:_onDragPuzzle(param)
	if self._isMoving then
		return
	end

	local puzzleId = param.id
	local position = param.position

	if puzzleId ~= BeiLiErGameModel.instance:getCurrentPuzzleId() then
		return
	end

	local x, y = recthelper.screenPosToAnchorPos2(position, self.viewGO.transform)
	local puzzleMo = BeiLiErGameModel.instance:getPuzzleById(puzzleId)

	if puzzleMo:rotationIsCorrect() then
		if puzzleMo:isInCanShowTipRange() then
			local mo = self._gameMo:getOnPlacePuzzleMo(puzzleId)

			if mo then
				self:showTempPuzzle(mo)
				self._puzzleItem[puzzleId].comp:showOrangeBg()
			end
		elseif self._tempPuzzle then
			self._puzzleItem[puzzleId].comp:clearBgState()
			self._puzzleItem[puzzleId].comp:showWhiteBg()
			self:_resetTempPuzzle()
		end
	end

	puzzleMo:updatePos(x, y)
	self._puzzleItem[puzzleId].comp:updateInfo(puzzleMo)
end

function BeiLiErGameView:_onDragEndPuzzle(param)
	self:_resetTempPuzzle()

	if not self:checkGameFinish() then
		local mo = BeiLiErGameModel.instance:getCurrentPuzzleMo()

		if mo then
			if mo:checkCorrectPlace() then
				local puzzleTrs = self._puzzleItem[mo.id].trs
				local x, y = mo:getCorrectPos()

				ZProj.TweenHelper.DOLocalMove(puzzleTrs, x, y, 0, 0.06, self._puzzleCorrectMoveDone, self, mo, EaseType.Linear)

				self._isMoving = true
			else
				mo:initPos()

				local x, y = mo:getPosXY()
				local puzzleTrs = self._puzzleItem[mo.id].trs

				if puzzleTrs then
					ZProj.TweenHelper.DOLocalMove(puzzleTrs, x, y, 0, self._puzzlemovetime, self._puzzleMoveDone, self, nil, EaseType.Linear)
					self._puzzleItem[mo.id].comp:clearBgState()
					self._puzzleItem[mo.id].comp:showWhiteBg()

					self._isMoving = true
				end
			end
		end
	end

	BeiLiErGameModel.instance:setCurrentPuzzleId(nil)
end

function BeiLiErGameView:_puzzleCorrectMoveDone(mo)
	self._isMoving = false

	mo:_initCorrectPuzzle()
	self:_resetTempPuzzle()
	self._puzzleItem[mo.id].comp:updateInfo(mo)
	self._puzzleItem[mo.id].comp:clearBgState()
	self._puzzleItem[mo.id].comp:playCorrectAnim()
	BeiLiErGameModel.instance:setCurrentPuzzleId(nil)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	self:checkGameFinish()
end

function BeiLiErGameView:checkGameFinish()
	if BeiLiErGameModel.instance:checkGameFinish() then
		gohelper.setActive(self._gopuzzleroot, false)
		BeiLiErStatHelper.instance:sendGameFinish()

		if BeiLiErGameModel.instance:checkHaveNextLevel() then
			gohelper.setActive(self._simagecrystal.gameObject, true)
			gohelper.setActive(self._simagecrystalframe.gameObject, false)
			gohelper.setActive(self._goFailed, true)

			self._isNextLevel = true

			TaskDispatcher.runDelay(self._toNextLevel, self, 2)
			BeiLiErStatHelper.instance:enterGame()
		else
			gohelper.setActive(self._simagecrystal.gameObject, true)
			gohelper.setActive(self._simagecrystalframe.gameObject, false)
			self:_checkGuideFinish()
		end

		return true
	else
		if self._episodeconfig and self._episodeconfig.type == BeiLiErEnum.SpEpisodeType then
			self:_checkSendGuide()
		end

		return false
	end
end

function BeiLiErGameView:_checkSendGuide()
	if BeiLiErGameModel.instance:getCorrectCount() == BeiLiErEnum.SpGuideStep2Count then
		BeiLiErController.instance:dispatchEvent(BeiLiErEvent.SpLevelStep2)
	end

	if BeiLiErGameModel.instance:checkIsBeforeLastPuzzle() then
		BeiLiErController.instance:dispatchEvent(BeiLiErEvent.SpLevelStep3)
	end
end

function BeiLiErGameView:_puzzleMoveDone()
	self._isMoving = false
end

function BeiLiErGameView:showTempPuzzle(mo)
	if not self._tempPuzzle then
		self._tempPuzzle = self:getUserDataTb_()
		self._tempPuzzle.go = gohelper.clone(self._gopuzzle, self._gopuzzleroot, "puzzle" .. mo.id)
		self._tempPuzzle.comp = MonoHelper.addNoUpdateLuaComOnceToGo(self._tempPuzzle.go, BeiLiErPuzzleItem)
	end

	self._tempPuzzle.comp:initInfo(mo)
	self._tempPuzzle.comp:showOrangeBg()
	self._tempPuzzle.comp:hideBg()
	self._tempPuzzle.comp:playIdleAnim()
end

function BeiLiErGameView:_resetTempPuzzle()
	if not self._tempPuzzle then
		return
	end

	self._tempPuzzle.comp:clearPuzzle()
end

function BeiLiErGameView:_initPuzzle()
	if self._puzzleItem == nil then
		self._puzzleItem = self:getUserDataTb_()
	end

	self._puzzleItemList = {}

	local allPuzzle = self._gameMo:getAllPuzzle()

	if allPuzzle == nil then
		return
	end

	for _, puzzlemo in pairs(allPuzzle) do
		local item = self._puzzleItem[puzzlemo.id]

		if item == nil then
			item = self:getUserDataTb_()
			item.go = gohelper.clone(self._gopuzzle, self._gopuzzleroot, "puzzle" .. puzzlemo.id)
			item.trs = item.go.transform
			item.comp = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, BeiLiErPuzzleItem)
			item.mo = puzzlemo
			self._puzzleItem[puzzlemo.id] = item

			item.comp:registerBeginDrag(self._onDragBeginPuzzle, self)
			item.comp:registerDrag(self._onDragPuzzle, self)
			item.comp:registerEndDrag(self._onDragEndPuzzle, self)
			table.insert(self._puzzleItemList, item)
		end

		item.comp:initInfo(puzzlemo)
	end
end

function BeiLiErGameView:_toNextLevel()
	self._isNextLevel = false

	TaskDispatcher.cancelTask(self._toNextLevel, self)
	gohelper.setActive(self._goexcessive, true)
	self._animblack:Play("chessmap_guodu01", 0, 0)

	self._isblack = true

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
	TaskDispatcher.runDelay(self._afterNextLevel, self, 0.5)
end

function BeiLiErGameView:_afterNextLevel()
	TaskDispatcher.cancelTask(self._afterNextLevel, self)

	self._isblack = false

	self:cleanPuzzles()
	BeiLiErGameModel.instance:setNextLevelGame()
	self:setNextLevelGame()
end

function BeiLiErGameView:setNextLevelGame()
	BeiLiErController.instance:dispatchEvent(BeiLiErEvent.ToNextLevel)
	gohelper.setActive(self._goFailed, false)

	self._gameMo = BeiLiErGameModel.instance:getGameMo()

	self:_initGame()
end

function BeiLiErGameView:resetPuzzle()
	self._gameMo:resetGame()

	if self._puzzleItemList and #self._puzzleItemList > 0 then
		for _, puzzle in ipairs(self._puzzleItemList) do
			puzzle.comp:updatePos()
			puzzle.comp:playLoopAnim()
		end
	end

	BeiLiErGameModel.instance:_onStart()
	self:_refreshTipBtn()
end

function BeiLiErGameView:_checkGuideFinish()
	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.BeiLiErPuzzleGame) then
		self:_finishGame()
	else
		BeiLiErController.instance:dispatchEvent(BeiLiErEvent.OnGuideFinishGame, self._episodeId)
	end
end

function BeiLiErGameView:_finishGame()
	gohelper.setActive(self._goComplete, true)
	gohelper.setActive(self._simagecrystallight.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_note_course_finish)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goclosetips, true)
end

function BeiLiErGameView:_gameFinish()
	BeiLiErController.instance:_onGameFinished(VersionActivity3_2Enum.ActivityId.BeiLiEr, self._episodeId)
end

function BeiLiErGameView:cleanPuzzles()
	if self._puzzleItem then
		for key, item in pairs(self._puzzleItem) do
			gohelper.destroy(item.go)
			item.comp:clearPuzzle()
		end

		self._puzzleItem = nil
	end
end

function BeiLiErGameView:onClose()
	TaskDispatcher.cancelTask(self._toNextLevel, self)
	TaskDispatcher.cancelTask(self._gameFinish, self)
	TaskDispatcher.cancelTask(self._afterReset, self)
	TaskDispatcher.cancelTask(self._afterNextLevel, self)
	TaskDispatcher.cancelTask(self._initGame, self)
end

return BeiLiErGameView
