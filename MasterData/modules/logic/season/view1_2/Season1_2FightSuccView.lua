-- chunkname: @modules/logic/season/view1_2/Season1_2FightSuccView.lua

module("modules.logic.season.view1_2.Season1_2FightSuccView", package.seeall)

local Season1_2FightSuccView = class("Season1_2FightSuccView", FightSuccView)

function Season1_2FightSuccView:onInitView()
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2FightSuccView:addEvents()
	self._btnData:AddClickListener(self._onClickData, self)
	self._click:AddClickListener(self._onClickClose, self)
	self._btncoverrecord:AddClickListener(self._onBtnCoverRecordClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, self._onCoverDungeonRecordReply, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Season1_2FightSuccView:removeEvents()
	self._btnData:RemoveClickListener()
	self._click:RemoveClickListener()
	self._btncoverrecord:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Season1_2FightSuccView:_editableInitView()
	self._click = gohelper.getClick(self.viewGO)
end

function Season1_2FightSuccView:_onClickClose()
	if self._showEquipCard then
		return
	end

	Season1_2FightSuccView.super._onClickClose(self)
end

function Season1_2FightSuccView:onOpen()
	Season1_2FightSuccView.super.onOpen(self)
	gohelper.setActive(self._bonusItemContainer, false)
	self:_dealGetCard()
	self:_showGoal()
end

function Season1_2FightSuccView:_dealGetCard()
	local reward_list = {}

	tabletool.addValues(reward_list, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getMaterialDataList())

	local equip_cards = {}

	for i = #reward_list, 1, -1 do
		local data = reward_list[i]

		if data.materilType == MaterialEnum.MaterialType.EquipCard then
			local tar_reward = table.remove(reward_list, i)

			table.insert(equip_cards, tar_reward.materilId)
		end
	end

	self._showEquipCard = {}
	self._choiceCards = {}
	self._newCardDic = {}

	for i, cardId in ipairs(equip_cards) do
		if SeasonConfig.instance:getEquipIsOptional(cardId) then
			table.insert(self._choiceCards, cardId)
		elseif Activity104Model.instance:isNew104Equip(cardId) then
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
	elseif #self._choiceCards > 0 then
		TaskDispatcher.runDelay(self._showChoiceCardView, self, 2)
	else
		self:_showRewardPart()
	end
end

function Season1_2FightSuccView:_loadBonusItems()
	return
end

function Season1_2FightSuccView:_showGetCardView()
	Activity104Controller.instance:openSeasonCelebrityCardGetlView({
		is_item_id = true,
		data = self._showEquipCard
	})
end

function Season1_2FightSuccView:_onTipsClose()
	self:_showRewardPart()
	self:_showPlayerLevelUpView()
end

function Season1_2FightSuccView:_showRewardPart()
	self._showEquipCard = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	gohelper.setActive(self._bonusItemContainer, true)
	Season1_2FightSuccView.super._loadBonusItems(self)
end

function Season1_2FightSuccView:_onCloseViewFinish(viewName)
	local getViewName = SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView)

	if viewName == getViewName then
		if self:_showChoiceCardView() then
			return
		end

		self:_onTipsClose()
	end
end

function Season1_2FightSuccView:_showChoiceCardView()
	if self._choiceCards and #self._choiceCards > 0 then
		local cardId = table.remove(self._choiceCards, 1)
		local cardUid = Activity104Model.instance:getItemEquipUid(cardId)

		if cardUid then
			local param = {}

			param.actId = Activity104Model.instance:getCurSeasonId()
			param.costItemUid = cardUid

			Activity104Controller.instance:openSeasonEquipSelectChoiceView(param)

			return true
		end
	end
end

function Season1_2FightSuccView:_addItem(material)
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

	if material.materilType == MaterialEnum.MaterialType.EquipCard then
		local isNew = self._newCardDic[material.materilId]

		self._equipCards = self._equipCards or {}

		local cardItem = Season1_2CelebrityCardItem.New()

		cardItem:init(gohelper.findChild(go, "container/cardicon"), material.materilId)
		cardItem:showNewFlag(isNew)
		table.insert(self._equipCards, cardItem)

		for i = 1, 5 do
			local effectObj = gohelper.findChild(go, "container/cardicon/#vx_glow/" .. i)
			local config = SeasonConfig.instance:getSeasonEquipCo(material.materilId)

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

function Season1_2FightSuccView:_setFbName(episodeCO)
	if episodeCO.type == DungeonEnum.EpisodeType.SeasonRetail then
		local showStage = math.min(Activity104Model.instance:getAct104CurStage(), 6)
		local retail = Activity104Model.instance.curBattleRetail
		local actId = Activity104Model.instance:getCurSeasonId()
		local tagCo = SeasonConfig.instance:getSeasonTagDesc(actId, retail.tag)

		self._txtFbName.text = string.format("%s %s", tagCo and tagCo.name, GameUtil.getRomanNums(showStage))
	else
		self._txtFbName.text = episodeCO.name
	end
end

function Season1_2FightSuccView:_showGoal()
	gohelper.setActive(self._goallist, false)

	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]

	if curEpisodeConfig and curEpisodeConfig.type == DungeonEnum.EpisodeType.SeasonRetail then
		local retail = Activity104Model.instance.curBattleRetail
		local advancedId = retail.advancedId
		local conditionConfig = lua_condition.configDict[advancedId]

		if conditionConfig then
			gohelper.setActive(self._goallist, true)
			gohelper.setActive(gohelper.findChild(self._goallist, "fightgoal"), true)

			local condition = gohelper.findChildText(self._goallist, "fightgoal/condition")

			condition.text = conditionConfig.desc

			local starColor = "#87898C"

			if retail.star >= 2 then
				if retail.advancedRare == 1 then
					starColor = "#A3F14C"
				elseif retail.advancedRare == 2 then
					starColor = "#FF423F"
				end
			end

			local star = gohelper.findChildImage(self._goallist, "fightgoal/star")

			SLFramework.UGUI.GuiHelper.SetColor(star, starColor)
		end
	end
end

function Season1_2FightSuccView:_checkTypeDetails()
	return
end

function Season1_2FightSuccView:_hideGoDemand()
	return
end

function Season1_2FightSuccView:onClose()
	TaskDispatcher.cancelTask(self._showGetCardView, self)
	TaskDispatcher.cancelTask(self._showChoiceCardView, self)

	if self._equipCards then
		for i, v in ipairs(self._equipCards) do
			v:destroy()
		end

		self._equipCards = nil
	end

	Season1_2FightSuccView.super.onClose(self)
end

function Season1_2FightSuccView:onDestroyView()
	Season1_2FightSuccView.super.onDestroyView(self)
end

return Season1_2FightSuccView
