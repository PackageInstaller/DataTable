-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerView.lua

module("modules.logic.weekwalk.view.WeekWalkLayerView", package.seeall)

local WeekWalkLayerView = class("WeekWalkLayerView", BaseView)

function WeekWalkLayerView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_right")
	self._goshallow = gohelper.findChild(self.viewGO, "bottom_left/#go_shallow ")
	self._godeep = gohelper.findChild(self.viewGO, "bottom_left/#go_deep")
	self._gocountdown = gohelper.findChild(self.viewGO, "bottom_left/#go_deep/#go_countdown")
	self._txtcountday = gohelper.findChildText(self.viewGO, "bottom_left/#go_deep/#go_countdown/#txt_countday")
	self._goexcept = gohelper.findChild(self.viewGO, "bottom_left/#go_deep/#go_except")
	self._goruleIcon = gohelper.findChild(self.viewGO, "#go_ruleIcon")
	self._btnruleIcon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ruleIcon/#btn_ruleIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkLayerView:addEvents()
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnruleIcon:AddClickListener(self._btnruleIconOnClick, self)
end

function WeekWalkLayerView:removeEvents()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnruleIcon:RemoveClickListener()
end

function WeekWalkLayerView:_btnruleIconOnClick()
	WeekWalkController.instance:openWeekWalkRuleView()
end

function WeekWalkLayerView:_btnleftOnClick()
	local curPageIndex = self._pageIndex

	self._pageIndex = curPageIndex - 1

	self:_tweenPos()
	self:_updateBtns()
	self:_pageTransition(curPageIndex, self._pageIndex)
end

function WeekWalkLayerView:_btnrightOnClick()
	local curPageIndex = self._pageIndex

	self._pageIndex = curPageIndex + 1

	self:_tweenPos()
	self:_updateBtns()
	self:_pageTransition(curPageIndex, self._pageIndex)
end

function WeekWalkLayerView:_editableInitView()
	WeekWalkModel.instance:clearOldInfo()
	gohelper.addUIClickAudio(self._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(self._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gotopleft = gohelper.findChild(self.viewGO, "top_left")

	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._OnGetInfo, self)
end

function WeekWalkLayerView:_OnGetInfo()
	self:_initPageList()

	for i, v in ipairs(self._layerPageList) do
		v:updateLayerList(self._pageList[i])
	end
end

function WeekWalkLayerView:_initPageList()
	local pageList = {}

	for i, v in ipairs(lua_weekwalk.configList) do
		local type = v.type

		if type <= 2 then
			local pageType = 1

			if not pageList[pageType] then
				local page = {}

				table.insert(page, v)

				pageList[pageType] = page
			end
		end
	end

	local info = WeekWalkModel.instance:getInfo()
	local deepLayerList = WeekWalkConfig.instance:getDeepLayer(info.issueId)
	local maxLayer = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if deepLayerList then
		for i, v in ipairs(deepLayerList) do
			if not self.isVerifing or maxLayer >= v.layer then
				local pageType = 2

				if not pageList[pageType] then
					table.insert(pageList[pageType], v)

					pageList[pageType] = pageList[pageType]
				end
			end
		end
	end

	self._pageList = pageList
end

function WeekWalkLayerView:_initPages()
	self:_initPageList()

	self._layerPageList = self:getUserDataTb_()
	self._pageIndex = 1
	self._maxPageIndex = 1
end

function WeekWalkLayerView:_addPages()
	for i, v in ipairs(self._pageList) do
		self:_addPage(i, v)
	end
end

function WeekWalkLayerView:_addPage(index, layerList)
	if index > self._maxPageIndex then
		self._maxPageIndex = index
	end

	if self._layerPageList[index] then
		return
	end

	local path = self.viewContainer:getSetting().otherRes[1]
	local pageGo = self:getResInst(path, self._gocontent)
	local layerPage = WeekWalkLayerPage.New()

	layerPage:initView(pageGo, {
		self,
		index,
		layerList
	})
	recthelper.setAnchorX(pageGo.transform, (index - 1) * 2808)

	self._layerPageList[index] = layerPage
end

function WeekWalkLayerView:_updateBtns()
	gohelper.setActive(self._btnleft.gameObject, self._pageIndex > 1)

	local showRightBtn = self._pageIndex < self._maxPageIndex

	showRightBtn = showRightBtn and self:_shallowFinish()

	if self.isVerifing then
		showRightBtn = false
	end

	gohelper.setActive(self._btnright.gameObject, showRightBtn)
	self:_updateTitles()
end

function WeekWalkLayerView:_shallowFinish()
	local mapInfo = WeekWalkModel.instance:getMapInfo(205)

	return mapInfo and mapInfo.isFinished > 0
end

function WeekWalkLayerView:_onChangeRightBtnVisible(showRightBtn)
	if self:_shallowFinish() then
		return
	end

	if self.isVerifing then
		showRightBtn = false
	end

	gohelper.setActive(self._btnright.gameObject, showRightBtn)
end

function WeekWalkLayerView:_updateTitles()
	local isShallowPage = WeekWalkLayerView.isShallowPage(self._pageIndex)

	gohelper.setActive(self._goshallow, isShallowPage)
	gohelper.setActive(self._godeep, not isShallowPage)

	if not isShallowPage then
		local info = WeekWalkModel.instance:getInfo()

		gohelper.setActive(self._goexcept, not info.isOpenDeep)
		gohelper.setActive(self._gocountdown, info.isOpenDeep)
	end

	gohelper.setActive(self._goruleIcon, self:_showDeepRuleBtn())
	self:_shallowPageOpenShow()
	self:_deepPageOpenShow()
end

function WeekWalkLayerView:_shallowPageOpenShow()
	local isShallowPage = WeekWalkLayerView.isShallowPage(self._pageIndex)

	if not isShallowPage then
		return
	end

	local info = WeekWalkModel.instance:getInfo()

	if not info.isOpenDeep then
		return
	end

	if not self:_shallowFinish() then
		return
	end

	if GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShallowPageOpenShow)
end

function WeekWalkLayerView:_deepPageOpenShow()
	local isShallowPage = WeekWalkLayerView.isShallowPage(self._pageIndex)

	if isShallowPage then
		return
	end

	local info = WeekWalkModel.instance:getInfo()

	if not info.isOpenDeep then
		return
	end

	if not self:_shallowFinish() then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideDeepPageOpenShow)
end

function WeekWalkLayerView.isShallowPage(index)
	return index <= 1
end

function WeekWalkLayerView:_pageTransition(prevIndex, curIndex)
	local prevPage = self._layerPageList[prevIndex]
	local curPage = self._layerPageList[curIndex]

	gohelper.setAsLastSibling(curPage.viewGO)

	if prevIndex < curIndex then
		curPage:playAnim("weekwalklayerpage_slideleft02")
		prevPage:playAnim("weekwalklayerpage_slideleft01")
		curPage:playBgAnim("weekwalklayerpage_bg_slideleft02")
		prevPage:playBgAnim("weekwalklayerpage_bg_slideleft01")
	else
		curPage:playAnim("weekwalklayerpage_slideright02")
		prevPage:playAnim("weekwalklayerpage_slideright01")
		curPage:playBgAnim("weekwalklayerpage_bg_slideright02")
		prevPage:playBgAnim("weekwalklayerpage_bg_slideright01")
	end
end

function WeekWalkLayerView:_tweenPos(noTween)
	if self._prevPageIndex == self._pageIndex then
		return
	end

	if self:_getAmbientSound(self._pageIndex) ~= self._ambientSoundId then
		self:_endAmbientSound()
	end

	self._prevPageIndex = self._pageIndex

	for i, v in ipairs(self._layerPageList) do
		local pageGo = v.viewGO
		local isShow = i == self._pageIndex

		v:setVisible(isShow)

		if isShow then
			v:resetPos(self._targetId)

			self._targetId = nil

			recthelper.setAnchorX(pageGo.transform, 0)
		else
			recthelper.setAnchorX(pageGo.transform, 10000)
		end
	end

	self:_movePageDone()
end

function WeekWalkLayerView:_movePageDone()
	self:_beginAmbientSound()

	if self._pageIndex == 2 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage3)
	end

	if self._pageIndex == 3 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage5)
	end
end

function WeekWalkLayerView:_beginAmbientSound()
	if not self._isOpenFinish then
		return
	end

	if self._ambientSoundId then
		return
	end
end

function WeekWalkLayerView:_endAmbientSound()
	if not self._ambientSoundId then
		return
	end

	self._ambientSoundId = nil
end

function WeekWalkLayerView:_getAmbientSound(pageIndex)
	if pageIndex <= 1 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_2
	elseif pageIndex <= 2 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_3
	end
end

function WeekWalkLayerView:onUpdateParam()
	return
end

function WeekWalkLayerView:onOpen()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnChangeRightBtnVisible, self._onChangeRightBtnVisible, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.GuideMoveLayerPage, self._onGuideMoveLayerPage, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)

	self.isVerifing = VersionValidator.instance:isInReviewing()

	self:_initPages()
	self:_addPages()
	self:_moveTargetLayer()
	self:_updateBtns()
	self:_showDeadline()
end

function WeekWalkLayerView:_onOpenView(viewName)
	if viewName == ViewName.WeekWalkView then
		self._animator.enabled = true

		self._animator:Play("weekwalklayerview_out", 0, 0)
		TaskDispatcher.cancelTask(self._delayHideBtnHelp, self)
		TaskDispatcher.runDelay(self._delayHideBtnHelp, self, 0.1)
		gohelper.setActive(self._goruleIcon, false)
	end
end

function WeekWalkLayerView:_delayHideBtnHelp()
	local btnView = self.viewContainer:getNavBtnView()

	btnView:setHelpVisible(false)
end

function WeekWalkLayerView:_onCloseView(viewName)
	if viewName == ViewName.WeekWalkView then
		self._animator.enabled = true

		self._animator:Play(UIAnimationName.Open, 0, 0)

		local btnView = self.viewContainer:getNavBtnView()

		btnView:setHelpVisible(true)
		gohelper.setActive(self._goruleIcon, self:_showDeepRuleBtn())

		local curPage = self._layerPageList[self._pageIndex]

		curPage:playAnim("weekwalklayerpage_in")
	end
end

function WeekWalkLayerView:_showDeepRuleBtn()
	if not self._pageIndex then
		return false
	end

	local isShallowPage = WeekWalkLayerView.isShallowPage(self._pageIndex)
	local info = WeekWalkModel.instance:getInfo()

	return not isShallowPage and info.isOpenDeep
end

function WeekWalkLayerView:_onCloseViewFinish(viewName)
	if viewName == ViewName.WeekWalkView then
		self:_addPages()
		self:_updateBtns()
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)
	end
end

function WeekWalkLayerView:onOpenFinish()
	self._isOpenFinish = true

	self:_beginAmbientSound()
end

function WeekWalkLayerView:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()
end

function WeekWalkLayerView:_onRefreshDeadline()
	local limitSec = self._endTime - ServerTime.now()

	if limitSec <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txtcountday.text = time .. format
end

function WeekWalkLayerView:_onGetInfo()
	self:_showDeadline()
	self:_updateTitles()
end

function WeekWalkLayerView:_onGuideMoveLayerPage(mapId)
	self._guideMoveMapId = tonumber(mapId)
end

function WeekWalkLayerView:_moveTargetLayer()
	self._targetId = self.viewParam and self.viewParam.mapId
	self._targetLayerId = self.viewParam and self.viewParam.layerId

	if not self._targetId and not self._targetLayerId then
		local info = WeekWalkModel.instance:getInfo()
		local map, index = info:getNotFinishedMap()

		self._targetId = map.id
	end

	if self._guideMoveMapId then
		self._targetId = self._guideMoveMapId
		self._guideMoveMapId = nil
	end

	if self._targetId or self._targetLayerId then
		for index, page in ipairs(self._pageList) do
			for i, v in ipairs(page) do
				if v.id == self._targetId or v.layer == self._targetLayerId then
					self._pageIndex = index

					self:_tweenPos(true)

					local curPage = self._layerPageList[self._pageIndex]

					gohelper.setAsLastSibling(curPage.viewGO)
					curPage:playAnim("weekwalklayerpage_in")

					return
				end
			end
		end
	end
end

function WeekWalkLayerView:onClose()
	TaskDispatcher.cancelTask(self._delayHideBtnHelp, self)
	self:_endAmbientSound()

	for i, v in ipairs(self._layerPageList) do
		v:destroyView()
	end

	gohelper.setActive(self._gotopleft, false)
end

function WeekWalkLayerView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

return WeekWalkLayerView
