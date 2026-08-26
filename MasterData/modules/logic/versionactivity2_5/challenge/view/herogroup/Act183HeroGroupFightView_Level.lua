-- chunkname: @modules/logic/versionactivity2_5/challenge/view/herogroup/Act183HeroGroupFightView_Level.lua

module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightView_Level", package.seeall)

local Act183HeroGroupFightView_Level = class("Act183HeroGroupFightView_Level", HeroGroupFightViewLevel)

function Act183HeroGroupFightView_Level:onInitView()
	Act183HeroGroupFightView_Level.super.onInitView(self)

	self._gotargetlist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	self._goadditioncontain = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain")
	self._goadditionitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/targetList/#go_additionitem")
	self._goadditionstar1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star1")
	self._goadditionstar2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star2")
	self._goadditionstar3 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star3")
	self._gochallenge = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege")
	self._gobaserulecontainer = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt")
	self._gobaserules = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist")
	self._gobaseruleItem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist/#go_item")
	self._goescapecontainer = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt")
	self._goescaperules = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist")
	self._goescaperuleitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist/#go_item")
	self._btnchallengetip = gohelper.findChildButton(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	self._gochallengetips = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips")
	self._btnclosechallengetips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_challengetips/#btn_closechallengetips")
	self._gochallengetipscontent = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content")
	self._gochallengetiptitle = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/title")
	self._gochallengetipitem = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem")
	self._gochallengedescitem = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/#txt_desc")
end

function Act183HeroGroupFightView_Level:_editableInitView()
	Act183HeroGroupFightView_Level.super._editableInitView(self)

	self._activityId = Act183Model.instance:getActivityId()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._episodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)
	self._episodeCo = Act183Config.instance:getEpisodeCo(self._episodeId)
	self._episodeMo = Act183Model.instance:getEpisodeMo(self._episodeCo.groupId, self._episodeId)
	self._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(self._episodeCo.groupId)
	self._groupType = self._groupEpisodeMo:getGroupType()
	self._hardMode = self._groupType == Act183Enum.GroupType.HardMain
	self._conditionItemTab = self:getUserDataTb_()
end

function Act183HeroGroupFightView_Level:addEvents()
	Act183HeroGroupFightView_Level.super.addEvents(self)
	self._btnchallengetip:AddClickListener(self._btnchallengetipOnClick, self)
	self._btnclosechallengetips:AddClickListener(self._btnclosechallengetipsOnClick, self)
end

function Act183HeroGroupFightView_Level:removeEvents()
	Act183HeroGroupFightView_Level.super.removeEvents(self)
	self._btnchallengetip:RemoveClickListener()
	self._btnclosechallengetips:RemoveClickListener()
end

function Act183HeroGroupFightView_Level:_btnchallengetipOnClick()
	gohelper.setActive(self._gochallengetips, true)
	self:refreshChallengeTips()
end

function Act183HeroGroupFightView_Level:_btnclosechallengetipsOnClick()
	gohelper.setActive(self._gochallengetips, false)
end

function Act183HeroGroupFightView_Level:_refreshUI()
	Act183HeroGroupFightView_Level.super._refreshUI(self)
	self:refreshChallengeRules()
	self:refreshFightConditions()
	gohelper.setActive(self._gohardEffect, self._hardMode)
end

function Act183HeroGroupFightView_Level:_refreshTarget()
	self:_refreshAdvanceStaList()
end

function Act183HeroGroupFightView_Level:_refreshAdvanceStaList()
	local conditionDescList = Act183Helper.getEpisodeConditionDescList(self._episodeId)

	if conditionDescList then
		self._conditionDescNum = #conditionDescList or 0
	end

	self._useOneStarFlag = self._conditionDescNum > 3

	local starResultNum = self._useOneStarFlag and 1 or self._conditionDescNum

	self:_initStars(starResultNum)
	gohelper.CreateObjList(self, self._refreshTargetItem, conditionDescList, self._gotargetlist, self._gonormalcondition)
end

function Act183HeroGroupFightView_Level:_refreshTargetItem(obj, conditionDesc, index)
	local txtcondition = gohelper.findChildText(obj, "#txt_normalcondition")
	local gofinishstar = gohelper.findChild(obj, "#go_normalfinish")
	local gounfinishstar = gohelper.findChild(obj, "#go_normalunfinish")

	txtcondition.text = conditionDesc

	local pass = index <= self._episodeInfo.star

	gohelper.setActive(gofinishstar, pass)
	gohelper.setActive(gounfinishstar, not pass)
	ZProj.UGUIHelper.SetColorAlpha(txtcondition, pass and 1 or 0.63)

	if self._useOneStarFlag then
		self:_setStar(self._starList[1], self._episodeInfo.star >= self._conditionDescNum)
	else
		self:_setStar(self._starList[index], pass)
	end
end

function Act183HeroGroupFightView_Level:_initStars(starNum)
	if self._starList then
		return
	end

	for i = 1, math.huge do
		local gostar = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star" .. i)

		if gohelper.isNil(gostar) then
			break
		end

		local isFind = i == starNum

		gohelper.setActive(gostar, isFind)

		if isFind then
			self._starList = self:getUserDataTb_()

			for j = 1, starNum do
				local star = gohelper.findChildImage(gostar, "star" .. j)

				table.insert(self._starList, star)
			end
		end
	end
end

function Act183HeroGroupFightView_Level:refreshFightConditions()
	local conditionIds = self._episodeMo:getConditionIds()

	if conditionIds then
		if not #conditionIds then
			local conditionCount = 0
			local hasConditions = conditionCount > 0

			gohelper.setActive(self._goadditioncontain, hasConditions)

			if not hasConditions then
				return
			end

			local useMap = {}
			local passConditionIndexMap = {}

			if conditionIds then
				for index, conditionId in ipairs(conditionIds) do
					local conditionItem = self:_getOrCreateConditionItem(index)
					local isConditionPass = self._episodeMo:isConditionPass(conditionId)
					local conditionCo = Act183Config.instance:getConditionCo(conditionId)

					if conditionCo then
						conditionItem.txtcontent.text = conditionCo.decs1 or ""
					end

					Act183Helper.setEpisodeConditionStar(conditionItem.imagestar, isConditionPass, nil, true)
					gohelper.setActive(conditionItem.viewGO, true)

					passConditionIndexMap[index] = isConditionPass
					useMap[conditionItem] = true
				end
			end

			for _, conditionItem in pairs(self._conditionItemTab) do
				if not useMap[conditionItem] then
					gohelper.setActive(conditionItem.viewGO, false)
				end
			end

			self:refreshFightConditionTitleStar(conditionCount, passConditionIndexMap)
		end
	end
end

function Act183HeroGroupFightView_Level:refreshFightConditionTitleStar(conditionCount, passConditionIndexMap)
	local gotitlestar = self["_goadditionstar" .. conditionCount]

	if not gotitlestar then
		return
	end

	for i = 1, conditionCount do
		local imagestar = gohelper.findChildImage(gotitlestar, "star" .. i)

		if not gohelper.isNil(imagestar) then
			local isPass = passConditionIndexMap[i]

			Act183Helper.setEpisodeConditionStar(imagestar, isPass)
		end
	end

	gohelper.setActive(gotitlestar, true)
end

function Act183HeroGroupFightView_Level:_getOrCreateConditionItem(index)
	local conditionItem = self._conditionItemTab[index]

	if not conditionItem then
		conditionItem = self:getUserDataTb_()
		conditionItem.viewGO = gohelper.cloneInPlace(self._goadditionitem, "fightcondition_" .. index)
		conditionItem.txtcontent = gohelper.findChildText(conditionItem.viewGO, "#txt_normalcondition")
		conditionItem.imagestar = gohelper.findChildImage(conditionItem.viewGO, "#image_star")
		self._conditionItemTab[index] = conditionItem
	end

	return conditionItem
end

function Act183HeroGroupFightView_Level:refreshChallengeRules()
	self._baseRuleDescList = Act183Config.instance:getEpisodeAllRuleDesc(self._episodeId)

	if self._baseRuleDescList then
		if not #self._baseRuleDescList then
			local baseRuleCount = 0

			self._hasBaseRule = baseRuleCount > 0

			gohelper.setActive(self._gobaserulecontainer, self._hasBaseRule)

			if self._hasBaseRule then
				gohelper.CreateObjList(self, self._refreshBaseRuleItem, self._baseRuleDescList, self._gobaserules, self._gobaseruleItem)
			end

			self._escapeRules = self._groupEpisodeMo:getEscapeRules(self._episodeId)

			if self._episodeMo then
				local episodeType = self._episodeMo:getEpisodeType()

				if self._episodeMo == Act183Enum.EpisodeType.Boss then
					local unfinishEpisodeList = {}
					local lockedEpisodeList = self._groupEpisodeMo:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Locked)
					local unlockEpisodeList = self._groupEpisodeMo:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Unlocked)

					tabletool.addValues(unfinishEpisodeList, lockedEpisodeList)
					tabletool.addValues(unfinishEpisodeList, unlockEpisodeList)

					for _, episodeMo in ipairs(unfinishEpisodeList) do
						local episodeId = episodeMo:getEpisodeId()
						local ruleDescList = Act183Config.instance:getEpisodeAllRuleDesc(episodeId)

						for i = 1, #ruleDescList do
							table.insert(self._escapeRules, {
								episodeId = episodeId,
								ruleIndex = i,
								ruleDesc = ruleDescList[i]
							})
						end
					end
				end

				if self._escapeRules then
					local hasEscapeRules = #self._escapeRules > 0

					self._canGetRule = hasEscapeRules

					gohelper.setActive(self._goescapecontainer, self._canGetRule)

					if self._canGetRule then
						gohelper.CreateObjList(self, self._refreshEscapeRuleItem, self._escapeRules, self._goescaperules, self._goescaperuleitem)
					end

					gohelper.setActive(self._gochallenge, self._hasBaseRule or self._canGetRule)
				end
			end
		end
	end
end

function Act183HeroGroupFightView_Level:_refreshBaseRuleItem(obj, desc, index)
	local imageicon = gohelper.findChildImage(obj, "icon")

	Act183Helper.setRuleIcon(self._episodeId, index, imageicon)
end

function Act183HeroGroupFightView_Level:_refreshEscapeRuleItem(obj, escapeInfo, index)
	local imageicon = gohelper.findChildImage(obj, "icon")
	local episodeId = escapeInfo.episodeId
	local ruleIndex = escapeInfo.ruleIndex

	Act183Helper.setRuleIcon(episodeId, ruleIndex, imageicon)
end

function Act183HeroGroupFightView_Level:refreshChallengeTips()
	if self._initChallengeTipsDone then
		return
	end

	self:_refreshBaseRuleTipContents()
	self:_refreshEscapeRuleTipContents()

	self._initChallengeTipsDone = true
end

function Act183HeroGroupFightView_Level:_refreshBaseRuleTipContents()
	if not self._hasBaseRule then
		return
	end

	self._gobaseruletipitem = gohelper.cloneInPlace(self._gochallengetipitem, "baseruleitem")

	self:_refreshTipTitle(self._gobaseruletipitem, "p_v2a5_challenge_herogroupview_basictxt")

	for index, baseRuleDesc in ipairs(self._baseRuleDescList) do
		local descitem = gohelper.clone(self._gochallengedescitem, self._gobaseruletipitem, "item_" .. index)
		local txtdesc = gohelper.onceAddComponent(descitem, gohelper.Type_TextMesh)
		local imageicon = gohelper.findChildImage(descitem, "image_icon")

		txtdesc.text = SkillHelper.buildDesc(baseRuleDesc)

		SkillHelper.addHyperLinkClick(txtdesc)
		Act183Helper.setRuleIcon(self._episodeId, index, imageicon)
		gohelper.setActive(descitem, true)
	end

	gohelper.setActive(self._gobaseruletipitem, true)
end

function Act183HeroGroupFightView_Level:_refreshEscapeRuleTipContents()
	if not self._canGetRule then
		return
	end

	self._goescaperuletipitem = gohelper.cloneInPlace(self._gochallengetipitem, "escaperuleitem")

	self:_refreshTipTitle(self._goescaperuletipitem, "p_v2a5_challenge_herogroupview_escapetxt")

	for index, escapeInfo in ipairs(self._escapeRules) do
		local descitem = gohelper.clone(self._gochallengedescitem, self._goescaperuletipitem, "item_" .. index)
		local txtdesc = gohelper.onceAddComponent(descitem, gohelper.Type_TextMesh)

		txtdesc.text = SkillHelper.buildDesc(escapeInfo.ruleDesc)

		SkillHelper.addHyperLinkClick(txtdesc)

		local episodeId = escapeInfo.episodeId
		local ruleIndex = escapeInfo.ruleIndex
		local imageicon = gohelper.findChildImage(descitem, "image_icon")

		Act183Helper.setRuleIcon(episodeId, ruleIndex, imageicon)
		gohelper.setActive(descitem, true)
	end

	gohelper.setActive(self._goescaperuletipitem, true)
end

function Act183HeroGroupFightView_Level:_refreshTipTitle(gotitle, langId)
	local txtname = gohelper.findChildText(gotitle, "title/txt_name")

	txtname.text = luaLang(langId)
end

return Act183HeroGroupFightView_Level
