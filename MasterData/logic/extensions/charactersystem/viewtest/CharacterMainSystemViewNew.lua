-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/viewtest/CharacterMainSystemViewNew.lua

module("logic.extensions.charactersystem.viewtest.CharacterMainSystemViewNew", package.seeall)

local M = class("CharacterMainSystemViewNew", ViewComponent)

M.kViewUrls = {
	ResName.CharacterSystem_SubView_Detail,
	ResName.CharacterSystem_SubView_Authority,
	ResName.CharacterSystem_SubView_Equip,
	ResName.CharacterSystem_SubView_Echo,
	ResName.CharacterSystem_SubView_Thinking,
	ResName.CharacterSystem_Voice_Info
}
M.kViewClass = {
	CharacterDetailFragmentViewNew,
	CharacterAuthorityFragmentViewNew,
	CharacterEquipFragmentView,
	CharacterEchoFragmentViewNew,
	CharacterThinkingPanelFragmentView,
	CharacterVoiceAndInfoView
}
M.kSystemOpenEnumList = {
	[CommEnum.CharacterSystemTab.Authority] = GameEnum.SystemEnum.RoleAffinity,
	[CommEnum.CharacterSystemTab.Equip] = GameEnum.SystemEnum.RoleCarryEquip,
	[CommEnum.CharacterSystemTab.EchoItem] = GameEnum.SystemEnum.RoleCarryEcho,
	[CommEnum.CharacterSystemTab.Thinking] = GameEnum.SystemEnum.Thought,
	[CommEnum.CharacterSystemTab.Profile] = GameEnum.SystemEnum.RoleData
}
M.PageData = {
	[CommEnum.CharacterSystemTab.Detail] = {
		enterChangeShow = true,
		showQualityAndSkill = true,
		animPrefix = MainPerformEnum.AnimPrefix.XiangQing,
		SoundEffId = CriwareAudioEnum.ui_shoumiren_xinxi
	},
	[CommEnum.CharacterSystemTab.Authority] = {
		animPrefix = MainPerformEnum.AnimPrefix.QinHeDu,
		SoundEffId = CriwareAudioEnum.ui_shoumiren_qinhedu
	},
	[CommEnum.CharacterSystemTab.Equip] = {
		animPrefix = MainPerformEnum.AnimPrefix.JiaoShiQi,
		SoundEffId = CriwareAudioEnum.ui_shoumiren_jiaoshiqi
	},
	[CommEnum.CharacterSystemTab.EchoItem] = {
		animPrefix = MainPerformEnum.AnimPrefix.CanXiang,
		SoundEffId = CriwareAudioEnum.ui_shoumiren_canxiang
	},
	[CommEnum.CharacterSystemTab.Thinking] = {
		animPrefix = MainPerformEnum.AnimPrefix.Thinking,
		SoundEffId = CriwareAudioEnum.ui_shoumiren_siwei,
		blurBg = {
			downSample = 4,
			iteration = 4,
			camCodeIndex = MainPerformEnum.CharSysCamGroupItemTyp.Thinking
		}
	},
	[CommEnum.CharacterSystemTab.Profile] = {
		animPrefix = MainPerformEnum.AnimPrefix.XiangQing,
		SoundEffId = CriwareAudioEnum.ui_shoumiren_xinxi
	}
}

function M._tabCheckFunc(index)
	return true
end

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Detail)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)

	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._animtorTitle = self:getUIComponent("title_view_-478490097", ComponentType.Animator)
	self._btnReturn = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "title_view/layout/btnReturn_1").gameObject)
	self._btnHome = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "title_view/layout/btnHome_1").gameObject)
	self._btnExplain = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "title_view/layout/btnExplain").gameObject)
	self._blurBg = self:getUIComponent("common_blur_rt_-2028819737", UIComponentType.RawImage)
	self._canvasGroupBg = self:getUIComponent("common_blur_rt_-2028819737", ComponentType.CanvasGroup)
	self._canvasGroupBg.alpha = 0

	goutil.setActive(self._blurBg.gameObject, true)

	self._goMaskNormal = self:getGo("character_system_main_view_copy_2145745893")
	self._goMaskPage = {
		[CommEnum.CharacterSystemTab.Authority] = self:getGo("character_system_main_view_copy_-1191557370")
	}
	self._canvasGroupQualityRoot = self:getUIComponent("character_system_main_view_copy_-2037142996", ComponentType.CanvasGroup)
	self._animationQualtiyAndSkill = self:getUIComponent("character_system_main_view_copy_-758747174", ComponentType.Animation)
	self._goQualityEffectLst = {
		[GameEnum.QualityEnum.S] = {
			self:getGo("character_system_main_view_copy_1171936382"),
			self:getGo("character_system_main_view_copy_2096317299")
		},
		[GameEnum.QualityEnum.A] = {
			self:getGo("character_system_main_view_copy_-1936484082"),
			self:getGo("character_system_main_view_copy_1917621237")
		},
		[GameEnum.QualityEnum.B] = {
			self:getGo("character_system_main_view_copy_439561596"),
			self:getGo("character_system_main_view_copy_1997575497")
		},
		[GameEnum.QualityEnum.C] = {
			self:getGo("character_system_main_view_copy_-1633871923"),
			self:getGo("character_system_main_view_copy_-309729692")
		}
	}
	self._canvasGroupLeftBtm = goutil.addComponentOnce(self:getGo("character_system_main_view_copy_1426692652"), ComponentType.CanvasGroup)
	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(self:getGo("6&role_combat_-1916846192"), RoleCombatCell)
	self._skillCanvasGroup = goutil.addComponentOnce(self:getGo("character_system_main_view_copy_1318565851"), ComponentType.CanvasGroup)
	self._skillBindGo = self:getGo("character_system_main_view_copy_1735963257")

	local skillRoot = self:getUIComponent("character_system_main_view_copy_1318565851", UIComponentType.RectTransform)

	self._skillCells = {}

	for i = 0, skillRoot.childCount - 1 do
		local go = skillRoot:GetChild(i).gameObject

		table.insert(self._skillCells, self:_buildSkillCell(go, i + 1))
	end

	self._btnSkillMore = self:getBtn("character_system_main_view_copy_-1845162826")
	self._goDynPanelRoot = self:getGo("character_system_main_view_copy_602072904")

	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(M.kViewUrls) do
		adapter:registerView(M.kViewUrls[index], M.kViewClass[index])
	end

	self._viewPager = ViewPager.New(self._goDynPanelRoot)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self.setPage, self)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("left_tab_content_-399612422"), LeftTabComp)

	self._tabComp:setActiveTabIndexLst({
		1,
		2,
		3,
		4,
		5,
		6
	})
	self._tabComp:setSystemOpenLst(M.kSystemOpenEnumList)
	self._tabComp:setRedPointTypeWeakly()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:setTabCheckFunc(M._tabCheckFunc)
	self._toggleTabControl:setSystemOpen(M.kSystemOpenEnumList)
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_1", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_2", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_3", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_4", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_5", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_6", UIComponentType.SpaceXToggle))

	self._goAuthoritySmoke = goutil.findChild(self.mainGO, "ui_authority_smoke").gameObject
	self._authoritySmoke = {}

	for i = 1, 5 do
		local tr = goutil.findChild(self.mainGO, string.format("ui_authority_smoke/%s", i))

		if tr then
			local gobj = tr.gameObject

			self._authoritySmoke[i] = gobj

			goutil.setActive(gobj, false)
		end
	end

	self._beginPosition = Vector2.New()
	self._dragGo = self:getGo("character_system_main_view_copy_1885344224")
	self._dragTrigger = Astral.UIDragTrigger.Get(self._dragGo)
	self._btnGuide = self:getBtn("character_system_main_view_copy_-18545926")

	goutil.setActive(self._btnExplain.gameObject, false)
end

function M:destroyUI()
	self._isEnter = nil

	self._viewPager:clear()
	self._viewPager:destroy()

	self._viewPager = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	for i, cell in ipairs(self._skillCells) do
		cell.btnClick:RemoveClickListener()
	end

	self._skillCells = nil

	AuthorityResMgr.instance:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Detail)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnSkillMore:AddClickListener(self._onClickSkillMore, self)
	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
	self._btnGuide:AddClickListener(self._onClickGuide, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnSkillMore:RemoveClickListener()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
	self._btnGuide:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	self._isEnter = true

	local info = self:getFirstParam()

	self._defaultTabIndex = info and info.tabIndex or self._activeIndex or CommEnum.CharacterSystemTab.Detail
	self._defaultTabData = info and info.data or {}
	self._isNormal = not self._viewPresentor:getIsBackOpen() and reasonTyp ~= WindowType.WindowOpenReasonType.QuickOpenType
	self._canvasGroup.interactable = false

	self._tabComp:setCanvasInteractable(false)
	self:updateAirtightTime(AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false))
	MainScenePerformUtil.setBgHeroShow(false, true)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, false)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, false)
	self:setEvent(true)
	self._tabComp:onEnter()

	self._heroAniState = nil
	self._mainUIStatus = true

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	if not viewPageMo and not self._otherPlayerUI then
		local tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
		local index = 1
		local heroData = tmpHeroList:getMoByIndex(index)
		local list = tmpHeroList:getMoList()

		viewPageMo = {
			hero = heroData,
			index = index,
			list = {
				heroData
			}
		}

		HeroDepotModel.instance:setViewPageMo(viewPageMo)
	end

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._heroId = self._heroData:getId()
	self._index = viewPageMo and viewPageMo.index or 0
	self._allHeroList = HeroDepotModel.instance:getShowDataListSort()
	self._maxHeroCount = #self._allHeroList

	if not ViewMgr.instance:isOpen(ViewName.CharacterPreview) and not self._otherPlayerUI then
		HeroPowerAgent.instance:sendHeroPowerInfoRequest(self._heroData:getId())
	end

	if not self._isNormal then
		self._animtorTitle.enabled = true
	else
		self._animtorTitle.enabled = false
	end

	self:_dealCamOnEnter()
	settimer(0, self.onEnterNextFrame, self, false)
end

function M:onEnterNextFrame()
	local isNormal = self._isNormal
	local data = self._defaultTabData

	data.isNormal = isNormal

	local defaultTabIndex = self._defaultTabIndex
	local orgTabIndex

	if not isNormal then
		orgTabIndex = defaultTabIndex
	end

	self._canvasGroup.interactable = true

	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:playGuiAniTab(true, isNormal, defaultTabIndex)
	self:_setCharacterInfoShow(true)
	self:updateCharacterInfo()
	self:updateCharacterSkills()
	self:_changeAdjutantHeroShow(self._heroId, defaultTabIndex, isNormal, false)
	self._viewPager:setPageChangeCallBack(nil, nil)
	self._viewPager:clear()
	self._toggleTabControl:selectTab(defaultTabIndex, data)
	self._viewPager:setPageChangeCallBack(self.setPage, self)
	self:_updatePageData(orgTabIndex, defaultTabIndex, false, true)

	self._activeIndex = defaultTabIndex

	CharacterSystemModel.instance:setPageIndex(self._activeIndex)

	if isNormal then
		TacitAgent.instance:sendGetTaskInfoRequest(self._heroId)
	end

	self:_initTabRedPoint()
	self:updateRedPointShow()
	self:_preloadAndInstance()
end

function M:_dealCamOnEnter()
	local defaultTabIndex = self._defaultTabIndex
	local isOpen = true
	local isNormal = self._isNormal

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), defaultTabIndex, isOpen, isNormal, self._heroId)
end

function M:onExit(reasonTyp)
	self._isEnter = false
	self._canvasGroupBg.alpha = 0
	self._canvasGroup.interactable = false
	self._lastUpdateTimeStamp = nil

	self:releaseTween()

	self._animtorTitle.enabled = true

	self:setEvent(false)
	removetimer(self.onEnterNextFrame, self)
	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), self._activeIndex, false, isNormalClose, self:getCurHeroId())

	if isNormalClose then
		self:playDynamicPageTimeLineAni("close", isNormalClose)

		self._activeIndex = nil

		CharacterSystemModel.instance:setPageIndex(nil)
		ThinkingController.instance:setSelectedThinkingId(nil)

		local info = self:getFirstParam() or {}

		if not info.enterByDepot then
			AirtightRoomController.instance:setPreviewState(nil)
		end
	else
		self:playDynamicPageTimeLineAni(nil, false)
	end

	self._tabComp:playGuiAniTab(false, isNormalClose)
	self._viewPager:getAdapter():getView(self._viewPager:getPage()):inactive()
end

function M:releaseTween()
	self._blurBg:DOKill(false)
	self._canvasGroupBg:DOKill(false)

	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CHARACTER_MAINUI_SHOW_STATUS_CHANGE, self._handleMainUIChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._handleHeroAnimPlay, self)
		GlobalDispatcher:addEventListener(EventType.CONTRACT_BREAKSTATUSCHANGE, self._handleContractBreakStatusChange, self)
		GlobalDispatcher:addEventListener(EventType.HERO_POWER_REFRESH_NODE_INFO, self.updateRedPointShow, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_AUTH_SMOKE_SWITCH, self._setAuthoritySmokeEffect, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_HERO_ANI_REFRESH, self._handleRefreshCharaterSystemHeroAni, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_SUB_PAGE_ANI_FINISH, self._handleSubPageAniFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsOpen, self)
		GlobalDispatcher:addEventListener(EventType.THINKING_HERO_REFRESH, self.updateRedPointShow, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_AUTHORITY_SWITCH, self._changeRoleFromAuthority, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:addEventListener(EventType.LEVELUP_TO_AUTHORITY, self._setAuthority, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAINUI_SHOW_STATUS_CHANGE, self._handleMainUIChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._handleHeroAnimPlay, self)
		GlobalDispatcher:removeEventListener(EventType.CONTRACT_BREAKSTATUSCHANGE, self._handleContractBreakStatusChange, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_POWER_REFRESH_NODE_INFO, self.updateRedPointShow, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_AUTH_SMOKE_SWITCH, self._setAuthoritySmokeEffect, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_HERO_ANI_REFRESH, self._handleRefreshCharaterSystemHeroAni, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_SUB_PAGE_ANI_FINISH, self._handleSubPageAniFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsOpen, self)
		GlobalDispatcher:removeEventListener(EventType.THINKING_HERO_REFRESH, self.updateRedPointShow, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_AUTHORITY_SWITCH, self._changeRoleFromAuthority, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:removeEventListener(EventType.LEVELUP_TO_AUTHORITY, self._setAuthority, self)
	end
end

function M:_onClickReturn()
	if self:getMainUIStatus() then
		self:back()
	else
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_MAINUI_SHOW_STATUS_CHANGE, true, true, false)
	end
end

function M:_handleRefreshCharaterSystemHeroAni()
	self:_dealHeroAnim(self._activeIndex, self._activeIndex, true, 0)
end

function M:_handleHeroInfoRedDotChange()
	CharacterInformationController.instance:checkRedPoint(self._heroData:getId())
end

function M:getMainUIStatus()
	return self._mainUIStatus
end

function M:_handleMainUIChange(_, status, needMoveSpine, isHideCharacter, static, heroChange)
	printWarn(string.format("status[%s] needMoveSpine[%s] isHideCharacter[%s] static[%s] heroChange[%s]", status, needMoveSpine, isHideCharacter, static, heroChange))

	self._mainUIStatus = status

	self._tabComp:setCanvasGroupShow(status)
	self:_setCharacterInfoShow(status)
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:updateAirtightTime(isInAirtightTime)
end

function M:_handleSubPageAniFinish(e, pageIndex, tagName, reason)
	if string.match(tagName, "open") then
		self._tabComp:setCanvasGroupShow(true)
	end
end

function M:updateAirtightTime(isInAirtightTime)
	return
end

function M:_setCharacterInfoShow(show)
	self._canvasGroupLeftBtm.alpha = show and 1 or 0
	self._canvasGroupLeftBtm.interactable = show
	self._canvasGroupLeftBtm.blocksRaycasts = show
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:playDynamicPageTimeLineAni(animName, isNormal)
	local index = self._viewPager:getPage()
	local view = self._viewPager:getAdapter():getView(index)

	if view and view.playGuiAni then
		view:playGuiAni(animName, isNormal)
	end
end

function M:getCurHeroId()
	return self._heroId
end

function M:getCurHeroData(heroId)
	heroId = heroId or self:getCurHeroId()

	local data = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not data then
		printError(string.format("无法找到角色[%s]的数据", heroId))
	end

	return data
end

function M:_handleHeroAnimPlay(e, pointId, elementId, heroId, animState, isInterrupt)
	if heroId ~= self:getCurHeroId() then
		return
	end

	self._heroAniState = animState
end

function M:_handleContractBreakStatusChange(_, isStart)
	return
end

function M:_setAuthority()
	goutil.setActive(self._dragGo, false)
end

function M:setPage(tabIndex)
	local openParam = self:getOpenParam()

	if openParam and openParam[1] then
		openParam[1].tabIndex = tabIndex
	end

	self:releaseTween()

	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_updatePageData(orgIndex, tabIndex, true)
	end

	goutil.setActive(self._dragGo, tabIndex ~= CommEnum.CharacterSystemTab.Authority)
	goutil.setActive(self._btnGuide.gameObject, tabIndex == CommEnum.CharacterSystemTab.Detail)
	goutil.setActive(self._btnExplain.gameObject, tabIndex ~= CommEnum.CharacterSystemTab.Detail)
	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), self._activeIndex, true, true, self:getCurHeroId())
	CharacterSystemModel.instance:setPageIndex(self._activeIndex)
end

function M:_setAuthoritySmokeEffect(e, powerLv)
	if powerLv then
		for i, go in pairs(self._authoritySmoke) do
			goutil.setActive(go, i == powerLv)
		end
	end
end

function M:_updatePageData(orgIndex, tabIndex, isForceRestart, callOnEnter)
	goutil.setActive(self._goAuthoritySmoke, tabIndex == CommEnum.CharacterSystemTab.Authority)
	self:_dealMaskGo(orgIndex, tabIndex)
	self:_dealHeroAnim(orgIndex, tabIndex, isForceRestart, nil)
	self:_dealQualityAndSkill(orgIndex, tabIndex, callOnEnter)
	self:_dealLeftTabComp(orgIndex, tabIndex, callOnEnter)
	self:_dealBlurBg(orgIndex, tabIndex)
	self:_dealSelectSoundEffect(orgIndex, tabIndex)
end

function M:_dealMaskGo(orgIndex, tabIndex)
	local showMaskNormal = true

	for _pageType, go in pairs(self._goMaskPage) do
		local show = _pageType == tabIndex

		goutil.setActive(go, show)
	end

	goutil.setActive(self._goMaskNormal, showMaskNormal)
end

function M:_dealBlurBg(orgIndex, tabIndex)
	self._canvasGroupBg:DOKill(false)
	self._blurBg:DOKill(false)

	self._canvasGroupBg.alpha = 0

	local data = M.PageData[tabIndex]

	if data.blurBg then
		local heroData = self:getCurHeroData()
		local heroId = heroData:getId()
		local modelId = heroData:getModelId()
		local camCode = 0
		local camCodeIndex = data.blurBg.camCodeIndex
		local cfgCamGroup = MainPerformConfig.instance:getHeroCharSysCamGroup(modelId)

		camCode = cfgCamGroup and cfgCamGroup.camIds and #cfgCamGroup.camIds > 0 and cfgCamGroup.camIds[camCodeIndex] and cfgCamGroup.camIds[camCodeIndex] or camCode

		local blurBgView = self._viewPresentor:getBlurBgView()

		blurBgView:setBlur(true, data.blurBg.downSample, data.blurBg.iteration)

		local delay = MainPerformEnum.DefaultCamTweenDurationPredict

		self._delayTween = DoTweenUtil.DelayedCall(delay, function()
			blurBgView:tryCaptureWithCamCode(camCode)

			local duration = 0.4

			self._canvasGroupBg:DOFade(1, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		end)
	end
end

function M:_dealLeftTabComp(orgIndex, tabIndex, callOnEnter)
	local samePage = orgIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = orgIndex and math.abs(orgIndex - tabIndex) <= 1 and 0.2 or duration

	self._tabComp:setCanvasGroupShow(false, 1, CharacterSystemModel.instance:getCharacterSysPageTabDelayTime())

	if not callOnEnter then
		self._tabComp:MoveSelectMark(tabIndex, duration)
	end
end

function M:_dealQualityAndSkill(orgIndex, tabIndex, callOnEnter)
	local data = M.PageData[tabIndex]
	local show = data.showQualityAndSkill
	local animName = show and "quality_open" or "quality_close"

	if not orgIndex or orgIndex < 0 then
		if callOnEnter and not show then
			self._guiAnimation:RemoveTrackBindg("quality", false, true, "open")
			self._animationQualtiyAndSkill:Stop()
			self._animationQualtiyAndSkill:Play(animName)
			AnimationUtils.ResetToLastFrame(self._animationQualtiyAndSkill)
			self._animationQualtiyAndSkill:Stop()
		end

		return
	end

	local samePage = orgIndex == tabIndex
	local lastShow = M.PageData[orgIndex].showQualityAndSkill

	self._canvasGroupQualityRoot.interactable = show
	self._canvasGroupQualityRoot.blocksRaycasts = show

	self._animationQualtiyAndSkill:Stop()

	if lastShow ~= show then
		self._guiAnimation:RemoveTrackBindg("quality", false, true, "open")
		self._animationQualtiyAndSkill:Play(animName)
	elseif samePage then
		self._guiAnimation:RemoveTrackBindg("quality", false, true, "open")
		self._animationQualtiyAndSkill:Play(animName)
		AnimationUtils.ResetToLastFrame(self._animationQualtiyAndSkill)
		self._animationQualtiyAndSkill:Stop()
	end
end

function M:_dealHeroAnim(orgIndex, tabIndex, isForceRestart, mixDuration)
	local nowData = M.PageData[tabIndex]
	local heroId = self:getCurHeroId()
	local prefixNow = nowData.animPrefix

	MainScenePerformUtil.heroAnimSeqPlay(heroId, prefixNow)
end

function M:_dealSelectSoundEffect(orgIndex, tabIndex)
	local samePage = orgIndex == tabIndex

	if samePage then
		return
	end

	local data = M.PageData[tabIndex]

	if data.SoundEffId then
		CriwareAudioFacade.instance:playOnceSEbyId(data.SoundEffId, nil, nil, nil)
	end
end

function M:updateCharacterInfo()
	local heroData = self:getCurHeroData()

	if not heroData then
		return
	end

	self._roleCombatCell:updateHeroData(heroData)
	CharacterInformationModel.instance:getHeroWeight(heroData:getId())

	local quality = heroData:getQuality()

	for _quality, goLst in pairs(self._goQualityEffectLst) do
		local show = _quality == quality

		for _, _go in ipairs(goLst or {}) do
			goutil.setActive(_go, show)
		end
	end
end

function M:_changeAdjutantHeroShow(newHeroId, tabIndex, isNormal, isChange)
	local _charcterCfg = CharacterConfig.instance:getCfgInfoByID(newHeroId)

	if not _charcterCfg then
		return false
	end

	local skinId = CharacterSkinUtil.getHeroUsingSkinId(newHeroId)

	if not self:_heroResourceCheck(newHeroId, skinId, true) then
		-- block empty
	end

	local nowData = M.PageData[tabIndex]
	local prefixNow = nowData.animPrefix
	local forceSet = false
	local mixDuration

	MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, newHeroId, skinId, forceSet, prefixNow, mixDuration, isChange)

	return true
end

function M:_heroResourceCheck(heroId, skinId, showLog)
	local exist = MainScenePerformUtil.getHeroModelAssetExist(heroId, skinId, showLog)

	if not exist then
		return false
	end

	return true
end

function M:updateCharacterSkills()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local skills = heroData:getActiveNormalSkill()
	local skillCount = skills and #skills or 0

	if skillCount > 0 then
		table.sort(skills, function(skillInfo1, skillInfo2)
			local skillCOWrapper1 = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillInfo1.key)
			local skillCOWrapper2 = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillInfo2.key)

			return skillCOWrapper1:getSkillType() < skillCOWrapper2:getSkillType()
		end)
	end

	for i, cell in ipairs(self._skillCells) do
		cell.btnClick:RemoveClickListener()

		local show = i <= skillCount

		if show then
			local skillInfo = skills[i]
			local skillId = skillInfo.key
			local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(heroId, skillId)
			local skillCOWrapper = skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil

			if not skillCOWrapper then
				show = false
			else
				local skillCO = skillCOWrapper:getSkillCO()

				IconLoader.setSprite(cell.imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))

				local signInfo = ActiveSkillCOUtil.getSkillSignInfo(skillCOWrapper:getSkillCode(), nil)

				cell.imgSign:SetSprite(signInfo.spriteName)
				goutil.setActive(cell.imgSign.gameObject, signInfo.isSign)

				cell.skillId = skillId

				cell.btnClick:AddClickListener(function()
					self:_onSkillCellClick(heroId, skillId, cell.go, cell.index)
				end, self)
			end
		end

		goutil.setActive(cell.go, show)
	end
end

function M:_buildSkillCell(tr, index)
	local go = tr.gameObject
	local cell = {}

	cell.go = go
	cell.index = index
	cell.imgIcon = goutil.findChildImageComponent(go, "imgIcon")
	cell.goSelected = goutil.findChild(go, "imgSelect")

	goutil.setActive(goutil.findChild(go, "cdSign"), false)
	goutil.setActive(goutil.findChild(go, "markPassive"), false)

	cell.imgSign = goutil.addComponentOnce(goutil.findChild(go, "passivitySign"), ComponentType.ImageLocalization)

	cell.imgSign:SetSprite("zd_label_0002")

	cell.btnClick = UIComponentType.ButtonAdapter(go)

	return cell
end

function M:_onSkillCellClick(heroId, skillId, cellGo, index)
	local bindGo = self._skillBindGo

	RectTransformUtils.SetPivot(bindGo.transform, 0, 1)

	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = heroId
	skillInfo.skillId = skillId
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = bindGo
	skillInfo.isPassEvent = true
	skillInfo.forceTipsAlignVer = CommEnum.TipsAlignType.Up
	skillInfo.forceAlign = UnityEngine.TextAnchor.LowerLeft

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onSkillTipsOpen(e, isOpen, viewName, skillCode)
	local _skillCode = ViewMgr.instance:isOpen(ViewName.CharacterSkillPreview) and -1 or skillCode

	for _, cell in ipairs(self._skillCells) do
		goutil.setActive(cell.goSelected, isOpen and cell.skillId == _skillCode)
	end
end

function M:_onClickSkillMore()
	CharacterUtil.openCharacterSkillPreview(self._heroId)
end

function M:_changeRoleFromAuthority(e, param)
	if not self._isEnter then
		return
	end

	local orgIndex = self._index

	if param then
		if self._index > 1 then
			self._index = self._index - 1
		else
			self._index = self._maxHeroCount
		end

		if not self:_getHeroByIndex(self._index) then
			self._index = orgIndex
		end
	else
		if self._index < self._maxHeroCount then
			self._index = self._index + 1
		else
			self._index = 1
		end

		if not self:_getHeroByIndex(self._index) then
			self._index = orgIndex
		end
	end
end

function M:_onBeginDrag(evt)
	if not self._isEnter then
		return
	end

	self._beginPosition:Set(0, 0)
	self._beginPosition:Add(evt.position)
end

function M:_onEndDrag(evt)
	if not self._isEnter then
		return
	end

	local position = evt.position
	local deltaX = position.x - self._beginPosition.x
	local orgIndex = self._index

	if deltaX >= 50 then
		if self._index > 1 then
			self._index = self._index - 1
		else
			self._index = self._maxHeroCount
		end

		if not self:_getHeroByIndex(self._index) then
			self._index = orgIndex
		end
	elseif deltaX <= -50 then
		if self._index < self._maxHeroCount then
			self._index = self._index + 1
		else
			self._index = 1
		end

		if not self:_getHeroByIndex(self._index) then
			self._index = orgIndex
		end
	end
end

function M:_getHeroByIndex(index)
	if not self._canvasGroup or not self._canvasGroup.interactable then
		return false
	end

	if not index or not self._allHeroList or not self._allHeroList[index] then
		return false
	end

	local nowTime = tonumber(os.clock())

	if self._lastUpdateTimeStamp and nowTime - self._lastUpdateTimeStamp < 0.5 then
		return
	end

	self._heroData = self._allHeroList[index]
	self._heroId = self._heroData:getId()

	HeroDepotModel.instance:setViewPageMo({
		hero = self._heroData,
		index = index,
		list = self._allHeroList
	})
	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), self._activeIndex, true, self._isNormal, self._heroId)

	local needChangeShow = M.PageData[self._activeIndex].enterChangeShow

	self:_changeAdjutantHeroShow(self._heroId, self._activeIndex, true, needChangeShow)
	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_MAIN_SYSTEM_SWITCH)
	HeroPowerAgent.instance:sendHeroPowerInfoRequest(self._heroData:getId())
	TacitAgent.instance:sendGetTaskInfoRequest(self._heroId)
	self:updateCharacterInfo()
	self:updateCharacterSkills()
	self:updateRedPointShow()

	self._lastUpdateTimeStamp = nowTime

	return true
end

function M:updateRedPointShow()
	local equipHeroData = self._heroData:getHeroEquipData()

	equipHeroData:checkForRedPoint()
	EchoItemController.instance:checkRedPoint()
	ThinkingModel.instance:checkRedPoint(self._heroData:getId())
	self:_handleHeroInfoRedDotChange()
end

function M:_initTabRedPoint()
	if not self._otherPlayerUI then
		local keyList3 = {}

		for index = 1, EquipEnum.MaxPartType do
			local key = string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT, index)

			table.insert(keyList3, key)
		end

		local keyList4 = {}

		table.insert(keyList4, RedDotType.ERedDotKey.ECHO)

		local keyList5 = {}

		table.insert(keyList5, RedDotType.ERedDotKey.Thinking)

		local keyList6 = {}

		table.insert(keyList6, RedDotType.ERedDotKey.PROFILE)

		local redDotLst = {
			[3] = {
				keyList = keyList3
			},
			[4] = {
				keyList = keyList4
			},
			[5] = {
				keyList = keyList5
			},
			[6] = {
				keyList = keyList6
			}
		}

		self._tabComp:setRedDotLst(redDotLst)
	end
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.GuideID.CharacterMain
	})
end

function M:_onClickGuide()
	ViewMgr.instance:open(ViewName.CharacterCareerIntroductionView, 1)
end

function M:_preloadAndInstance()
	local urls = {
		ResName.CharacterSystem_SubView_Authority,
		ResName.CharacterSystem_Authority_Node
	}

	AuthorityResMgr.instance:setResPaths(urls)
	AuthorityResMgr.instance:preload()
	AuthorityResMgr.instance:instantiate(ResName.CharacterSystem_Authority_Node, 25, true)
end

return M
