-- chunkname: @modules/logic/versionactivity3_5/lorentz/view/LorentzGameView.lua

module("modules.logic.versionactivity3_5.lorentz.view.LorentzGameView", package.seeall)

local LorentzGameView = class("LorentzGameView", BaseView)

function LorentzGameView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._simagecrystal = gohelper.findChildSingleImage(self.viewGO, "#simage_puzzle")
	self._simagecrystallight = gohelper.findChildSingleImage(self.viewGO, "#simage_puzzle/#simage_puzzle_light")
	self._imagecrystal = gohelper.findChildImage(self.viewGO, "#simage_puzzle")
	self._imagecrystallight = gohelper.findChildImage(self.viewGO, "#simage_puzzle/#simage_puzzle_light")
	self._simagecrystalframe = gohelper.findChildSingleImage(self.viewGO, "#simage_crystalframe")
	self._imagecrystalframe = gohelper.findChildImage(self.viewGO, "#simage_crystalframe")
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

function LorentzGameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnclose:AddClickListener(self._gameFinish, self)
	self.addEventCb(self, LorentzController.instance, LorentzEvent.FinishGame, self._finishGame, self)
end

function LorentzGameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btntip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function LorentzGameView:_btnresetOnClick()
	if self._isblack or self._isNextLevel then
		return
	end

	gohelper.setActive(self._goexcessive, true)
	self._animblack:Play("chessmap_guodu01", 0, 0)

	self._isblack = true

	LorentzStatHelper.instance:sendGameReset()
	TaskDispatcher.runDelay(self._afterReset, self, 0.5)
end

function LorentzGameView:_afterReset()
	TaskDispatcher.cancelTask(self._afterReset, self)

	self._isblack = false

	self:resetPuzzle()
end

function LorentzGameView:_btntipOnClick()
	if self._isMoving or self._isblack or self._isNextLevel then
		return
	end

	local tipcount = LorentzGameModel.instance:getTipCount()

	if tipcount > 0 then
		local id = LorentzGameModel.instance:getNextPuzzleMoId()
		local tempmo = self._gameMo:getOnPlacePuzzleMo(id)
		local puzzleComp = self._puzzleItem[id].comp
		local puzzleTrs = self._puzzleItem[id].trs
		local mo = self._puzzleItem[id].mo

		if tempmo then
			local x, y = tempmo:getPosXY()

			puzzleComp:tweenRotation(tempmo:getRotation())

			self._isMoving = true

			ZProj.TweenHelper.DOLocalMove(puzzleTrs, x, y, 0, self._puzzlemovetime, self._tipPuzzleMoveDone, self, mo, EaseType.Linear)
		end

		self:_refreshTipBtn()
		self._animtip:Play("tip_light", 0, 0)
		LorentzStatHelper.instance:sendGameTip()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
	else
		GameFacade.showToast(ToastEnum.BeiLiErGameNoTipCount)
	end
end

function LorentzGameView:_tipPuzzleMoveDone(mo)
	self._isMoving = false

	mo:_initCorrectPuzzle()
	self._puzzleItem[mo.id].comp:clearBgState()
	self._puzzleItem[mo.id].comp:playCorrectAnim()
	self:_resetTempPuzzle()
	self:checkGameFinish()
end

function LorentzGameView:_refreshTipBtn()
	self._txttipcount.text = LorentzGameModel.instance:getTipCount()
end

function LorentzGameView:onOpen()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "LorentzGameView", true)

	self._episodeId = self.viewParam
	self._episodeconfig = LorentzConfig.instance:getLorentzEpisodeConfigById(VersionActivity3_5Enum.ActivityId.Lorentz, self._episodeId)
	self._gameMo = LorentzGameModel.instance:getGameMo()
	self._gameId = LorentzGameModel.instance:getCurGameId()
	self._gameConfig = LorentzConfig.instance:getLorentzGameConfigById(self._gameId)

	self:_initGame()
end

function LorentzGameView:_initGame()
	self:_loadBg()
	self:_initPuzzle()
	gohelper.setActive(self._gopuzzleroot, true)
	self:_refreshTipBtn()
end

function LorentzGameView:_loadBg()
	local levelId = LorentzGameModel.instance:getCurrentLevelId()
	local levelConfig = self._gameConfig[levelId]

	self._simagecrystal:LoadImage(ResUrl.getLorentzIcon(levelConfig.img), self._finishloadBg, self)
	self._simagecrystallight:LoadImage(ResUrl.getLorentzIcon(levelConfig.img), self._finishloadLightBg, self)
	self._simagecrystalframe:LoadImage(ResUrl.getLorentzIcon(levelConfig.bg), self._finishloadBgFrame, self)
	gohelper.setActive(self._simagecrystal.gameObject, false)
	gohelper.setActive(self._simagecrystalframe.gameObject, true)
end

function LorentzGameView:_finishloadBg()
	self._imagecrystal:SetNativeSize()
end

function LorentzGameView:_finishloadLightBg()
	self._imagecrystallight:SetNativeSize()
end

function LorentzGameView:_finishloadBgFrame()
	self._imagecrystalframe:SetNativeSize()
end

function LorentzGameView:_onDragBeginPuzzle(param)
	if self._isMoving then
		return
	end

	local puzzleId = param.id
	local puzzleMo = LorentzGameModel.instance:getPuzzleById(puzzleId)

	if not puzzleMo or LorentzGameModel.instance:getCurrentPuzzleId() then
		return
	end

	if puzzleMo:getCanMove() then
		LorentzGameModel.instance:setCurrentPuzzleId(puzzleId)
	end
end

function LorentzGameView:_onDragPuzzle(param)
	if self._isMoving then
		return
	end

	local puzzleId = param.id
	local position = param.position

	if puzzleId ~= LorentzGameModel.instance:getCurrentPuzzleId() then
		return
	end

	local x, y = recthelper.screenPosToAnchorPos2(position, self.viewGO.transform)
	local puzzleMo = LorentzGameModel.instance:getPuzzleById(puzzleId)

	if puzzleMo:rotationIsCorrect() then
		if puzzleMo:isInCanShowTipRange() then
			local mo = self._gameMo:getOnPlacePuzzleMo(puzzleId)

			if mo then
				self._puzzleItem[puzzleId].comp:showOrangeBg()
			end
		elseif self._tempPuzzle then
			self._puzzleItem[puzzleId].comp:clearBgState()
			self._puzzleItem[puzzleId].comp:showWhiteBg()
		end
	end

	puzzleMo:updatePos(x, y)
	self._puzzleItem[puzzleId].comp:updateInfo(puzzleMo)
end

function LorentzGameView:_onDragEndPuzzle(param)
	self:_resetTempPuzzle()

	if not self:checkGameFinish() then
		local mo = LorentzGameModel.instance:getCurrentPuzzleMo()

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

	LorentzGameModel.instance:setCurrentPuzzleId(nil)
end

function LorentzGameView:_puzzleCorrectMoveDone(mo)
	self._isMoving = false

	mo:_initCorrectPuzzle()
	self:_resetTempPuzzle()
	self._puzzleItem[mo.id].comp:updateInfo(mo)
	self._puzzleItem[mo.id].comp:clearBgState()
	self._puzzleItem[mo.id].comp:playCorrectAnim()
	LorentzGameModel.instance:setCurrentPuzzleId(nil)
	AudioMgr.instance:trigger(AudioEnum3_5.Lorentz.play_ui_hero_card_gone)
	self:checkGameFinish()
end

function LorentzGameView:checkGameFinish()
	if LorentzGameModel.instance:checkGameFinish() then
		gohelper.setActive(self._gopuzzleroot, false)
		LorentzStatHelper.instance:sendGameFinish()

		if LorentzGameModel.instance:checkHaveNextLevel() then
			gohelper.setActive(self._simagecrystal.gameObject, true)
			gohelper.setActive(self._simagecrystalframe.gameObject, false)
			gohelper.setActive(self._goFailed, true)

			self._isNextLevel = true

			TaskDispatcher.runDelay(self._toNextLevel, self, 2)
			LorentzStatHelper.instance:enterGame()
		else
			gohelper.setActive(self._simagecrystal.gameObject, true)
			gohelper.setActive(self._simagecrystalframe.gameObject, false)
			self:_checkGuideFinish()
		end

		return true
	else
		if self._episodeconfig and self._episodeconfig.type == LorentzEnum.SpEpisodeType then
			self:_checkSendGuide()
		end

		return false
	end
end

function LorentzGameView:_checkSendGuide()
	if LorentzGameModel.instance:getCorrectCount() == LorentzEnum.SpGuideStep2Count then
		LorentzController.instance:dispatchEvent(LorentzEvent.SpLevelStep2)
	end

	if LorentzGameModel.instance:checkIsBeforeLastPuzzle() then
		LorentzController.instance:dispatchEvent(LorentzEvent.SpLevelStep3)
	end
end

function LorentzGameView:_puzzleMoveDone()
	self._isMoving = false
end

function LorentzGameView:showTempPuzzle(mo)
	if not self._tempPuzzle then
		self._tempPuzzle = self:getUserDataTb_()
		self._tempPuzzle.go = gohelper.clone(self._gopuzzle, self._gopuzzleroot, "puzzle" .. mo.id)
		self._tempPuzzle.comp = MonoHelper.addNoUpdateLuaComOnceToGo(self._tempPuzzle.go, LorentzPuzzleItem)
	end

	self._tempPuzzle.comp:initInfo(mo)
end

function LorentzGameView:_resetTempPuzzle()
	if not self._tempPuzzle then
		return
	end

	self._tempPuzzle.comp:clearPuzzle()
end

function LorentzGameView:_initPuzzle()
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
			item.comp = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, LorentzPuzzleItem)
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

function LorentzGameView:_toNextLevel()
	self._isNextLevel = false

	TaskDispatcher.cancelTask(self._toNextLevel, self)
	gohelper.setActive(self._goexcessive, true)
	self._animblack:Play("chessmap_guodu01", 0, 0)

	self._isblack = true

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
	TaskDispatcher.runDelay(self._afterNextLevel, self, 0.5)
end

function LorentzGameView:_afterNextLevel()
	TaskDispatcher.cancelTask(self._afterNextLevel, self)

	self._isblack = false

	self:cleanPuzzles()
	LorentzGameModel.instance:setNextLevelGame()
	self:setNextLevelGame()
end

function LorentzGameView:setNextLevelGame()
	LorentzController.instance:dispatchEvent(LorentzEvent.ToNextLevel)
	gohelper.setActive(self._goFailed, false)

	self._gameMo = LorentzGameModel.instance:getGameMo()

	self:_initGame()
end

function LorentzGameView:resetPuzzle()
	self._gameMo:resetGame()

	if self._puzzleItemList and #self._puzzleItemList > 0 then
		for _, puzzle in ipairs(self._puzzleItemList) do
			puzzle.comp:updatePos()
			puzzle.comp:playLoopAnim()
		end
	end

	LorentzGameModel.instance:_onStart()
	self:_refreshTipBtn()
end

function LorentzGameView:_checkGuideFinish()
	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.LorentzPuzzleGame) then
		self:_finishGame()
	else
		LorentzController.instance:dispatchEvent(LorentzEvent.OnGuideFinishGame, self._episodeId)
	end
end

function LorentzGameView:_finishGame()
	gohelper.setActive(self._goComplete, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_note_course_finish)
	AudioMgr.instance:trigger(AudioEnum3_5.Lorentz.play_ui_lushang_zhihuibu_fanhui)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goclosetips, true)
end

function LorentzGameView:_gameFinish()
	LorentzController.instance:_onGameFinished(VersionActivity3_5Enum.ActivityId.Lorentz, self._episodeId)
end

function LorentzGameView:cleanPuzzles()
	if self._puzzleItem then
		for key, item in pairs(self._puzzleItem) do
			gohelper.destroy(item.go)
			item.comp:clearPuzzle()
		end

		self._puzzleItem = nil
	end
end

function LorentzGameView:onClose()
	TaskDispatcher.cancelTask(self._toNextLevel, self)
	TaskDispatcher.cancelTask(self._gameFinish, self)
	TaskDispatcher.cancelTask(self._afterReset, self)
	TaskDispatcher.cancelTask(self._afterNextLevel, self)
	TaskDispatcher.cancelTask(self._initGame, self)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "LorentzGameView", false)
end

return LorentzGameView
