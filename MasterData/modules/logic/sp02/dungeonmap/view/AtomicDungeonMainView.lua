-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonMainView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonMainView", package.seeall)

local AtomicDungeonMainView = class("AtomicDungeonMainView", BaseView)

function AtomicDungeonMainView:onInitView()
	self._gofullMask = gohelper.findChild(self.viewGO, "root/fullmask")
	self._gohardEffect = gohelper.findChild(self.viewGO, "root/#go_hardEffect")
	self._gomapInfo = gohelper.findChild(self.viewGO, "root/#go_mapInfo")
	self._txtmapName = gohelper.findChildText(self.viewGO, "root/#go_mapInfo/bg/#txt_mapName")
	self._goexplore = gohelper.findChild(self.viewGO, "root/#go_mapInfo/explore")
	self._txtexplore = gohelper.findChildText(self.viewGO, "root/#go_mapInfo/explore/#txt_explore")
	self._gomapFinish = gohelper.findChild(self.viewGO, "root/#go_mapInfo/finish")
	self._goalarmLevel = gohelper.findChild(self.viewGO, "root/#go_alarmLevel")
	self._btnalarmRule = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_alarmLevel/#btn_alarmRule")
	self._txtalarmLevel = gohelper.findChildText(self.viewGO, "root/#go_alarmLevel/#txt_alarmLevel")
	self._gobottomLeft = gohelper.findChild(self.viewGO, "root/#go_bottomLeft")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottomLeft/#btn_task")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "root/#go_bottomLeft/#btn_task/#go_taskReddot")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottomLeft/#btn_talent")
	self._btndata = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottomLeft/#btn_data")
	self._godataReddot = gohelper.findChild(self.viewGO, "root/#go_bottomLeft/#btn_data/#go_dataReddot")
	self._btnpolygon = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_polygon")
	self._gopolygonReddot = gohelper.findChild(self.viewGO, "root/#btn_polygon/#go_polygonReddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._goploygonMapInfo = gohelper.findChild(self.viewGO, "root/#go_polygonMapInfo")
	self._txtpolygonMapName = gohelper.findChildText(self.viewGO, "root/#go_polygonMapInfo/bg/#txt_polygonMapName")
	self._gotalent1 = gohelper.findChild(self.viewGO, "root/#go_bottomLeft/#btn_talent/#go_talent1")
	self._gotalentUp1 = gohelper.findChild(self.viewGO, "root/#go_bottomLeft/#btn_talent/#go_talent1/#go_talentUp1")
	self._godata1 = gohelper.findChild(self.viewGO, "root/#go_bottomLeft/#btn_data/#go_data1")
	self._godataReddot1 = gohelper.findChild(self.viewGO, "root/#go_bottomLeft/#btn_data/#go_data1/#go_dataReddot1")
	self._gopolygon1 = gohelper.findChild(self.viewGO, "root/#btn_polygon/#go_polygon1")
	self._scrollRuleTips = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_alarmRuleTips")
	self._goalarmRuleTips = gohelper.findChild(self.viewGO, "root/#scroll_alarmRuleTips/Viewport/#go_alarmRuleTips")
	self._goalarmRuleItem = gohelper.findChild(self.viewGO, "root/#scroll_alarmRuleTips/Viewport/#go_alarmRuleTips/#go_alarmRuleItem")
	self._btncloseAlarmRule = gohelper.findChildButtonWithAudio(self.viewGO, "root/#scroll_alarmRuleTips/#btn_closeAlarmRule")
	self._sliderPolygon = gohelper.findChildSlider(self.viewGO, "root/#go_polygonSlider")
	self._gopolygonMask = gohelper.findChild(self.viewGO, "root/#go_polygonMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonMainView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btntalent:AddClickListener(self._btntalentOnClick, self)
	self._btndata:AddClickListener(self._btndataOnClick, self)
	self._btnpolygon:AddClickListener(self._btnpolygonOnClick, self)
	self._btnalarmRule:AddClickListener(self._btnalarmRuleOnClick, self)
	self._btncloseAlarmRule:AddClickListener(self._btncloseAlarmRuleOnClick, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnLoadSceneFinish, self.refreshUI, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnUpdateElementPush, self.refreshUI, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnAlarmValueChange, self.refreshUI, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnMapUpdate, self.refreshUI, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnOpenInteractView, self.onOpenInteractView, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseInteractView, self.onCloseInteractView, self)
	self.addEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshTalentRedDot, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnClosePolygonSelectView, self.refreshReddot, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function AtomicDungeonMainView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btntalent:RemoveClickListener()
	self._btndata:RemoveClickListener()
	self._btnpolygon:RemoveClickListener()
	self._btnalarmRule:RemoveClickListener()
	self._btncloseAlarmRule:RemoveClickListener()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnLoadSceneFinish, self.refreshUI, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnUpdateElementPush, self.refreshUI, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnAlarmValueChange, self.refreshUI, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnMapUpdate, self.refreshUI, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnOpenInteractView, self.onOpenInteractView, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseInteractView, self.onCloseInteractView, self)
	self.removeEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshTalentRedDot, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnClosePolygonSelectView, self.refreshReddot, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function AtomicDungeonMainView:_btntaskOnClick()
	AtomicDungeonController.instance:openDungeonTaskView()
end

function AtomicDungeonMainView:_btntalentOnClick()
	AtomicController.instance:openTalentView()
end

function AtomicDungeonMainView:_btndataOnClick()
	AtomicController.instance:openDataBaseView()
end

function AtomicDungeonMainView:_btnpolygonOnClick()
	AtomicDungeonController.instance:openAtomicDungeonPolygonSelectView()
end

function AtomicDungeonMainView:_btnalarmRuleOnClick()
	self._scrollRuleTips.verticalNormalizedPosition = 1

	gohelper.setActive(self._scrollRuleTips.gameObject, false)
	gohelper.setActive(self._scrollRuleTips.gameObject, true)
end

function AtomicDungeonMainView:_btncloseAlarmRuleOnClick()
	self.scrollRuleTipAnim:Play("close", 0, 0)
	self.scrollRuleTipAnim:Update(0)
	TaskDispatcher.runDelay(self.hideAlarmRule, self, 0.167)
end

function AtomicDungeonMainView:_editableInitView()
	self.animView = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.scrollRuleTipAnim = self._scrollRuleTips:GetComponent(gohelper.Type_Animator)
	self.bottomLeftHLayoutGroup = self._gobottomLeft:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self.alarmRuleItemMap = self:getUserDataTb_()

	gohelper.setActive(self._goalarmRuleItem, false)
	gohelper.setActive(self._scrollRuleTips.gameObject, false)

	self.maxAlarmLevel = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.MaxAlarmLevel, true)
end

function AtomicDungeonMainView:onUpdateParam()
	return
end

function AtomicDungeonMainView:onOpen()
	RedDotController.instance:addRedDot(self._gotaskReddot, RedDotEnum.DotNode.SP02AtomicDungeonTask)
	RedDotController.instance:addRedDot(self._gopolygonReddot, RedDotEnum.DotNode.SP02AtomicDungeonPolygonSelect, nil, self.checkHasNewUnlockPolygonSelect, self)
	self:setMainUIShowState(true, true)
	self:refreshUI()
	self:refreshTaskInfo()
	self:refreshAlarmRule()
end

function AtomicDungeonMainView:setMainUIShowState(state, onOpen)
	gohelper.setActive(self._txtalarmLevel.gameObject, true)
	gohelper.setActive(self._gobottomLeft, true)
	self:playViewAnim(state, onOpen)
	gohelper.setActive(self._gotopleft, state)

	local canShowpolygon = AtomicDungeonModel.instance:isHaveUnlockPolygon()

	gohelper.setActive(self._btnpolygon.gameObject, state and canShowpolygon)
end

function AtomicDungeonMainView:playViewAnim(state, onOpen)
	local showAnimName = onOpen and "open" or "switch"

	self.animView:Play(state and showAnimName or "close", 0, 0)
	self.animView:Update(0)
end

function AtomicDungeonMainView:onOpenInteractView()
	self:playViewAnim(false)
end

function AtomicDungeonMainView:onCloseInteractView()
	self:playViewAnim(true)
end

function AtomicDungeonMainView:refreshUI()
	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	gohelper.setActive(self._gomapInfo, not isInMapSelectState and not isInPolygonState)
	gohelper.setActive(self._goploygonMapInfo, not isInMapSelectState and isInPolygonState)
	gohelper.setActive(self._goalarmLevel, not isInMapSelectState)

	if not isInMapSelectState then
		local mapId = AtomicDungeonModel.instance:getCurMapId()
		local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(mapId)
		local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(mapConfig.infoId)

		self._txtmapName.text = mapInfoConfig.mapName or ""
		self._txtpolygonMapName.text = mapInfoConfig.mapName or ""

		local curFinishCount, needFinishCount, curMapIndex = AtomicDungeonModel.instance:getCurArenaMapProgress(mapConfig.arenaId)
		local isMapFinish = AtomicDungeonModel.instance:checkCanShowPolygon(mapId)

		gohelper.setActive(self._goexplore, not isMapFinish)
		gohelper.setActive(self._gomapFinish, isMapFinish)

		local isPolygonUnlock = AtomicDungeonModel.instance:checkPolygonUnlock(mapId)

		if isPolygonUnlock then
			local canShowPolygon = AtomicDungeonModel.instance:checkCanShowPolygon(mapId)

			self._txtexplore.text = canShowPolygon and luaLang("partygame_game19_finish") or luaLang("sp02_atomic_polygon_doing")
		else
			self._txtexplore.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("sp02_atomic_map_progress"), GameUtil.getRomanNums(curMapIndex), curFinishCount, needFinishCount)
		end
	end

	local canShowpolygon = AtomicDungeonModel.instance:isHaveUnlockPolygon()

	gohelper.setActive(self._btnpolygon.gameObject, canShowpolygon)

	local curAlarmLevel = AtomicDungeonModel.instance:getCurAlarmLevel()

	self._txtalarmLevel.text = string.format("%02d", curAlarmLevel)

	gohelper.setActive(self._gohardEffect, curAlarmLevel >= self.maxAlarmLevel and not isInMapSelectState)

	self.bottomLeftHLayoutGroup.spacing = isInPolygonState and not isInMapSelectState and 80 or 10

	local canShowpolygon = AtomicDungeonModel.instance:isHaveUnlockPolygon()
	local isTalentUnlock = AtomicDungeonModel.instance:checkTalentUnlock()

	gohelper.setActive(self._btntalent.gameObject, isTalentUnlock and (not isInPolygonState or isInMapSelectState))
	gohelper.setActive(self._btnpolygon.gameObject, canShowpolygon and (not isInPolygonState or isInMapSelectState))
	gohelper.setActive(self._btndata.gameObject, not isInPolygonState or isInMapSelectState)
	gohelper.setActive(self._btntask.gameObject, not isInPolygonState or isInMapSelectState)
	gohelper.setActive(self._gofullMask, not isInPolygonState or isInMapSelectState)
	gohelper.setActive(self._sliderPolygon.gameObject, isInPolygonState and not isInMapSelectState)
	gohelper.setActive(self._gopolygonMask, isInPolygonState and not isInMapSelectState)
	self:refreshTalentRedDot()
	self:refreshDataBaseRedDot()
end

function AtomicDungeonMainView:refreshTaskInfo()
	local atomicDungeonTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.AtomicDungeon) or {}

	AtomicDungeonTaskModel.instance:setTaskInfoList(atomicDungeonTasks)
end

function AtomicDungeonMainView:refreshAlarmRule()
	local maxAlarmLevel = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.MaxAlarmLevel, true)

	for level = 1, maxAlarmLevel do
		local ruleItem = self.alarmRuleItemMap[level]

		if not ruleItem then
			ruleItem = {
				go = gohelper.clone(self._goalarmRuleItem, self._goalarmRuleTips, "ruleItem" .. level)
			}
			ruleItem.txtName = gohelper.findChildText(ruleItem.go, "txt_name")
			ruleItem.txtDesc = gohelper.findChildText(ruleItem.go, "txt_desc")
			ruleItem.goLine = gohelper.findChild(ruleItem.go, "go_line")
			self.alarmRuleItemMap[level] = ruleItem
		end

		gohelper.setActive(ruleItem.go, true)

		ruleItem.txtName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_atomic_alarmLevel"), level)

		local descStr = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId["AdditionRule" .. level], false, true)

		ruleItem.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(ruleItem.txtDesc.gameObject, FixTmpBreakLine)
		ruleItem.txtDesc.text = SkillHelper.buildDesc(descStr)

		ruleItem.fixTmpBreakLine:refreshTmpContent(ruleItem.txtDesc)
		SkillHelper.addHyperLinkClick(ruleItem.txtDesc, self._onHyperLinkClick, self)
		gohelper.setActive(ruleItem.goLine, level < maxAlarmLevel)
	end
end

function AtomicDungeonMainView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function AtomicDungeonMainView:refreshTalentRedDot()
	local canLight = AtomicTalentViewModel.instance:isTalentCanLight()

	gohelper.setActive(self._gotalentUp1, canLight)
end

function AtomicDungeonMainView:refreshDataBaseRedDot()
	local canShowNew = AtomicDataBaseViewModel.instance:isDataBaseHasNew()

	gohelper.setActive(self._godataReddot1, canShowNew)
end

function AtomicDungeonMainView:hideAlarmRule()
	gohelper.setActive(self._scrollRuleTips.gameObject, false)
end

function AtomicDungeonMainView:refreshReddot()
	RedDotController.instance:addRedDot(self._gopolygonReddot, RedDotEnum.DotNode.SP02AtomicDungeonPolygonSelect, nil, self.checkHasNewUnlockPolygonSelect, self)
end

function AtomicDungeonMainView:checkHasNewUnlockPolygonSelect(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = AtomicDungeonController.instance:checkHasNewUnlockPolygonSelect()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function AtomicDungeonMainView:onCloseView(viewName)
	if viewName == ViewName.AtomicDataBaseView then
		self:refreshDataBaseRedDot()
	end

	TaskDispatcher.cancelTask(self.hideAlarmRule, self)
end

function AtomicDungeonMainView:onClose()
	return
end

function AtomicDungeonMainView:onDestroyView()
	return
end

return AtomicDungeonMainView
