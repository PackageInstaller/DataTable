-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianMapView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapView", package.seeall)

local YaXianMapView = class("YaXianMapView", BaseView)

function YaXianMapView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "map/#simage_bg")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "window/bottom/#simage_bottom")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianMapView:addEvents()
	return
end

function YaXianMapView:removeEvents()
	return
end

YaXianMapView.MapMaxOffsetX = 150
YaXianMapView.AnimationDuration = 1

function YaXianMapView:_editableInitView()
	self.goChapterNodeList = {}
	self.nodeItemDict = {}

	for i = 1, 3 do
		table.insert(self.goChapterNodeList, gohelper.findChild(self.viewGO, "map/chapter" .. i))
	end

	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnUpdateEpisodeInfo, self.onUpdateEpisodeInfo, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)

	local path = self.viewContainer:getSetting().otherRes[1]

	self.aniCurveConfig = self.viewContainer._abLoader:getAssetItem(path):GetResource()
	self.animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self._simagebottom:LoadImage(ResUrl.getYaXianImage("img_quyu_bg"))
end

function YaXianMapView:onUpdateParam()
	return
end

function YaXianMapView:onOpen()
	self.chapterId = self.viewContainer.chapterId
	self.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(self.chapterId)

	self:initMat()
	self:setMapPos()
	self:refreshUI()
	self:refreshPath()
end

function YaXianMapView:initMat()
	local chapterGo = self.goChapterNodeList[self.chapterId]
	local matGo = gohelper.findChild(chapterGo, "lujinganim/luxian")

	self.mat = matGo:GetComponent(typeof(UnityEngine.UI.Graphic)).material
end

function YaXianMapView:setMapPos()
	if self.chapterId ~= 1 then
		recthelper.setAnchorX(self._simagebg.transform, 0)
		recthelper.setAnchorX(self.goChapterNodeList[1].transform, 0)

		return
	end

	local minRate = SettingsModel.instance:getScreenSizeMinRate()
	local maxRate = SettingsModel.instance:getScreenSizeMaxRate()
	local gameScreenState = GameGlobalMgr.instance:getScreenState()
	local width, height = gameScreenState:getScreenSize()
	local currentRate = width / height
	local offset = (1 - (currentRate - minRate) / (maxRate - minRate)) * YaXianMapView.MapMaxOffsetX

	recthelper.setAnchorX(self._simagebg.transform, -offset)
	recthelper.setAnchorX(self.goChapterNodeList[1].transform, -offset)
end

function YaXianMapView:refreshUI()
	self:refreshBg()
	self:refreshNode()
end

function YaXianMapView:refreshBg()
	self._simagebg:LoadImage(ResUrl.getYaXianImage("img_map_" .. string.format("%02d", self.chapterId)))

	for i = 1, 3 do
		gohelper.setActive(self.goChapterNodeList[i], i == self.chapterId)
	end
end

function YaXianMapView:refreshNode()
	local episodeList = YaXianModel.instance:getEpisodeList(self.chapterId)
	local nodeItem

	for _, episodeMo in ipairs(episodeList) do
		nodeItem = self.nodeItemDict[episodeMo.id] or self:createNodeItem(episodeMo)

		self:refreshNodeItem(nodeItem)
	end
end

function YaXianMapView:createNodeItem(episodeMo)
	local nodeItem = self:getUserDataTb_()

	nodeItem.episodeMo = episodeMo
	nodeItem.go = gohelper.findChild(self.goChapterNodeList[self.chapterId], "node" .. episodeMo.id)
	nodeItem.goPath = gohelper.findChild(nodeItem.go, "xian")
	nodeItem.txtNodeIndex = gohelper.findChildText(nodeItem.go, "info/txtnodenum/#txt_node_num")
	nodeItem.txtNodeName = gohelper.findChildText(nodeItem.go, "info/#txt_node_name")
	nodeItem.goToothItem = gohelper.findChild(nodeItem.go, "info/bg/node/teeth/tooth")
	nodeItem.click = gohelper.findChildClick(nodeItem.go, "info/clickarea")
	nodeItem.goSelect = gohelper.findChildClick(nodeItem.go, "#icon")

	gohelper.setActive(nodeItem.goToothItem, false)
	gohelper.setActive(nodeItem.goSelect, false)

	nodeItem.toothList = {}

	for i = 1, 3 do
		table.insert(nodeItem.toothList, self:createToothItem(nodeItem.goToothItem))
	end

	nodeItem.click:AddClickListener(self.onClickEpisodeNode, self, nodeItem)

	self.nodeItemDict[episodeMo.id] = nodeItem

	return nodeItem
end

function YaXianMapView:createToothItem(goToothItem)
	local toothItem = self:getUserDataTb_()

	toothItem.go = gohelper.cloneInPlace(goToothItem)
	toothItem.goGet = gohelper.findChild(toothItem.go, "#go_get")
	toothItem.goLock = gohelper.findChild(toothItem.go, "#go_lock")

	gohelper.setActive(toothItem.go, true)

	return toothItem
end

function YaXianMapView:refreshNodeItem(nodeItem)
	if nodeItem.episodeMo.star == 0 and nodeItem.episodeMo.id ~= self.lastCanFightEpisodeMo.id then
		gohelper.setActive(nodeItem.go, false)

		return
	end

	local isLastCanFightEpisode = nodeItem.episodeMo.id == self.lastCanFightEpisodeMo.id

	if isLastCanFightEpisode then
		gohelper.setActive(nodeItem.go, YaXianModel.instance:isFirstEpisode(nodeItem.episodeMo.id) or self:isPlayedPathAnimation())
	else
		gohelper.setActive(nodeItem.go, true)
	end

	gohelper.setActive(nodeItem.goSelect, isLastCanFightEpisode)

	nodeItem.txtNodeIndex.text = nodeItem.episodeMo.config.index
	nodeItem.txtNodeName.text = nodeItem.episodeMo.config.name

	self:refreshNodeItemStar(nodeItem)

	if nodeItem.episodeMo.id == self.lastCanFightEpisodeMo.id then
		gohelper.setActive(nodeItem.goPath, false)
	else
		gohelper.setActive(nodeItem.goPath, true)
	end
end

function YaXianMapView:refreshNodeItemStar(nodeItem)
	local condition = nodeItem.episodeMo.config.extStarCondition
	local maxStar = 1

	if not string.nilorempty(condition) then
		maxStar = maxStar + #string.split(condition, "|")
	end

	for i = 1, maxStar do
		gohelper.setActive(nodeItem.toothList[i].go, true)
		gohelper.setActive(nodeItem.toothList[i].goGet, i <= nodeItem.episodeMo.star)
		gohelper.setActive(nodeItem.toothList[i].goLock, i > nodeItem.episodeMo.star)
	end

	for i = maxStar + 1, 3 do
		gohelper.setActive(nodeItem.toothList[i].go, false)
	end
end

function YaXianMapView:refreshPath()
	if YaXianModel.instance:isFirstEpisode(self.lastCanFightEpisodeMo.id) then
		if self.lastCanFightEpisodeMo.config then
			if not self.lastCanFightEpisodeMo.config.aniPos then
				do
					local targetAniPos = 0

					self:setMatValue(targetAniPos)

					return
				end

				local targetEpisodeConfig = self.lastCanFightEpisodeMo.config

				if not targetEpisodeConfig.aniPos then
					if self:checkNeedPlayAnimation() then
						local nodeItem = self.nodeItemDict[targetEpisodeConfig.id]

						gohelper.setActive(nodeItem.go, false)

						local srcEpisodeConfig = YaXianConfig.instance:getPreEpisodeConfig(targetEpisodeConfig.activityId, targetEpisodeConfig.id)

						if srcEpisodeConfig then
							if not srcEpisodeConfig.aniPos then
								local srcAniPos = 0

								self:setMatValue(srcAniPos)
								TaskDispatcher.runDelay(self.startPathAnimation, self, 0.667)

								return
							end
						end
					end

					self:setMatValue(targetEpisodeConfig.aniPos)
				end
			end
		end
	end
end

function YaXianMapView:checkNeedPlayAnimation()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return false
	end

	if YaXianModel.instance:isFirstEpisode(self.lastCanFightEpisodeMo.id) then
		return false
	end

	return not self:isPlayedPathAnimation()
end

function YaXianMapView:isPlayedPathAnimation()
	self:initPlayedPathAnimationEpisodeList()

	if tabletool.indexOf(self.playedEpisodeIdList, self.lastCanFightEpisodeMo.id) then
		return true
	end

	return false
end

function YaXianMapView:initPlayedPathAnimationEpisodeList()
	if self.playedEpisodeIdList then
		return
	end

	local str = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianEpisodePathAnimationKey), "")

	if string.nilorempty(str) then
		self.playedEpisodeIdList = {}

		return
	end

	self.playedEpisodeIdList = string.splitToNumber(str, ";")
end

function YaXianMapView:playedPathAnimation(episodeId)
	if tabletool.indexOf(self.playedEpisodeIdList, episodeId) then
		return
	end

	table.insert(self.playedEpisodeIdList, episodeId)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianEpisodePathAnimationKey), table.concat(self.playedEpisodeIdList, ";"))
end

function YaXianMapView:startPathAnimation()
	local targetEpisodeConfig = self.lastCanFightEpisodeMo.config

	if not targetEpisodeConfig.aniPos then
		local targetAniPos = 0
		local srcEpisodeConfig = YaXianConfig.instance:getPreEpisodeConfig(targetEpisodeConfig.activityId, targetEpisodeConfig.id)

		if srcEpisodeConfig then
			if not srcEpisodeConfig.aniPos then
				local srcAniPos = 0

				if srcAniPos == targetAniPos then
					self:setMatValue(srcAniPos)

					return
				end

				TaskDispatcher.cancelTask(self._onFrame, self)

				self.startTime = Time.time
				self.srcAniPos = srcAniPos
				self.targetAniPos = targetAniPos

				TaskDispatcher.runRepeat(self._onFrame, self, 0.001)
			end
		end
	end
end

function YaXianMapView:_onFrame()
	local runTime = Time.time - self.startTime

	if runTime >= YaXianMapView.AnimationDuration then
		self:onPathAnimationDone()

		return
	end

	local x = runTime / YaXianMapView.AnimationDuration
	local y = self.aniCurveConfig:GetY(x)

	self:setMatValue(Mathf.Lerp(self.srcAniPos, self.targetAniPos, y))
end

function YaXianMapView:onPathAnimationDone()
	TaskDispatcher.cancelTask(self._onFrame, self)
	self:setMatValue(self.targetAniPos)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

	local nodeItem = self.nodeItemDict[self.lastCanFightEpisodeMo.id]

	gohelper.setActive(nodeItem.go, true)
	self:playedPathAnimation(self.lastCanFightEpisodeMo.id)
end

function YaXianMapView:setMatValue(value)
	self.mat:SetTextureOffset("_Mask", Vector2.New(value, 0))
end

YaXianMapView.EnterGameKey = "EnterYaXianGameKey"

function YaXianMapView:onClickEpisodeNode(nodeItem)
	UIBlockMgr.instance:startBlock(YaXianMapView.EnterGameKey)

	local episodeCo = nodeItem.episodeMo.config

	self:_enterChessGame(episodeCo.id)
	YaXianModel.instance:setPlayingClickAnimation(true)
	self.animator:Play("click", self.onClickAnimationDone, self)
end

function YaXianMapView:_enterChessGame(episodeId)
	YaXianGameController.instance:enterChessGame(episodeId)
end

function YaXianMapView:onSelectChapterChange()
	self.chapterId = self.viewContainer.chapterId
	self.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(self.chapterId)

	self:setMapPos()
	self:refreshUI()
	self:refreshPath()
end

function YaXianMapView:onUpdateEpisodeInfo()
	self.lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo(self.chapterId)

	self:refreshNode()

	if self.lastCanFightEpisodeMo.chapterId == self.chapterId then
		self:refreshPath()
	end
end

function YaXianMapView:_onScreenSizeChange()
	self:setMapPos()
end

function YaXianMapView:_onCloseViewFinish(viewName)
	if viewName == ViewName.YaXianGameView then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
		self.animator:Play("out")
	end

	self:refreshPath()
end

function YaXianMapView:onClickAnimationDone()
	UIBlockMgr.instance:endBlock(YaXianMapView.EnterGameKey)
	YaXianModel.instance:setPlayingClickAnimation(false)
	self.viewContainer:setVisibleInternal(false)
end

function YaXianMapView:onGameLoadDone()
	self.viewContainer:setVisibleInternal(false)
end

function YaXianMapView:onClose()
	TaskDispatcher.cancelTask(self._onFrame, self)
	TaskDispatcher.cancelTask(self.startPathAnimation, self)
end

function YaXianMapView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagebottom:UnLoadImage()

	for _, nodeItem in pairs(self.nodeItemDict) do
		nodeItem.click:RemoveClickListener()
	end
end

return YaXianMapView
