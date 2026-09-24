-- chunkname: @modules/logic/matchgame/outside/map/MatchGameLevelView.lua

module("modules.logic.matchgame.outside.map.MatchGameLevelView", package.seeall)

local MatchGameLevelView = class("MatchGameLevelView", BaseView)

function MatchGameLevelView:onInitView()
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goMapContent = gohelper.findChild(self.viewGO, "#go_MapContent")
	self._goLineRoot = gohelper.findChild(self.viewGO, "#go_MapContent/#go_LineRoot")
	self._goEpisodeRoot = gohelper.findChild(self.viewGO, "#go_MapContent/#go_EpisodeRoot")
	self._goPathList = gohelper.findChild(self.viewGO, "#go_MapContent/#go_PathList")
	self._goLevelItem = gohelper.findChild(self.viewGO, "#go_MapContent/#go_EpisodeRoot/#go_LevelItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameLevelView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnClickSelectMap, self._onClickSelectMap, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateEpisodeInfo, self._onUpdateEpisodeInfo, self)
end

function MatchGameLevelView:removeEvents()
	return
end

function MatchGameLevelView:_editableInitView()
	gohelper.setActive(self._goLevelItem, false)

	self._episodeItems = self:getUserDataTb_()
	self._allPathAnimTab = self:getUserDataTb_()
	self._allStageRootTab = self:getUserDataTb_()
	self._allMapItemTab = self:getUserDataTb_()
	self._viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._ignoreViewList = {
		ViewName.ToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	}
end

function MatchGameLevelView:onOpen()
	self:_initLevelItems()
end

function MatchGameLevelView:_initLevelItems()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)

	self._chapterId = MatchGameLevelModel.instance:getCurChapterId()
	self._chapterCo = lua_activity244_chapter.configDict[self._chapterId]

	local episodeCos = MatchGameLevelModel.instance:getCurEpisodeCos()

	self._curEpisodeIndex = MatchGameLevelModel.instance:getCurEpisodeIndex()

	self:_initPathItems()

	for i = 1, #episodeCos do
		local episodeItem = self:getOrCreateEpisodeItem(i)

		if self._allStageRootTab[self._chapterId] then
			local goStageFlag = self._allStageRootTab[self._chapterId][i]
			local episodePosX, episodePosY = recthelper.getAnchor(goStageFlag.transform)

			episodeItem:setParam(episodeCos[i], i, episodePosX, episodePosY)

			local isPass = MatchGameLevelModel.instance:isEpisodePass(episodeCos[i].id)

			self:_playPathAnim(i, isPass and "idle2" or "idle1")
		end
	end

	for i = #episodeCos + 1, #self._episodeItems do
		local episodeItem = self._episodeItems[i]

		gohelper.setActive(episodeItem.viewGO, false)
	end

	if self._chapterCo then
		self._simageBg:LoadImage(ResUrl.getMatchGameSingleBg(self._chapterCo))
	end
end

function MatchGameLevelView:_initPathItems()
	local pathAnimTab = self._allPathAnimTab[self._chapterId]

	if not pathAnimTab then
		local chapterIndex = MatchGameLevelModel.instance:getCurChapterIndex()
		local resPath = string.format("%s%s.prefab", MatchGameEnum.NormalEpisodeItemPrefabPath, chapterIndex)
		local goPathContainer = self:getResInst(resPath, self._goLineRoot, "path_" .. self._chapterId)

		pathAnimTab = self:_initPathAnim(goPathContainer)
		self._allPathAnimTab[self._chapterId] = pathAnimTab
		self._allStageRootTab[self._chapterId] = self:_initEpisodeRoot(goPathContainer)
		self._allMapItemTab[self._chapterId] = goPathContainer
	end

	self._pathAnimTab = pathAnimTab

	for chapterId, goMap in pairs(self._allMapItemTab) do
		gohelper.setActive(goMap, chapterId == self._chapterId)
	end
end

function MatchGameLevelView:_initPathAnim(goContainer)
	local pathAnimTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goPath = gohelper.findChild(goContainer, "#go_PathList/#go_Path_" .. i)

		if gohelper.isNil(goPath) then
			break
		end

		pathAnimTab[i] = gohelper.onceAddComponent(goPath, gohelper.Type_Animator)
	end

	return pathAnimTab
end

function MatchGameLevelView:_initEpisodeRoot(goContainer)
	local episodeRootTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goEpisode = gohelper.findChild(goContainer, "#go_Stage_" .. i)

		if gohelper.isNil(goEpisode) then
			break
		end

		episodeRootTab[i] = goEpisode
	end

	return episodeRootTab
end

function MatchGameLevelView:getOrCreateEpisodeItem(index)
	self._episodeItems = self._episodeItems or {}

	local episodeItem = self._episodeItems[index]

	if not episodeItem then
		local stageName = "#go_Stage_" .. index

		if self._allStageRootTab[self._chapterId] then
			local goStage = self._allStageRootTab[self._chapterId][index]

			if gohelper.isNil(self._allStageRootTab[self._chapterId]) then
				logError(string.format("消消乐地图缺少关卡挂点 chapterId = %s, index = %s", self._chapterId, index))

				goStage = gohelper.create2d(self._goMapContent, stageName)
			end

			local cloneGo = gohelper.cloneInPlace(self._goLevelItem, "#go_Level_" .. index)

			episodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, MatchGameMapLevelItem, self)
			self._episodeItems[index] = episodeItem

			gohelper.setActive(cloneGo, true)
		end
	end

	return episodeItem
end

function MatchGameLevelView:_onClickSelectMap()
	self:_initLevelItems()
end

function MatchGameLevelView:_onCloseView(viewName)
	if viewName == self.viewName then
		self._needPlayNewFinishAnim = false

		return
	end

	local newEpisode = MatchGameLevelModel.instance:getNewFinishEpisode()
	local newEpisodeCo = newEpisode and lua_activity244_episode.configDict[newEpisode]

	if not newEpisodeCo or newEpisodeCo.chapterId ~= self._chapterId then
		self._needPlayNewFinishAnim = false

		MatchGameLevelModel.instance:clearFinishEpisode()

		return
	end

	self:_initFinishEpisodeState()

	self._needPlayNewFinishAnim = true
end

function MatchGameLevelView:_onCloseViewFinish(viewName)
	if not self._needPlayNewFinishAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, self._ignoreViewList) then
		return
	end

	self._needPlayNewFinishAnim = false

	GameUtil.setActiveUIBlock(self.viewName, true, false)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
end

function MatchGameLevelView:_initFinishEpisodeState()
	local newEpisode = MatchGameLevelModel.instance:getNewFinishEpisode()

	for k, episodeItem in ipairs(self._episodeItems) do
		if episodeItem:getEpisodeId() == newEpisode then
			self._finishEpisodeIndex = k

			break
		else
			episodeItem:refreshUI()
			self:_playPathAnim(k, "idle2")
		end
	end
end

function MatchGameLevelView:_playStoryFinishAnim()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	if self._finishEpisodeIndex then
		if self._finishEpisodeIndex then
			self._finishEpisodeIndex:refreshUI()
			self._finishEpisodeIndex:playFinish()
			GameUtil.setActiveUIBlock(self.viewName, true, false)
			TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)
		end

		MatchGameLevelModel.instance:clearFinishEpisode()
	end
end

function MatchGameLevelView:_finishStoryEnd()
	GameUtil.setActiveUIBlock(self.viewName, false, true)

	if self._finishEpisodeIndex == #self._episodeItems then
		self:_onFinishChapterLastEpisode()
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_playPathAnim(self._finishEpisodeIndex, "move")
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function MatchGameLevelView:_onFinishChapterLastEpisode()
	local finishEpisodeItem = self._episodeItems[self._finishEpisodeIndex]
	local finishEpisodeId = finishEpisodeItem and finishEpisodeItem:getEpisodeId()
	local finishEpisodeCo = lua_activity244_episode.configDict[finishEpisodeId]
	local nextEpisodeCo = MatchGameConfig.instance:getNextEpisodeConfig(finishEpisodeId)
	local nextChapterId = nextEpisodeCo and nextEpisodeCo.chapterId

	if nextChapterId and nextChapterId ~= finishEpisodeCo.chapterId and MatchGameLevelModel.instance:isEpisodeUnlock(nextEpisodeCo.id) then
		self._curEpisodeIndex = 1
		self._finishEpisodeIndex = 0

		MatchGameController.instance:dispatchEvent(MatchGameEvent.PlaySwitchMapAnim, nextChapterId)
	else
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = 0
	end
end

function MatchGameLevelView:_playPathAnim(episodeIndex, animName)
	if not episodeIndex or string.nilorempty(animName) then
		return
	end

	if self._pathAnimTab then
		local animPath = self._pathAnimTab[episodeIndex]

		if not animPath then
			return
		end

		gohelper.setActive(animPath.gameObject, true)
		animPath:Play(animName, 0, 0)

		local goUnlockLine = gohelper.findChildImage(animPath.gameObject, "unlock")
		local goLockLine = gohelper.findChildImage(animPath.gameObject, "lock")

		gohelper.setActive(goUnlockLine, false)
		gohelper.setActive(goLockLine, false)

		if animName == "idle2" then
			gohelper.setActive(goUnlockLine, true)
		elseif animName == "move" then
			gohelper.setActive(goUnlockLine, true)
		else
			gohelper.setActive(goLockLine, true)
		end
	end
end

function MatchGameLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)

	local unlockEpisodeItem = self._episodeItems[self._finishEpisodeIndex + 1]
	local unlockEpisodeId = unlockEpisodeItem:getEpisodeId()

	MatchGameLevelModel.instance:switchEpisode(unlockEpisodeId)
	unlockEpisodeItem:refreshUI()
	unlockEpisodeItem:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function MatchGameLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function MatchGameLevelView:_onUpdateEpisodeInfo()
	local newEpisode = MatchGameLevelModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		return
	end

	self:_initLevelItems()
end

function MatchGameLevelView:onClose()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	GameUtil.setActiveUIBlock(self.viewName, false, true)
end

function MatchGameLevelView:onDestroyView()
	self._episodeItems = nil

	self._simageBg:UnLoadImage()
end

return MatchGameLevelView
