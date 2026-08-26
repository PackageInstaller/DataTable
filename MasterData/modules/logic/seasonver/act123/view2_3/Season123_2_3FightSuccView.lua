-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3FightSuccView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightSuccView", package.seeall)

local Season123_2_3FightSuccView = class("Season123_2_3FightSuccView", FightSuccView)

function Season123_2_3FightSuccView:onInitView()
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "btnData")
	self._simagecharacterbg = gohelper.findChildSingleImage(self.viewGO, "#simage_characterbg")
	self._simagemaskImage = gohelper.findChildSingleImage(self.viewGO, "#simage_maskImage")
	self._godetails = gohelper.findChild(self.viewGO, "#go_details")
	self._gocoverrecordpart = gohelper.findChild(self.viewGO, "#go_cover_record_part")
	self._btncoverrecord = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cover_record_part/#btn_cover_record")
	self._txtcurroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	self._txtmaxroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	self._goCoverLessThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	self._goCoverMuchThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	self._goCoverEqual = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	self._bonusItemGo = gohelper.findChild(self.viewGO, "scroll/item")
	self._favorIcon = gohelper.findChild(self.viewGO, "scroll/viewport/content/favor")
	self._txtFbName = gohelper.findChildText(self.viewGO, "txtFbName")
	self._txtFbNameEn = gohelper.findChildText(self.viewGO, "txtFbNameen")
	self._goallist = gohelper.findChild(self.viewGO, "goalcontent/goallist")
	self._txtLv = gohelper.findChildText(self.viewGO, "goalcontent/txtLv")
	self._sliderExp = gohelper.findChildSlider(self.viewGO, "goalcontent/txtLv/progress")
	self._txtExp = gohelper.findChildText(self.viewGO, "goalcontent/txtLv/txtExp")
	self._txtAddExp = gohelper.findChildText(self.viewGO, "goalcontent/txtLv/progress/txtAddExp")
	self._gospine = gohelper.findChild(self.viewGO, "spineContainer/spine")
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)
	self._goCondition = gohelper.findChild(self.viewGO, "goalcontent/goallist/fightgoal")
	self._goPlatCondition = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinum")
	self._goPlatCondition2 = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinum2")
	self._bonusItemContainer = gohelper.findChild(self.viewGO, "scroll/viewport/content")
	self._bonusItemGo = gohelper.findChild(self.viewGO, "scroll/item")
	self._txtSayCn = gohelper.findChildText(self.viewGO, "txtSayCn")
	self._txtSayEn = gohelper.findChildText(self.viewGO, "SayEn/txtSayEn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3FightSuccView:addEvents()
	self._btnData:AddClickListener(self._onClickData, self)
	self._click:AddClickListener(self._onClickClose, self)
	self._btncoverrecord:AddClickListener(self._onBtnCoverRecordClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, self._onCoverDungeonRecordReply, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Season123_2_3FightSuccView:removeEvents()
	self._btnData:RemoveClickListener()
	self._click:RemoveClickListener()
	self._btncoverrecord:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Season123_2_3FightSuccView:_editableInitView()
	self._click = gohelper.getClick(self.viewGO)
end

function Season123_2_3FightSuccView:_onClickClose()
	if self._showEquipCard then
		return
	end

	Season123_2_3FightSuccView.super._onClickClose(self)
end

function Season123_2_3FightSuccView:onOpen()
	Season123_2_3FightSuccView.super.onOpen(self)
	gohelper.setActive(self._bonusItemContainer, false)
	self:_dealGetCard()
	self:_showGoal()
	NavigateMgr.instance:addEscape(self.viewName, self._onClickClose, self)
end

function Season123_2_3FightSuccView:_dealGetCard()
	local reward_list = {}

	tabletool.addValues(reward_list, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getMaterialDataList())

	local equip_cards = {}

	for i = #reward_list, 1, -1 do
		local data = reward_list[i]

		if data.materilType == MaterialEnum.MaterialType.Season123EquipCard then
			local tar_reward = table.remove(reward_list, i)

			table.insert(equip_cards, tar_reward.materilId)
		end
	end

	self._showEquipCard = {}
	self._newCardDic = {}

	for i, cardId in ipairs(equip_cards) do
		if Season123Model.instance:isNewEquipBookCard(cardId) then
			table.insert(self._showEquipCard, cardId)

			self._newCardDic[cardId] = true
		end
	end

	if #self._showEquipCard > 0 then
		local idDict = {}

		for i = #self._showEquipCard, 1, -1 do
			local cardId = self._showEquipCard[i]

			if idDict[cardId] then
				table.remove(self._showEquipCard, i)
			else
				idDict[cardId] = true
			end
		end

		TaskDispatcher.runDelay(self._showGetCardView, self, 2)
	else
		self:_showRewardPart()
	end
end

function Season123_2_3FightSuccView:_loadBonusItems()
	return
end

function Season123_2_3FightSuccView:_showGetCardView()
	Season123Controller.instance:openSeasonCelebrityCardGetView({
		is_item_id = true,
		data = self._showEquipCard
	})
end

function Season123_2_3FightSuccView:_onTipsClose()
	self:_showRewardPart()
	self:_showPlayerLevelUpView()
end

function Season123_2_3FightSuccView:_showRewardPart()
	self._showEquipCard = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	gohelper.setActive(self._bonusItemContainer, true)
	Season123_2_3FightSuccView.super._loadBonusItems(self)
end

function Season123_2_3FightSuccView:_onCloseViewFinish(viewName)
	local getViewName = ViewName.Season123_2_3CelebrityCardGetView

	if viewName == getViewName then
		self:_onTipsClose()
	end
end

function Season123_2_3FightSuccView:_addItem(material)
	local go = gohelper.clone(self._bonusItemGo, self._bonusItemContainer, material.id)
	local tagGO = gohelper.findChild(go, "container/tag")
	local imgFirstGO = gohelper.findChild(go, "container/tag/imgFirst")
	local imgFirstHardGO = gohelper.findChild(go, "container/tag/imgFirstHard")
	local imgNormalGO = gohelper.findChild(go, "container/tag/imgNormal")
	local imgAdvanceGO = gohelper.findChild(go, "container/tag/imgAdvance")
	local imgEquipDailyGO = gohelper.findChild(go, "container/tag/imgEquipDaily")
	local containerGO = gohelper.findChild(go, "container")

	gohelper.setActive(containerGO, false)
	gohelper.setActive(tagGO, material.bonusTag)

	if material.bonusTag then
		gohelper.setActive(imgFirstGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and not self._hardMode)
		gohelper.setActive(imgFirstHardGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._hardMode)
		gohelper.setActive(imgNormalGO, false)
		gohelper.setActive(imgAdvanceGO, material.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(imgEquipDailyGO, material.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
	end

	material.isIcon = true

	if material.materilType == MaterialEnum.MaterialType.Season123EquipCard then
		local isNew = self._newCardDic[material.materilId]

		self._equipCards = self._equipCards or {}

		local cardItem = Season123_2_3CelebrityCardItem.New()

		cardItem:init(gohelper.findChild(go, "container/cardicon"), material.materilId)
		cardItem:showNewFlag(isNew)
		table.insert(self._equipCards, cardItem)

		for i = 1, 5 do
			local effectObj = gohelper.findChild(go, "container/cardicon/#vx_glow/" .. i)
			local config = Season123Config.instance:getSeasonEquipCo(material.materilId)

			gohelper.setActive(effectObj, i == config.rare)
		end
	else
		local itemIconGO = gohelper.findChild(go, "container/itemIcon")
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemIconGO)

		itemIcon:onUpdateMO(material)
		itemIcon:setCantJump(true)
		itemIcon:setCountFontSize(40)
		itemIcon:setAutoPlay(true)
		itemIcon:isShowEquipRefineLv(true)
	end

	gohelper.setActive(go, false)

	local canvasGroup = tagGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0

	self:applyBonusVfx(material, go)

	return containerGO, go
end

function Season123_2_3FightSuccView:_setFbName(episodeCO)
	self._txtFbName.text = episodeCO.name
	self._txtFbNameEn.text = episodeCO.name_En
end

function Season123_2_3FightSuccView:_showGoal()
	gohelper.setActive(self._goallist, false)
end

function Season123_2_3FightSuccView:_checkTypeDetails()
	return
end

function Season123_2_3FightSuccView:_hideGoDemand()
	return
end

function Season123_2_3FightSuccView:onClose()
	TaskDispatcher.cancelTask(self._showGetCardView, self)

	if self._equipCards then
		for i, v in ipairs(self._equipCards) do
			v:destroy()
		end

		self._equipCards = nil
	end

	Season123_2_3FightSuccView.super.onClose(self)
end

function Season123_2_3FightSuccView:onDestroyView()
	Season123_2_3FightSuccView.super.onDestroyView(self)
end

return Season123_2_3FightSuccView
