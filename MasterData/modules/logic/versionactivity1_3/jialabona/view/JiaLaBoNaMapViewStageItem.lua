-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaMapViewStageItem.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewStageItem", package.seeall)

local JiaLaBoNaMapViewStageItem = class("JiaLaBoNaMapViewStageItem", LuaCompBase)

function JiaLaBoNaMapViewStageItem:init(go)
	self.viewGO = go
	self._goRoot = gohelper.findChild(self.viewGO, "Root")
	self._imagePoint = gohelper.findChildImage(self.viewGO, "Root/#image_Point")
	self._imageStageFinishedBG = gohelper.findChildImage(self.viewGO, "Root/unlock/#image_StageFinishedBG")
	self._imageLine = gohelper.findChildImage(self.viewGO, "Root/unlock/#image_Line")
	self._imageAngle = gohelper.findChildImage(self.viewGO, "Root/unlock/#image_Angle")
	self._txtStageName = gohelper.findChildText(self.viewGO, "Root/unlock/Info/#txt_StageName")
	self._txtStageNum = gohelper.findChildText(self.viewGO, "Root/unlock/Info/#txt_StageName/#txt_StageNum")
	self._imageNoStar = gohelper.findChildImage(self.viewGO, "Root/unlock/Info/#txt_StageName/#image_NoStar")
	self._imageHasStar = gohelper.findChildImage(self.viewGO, "Root/unlock/Info/#txt_StageName/#image_HasStar")
	self._btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "Root/unlock/Info/#txt_StageName/#btn_Review")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "Root/unlock/#btn_Click")
	self._imagechess = gohelper.findChildImage(self.viewGO, "Root/unlock/image_chess")
	self._goUnLock = gohelper.findChild(self.viewGO, "Root/unlock")
	self._animator = self.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	gohelper.setActive(self._imagechess, false)

	local gochessAnim = gohelper.findChild(self.viewGO, "Root/unlock/image_chess/ani")

	self._chessAnimator = gochessAnim:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

function JiaLaBoNaMapViewStageItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function JiaLaBoNaMapViewStageItem:removeEventListeners()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
		self._btnReview:RemoveClickListener()
	end
end

function JiaLaBoNaMapViewStageItem:_btnClickOnClick()
	if self._config then
		local isSelect = Activity120Model.instance:getCurEpisodeId() == self._config.id

		JiaLaBoNaController.instance:enterChessGame(self._config.activityId, self._config.id, isSelect and 0.1 or 0.6)
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.SelectEpisode)
	end
end

function JiaLaBoNaMapViewStageItem:_btnReviewOnClick()
	if self._config then
		JiaLaBoNaController.instance:openStoryView(self._config.id)
	end
end

function JiaLaBoNaMapViewStageItem:onUpdateMO(mo)
	return
end

function JiaLaBoNaMapViewStageItem:onSelect()
	if not self._config then
		return
	end

	local curId = Activity120Model.instance:getCurEpisodeId()
	local isSelect = self._config.id == curId

	if self._isLasetSelect == isSelect then
		return
	end

	if self._isLasetSelect == nil then
		self._isLasetSelect = isSelect
		self._isLastSelectId = curId

		gohelper.setActive(self._imagechess, isSelect)
	else
		TaskDispatcher.cancelTask(self._playChessAnim, self)

		self._isLasetSelect = isSelect

		if self._isLasetSelect then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_role_move)
			TaskDispatcher.runDelay(self._playChessAnim, self, 0.15)
		else
			self:_playChessAnim()
		end
	end
end

function JiaLaBoNaMapViewStageItem:_playChessAnim()
	if not self._config then
		return
	end

	local curId = Activity120Model.instance:getCurEpisodeId()

	if not self._isLastSelectId then
		local lastId = self._config.id

		self._isLastSelectId = curId

		local animName = self:_getChessAnimName(lastId < curId)

		if self._isLasetSelect then
			gohelper.setActive(self._imagechess, true)
		end

		self._chessAnimator:Play(animName)
		TaskDispatcher.cancelTask(self._onChessAnimEnd, self)
		TaskDispatcher.runDelay(self._onChessAnimEnd, self, 0.3)
	end
end

function JiaLaBoNaMapViewStageItem:_onChessAnimEnd()
	gohelper.setActive(self._imagechess, self._isLasetSelect)
end

function JiaLaBoNaMapViewStageItem:_getChessAnimName(isRight)
	if self._isLasetSelect then
		return isRight and "open_right" or "open_left"
	end

	return isRight and "close_right" or "close_left"
end

function JiaLaBoNaMapViewStageItem:setStageType(stageType)
	self._stageType = stageType or JiaLaBoNaEnum.StageType.Main
end

function JiaLaBoNaMapViewStageItem:setCfg(cfg)
	self._config = cfg
	self._isLock = true
end

function JiaLaBoNaMapViewStageItem:getCfgId()
	return self._config and self._config.id
end

function JiaLaBoNaMapViewStageItem:getCfgPreId()
	return self._config and self._config.preEpisode
end

function JiaLaBoNaMapViewStageItem:getCfgChapterId()
	return self._config and self._config.chapterId
end

function JiaLaBoNaMapViewStageItem:refreshUI(isPlayAnim)
	if not self._config then
		gohelper.setActive(self._goRoot, false)

		return
	end

	gohelper.setActive(self._goRoot, true)

	local isLock = false

	if Activity120Model.instance:isEpisodeClear(self._config.id) then
		self:_clearanceUI()

		if isPlayAnim then
			self._animator:Play("finish", 0, 0)
		end
	elseif self._config.preEpisode == 0 or Activity120Model.instance:isEpisodeClear(self._config.preEpisode) and JiaLaBoNaHelper.isOpenDay(self._config.id) then
		self:_unLockUI()

		if isPlayAnim then
			self._animator:Play("unlock", 0, 0)
		end
	else
		isLock = true

		self:_lockUI()
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._imagePoint, isLock and "#FFFFFF" or self:_getValueByType(JiaLaBoNaEnum.Stage.StageNameColor, self._stageType))

	self._txtStageName.text = self._config.name
	self._txtStageNum.text = self._config.orderId

	if self._lastStateType ~= self._stageType then
		self._lastStateType = self._stageType

		self:_stageTypeUI()
	end
end

function JiaLaBoNaMapViewStageItem:_stageTypeUI()
	local colorNameStr = self:_getValueByType(JiaLaBoNaEnum.Stage.StageNameColor, self._stageType)

	SLFramework.UGUI.GuiHelper.SetColor(self._txtStageName, colorNameStr)

	local colorStr = self:_getValueByType(JiaLaBoNaEnum.Stage.StageColor, self._stageType)

	SLFramework.UGUI.GuiHelper.SetColor(self._imageLine, colorStr)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtStageNum, colorStr)
end

function JiaLaBoNaMapViewStageItem:_getValueByType(stageMap, stageType)
	return stageMap[stageType] or stageMap[JiaLaBoNaEnum.StageType.Main]
end

function JiaLaBoNaMapViewStageItem:_lockUI()
	gohelper.setActive(self._goUnLock, false)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(self._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished)
end

function JiaLaBoNaMapViewStageItem:_unLockUI()
	gohelper.setActive(self._goUnLock, true)
	gohelper.setActive(self._imageStageFinishedBG, false)
	gohelper.setActive(self._btnReview, false)
	self:_startUI(false)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(self._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished)
end

function JiaLaBoNaMapViewStageItem:_clearanceUI()
	gohelper.setActive(self._goUnLock, true)
	gohelper.setActive(self._imageStageFinishedBG, true)
	gohelper.setActive(self._btnReview, self:_isHasStory())

	local episodeData = Activity120Model.instance:getEpisodeData(self._config.id)
	local var_21_0

	if episodeData then
		::label_21_0::

		var_21_0 = episodeData.star and episodeData.star > 1
	end

	self:_startUI(var_21_0)
	UISpriteSetMgr.instance:setJiaLaBoNaSprite(self._imagePoint, JiaLaBoNaEnum.StatgePiontSpriteName.Finished)
end

function JiaLaBoNaMapViewStageItem:_startUI(isHas)
	gohelper.setActive(self._imageNoStar, not isHas)
	gohelper.setActive(self._imageHasStar, isHas)
end

function JiaLaBoNaMapViewStageItem:_isHasStory()
	if self._config then
		local storyCoList = Activity120Config.instance:getEpisodeStoryList(self._config.activityId, self._config.id)

		if storyCoList and #storyCoList > 0 then
			return true
		end
	end

	return false
end

function JiaLaBoNaMapViewStageItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onChessAnimEnd, self)
	TaskDispatcher.cancelTask(self._playChessAnim, self)
	self:removeEventListeners()
	self:__onDispose()
end

JiaLaBoNaMapViewStageItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonamapviewstageitem.prefab"

return JiaLaBoNaMapViewStageItem
