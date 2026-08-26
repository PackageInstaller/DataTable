-- chunkname: @modules/logic/fight/view/FightFailView.lua

module("modules.logic.fight.view.FightFailView", package.seeall)

local FightFailView = class("FightFailView", BaseView)

function FightFailView:onInitView()
	self._gocost = gohelper.findChild(self.viewGO, "#go_cost")
	self._txtaddActive = gohelper.findChildText(self.viewGO, "#go_cost/#txt_addActive")
	self._gofirstfailtxt = gohelper.findChild(self.viewGO, "#go_cost/#txt_addActive/#go_firstfailtxt")
	self._goAddActive = gohelper.findChild(self.viewGO, "#go_cost/#txt_addActive")
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cost/#btn_data")
	self._gocosticon = gohelper.findChild(self.viewGO, "#go_cost/#go_costicon")
	self._costitemIcon = gohelper.findChildSingleImage(self._gocosticon, "itemIcon")
	self._costcurrencyIcon = gohelper.findChildImage(self._gocosticon, "currencyIcon")
	self._gotips = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips")
	self._golevel = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_level")
	self._goinfos = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos")
	self._golevelsubcontainer = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer")
	self._goequipsubcontainer = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer")
	self._gotalentsubcontainer = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer")
	self._imagelevelcareer = gohelper.findChildImage(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#image_levelcareer")
	self._txtleveltitle = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#txt_leveltitle")
	self._txtlevelnum = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#txt_levelnum")
	self._imageequipcareer = gohelper.findChildImage(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#image_equipcareer")
	self._txtequiptitle = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#txt_equiptitle")
	self._txtequipnum = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#txt_equipnum")
	self._imagetalentcareer = gohelper.findChildImage(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#image_talentcareer")
	self._txttalenttitle = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#txt_talenttitle")
	self._txttalentnum = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#txt_talentnum")
	self._gorestrain = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_restrain")
	self._goherotipslist = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_restrain/#go_herotipslist")
	self._goconditions = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_conditions")
	self._goconditionitem = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item")
	self._gonormaltip = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_normaltip")
	self._goteachnote = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_teachnote")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightFailView:addEvents()
	self._click:AddClickListener(self._onClickClose, self)
	self._btnData:AddClickListener(self._onClickData, self)
end

function FightFailView:removeEvents()
	self._click:RemoveClickListener()
	self._btnData:RemoveClickListener()
end

FightFailView.CareerToImageName = {
	"zhandou_icon_yan",
	"zhandou_icon_xing",
	"zhandou_icon_mu",
	"zhandou_icon_shou",
	"zhandou_icon_ling",
	"zhandou_icon_zhi",
	[101] = "zhandou_icon_101"
}
FightFailView.ShowLevelContainerValue = 0.8
FightFailView.OffsetValue = 1.6
FightFailView.PercentRedColor = "#b26161"
FightFailView.PercentWhiteColor = "#e2e2e2"
FightFailView.TxtRedColor = "#b26161"
FightFailView.TxtWhiteColor = "#adadad"
FightFailView.RedImageName = "zhandou_tuoyuan_hong"
FightFailView.WhiteImageName = "zhandou_tuoyuan_bai"

function FightFailView:_editableInitView()
	self._click = gohelper.getClick(self.viewGO)

	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._gorestrain, false)
	gohelper.setActive(self._goconditions, false)
	gohelper.setActive(self._gonormaltip, false)
	gohelper.setActive(self._goteachnote, false)

	self.restrainItem = gohelper.findChild(self._goherotipslist, "item")

	gohelper.setActive(self.restrainItem, false)
	gohelper.setActive(self._goconditionitem, false)

	local chapterId = DungeonModel.instance.curSendChapterId

	if chapterId then
		local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

		self.isSimple = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Simple
	end

	local constStr = lua_const.configDict[ConstEnum.SimpleEpisodeEffectiveness]

	self.constEffectiveness = string.splitToNumber(constStr.value, "#")
end

function FightFailView:_onClickClose()
	self:_exitFight()
end

function FightFailView:_onClickData()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function FightFailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	FightController.instance:checkFightQuitTipViewClose()

	self.fightParam = FightModel.instance:getFightParam()
	self._episodeId = self.fightParam.episodeId
	self._chapterId = self.fightParam.chapterId
	self.episodeCo = lua_episode.configDict[self._episodeId]
	self.chapterCo = DungeonConfig.instance:getChapterCO(self._chapterId)
	self.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	NavigateMgr.instance:addEscape(ViewName.FightFailView, self._onClickClose, self)

	if self:_hideActiveGo() then
		if self.episodeCo then
			gohelper.setActive(self._gocost, true)

			self._txtaddActive.text = ""
		end

		gohelper.setActive(self._gofirstfailtxt, false)
	else
		local fightParam = FightModel.instance:getFightParam()

		if fightParam then
			if not fightParam.multiplication then
				local multiplication = 1

				if not FightModel.instance.cacheUserDungeonMO then
					local episodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)
					local returnCost = DungeonConfig.instance:getEpisodeFailedReturnCost(self._episodeId, multiplication)

					gohelper.setActive(self._gofirstfailtxt, true)

					if self.episodeCo then
						local costList = string.splitToNumber(self.episodeCo.cost, "#")
						local costType = costList[1]
						local costId = costList[2]

						if costType == MaterialEnum.MaterialType.Currency then
							gohelper.setActive(self._costcurrencyIcon.gameObject, true)

							local currencyCO = CurrencyConfig.instance:getCurrencyCo(costId)

							UISpriteSetMgr.instance:setCurrencyItemSprite(self._costcurrencyIcon, currencyCO.icon .. "_1")

							self._txtaddActive.text = string.format(luaLang("fightfail_returncost"), returnCost)
						else
							gohelper.setActive(self._costitemIcon.gameObject, true)

							local icon = ItemModel.instance:getItemSmallIcon(costId)
							local itemConfig = ItemModel.instance:getItemConfig(costType, costId)

							self._costitemIcon:LoadImage(icon)

							local tag = {
								itemConfig.name,
								returnCost
							}

							self._txtaddActive.text = GameUtil.getSubPlaceholderLuaLang(luaLang("fightfail_returncost2"), tag)
						end
					end
				end
			end
		end
	end

	self:refreshTips()
end

function FightFailView:_hideActiveGo()
	if self.episodeCo and self.episodeCo.type == DungeonEnum.EpisodeType.Equip then
		return FightModel.instance:isEnterUseFreeLimit()
	end

	if self.episodeCo and (self.episodeCo.type == DungeonEnum.EpisodeType.WeekWalk or self.episodeCo.type == DungeonEnum.EpisodeType.Season) then
		return true
	end

	local endBattleCost = tonumber(DungeonConfig.instance:getEndBattleCost(self._episodeId, false)) or 0

	if endBattleCost <= 0 then
		return true
	end

	return false
end

function FightFailView:refreshTips()
	if not self.chapterCo or self.chapterCo.type == DungeonEnum.ChapterType.TeachNote then
		self:refreshTeachNoteContainer()

		return
	end

	local _, counter = FightHelper.detectAttributeCounter()
	local showHeroCoList

	if #counter ~= 0 then
		showHeroCoList = self:getCounterHeroList(self.fightParam:getAllHeroMoList(), counter)
	end

	local heroPercent = self:getHeroPercent()
	local equipPercent = self:getEquipPercent()
	local talentPercent = self:getTalentPercent()

	if heroPercent < FightFailView.ShowLevelContainerValue or equipPercent < FightFailView.ShowLevelContainerValue or talentPercent < FightFailView.ShowLevelContainerValue then
		self:refreshLevelContainer(heroPercent, equipPercent, talentPercent)
	elseif showHeroCoList and #showHeroCoList ~= 0 then
		self:refreshRestrainContainer(showHeroCoList)
	end

	local conditionCoList = self:getShowConditionsCoList()

	if self.episodeCo.type == DungeonEnum.EpisodeType.Meilanni then
		conditionCoList = HeroGroupFightViewRule.meilanniExcludeRules(conditionCoList)
	end

	if self.episodeCo.type == DungeonEnum.EpisodeType.Survival then
		conditionCoList = SurvivalShelterModel.instance:addExRule(conditionCoList)
	end

	if self.episodeCo.chapterId == AtomicDungeonEnum.TalentChapterId or self.episodeCo.chapterId == AtomicDungeonEnum.TalentChapterId2 then
		local alarmRuleList = AtomicDungeonModel.instance:getAlarmRuleList()

		tabletool.addValues(conditionCoList, alarmRuleList)
	end

	if conditionCoList and #conditionCoList ~= 0 then
		self:refreshConditionsContainer(conditionCoList)
	else
		self:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(self.rebuildLayout, self, 0.01)
end

function FightFailView:refreshLevelContainer(heroPercent, equipPercent, talentPercent)
	gohelper.setActive(self._golevel, true)

	self._txtlevelnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(heroPercent, FightFailView.OffsetValue) * 100), 100)) .. "%"
	self._txtequipnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(equipPercent, FightFailView.OffsetValue) * 100), 100)) .. "%"
	self._txttalentnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(talentPercent, FightFailView.OffsetValue) * 100), 100)) .. "%"

	if heroPercent > FightFailView.ShowLevelContainerValue then
		UISpriteSetMgr.instance:setFightSprite(self._imagelevelcareer, FightFailView.WhiteImageName)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtlevelnum, FightFailView.PercentWhiteColor)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtleveltitle, FightFailView.TxtWhiteColor)
	else
		UISpriteSetMgr.instance:setFightSprite(self._imagelevelcareer, FightFailView.RedImageName)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtlevelnum, FightFailView.PercentRedColor)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtleveltitle, FightFailView.TxtRedColor)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		gohelper.setActive(self._goequipsubcontainer, true)

		if equipPercent > FightFailView.ShowLevelContainerValue then
			UISpriteSetMgr.instance:setFightSprite(self._imageequipcareer, FightFailView.WhiteImageName)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtequipnum, FightFailView.PercentWhiteColor)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtequiptitle, FightFailView.TxtWhiteColor)
		else
			UISpriteSetMgr.instance:setFightSprite(self._imageequipcareer, FightFailView.RedImageName)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtequipnum, FightFailView.PercentRedColor)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtequiptitle, FightFailView.TxtRedColor)
		end
	else
		gohelper.setActive(self._goequipsubcontainer, false)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		gohelper.setActive(self._gotalentsubcontainer, true)

		if talentPercent > FightFailView.ShowLevelContainerValue then
			UISpriteSetMgr.instance:setFightSprite(self._imagetalentcareer, FightFailView.WhiteImageName)
			SLFramework.UGUI.GuiHelper.SetColor(self._txttalentnum, FightFailView.PercentWhiteColor)
			SLFramework.UGUI.GuiHelper.SetColor(self._txttalenttitle, FightFailView.TxtWhiteColor)
		else
			UISpriteSetMgr.instance:setFightSprite(self._imagetalentcareer, FightFailView.RedImageName)
			SLFramework.UGUI.GuiHelper.SetColor(self._txttalentnum, FightFailView.PercentRedColor)
			SLFramework.UGUI.GuiHelper.SetColor(self._txttalenttitle, FightFailView.TxtRedColor)
		end
	else
		gohelper.setActive(self._gotalentsubcontainer, false)
	end
end

function FightFailView:refreshRestrainContainer(showHeroCoList)
	for i, heroCo in ipairs(showHeroCoList) do
		local itemGo = gohelper.clone(self.restrainItem, self._goherotipslist, "item" .. i)
		local careerIcon = gohelper.findChildImage(itemGo, "image_career")
		local txt = gohelper.findChildText(itemGo, "txt_herotips")

		UISpriteSetMgr.instance:setFightSprite(careerIcon, FightFailView.CareerToImageName[heroCo.career])

		txt.text = string.format(luaLang("restrain_text"), heroCo.name)

		gohelper.setActive(itemGo, true)
	end

	gohelper.setActive(self._gorestrain, true)
end

function FightFailView:refreshConditionsContainer(conditionList)
	for i, rule in ipairs(conditionList) do
		local targetId = rule[1]
		local ruleId = rule[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			local itemGo = gohelper.clone(self._goconditionitem, self._goconditions, "item" .. i)
			local txt = gohelper.findChildText(itemGo, "#txt_extratips")
			local srcDesc = ruleCo.desc
			local descContent = SkillHelper.buildDesc(srcDesc, "#FFFFFF", "#FFFFFF")
			local langStr = luaLang("dungeon_add_rule_target_" .. targetId)

			txt.text = string.format("[%s]%s", langStr, descContent)

			gohelper.setActive(itemGo, true)
		end
	end

	gohelper.setActive(self._goconditions, true)
end

function FightFailView:refreshNormalContainer()
	gohelper.setActive(self._gonormaltip, true)
end

function FightFailView:refreshTeachNoteContainer()
	gohelper.setActive(self._goteachnote, true)
end

function FightFailView:getCounterHeroList(heroMoList, careerList)
	local counterHeroList = {}

	for _, heroMo in ipairs(heroMoList) do
		for _, career in ipairs(careerList) do
			local heroCo = heroMo.config

			if heroCo and heroCo.career == career then
				table.insert(counterHeroList, heroCo)

				break
			end
		end
	end

	return counterHeroList
end

function FightFailView:getHeroPercent()
	local heroAverage = EffectivenessConfig.instance:calculateHeroAverageEffectiveness(self.fightParam:getMainHeroMoList(), self.fightParam:getSubHeroMoList())

	if self.isSimple then
		if not self.constEffectiveness[1] then
			local heroEffectiveness = self.battleCo.heroEffectiveness

			return self:calculatePercent(heroAverage, heroEffectiveness)
		end
	end
end

function FightFailView:getEquipPercent()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		return FightFailView.ShowLevelContainerValue + 1
	end

	local equipAverage = EffectivenessConfig.instance:calculateEquipAverageEffectiveness(self.fightParam:getEquipMoList())

	if self.isSimple then
		if not self.constEffectiveness[2] then
			local equipEffectiveness = self.battleCo.equipEffectiveness

			return self:calculatePercent(equipAverage, equipEffectiveness)
		end
	end
end

function FightFailView:getTalentPercent()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		return FightFailView.ShowLevelContainerValue + 1
	end

	local talentAverage = EffectivenessConfig.instance:calculateTalentAverageEffectiveness(self.fightParam:getMainHeroMoList(), self.fightParam:getSubHeroMoList())

	if self.isSimple then
		if not self.constEffectiveness[3] then
			local talentEffectiveness = self.battleCo.talentEffectiveness

			return self:calculatePercent(talentAverage, talentEffectiveness)
		end
	end
end

function FightFailView:calculatePercent(a, b)
	if b <= a then
		return 1
	else
		return a / b
	end
end

function FightFailView:getShowConditionsCoList()
	local conditionList = {}
	local additionRule = self.battleCo.additionRule

	if not string.nilorempty(additionRule) then
		for _, rule in ipairs(GameUtil.splitString2(additionRule, true, "|", "#")) do
			table.insert(conditionList, rule)
		end
	end

	return conditionList
end

function FightFailView:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self._gotips.transform)
end

function FightFailView:_exitFight()
	self:closeThis()
	FightController.onResultViewClose()
end

function FightFailView:onClose()
	return
end

function FightFailView:onCloseFinish()
	FightStatModel.instance:clear()
end

function FightFailView:onDestroy()
	if self._costitemIcon then
		self._costitemIcon:UnLoadImage()
	end
end

return FightFailView
