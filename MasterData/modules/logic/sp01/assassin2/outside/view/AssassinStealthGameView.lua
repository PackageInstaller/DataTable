-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameView", package.seeall)

local AssassinStealthGameView = class("AssassinStealthGameView", BaseView)

function AssassinStealthGameView:onInitView()
	self._gobellringmask = gohelper.findChild(self.viewGO, "root/simage_redmask")
	self._godrag = gohelper.findChild(self.viewGO, "root/#go_drag")
	self._gomap = gohelper.findChild(self.viewGO, "root/#go_drag/#go_map")
	self._gotop = gohelper.findChild(self.viewGO, "root/top")
	self._txtroundTip = gohelper.findChildText(self.viewGO, "root/top/#txt_roundTip")
	self._txtroundTipEff = gohelper.findChildText(self.viewGO, "root/top/#txt_roundTipeff")
	self._txtround = gohelper.findChildText(self.viewGO, "root/top/#txt_round")
	self._goplayerturnbg = gohelper.findChild(self.viewGO, "root/top/go_roundBG/image_player")
	self._goenemyturnbg = gohelper.findChild(self.viewGO, "root/top/go_roundBG/image_enemy")
	self._gobell = gohelper.findChild(self.viewGO, "root/#go_bell")
	self._btnbell = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bell/#btn_bell", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gogreen = gohelper.findChild(self.viewGO, "root/#go_bell/#go_green")
	self._gored = gohelper.findChild(self.viewGO, "root/#go_bell/#go_red")
	self._btnqte = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_qte", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goapLayout = gohelper.findChild(self.viewGO, "root/#btn_qte/#go_apLayout")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_end", AudioEnum2_9.StealthGame.play_ui_cikeshang_overround)
	self._gostartLight = gohelper.findChild(self.viewGO, "root/target/start/#go_startLight")
	self._txttarget = gohelper.findChildText(self.viewGO, "root/target/#txt_target")
	self._gochangeMissionEff = gohelper.findChild(self.viewGO, "root/target/#saoguang")
	self._goheroLayout = gohelper.findChild(self.viewGO, "root/#go_heroLayout")
	self._goheroItem = gohelper.findChild(self.viewGO, "root/#go_heroLayout/#go_heroItem")
	self._btntechnique = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_topleft/#btn_technique")
	self._gotips = gohelper.findChild(self.viewGO, "root/tips")
	self._gouseItem = gohelper.findChild(self.viewGO, "root/tips/#go_useItem")
	self._btnuseitemmask = gohelper.findChildClickWithAudio(self.viewGO, "root/tips/#go_useItem/mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gouseitemtargetlayer = gohelper.findChild(self.viewGO, "root/tips/#go_useItem/#go_targetLayer")
	self._txttips = gohelper.findChildText(self.viewGO, "root/tips/#go_useItem/#go_tip/#txt_tips")
	self._imageitemicon = gohelper.findChildImage(self.viewGO, "root/tips/#go_useItem/#go_itemInfo/#simage_icon")
	self._txtitemName = gohelper.findChildText(self.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemName")
	self._goitemtag = gohelper.findChild(self.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemName/tag")
	self._txttag = gohelper.findChildText(self.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemName/tag/#txt_tag")
	self._txtitemDesc = gohelper.findChildText(self.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemDesc")
	self._goshow = gohelper.findChild(self.viewGO, "root/tips/#go_show")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "root/tips/#go_show/#skill/#simage_pic")
	self._txtname = gohelper.findChildText(self.viewGO, "root/tips/#go_show/#txt_name")
	self._imageshowicon = gohelper.findChildImage(self.viewGO, "root/tips/#go_show/#txt_name/#image_icon")
	self._gomissionTip = gohelper.findChild(self.viewGO, "root/tips/#go_mission")
	self._txtmissionTip = gohelper.findChildText(self.viewGO, "root/tips/#go_mission/root/#txt_Mission")
	self._goselectenemy = gohelper.findChild(self.viewGO, "root/tips/#go_selectEnemy")
	self._btnselectenemymask = gohelper.findChildClickWithAudio(self.viewGO, "root/tips/#go_selectEnemy/mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goselectedwheel = gohelper.findChild(self.viewGO, "root/tips/#go_selectEnemy/#go_selected")
	self._goopItem = gohelper.findChild(self.viewGO, "root/tips/#go_selectEnemy/#go_selected/#go_opItem")
	self._goopLayout = gohelper.findChild(self.viewGO, "root/tips/#go_selectEnemy/#go_selected/#go_opLayout")
	self._goopreadmelayout = gohelper.findChild(self.viewGO, "root/tips/#go_selectEnemy/layout")
	self._goopreadmeItem = gohelper.findChild(self.viewGO, "root/tips/#go_selectEnemy/layout/#go_item")
	self._goexposetips = gohelper.findChild(self.viewGO, "root/tips/#go_expose")
	self._txtexposetips = gohelper.findChildText(self.viewGO, "root/tips/#go_expose/#go_tip/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameView:addEvents()
	self._btnbell:AddClickListener(self._btnbellOnClick, self)
	self._btnqte:AddClickListener(self._btnqteOnClick, self)
	self._btnend:AddClickListener(self._btnendOnClick, self)
	self._btnselectenemymask:AddClickListener(self._btnselectenemymaskOnClick, self)
	self._btnuseitemmask:AddClickListener(self._btnuseitemmaskOnClick, self)
	self._drag:AddDragBeginListener(self._onBeginDragMap, self)
	self._drag:AddDragListener(self._onDragMap, self)
	self._drag:AddDragEndListener(self._onEndDragMap, self)
	self._useitemdrag:AddDragBeginListener(self._onBeginDragMap, self)
	self._useitemdrag:AddDragListener(self._onDragMap, self)
	self._useitemdrag:AddDragEndListener(self._onEndDragMap, self)
	self._touchEventMgr:SetOnMultiDragCb(self._onMultiDrag, self)
	self._touchEventMgr:SetScrollWheelCb(self._onMouseScrollWheelChange, self)
	self._btntechnique:AddClickListener(self._btntechniqueOnClick, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, self._onHeroUpdate, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, self._onHeroMove, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectHero, self._onSelectedHero, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectEnemy, self._onSelectEnemy, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnSelectSkillProp, self._onSelectSkillProp, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnUseSkillProp, self._onUseSkillProp, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.ShowHeroActImg, self._showHeroActImg, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroGetItem, self._onHeroGetItem, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.ShowExposeTip, self._onShowExposeTip, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnPlayerEndTurn, self._onPlayerEndTurn, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.BeforeEnterFight, self._beforeEnterFight, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, self._onBeginNewRound, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnMissionUpdate, self._onMissionUpdate, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnMissionChange, self._onMissionChange, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnQTEInteractUpdate, self._onQTEInteractUpdate, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRecover, self._onGameSceneRecover, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRestart, self._onGameSceneRestart, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnGameChangeMap, self._onGameChangeMap, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnChangeAlertLevel, self._onAlertLevelChange, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.TweenStealthMapPos, self._onTweenMapPos, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.GuidFocusStealthGameHero, self._onGuideFocusHero, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
end

function AssassinStealthGameView:removeEvents()
	self._btnbell:RemoveClickListener()
	self._btnqte:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btnselectenemymask:RemoveClickListener()
	self._btnuseitemmask:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self._useitemdrag:RemoveDragBeginListener()
	self._useitemdrag:RemoveDragListener()
	self._useitemdrag:RemoveDragEndListener()

	for _, opItem in ipairs(self._opItemList) do
		opItem.btnclick:RemoveClickListener()
	end

	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end

	self._btntechnique:RemoveClickListener()
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, self._onHeroUpdate, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, self._onHeroMove, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectHero, self._onSelectedHero, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectEnemy, self._onSelectEnemy, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnSelectSkillProp, self._onSelectSkillProp, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnUseSkillProp, self._onUseSkillProp, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.ShowHeroActImg, self._showHeroActImg, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroGetItem, self._onHeroGetItem, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.ShowExposeTip, self._onShowExposeTip, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnPlayerEndTurn, self._onPlayerEndTurn, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.BeforeEnterFight, self._beforeEnterFight, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, self._onBeginNewRound, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnMissionUpdate, self._onMissionUpdate, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnMissionChange, self._onMissionChange, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnQTEInteractUpdate, self._onQTEInteractUpdate, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRecover, self._onGameSceneRecover, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRestart, self._onGameSceneRestart, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnGameChangeMap, self._onGameChangeMap, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnChangeAlertLevel, self._onAlertLevelChange, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.TweenStealthMapPos, self._onTweenMapPos, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.GuidFocusStealthGameHero, self._onGuideFocusHero, self)
end

function AssassinStealthGameView:_btnbellOnClick()
	AssassinController.instance:openAssassinStealthGameOverView()
end

function AssassinStealthGameView:_btnqteOnClick()
	AssassinStealthGameController.instance:heroInteract()
end

function AssassinStealthGameView:_btnendOnClick()
	AssassinStealthGameController.instance:playerEndTurn()
end

function AssassinStealthGameView:_btnselectenemymaskOnClick()
	AssassinStealthGameController.instance:selectEnemy()
end

function AssassinStealthGameView:_btnuseitemmaskOnClick()
	AssassinStealthGameController.instance:selectSkillProp()
end

function AssassinStealthGameView:_onOpItemClick(index)
	local opItem = self._opItemList[index]
	local actId = opItem and opItem.actId

	if not actId then
		return
	end

	if opItem.isAssassinate then
		AssassinStealthGameController.instance:heroAssassinate(actId)
	else
		AssassinStealthGameController.instance:heroAttack(actId)
	end
end

function AssassinStealthGameView:_onBeginDragMap(_, pointerEventData)
	self._startDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._transdrag)
	self._startMapPosX, self._startMapPosY = transformhelper.getLocalPos(self._transmap)
end

function AssassinStealthGameView:_onDragMap(_, pointerEventData)
	if self._multiDragging or not self._startDragPos then
		return
	end

	local endPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._transdrag)
	local deltaPos = endPos - self._startDragPos
	local targetX = self._startMapPosX + deltaPos.x
	local targetY = self._startMapPosY + deltaPos.y

	self:setMapPos(targetX, targetY)
end

function AssassinStealthGameView:_onEndDragMap(_, _)
	self._multiDragging = false
	self._startDragPos = nil
end

function AssassinStealthGameView:_onMultiDrag(_, delta)
	self._multiDragging = true

	local isCanScale = self:_checkCanScale()

	if not isCanScale then
		return
	end

	local deltaScale = delta * 0.01

	self.curScale = self.curScale + deltaScale

	self:setLocalScale()
end

function AssassinStealthGameView:_onMouseScrollWheelChange(deltaData)
	local isCanScale = self:_checkCanScale()

	if not isCanScale then
		return
	end

	self.curScale = self.curScale + deltaData

	self:setLocalScale()
end

function AssassinStealthGameView:_checkCanScale()
	local mapId = AssassinStealthGameModel.instance:getMapId()
	local checkGuide, checkStep = AssassinConfig.instance:getStealthMapForbidScaleGuide(mapId)

	if not ((checkGuide or nil) and (checkStep and GuideModel.instance:isStepFinish(checkGuide, checkStep) or GuideModel.instance:isGuideFinish(checkGuide))) then
		return false
	end

	local isInGuide = self:checkInGuide()

	if isInGuide then
		return false
	end

	local isBlock = UIBlockMgr.instance:isBlock()

	if isBlock then
		return false
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= self.viewName then
		return false
	end

	if self.tweenId or self._gouseItem.activeSelf or self._goselectenemy.activeSelf or self._goshow.activeSelf then
		return false
	end

	return true
end

function AssassinStealthGameView:_btntechniqueOnClick()
	AssassinController.instance:openAssassinStealthTechniqueView()
end

function AssassinStealthGameView:_onEscBtnClick()
	local isInGuide = self:checkInGuide()

	if isInGuide then
		return
	end

	AssassinController.instance:openAssassinStealthGamePauseView()
end

function AssassinStealthGameView:_onHeroUpdate()
	self:refreshInteractQTEBtn()
	self:refreshHeroHeadItem()
end

function AssassinStealthGameView:_onHeroMove()
	self:refreshInteractQTEBtn()
	self:refreshHeroHeadItem()
end

function AssassinStealthGameView:_onSelectedHero(eventParam)
	local lastSelectedHeroUid = eventParam.lastSelectedHeroUid
	local selectedHero = AssassinStealthGameModel.instance:getSelectedHero()

	if selectedHero then
		self:initHeroItem(true, lastSelectedHeroUid)
	else
		self:refreshHeroHeadItem(true, lastSelectedHeroUid)
	end

	self:refreshInteractQTEBtn()

	local needFocus = eventParam.needFocus
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if needFocus and heroGameMo then
		local gridId = heroGameMo:getPos()

		self:mapFocus2Grid(gridId)
	end
end

function AssassinStealthGameView:_onSelectEnemy(oldSelectedEnemy)
	local enemyGameMo = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if enemyGameMo then
		self:_setSelectedEnemyOpItemList()

		if oldSelectedEnemy then
			AssassinStealthGameEntityMgr.instance:changeEnemyParent(oldSelectedEnemy)
			AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(oldSelectedEnemy)
		end

		local gridId = enemyGameMo:getPos()

		self.mapFocus2Grid(self, gridId, nil, true, self._changeSelectedEnemyLayer, self)
	else
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, true)

		self._oldSelectedEnemy = oldSelectedEnemy

		self._selectEnemyAnimatorPlayer:Play("close", self._hideSelectEnemyGo, self)
	end
end

function AssassinStealthGameView:_changeSelectedEnemyLayer()
	local enemyGameMo = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if enemyGameMo then
		local enemyUid = enemyGameMo:getUid()

		AssassinStealthGameEntityMgr.instance:changeEnemyParent(enemyUid, self._transselectenemy)

		local x, y = AssassinStealthGameEntityMgr.instance:getEnemyLocalPos(enemyUid)

		if x and y then
			transformhelper.setLocalPosXY(self._transselectenemywheel, x, y)
		end

		gohelper.setActive(self._goselectenemy, true)
		self._selectEnemyAnimatorPlayer:Play("open", nil, self)
	end
end

function AssassinStealthGameView:_setSelectedEnemyOpItemList()
	local opActList = {}
	local assassinateData
	local assassinateActId = AssassinStealthGameHelper.getSelectedHeroAssassinateActId()

	if assassinateActId then
		opActList[#opActList + 1] = {
			actId = assassinateActId
		}
	end

	local attackId, togetherAttackActId = AssassinStealthGameHelper.getSelectedHeroAttackActId()

	opActList[#opActList + 1] = attackId
	opActList[#opActList + 1] = togetherAttackActId

	for i, opItem in ipairs(self._opItemList) do
		local actData = opActList[i]

		if actData then
			local actId = actData
			local isAssassinate = false

			if LuaUtil.isTable(actData) then
				actId = actData.actId
				isAssassinate = true
			end

			AssassinHelper.setAssassinActIcon(actId, opItem.imageicon)

			local needAp = AssassinConfig.instance:getAssassinActPower(actId)

			opItem.apComp:setAPCount(needAp)

			opItem.actId = actId
			opItem.isAssassinate = isAssassinate
		else
			opItem.actId = nil
			opItem.isAssassinate = nil
		end

		gohelper.setActive(opItem.go, opItem.actId)
	end

	gohelper.CreateObjList(self, self._onCreateOpReadmeItem, opActList, self._goopreadmelayout, self._goopreadmeItem)
end

function AssassinStealthGameView:_onCreateOpReadmeItem(obj, data, _)
	local actId = data

	if LuaUtil.isTable(data) then
		actId = data.actId
	end

	local imageicon = gohelper.findChildImage(obj, "#image_icon")

	AssassinHelper.setAssassinActIcon(actId, imageicon)

	local txtname = gohelper.findChildText(obj, "#txt_name")

	txtname.text = AssassinConfig.instance:getAssassinActName(actId)
end

function AssassinStealthGameView:_hideSelectEnemyGo()
	if self._oldSelectedEnemy then
		AssassinStealthGameEntityMgr.instance:changeEnemyParent(self._oldSelectedEnemy)
		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(self._oldSelectedEnemy)

		self._oldSelectedEnemy = nil
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, false)
	gohelper.setActive(self._goselectenemy, false)
end

function AssassinStealthGameView:_onSelectSkillProp(notPlay)
	for _, headItem in ipairs(self._heroHeadItemList) do
		headItem:refreshSkillProp()
	end

	local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if selectedSkillPropId then
		local name = ""
		local desc = ""

		if selectedIsSkill then
			AssassinHelper.setAssassinSkillIcon(selectedSkillPropId, self._imageitemicon)

			name = AssassinConfig.instance:getAssassinSkillName(selectedSkillPropId)
			desc = AssassinConfig.instance:getAssassinCareerSkillDesc(selectedSkillPropId)
		else
			AssassinHelper.setAssassinItemIcon(selectedSkillPropId, self._imageitemicon)

			name = AssassinConfig.instance:getAssassinItemName(selectedSkillPropId)
			desc = AssassinConfig.instance:getAssassinItemStealthEffDesc(selectedSkillPropId)
		end

		self._txtitemName.text = name
		self._txtitemDesc.text = desc

		gohelper.setActive(self._goitemtag, false)
	end

	self:_setIsShowUseItem(selectedSkillPropId, notPlay)
end

function AssassinStealthGameView:_onUseSkillProp()
	self:_setIsShowUseItem(false)
	self:changeHeroSkillProp()
end

function AssassinStealthGameView:_setIsShowUseItem(isShow, notPlay)
	if isShow then
		gohelper.setActive(self._gouseItem, true)

		local hasTarget = AssassinStealthGameEntityMgr.instance:changeSkillPropTargetLayer(self._transuseitemtargetlayer)
		local langId = hasTarget and "assassin_stealth_use_skill_prop_select_target" or "assassin_stealth_use_skill_prop_no_target"

		self._txttips.text = luaLang(langId)
	else
		AssassinStealthGameEntityMgr.instance:changeSkillPropTargetLayer(self._transuseitemtargetlayer)

		if notPlay then
			self:_hideUseItemGo()
		else
			self._useItemAnimatorPlayer:Play("close", self._hideUseItemGo, self)
		end
	end
end

function AssassinStealthGameView:_hideUseItemGo()
	gohelper.setActive(self._gouseItem, false)
end

function AssassinStealthGameView:_showHeroActImg(actId, actParam)
	local showImg = AssassinConfig.instance:getAssassinActShowImg(actId)

	if string.nilorempty(showImg) then
		AssassinStealthGameController.instance:showActImgFinish(actId, actParam)
	else
		self._txtname.text = AssassinConfig.instance:getAssassinActName(actId)

		AssassinHelper.setAssassinActIcon(actId, self._imageshowicon)

		local showImgPath = ResUrl.getSp01AssassinSingleBg("stealth/" .. showImg)

		self._simagepic:LoadImage(showImgPath)

		self._showActId = actId
		self._actParam = actParam

		gohelper.setActive(self._goshow, true)
		self._showAnimatorPlayer:Play("open", self._playShowFinished, self)

		local actAudioId = AssassinConfig.instance:getAssassinActAudioId(actId)

		if actAudioId and actAudioId ~= 0 then
			AudioMgr.instance:trigger(actAudioId)
		end
	end
end

function AssassinStealthGameView:_playShowFinished()
	gohelper.setActive(self._goshow, false)
	AssassinStealthGameController.instance:showActImgFinish(self._showActId, self._actParam)
end

function AssassinStealthGameView:_onHeroGetItem(uid, newItemDict)
	self._getItemUid = uid
	self._newItemDict = newItemDict

	AssassinStealthGameController.instance:selectSkillProp(nil, nil, true)
end

function AssassinStealthGameView:_onShowExposeTip(exposeHeroUidList)
	local heroNameList = {}

	for _, uid in ipairs(exposeHeroUidList) do
		local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(uid, true)
		local assassinHeroId = gameHeroMo and gameHeroMo:getHeroId()
		local name = AssassinHeroModel.instance:getAssassinHeroName(assassinHeroId)

		if not string.nilorempty(name) then
			heroNameList[#heroNameList + 1] = name
		end
	end

	local connChar = luaLang("room_levelup_init_and1")
	local allHeroName = table.concat(heroNameList, connChar)

	self._txtexposetips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassin_stealth_expose_tip"), allHeroName)

	gohelper.setActive(self._goexposetips, true)
	self._exposeAnimatorPlayer:Play("open", self._playExposeTipFinished, self)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_exposure)
	self:refreshHeroHeadItem()
end

function AssassinStealthGameView:_playExposeTipFinished()
	gohelper.setActive(self._goexposetips, false)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.PlayExposeTipFinished)
end

function AssassinStealthGameView:_onPlayerEndTurn()
	self:refreshRound(true)
	self:refreshEndPlayerRoundBtn()
end

function AssassinStealthGameView:_beforeEnterFight()
	local posX, posY = transformhelper.getLocalPos(self._transmap)

	AssassinStealthGameModel.instance:setMapPosRecordOnFight(posX, posY, self.curScale)
end

function AssassinStealthGameView:_onCloseView(viewName)
	if viewName == ViewName.AssassinStealthGameEventView then
		self._bellAnimator:Play("get", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskring)
	elseif viewName == ViewName.AssassinStealthGameGetItemView then
		for _, headItem in ipairs(self._heroHeadItemList) do
			headItem:playGetItem(self._getItemUid, self._newItemDict)
		end

		self._getItemUid = nil
		self._newItemDict = nil

		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_getitembag)
	elseif viewName == ViewName.LoadingView then
		if self._needCheckGameRequestAfterCloseLoading then
			AssassinStealthGameController.instance:checkGameRequest()
		end

		self._needCheckGameRequestAfterCloseLoading = nil
	end
end

function AssassinStealthGameView:_onBeginNewRound()
	local isGameEnd = AssassinStealthGameController.instance:checkGameState()

	if isGameEnd then
		return
	end

	self:refreshRound(true)
	self:refreshBell()
	self:refreshMoveDir()
	self:refreshEndPlayerRoundBtn()
	self:changeHeroSkillProp()
	self:refreshHeroHeadItem()
end

local MISSION_FINISH_EFFECT_TIME = 0.8

function AssassinStealthGameView:_onMissionUpdate()
	self:refreshTarget()
	self:_checkMissionProgress()
end

function AssassinStealthGameView:_checkMissionProgress()
	local isFinish = false
	local progress, targetProgress = AssassinStealthGameModel.instance:getMissionProgress()

	if targetProgress <= progress then
		self:_cancelFinishMissionTask()
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, true)
		gohelper.setActive(self._gostartLight, true)
		TaskDispatcher.runDelay(self._onFinishMission, self, MISSION_FINISH_EFFECT_TIME)

		isFinish = true
	end

	return isFinish
end

function AssassinStealthGameView:_onFinishMission()
	AssassinStealthGameController.instance:finishMission()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
end

function AssassinStealthGameView:_cancelFinishMissionTask()
	TaskDispatcher.cancelTask(self._onFinishMission, self)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
end

function AssassinStealthGameView:_onMissionChange()
	local missionId = AssassinStealthGameModel.instance:getMissionId()

	if missionId and missionId > 0 then
		gohelper.setActive(self._gochangeMissionEff, false)
		gohelper.setActive(self._gochangeMissionEff, true)
		gohelper.setActive(self._gostartLight, false)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_nexttask)
		self:refreshTarget()
	end

	if self._needCheckGameRequest then
		AssassinStealthGameController.instance:checkGameRequest()
	end

	self._needCheckGameRequest = nil
end

function AssassinStealthGameView:_onQTEInteractUpdate()
	self:refreshInteractQTEBtn()
end

function AssassinStealthGameView:_onGameSceneRecover()
	self:_resetGameView(false)
end

function AssassinStealthGameView:_onGameSceneRestart()
	self:_resetGameView(false)
end

function AssassinStealthGameView:_onGameChangeMap()
	self:_resetGameView(false)
end

function AssassinStealthGameView:_onAlertLevelChange()
	self:refreshBell()
end

function AssassinStealthGameView:_onTweenMapPos(posData, isRecord)
	if not posData then
		return
	end

	if isRecord then
		local posX, posY = transformhelper.getLocalPos(self._transmap)

		AssassinStealthGameModel.instance:setMapPosRecordOnTurn(posX, posY, self.curScale)
	end

	local curX, curY = transformhelper.getLocalPos(self._transmap)

	if not posData.x then
		if not posData.y then
			local posY = curY

			self:tweenMapPos(posData.x, posY, posData.scale)
		end
	end
end

function AssassinStealthGameView:_onGuideFocusHero(mapScale)
	local selectedHero = AssassinStealthGameModel.instance:getSelectedHero()

	mapScale = mapScale and tonumber(mapScale)

	self:mapFocus2Hero(selectedHero, mapScale, true)
end

function AssassinStealthGameView:_editableInitView()
	AssassinStealthGameController.instance:initBaseMap(self._gomap)

	self._qteApComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goapLayout, AssassinStealthGameAPComp)

	gohelper.setActive(self._gotargetTip, false)

	self._dirGOList = self:getUserDataTb_()
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_bell/image_top")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_bell/image_bottom")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_bell/image_left")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_bell/image_right")
	self._opItemList = {}

	gohelper.setActive(self._goopItem, false)

	local transLayout = self._goopLayout.transform
	local childCount = transLayout.childCount

	for i = 1, childCount do
		local opItem = self:getUserDataTb_()
		local child = transLayout:GetChild(i - 1)

		opItem.go = gohelper.clone(self._goopItem, child.gameObject, "opItem")
		opItem.imageicon = gohelper.findChildImage(opItem.go, "#image_icon")

		local goapLayout = gohelper.findChild(opItem.go, "#go_apLayout")

		opItem.btnclick = gohelper.findChildClickWithAudio(opItem.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
		opItem.apComp = MonoHelper.addNoUpdateLuaComOnceToGo(goapLayout, AssassinStealthGameAPComp)

		opItem.btnclick:AddClickListener(self._onOpItemClick, self, i)

		self._opItemList[i] = opItem
	end

	local transView = self.viewGO.transform

	self._viewWidth = recthelper.getWidth(transView)
	self._viewHeight = recthelper.getHeight(transView)
	self.mapWidth = self._viewWidth / AssassinEnum.StealthConst.MinMapScale
	self.mapHeight = self._viewHeight / AssassinEnum.StealthConst.MinMapScale
	self._transmap = self._gomap.transform
	self._transdrag = self._godrag.transform
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)
	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._godrag)

	self._touchEventMgr:SetIgnoreUI(true)

	self._useitemdrag = SLFramework.UGUI.UIDragListener.Get(self._gouseItem)
	self._transselectenemy = self._goselectenemy.transform
	self._transselectenemywheel = self._goselectedwheel.transform
	self._transuseitemtargetlayer = self._gouseitemtargetlayer.transform

	self:setLocalScale()
	self:setMapPos(0, 0)

	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._bellAnimator = self._gobell:GetComponent(typeof(UnityEngine.Animator))
	self._topAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gotop)
	self._useItemAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gouseItem)
	self._showAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goshow)
	self._selectEnemyAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goselectenemy)
	self._exposeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goexposetips)

	gohelper.setActive(self._gotips, true)
end

function AssassinStealthGameView:mapFocus2Hero(heroUid, mapScale, isBlock)
	local heroGameMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)

	if not heroGameMo then
		return
	end

	local gridId = heroGameMo:getPos()

	self:mapFocus2Grid(gridId, mapScale, isBlock)
end

function AssassinStealthGameView:mapFocus2Grid(gridId, mapScala, isBlock, tweenFinishCb, tweenFinishCbObj)
	local gridItem = AssassinStealthGameEntityMgr.instance:getGridItem(gridId, true)
	local worldPos = gridItem and gridItem:getGoPosition()

	if worldPos then
		if isBlock then
			AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, true)
		end

		local pos = self._transmap:InverseTransformPoint(worldPos)

		self:tweenMapPos(-pos.x, -pos.y, mapScala, tweenFinishCb, tweenFinishCbObj)
	end
end

function AssassinStealthGameView:setLocalScale()
	self.curScale = Mathf.Clamp(self.curScale or 1, AssassinEnum.StealthConst.MinMapScale, AssassinEnum.StealthConst.MaxMapScale)

	transformhelper.setLocalScale(self._transmap, self.curScale, self.curScale, 1)
	transformhelper.setLocalScale(self._transselectenemywheel, self.curScale, self.curScale, 1)
	self:calculateDragBorder()
	self:setMapPos()
end

function AssassinStealthGameView:calculateDragBorder()
	local mapWidth = self.mapWidth * self.curScale
	local mapHeight = self.mapHeight * self.curScale

	self.maxOffsetX = (mapWidth - self._viewWidth) / 2
	self.maxOffsetY = (mapHeight - self._viewHeight) / 2
end

function AssassinStealthGameView:checkInGuide()
	local isDoingClickGuide = GuideModel.instance:isDoingClickGuide()
	local isForbid = GuideController.instance:isForbidGuides()

	if isDoingClickGuide and not isForbid then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end
end

function AssassinStealthGameView:setMapPos(posX, posY)
	if not posX or not posY then
		posX, posY = transformhelper.getLocalPos(self._transmap)
	end

	posX = Mathf.Clamp(posX, -self.maxOffsetX, self.maxOffsetX)
	posY = Mathf.Clamp(posY, -self.maxOffsetY, self.maxOffsetY)

	transformhelper.setLocalPosXY(self._transmap, posX, posY)
	AssassinStealthGameEntityMgr.instance:refreshSkillPropTargetPos()
end

function AssassinStealthGameView:tweenMapPos(posX, posY, mapScale, tweenFinishCb, tweenFinishCbObj)
	if not posX or not posY then
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)

		return
	end

	self:killTween()

	self._tweenMapPosFinishCb = tweenFinishCb
	self._tweenMapPosFinishCbObj = tweenFinishCbObj
	self._tweenStartPosX, self._tweenStartPosY = transformhelper.getLocalPos(self._transmap)
	self._tweenStartScale = self.curScale

	local scaleFinish = true

	if mapScale then
		self._tweenTargetPosX = posX
		self._tweenTargetPosY = posY
		self._tweenTargetScale = mapScale
		scaleFinish = self._tweenTargetScale == self.curScale
	else
		self._tweenTargetPosX = Mathf.Clamp(posX, -self.maxOffsetX, self.maxOffsetX)
		self._tweenTargetPosY = Mathf.Clamp(posY, -self.maxOffsetY, self.maxOffsetY)
	end

	if self._tweenStartPosX == self._tweenTargetPosX and self._tweenStartPosY == self._tweenTargetPosY and scaleFinish then
		self:tweenFinishCallback()

		return
	end

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, AssassinEnum.StealthConst.MapTweenPosTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function AssassinStealthGameView:tweenFrameCallback(value)
	if self._tweenTargetScale then
		self.curScale = Mathf.Lerp(self._tweenStartScale, self._tweenTargetScale, value)

		self:setLocalScale()
	end

	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self:setMapPos(x, y)
end

function AssassinStealthGameView:tweenFinishCallback()
	if self._tweenTargetScale then
		self.curScale = self._tweenTargetScale

		self:setLocalScale()
	end

	self:setMapPos(self._tweenTargetPosX, self._tweenTargetPosY)

	if self._tweenMapPosFinishCb then
		self._tweenMapPosFinishCb(self._tweenMapPosFinishCbObj)
	end

	self:killTween()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)
end

function AssassinStealthGameView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self.tweenId = nil
	self._tweenMapPosFinishCb = nil
	self._tweenMapPosFinishCbObj = nil
	self._tweenStartPosX = nil
	self._tweenStartPosY = nil
	self._tweenTargetPosX = nil
	self._tweenTargetPosY = nil
	self._tweenStartScale = nil
	self._tweenTargetScale = nil
end

function AssassinStealthGameView:onUpdateParam()
	return
end

function AssassinStealthGameView:onOpen()
	if self.viewParam then
		self:_resetGameView(self.viewParam, true)

		local mapId = AssassinStealthGameModel.instance:getMapId()

		AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TriggerGuideOnEnterStealthGameMap, mapId)
	end
end

function AssassinStealthGameView:_resetGameView(fightReturn, needCheckGameState)
	self._needCheckGameRequest = nil
	self._needCheckGameRequestAfterCloseLoading = nil

	self:killTween()
	gohelper.setActive(self._gochangeMissionEff, false)
	gohelper.setActive(self._gostartLight, false)
	self:initHeroItem()
	self:refresh()

	local hasRequest = AssassinStealthGameModel.instance:getIsNeedRequest()
	local isGameEnd = false

	if needCheckGameState then
		local gameState = AssassinStealthGameModel.instance:getGameState()

		isGameEnd = gameState ~= AssassinEnum.GameState.InProgress
	end

	if hasRequest or fightReturn or isGameEnd then
		gohelper.setActive(self._gomissionTip, false)
		self._animatorPlayer:Play("open2", self._afterOpen2Anim, self)
	else
		self:showTargetTip()
		self._animatorPlayer:Play("open1", self.showEvent, self)
	end

	self:_hideUseItemGo()

	local posX, posY, scale

	if fightReturn and self.viewParam then
		posX = self.viewParam.mapPosX
		posY = self.viewParam.mapPosY
		scale = self.viewParam.mapScale
	end

	if scale then
		self.curScale = scale

		self:setLocalScale()
	end

	if posX and posY then
		self:setMapPos(posX, posY)
	else
		local requireAssassinHeroId = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.RequireAssassinHeroId, true)
		local requireAssassinHeroUid = AssassinStealthGameModel.instance:getHeroUidByAssassinHeroId(requireAssassinHeroId)

		self:mapFocus2Hero(requireAssassinHeroUid)
	end
end

function AssassinStealthGameView:_afterOpen2Anim()
	local isGameEnd = AssassinStealthGameController.instance:checkGameState()

	if isGameEnd then
		return
	end

	local isFinished = self:_checkMissionProgress()

	if isFinished then
		self._needCheckGameRequest = true
	else
		local isShowingLoading = ViewMgr.instance:isOpen(ViewName.LoadingView)

		if isShowingLoading then
			self._needCheckGameRequestAfterCloseLoading = true
		else
			AssassinStealthGameController.instance:checkGameRequest()
		end
	end
end

function AssassinStealthGameView:initHeroItem(checkSelectedAnim, lastSelectedHeroUid)
	self._heroHeadItemList = {}

	local list = {}
	local heroUidList = AssassinStealthGameModel.instance:getHeroUidList()
	local count = #heroUidList

	for i, heroUid in ipairs(heroUidList) do
		list[i] = {
			heroUid = heroUid,
			checkSelectedAnim = checkSelectedAnim,
			oldSelectedHeroUid = lastSelectedHeroUid,
			isLastHeroHead = i == count
		}
	end

	gohelper.CreateObjList(self, self._onCreateHeroHeadItem, list, self._goheroLayout, self._goheroItem, AssassinStealthGameHeroHeadItem)
end

function AssassinStealthGameView:_onCreateHeroHeadItem(obj, data, index)
	obj:setData(data)

	self._heroHeadItemList[index] = obj
end

function AssassinStealthGameView:showTargetTip()
	local missionId = AssassinStealthGameModel.instance:getMissionId()

	if missionId <= 0 then
		return
	end

	self._txtmissionTip.text = AssassinConfig.instance:getStealthMissionDesc(missionId)

	gohelper.setActive(self._gomissionTip, false)
	gohelper.setActive(self._gomissionTip, true)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskin)
end

function AssassinStealthGameView:showEvent()
	AssassinController.instance:openAssassinStealthGameEventView()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, false)
end

function AssassinStealthGameView:refresh()
	self:refreshRound()
	self:refreshMoveDir()
	self:refreshTarget()
	self:refreshHeroHeadItem()
	self:refreshBell()
	self:refreshInteractQTEBtn()
	self:refreshEndPlayerRoundBtn()
end

function AssassinStealthGameView:refreshRound(playAnim)
	local isPlayerTurn = AssassinStealthGameModel.instance:isPlayerTurn()

	gohelper.setActive(self._goplayerturnbg, isPlayerTurn)
	gohelper.setActive(self._goenemyturnbg, not isPlayerTurn)

	local roundTip = isPlayerTurn and luaLang("assassin_stealth_game_player_turn") or luaLang("assassin_stealth_game_enemy_turn")

	self._txtroundTip.text = roundTip
	self._txtroundTipEff.text = roundTip

	local round = AssassinStealthGameModel.instance:getRound()
	local maxRound = AssassinConfig.instance:getAssassinStealthConst(AssassinEnum.StealthConstId.MaxRound)

	self._txtround.text = string.format("%s/%s", round, maxRound)

	if playAnim then
		if isPlayerTurn then
			self._topAnimatorPlayer:Play("open", self.showEvent, self)
			AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, true)
		else
			self._topAnimatorPlayer:Play("open")
		end

		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_foeround)
	end
end

function AssassinStealthGameView:refreshTarget()
	local missionId = AssassinStealthGameModel.instance:getMissionId()

	if missionId <= 0 then
		return
	end

	local missionDesc = AssassinConfig.instance:getStealthMissionDesc(missionId)
	local progress, targetProgress = AssassinStealthGameModel.instance:getMissionProgress()
	local missionProgress = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_mission_progress"), progress, targetProgress)

	self._txttarget.text = string.format("%s%s", missionDesc, missionProgress)
end

function AssassinStealthGameView:refreshHeroHeadItem(checkSelectedAnim, lastSelectedHeroUid)
	for _, headItem in ipairs(self._heroHeadItemList) do
		headItem:refresh(checkSelectedAnim, lastSelectedHeroUid)
	end
end

function AssassinStealthGameView:changeHeroSkillProp()
	for _, headItem in ipairs(self._heroHeadItemList) do
		headItem:onSkillPropChange()
	end
end

function AssassinStealthGameView:refreshBell()
	local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()

	gohelper.setActive(self._gogreen, not isAlertBellRing)
	gohelper.setActive(self._gored, isAlertBellRing)
	gohelper.setActive(self._gobellringmask, isAlertBellRing)
	self:_changeBgmState()
end

function AssassinStealthGameView:_changeBgmState()
	local stateId
	local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()

	stateId = isAlertBellRing and AudioMgr.instance:getIdFromString("danger") or AudioMgr.instance:getIdFromString("explore")

	local switchGroupId = AudioMgr.instance:getIdFromString("dl_music")

	AudioMgr.instance:setState(switchGroupId, stateId)
end

function AssassinStealthGameView:refreshInteractQTEBtn()
	local isShowQTEBtn = AssassinStealthGameHelper.isSelectedHeroCanInteract()

	if isShowQTEBtn then
		local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
		local curGridId = heroGameMo:getPos()
		local interactId = AssassinStealthGameModel.instance:getGridInteractId(curGridId)
		local apCost = AssassinConfig.instance:getInteractApCost(interactId)

		self._qteApComp:setAPCount(apCost)
	end

	gohelper.setActive(self._btnqte, isShowQTEBtn)
end

function AssassinStealthGameView:refreshEndPlayerRoundBtn()
	local isPlayerTurn = AssassinStealthGameModel.instance:isPlayerTurn()

	gohelper.setActive(self._btnend, isPlayerTurn)
end

function AssassinStealthGameView:refreshMoveDir()
	local moveDir = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for dir, dirGo in ipairs(self._dirGOList) do
		gohelper.setActive(dirGo, dir == moveDir)
	end
end

function AssassinStealthGameView:onClose()
	self._simagepic:UnLoadImage()
	self:killTween()
	self:_cancelFinishMissionTask()

	self._needCheckGameRequest = nil
	self._needCheckGameRequestAfterCloseLoading = nil

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, false)
end

function AssassinStealthGameView:onDestroyView()
	self._opItemList = nil
	self._heroHeadItemList = nil

	AssassinStealthGameController.instance:onGameViewDestroy()
end

return AssassinStealthGameView
