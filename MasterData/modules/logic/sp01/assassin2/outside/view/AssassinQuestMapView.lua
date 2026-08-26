-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestMapView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapView", package.seeall)

local AssassinQuestMapView = class("AssassinQuestMapView", BaseViewExtended)

function AssassinQuestMapView:onInitView()
	self._godrag = gohelper.findChild(self.viewGO, "root/#go_drag")
	self._gomap = gohelper.findChild(self.viewGO, "root/#go_drag/simage_fullbg")
	self._gobg = gohelper.findChild(self.viewGO, "root/#go_drag/simage_fullbg/#go_bg")
	self._goquestItem = gohelper.findChild(self.viewGO, "root/#go_drag/simage_fullbg/#go_container/#go_questItem")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/left/info/#txt_title")
	self._txtprogress = gohelper.findChildText(self.viewGO, "root/left/info/#txt_progress")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "root/left/info/#slider_progress")
	self._goquestInfo = gohelper.findChild(self.viewGO, "root/left/info/#go_questInfo")
	self._goquestInfoItem = gohelper.findChild(self.viewGO, "root/left/info/#go_questInfo/#go_questInfoItem")
	self._btnmanor = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_manor", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gomanorreddot = gohelper.findChild(self.viewGO, "root/left/#btn_manor/go_manorreddot")
	self._btndevelop = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_develop", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_task", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/right/#btn_task/#go_taskreddot")
	self._btnlibrary = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_library", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._golibraryreddot = gohelper.findChild(self.viewGO, "root/right/#btn_library/#go_libraryreddot")
	self._goarrow = gohelper.findChild(self.viewGO, "root/#go_arrow")
	self._gotopright = gohelper.findChild(self.viewGO, "root/#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinQuestMapView:addEvents()
	self._btnmanor:AddClickListener(self._btnmanorOnClick, self)
	self._btndevelop:AddClickListener(self._btndevelopOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnlibrary:AddClickListener(self._btnlibraryOnClick, self)
	self._drag:AddDragBeginListener(self._onBeginDragMap, self)
	self._drag:AddDragListener(self._onDragMap, self)
	self._drag:AddDragEndListener(self._onEndDragMap, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnClickQuestItem, self._onClickQuestItem, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnFinishQuest, self._onFinishQuest, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnUnlockQuestContent, self._onUnlockQuestContent, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.refreshUI, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self.refreshUI, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UnlockBuildings, self.refreshUI, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.refreshLibraryRedDot, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function AssassinQuestMapView:removeEvents()
	self._btnmanor:RemoveClickListener()
	self._btndevelop:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnlibrary:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnClickQuestItem, self._onClickQuestItem, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnFinishQuest, self._onFinishQuest, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnUnlockQuestContent, self._onUnlockQuestContent, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.refreshUI, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self.refreshUI, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.UnlockBuildings, self.refreshUI, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.refreshLibraryRedDot, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function AssassinQuestMapView:_btnmanorOnClick()
	AssassinController.instance:openAssassinBuildingMapView()
end

function AssassinQuestMapView:_btndevelopOnClick()
	AssassinController.instance:openAssassinHeroView()
end

function AssassinQuestMapView:_btntaskOnClick()
	AssassinController.instance:openAssassinTaskView()
end

function AssassinQuestMapView:_btnlibraryOnClick()
	AssassinController.instance:openAssassinLibraryView()
end

function AssassinQuestMapView:_onBeginDragMap(param, pointerEventData)
	self._startDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._transdrag)
	self._startMapPosX, self._startMapPosY = transformhelper.getLocalPos(self._transmap)
end

function AssassinQuestMapView:_onDragMap(param, pointerEventData)
	if not self._startDragPos then
		return
	end

	local endPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._transdrag)
	local deltaPos = endPos - self._startDragPos
	local targetX = self._startMapPosX + deltaPos.x
	local targetY = self._startMapPosY + deltaPos.y

	self:setMapPos(targetX, targetY)
	self:updateAllArrow()
end

function AssassinQuestMapView:_onEndDragMap(param, pointerEventData)
	self._startDragPos = nil
end

function AssassinQuestMapView:_onClickQuestItem(questId, fightReturn, isTween)
	local questItem = self._showQuestItemDict[questId]

	if not questItem then
		return
	end

	self._targetQuestId = questId
	self._fightReturn = fightReturn

	self:killTween()

	if isTween then
		local worldPos = questItem:getGoPosition()
		local pos = self._transmap:InverseTransformPoint(worldPos)

		self:tweenMapPos(-pos.x, -pos.y)
	else
		self:_focusQuestItemFinish()
	end
end

function AssassinQuestMapView:_focusQuestItemFinish()
	self:updateAllArrow()
	self:_enterAssassinStealthGame()
end

function AssassinQuestMapView:_enterAssassinStealthGame()
	if self._targetQuestId then
		local questItem = self._showQuestItemDict[self._targetQuestId]
		local worldPos = questItem and questItem:getGoPosition()

		AssassinController.instance:openAssassinQuestDetailView(self._targetQuestId, self._fightReturn, worldPos)
	end

	self._targetQuestId = nil
	self._fightReturn = nil
end

function AssassinQuestMapView:_onFinishQuest()
	self:initAllQuestItem()
	self:refreshUI()
end

function AssassinQuestMapView:_onUnlockQuestContent()
	self:initAllQuestItem()
	self:refreshUI()
end

function AssassinQuestMapView:_onCloseFullView(viewName)
	if viewName ~= self.viewName then
		self:updateAllArrow()
	end

	if viewName ~= ViewName.AssassinStealthGameView or viewName == self.viewName or not self.viewContainer._isVisible then
		return
	end

	self._animatorPlayer:Play(UIAnimationName.Open, self._afterOpenAnim, self)

	if self._showQuestItemDict then
		for _, questItem in pairs(self._showQuestItemDict) do
			questItem:playOpen()
		end
	end
end

function AssassinQuestMapView:_afterOpenAnim()
	self:checkPlayAnim()
	self:checkGuide()
end

function AssassinQuestMapView:_onCloseView(viewName)
	if viewName == self.viewName then
		return
	end

	self:checkPlayAnim()
	self:checkGuide()
end

function AssassinQuestMapView:_editableInitView()
	gohelper.setActive(self._goquestItem, false)

	self._questItemPool = {}
	self._transmap = self._gomap.transform

	self:calculateDragBorder()

	self._transdrag = self._godrag.transform
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.bgSimageList = self:getUserDataTb_()

	local temp = self._gobg:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage))
	local iter = temp and temp:GetEnumerator()

	if iter then
		while iter:MoveNext() do
			table.insert(self.bgSimageList, iter.Current)
		end
	end

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.AssassinOutsideTask)

	self._arrowList = self:getUserDataTb_()
end

function AssassinQuestMapView:onUpdateParam()
	self._mapId = self.viewParam.mapId

	self:setMapInfo()
	self:setQuestTypeInfoItems()
	self:initAllQuestItem()
end

function AssassinQuestMapView:onOpen()
	self._currencyToolView = self:openSubView(AssassinCurrencyToolView, nil, self._gotopright)

	self:onUpdateParam()
	self:refreshUI()

	local questId = self.viewParam.questId

	if questId then
		AssassinController.instance:clickQuestItem(questId, self.viewParam.fightReturnStealthGame)
	end
end

function AssassinQuestMapView:onOpenFinish()
	self:checkPlayAnim()
	self:checkGuide()
end

function AssassinQuestMapView:checkGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(AssassinEnum.StealthConst.QuestMapGuide)

	if isGuideFinish then
		return
	end

	local finishQuestIdList = AssassinOutsideModel.instance:getMapFinishQuestIdList(self._mapId)

	for _, questId in ipairs(finishQuestIdList) do
		local questType = AssassinConfig.instance:getQuestType(questId)

		if questType == AssassinEnum.QuestType.Stealth then
			AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TriggerGuideAfterFinishStealthGame)

			break
		end
	end
end

function AssassinQuestMapView:setMapInfo()
	self._txttitle.text = AssassinConfig.instance:getMapTitle(self._mapId)

	local bg = AssassinConfig.instance:getMapBg(self._mapId)

	if bg and self.bgSimageList then
		for i, bgSimage in ipairs(self.bgSimageList) do
			local bgPath = ResUrl.getSp01AssassinSingleBg(string.format("map/%s_%s", bg, i))

			bgSimage:LoadImage(bgPath)
		end
	end

	local x, y = AssassinConfig.instance:getMapCenterPos(self._mapId)

	transformhelper.setLocalPos(self._gobg.transform, x, y, 0)
end

function AssassinQuestMapView:setQuestTypeInfoItems()
	self._questTypeInfoItemList = {}

	local questTypeList = AssassinConfig.instance:getQuestTypeList()

	gohelper.CreateObjList(self, self._onCreateQuestTypeInfoItem, questTypeList, self._goquestInfo, self._goquestInfoItem)
end

function AssassinQuestMapView:_onCreateQuestTypeInfoItem(obj, questType, index)
	local questTypeInfoItem = self:getUserDataTb_()

	questTypeInfoItem.go = obj
	questTypeInfoItem.questType = questType
	questTypeInfoItem.imageicon = gohelper.findChildImage(obj, "image_icon")
	questTypeInfoItem.txttitle = gohelper.findChildText(obj, "txt_title")
	questTypeInfoItem.txtprogress = gohelper.findChildText(obj, "txt_progress")
	questTypeInfoItem.txttitle.text = AssassinConfig.instance:getQuestTypeName(questType)

	AssassinHelper.setQuestTypeIcon(questType, questTypeInfoItem.imageicon)

	self._questTypeInfoItemList[index] = questTypeInfoItem
end

function AssassinQuestMapView:calculateDragBorder()
	local transView = self.viewGO.transform
	local viewWidth = recthelper.getWidth(transView)
	local viewHeight = recthelper.getHeight(transView)
	local mapWidth = recthelper.getWidth(self._transmap)
	local mapHeight = recthelper.getHeight(self._transmap)

	self.maxOffsetX = (mapWidth - viewWidth) / 2
	self.maxOffsetY = (mapHeight - viewHeight) / 2
end

function AssassinQuestMapView:setMapPos(posX, posY)
	if not posX or not posY then
		posX, posY = transformhelper.getLocalPos(self._transmap)
	end

	posX = Mathf.Clamp(posX, -self.maxOffsetX, self.maxOffsetX)
	posY = Mathf.Clamp(posY, -self.maxOffsetY, self.maxOffsetY)

	transformhelper.setLocalPosXY(self._transmap, posX, posY)
end

function AssassinQuestMapView:tweenMapPos(posX, posY)
	if not posX or not posY then
		return
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.QuestMapTween, true)

	self._tweenStartPosX, self._tweenStartPosY = transformhelper.getLocalPos(self._transmap)
	self._tweenTargetPosX = Mathf.Clamp(posX, -self.maxOffsetX, self.maxOffsetX)
	self._tweenTargetPosY = Mathf.Clamp(posY, -self.maxOffsetY, self.maxOffsetY)

	local tweenTime = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.QuestMapTweenTime, true) or 0

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, tweenTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function AssassinQuestMapView:tweenFrameCallback(value)
	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self:setMapPos(x, y)
end

function AssassinQuestMapView:tweenFinishCallback()
	self:setMapPos(self._tweenTargetPosX, self._tweenTargetPosY)
	self:_focusQuestItemFinish()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.QuestMapTween, false)
end

function AssassinQuestMapView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self.tweenId = nil

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.QuestMapTween, false)
end

function AssassinQuestMapView:initAllQuestItem()
	self:clearAllQuestItem()

	local unlockQuestIdList = AssassinOutsideModel.instance:getMapUnlockQuestIdList(self._mapId)

	for _, questId in ipairs(unlockQuestIdList) do
		self:addQuestItem(questId)

		local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemOpenAnim, questId)
		local needPlayNew = not AssassinOutsideModel.instance:getCacheKeyData(cacheKey)

		if needPlayNew then
			local questItem = self._showQuestItemDict[questId]

			if questItem then
				questItem:disableItem()
			end
		end
	end

	local finishQuestIdList = AssassinOutsideModel.instance:getMapFinishQuestIdList(self._mapId)

	for _, questId in ipairs(finishQuestIdList) do
		local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemFinishAnim, questId)
		local needPlayUnlockAnim = not AssassinOutsideModel.instance:getCacheKeyData(cacheKey)

		if needPlayUnlockAnim then
			self:addQuestItem(questId)
		end
	end
end

function AssassinQuestMapView:clearAllQuestItem()
	if self._showQuestItemDict then
		for questId, _ in pairs(self._showQuestItemDict) do
			self:removeQuestItem(questId)
		end
	end

	self._showQuestItemDict = {}
end

function AssassinQuestMapView:removeQuestItem(questId, isPlayAnim)
	local questItem = self._showQuestItemDict[questId]

	if not questItem then
		return
	end

	questItem:remove(isPlayAnim)

	self._showQuestItemDict[questId] = nil

	table.insert(self._questItemPool, questItem)

	local arrowItem = self._arrowList[questId]

	if arrowItem then
		arrowItem.arrowClick:RemoveClickListener()

		self._arrowList[questId] = nil

		gohelper.destroy(arrowItem.go)
	end
end

function AssassinQuestMapView:addQuestItem(questId)
	if self._showQuestItemDict[questId] then
		return
	end

	local newQuestItem

	if next(self._questItemPool) then
		newQuestItem = table.remove(self._questItemPool)
	else
		local newQuestItemGo = gohelper.cloneInPlace(self._goquestItem)

		newQuestItem = MonoHelper.addNoUpdateLuaComOnceToGo(newQuestItemGo, AssassinQuestItem)
	end

	newQuestItem:setData(questId)

	self._showQuestItemDict[questId] = newQuestItem

	local itemPath = self.viewContainer:getSetting().otherRes[1]
	local itemGo = self:getResInst(itemPath, self._goarrow)
	local rotationGo = gohelper.findChild(itemGo, "mesh")
	local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
	local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

	arrowClick:AddClickListener(self._arrowClick, self, questId)

	self._arrowList[questId] = {
		go = itemGo,
		rotationTrans = rotationGo.transform,
		initRotation = {
			rx,
			ry,
			rz
		},
		arrowClick = arrowClick
	}

	self:updateArrow(newQuestItem)
end

function AssassinQuestMapView:_arrowClick(questId)
	self:_onClickQuestItem(questId, false, true)
end

function AssassinQuestMapView:checkPlayAnim()
	local isShowingLoading = ViewMgr.instance:isOpen(ViewName.LoadingView)

	if isShowingLoading then
		return
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= self.viewName and topView ~= ViewName.AssassinLibraryToastView and topView ~= ViewName.GuideView then
		return
	end

	self:playFinishedQuest()

	if self._currencyToolView then
		self._currencyToolView:checkPlayGet()
	end
end

local QUEST_FINISH_ANIM_TIME = 0.67

function AssassinQuestMapView:playFinishedQuest()
	local finishList = {}

	for questId, _ in pairs(self._showQuestItemDict) do
		local isFinished = AssassinOutsideModel.instance:isFinishQuest(questId)

		if isFinished then
			finishList[#finishList + 1] = questId
		end
	end

	if #finishList > 0 then
		local focusQuestId = finishList[1]
		local questItem = self._showQuestItemDict[focusQuestId]

		if questItem then
			local worldPos = questItem:getGoPosition()
			local pos = self._transmap:InverseTransformPoint(worldPos)

			self:tweenMapPos(-pos.x, -pos.y)
		end

		for _, finishQuestId in ipairs(finishList) do
			self:removeQuestItem(finishQuestId, true)
		end

		TaskDispatcher.cancelTask(self.playNewQuestItem, self)
		TaskDispatcher.runDelay(self.playNewQuestItem, self, QUEST_FINISH_ANIM_TIME)
	else
		self:playNewQuestItem()
	end
end

function AssassinQuestMapView:playNewQuestItem()
	local hasFocus

	for questId, questItem in pairs(self._showQuestItemDict) do
		local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemOpenAnim, questId)
		local needPlayNew = not AssassinOutsideModel.instance:getCacheKeyData(cacheKey)

		if needPlayNew then
			questItem:playOpen()
			AssassinController.instance:setHasPlayedAnimation(cacheKey)

			if not hasFocus then
				local worldPos = questItem:getGoPosition()
				local pos = self._transmap:InverseTransformPoint(worldPos)

				self:tweenMapPos(-pos.x, -pos.y)

				hasFocus = true
			end
		end
	end
end

function AssassinQuestMapView:refreshUI()
	self:refreshMapProgress()
	self:refreshQuestTypeInfoProgress()
	self:refreshBuildingReddot()
	self:refreshLibraryRedDot()
end

function AssassinQuestMapView:refreshMapProgress()
	local progress, strProgress = AssassinOutsideModel.instance:getQuestMapProgress(self._mapId)

	self._txtprogress.text = strProgress

	self._sliderprogress:SetValue(progress)
end

function AssassinQuestMapView:refreshQuestTypeInfoProgress()
	for _, questTypeInfoItem in ipairs(self._questTypeInfoItemList) do
		questTypeInfoItem.txtprogress.text = AssassinOutsideModel.instance:getQuestTypeProgressStr(self._mapId, questTypeInfoItem.questType)
	end
end

function AssassinQuestMapView:refreshBuildingReddot()
	local mapMo = AssassinOutsideModel.instance:getBuildingMapMo()
	local canLevelUp = mapMo and mapMo:isAnyBuildingLevelUp2NextLv()

	gohelper.setActive(self._gomanorreddot, canLevelUp)
end

function AssassinQuestMapView:refreshLibraryRedDot()
	self._libraryRedDot = RedDotController.instance:addNotEventRedDot(self._golibraryreddot, self._libraryRedDotCheckFunc, self, AssassinEnum.LibraryReddotStyle)

	self._libraryRedDot:refreshRedDot()
end

function AssassinQuestMapView:_libraryRedDotCheckFunc()
	return AssassinLibraryModel.instance:isAnyLibraryNewUnlock()
end

function AssassinQuestMapView:onClose()
	self:killTween()
	TaskDispatcher.cancelTask(self.playNewQuestItem, self)
end

function AssassinQuestMapView:onDestroyView()
	self._questItemPool = nil
	self._showQuestItemDict = nil

	if self.bgSimageList then
		for _, bgSimage in ipairs(self.bgSimageList) do
			bgSimage:UnLoadImage()
		end
	end

	for _, v in pairs(self._arrowList) do
		v.arrowClick:RemoveClickListener()
		gohelper.destroy(v.go)
	end
end

function AssassinQuestMapView:updateAllArrow()
	for _, questItem in pairs(self._showQuestItemDict) do
		self:updateArrow(questItem)
	end
end

function AssassinQuestMapView:updateArrow(questItem)
	local t = questItem.trans
	local camera = CameraMgr.instance:getUICamera()
	local pos = camera:WorldToViewportPoint(t.position)
	local x = pos.x
	local y = pos.y
	local isShow = x >= 0 and x <= 1 and y >= 0 and y <= 1
	local arrowItem = self._arrowList[questItem._questId]

	if not arrowItem then
		return
	end

	gohelper.setActive(arrowItem.go, not isShow)

	if isShow then
		return
	end

	local viewportX = math.max(0.02, math.min(x, 0.98))
	local viewportY = math.max(0.035, math.min(y, 0.965))
	local width = recthelper.getWidth(self._goarrow.transform)
	local height = recthelper.getHeight(self._goarrow.transform)

	recthelper.setAnchor(arrowItem.go.transform, width * (viewportX - 0.5), height * (viewportY - 0.5))

	local initRotation = arrowItem.initRotation

	if x >= 0 and x <= 1 then
		if y < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 180)

			return
		elseif y > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 0)

			return
		end
	end

	if y >= 0 and y <= 1 then
		if x < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 270)

			return
		elseif x > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 90)

			return
		end
	end

	local angle = 90 - Mathf.Atan2(y, x) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], angle)
end

return AssassinQuestMapView
