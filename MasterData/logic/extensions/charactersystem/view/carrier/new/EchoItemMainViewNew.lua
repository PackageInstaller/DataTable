-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainViewNew.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainViewNew", package.seeall)

local M = class("EchoItemMainViewNew", ViewComponent)

M.SubViewType = {
	Break = 2,
	Detail = 3,
	Change = 1
}
M.SubViewComp = {
	EchoLst = 2,
	Filter = 1,
	DetailShow = 4,
	Contrast = 5,
	Node = 3
}
M.BreakPercentFillAmount = {
	nil,
	0.2,
	0.43,
	0.5,
	0.57,
	1
}
M.MoneyShowType = {
	[M.SubViewType.Change] = CommEnum.MoneyShowType.DefaultHideType,
	[M.SubViewType.Break] = CommEnum.MoneyShowType.DiamondMoneyShowType,
	[M.SubViewType.Detail] = CommEnum.MoneyShowType.DefaultHideType
}
M.ShowCardFindBtn = {
	[M.SubViewType.Break] = true,
	[M.SubViewType.Detail] = true
}
M.BreakShowDuration = 0.7
M.BreakPointAnimTime = 1

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)

	self._canvasGroupMain = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._txtTitle = self:getText("12&title_view_-788888785")
	self._btnReturn1 = self:getBtn("12&title_view_-878360263")
	self._btnHome1 = self:getBtn("12&title_view_1398742689")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._rectTrShowPoint = self:getUIComponent("echo_view_copy_1186855734", UIComponentType.RectTransform)
	self._showCardView = Astral.LuaComponentContainer.Add(self:getGo("0&echo_show_card_-997813653"), EchoItemShowCardView)

	self._showCardView:showGyros()
	self._showCardView:setAddBtnVisible(false)
	self._showCardView:setClickFunction(self._onClickEchoFind, self)

	self._posShowPos = {}

	local tmpRectTr1 = self:getUIComponent("echo_view_copy_1982182467", UIComponentType.RectTransform)
	local tmpRectTr2 = self:getUIComponent("echo_view_copy_1639989286", UIComponentType.RectTransform)
	local tmpRectTr3 = self:getUIComponent("echo_view_copy_141449836", UIComponentType.RectTransform)

	self._posShowPos[self.SubViewType.Break] = tmpRectTr1
	self._posShowPos[self.SubViewType.Change] = tmpRectTr2
	self._posShowPos[self.SubViewType.Detail] = tmpRectTr3
	self._goIsEquip = self:getGo("echo_view_copy_1845301560")
	self._goIsEquipVFX = self:getGo("echo_view_copy_1138934696")
	self._btnContrast = self:getBtn("echo_view_copy_92352174")
	self._btnCloseContrast = self:getBtn("echo_view_copy_667761503")
	self._goBreakPanelRoot = self:getGo("echo_view_copy_-1866559403")
	self._goBreakInfoShow = self:getGo("echo_view_copy_1550404457")
	self._goBreakPercentRoot = self:getGo("echo_view_copy_-426360284")
	self._imgBreakPercent = self:getImage("echo_view_copy_81225065")
	self._breakAttrLst = {}

	for i = 0, self._goBreakInfoShow.transform.childCount - 1 do
		local go = self._goBreakInfoShow.transform:GetChild(i).gameObject
		local _level = i + 2

		self._breakAttrLst[_level] = self:_buildBreakAttrCell(go, _level)
	end

	self._goRolePowerPointRoot = goutil.findChild(self.mainGO, "role_combat").gameObject
	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(self._goRolePowerPointRoot, RoleCombatCell)
	self._qualityLightRoot = self:getGo("34&quality_group_bottom_-387807289")

	goutil.setActive(self._qualityLightRoot, true)

	self._qualityLight = {
		[GameEnum.QualityEnum.S] = self:getGo("34&quality_group_bottom_-1559528913"),
		[GameEnum.QualityEnum.A] = self:getGo("34&quality_group_bottom_54871086"),
		[GameEnum.QualityEnum.B] = self:getGo("34&quality_group_bottom_-818086664")
	}
	self._btnPresets = self:getBtn("32&btn_presets_600318579")
	self._goTab = self:getGo("33&left_tab_content_-399612422")

	local tabList = self:getGo("33&left_tab_content_-205429629")

	self._tabBarList = {}

	local count = tabList.transform.childCount

	for i = 1, count do
		local tab = goutil.findChild(tabList, "tab_" .. i)

		if i < 3 then
			local toggleComp = tab:GetComponent(UIComponentType.SpaceXToggle)

			goutil.setActive(tab, true)
			table.insert(self._tabBarList, toggleComp)
		else
			goutil.setActive(tab, false)
		end
	end

	self._tabComp = Astral.LuaComponentContainer.Add(self._goTab, LeftTabComp)

	self:_regLockStats(GameEnum.SystemEnum.HeroPreset, self._btnPresets.gameObject, nil, nil)

	self._subViewComp = {}
	self._subViewComp[M.SubViewComp.Filter] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, EchoItemMainSubViewFilter)
	self._subViewComp[M.SubViewComp.EchoLst] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, EchoItemMainSubViewEchoLst)
	self._subViewComp[M.SubViewComp.Node] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, EchoItemMainSubViewDetailNode)
	self._subViewComp[M.SubViewComp.DetailShow] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, EchoItemMainSubViewDetailShow)
	self._subViewComp[M.SubViewComp.Contrast] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, EchoItemMainSubViewContrast)

	for _, _subViewComp in pairs(self._subViewComp) do
		_subViewComp:setHandler(self)
	end
end

function M:getSubViewComp(compTyp)
	if self._subViewComp then
		return self._subViewComp[compTyp]
	end
end

function M:destroyUI()
	self._subViewComp = nil

	self._showCardView:onExit()

	self._showCardView = nil
	self._posShowPos = nil
	self._baseAttrLst = nil
	self._attrViewList = nil

	for _, cell in pairs(self._breakAttrLst or {}) do
		cell.btnAttr:RemoveClickListener()
	end

	self._breakAttrLst = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
end

function M:bindEvents()
	self._btnReturn1:AddClickListener(self._onClickBack, self)
	self._btnHome1:AddClickListener(self._onClickHome, self)
	self._btnContrast:AddClickListener(self._onClickContrast, self)
	self._btnCloseContrast:AddClickListener(self._onClickCloseContrast, self)
	self._btnPresets:AddClickListener(self._onClickPreinstall, self)

	for index, toggleComp in ipairs(self._tabBarList) do
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index)
			end
		end, nil)
	end
end

function M:unbindEvents()
	self._btnReturn1:RemoveClickListener()
	self._btnHome1:RemoveClickListener()
	self._btnContrast:RemoveClickListener()
	self._btnCloseContrast:RemoveClickListener()
	self._btnPresets:RemoveClickListener()

	for _, toggleComp in ipairs(self._tabBarList) do
		toggleComp:RemoveListener()
	end
end

function M:onEnter(reasonTyp)
	self._guiAnimation:StopTimelineAni()
	self._tabComp:onEnter()
	self:setEvent(true)

	local params = self:getFirstParam() or {}

	self._defaultPageTyp = params.index and params.index or M.SubViewType.Change

	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()
	local echoItemId = echoItemData and echoItemData:getId() or 0

	for _, _subViewComp in pairs(self._subViewComp or {}) do
		_subViewComp:onEnter()
	end

	self._showCardView:onEnter()
	self._showCardView:showGyros()
	self._showCardView:refreshView(echoItemId)
	self._showCardView:setAddBtnVisible(true)
	self._showCardView:updateDynamicEffect(echoItemData)
	self:refreshBaseInfo()

	local readyDefaultPageType = self._defaultPageTyp

	if self._viewPresentor:getIsBackOpen() and self._curShowType then
		readyDefaultPageType = self._curShowType
	end

	self:changeSubPage(readyDefaultPageType)
	self:blockClickCanvasGroup(self._canvasGroupMain, false)

	if params.echoTestView then
		self._showCardView:openEchoTestView()
	end

	self:_handleOnSystemOpen()
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._tabComp:onExit()
	self:setEvent(false)
	self:blockClickCanvasGroup(self._canvasGroupMain, true)
	self:_fillBreakPercent(nil, nil)

	for _, _subViewComp in pairs(self._subViewComp or {}) do
		_subViewComp:onExit()
	end

	EchoItemMainController.instance:clearCostEchoItemForBreakList()

	if isNormalClose then
		EchoItemMainController.instance:setSelectedEchoItem(nil)
	end

	self._lastBlurBgPageType = nil

	removetimer(self._autoRotation, self)
end

function M:onExitFinished()
	self._showCardView:onExit()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_ON_SET_SELECT, self._handleEchoItemOnSetSelect, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._handleEchoCostForBreakSelect, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_MAIN_CHANGE_PAGE_REQ, self._handleChangePageReq, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.ON_ECHO_BREAK_ITEM_LST_SHOW, self._handleEchoBreakItemLstShow, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.MULTI_FUNCITON_VIEW_CLOSE, self._handleFunctionViewClose, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_ON_SET_SELECT, self._handleEchoItemOnSetSelect, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_MAIN_CHANGE_PAGE_REQ, self._handleChangePageReq, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._handleEchoCostForBreakSelect, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ECHO_BREAK_ITEM_LST_SHOW, self._handleEchoBreakItemLstShow, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.MULTI_FUNCITON_VIEW_CLOSE, self._handleFunctionViewClose, self)
	end
end

function M:_regLockStats(key, root, objNormal, objLock)
	if not self._lockStatsGroup then
		self._lockStatsGroup = {}
	end

	local data = {}

	data.root = root.gameObject
	data.normal = objNormal and objNormal.gameObject or nil
	data.lock = objLock and objLock.gameObject or nil
	self._lockStatsGroup[key] = self._lockStatsGroup[key] or {}

	table.insert(self._lockStatsGroup[key], data)
end

function M:_handleOnSystemOpen()
	for key, group in pairs(self._lockStatsGroup or {}) do
		for _, data in ipairs(group) do
			local showOnLock = SystemOpenFacade.instance:isShowOnLock(key)
			local isOpen = SystemOpenFacade.instance:isOpen(key)

			if key == GameEnum.SystemEnum.HeroPreset then
				isOpen = isOpen and self._curShowType ~= M.SubViewType.Break

				goutil.setActive(data.root, isOpen)
			else
				goutil.setActive(data.root, isOpen or showOnLock and not isOpen)

				if data.lock then
					goutil.setActive(data.lock, not isOpen)
				end

				if data.normal then
					goutil.setActive(data.normal, isOpen)
				end
			end
		end
	end
end

function M:_handleEchoItemOnSetSelect(e, echoItemData)
	self:refreshShowCardView(echoItemData and echoItemData:getId() or 0)
	self:refreshRightTopBtn()

	echoItemData = echoItemData or EchoItemMainController.instance:getSelectedEchoItem()

	self:refreshQualityLight(echoItemData and echoItemData:getQuality() or GameEnum.QualityEnum.D)
end

function M:_handleChangePageReq(e, pageType)
	local resetPos = false
	local needPlayItemCellOpenAni = false

	self:changeSubPage(pageType, resetPos, needPlayItemCellOpenAni)
end

function M:_handleEchoItemInfoRefresh(e, isUpgrade)
	if isUpgrade then
		self:blockClickCanvasGroup(self._canvasGroupMain, true, M.BreakShowDuration + M.BreakPointAnimTime)
		self:refreshBreakInfoShow(true)
	end
end

function M:_handleRefreshHeroDepotData(e, heroData)
	self:refreshRightTopBtn()
end

function M:_handleEchoCostForBreakSelect(e, echoItemDataList, isUpgrade)
	local len = echoItemDataList and #echoItemDataList or 0

	if len > 0 then
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_canxiangtupozhong, nil, nil, nil)
		self._showCardView:playAnimByName("echo_card_rising")
	else
		self._showCardView:setUpgradeReadyVFXVisible(false)

		if not isUpgrade then
			self._showCardView:resetAnimByName("echo_show_card_open")
		end
	end
end

function M:_handleEchoBreakItemLstShow(e, show, byUpgrading)
	if byUpgrading then
		return
	end

	self._showCardView:setEnabledRaycast(not show)
end

function M:_onClickEchoFind(echoItemId)
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	ViewMgr.instance:open(ViewName.EchoFullScreenPreview, echoItemData)
end

function M:_onClickBack()
	if self._defaultPageTyp and self._curShowType ~= self._defaultPageTyp then
		self:changeSubPage(self._defaultPageTyp)

		return
	end

	self:setEvent(false)
	self:back()
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickContrast()
	if self._curShowType ~= M.SubViewType.Change then
		return
	end

	if self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Contrast):getIsActive() then
		return
	end

	local curSelectedEcho = EchoItemMainController.instance:getSelectedEchoItem()
	local curEquipEcho = EchoItemController.instance:getCurHeroEchoItem()

	if curSelectedEcho and curEquipEcho then
		self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Contrast):setIsActive(true)
		self:refreshRightTopBtn()
	end
end

function M:_onClickCloseContrast()
	if self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Contrast):getIsActive() then
		self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Contrast):setIsActive(false)
		self:refreshRightTopBtn()
	end
end

function M:_onClickPreinstall()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.HeroPreset, true) then
		return
	end

	ViewMgr.instance:open(ViewName.CharacterPreinstallView, self:getHeroId(), 2)
end

function M:refreshShowCardView(echoId)
	echoId = echoId or 0

	self._showCardView:refreshView(echoId)
	self._showCardView:playAnimByName("echo_show_card_open")

	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	self._showCardView:updateDynamicEffect(echoItemData)
end

function M:refreshQualityLight(quality)
	for _quality, go in pairs(self._qualityLight or {}) do
		goutil.setActive(go, _quality == quality)
	end
end

function M:refreshBaseInfo()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	self._roleCombatCell:updateHeroData(heroData)
end

function M:getHeroId()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		return heroData:getId()
	end

	return nil
end

function M:getHeroModelId()
	local modelId
	local heroId = self:getHeroId()

	if heroId then
		local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		modelId = heroData:getModelId()
	end

	return modelId
end

function M:changeSubPage(typ, resetPos, playOpenAni)
	self._curShowType = typ

	local guiAnimName = typ == M.SubViewType.Break and "open_tupo" or "open2"

	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:SetAniTime(0)
	self:refreshPanelPos(typ)
	self:refreshBlurBg(typ)
	self._showCardView:resetAnimByName("echo_show_card_open")
	self._showCardView:setUpgradeVFXVisible(false)
	self._showCardView:setUpgradeReadyVFXVisible(false)
	goutil.setActive(self._goRolePowerPointRoot, typ == M.SubViewType.Change)
	goutil.setActive(self._goBreakInfoShow, typ == M.SubViewType.Break)
	goutil.setActive(self._goBreakPercentRoot, typ == M.SubViewType.Break)
	goutil.setActive(self._qualityLightRoot, typ ~= M.SubViewType.Change)

	if typ == M.SubViewType.Detail then
		self._txtTitle.text = lang("t_echo_wuyu")
	elseif typ == M.SubViewType.Break then
		self._txtTitle.text = lang("t_echo_break")
	else
		self._txtTitle.text = lang("t_echo_puton")
	end

	local echoLst = {}

	if typ == EchoItemMainViewNew.SubViewType.Change then
		echoLst = self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Filter):getFilterEchoItemData()

		local selectedEcho = EchoItemMainController.instance:getSelectedEchoItem()

		if typ == M.SubViewType.Change then
			echoLst = self:getSubViewComp(M.SubViewComp.Filter):getFilterEchoItemData()

			if not selectedEcho then
				selectedEcho = echoLst[1]
			end
		end

		EchoItemMainController.instance:setSelectedEchoItem(selectedEcho)
	elseif typ == EchoItemMainViewNew.SubViewType.Break then
		EchoItemMainController.instance:clearCostEchoItemForBreakList()
		self:refreshBreakInfoShow(false)
		EchoItemMainController.instance:updateAvailableEchoItem()

		echoLst = EchoItemMainController.instance:getAvailableEchoItem():getMoList()
	end

	self._guiAnimation:PlayAniByName(guiAnimName)

	for _, _subViewComp in ipairs(self._subViewComp or {}) do
		_subViewComp:onPageTypChange(typ, echoLst)
	end

	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, M.MoneyShowType[typ] or CommEnum.MoneyShowType.DefaultHideType)
	self._showCardView:setAddBtnVisible(false)
	self:refreshRightTopBtn()

	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	self:refreshQualityLight(echoItemData and echoItemData:getQuality() or GameEnum.QualityEnum.D)
	self:_updateToggle()
end

function M:refreshPanelPos(typ)
	local anchoredPos_showP = self._posShowPos[typ].anchoredPosition or {
		x = 0,
		y = 0
	}
	local scale_showP = self._posShowPos[typ].localScale or {
		z = 1,
		x = 1,
		y = 1
	}

	Astral.TransformUtil.SetAnchoredPos(self._rectTrShowPoint, anchoredPos_showP.x, anchoredPos_showP.y)
	Astral.TransformUtil.SetLocalScale(self._rectTrShowPoint, scale_showP.x, scale_showP.y, scale_showP.z)
end

function M:refreshBlurBg(typ)
	local withCharacter = typ == M.SubViewType.Change and 1 or 0
	local needRefresh = self._lastBlurBgPageType ~= withCharacter

	self._lastBlurBgPageType = withCharacter

	if not needRefresh then
		return
	end

	local camCode = 0
	local layerMask

	if withCharacter == 1 then
		camCode = self:getCamCode(self:getHeroModelId())
		layerMask = Astral.LayerUtil.GetLayerMask(SceneLayer.Default_Value, SceneLayer.Stone_Value, SceneLayer.Unit_Value)
	else
		layerMask = Astral.LayerUtil.GetLayerMask(SceneLayer.Default_Value, SceneLayer.Stone_Value)
	end

	self._viewPresentor:captureBg(camCode, layerMask)
end

function M:getCamCode(modelId)
	local index = MainPerformEnum.CharSysCamGroupItemTyp.Echo
	local cfgCamGroup = MainPerformConfig.instance:getHeroCharSysCamGroup(tonumber(modelId))

	if cfgCamGroup and cfgCamGroup.camIds and #cfgCamGroup.camIds > 0 then
		return cfgCamGroup.camIds[index] or 0
	end

	return 0
end

function M:refreshRightTopBtn()
	local curSelectedEcho = EchoItemMainController.instance:getSelectedEchoItem()
	local curEquipEcho = EchoItemController.instance:getCurHeroEchoItem()
	local isSelectedEquip = curSelectedEcho and curEquipEcho and curSelectedEcho:getUuid() == curEquipEcho:getUuid()
	local isShowingContrast = self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Contrast):getIsActive()

	if isSelectedEquip and isShowingContrast then
		self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Contrast):setIsActive(false)

		isShowingContrast = false
	end

	local showIsEquipMark = self._curShowType == M.SubViewType.Change and isSelectedEquip

	goutil.setActive(self._goIsEquip, showIsEquipMark)
	goutil.setActive(self._goIsEquipVFX, false)

	if showIsEquipMark then
		goutil.setActive(self._goIsEquipVFX, showIsEquipMark)
	end

	goutil.setActive(self._btnContrast.gameObject, self._curShowType == M.SubViewType.Change and curEquipEcho and not isShowingContrast and not isSelectedEquip)
	goutil.setActive(self._btnCloseContrast.gameObject, self._curShowType == M.SubViewType.Change and curEquipEcho and isShowingContrast)
end

function M:_buildBreakAttrCell(go, _level)
	local cell = {}

	cell.go = go
	cell.level = _level
	cell.canvasGroup = goutil.findChildComponent(go, "subRoot", ComponentType.CanvasGroup)
	cell.txtAttr = goutil.findChildComponent(go, "subRoot/txtBreakAttribute_1", UIComponentType.TextMeshProUGUI)
	cell.btnAttr = UIComponentType.ButtonAdapter(goutil.findChild(go, "subRoot/txtBreakAttribute_1/click").gameObject)
	cell.breakPointView = Astral.LuaComponentContainer.Add(goutil.findChild(go, "subRoot/break_point").gameObject, EchoItemBreakPointView)
	cell.goBreakVFX = goutil.findChild(go, "vfx").gameObject

	function cell.setData(data, echoMaxLv)
		local unlockLevel = EchoItemConfig.instance:getUnlockDynamicEffectLevel(data.quality)
		local isBreak = data.level >= cell.level

		if unlockLevel == cell.level then
			cell.txtAttr.text = langF("tip_echo_unlock_dynamic", data.desc)
		else
			cell.txtAttr.text = data.desc
		end

		cell.breakPointView:setEchoItemLevel(cell.level, echoMaxLv)

		cell.canvasGroup.alpha = isBreak and 1 or 0.15
	end

	function cell.showVfx(show)
		goutil.setActive(cell.goBreakVFX, false)

		if show then
			goutil.setActive(cell.goBreakVFX, true)
		end
	end

	cell.btnAttr:AddClickListener(function()
		self:_onClickCellBreakAttr(cell)
	end, self)

	return cell
end

function M:_onClickCellBreakAttr(cell)
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		return
	end

	local skillEnhanceMo = EchoItemConfig.instance:getAttrSkillEnhanceMO(echoItemData:getId(), cell.level)

	if skillEnhanceMo then
		local bindGo = cell.btnAttr.gameObject
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMo, bindGo, isPassEvent)
	end
end

function M:_handleFunctionViewClose()
	settimer(0.5, self._autoRotation, self, false)
end

function M:_autoRotation()
	self._showCardView:autoRotation()
end

function M:refreshBreakInfoShow(isBreakUpdate)
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		return
	end

	self._showCardView:updateDynamicEffect(echoItemData)

	local echoMaxLv = echoItemData:getMaxLevel()
	local echoCurLv = echoItemData:getLevel()

	for _lv, cell in pairs(self._breakAttrLst) do
		local isBreak = echoCurLv >= cell.level
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local highLightTagIds
		local data = {
			level = echoCurLv,
			descSplit = descSplit,
			quality = echoItemData:getQuality(),
			desc = EchoItemConfig.instance:getAttrDesc(echoItemData:getId(), cell.level, colorAttr, colorSkill, descSplit, highLightTagIds)
		}

		cell.showVfx(false)

		if isBreakUpdate and echoCurLv == cell.level then
			cell.showVfx(true)
		end

		cell.setData(data, echoMaxLv)
	end

	local fillAmount = M.BreakPercentFillAmount[echoCurLv] or 0
	local duration = isBreakUpdate and M.BreakShowDuration or 0

	self:_fillBreakPercent(fillAmount, duration, function()
		self:getSubViewComp(M.SubViewComp.Node):refreshBaseInfo(true, isBreakUpdate)
	end, self)

	if isBreakUpdate then
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_canxiangtupowancheng, nil, nil, nil)
		self._showCardView:playAnimByName("echo_card_fall_vfx")
	end
end

function M:_fillBreakPercent(fillAmount, duration, finishCB, finishCBHandler)
	self._imgBreakPercent:DOKill()

	duration = duration or 0
	fillAmount = fillAmount or self._imgBreakPercent.fillAmount

	if duration > 0 then
		self._imgBreakPercent:DOFillAmount(fillAmount, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnUpdate(self._expAniUpdate, self):OnComplete(function()
			if finishCB then
				if finishCBHandler then
					finishCB(finishCBHandler)
				else
					finishCB()
				end
			end
		end, self)
	else
		self._imgBreakPercent.fillAmount = fillAmount
	end
end

function M:blockClickCanvasGroup(canvasGroup, isBlock, autoReleaseDuration)
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil
	canvasGroup.interactable = not isBlock

	self._showCardView:setEnabledRaycast(not isBlock)

	if isBlock and autoReleaseDuration then
		self._delayTween = DoTweenUtil.DelayedCall(autoReleaseDuration, function()
			self:blockClickCanvasGroup(canvasGroup, false)
		end)
	end
end

function M:_dealToggleClick(index)
	local samePage = self._curTabIndex and self._curTabIndex == index

	self._tabComp:MoveSelectMark(index, samePage and 0 or 0.3)

	if self._curTabIndex and self._curTabIndex == index then
		return
	end

	self._curTabIndex = index

	local type = self._curTabIndex == 1 and M.SubViewType.Break or M.SubViewType.Detail
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	self:changeSubPage(type)
end

function M:_updateToggle()
	local isShowToggle = self._curShowType == M.SubViewType.Break or self._curShowType == M.SubViewType.Detail

	goutil.setActive(self._goTab, isShowToggle)
	goutil.setActive(self._btnPresets.gameObject, self._curShowType == M.SubViewType.Change)

	if not isShowToggle then
		self._curTabIndex = nil

		return
	end

	self._curTabIndex = self._curShowType == M.SubViewType.Break and 1 or 2
	self._tabBarList[self._curTabIndex].IsOn = true
end

return M
