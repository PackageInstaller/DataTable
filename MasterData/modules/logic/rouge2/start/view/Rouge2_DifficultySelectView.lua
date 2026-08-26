-- chunkname: @modules/logic/rouge2/start/view/Rouge2_DifficultySelectView.lua

module("modules.logic.rouge2.start.view.Rouge2_DifficultySelectView", package.seeall)

local Rouge2_DifficultySelectView = class("Rouge2_DifficultySelectView", BaseView)

Rouge2_DifficultySelectView.PercentColor = "#CE6A51"
Rouge2_DifficultySelectView.BracketColor = "#5E7DD9"

function Rouge2_DifficultySelectView:onInitView()
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "Middle/#scroll_List")
	self._goContent = gohelper.findChild(self.viewGO, "Middle/#scroll_List/Viewport/#go_Content")
	self._goPageItem = gohelper.findChild(self.viewGO, "Middle/#scroll_List/Viewport/#go_Content/#go_PageItem")
	self._btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_RightArrow", AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	self._btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_LeftArrow", AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	self._txtDescr = gohelper.findChildText(self.viewGO, "Setting/#txt_Descr")
	self._txtDescr2 = gohelper.findChildText(self.viewGO, "Reward/#txt_Descr")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_Start", AudioEnum.Rouge2.NextStep)
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Block")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_DifficultySelectView:addEvents()
	self._btnRightArrow:AddClickListener(self._btnRightArrowOnClick, self)
	self._btnLeftArrow:AddClickListener(self._btnLeftArrowOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goContent)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectDifficulty, self._onSelectDifficulty, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSwitchDifficultyPage, self._onSwitchDifficultyPage, self)
end

function Rouge2_DifficultySelectView:removeEvents()
	self._btnRightArrow:RemoveClickListener()
	self._btnLeftArrow:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
end

function Rouge2_DifficultySelectView:_btnRightArrowOnClick()
	local isSucc, toastId = Rouge2_DifficultySelectListModel.instance:switchPage(true)

	if not isSucc and toastId then
		GameFacade.showToast(toastId)
	end
end

function Rouge2_DifficultySelectView:_btnLeftArrowOnClick()
	local isSucc, toastId = Rouge2_DifficultySelectListModel.instance:switchPage(false)

	if not isSucc and toastId then
		GameFacade.showToast(toastId)
	end
end

function Rouge2_DifficultySelectView:_btnStartOnClick()
	if not self._difficultyId then
		return
	end

	local highDifficulty = tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.HighDifficulty].value)

	if highDifficulty and highDifficulty <= self._difficultyId then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.Rouge2HighDifficulty, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self._sendRpc2SelectDifficulty, nil, nil, self)

		return
	end

	self:_sendRpc2SelectDifficulty()
end

function Rouge2_DifficultySelectView:_sendRpc2SelectDifficulty()
	Rouge2_Rpc.instance:sendEnterRouge2SelectDifficultyRequest(self._difficultyId, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		self.animator:Play("close", 0, 0)

		self.isPlayingCloseAnim = true

		Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
		Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SceneSwitch, Rouge2_OutsideEnum.SceneIndex.CareerScene)
	end)
end

function Rouge2_DifficultySelectView:onSceneSwitchFinish()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	Rouge2_ViewHelper.openCareerSelectView()
	self:closeThis()
end

function Rouge2_DifficultySelectView:_onDragBegin(param, pointerEventData)
	self._startDragPosition = pointerEventData.position
end

function Rouge2_DifficultySelectView:_onDragEnd(param, pointerEventData)
	self._startDragPosition = nil
end

function Rouge2_DifficultySelectView:_onDrag(param, pointerEventData)
	if not self._startDragPosition then
		return
	end

	local dragOffset = pointerEventData.position.x - self._startDragPosition.x

	if Mathf.Abs(dragOffset) < Rouge2_Enum.MinSwitchPageOffset then
		return
	end

	self._startDragPosition = nil

	local isSwitchNext = dragOffset < 0

	Rouge2_DifficultySelectListModel.instance:switchPage(isSwitchNext)
end

function Rouge2_DifficultySelectView:_editableInitView()
	Rouge2_MapLocalDataHelper.clear()
	gohelper.setActive(self._goBlock, false)
	gohelper.setActive(self._goPageItem, false)

	self._goLeftArrow = self._btnLeftArrow.gameObject
	self._goRightArrow = self._btnRightArrow.gameObject
	self._tranScroll = self._scrollList.transform
	self._tranContent = self._goContent.transform

	SkillHelper.addHyperLinkClick(self._txtDescr)
	SkillHelper.addHyperLinkClick(self._txtDescr2)

	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_DifficultySelectView:onOpen()
	self.animator:Play("open", 0, 0)
	Rouge2_DifficultySelectListModel.instance:init()
	self:initDifficultyItemList()
end

function Rouge2_DifficultySelectView:_onSelectDifficulty(difficultyId)
	self._difficultyId = difficultyId
	self._difficultyCo = Rouge2_Config.instance:getDifficultyCoById(difficultyId)

	self:refreshUI()
end

function Rouge2_DifficultySelectView:_onSwitchDifficultyPage(pageIndex)
	self:tweenSwitchPageItem(pageIndex)
end

function Rouge2_DifficultySelectView:tweenSwitchPageItem(pageIndex)
	if self._pageItemTab then
		if not self._pageItemTab then
			return
		end

		self:killTween()
		gohelper.setActive(self._goBlock, true)

		local targetContentPosX = self:pageIndex2ContentPosX(pageIndex)

		if self._curPageIndex then
			if not Rouge2_Enum.TweenSwitchPageDuration then
				local duration = 0

				self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._tranContent, targetContentPosX, duration, self._tweenDoneCallback, self, nil, EaseType.OutCubic)
				self._curPageIndex = pageIndex

				self:refreshArrows()
			end
		end
	end
end

function Rouge2_DifficultySelectView:_tweenDoneCallback()
	gohelper.setActive(self._goBlock, false)
end

function Rouge2_DifficultySelectView:pageIndex2ContentPosX(pageIndex)
	if self._pageItemTab then
		local pageItem = self._pageItemTab[pageIndex]
		local pageTran = pageItem.go.transform
		local itemLocalPosX = recthelper.rectToRelativeAnchorPos2(pageTran.position, self._tranScroll)
		local contentLocalPosX = recthelper.getAnchorX(self._tranContent)

		return contentLocalPosX - itemLocalPosX
	end
end

function Rouge2_DifficultySelectView:initDifficultyItemList()
	self._pageItemTab = self:getUserDataTb_()

	local pageMoList = Rouge2_DifficultySelectListModel.instance:getList() or {}

	for index, pageMo in ipairs(pageMoList) do
		local gopage = gohelper.cloneInPlace(self._goPageItem, "page_" .. index)
		local pageItem = MonoHelper.addNoUpdateLuaComOnceToGo(gopage, Rouge2_DifficultyPageItem, self)

		pageItem:onUpdateMO(pageMo)

		self._pageItemTab[index] = pageItem
	end

	ZProj.UGUIHelper.RebuildLayout(self._tranContent)
	Rouge2_DifficultySelectListModel.instance:selectNewestDifficulty()
end

function Rouge2_DifficultySelectView:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Rouge2_DifficultySelectView:refreshUI()
	if not self._difficultyCo then
		return
	end

	local desc = self._difficultyCo.desc

	self._txtDescr.text = Rouge2_ItemDescHelper.buildDesc(desc, Rouge2_DifficultySelectView.PercentColor, Rouge2_DifficultySelectView.BracketColor)

	local scoreReward = self._difficultyCo.scoreReward
	local scroreRewardStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_difficultyselectview_reward"), scoreReward)

	self._txtDescr2.text = Rouge2_ItemDescHelper.buildDesc(scroreRewardStr, Rouge2_DifficultySelectView.PercentColor, Rouge2_DifficultySelectView.BracketColor)
end

function Rouge2_DifficultySelectView:refreshArrows()
	local goEnableLeft = gohelper.findChild(self._goLeftArrow, "enable")
	local goDisenableLeft = gohelper.findChild(self._goLeftArrow, "disable")
	local goEnableRight = gohelper.findChild(self._goRightArrow, "enable")
	local goDisenableRight = gohelper.findChild(self._goRightArrow, "disable")
	local canSwitch2Pre = Rouge2_DifficultySelectListModel.instance:canSwitchPage(false)
	local canSwitch2Next = Rouge2_DifficultySelectListModel.instance:canSwitchPage(true)

	gohelper.setActive(goEnableLeft, canSwitch2Pre)
	gohelper.setActive(goDisenableLeft, not canSwitch2Pre)
	gohelper.setActive(goEnableRight, canSwitch2Next)
	gohelper.setActive(goDisenableRight, not canSwitch2Next)

	local isPrePage = Rouge2_DifficultySelectListModel.instance:isIndexValid(false)
	local isNextPage = Rouge2_DifficultySelectListModel.instance:isIndexValid(true)

	gohelper.setActive(self._goLeftArrow, isPrePage)
	gohelper.setActive(self._goRightArrow, isNextPage)
end

function Rouge2_DifficultySelectView:onClose()
	self:killTween()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchDifficultyPage, nil)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)

	if not self.isPlayingCloseAnim then
		self.animator:Play("close", 0, 0)
	end
end

function Rouge2_DifficultySelectView:onDestroyView()
	return
end

return Rouge2_DifficultySelectView
