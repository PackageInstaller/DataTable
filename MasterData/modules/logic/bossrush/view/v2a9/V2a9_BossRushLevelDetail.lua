-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushLevelDetail.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushLevelDetail", package.seeall)

local V2a9_BossRushLevelDetail = class("V2a9_BossRushLevelDetail", V1a4_BossRushLevelDetail)

function V2a9_BossRushLevelDetail:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._gospines = gohelper.findChild(self.viewGO, "#go_spines")
	self._goAssassinNormalMask = gohelper.findChild(self.viewGO, "BG/#go_AssassinNormalMask")
	self._goAssassinHardMask = gohelper.findChild(self.viewGO, "BG/#go_AssassinHardMask")
	self._goNormalMask = gohelper.findChild(self.viewGO, "BG/#go_NormalMask")
	self._goHardMask = gohelper.findChild(self.viewGO, "BG/#go_HardMask")
	self._goHardBG = gohelper.findChild(self.viewGO, "BG/#go_HardBG")
	self._simageLeftBG = gohelper.findChildSingleImage(self.viewGO, "BG/#go_HardBG/#simage_LeftBG")
	self._simageRightBG = gohelper.findChildSingleImage(self.viewGO, "BG/#go_HardBG/#simage_RightBG")
	self._btnSimple = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Simple")
	self._btnHard = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Hard")
	self._btnAssassinSimple = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_AssassinSimple")
	self._btnAssassinHard = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_AssassinHard")
	self._btnbonus = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_bonus")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/#btn_bonus/#go_AssessIcon")
	self._goRedPoint1 = gohelper.findChild(self.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	self._txtTitle = gohelper.findChildText(self.viewGO, "DetailPanel/Title/#txt_Title")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "DetailPanel/Title/#txt_Title/#simage_Title")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "DetailPanel/Title/#txt_Title/#image_IssxIcon")
	self._btnSearchIcon = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Title/#txt_Title/#btn_SearchIcon")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#scroll_desc")
	self._txtDescr = gohelper.findChildText(self.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	self._txtLvNum = gohelper.findChildText(self.viewGO, "DetailPanel/Attention/Lv/#txt_LvNum")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#btn_Go")
	self._txtDoubleTimes = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	self._gomask = gohelper.findChild(self.viewGO, "mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushLevelDetail:addEvents()
	self._btnSimple:AddClickListener(self._btnSimpleOnClick, self)
	self._btnHard:AddClickListener(self._btnHardOnClick, self)
	self._btnAssassinSimple:AddClickListener(self._btnAssassinSimpleOnClick, self)
	self._btnAssassinHard:AddClickListener(self._btnAssassinHardOnClick, self)
	self._btnbonus:AddClickListener(self._btnbonusOnClick, self)
	self._btnSearchIcon:AddClickListener(self._btnSearchIconOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, self._onBtnGoEnter, self)
end

function V2a9_BossRushLevelDetail:removeEvents()
	self._btnSimple:RemoveClickListener()
	self._btnHard:RemoveClickListener()
	self._btnAssassinSimple:RemoveClickListener()
	self._btnAssassinHard:RemoveClickListener()
	self._btnbonus:RemoveClickListener()
	self._btnSearchIcon:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, self._onBtnGoEnter, self)
end

local TabEnum = {
	Second = 2,
	First = 1
}
local LayerTabEnum = {
	[BossRushEnum.LayerEnum.Endless] = TabEnum.First,
	[BossRushEnum.LayerEnum.V2a9] = TabEnum.Second
}
local V2a9StageInfo = {
	[BossRushEnum.V2a9StageEnum.First] = {
		[TabEnum.First] = {
			color2 = "#463d3a",
			color3 = "#fffbf4",
			color1 = "#6d6d6d",
			alpha = 0.3
		},
		[TabEnum.Second] = {
			color2 = "#fffbf4",
			color3 = "#fffbf4",
			color1 = "#cac7c2",
			alpha = 0.3
		}
	},
	[BossRushEnum.V2a9StageEnum.Second] = {
		[TabEnum.First] = {
			color2 = "#beb9a6",
			color3 = "#beb9a6",
			color1 = "#6d6d6d",
			alpha = 0.5
		},
		[TabEnum.Second] = {
			color2 = "#beb9a6",
			color3 = "#beb9a6",
			color1 = "#6d6d6d",
			alpha = 0.5
		}
	}
}

function V2a9_BossRushLevelDetail:_btnSimpleOnClick()
	self:_setSelect(TabEnum.First, true)
end

function V2a9_BossRushLevelDetail:_btnHardOnClick()
	self:_setSelect(TabEnum.Second, true)
end

function V2a9_BossRushLevelDetail:_btnAssassinSimpleOnClick()
	self:_setSelect(TabEnum.First, true)
end

function V2a9_BossRushLevelDetail:_btnAssassinHardOnClick()
	self:_setSelect(TabEnum.Second, true)
end

function V2a9_BossRushLevelDetail:_btnGoOnClick()
	local stage, layer = self:_getStageAndLayer()

	if V2a9BossRushModel.instance:isV2a9SecondStageSpecialLayer(stage, layer) then
		OdysseyRpc.instance:sendOdysseyGetInfoRequest(self._btnGoOnClickCB, self)
	else
		self:_btnGoOnClickCB()
	end
end

function V2a9_BossRushLevelDetail:_btnGoOnClickCB()
	local stage, layer = self:_getStageAndLayer()

	BossRushController.instance:enterFightScene(stage, layer)
end

function V2a9_BossRushLevelDetail:_editableInitView()
	self:_initAssessIcon()

	local itemClass = V1a4_BossRushLevelDetailItem

	self._tabsList = {
		[BossRushEnum.V2a9StageEnum.First] = {
			[TabEnum.First] = MonoHelper.addNoUpdateLuaComOnceToGo(self._btnAssassinSimple.gameObject, itemClass),
			[TabEnum.Second] = MonoHelper.addNoUpdateLuaComOnceToGo(self._btnAssassinHard.gameObject, itemClass)
		},
		[BossRushEnum.V2a9StageEnum.Second] = {
			[TabEnum.First] = MonoHelper.addNoUpdateLuaComOnceToGo(self._btnSimple.gameObject, itemClass),
			[TabEnum.Second] = MonoHelper.addNoUpdateLuaComOnceToGo(self._btnHard.gameObject, itemClass)
		}
	}
	self._animSelf = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._animSelf.enabled = false

	self._animEvent:AddEventListener(BossRushEnum.AnimEvtLevelDetail.onPlayCloseTransitionFinish, self._onPlayCloseTransitionFinish, self)

	self._imgLine = {
		gohelper.findChildImage(self.viewGO, "DetailPanel/Title/image_Line"),
		gohelper.findChildImage(self.viewGO, "DetailPanel/Title/image_Line/image_Line"),
		gohelper.findChildImage(self.viewGO, "DetailPanel/Attention/Lv/image_Line"),
		gohelper.findChildImage(self.viewGO, "DetailPanel/Attention/Lv/image_Line/image_Line")
	}
	self._txtLvDesc = gohelper.findChildText(self.viewGO, "DetailPanel/Attention/Lv/txt_Lv")
	self._txtCondition = gohelper.findChildText(self.viewGO, "DetailPanel/Condition/Title/txt_Condition")
end

function V2a9_BossRushLevelDetail:onOpen()
	self._selectedIndex = nil

	local viewParam = self.viewParam
	local stage = viewParam.stage
	local selectedIndex = viewParam.selectedIndex
	local pointsInfo = BossRushModel.instance:getStagePointInfo(stage)

	self._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)
	self._tabList = self._tabsList[stage]
	self._actId = BossRushConfig.instance:getActivityId()

	if not selectedIndex then
		selectedIndex = self:_tryLayer2TabIndex(BossRushModel.instance:getLastMarkSelectedLayer(stage))
		viewParam.selectedIndex = selectedIndex
	else
		selectedIndex = self:_tryLayer2TabIndex(selectedIndex)
		viewParam.selectedIndex = selectedIndex
	end

	self:_setSelect(selectedIndex or TabEnum.First)
	self:_tweenUnlockTabs()
	self:_refreshMonster()
	self:_refreshRedDot()

	self._imageSliderFG.fillAmount = pointsInfo.cur / pointsInfo.max
	self._animSelf.enabled = true

	if selectedIndex == TabEnum.Second then
		self._animSelf:Play(BossRushEnum.AnimLevelDetail.HardEnter)
	elseif selectedIndex == TabEnum.First then
		self._animSelf:Play(BossRushEnum.AnimLevelDetail.NormalEnter)
	end

	self:_refreshGoBtn(selectedIndex)
	gohelper.setActive(self._gomask, false)

	for _stage, tabs in pairs(self._tabsList) do
		for _, item in pairs(tabs) do
			gohelper.setActive(item.go, stage == _stage)
		end
	end
end

function V2a9_BossRushLevelDetail:_setSelect(index, isPlayAnim)
	if self._selectedIndex == index then
		return
	end

	local lastIndex = self._selectedIndex

	if not self:_isOpen(index) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)

		return
	end

	if isPlayAnim then
		if index == TabEnum.Second then
			self._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToHard)
		elseif index == TabEnum.First then
			self._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToNormal)
		end
	end

	if lastIndex then
		local lastTab = self._tabList[lastIndex]

		lastTab:setSelect(false)
		lastTab:playIdle()
	end

	local curTab = self._tabList[index]

	curTab:setSelect(true)

	self._selectedIndex = index

	if isPlayAnim then
		curTab:plaAnim(BossRushEnum.AnimLevelDetailBtn.Select, 0, 0)
	end

	self:_refreshContent()

	local stage, layer = self:_getStageAndLayer()

	BossRushModel.instance:setLastMarkSelectedLayer(stage, layer)
	gohelper.setActive(self._goAssassinNormalMask, stage == BossRushEnum.V2a9StageEnum.First and index == TabEnum.First)
	gohelper.setActive(self._goAssassinHardMask, stage == BossRushEnum.V2a9StageEnum.First and index == TabEnum.Second)
	gohelper.setActive(self._goNormalMask, stage == BossRushEnum.V2a9StageEnum.Second and index == TabEnum.First)
	gohelper.setActive(self._goHardMask, stage == BossRushEnum.V2a9StageEnum.Second and index == TabEnum.Second)
	gohelper.setActive(self._goHardBG, stage == BossRushEnum.V2a9StageEnum.Second and index == TabEnum.Second)

	local stageShowInfo = V2a9StageInfo[stage][index]
	local color1 = GameUtil.parseColor(stageShowInfo.color1)

	self._txtDescr.color = color1
	self._txtLvDesc.color = GameUtil.parseColor(stageShowInfo.color2)
	self._txtCondition.color = GameUtil.parseColor(stageShowInfo.color3)
	color1.a = stageShowInfo.alpha

	for _, img in ipairs(self._imgLine) do
		img.color = color1
	end
end

function V2a9_BossRushLevelDetail:_refreshContent()
	local viewParam = self.viewParam
	local stage = viewParam.stage
	local index = self._selectedIndex
	local stageLayerInfo = self._stageLayerInfos[index]
	local layerCO = stageLayerInfo.layerCO
	local layer = layerCO.layer
	local battleMaxPoints = BossRushConfig.instance:getBattleMaxPoints(stage, layer)
	local issxIconName = BossRushConfig.instance:getIssxIconName(stage, layer)
	local highestPoint = BossRushModel.instance:getHighestPoint(stage)
	local isInfinite = BossRushConfig.instance:isInfinite(stage, layer)
	local battleId = BossRushConfig.instance:getDungeonBattleId(stage, layer)

	UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
	self._simagefull:LoadImage(BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(stage))

	local type = BossRushEnum.AssessType.Normal
	local spHeight = V2a9BossRushModel.instance:getHighestPoint(stage)

	highestPoint = math.max(highestPoint, spHeight)

	self._assessIcon:setData(stage, highestPoint, type)

	local spriteName = BossRushConfig.instance:getAssessSpriteName(stage, highestPoint, type)
	local isEmpty = string.nilorempty(spriteName)

	gohelper.setActive(self._vxreceive1, not isEmpty)

	self._txtTitle.text = ""

	if self._scrollDescr then
		self._scrollDescr.verticalNormalizedPosition = 1
	end

	self._txtDescr.text = layerCO.desc

	ZProj.UGUIHelper.RebuildLayout(self._txtDescr.transform)

	self._txtLvNum.text = layerCO.recommendLevelDesc

	local titleResPath = ResUrl.getV1a4BossRushLangPath("v2a9_bossrush_bossname_" .. stage)

	self._simageTitle:LoadImage(titleResPath)

	if isInfinite then
		local info = BossRushModel.instance:getDoubleTimesInfo(stage)
		local tag = {
			info.cur,
			info.max
		}

		self._txtDoubleTimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrushleveldetail_txt_doubletimes"), tag)
	else
		self._txtDoubleTimes.text = ""
	end

	local isSpecialLayer = BossRushModel.instance:isSpecialLayer(layer)

	gohelper.setActive(self._goLeftBGEndless, not isSpecialLayer and isInfinite)
	gohelper.setActive(self._goLeftBG, not isSpecialLayer and not isInfinite)
	gohelper.setActive(self._goRightBGEndless, not isSpecialLayer and isInfinite)
	gohelper.setActive(self._goRightBG, not isSpecialLayer and not isInfinite)
	gohelper.setActive(self._goRightBGLayer4, isSpecialLayer)
	self:_doUpdateSelectIcon(battleId)
end

function V2a9_BossRushLevelDetail:_refreshGoBtn(layer)
	return
end

function V2a9_BossRushLevelDetail:_refreshTabs(newUnlockStates)
	local layerList = {}

	for i, stageLayerInfo in ipairs(self._stageLayerInfos) do
		local layer = stageLayerInfo.layer
		local tabIndex = LayerTabEnum[layer]
		local item = self._tabList[tabIndex]

		if item then
			item:setData(tabIndex, stageLayerInfo)

			if newUnlockStates then
				local isNewUnlock = newUnlockStates[layer]

				if isNewUnlock then
					item:setIsLocked(true)
				end
			end

			if stageLayerInfo.isOpen then
				item:setSelect(self._selectedIndex == tabIndex)
			end
		end

		table.insert(layerList, layer)
	end

	for layer, item in pairs(self._tabsList) do
		local isShow = LuaUtil.tableContains(layerList, layer)

		gohelper.setActive(item.go, isShow)
	end
end

function V2a9_BossRushLevelDetail:_onBtnGoEnter()
	self:_refreshGoBtn(self._selectedIndex)
end

function V2a9_BossRushLevelDetail:playCloseTransition()
	self._animSelf:Play(BossRushEnum.AnimLevelDetail.CloseView)
	gohelper.setActive(self._gomask, true)
end

function V2a9_BossRushLevelDetail:_onPlayCloseTransitionFinish()
	self.viewContainer:onPlayCloseTransitionFinish()
end

function V2a9_BossRushLevelDetail:onDestroyView()
	self._animEvent:RemoveEventListener(BossRushEnum.AnimEvtLevelDetail.onPlayCloseTransitionFinish)
	self._simagefull:UnLoadImage()
	GameUtil.onDestroyViewMemberList(self, "_tabList")
	GameUtil.onDestroyViewMemberList(self, "_uiSpineList")
end

return V2a9_BossRushLevelDetail
