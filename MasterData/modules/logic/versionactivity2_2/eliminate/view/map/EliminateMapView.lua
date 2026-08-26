-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateMapView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapView", package.seeall)

local EliminateMapView = class("EliminateMapView", BaseView)

function EliminateMapView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "map/#simage_bg")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "window/bottom/#simage_bottom")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateMapView:addEvents()
	return
end

function EliminateMapView:removeEvents()
	return
end

EliminateMapView.MapMaxOffsetX = 150
EliminateMapView.AnimationDuration = 1

function EliminateMapView:_editableInitView()
	self._vec4 = Vector4(0, 0.05, 0, 0)
	self.goChapterNodeList = {}
	self.nodeItemDict = {}

	for i = 1, EliminateMapModel.getChapterNum() do
		table.insert(self.goChapterNodeList, gohelper.findChild(self.viewGO, "map/chapter" .. i))
	end

	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.UnlockChapterAnimDone, self._onUnlockChapterAnimDone, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.OnUpdateEpisodeInfo, self.onUpdateEpisodeInfo, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.ClickEpisode, self._onClickEpisode, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self.animator = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._gonormal = gohelper.findChild(self.viewGO, "map/bg_eff_normal")
	self._gospecial = gohelper.findChild(self.viewGO, "map/bg_eff_special")
end

local BlockKey = "EliminateMapViewBlock"

function EliminateMapView:_startBlock(time)
	TaskDispatcher.cancelTask(self._endBlock, self)
	TaskDispatcher.runDelay(self._endBlock, self, time + 0.1)
	UIBlockMgr.instance:startBlock(BlockKey)
end

function EliminateMapView:_endBlock()
	UIBlockMgr.instance:endBlock(BlockKey)
end

function EliminateMapView:selectedNodeItem(nodeItem)
	nodeItem:showChess(true)

	self._curSelectedNodeItem = nodeItem

	local isBoss = nodeItem:isBoss()

	gohelper.setActive(self._gonormal, not isBoss)
	gohelper.setActive(self._gospecial, isBoss)
end

function EliminateMapView:onOpen()
	self.chapterId = self.viewContainer.chapterId
	self.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(self.chapterId)

	self:refreshUI()
	self:refreshPath()
end

function EliminateMapView:initMat()
	local chapterGo = self.goChapterNodeList[self.chapterId]
	local matGo = gohelper.findChild(chapterGo, "lujinganim/luxian_light")

	self.mat = matGo:GetComponent(typeof(UnityEngine.UI.Graphic)).material
end

function EliminateMapView:refreshUI()
	self:refreshBg()
	self:refreshNode()
end

function EliminateMapView:refreshBg()
	local path = lua_eliminate_chapter.configDict[self.chapterId].map

	self._simagebg:LoadImage(path)

	for i = 1, EliminateMapModel.getChapterNum() do
		gohelper.setActive(self.goChapterNodeList[i], i == self.chapterId)
	end

	self:initMat()
end

function EliminateMapView:refreshNode()
	local episodeList = EliminateMapModel.instance:getEpisodeList(self.chapterId)

	for i, episodeMo in ipairs(episodeList) do
		local nodeItem = self.nodeItemDict[episodeMo.id]

		if not nodeItem then
			nodeItem = self:createNodeItem(episodeMo)
			self.nodeItemDict[episodeMo.id] = nodeItem

			nodeItem:setIndex(i)
		end

		nodeItem:onUpdateMO(episodeMo, self.lastCanFightEpisodeMo)

		if nodeItem ~= self._curSelectedNodeItem then
			nodeItem:showChess(false)
		end
	end

	if self._curSelectedNodeItem then
		self:selectedNodeItem(self._curSelectedNodeItem)
	end
end

function EliminateMapView:createNodeItem(episodeMo)
	local nodeGo = gohelper.findChild(self.goChapterNodeList[self.chapterId], "node" .. episodeMo.config.posIndex)

	if episodeMo.config.levelPosition == EliminateLevelEnum.levelType.boss then
		local var_13_0 = self.viewContainer:getSetting().otherRes[3]

		if not var_13_0 then
			var_13_0 = self.viewContainer:getSetting().otherRes[2]

			local path = var_13_0
			local itemGo = self:getResInst(path, nodeGo, episodeMo.config.posIndex)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, EliminateMapStageItem)

			item.parentTrans = nodeGo.transform

			return item
		end
	end
end

function EliminateMapView:refreshPath()
	local targetEpisodeConfig = self.lastCanFightEpisodeMo.config

	if self:checkNeedPlayAnimation() and self._isUpdateEpisodeInfo then
		local nodeItem = self.nodeItemDict[targetEpisodeConfig.id]

		if nodeItem then
			nodeItem:showMainInfo(false)
		end

		self._targetItem = nodeItem

		local srcEpisodeConfig = EliminateMapModel.instance:getEpisodeConfig(targetEpisodeConfig.preEpisode)

		if srcEpisodeConfig then
			if not srcEpisodeConfig.aniPos then
				local srcAniPos = 0
				local nodeItem = self.nodeItemDict[srcEpisodeConfig.id]

				if nodeItem then
					self:selectedNodeItem(nodeItem)
					nodeItem:playAnim("finish")
				end

				self._srcItem = nodeItem

				self:setMatValue(srcAniPos)
				TaskDispatcher.runDelay(self.startPathAnimation, self, EliminateMapEnum.MapViewOpenAnimLength)
				self:_startBlock(EliminateMapEnum.MapViewOpenAnimLength)

				return
			end
		end
	end

	if targetEpisodeConfig then
		if not targetEpisodeConfig.aniPos then
			local targetAniPos = 0

			self:setMatValue(targetAniPos)

			if not self._curSelectedNodeItem then
				local nodeItem = self.nodeItemDict[self.lastCanFightEpisodeMo.id]

				self:selectedNodeItem(nodeItem)
			end

			if self._changeEpisodeAnimDone then
				self._changeEpisodeAnimDone = false

				local nodeItem = self.nodeItemDict[self.lastCanFightEpisodeMo.id]

				self:selectedNodeItem(nodeItem)
				nodeItem:playChessAnim("open_right")
			end

			if self._isUpdateEpisodeInfo or self._updateNode then
				TaskDispatcher.cancelTask(self._refreshNodyByUpdateEpisodeInfo, self)
				TaskDispatcher.runDelay(self._refreshNodyByUpdateEpisodeInfo, self, EliminateMapEnum.MapViewOpenAnimLength)
				self:_startBlock(EliminateMapEnum.MapViewOpenAnimLength)
			end
		end
	end
end

function EliminateMapView:_refreshNodyByUpdateEpisodeInfo()
	if self._isUpdateEpisodeInfo or self._updateNode then
		self._isUpdateEpisodeInfo = false

		self:refreshNode()
	end
end

function EliminateMapView:startPathAnimation()
	local targetEpisodeConfig = self.lastCanFightEpisodeMo.config

	if not targetEpisodeConfig.aniPos then
		local targetAniPos = 0
		local srcEpisodeConfig = EliminateMapModel.instance:getEpisodeConfig(targetEpisodeConfig.preEpisode)

		if srcEpisodeConfig then
			if not srcEpisodeConfig.aniPos then
				local srcAniPos = 0

				if srcAniPos == targetAniPos then
					self:setMatValue(srcAniPos)
					self:_refreshNodyByUpdateEpisodeInfo()

					return
				end

				self.srcAniPos = srcAniPos
				self.targetAniPos = targetAniPos

				if self._pathTweenId then
					ZProj.TweenHelper.KillById(self._pathTweenId)

					self._pathTweenId = nil
				end

				local time = 0.33

				self._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, time, self._onPathFrame, self._onPathFinish, self, nil, EaseType.Linear)

				self:_startBlock(time)
			end
		end
	end
end

function EliminateMapView:_onPathFrame(t)
	local tempVale = self.srcAniPos + (self.targetAniPos - self.srcAniPos) * t

	self:setMatValue(tempVale)
end

function EliminateMapView:_onPathFinish()
	self:_refreshNodyByUpdateEpisodeInfo()
	self:setMatValue(self.targetAniPos)
	self:playedPathAnimation(self.lastCanFightEpisodeMo.id)
	self._targetItem:showMainInfo(true)
	self._targetItem:playAnim("unlock")
	self:_showChessMoveAnim(self._srcItem, self._targetItem)
end

function EliminateMapView:_showChessMoveAnim(srcItem, targetItem)
	srcItem:showPointFinish(false)
	srcItem:showSign(false)
	self:selectedNodeItem(targetItem)

	local srcX = recthelper.getAnchorX(srcItem.parentTrans)
	local targetX = recthelper.getAnchorX(targetItem.parentTrans)
	local srcChapterId = srcItem:getChapterId()
	local targetChapterId = targetItem:getChapterId()

	if (srcChapterId ~= targetChapterId or nil) and srcChapterId < targetChapterId then
		srcItem:playChessAnim("close_right")
		targetItem:playChessAnim("open_right")
	else
		srcItem:playChessAnim("close_left")
		targetItem:playChessAnim("open_left")
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_molu_role_move)
end

function EliminateMapView:setMatValue(value)
	self._vec4.x = value

	self.mat:SetVector("_DissolveControl", self._vec4)
end

function EliminateMapView:checkNeedPlayAnimation()
	if EliminateMapModel.instance:isFirstEpisode(self.lastCanFightEpisodeMo.id) then
		return false
	end

	return not self:isPlayedPathAnimation()
end

function EliminateMapView:isPlayedPathAnimation()
	self:initPlayedPathAnimationEpisodeList()

	if tabletool.indexOf(self.playedEpisodeIdList, self.lastCanFightEpisodeMo.id) then
		return true
	end

	return false
end

function EliminateMapView:initPlayedPathAnimationEpisodeList()
	if self.playedEpisodeIdList then
		return
	end

	local str = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateEpisodePathAnimationKey), "")

	if string.nilorempty(str) then
		self.playedEpisodeIdList = {}

		return
	end

	self.playedEpisodeIdList = string.splitToNumber(str, ";")
end

function EliminateMapView:playedPathAnimation(episodeId)
	if tabletool.indexOf(self.playedEpisodeIdList, episodeId) then
		return
	end

	table.insert(self.playedEpisodeIdList, episodeId)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateEpisodePathAnimationKey), table.concat(self.playedEpisodeIdList, ";"))
end

EliminateMapView.EnterGameKey = "EnterEliminateKey"

function EliminateMapView:_onClickEpisode(config)
	self._selectedEpisodeCo = config
	self._selectedEpisodeId = self._selectedEpisodeCo.id

	if not self._curSelectedNodeItem then
		self:_doEnterEpisode()

		return
	end

	local nodeItem = self.nodeItemDict[self._selectedEpisodeId]

	if self._curSelectedNodeItem == nodeItem then
		self:_doEnterEpisode()

		return
	end

	self:_showChessMoveAnim(self._curSelectedNodeItem, nodeItem)
	TaskDispatcher.cancelTask(self._doEnterEpisode, self)

	local time = 0.5

	TaskDispatcher.runDelay(self._doEnterEpisode, self, time)
	self:_startBlock(time)
end

function EliminateMapView:_doEnterEpisode()
	local dialogueId = self._selectedEpisodeCo.dialogueId

	if dialogueId > 0 and not DialogueModel.instance:isFinishDialogue(dialogueId) then
		DialogueController.instance:enterDialogue(dialogueId, self._enterEpisode, self)

		return
	end

	self:_enterEpisode()
end

function EliminateMapView:_enterEpisode()
	if not EliminateLevelModel.instance:selectSoliderIsUnLock() then
		self.animator:Play("click", self._onClickAnimDone, self)
	else
		self:_onClickAnimDone()
	end
end

function EliminateMapView:_onClickAnimDone()
	self._changeEpisodeAnimDone = false

	local episodeId = self._selectedEpisodeId

	EliminateMapController.instance:enterEpisode(episodeId)
end

function EliminateMapView:_onUnlockChapterAnimDone()
	self._changeEpisodeAnimDone = true
end

function EliminateMapView:onSelectChapterChange()
	self.chapterId = self.viewContainer.chapterId
	self.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(self.chapterId)

	self:refreshUI()
	self:refreshPath()
end

function EliminateMapView:onUpdateEpisodeInfo()
	local oldLastCanFightEpisodeMo = self.lastCanFightEpisodeMo

	self.lastCanFightEpisodeMo = EliminateMapModel.instance:getLastCanFightEpisodeMo(self.chapterId)
	self._isUpdateEpisodeInfo = not oldLastCanFightEpisodeMo or oldLastCanFightEpisodeMo.id ~= self.lastCanFightEpisodeMo.id
end

function EliminateMapView:_onScreenSizeChange()
	return
end

function EliminateMapView:_onOpenViewFinish(viewName)
	if viewName == ViewName.EliminateEffectView then
		ViewMgr.instance:closeView(ViewName.EliminateSelectChessMenView)
		ViewMgr.instance:closeView(ViewName.EliminateSelectRoleView)
	end
end

function EliminateMapView:_onCloseViewFinish(viewName)
	if viewName == ViewName.EliminateEffectView then
		if EliminateTeamSelectionModel.instance:getRestart() then
			EliminateTeamSelectionModel.instance:setRestart(false)
			self:_enterEpisode()

			return
		end

		self.animator:Play("out", self._outAnimDone, self)

		self._updateNode = true

		self:refreshPath()
	end
end

function EliminateMapView:_outAnimDone()
	return
end

function EliminateMapView:onClickAnimationDone()
	UIBlockMgr.instance:endBlock(EliminateMapView.EnterGameKey)
	EliminateMapModel.instance:setPlayingClickAnimation(false)
	self.viewContainer:setVisibleInternal(false)
end

function EliminateMapView:onGameLoadDone()
	self.viewContainer:setVisibleInternal(false)
end

function EliminateMapView:onClose()
	TaskDispatcher.cancelTask(self.refreshPath, self)
	TaskDispatcher.cancelTask(self.startPathAnimation, self)
	TaskDispatcher.cancelTask(self._doEnterEpisode, self)
	TaskDispatcher.cancelTask(self._refreshNodyByUpdateEpisodeInfo, self)
	TaskDispatcher.cancelTask(self._endBlock, self)
	self:_endBlock()

	if self._pathTweenId then
		ZProj.TweenHelper.KillById(self._pathTweenId)

		self._pathTweenId = nil
	end
end

function EliminateMapView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

return EliminateMapView
