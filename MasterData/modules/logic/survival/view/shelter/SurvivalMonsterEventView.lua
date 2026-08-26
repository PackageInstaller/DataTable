-- chunkname: @modules/logic/survival/view/shelter/SurvivalMonsterEventView.lua

module("modules.logic.survival.view.shelter.SurvivalMonsterEventView", package.seeall)

local SurvivalMonsterEventView = class("SurvivalMonsterEventView", BaseView)

function SurvivalMonsterEventView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageMap = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/#simage_Map")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Panel/Title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Panel/Title/#txt_TitleEn")
	self._goscore = gohelper.findChild(self.viewGO, "Panel/Buff/Viewport/Content/#go_score")
	self._txtrecommendscore = gohelper.findChildText(self.viewGO, "Panel/Buff/Viewport/Content/#go_score/recommend/#txt_recommend_score")
	self._txtcurscore = gohelper.findChildText(self.viewGO, "Panel/Buff/Viewport/Content/#go_score/current/#txt_cur_score")
	self._gotips = gohelper.findChild(self.viewGO, "Panel/Buff/Viewport/Content/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "Panel/Buff/Viewport/Content/#go_tips/#txt_tips")
	self._txttitledec = gohelper.findChildText(self.viewGO, "Panel/Buff/Viewport/Content/#txt_titledec")
	self._gobuffitem = gohelper.findChild(self.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem")
	self._gounfinish = gohelper.findChild(self.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/#go_unfinish")
	self._txtdec = gohelper.findChildText(self.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/scroll_buffDec/Viewport/Content/#txt_dec")
	self._txtdecfinished = gohelper.findChildText(self.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/scroll_buffDec/Viewport/Content/#txt_dec_finished")
	self._gofinished = gohelper.findChild(self.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/#go_finished")
	self._goNpcitem = gohelper.findChild(self.viewGO, "Panel/Npc/layout/#go_Npcitem")
	self._goempty = gohelper.findChild(self.viewGO, "Panel/Npc/layout/#go_Npcitem/#go_empty")
	self._gohas = gohelper.findChild(self.viewGO, "Panel/Npc/layout/#go_Npcitem/#go_has")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "Panel/Npc/layout/#go_Npcitem/#go_has/#simage_hero")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Npc/layout/#go_Npcitem/#btn_click")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Btns/#btn_Reset")
	self._btnFight = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Btns/#btn_Fight")
	self._btnWatch = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Btns/#btn_Watch")

	if self._editableInitView then
		self:_editableInitView()
	end

	self._goNpc = gohelper.findChild(self.viewGO, "Panel/Npc")

	gohelper.setActive(self._goNpc, false)
end

function SurvivalMonsterEventView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnFight:AddClickListener(self._btnFightOnClick, self)
	self._btnWatch:AddClickListener(self._btnWatchOnClick, self)
end

function SurvivalMonsterEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnWatch:RemoveClickListener()
end

function SurvivalMonsterEventView:_btnWatchOnClick()
	self:closeThis()

	if self._fight and self._fight:canShowEntity() then
		SurvivalMapHelper.instance:gotoMonster(self._fight.fightId, nil, true)
	end
end

function SurvivalMonsterEventView:_btncloseOnClick()
	self:closeThis()
end

function SurvivalMonsterEventView:onClickModalMask()
	self:closeThis()
end

function SurvivalMonsterEventView:_btnclickOnClick()
	return
end

function SurvivalMonsterEventView:_btnResetOnClick()
	if self._fight then
		UIBlockHelper.instance:startBlock("SurvivalMonsterEventView_Reset", 1)
		SurvivalWeekRpc.instance:sendSurvivalIntrudeReExterminateRequest()
	end
end

function SurvivalMonsterEventView:_btnFightOnClick()
	if self._fight == nil then
		return
	end

	if not self._fight:isFighting() then
		GameFacade.showToast(ToastEnum.SurvivalBossDotOpen, self._fight.beginTime)

		return
	end

	self:enterFight()
end

function SurvivalMonsterEventView:enterFight()
	self:_enterFight()
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function SurvivalMonsterEventView:_enterFight()
	if self._fight:getBattleId() then
		UIBlockHelper.instance:startBlock("SurvivalMonsterEventView_EnterFight")
		SurvivalController.instance:tryEnterShelterFight(self._enterFightFinish, self)
	end
end

function SurvivalMonsterEventView:_enterFightFinish()
	UIBlockHelper.instance:endBlock("SurvivalMonsterEventView_EnterFight")
end

function SurvivalMonsterEventView:_editableInitView()
	gohelper.setActive(self._goNpcitem, false)
	gohelper.setActive(self._gobuffitem, false)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.UpdateView, self.updateView, self)

	self._fightUIEffect = ZProj_UIEffectsCollection.Get(self._btnFight.gameObject)
	self._fightBtnAnchorX, self._fightBtnAnchorY = recthelper.getAnchor(self._btnFight.transform)
	self._resetBtnAnchorX, self._resetBtnAnchorY = recthelper.getAnchor(self._btnReset.transform)
end

function SurvivalMonsterEventView:onUpdateParam()
	return
end

function SurvivalMonsterEventView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	self.showType = self.viewParam.showType

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self._fight = weekInfo:getMonsterFight()
	self._fightConfig = self._fight.fightCo

	self:_initConfigInfo()
	self:updateView()
end

function SurvivalMonsterEventView:refreshShowType()
	gohelper.setActive(self._gotips, self.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Watch)
	gohelper.setActive(self._btnWatch.gameObject, self.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Watch)
	gohelper.setActive(self._goscore, self.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	gohelper.setActive(self._btnFight.gameObject, self.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitBossEventView, self.showType)
end

function SurvivalMonsterEventView:updateView()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self._fight = weekInfo:getMonsterFight()

	self:_refreshState()

	local recommendScore = self._fightConfig.score
	local curScore = weekInfo.equipBox:getAllScore()
	local curScoreTxtColor = "#843034"

	if recommendScore < curScore then
		curScoreTxtColor = "#19623f"
	end

	self._txtrecommendscore.text = self._fightConfig.score
	self._txtcurscore.text = weekInfo.equipBox:getAllScore()
	self._txtcurscore.color = GameUtil.parseColor(curScoreTxtColor)

	local time = self._fight.endTime - weekInfo.day

	self._txttips.text = time == 0 and luaLang("survivalmonstereventview_monster_toady") or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_SurvivalMonsterEventView_tips"), time)

	TaskDispatcher.runDelay(self._updateNpcInfo, self, 0.5)
end

function SurvivalMonsterEventView:_refreshState()
	self:refreshShowType()
	gohelper.setActive(self._btnReset, self._fight:canShowReset())

	local canFight = self._fight:isFighting()

	if self._fightUIEffect then
		self._fightUIEffect:SetGray(not canFight)
	end

	local showFight = self._fight:canShowFightBtn()

	gohelper.setActive(self._btnFight, showFight)

	local anchorX, anchorY = self._resetBtnAnchorX, self._resetBtnAnchorY

	if not showFight then
		anchorY = self._fightBtnAnchorY
		anchorX = self._fightBtnAnchorX
	end

	recthelper.setAnchor(self._btnReset.transform, anchorX, anchorY)
end

function SurvivalMonsterEventView:_initConfigInfo()
	if self._fightConfig == nil then
		return
	end

	self._txtTitle.text = self._fightConfig.name
	self._txttitledec.text = self._fightConfig.desc

	local path = self._fightConfig.image

	self._simageMap:LoadImage(path)
end

function SurvivalMonsterEventView:_updateNpcInfo()
	if self._fight == nil then
		logError("SurvivalMonsterEventView:_updateNpcInfo() self._fight is nil")

		return
	end

	self:_refreshSchemes()

	local repressNpcIds = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

	if repressNpcIds == nil then
		return
	end

	if self._repressNpcItems == nil then
		self._repressNpcItems = self:getUserDataTb_()
	end

	local configValue = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterMonsterSelectNpcMax)
	local count = configValue and tonumber(configValue) or 0

	for i = 1, count do
		local item = self._repressNpcItems[i]
		local npcId = repressNpcIds[i]

		if item == nil then
			local go = gohelper.cloneInPlace(self._goNpcitem)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalMonsterEventSmallNpcItem)

			gohelper.setActive(go, true)
			table.insert(self._repressNpcItems, item)
		end

		item:setIsCanEnterSelect(self._fight:canEnterSelectNpc())
		item:setNeedShowEmpty(self._fight:canEnterSelectNpc())
		item:updateItem(npcId)
	end
end

function SurvivalMonsterEventView:_refreshSchemes()
	local schemes = self._fight.schemes

	if self._schemesItems == nil then
		self._schemesItems = self:getUserDataTb_()
	end

	local isFight = self._fight:isFighting()

	for id, repress in pairs(schemes) do
		local item = self._schemesItems[id]

		if item == nil then
			local go = gohelper.cloneInPlace(self._gobuffitem)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalMonsterEventBuffItem)

			item:initItem(id, self._fight:getIntrudeSchemeMo(id))

			self._schemesItems[id] = item

			gohelper.setActive(go, true)
		end

		item:updateItem((not isFight or nil) and SurvivalShelterMonsterModel.instance:calBuffIsRepress(id))
	end
end

function SurvivalMonsterEventView:onClose()
	TaskDispatcher.cancelTask(self._updateNpcInfo, self)

	if self._fight:canEnterSelectNpc() then
		SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(nil)
	end
end

function SurvivalMonsterEventView:onDestroyView()
	self._simageMap:UnLoadImage()
end

return SurvivalMonsterEventView
