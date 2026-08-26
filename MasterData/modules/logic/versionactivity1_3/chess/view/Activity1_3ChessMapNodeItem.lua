-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessMapNodeItem.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapNodeItem", package.seeall)

local Activity1_3ChessMapNodeItem = class("Activity1_3ChessMapNodeItem", LuaCompBase)

Activity1_3ChessMapNodeItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_mapviewstageitem.prefab"

local nodeItemState = {
	open = 2,
	passIncompletly = 3,
	lock = 1,
	pass = 4
}
local unLockNodeColor = "#E3C479"
local lockNodeColor = "#FFFFFF"

function Activity1_3ChessMapNodeItem:init(go)
	self._go = go
	self._goRoot = gohelper.findChild(go, "Root")
	self._imagePoint = gohelper.findChildImage(go, "Root/#image_Point")
	self._imageStageFinishedBG = gohelper.findChildImage(go, "Root/unlock/#image_StageFinishedBG")
	self._txtStageName = gohelper.findChildText(go, "Root/unlock/Info/#txt_StageName")
	self._txtStageNum = gohelper.findChildText(go, "Root/unlock/Info/#txt_StageName/#txt_StageNum")
	self._imageNoStar = gohelper.findChildImage(go, "Root/unlock/Info/#txt_StageName/#image_NoStar")
	self._imageHasStar = gohelper.findChildImage(go, "Root/unlock/Info/#txt_StageName/#image_Star")
	self._btnClick = gohelper.findChildClick(go, "Root/unlock/#btn_Click")
	self._btnReview = gohelper.findChildButtonWithAudio(go, "Root/unlock/Info/#txt_StageName/#btn_Review")
	self._goUnLock = gohelper.findChild(go, "Root/unlock")
	self._goChess = gohelper.findChild(go, "Root/unlock/image_chess")

	local gochessAni = gohelper.findChild(go, "Root/unlock/image_chess/ani")
	local animatorType = typeof(UnityEngine.Animator)

	self._nodeItemAnimator = go:GetComponent(animatorType)
	self._chessAnimator = gochessAni:GetComponent(animatorType)
end

function Activity1_3ChessMapNodeItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function Activity1_3ChessMapNodeItem:removeEventListeners()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
		self._btnReview:RemoveClickListener()
	end
end

function Activity1_3ChessMapNodeItem:_btnClickOnClick()
	if not self._config then
		return
	end

	if not self._clickCallback then
		return
	end

	self._clickCallback(self._clickCbObj, self._config.id)
end

function Activity1_3ChessMapNodeItem:_btnReviewOnClick()
	if self._config then
		Activity1_3ChessController.instance:openStoryView(self._config.id)
	end
end

function Activity1_3ChessMapNodeItem:onUpdateMO(mo)
	return
end

function Activity1_3ChessMapNodeItem:onSelect(isSelect)
	return
end

function Activity1_3ChessMapNodeItem:setCfg(cfg)
	self._config = cfg
	self._isLock = true
end

function Activity1_3ChessMapNodeItem:setClickCallback(callback, obj)
	self._clickCallback = callback
	self._clickCbObj = obj
end

function Activity1_3ChessMapNodeItem:_checkNodeItemState()
	local episodeData = Activity122Model.instance:getEpisodeData(self._config.id)

	if episodeData then
		if episodeData.star == 2 then
			return nodeItemState.pass
		elseif episodeData.star == 1 then
			return nodeItemState.passIncompletly
		else
			return nodeItemState.open
		end
	end

	if self._config.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(self._config.preEpisode) and Activity1_3ChessController.isOpenDay(self._config.id) then
		return nodeItemState.open
	else
		return nodeItemState.lock
	end
end

function Activity1_3ChessMapNodeItem:refreshUI()
	if not self._config then
		gohelper.setActive(self._goRoot, false)

		return
	end

	gohelper.setActive(self._goRoot, true)

	local nodeState = self:_checkNodeItemState()

	self:_refreshNodeStateView(nodeState)

	self._txtStageName.text = self._config.name
	self._txtStageNum.text = self._config.orderId

	self:_refreshChess()
end

function Activity1_3ChessMapNodeItem:_refreshNodeStateView(state)
	if self._nodeStateViewAction == nil then
		self._nodeStateViewAction = {
			[nodeItemState.lock] = self._lockUI,
			[nodeItemState.open] = self._unLockUI,
			[nodeItemState.passIncompletly] = self._refreshPassIncompletlyView,
			[nodeItemState.pass] = self._refreshPassView
		}
	end

	self._nodeStateViewAction[state](self)
	UISpriteSetMgr.instance:setActivity1_3ChessSprite(self._imagePoint, self:_getNodePointSprite(state))

	if state == nodeItemState.lock then
		return
	end

	local playerCacheData = Activity122Model.instance:getPlayerCacheData()
	local needShowUnlockAni = state == nodeItemState.open and not playerCacheData["isEpisodeUnlock_" .. self._config.id]
	local needShowPassAni = (state == nodeItemState.pass or state == nodeItemState.passIncompletly) and not playerCacheData["isEpisodePass_" .. self._config.id]

	if needShowPassAni then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.SetNodePathEffectToPassNode)
		self:delayPlayNodePassAni(0.8)
	end

	if needShowUnlockAni then
		gohelper.setActive(self._goRoot, false)
		self:delayPlayNodeUnlockAni(1.5)
	end
end

function Activity1_3ChessMapNodeItem:_getNodePointSprite(state, forceSelect)
	if self._nodeState2SpriteMap == nil then
		self._nodeState2SpriteMap = {
			[nodeItemState.lock] = JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished,
			[nodeItemState.open] = Activity1_3ChessEnum.SpriteName.NodeUnFinished,
			[nodeItemState.passIncompletly] = Activity1_3ChessEnum.SpriteName.NodeFinished,
			[nodeItemState.pass] = Activity1_3ChessEnum.SpriteName.NodeFinished
		}
	end

	local spriteName = self._nodeState2SpriteMap[state]
	local lastEpisodeId = Activity122Model.instance:getCurEpisodeId()

	spriteName = (forceSelect ~= nil or nil) and forceSelect and Activity1_3ChessEnum.SpriteName.NodeCurrent or spriteName

	return spriteName
end

function Activity1_3ChessMapNodeItem:_refreshPassView()
	gohelper.setActive(self._goUnLock, true)
	gohelper.setActive(self._btnReview.gameObject, true)
	gohelper.setActive(self._imageStageFinishedBG, true)
	SLFramework.UGUI.GuiHelper.SetColor(self._imagePoint, unLockNodeColor)
	self:_refreshStarState(true)
end

function Activity1_3ChessMapNodeItem:_refreshPassIncompletlyView()
	gohelper.setActive(self._goUnLock, true)
	gohelper.setActive(self._imageStageFinishedBG, true)
	gohelper.setActive(self._btnReview.gameObject, true)
	SLFramework.UGUI.GuiHelper.SetColor(self._imagePoint, unLockNodeColor)
	self:_refreshStarState(false)
end

function Activity1_3ChessMapNodeItem:_lockUI()
	gohelper.setActive(self._goUnLock, false)
	gohelper.setActive(self._btnReview.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(self._imagePoint, lockNodeColor)
end

function Activity1_3ChessMapNodeItem:_unLockUI()
	gohelper.setActive(self._goUnLock, true)
	gohelper.setActive(self._imageStageFinishedBG, false)
	gohelper.setActive(self._btnReview.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(self._imagePoint, unLockNodeColor)
	self:_refreshStarState(false)
end

function Activity1_3ChessMapNodeItem:_refreshStarState(star)
	gohelper.setActive(self._imageNoStar.gameObject, not star)
	gohelper.setActive(self._imageHasStar.gameObject, star)
end

function Activity1_3ChessMapNodeItem:_refreshChess()
	local lastEpisodeId = Activity122Model.instance:getCurEpisodeId()

	if lastEpisodeId == 0 then
		gohelper.setActive(self._goChess, self._config.id == 1)
	else
		gohelper.setActive(self._goChess, self._config.id == lastEpisodeId)
	end
end

function Activity1_3ChessMapNodeItem:delayPlayNodePassAni(delay)
	self._nodeStateViewAction[nodeItemState.open](self)

	delay = delay or 0.5

	TaskDispatcher.runDelay(self.playNodePassAni, self, delay)
end

function Activity1_3ChessMapNodeItem:delayPlayNodeUnlockAni(delay)
	gohelper.setActive(self._goRoot, false)

	delay = delay or 0.5

	TaskDispatcher.runDelay(self.playNodeUnlockAni, self, delay)
end

function Activity1_3ChessMapNodeItem:playNodePassAni()
	local playerCacheData = Activity122Model.instance:getPlayerCacheData()

	playerCacheData["isEpisodePass_" .. self._config.id] = true

	Activity122Model.instance:saveCacheData()
	gohelper.setActive(self._imageStageFinishedBG.gameObject, true)

	local nodeState = self:_checkNodeItemState()

	self:_refreshStarState(nodeState == nodeItemState.pass)
	self._nodeItemAnimator:Play("finish")
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ShowPassEpisodeEffect)
	TaskDispatcher.runDelay(self.refreshUI, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)
end

function Activity1_3ChessMapNodeItem:playNodeUnlockAni()
	local playerCacheData = Activity122Model.instance:getPlayerCacheData()

	playerCacheData["isEpisodeUnlock_" .. self._config.id] = true

	Activity122Model.instance:saveCacheData()
	gohelper.setActive(self._goRoot, true)
	self._nodeItemAnimator:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NewEpisodeUnlock)
end

function Activity1_3ChessMapNodeItem:playAppearAni(fromId)
	gohelper.setActive(self._goChess, true)

	local curId = Activity122Model.instance:getCurEpisodeId()
	local aniName = fromId < self._config.id and "open_right" or "open_left"

	self._chessAnimator:Play(aniName)

	local nodeState = self:_checkNodeItemState()

	UISpriteSetMgr.instance:setActivity1_3ChessSprite(self._imagePoint, self:_getNodePointSprite(nodeState, true))
end

function Activity1_3ChessMapNodeItem:playDisAppearAni(targetId)
	gohelper.setActive(self._goChess, true)

	local curId = Activity122Model.instance:getCurEpisodeId()
	local aniName = targetId > self._config.id and "close_right" or "close_left"

	self._chessAnimator:Play(aniName)

	local nodeState = self:_checkNodeItemState()

	UISpriteSetMgr.instance:setActivity1_3ChessSprite(self._imagePoint, self:_getNodePointSprite(nodeState, false))
end

function Activity1_3ChessMapNodeItem:onDestroyView()
	self._clickCallback = nil
	self._clickCbObj = nil

	self:removeEventListeners()
	TaskDispatcher.cancelTask(self.playNodePassAni, self)
	TaskDispatcher.cancelTask(self.playNodeUnlockAni, self)
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

return Activity1_3ChessMapNodeItem
