-- chunkname: @modules/logic/fight/view/FightSpecialTipView.lua

module("modules.logic.fight.view.FightSpecialTipView", package.seeall)

local FightSpecialTipView = class("FightSpecialTipView", BaseView)

function FightSpecialTipView:onInitView()
	self.goSimageBg = gohelper.findChild(self.viewGO, "content/#simage_bg")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "content/#simage_bg")
	self._goBossRushLayer4 = gohelper.findChild(self.viewGO, "content/#simage_bg/#go_BossRushLayer4")
	self._gospecialTip = gohelper.findChild(self.viewGO, "content/#go_specialTip")
	self._txtdesc = gohelper.findChildText(self.viewGO, "content/#go_specialTip/#txt_desc")
	self._golayout = gohelper.findChild(self.viewGO, "content/layout")
	self._goadditionTip = gohelper.findChild(self.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent/#go_Content")
	self._goruleitem = gohelper.findChild(self.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent/#go_Content/#go_ruleitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goadditionTip2 = gohelper.findChild(self.viewGO, "content/layout/#go_additionTip")
	self.additionTipLayout = self._goadditionTip2:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self.additionTipLayoutElement = self._goadditionTip2:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self.goViewPort = gohelper.findChild(self.viewGO, "content/layout/#go_additionTip/Viewport")
	self.viewPortLayout = self.goViewPort:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self.viewPortTrans = self.goViewPort:GetComponent(gohelper.Type_RectTransform)
	self.goLayoutContent = gohelper.findChild(self.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent")
	self.layoutContentTrans = self.goLayoutContent:GetComponent(gohelper.Type_RectTransform)
	self.layoutContentSizeFilter = self.goLayoutContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	self._go_weekwalkheart = gohelper.findChild(self.viewGO, "content/#go_weekwalkheart")

	gohelper.setActive(self._go_weekwalkheart, false)

	self._weekwalkTagText = gohelper.findChildText(self.viewGO, "content/#go_weekwalkheart/#go_ruleitem/scroll_tag/Viewport/Content/tag")
	self._weekwalkTagIcon = gohelper.findChildImage(self.viewGO, "content/#go_weekwalkheart/#go_ruleitem/scroll_tag/Viewport/Content/tag/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightSpecialTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayVideo, self._onPlayVideo, self)
end

function FightSpecialTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnPlayVideo, self._onPlayVideo, self)
end

function FightSpecialTipView:_editableInitView()
	gohelper.setActive(self._goruleitem, false)

	self._additionTips = self:getUserDataTb_()
	self._ruleItems = self:getUserDataTb_()
end

function FightSpecialTipView:_btncloseOnClick()
	self._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._closeView, self, 0.133)
end

function FightSpecialTipView:_onOpenView(viewName)
	if viewName == ViewName.GuideView or viewName == ViewName.StoryView then
		self:closeThis()
	end
end

function FightSpecialTipView:_onPlayVideo(videoName)
	self:closeThis()
end

function FightSpecialTipView:_closeView()
	self:closeThis()
end

function FightSpecialTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)
	self._simagebg:LoadImage(ResUrl.getFightSpecialTipIcon("img_tishi_bg.png"))

	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)
	local show_type

	if episode_config and not string.nilorempty(episode_config.battleDesc) then
		show_type = FightEnum.FightSpecialTipsType.Special
		self._txtdesc.text = episode_config.battleDesc
	end

	local episodeType = episode_config and episode_config.type
	local battleConfig = lua_battle.configDict[fightParam.battleId]

	if episodeType == DungeonEnum.EpisodeType.Rouge then
		local curNode = RougeMapModel.instance:getCurNode()
		local eventMo = curNode and curNode.eventMo
		local surpriseAttackList = eventMo and eventMo:getSurpriseAttackList()
		local additionRule = battleConfig.additionRule
		local data_list

		if not string.nilorempty(battleConfig.additionRule) then
			data_list = GameUtil.splitString2(additionRule, true, "|", "#")
		end

		if surpriseAttackList then
			data_list = data_list or {}

			for _, ruleId in ipairs(surpriseAttackList) do
				local co = lua_rouge_surprise_attack.configDict[ruleId]
				local rule = co.additionRule

				if not string.nilorempty(rule) then
					table.insert(data_list, string.splitToNumber(rule, "#"))
				end
			end
		end

		if data_list and #data_list > 0 then
			if #data_list > 2 and #data_list % 2 == 1 then
				table.insert(data_list, {})
			end

			gohelper.CreateObjList(self, self._onRuleItemShow, data_list, self._goadditionTip, self._goruleitem)
		end

		show_type = FightEnum.FightSpecialTipsType.Addition

		gohelper.setActive(self._gospecialTip, FightEnum.FightSpecialTipsType.Addition == FightEnum.FightSpecialTipsType.Special)
		gohelper.setActive(self._golayout, show_type == FightEnum.FightSpecialTipsType.Addition)

		return
	end

	local data_list

	if battleConfig and not string.nilorempty(battleConfig.additionRule) then
		show_type = FightEnum.FightSpecialTipsType.Addition

		local additionRule = battleConfig.additionRule

		data_list = GameUtil.splitString2(additionRule, true, "|", "#")

		local episodeType = episode_config and episode_config.type

		if Activity104Model.instance:isSeasonEpisodeType(episodeType) then
			data_list = SeasonConfig.instance:filterRule(data_list)
		elseif Season123Controller.isSeason123EpisodeType(episodeType) then
			local context = Season123Model.instance:getBattleContext()

			if context then
				data_list = Season123HeroGroupModel.filterRule(context.actId, data_list)

				if context.stage then
					data_list = Season123Config.instance:filterRule(data_list, context.stage)
				end
			end
		end
	end

	local data183 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if data183 then
		local jsonData = data183

		if jsonData.currRules then
			data_list = data_list or {}

			for i, v in ipairs(jsonData.currRules) do
				local arr = GameUtil.splitString2(v, true, "|", "#")

				tabletool.addValues(data_list, arr)
			end
		end

		if jsonData.transferRules then
			data_list = data_list or {}

			for i, v in ipairs(jsonData.transferRules) do
				local arr = GameUtil.splitString2(v, true, "|", "#")

				tabletool.addValues(data_list, arr)
			end
		end
	end

	local dataWeekwalkVer2 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2]

	if dataWeekwalkVer2 then
		local jsonData = cjson.decode(dataWeekwalkVer2)
		local ruleMap = jsonData.ruleMap

		if ruleMap then
			data_list = data_list or {}

			if ruleMap.chooseSkill then
				gohelper.setActive(self.goSimageBg, #ruleMap.chooseSkill > 0)

				for i, v in ipairs(ruleMap.chooseSkill) do
					local arr = GameUtil.splitString2(v, true, "|", "#")

					tabletool.addValues(data_list, arr)
				end
			else
				gohelper.setActive(self.goSimageBg, false)
			end

			if ruleMap.defaultRule then
				gohelper.setActive(self._go_weekwalkheart, true)

				local data = GameUtil.splitString2(ruleMap.defaultRule[1], true, "|", "#")[1]
				local tagColor = {
					"#5283ca",
					"#de4d4d",
					"#dd9446",
					"#ff0000"
				}
				local rule_config = lua_rule.configDict[data[2]]
				local targetId = data[1]
				local srcDesc = rule_config.desc
				local descContent = SkillHelper.buildDesc(srcDesc, nil, "#5283ca")
				local side = luaLang("dungeon_add_rule_target_" .. targetId)
				local color = tagColor[targetId]

				self._weekwalkTagText.text = string.format("<color=%s>[%s]</color>%s", color, side, descContent)

				UISpriteSetMgr.instance:setDungeonLevelRuleSprite(self._weekwalkTagIcon, rule_config.icon, true)
			end
		end
	end

	local data229 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act229]

	if data229 then
		local selectSkillIds = data229.selectSkillIds

		if selectSkillIds and #selectSkillIds > 0 then
			gohelper.setActive(self._go_weekwalkheart, true)

			for i, v in ipairs(selectSkillIds) do
				local config = lua_activity229_skill.configDict[v]

				if config then
					self._weekwalkTagText.alignment = TMPro.TextAlignmentOptions.Center
					self._weekwalkTagText.text = SkillHelper.buildDesc(config.desc, nil, "#5283ca")

					SkillHelper.addHyperLinkClick(self._weekwalkTagText)
					UISpriteSetMgr.instance:setAbyssSprite(self._weekwalkTagIcon, "jdsh_" .. config.icon, true)
				end
			end
		end
	end

	if episodeType == DungeonEnum.EpisodeType.Survival then
		data_list = SurvivalShelterModel.instance:addExRule(data_list)
	end

	if episode_config.chapterId == AtomicDungeonEnum.TalentChapterId or episode_config.chapterId == AtomicDungeonEnum.TalentChapterId2 then
		data_list = data_list or {}

		local alarmRuleList = AtomicDungeonModel.instance:getAlarmRuleList()

		if alarmRuleList and #alarmRuleList > 0 then
			tabletool.addValues(data_list, alarmRuleList)
		end
	end

	if data_list and #data_list > 0 then
		show_type = FightEnum.FightSpecialTipsType.Addition

		if episodeType == DungeonEnum.EpisodeType.Meilanni then
			data_list = HeroGroupFightViewRule.meilanniExcludeRules(data_list)
		end

		if #data_list > 2 and #data_list % 2 == 1 then
			table.insert(data_list, {})
		end

		gohelper.CreateObjList(self, self._onRuleItemShow, data_list, self._goadditionTip, self._goruleitem)
	end

	gohelper.setActive(self._gospecialTip, show_type == FightEnum.FightSpecialTipsType.Special)
	gohelper.setActive(self._golayout, show_type == FightEnum.FightSpecialTipsType.Addition)

	local isInBossRushSpecial = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(self._goBossRushLayer4, isInBossRushSpecial)
	self:setTipLayout(data_list)
end

function FightSpecialTipView:setTipLayout(data_list)
	local maxTipHeight = 720

	if data_list and #data_list > 6 then
		self.additionTipLayout.enabled = false
		self.additionTipLayoutElement.enabled = true
		self.viewPortLayout.enabled = false
		self.layoutContentSizeFilter.enabled = true

		recthelper.setHeight(self.viewPortTrans, maxTipHeight)

		local anchorVector = Vector2(0, 1)

		self.viewPortTrans.pivot = anchorVector
		self.viewPortTrans.anchorMin = anchorVector
		self.viewPortTrans.anchorMax = anchorVector
		self.layoutContentTrans.pivot = anchorVector
		self.layoutContentTrans.anchorMin = anchorVector
		self.layoutContentTrans.anchorMax = anchorVector

		recthelper.setAnchorY(self.viewPortTrans, 0)
		recthelper.setAnchorY(self.layoutContentTrans, 0)
	end
end

function FightSpecialTipView:_onRuleItemShow(obj, data, index)
	local tagColor = {
		"#5283ca",
		"#de4d4d",
		"#dd9446",
		"#ff0000"
	}

	gohelper.setActive(obj, true)

	local transform = obj.transform
	local scrolltag = transform:Find("scroll_tag")
	local tag = transform:Find("scroll_tag/Viewport/Content/tag"):GetComponent(gohelper.Type_TextMesh)
	local ruleIcon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local notData = string.nilorempty(data[2])

	gohelper.setActive(scrolltag.gameObject, not notData)
	gohelper.setActive(ruleIcon.gameObject, not notData)

	if notData then
		return
	end

	local rule_config = lua_rule.configDict[data[2]]
	local targetId = data[1]

	SkillHelper.addHyperLinkClick(tag)

	local srcDesc = rule_config.desc
	local descContent = SkillHelper.buildDesc(srcDesc, nil, "#5283ca")
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	tag.text = string.format("<color=%s>[%s]</color>%s", color, side, descContent)

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleIcon, rule_config.icon)
end

function FightSpecialTipView:onClose()
	TaskDispatcher.cancelTask(self._closeView, self)
end

function FightSpecialTipView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return FightSpecialTipView
