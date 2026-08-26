-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryView", package.seeall)

local NecrologistStoryView = class("NecrologistStoryView", BaseView)

function NecrologistStoryView:onInitView()
	self.goTitle = gohelper.findChild(self.viewGO, "Title")
	self.animTitle = self.goTitle:GetComponent(typeof(UnityEngine.Animator))
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_time")
	self.txtPlace = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_place")
	self.imageWeather = gohelper.findChildImage(self.viewGO, "Title/#image_weather")
	self.goWeatherRoot = gohelper.findChild(self.viewGO, "#weather")
	self.txtNum = gohelper.findChildTextMesh(self.viewGO, "Title/num/#txt_num")
	self.goLeft = gohelper.findChild(self.viewGO, "left")
	self.animLeft = self.goLeft:GetComponent(typeof(UnityEngine.Animator))
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "left/#txt_title")
	self.txtTitleEn = gohelper.findChildTextMesh(self.viewGO, "left/#txt_title/#txt_sectionEn")
	self.simageSectionpic = gohelper.findChildSingleImage(self.viewGO, "left/#simage_sectionpic")
	self.goLeftArea = gohelper.findChild(self.viewGO, "left/simage_leftbg")
	self.goDragPicture = gohelper.findChild(self.viewGO, "left/#dragpicture")
	self.goEnd = gohelper.findChild(self.viewGO, "right/#go_end")
	self.goArrow = gohelper.findChild(self.viewGO, "right/#go_Talk/Scroll DecView/Viewport/arrow")
	self.scrollRect = gohelper.findChildComponent(self.viewGO, "right/#go_Talk/Scroll DecView", gohelper.Type_LimitedScrollRect)
	self.goContent = gohelper.findChild(self.viewGO, "right/#go_Talk/Scroll DecView/Viewport/Content")
	self.rectContent = self.goContent.transform
	self.storyItemList = {}
	self.itemCount = 0
	self.goLine = gohelper.findChild(self.viewGO, "right/#go_Talk/Scroll DecView/Viewport/Content/#go_Line")

	gohelper.setActive(self.goLine, false)

	self.lineList = {}
	self.normalSpace = 20
	self.paragraphSpace = 40
	self.bottomSpace = 30
	self.loaderComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, NecrologistStoryLoaderComp)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryView:addEvents()
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnClickNext, self.onClickNext, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, self.onAutoChange, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnClickSkip, self.onClickSkip, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnSelectSection, self.onSelectSection, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, self.onChangeWeather, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePic, self.onChangePic, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeTime, self.onChangeTime, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePlace, self.onChangePlace, self)
end

function NecrologistStoryView:removeEvents()
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnClickNext, self.onClickNext, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, self.onAutoChange, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnClickSkip, self.onClickSkip, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnSelectSection, self.onSelectSection, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, self.onChangeWeather, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePic, self.onChangePic, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeTime, self.onChangeTime, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePlace, self.onChangePlace, self)
end

function NecrologistStoryView:_editableInitView()
	return
end

function NecrologistStoryView:getScrollViewGO()
	return self.scrollRect.gameObject
end

function NecrologistStoryView:onChangePic(picName)
	self:setLeftPic(picName)
end

function NecrologistStoryView:onChangeWeather(weatherType)
	TaskDispatcher.cancelTask(self._refreshWeather, self)

	self._lastWeather = self._curWeather

	if self._curWeather and self._curWeather ~= weatherType then
		self._curWeather = weatherType

		self.animTitle:Play("weather", 0, 0)
		TaskDispatcher.runDelay(self._refreshWeather, self, 0.16)
	else
		self._curWeather = weatherType

		self:_refreshWeather()
	end
end

function NecrologistStoryView:onChangeTime(time)
	self.txtTime.text = time
end

function NecrologistStoryView:onChangePlace(place)
	self.txtPlace.text = place
end

function NecrologistStoryView:onSelectSection(sectionId, isSkip)
	if not self._storyGroupMo then
		return
	end

	self._storyGroupMo:setSection(sectionId)
	self:runNextStep(isSkip)
end

function NecrologistStoryView:onClickNext()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.UI_Common_Click)

	if not self._storyGroupMo then
		return
	end

	if self:isStoryFinish() then
		return
	end

	local item = self:getLastItem()

	if item then
		item:onClickNext()

		if not item:isDone() then
			item:justDone()

			return
		end
	end

	self:runNextStep()
end

function NecrologistStoryView:onAutoChange()
	if not self._storyGroupMo then
		return
	end

	if self:isStoryFinish() then
		return
	end

	if not self._storyGroupMo:getIsAuto() then
		if self._tweenBottomId then
			self:_onTweenBottomFinish()
		end

		return
	end

	local item = self:getLastItem()

	if item and item:isDone() then
		self:runNextStep()
	end
end

function NecrologistStoryView:onClickSkip()
	if self._isSkipping then
		return
	end

	if self._tweenBottomId then
		return
	end

	if not self._storyGroupMo then
		return
	end

	if self:isStoryFinish() then
		return
	end

	self._storyGroupMo:setIsAuto(false)

	local item = self:getLastItem()

	if item and not item:isDone() then
		item:justDone()

		if not item:isDone() then
			return
		end
	end

	self._storyGroupMo:onSkip()

	local statParam = self._storyGroupMo:getStatParam(self:isInReview())

	statParam.lastText = self:getLastText()

	NecrologistStoryStatController.instance:statStorySkip(statParam)

	self._isSkipping = true

	self:_continueSkip()
end

function NecrologistStoryView:_continueSkip()
	if not self._isSkipping then
		return
	end

	if self:isStoryFinish() then
		self._isSkipping = false

		self:onFinishStory()

		return
	end

	self:runNextStep(true)
end

function NecrologistStoryView:_canContinueSkip()
	if not self._isSkipping then
		return false
	end

	if self:isStoryFinish() then
		return false
	end

	if self._isLoadingAsync then
		return false
	end

	local item = self:getLastItem()

	if not item then
		self._isSkipping = false

		return false
	end

	if not item:isDone() then
		item:justDone()

		if not item:isDone() then
			if not item:isAsyncItem() then
				self._isSkipping = false
			end

			return false
		end
	end

	return true
end

function NecrologistStoryView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_activity_meeting_book_open)
	self:refreshViewParam()
end

function NecrologistStoryView:onUpdateParam()
	self:refreshViewParam()
end

function NecrologistStoryView:refreshViewParam()
	self.roleStoryId = self.viewParam and self.viewParam.roleStoryId
	self.callback = self.viewParam and self.viewParam.callback
	self.callbackObj = self.viewParam and self.viewParam.callbackObj

	if self.viewParam then
		local storyGroupId = self.viewParam.storyGroupId

		self:startStoryGroup(storyGroupId)
	end
end

function NecrologistStoryView:startStoryGroup(storyGroupId)
	if not storyGroupId then
		return
	end

	NecrologistStoryStatController.instance:startStoryStat()

	self._storyGroupMo = self:getStoryMo(storyGroupId)

	self._storyGroupMo:initData()

	if self.roleStoryId then
		local storyMo = NecrologistStoryModel.instance:getGameMO(self.roleStoryId)

		storyMo:setStoryState(storyGroupId, NecrologistStoryEnum.StoryState.Reading)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryStart)

	self.isFinish = false

	self:setIsEnd(false)
	self:clearAll()
	self:refreshUI(storyGroupId)
	TaskDispatcher.runDelay(self.runNextStep, self, 0.1)
end

function NecrologistStoryView:refreshUI(storyGroupId)
	local plotGroupCo = NecrologistStoryConfig.instance:getPlotGroupCo(storyGroupId)

	if not plotGroupCo then
		return
	end

	self.txtTitle.text = plotGroupCo.storyName
	self.txtTitleEn.text = plotGroupCo.storyNameEn

	local timeStr = NecrologistStoryHelper.getTimeStrByConfig(plotGroupCo)

	self._storyGroupMo:setTime(timeStr)
	self._storyGroupMo:setPlace(plotGroupCo.place)
	self._storyGroupMo:setWeather(plotGroupCo.weather)

	self.txtNum.text = string.format("%02d", NecrologistStoryHelper.getStoryGroupIndex(storyGroupId))

	self:setLeftPic(plotGroupCo.storyPic)

	local storyConfig = self._storyGroupMo:getNextStepConfig()
	local isHideLeftStyle = storyConfig and string.find(storyConfig.type, "LeftStyle")

	self:setLeftStyleVisible(not isHideLeftStyle)
end

function NecrologistStoryView:_refreshWeather()
	NecrologistStoryHelper.setWeatherIcon(self.imageWeather, self._storyGroupMo.showWeather)
	self:playWeather()
end

function NecrologistStoryView:playWeather()
	if not self.goWeather then
		local resPath = self.viewContainer:getSetting().otherRes[1]

		self.goWeather = self.viewContainer:getResInst(resPath, self.goWeatherRoot, "weather")
		self.weatherList = {}

		for type, name in pairs(NecrologistStoryEnum.WeatherType2Name) do
			local item = self:getUserDataTb_()

			item.go = gohelper.findChild(self.goWeather, name)

			if not gohelper.isNil(item.go) then
				item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))

				gohelper.setActive(item.go, false)

				item.isVisible = false
				self.weatherList[type] = item
			end
		end
	end

	if self._lastWeather == self._curWeather then
		return
	end

	if self._lastWeather then
		local item = self.weatherList[self._lastWeather]

		self:setWeaherVisible(item, false)
	end

	if self._curWeather then
		local item = self.weatherList[self._curWeather]

		self:setWeaherVisible(item, true)
	end
end

function NecrologistStoryView:setWeaherVisible(item, isVisible)
	if not item then
		return
	end

	if item.isVisible == isVisible then
		return
	end

	item.isVisible = isVisible

	if isVisible then
		gohelper.setActive(item.go, true)

		if item.anim then
			item.anim:Play("open", 0, 0)
		end
	elseif item.anim then
		gohelper.setActive(item.go, true)
		item.anim:Play("close", 0, 0)
	else
		gohelper.setActive(item.go, false)
	end
end

function NecrologistStoryView:setLeftPic(picRes)
	TaskDispatcher.cancelTask(self._refreshLeftPic, self)

	if self._curPicRes and self._curPicRes ~= picRes then
		self._curPicRes = picRes

		self.animLeft:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self._refreshLeftPic, self, 0.16)
	else
		self._curPicRes = picRes

		self:_refreshLeftPic()
	end
end

function NecrologistStoryView:_refreshLeftPic()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mln_day_night)

	if string.nilorempty(self._curPicRes) then
		self.simageSectionpic:LoadImage(ResUrl.getNecrologistStoryPicBg("rolestory_pic_01"))
	else
		self.simageSectionpic:LoadImage(ResUrl.getNecrologistStoryPicBg(self._curPicRes))
	end
end

function NecrologistStoryView:isStoryFinish()
	if not self._storyGroupMo:isStoryFinish() then
		return false
	end

	local beforeItem = self:getLastItem()

	if beforeItem and not beforeItem:isDone() then
		return false
	end

	return true
end

function NecrologistStoryView:runNextStep(isSkip)
	if self:isStoryFinish() then
		self:onFinishStory()

		return
	end

	self._isSkip = isSkip

	TaskDispatcher.cancelTask(self.realPlayNextStep, self)

	if not isSkip and self._storyGroupMo:isNextStepNeedDelay() then
		TaskDispatcher.runDelay(self.realPlayNextStep, self, 0.75)
	else
		self:realPlayNextStep()
	end
end

function NecrologistStoryView:realPlayNextStep()
	self._storyGroupMo:runNextStep()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryNextStep)

	local storyConfig = self._storyGroupMo:getCurStoryConfig()

	if not storyConfig then
		self:onFinishStory()

		return
	end

	self:playStory(storyConfig, self._isSkip)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnPlayStory, storyConfig.id)
end

function NecrologistStoryView:playStory(storyConfig, isSkip)
	local type = storyConfig.type
	local isPause = storyConfig.pause == 1

	if isPause then
		isSkip = false
		self._isSkipping = false
	end

	self:tryEnding(storyConfig)

	local storyPlayView = self:getStoryPlayView()
	local funcName = string.format("playStory_%s", type)
	local func = storyPlayView[funcName]

	if func then
		func(storyPlayView, storyConfig, isSkip)
	else
		self:runNextStep()
	end
end

function NecrologistStoryView:tryEnding(storyConfig)
	local endingCo = NecrologistStoryConfig.instance:getEndingCoByStep(storyConfig.id)

	if not endingCo then
		return
	end

	self._storyGroupMo:onEndingUnlock(endingCo.id)
end

function NecrologistStoryView:onItemPlayFinish(isAutoNext)
	if not self._storyGroupMo:getIsAuto() and not isAutoNext then
		if self:isStoryFinish() then
			self:onFinishStory()
		end

		return
	end

	self:runNextStep()
end

function NecrologistStoryView:refreshContentSize(curItem)
	if not curItem:getIsContentItem() then
		return
	end

	local curIndex = curItem.index
	local beforeItem = self:getBeforeContentItem(curItem)
	local posY = beforeItem and beforeItem:getPosY() - beforeItem:getHeight() or 0
	local endItem = self:getLastContentItem()

	if endItem then
		local endIndex = endItem.index

		for i = curIndex, endIndex do
			local tempItem = self:getStoryItemView():getItemByIndex(i)

			if tempItem:getIsContentItem() then
				local itemSpace = self:getItemSpace(tempItem, beforeItem)
				local curPosY = ((beforeItem or nil) and beforeItem:getPosY() - beforeItem:getHeight()) - itemSpace

				tempItem:setPosY(curPosY)
				self:tryAddLine(tempItem, beforeItem)

				beforeItem = tempItem
			end
		end
	end

	local endPos = endItem and endItem:getPosY() or 0
	local endHeight = endItem and endItem:getHeight() or 0
	local allHeight = math.abs(endPos) + endHeight + self.bottomSpace

	self:setContentHeight(allHeight)
end

function NecrologistStoryView:getBeforeContentItem(curItem)
	local curIndex = curItem.index
	local storyItemView = self:getStoryItemView()

	for i = curIndex - 1, 1, -1 do
		local item = storyItemView:getItemByIndex(i)

		if item:getIsContentItem() then
			return item
		end
	end
end

function NecrologistStoryView:setContentHeight(height)
	local oldHeight = recthelper.getHeight(self.rectContent)

	if oldHeight ~= height then
		self:clearTweenBottom()
		recthelper.setHeight(self.rectContent, height)
		self:moveToContentBottom()
	end
end

function NecrologistStoryView:moveToContentBottom()
	local startValue = self.scrollRect.verticalNormalizedPosition
	local endValue = 0

	if math.abs(startValue - endValue) < 0.001 then
		return
	end

	local duration = 0.2

	self._tweenBottomId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, duration, self._onTweenBottomUpdate, self._onTweenBottomFinish, self, nil, EaseType.Linear)
end

function NecrologistStoryView:_onTweenBottomUpdate(value)
	self.scrollRect.verticalNormalizedPosition = value
end

function NecrologistStoryView:_onTweenBottomFinish()
	self.scrollRect.verticalNormalizedPosition = 0

	self:clearTweenBottom()
end

function NecrologistStoryView:clearTweenBottom()
	if self._tweenBottomId then
		ZProj.TweenHelper.KillById(self._tweenBottomId)

		self._tweenBottomId = nil
	end
end

function NecrologistStoryView:getItemSpace(curItem, beforeItem)
	local space = 0

	if not beforeItem then
		return space
	end

	local isDifferentParagraphs = self:isDifferentParagraphs(curItem, beforeItem)

	space = isDifferentParagraphs and self.paragraphSpace or self.normalSpace

	return space
end

function NecrologistStoryView:isDifferentParagraphs(curItem, beforeItem)
	local curType = curItem:getItemType()
	local beforeType = beforeItem:getItemType()

	if curType == nil or beforeType == nil then
		return false
	end

	if curType == beforeType then
		return false
	end

	return true
end

function NecrologistStoryView:onFinishStory()
	if self.isFinish then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_revelation_open)

	self.isFinish = true

	self:setIsEnd(true)
	self._storyGroupMo:saveSituation()
	self._storyGroupMo:saveTaskValue()

	if self.roleStoryId then
		local storyMo = NecrologistStoryModel.instance:getGameMO(self.roleStoryId)

		storyMo:setStoryState(self._storyGroupMo.id, NecrologistStoryEnum.StoryState.Finish)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryEnd)

	local statParam = self._storyGroupMo:getStatParam(self:isInReview())

	statParam.lastText = self:getLastText()

	NecrologistStoryStatController.instance:statStoryEnd(statParam)
end

function NecrologistStoryView:setIsEnd(isEnd)
	gohelper.setActive(self.goEnd, isEnd)
	gohelper.setActive(self.goArrow, not isEnd)
end

function NecrologistStoryView:getStoryMo(id)
	return (NecrologistStoryModel.instance:getStoryMO(id))
end

function NecrologistStoryView:getLastItem()
	local storyItemView = self:getStoryItemView()

	return storyItemView:getLastItem()
end

function NecrologistStoryView:getLastContentItem()
	local storyItemView = self:getStoryItemView()

	return storyItemView:getLastContentItem()
end

function NecrologistStoryView:clearStoryItem()
	local storyItemView = self:getStoryItemView()

	storyItemView:clearStoryItem()
end

function NecrologistStoryView:clearAll()
	TaskDispatcher.cancelTask(self.realPlayNextStep, self)
	TaskDispatcher.cancelTask(self.runNextStep, self)
	TaskDispatcher.cancelTask(self._refreshWeather, self)
	TaskDispatcher.cancelTask(self._refreshLeftPic, self)
	self:clearTweenBottom()
	self:clearStoryItem()
end

function NecrologistStoryView:createStoryItem(cls, storyConfig, isSkip)
	local storyItemView = self:getStoryItemView()

	storyItemView:createStoryItem(cls, storyConfig, isSkip)
end

function NecrologistStoryView:createStoryItemAsync(cls, storyConfig, isSkip, parentGO)
	local storyItemView = self:getStoryItemView()

	storyItemView:createStoryItemAsync(cls, storyConfig, isSkip, parentGO)
end

function NecrologistStoryView:addItem(item)
	local storyItemView = self:getStoryItemView()

	storyItemView:addItem(item)
end

function NecrologistStoryView:delItem(item)
	local storyItemView = self:getStoryItemView()

	storyItemView:delItem(item)
end

function NecrologistStoryView:addControl(storyConfig, isSkip, fromItem)
	self.controlMgr = self.controlMgr or MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, NecrologistStoryControlMgrComp, self)

	self.controlMgr:playControl(storyConfig, isSkip, fromItem)
end

function NecrologistStoryView:createControlItemAsync(cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
	local resPath = cls.getResPath()

	if string.nilorempty(resPath) then
		self:_createControlItemGo(nil, nil, cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)

		return
	end

	local resPathList = {
		resPath
	}
	local otherResPathList = cls.getOtherResPath()

	if otherResPathList then
		tabletool.addValues(resPathList, otherResPathList)
	end

	if self.loaderComp then
		self._isLoadingAsync = true

		self.loaderComp:startLoad(resPathList, self.onControlItemLoaded, self, cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
	else
		self:createControlItem(cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
	end
end

function NecrologistStoryView:_createControlItemGo(go, resList, cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
	go = go or gohelper.create2d(self.goContent, tostring(storyId))

	local itemParam = {
		isContentItem = true,
		storyView = self,
		resList = resList
	}
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, itemParam)

	self:addItem(item)
	item:setStoryId(storyId)
	item:playControl(controlParam, playFinishCallback, playFinishCallbackObj, self.refreshContentSize, self)
	self:tryAddLine()

	local flag = self:_canContinueSkip()

	if flag then
		self:_continueSkip()
	end
end

function NecrologistStoryView:onControlItemLoaded(mainRes, resList, cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
	self._isLoadingAsync = false

	if not mainRes then
		self:_createControlItemGo(nil, resList, cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)

		return
	end

	local go = gohelper.clone(mainRes, self.goContent, tostring(storyId))

	self:_createControlItemGo(go, resList, cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
end

function NecrologistStoryView:recycelLines()
	self._linePool = self._linePool or {}

	for _, v in pairs(self.lineList) do
		gohelper.setActive(v, false)
		table.insert(self._linePool, v)
	end

	self.lineList = {}
end

function NecrologistStoryView:getLine()
	local goLine

	return self._linePool and #self._linePool > 0 and table.remove(self._linePool) or gohelper.cloneInPlace(self.goLine, "line")
end

function NecrologistStoryView:tryAddLine(curItem, beforeItem)
	local flag, posY, key = self:isNeedAddLine(curItem, beforeItem)

	if flag then
		local goLine = self.lineList[key]

		if not goLine then
			goLine = self:getLine()

			gohelper.setActive(goLine, true)

			self.lineList[key] = goLine
		end

		recthelper.setAnchorY(goLine.transform, posY)
	end
end

function NecrologistStoryView:isNeedAddLine(curItem, beforeItem)
	if not curItem then
		local storyItemView = self:getStoryItemView()
		local itemCount = storyItemView:getItemCount()

		curItem = storyItemView:getItemByIndex(itemCount)
		beforeItem = storyItemView:getItemByIndex(itemCount - 1)
	end

	if not curItem or not beforeItem then
		return false
	end

	local posY = 0
	local flag = self:isDifferentParagraphs(curItem, beforeItem)

	if flag then
		local itemSpace = self:getItemSpace(curItem, beforeItem)
		local itemPosY = curItem:getPosY()
		local halfSpace = itemSpace * 0.5

		posY = itemPosY + halfSpace
	end

	local key = string.format("%s_%s", curItem:getStoryId(), beforeItem:getStoryId())

	return flag, posY, key
end

function NecrologistStoryView:isInLeftArea(transform)
	if not transform or not self.goLeftArea then
		return false
	end

	local uiCamera = CameraMgr.instance:getUICamera()
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(transform)

	return recthelper.screenPosInRect(self.goLeftArea.transform, uiCamera, screenPosX, screenPosY)
end

function NecrologistStoryView:onDragPicEnable(isEnable)
	gohelper.setActive(self.goDragPicture, isEnable)
end

function NecrologistStoryView:setLeftStyleVisible(isVisible)
	gohelper.setActive(self.goLeft, isVisible)
	gohelper.setActive(self.goTitle, isVisible)
end

function NecrologistStoryView:onClose()
	if self.roleStoryId then
		local storyGameMo = NecrologistStoryModel.instance:getGameMO(self.roleStoryId)
		local storyId = self._storyGroupMo.id
		local storyCo = RoleStoryConfig.instance:getStoryById(self.roleStoryId)
		local unlock = storyCo.cgUnlockStoryId == storyId and storyGameMo:isStoryFinish(storyId)

		if unlock then
			NecrologistStoryController.instance:openCgUnlockView(self.roleStoryId)
		end
	end

	local statParam = self._storyGroupMo:getStatParam(self:isInReview())

	statParam.lastText = self:getLastText()

	NecrologistStoryStatController.instance:statStoryInterrupt(statParam)

	if self.callback then
		-- block empty
	end
end

function NecrologistStoryView:onCloseFinish()
	return
end

function NecrologistStoryView:isInReview()
	return self.roleStoryId == nil
end

function NecrologistStoryView:getLastText()
	local storyItemView = self:getStoryItemView()
	local itemCount = storyItemView:getItemCount()

	for i = itemCount, 1, -1 do
		local item = storyItemView:getItemByIndex(i)
		local lastText = item:getTextStr()

		if not string.nilorempty(lastText) then
			return lastText
		end
	end

	return ""
end

function NecrologistStoryView:getStoryItemView()
	return self.viewContainer:getStoryItemView()
end

function NecrologistStoryView:getStoryPlayView()
	return self.viewContainer:getStoryPlayView()
end

function NecrologistStoryView:onDestroyView()
	self:clearAll()
	self.simageSectionpic:UnLoadImage()
end

return NecrologistStoryView
