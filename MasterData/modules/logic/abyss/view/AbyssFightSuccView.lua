-- chunkname: @modules/logic/abyss/view/AbyssFightSuccView.lua

module("modules.logic.abyss.view.AbyssFightSuccView", package.seeall)

local AbyssFightSuccView = class("AbyssFightSuccView", BaseView)

function AbyssFightSuccView:onInitView()
	self._btnfullclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullclose")
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "#go_herogroupcontain")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_herogroupcontain/#btn_close")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_heroitem")
	self._gostarList = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/hero/vertical/#go_starList")
	self._gorecommended = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/hero/#go_recommended")
	self._gocounter = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/hero/#go_counter")
	self._txttrialtag = gohelper.findChildText(self.viewGO, "#go_heroitem/heroitemani/tags/trialtag/#txt_trial_tag")
	self._gomojing = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/#go_mojing")
	self._txt = gohelper.findChildText(self.viewGO, "#go_heroitem/heroitemani/#go_mojing/#txt")
	self._simagewintitle = gohelper.findChildSingleImage(self.viewGO, "#simage_wintitle")
	self._txtcurround = gohelper.findChildText(self.viewGO, "#txt_curround")
	self._gonewtag = gohelper.findChild(self.viewGO, "#txt_curround/#go_newtag")
	self._txtchaptername = gohelper.findChildText(self.viewGO, "chaptertitle/#txt_chaptername")
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "chaptertitle/#btn_Data")
	self._goconditionitem = gohelper.findChild(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_conditionitem")
	self._txtcondition = gohelper.findChildText(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_conditionitem/#txt_condition")
	self._gostar2 = gohelper.findChild(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_conditionitem/#go_star2")
	self._gostar1 = gohelper.findChild(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_conditionitem/#go_star1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssFightSuccView:addEvents()
	self._btnfullclose:AddClickListener(self._btnfullcloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnData:AddClickListener(self._btnDataOnClick, self)
end

function AbyssFightSuccView:removeEvents()
	self._btnfullclose:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnData:RemoveClickListener()
end

function AbyssFightSuccView:_btnfullcloseOnClick()
	self:clickClose()
end

function AbyssFightSuccView:_btncloseOnClick()
	self:clickClose()
end

function AbyssFightSuccView:_btnDataOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function AbyssFightSuccView:_editableInitView()
	self.heroItemList = self:getUserDataTb_()
	self.orderTextList = self:getUserDataTb_()
	self.heroGroupParent = gohelper.findChild(self.viewGO, "#go_herogroupcontain/hero")

	NavigateMgr.instance:addEscape(self.viewName, self.clickClose, self)
end

function AbyssFightSuccView:onUpdateParam()
	return
end

function AbyssFightSuccView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.Abyss.play_ui_stage_finish)
	self:checkParam()
	self:refreshUI()
end

function AbyssFightSuccView:clickClose()
	self:closeThis()
	FightController.onResultViewClose()
end

function AbyssFightSuccView:checkParam()
	self._resultParam = AbyssModel.instance:getCurFightResultParam()
	self.actId = AbyssModel.instance:getCurActId()
	self.stageId = AbyssModel.instance:getCurStageId()
	self.stageConfig = AbyssConfig.instance:getEpisodeConfig(self.actId, self.stageId)
	self.totalStar = AbyssConfig.instance:getStageMaxStar(self.actId, self.stageId) or 0
end

function AbyssFightSuccView:refreshUI()
	self:refreshInfo()
	self:refreshTarget()
	self:initHeroGroup()
end

function AbyssFightSuccView:refreshInfo()
	local isNewScore = self._resultParam.minRound == 0 or self._resultParam.round < self._resultParam.minRound

	gohelper.setActive(self._gonewtag, isNewScore)

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.stageConfig.episodeId)

	self._txtchaptername.text = episodeConfig.name
	self._txtcurround.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a6_abyss_result_round_desc"), self._resultParam.round)
end

function AbyssFightSuccView:initHeroGroup()
	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local parentGo = gohelper.findChild(self.heroGroupParent, string.format("bg%s/bg", i))
		local itemGo = gohelper.clone(self._goheroitem, self._goherogroupcontain)

		self.heroItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, AbyssFightResultHeroItem)

		local positonX, positonY = recthelper.rectToRelativeAnchorPos2(parentGo.transform.position, self._goherogroupcontain.transform)

		recthelper.setAnchor(itemGo.transform, positonX, positonY)
		gohelper.setActive(itemGo, true)
	end

	self:_refreshHeroGroup()
end

function AbyssFightSuccView:_refreshHeroGroup()
	local fightParam = FightModel.instance:getFightParam()

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroUid = fightParam.mySideUids[i]
		local equip = fightParam.equips[i]
		local equipUid = equip and equip.equipUid[1]
		local heroMo = HeroModel.instance:getById(heroUid)
		local equipMo = EquipModel.instance:getEquip(equipUid)
		local heroItem = self.heroItemList[i]

		if heroMo then
			heroItem:setData(heroMo, equipMo)
		else
			heroItem:setData()
		end
	end
end

function AbyssFightSuccView:refreshTarget()
	local conditionList = AbyssHelper.getEpisodeConditionDescList(self.stageConfig.episodeId)

	gohelper.CreateObjList(self, self.onCreateTargetItem, conditionList, nil, self._goconditionitem)
end

function AbyssFightSuccView:onCreateTargetItem(itemGo, desc, index)
	local text = gohelper.findChildTextMesh(itemGo, "#txt_condition")
	local starFinish = gohelper.findChild(itemGo, "#go_star1")
	local starUnlock = gohelper.findChild(itemGo, "#go_star2")
	local starFinish2 = gohelper.findChild(itemGo, "#go_star3")
	local starUnlock2 = gohelper.findChild(itemGo, "#go_star4")
	local isFinish = index <= self._resultParam.star
	local isFinal = index >= self.totalStar

	text.text = desc

	ZProj.UGUIHelper.SetColorAlpha(text, isFinish and 1 or 0.63)
	gohelper.setActive(starFinish, isFinish and not isFinal)
	gohelper.setActive(starUnlock, not isFinish and not isFinal)
	gohelper.setActive(starFinish2, isFinish and isFinal)
	gohelper.setActive(starUnlock2, not isFinish and isFinal)
end

function AbyssFightSuccView:onClose()
	return
end

function AbyssFightSuccView:onDestroyView()
	return
end

return AbyssFightSuccView
