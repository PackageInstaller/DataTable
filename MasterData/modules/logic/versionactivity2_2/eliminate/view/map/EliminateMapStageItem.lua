-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateMapStageItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapStageItem", package.seeall)

local EliminateMapStageItem = class("EliminateMapStageItem", ListScrollCellExtend)

function EliminateMapStageItem:onInitView()
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point")
	self._imagepointfinished = gohelper.findChildImage(self.viewGO, "#image_pointfinished")
	self._gostage = gohelper.findChild(self.viewGO, "unlock/#go_stage")
	self._gostagefinish = gohelper.findChild(self.viewGO, "unlock/#go_stage/#go_stagefinish")
	self._goGame = gohelper.findChild(self.viewGO, "unlock/#go_stage/#go_Game")
	self._goStageLine = gohelper.findChild(self.viewGO, "unlock/#go_stage/#go_StageLine")
	self._goStageLineFinished = gohelper.findChild(self.viewGO, "unlock/#go_stage/#go_StageLineFinished")
	self._imageline = gohelper.findChildImage(self.viewGO, "unlock/#go_stage/#image_line")
	self._imageangle = gohelper.findChildImage(self.viewGO, "unlock/#go_stage/#image_angle")
	self._imagelinefinish = gohelper.findChildImage(self.viewGO, "unlock/#go_stage/#image_linefinish")
	self._imageanglefinish = gohelper.findChildImage(self.viewGO, "unlock/#go_stage/#image_anglefinish")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/#go_stage/info/#txt_stagename")
	self._txtstageNum = gohelper.findChildText(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#txt_stageNum")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	self._gostar1 = gohelper.findChild(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1")
	self._imageStar1 = gohelper.findChildImage(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1/has/#image_Star1")
	self._gostar2 = gohelper.findChild(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2")
	self._imageStar2 = gohelper.findChildImage(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2/has/#image_Star2")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._imagechess = gohelper.findChildImage(self.viewGO, "unlock/#image_chess")
	self._imageSign = gohelper.findChildImage(self.viewGO, "#image_Sign")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateMapStageItem:addEvents()
	self._btnreview:AddClickListener(self._btnreviewOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function EliminateMapStageItem:removeEvents()
	self._btnreview:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function EliminateMapStageItem:_btnreviewOnClick()
	local dialogueId = self._config.dialogueId

	if dialogueId > 0 then
		DialogueController.instance:enterDialogue(dialogueId)
	end
end

function EliminateMapStageItem:_btnclickOnClick()
	self:_onClickEnterEpisode()
end

function EliminateMapStageItem:_onClickEnterEpisode()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ClickEpisode, self._config)
end

function EliminateMapStageItem:_editableInitView()
	self._gostarNo1 = gohelper.findChild(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star1/no")
	self._gostarNo2 = gohelper.findChild(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star/#go_star2/no")
	self._animator = self.viewGO:GetComponent("Animator")
	self._goUnlock = gohelper.findChild(self.viewGO, "unlock")

	local chessAniGo = gohelper.findChild(self.viewGO, "unlock/#image_chess/ani")

	self._chessAnimator = chessAniGo:GetComponent("Animator")

	gohelper.setActive(self._imageSign, false)
	gohelper.setActive(self._imagepointfinished, false)
	gohelper.setActive(self._imagechess, false)
	gohelper.setActive(self._imagepoint, true)
	gohelper.setActive(self._goGame, false)
end

function EliminateMapStageItem:playAnim(name)
	self._animator:Play(name, 0, 0)
end

function EliminateMapStageItem:playChessAnim(name)
	self._chessAnimator:Play(name, 0, 0)
end

function EliminateMapStageItem:_editableAddEvents()
	return
end

function EliminateMapStageItem:_editableRemoveEvents()
	return
end

function EliminateMapStageItem:isBoss()
	return self._isBoss
end

function EliminateMapStageItem:getChapterId()
	return self._config.chapterId
end

function EliminateMapStageItem:setIndex(index)
	self._index = index
end

function EliminateMapStageItem:onUpdateMO(mo, lastCanFightEpisodeMo)
	self._episodeMo = mo

	local isPassed = self._episodeMo.star ~= 0

	self._config = self._episodeMo.config
	self._isBoss = self._config.levelPosition == EliminateLevelEnum.levelType.boss
	self._isShowMainInfo = isPassed or mo == lastCanFightEpisodeMo

	self:showMainInfo(self._isShowMainInfo)
	gohelper.setActive(self._btnreview, isPassed and self._config.dialogueId > 0)

	local color = self._isBoss and (isPassed and EliminateMapEnum.BossPassedColor or EliminateMapEnum.BossUnPassedColor) or isPassed and EliminateMapEnum.NormalPassedColor or EliminateMapEnum.NormalUnPassedColor

	self._txtstagename.color = self._isBoss and (isPassed and EliminateMapEnum.TxtBossPassedColor or EliminateMapEnum.TxtBossUnPassedColor) or isPassed and EliminateMapEnum.TxtNormalPassedColor or EliminateMapEnum.TxtNormalUnPassedColor

	if not self._isShowMainInfo then
		self._imagepoint.color = EliminateMapEnum.TxtNormalUnPassedColor or color
	end

	self._imagepointfinished.color = color
	self._imageline.color = color
	self._imageangle.color = color
	self._txtstagename.text = self._config.name
	self._txtstageNum.text = string.format("STAGE <color=#FFC67C>%s-%s</color>", self._config.chapterId, self._index)

	gohelper.setActive(self._goStageLine, not isPassed)
	gohelper.setActive(self._gostagefinish, isPassed)
	gohelper.setActive(self._goStageLineFinished, isPassed)
	gohelper.setActive(self._imageline, not isPassed)
	gohelper.setActive(self._imageangle, not isPassed)
	gohelper.setActive(self._imagelinefinish, isPassed)
	gohelper.setActive(self._imageanglefinish, isPassed)
	self:_showStars()
end

function EliminateMapStageItem:showMainInfo(value)
	gohelper.setActive(self._goUnlock, value)
end

function EliminateMapStageItem:showChess(value)
	gohelper.setActive(self._imagechess, value)
	gohelper.setActive(self._imagepointfinished, value)
	gohelper.setActive(self._imageSign, value)
	gohelper.setActive(self._goGame, value)
end

function EliminateMapStageItem:showPointFinish(value)
	gohelper.setActive(self._imagepointfinished, value)
	gohelper.setActive(self._goGame, value)
end

function EliminateMapStageItem:showSign(value)
	gohelper.setActive(self._imageSign, value)
end

function EliminateMapStageItem:_showStars()
	local warChessId = self._config.warChessId
	local warBattleConfig = lua_war_chess_episode.configDict[warChessId]
	local hasMultiConfition = not string.nilorempty(warBattleConfig.extraWinCondition)
	local starNum = hasMultiConfition and 2 or 1

	for i = 1, 2 do
		local go = self["_gostar" .. i]
		local showStar = i <= starNum

		gohelper.setActive(go, showStar)

		if showStar then
			local star = self["_imageStar" .. i]
			local showImageStar = i <= self._episodeMo.star

			gohelper.setActive(star, showImageStar)

			local noGo = self["_gostarNo" .. i]

			gohelper.setActive(noGo, not showImageStar)
		end
	end
end

function EliminateMapStageItem:onSelect(isSelect)
	return
end

function EliminateMapStageItem:onDestroyView()
	return
end

return EliminateMapStageItem
