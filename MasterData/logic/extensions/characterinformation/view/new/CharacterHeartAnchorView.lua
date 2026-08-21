-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorView.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorView", package.seeall)

local M = class("CharacterHeartAnchorView", ViewComponent)

M.PageType = CharacterInfoEnum.AnchorViewPageType

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroupTitle = self:getUIComponent("title_view_-478490097", ComponentType.CanvasGroup)
	self._btnReturn1 = self:getBtn("title_view_-878360263")
	self._btnHome1 = self:getBtn("title_view_1398742689")
	self._btnExplain = self:getBtn("0&title_view_-636449388")
	self._txtReturn = self:getText("title_view_-788888785")
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._imgBg = UIComponentType.ImageBigBG(self:getGo("heart_anchor_view_935866869"))
	self._canvasGroupBgSublimed = self:getUIComponent("heart_anchor_view_-1303490871", ComponentType.CanvasGroup)
	self._canvasGroupQualityRoot = self:getUIComponent("heart_anchor_view_35533236", ComponentType.CanvasGroup)
	self._goQualityEffectLst = {
		[GameEnum.QualityEnum.S] = {
			self:getGo("heart_anchor_view_-498790968"),
			self:getGo("heart_anchor_view_91658299")
		},
		[GameEnum.QualityEnum.A] = {
			self:getGo("heart_anchor_view_-385094711"),
			self:getGo("heart_anchor_view_1278892891")
		},
		[GameEnum.QualityEnum.B] = {
			self:getGo("heart_anchor_view_-1293641507"),
			self:getGo("heart_anchor_view_-593492182")
		},
		[GameEnum.QualityEnum.C] = {
			self:getGo("heart_anchor_view_-661061075"),
			self:getGo("heart_anchor_view_-1536745791")
		}
	}

	local goRoleCombat = goutil.findChild(self.mainGO, "role_combat").gameObject

	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(goRoleCombat, RoleCombatCell)
	self._canvasGroupRoleCombat = goutil.addComponentOnce(goRoleCombat, ComponentType.CanvasGroup)
	self._canvasGroupLevelContent = self:getUIComponent("heart_anchor_view_1219108196", ComponentType.CanvasGroup)
	self._txtImpressionLv = self:getText("heart_anchor_view_-200239226")
	self._txtImpressionMaxLv = self:getText("heart_anchor_view_1069919524")
	self._goExpFill1 = self:getGo("heart_anchor_view_2116476721")
	self._imgExp = self:getImage("heart_anchor_view_-1215171451")
	self._txtImpressionExp = self:getText("heart_anchor_view_-348753872")
	self._btnAddExp = self:getBtn("heart_anchor_view_1434978533")
	self._goRedDotExp = goutil.findChild(self._btnAddExp.gameObject, "red_point")
	self._goExpFill2 = self:getGo("heart_anchor_view_1373785268")
	self._imgExp2 = self:getImage("heart_anchor_view_-2118680543")
	self._txtImpressionExp2 = self:getText("heart_anchor_view_1716608757")
	self._panelRoot = self:getUIComponent("heart_anchor_view_-1136902813", UIComponentType.RectTransform)

	local goCourse = self:getResInstance(ResName.CharacterSystem_heart_anchor_course_view)

	goutil.addChildToParent(goCourse, self._panelRoot)

	local goImpression = self:getResInstance(ResName.CharacterSystem_heart_anchor_impression_view)

	goutil.addChildToParent(goImpression, self._panelRoot)

	self._subView = {
		[M.PageType.CarryItem] = Astral.SimpleLuaComponentContainer.Add(goCourse, CharacterHeartAnchorSubViewCourse),
		[M.PageType.Impression] = Astral.SimpleLuaComponentContainer.Add(goImpression, CharacterHeartAnchorSubViewImpression)
	}

	for _, subView in pairs(self._subView) do
		subView:setVisible(false)
		subView:setHandler(self)
	end
end

function M:destroyUI()
	self:_releaseTween()
	self._imgBg:ClearImage()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
end

function M:bindEvents()
	self._btnReturn1:AddClickListener(self._onClickBack, self)
	self._btnHome1:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnAddExp:AddClickListener(self._onClickAddExp, self)
end

function M:unbindEvents()
	self._btnReturn1:RemoveClickListener()
	self._btnHome1:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnAddExp:RemoveClickListener()
end

function M:onEnter(reasonType)
	self:setEvent(true)

	self._inLevelUp = nil
	self._lastTacitExp = nil
	self._lastTacitLevel = nil

	self:_blockKey(false)
	self:updateHeroBaseInfo()
	self:updateHeroInfo()
	self:refreshRedPoint()

	local defaultPage = M.PageType.CarryItem

	if self._viewPresentor:getIsBackOpen() and self._curPageType then
		defaultPage = self._curPageType
	end

	self:setPage(defaultPage, not self._viewPresentor:getIsBackOpen(), false)
	self:_handleHeroInfoRedDotChange()
	self:showCanvas(self._canvasGroupQualityRoot, true, 0)
	self:showCanvas(self._canvasGroupLevelContent, true, 0)
	self:showCanvas(self._canvasGroupTitle, true, 0)
	self:showCanvas(self._canvasGroupRoleCombat, true, 0)
	TacitAgent.instance:sendGetTaskInfoRequest(self:getCurHeroId())
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	self:_blockKey(true)

	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)
	self:_fillExpTween(false)

	for _, subView in ipairs(self._subView) do
		subView:onExit()
	end

	self:_releaseTween()

	self._lastStrBgView = nil
	self._lastStrBgCourse = nil

	if isNormalClose then
		self._curPageType = nil

		CharacterInformationModel.instance:setImpressionTaskPageIndex(nil)
	end
end

function M:onExitFinished()
	self._imgBg:ClearImage()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._handleTacitRefreshTaskView, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, self._handleTacitAnchorSublimedViewEnter, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_ANCHOR_WAKE_UP_PROCESSING, self._handleTacitAnchorWakeUpProcessing, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self.refreshRedPoint, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._handleTacitRefreshTaskView, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, self._handleTacitAnchorSublimedViewEnter, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_ANCHOR_WAKE_UP_PROCESSING, self._handleTacitAnchorWakeUpProcessing, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self.refreshRedPoint, self)
	end
end

function M:_blockKey(block)
	self._canvasGroup.interactable = not block
	self._btnAddExp.btn.interactable = not block
end

function M:_addTween(tween)
	if not self._tweenLst then
		self._tweenLst = {}
	end

	table.insert(self._tweenLst, tween)
end

function M:_releaseTween()
	self._canvasGroupQualityRoot:DOKill(false)
	self._canvasGroupRoleCombat:DOKill(false)
	self._canvasGroupLevelContent:DOKill(false)
	self._canvasGroupTitle:DOKill(false)

	for _, tween in pairs(self._tweenLst or {}) do
		tween:Kill(false)
	end

	self._tweenLst = nil
end

function M:_handleRefreshHeroDepotData()
	if self._inLevelUp then
		return
	end

	if TacitModel.instance:getRewardingTask() then
		return
	end

	self:updateHeroInfo()
end

function M:_handleHeroInfoRedDotChange(e, heroId)
	return
end

function M:_handleTacitRefreshTaskView(e, rewardingTaskId, markPrimaryTask, isUpgrade)
	self:refreshRedPoint()

	if rewardingTaskId then
		local heroData = self:getCurHeroData()
		local tacitLevel = heroData:getTacit()

		if self._lastTacitLevel == tacitLevel and self._lastTacitExp ~= heroData:getTacitExp() then
			CriwareAudioFacade.instance:playVoiceByAudioId(CharacterInfoEnum.VoiceResKey.haoganrenwu, heroData:getId())
		end
	end
end

function M:_handleTacitAnchorSublimedViewEnter(e, enter, isExistBySublimedFinish)
	self:showCanvas(self._canvasGroupLevelContent, not enter, 0.3)

	if enter then
		self:playGuiAni("heart_anchor_view_promote")
	else
		self:playGuiAni("heart_anchor_view_promote_back")
	end

	self:_updateTitleText()
end

function M:_handleTacitAnchorWakeUpProcessing(e, isProcessing)
	goutil.setActive(self._btnReturn1.gameObject, not isProcessing)
	self:showCanvas(self._canvasGroupRoleCombat, not isProcessing, 0.3)
	self:showCanvas(self._canvasGroupQualityRoot, not isProcessing, 0.3)
	self:showCanvas(self._canvasGroupTitle, not isProcessing, 0.3)
	self:showCanvas(self._canvasGroupBgSublimed, isProcessing, isProcessing and 0.3 or 0.5)
end

function M:_onClickBack()
	if CharacterInformationModel.instance:getInAnchorSublimedView() then
		CharacterInformationModel.instance:setInAnchorSublimedView(false)

		return
	end

	if self._curPageType == M.PageType.Impression then
		local isNormal = true
		local changePage = true

		self:setPage(CharacterInfoEnum.AnchorViewPageType.CarryItem, isNormal, changePage)

		return
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:SetAniTime(0)
	self:back()
end

function M:_onClickHome()
	ViewMgr.instance:close(ViewName.CharacterHeartAnchorView, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickAddExp()
	if not self:_isVaildToImpressionTask() then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_yinxianglicheng, nil, nil, nil)

	local isNormal = true
	local changePage = true

	self:setPage(CharacterInfoEnum.AnchorViewPageType.Impression, isNormal, changePage)
end

function M:playGuiAni(name, isNormal)
	if isNormal == nil then
		isNormal = true
	end

	local timeLineMode = isNormal and Astral.GUITimeLineMode.TimeToStart or Astral.GUITimeLineMode.TimeToEnd

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:SetAniTime(0)
	self._guiAnimation:PlayAniByName(name, timeLineMode)
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return nil
	end

	local data = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	return data
end

function M:getCurHeroId()
	local heroId
	local heroData = self:getCurHeroData()

	if heroData then
		heroId = heroData:getId()
	end

	return heroId
end

function M:_updateTitleText()
	local titleStr

	if CharacterInformationModel.instance:getInAnchorSublimedView() then
		titleStr = lang("tip_tacit_entry_sublimed")
	else
		titleStr = self._curPageType == M.PageType.Impression and lang("tip_tacit_entry_task") or lang("tip_tacit_entry_reshape")
	end

	self._txtReturn.text = titleStr
end

function M:setPage(pageType, isNormal, changePage)
	if self._curPageType and self._curPageType ~= pageType then
		self._subView[self._curPageType]:onExit(isNormal, changePage)
	end

	if changePage or not isNormal then
		if pageType == M.PageType.Impression then
			self:playGuiAni("heart_anchor_view_entry", isNormal)
		elseif pageType == M.PageType.CarryItem then
			self:playGuiAni("heart_anchor_view_out", isNormal)
		end
	else
		for _pageType, subView in pairs(self._subView) do
			subView:setVisible(_pageType == pageType, true)
		end
	end

	self._curPageType = pageType

	self._subView[pageType]:onEnter(isNormal, changePage)
	self:refreshViewBg()
	goutil.setActive(self._goExpFill1, pageType == M.PageType.CarryItem)
	goutil.setActive(self._goExpFill2, pageType == M.PageType.Impression)
	GlobalDispatcher:dispatchEvent(EventType.VIEW_PAGE_CHAGNE_EVENT, ViewName.CharacterHeartAnchorView, pageType)
	self:_updateTitleText()
end

function M:showCanvas(canvas, show, duration)
	if not canvas then
		return
	end

	duration = duration or 0

	if show then
		canvas.alpha = 0

		goutil.setActive(canvas.gameObject, true)
	end

	local finalAlpha = show and 1 or 0

	canvas:DOKill(false)

	if duration > 0 then
		canvas:DOFade(finalAlpha, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	else
		canvas.alpha = finalAlpha
	end

	canvas.interactable = show
	canvas.blocksRaycasts = show
end

function M:refreshViewBg()
	local pageType = self._curPageType

	if pageType == M.PageType.CarryItem then
		-- block empty
	elseif pageType == M.PageType.Impression then
		-- block empty
	end

	self:setBg("yx_bg_0001.jpg")
end

function M:setBg(bgView, bgCourse)
	if self._lastStrBgView and self._lastStrBgView == bgView then
		-- block empty
	else
		self._imgBg:SetImage(GameUrl.getCharacterHeroAnchorBg(bgView), nil, self)
	end

	self._lastStrBgView = bgView

	if not string.nilorempty(bgCourse) then
		if self._lastStrBgCourse and self._lastStrBgCourse == bgCourse then
			-- block empty
		else
			self._subView[M.PageType.CarryItem]:setBg(GameUrl.getCharacterHeroAnchorBg(bgCourse))
		end

		self._lastStrBgCourse = bgCourse
	end
end

function M:updateHeroBaseInfo()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local quality = heroData:getQuality()

	self._roleCombatCell:updateHeroData(heroData)

	for _quality, goLst in pairs(self._goQualityEffectLst) do
		local show = _quality == quality

		for _, _go in ipairs(goLst or {}) do
			goutil.setActive(_go, show)
		end
	end
end

function M:updateHeroInfo()
	local heroData = self:getCurHeroData()
	local tacitLevel = heroData:getTacit()

	if self._lastTacitLevel then
		if self._lastTacitLevel ~= tacitLevel then
			if not self._inLevelUp then
				self:_blockKey(true)

				self._inLevelUp = true
				self._cacheTacitLvUpOrgLevel = self._lastTacitLevel

				printWarn(string.format("心锚印象升级:%s -> %s, exp:%s -> %s", self._lastTacitLevel, tacitLevel, self._lastTacitExp, heroData:getTacitExp()))
				TacitModel.instance:popCacheItemMoList(self._onPopUpItemFinish, self)
				CriwareAudioFacade.instance:playVoiceByAudioId(CharacterInfoEnum.VoiceResKey.haogan, heroData:getId())
			end

			self:_fillExpTween(true, 1, 0.5, self._onExpFillMaxFinish, self)

			return
		elseif self._lastTacitExp ~= heroData:getTacitExp() then
			local tacitExp = heroData:getTacitExp()
			local need = TacitConfig.instance:getUpgradeLevelExp(tacitLevel)
			local curMinExp = TacitConfig.instance:getCurMinExp(tacitLevel)
			local fillAmount = (tacitExp - curMinExp) / (need - curMinExp)

			self:_fillExpTween(true, fillAmount, 0.3, self._onExpFillToFinish, self)
			TacitModel.instance:popCacheItemMoList()

			return
		end
	end

	self:_refreshLvShow()

	if self._inLevelUp then
		self._inLevelUp = false

		TacitAgent.instance:sendGetTaskInfoRequest(self:getCurHeroId(), true)
	end
end

function M:_onPopUpItemFinish()
	self:_blockKey(false)

	local heroData = self:getCurHeroData()

	ToolTipsMgr.showCharacterHeartAnchorImpressionUpgradeResultTips(heroData:getId(), self._cacheTacitLvUpOrgLevel, heroData:getTacit())
end

function M:_onExpFillMaxFinish()
	local orgLevel = self._lastTacitLevel
	local nextLevel = self._lastTacitLevel + 1

	self._tacitExpNeed = TacitConfig.instance:getUpgradeLevelExp(nextLevel)
	self._lastTacitLevel = nextLevel
	self._lastTacitExp = TacitConfig.instance:getUpgradeLevelExp(orgLevel)
	self._imgExp.fillAmount = 0
	self._imgExp2.fillAmount = 0
	self._txtImpressionLv.text = self._lastTacitLevel

	self:updateHeroInfo()
end

function M:_onExpFillToFinish()
	local heroData = self:getCurHeroData()

	self._lastTacitExp = heroData:getTacitExp()

	self:updateHeroInfo()
end

function M:_releaseExpTweener()
	if self._expTweener then
		self._expTweener:Kill(false)
	end

	self._expTweener = nil
end

function M:_fillExpTween(play, fillAmount, duration, finishCB, finishCBHandler)
	self:_releaseExpTweener()

	if play then
		self._expTweener = TweenNumberUtils.FloatToWithGetter(fillAmount, duration, self._getExpFillAmount, self._setExpFillAmount, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
			if finishCB then
				if finishCBHandler then
					finishCB(finishCBHandler)
				else
					finishCB()
				end
			end
		end, self)
	end
end

function M:_getExpFillAmount()
	return self._imgExp.fillAmount
end

function M:_setExpFillAmount(val)
	self._imgExp.fillAmount = val
	self._imgExp2.fillAmount = val

	local nowShowVal = math.floor(self._tacitExpNeed * val)
	local valStr = string.format("%s/%s", nowShowVal, self._tacitExpNeed)

	self._txtImpressionExp.text = valStr
	self._txtImpressionExp2.text = valStr
end

function M:_refreshLvShow()
	local heroData = self:getCurHeroData()
	local tacitLevelMax = TacitConfig.instance:getTacitMaxLevel()
	local tacitLevel = heroData:getTacit()

	self._txtImpressionMaxLv.text = string.format("/%s", tacitLevelMax)

	self:_releaseExpTweener()

	local expFillAmount = 0
	local strLv, strExp

	if tacitLevel == tacitLevelMax then
		expFillAmount = 1
		strLv = tacitLevel
		strExp = ""
	else
		local tacitExp = heroData:getTacitExp()

		self._tacitExpNeed = TacitConfig.instance:getUpgradeLevelExp(tacitLevel)

		local curMinExp = TacitConfig.instance:getCurMinExp(tacitLevel)

		expFillAmount = (tacitExp - curMinExp) / (self._tacitExpNeed - curMinExp)
		strLv = tacitLevel
		strExp = string.format("%s/%s", tacitExp - curMinExp, self._tacitExpNeed - curMinExp)
	end

	self._imgExp.fillAmount = expFillAmount
	self._imgExp2.fillAmount = expFillAmount
	self._txtImpressionLv.text = strLv
	self._txtImpressionExp.text = strExp
	self._txtImpressionExp2.text = strExp
	self._lastTacitExp = heroData:getTacitExp()
	self._lastTacitLevel = tacitLevel
end

function M:refreshRedPoint()
	local showRedTask = false
	local heroData = self:getCurHeroData()

	if heroData then
		local heroId = heroData:getId()
		local impressionSysOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, false)
		local hasImpressionTask = false

		if self:_isVaildToImpressionTask() then
			for i = 1, 3 do
				if hasImpressionTask == false and TacitModel.instance:checkHasRedDot(i) then
					hasImpressionTask = true
				end
			end

			hasImpressionTask = hasImpressionTask or CharacterUtil.isHeroHasTacitTaskCanReceive(heroId, true)
			showRedTask = impressionSysOpen and hasImpressionTask
		end
	end

	goutil.setActive(self._goRedDotExp, showRedTask)
end

function M:flyTaskCellVFXToExp(go)
	if not go then
		return
	end

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.TacitReward)
	settimer(0.5, function()
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.TacitReward)
	end, self, false)

	local uiCam = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local screenPos = uiCam:WorldToScreenPoint(Vector3.New(TransformUtils.GetPosition(go.transform, 0, 0, 0)))
	local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._canvasGroupLevelContent.transform, screenPos.x, screenPos.y, uiCam, 0, 0)
	local clone = goutil.clone(go)

	clone.transform:SetParent(self._canvasGroupLevelContent.transform, false)

	local rectTr = clone:GetComponent(UIComponentType.RectTransform)

	RectTransformUtils.SetAnchoredPosition(rectTr, targetX, targetY)
	goutil.setActive(clone.gameObject, true)
	rectTr:DOAnchorPos(Vector3.New(0, 0, 0), 0.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		rectTr:DOKill(false)
		self:_delayDestroy(rectTr.gameObject, 0.5)

		if self._lastTacitExp and self._lastTacitExp >= TacitConfig.instance:getMaxExp() then
			TacitModel.instance:popCacheItemMoList()
		else
			self:updateHeroInfo()
		end
	end, self)
end

function M:_delayDestroy(go, delay)
	if go and not goutil.isNil(go) then
		local tween = DoTweenUtil.DelayedCall(delay, function()
			if go and not goutil.isNil(go) then
				goutil.destroy(go)
			end
		end, self)

		self:_addTween(tween)
	end
end

function M:_onClickExplain()
	if self._curPageType == M.PageType.CarryItem then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.GuideID.CarryItem
		})
	elseif self._curPageType == M.PageType.Impression then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.GuideID.Impression
		})
	end
end

function M:_isVaildToImpressionTask()
	local heroData = self:getCurHeroData()
	local isVaild = true
	local cfg = TacitConfig.instance:getTacitCO(heroData:getId())

	if not cfg then
		isVaild = false
	elseif cfg.isOnLine <= 0 then
		isVaild = false
	end

	return isVaild
end

return M
