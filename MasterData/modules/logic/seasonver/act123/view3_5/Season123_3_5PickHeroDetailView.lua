-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5PickHeroDetailView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5PickHeroDetailView", package.seeall)

local Season123_3_5PickHeroDetailView = class("Season123_3_5PickHeroDetailView", BaseView)

function Season123_3_5PickHeroDetailView:onInitView()
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._gospecialitem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	self._golevel = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._txtlevelmax = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	self._btnattribute = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	self._goattribute = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._goskill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._godmgitem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_ok")
	self._txtrecommendAttrDesc = gohelper.findChildText(self.viewGO, "#go_recommendAttr/bg/#txt_desc")
	self._goattrlist = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")
	self._golevelWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	self._txtlevelWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	self._txtlevelmaxWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	self._btncharacterWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	self._goheroLvTxtWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	self._txttalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	self._txttalentType = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5PickHeroDetailView:addEvents()
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btncharacter:AddClickListener(self._btncharacterOnClick, self)
	self._btncharacterWithTalent:AddClickListener(self._btncharacterOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btnclosefilterview:AddClickListener(self._btncloseFilterViewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function Season123_3_5PickHeroDetailView:removeEvents()
	self._btnpassiveskill:RemoveClickListener()
	self._btncharacter:RemoveClickListener()
	self._btncharacterWithTalent:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnok:RemoveClickListener()
end

function Season123_3_5PickHeroDetailView:_editableInitView()
	self._careerGOs = {}
	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._classifyBtns = self:getUserDataTb_()
	self._selectDmgs = {}
	self._dmgSelects = self:getUserDataTb_()
	self._dmgUnselects = self:getUserDataTb_()
	self._dmgBtnClicks = self:getUserDataTb_()
	self._selectAttrs = {}
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()
	self._selectLocations = {}
	self._locationSelects = self:getUserDataTb_()
	self._locationUnselects = self:getUserDataTb_()
	self._locationBtnClicks = self:getUserDataTb_()
	self._curDmgs = {}
	self._curAttrs = {}
	self._curLocations = {}

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
		self._dmgUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/unselected")
		self._dmgSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/selected")
		self._dmgBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/click")

		self._dmgBtnClicks[i]:AddClickListener(self._dmgBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._locationUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._locationSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._locationBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")

		self._locationBtnClicks[i]:AddClickListener(self._locationBtnOnClick, self, i)
	end

	self._attributevalues = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.value = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.name = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/name")
		o.icon = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/icon")
		self._attributevalues[i] = o
	end

	self._passiveskillitems = {}

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. tostring(i))
		o.on = gohelper.findChild(o.go, "on")
		o.off = gohelper.findChild(o.go, "off")
		self._passiveskillitems[i] = o
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer)

	gohelper.setActive(self._gononecharacter, false)
	gohelper.setActive(self._gocharacterinfo, false)
end

function Season123_3_5PickHeroDetailView:onDestroyView()
	if self._skillContainer then
		self._skillContainer:onDestroy()

		self._skillContainer = nil
	end

	for i = 1, 2 do
		self._dmgBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._attrBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._locationBtnClicks[i]:RemoveClickListener()
	end
end

function Season123_3_5PickHeroDetailView:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.PickViewRefresh, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self.refreshHeroListByFilter, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self.refreshHeroListByFilter, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self.refreshHeroListByFilter, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self.refreshHeroListByFilter, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self.refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self:initStatus()
	self:refreshUI()
	self:_showRecommendCareer()
end

function Season123_3_5PickHeroDetailView:onClose()
	return
end

function Season123_3_5PickHeroDetailView:initStatus()
	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end
end

function Season123_3_5PickHeroDetailView:refreshUI()
	self._heroMO = Season123PickHeroModel.instance:getSelectedHeroMO()

	if self._heroMO then
		gohelper.setActive(self._gononecharacter, false)
		gohelper.setActive(self._gocharacterinfo, true)
		self:_refreshSkill()
		self:_refreshMainInfo()
		self:_refreshAttribute()
		self:_refreshPassiveSkill()
	else
		gohelper.setActive(self._gononecharacter, true)
		gohelper.setActive(self._gocharacterinfo, false)
	end

	self:_refreshBtnIcon()
end

function Season123_3_5PickHeroDetailView:_refreshMainInfo()
	if self._heroMO then
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "sx_biandui_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

		self._txtname.text = self._heroMO.config.name
		self._txtnameen.text = self._heroMO.config.nameEng

		local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
		local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
		local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

		if (not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or nil) and false then
			gohelper.setActive(self._golevel, false)
			gohelper.setActive(self._golevelWithTalent, true)
			gohelper.setActive(self._goheroLvTxtWithTalent, true)

			self._txtlevelWithTalent.text = tostring(showLevel)
			self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)
			self._txttalent.text = "Lv.<size=40>" .. tostring(self._heroMO.talent)
			self._txttalentType.text = luaLang("talent_character_talentcn" .. self._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(self._golevel, true)
			gohelper.setActive(self._golevelWithTalent, false)

			self._txtlevel.text = tostring(showLevel)
			self._txtlevelmax.text = string.format("/%d", showMaxLevel)
		end

		local tags = {}

		if not string.nilorempty(self._heroMO.config.battleTag) then
			tags = string.split(self._heroMO.config.battleTag, "#")
		end

		for i = 1, #tags do
			local careerTable = self._careerGOs[i]

			if not careerTable then
				careerTable = self:getUserDataTb_()
				careerTable.go = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)
				careerTable.textfour = gohelper.findChildText(careerTable.go, "#go_fourword/name")
				careerTable.textthree = gohelper.findChildText(careerTable.go, "#go_threeword/name")
				careerTable.texttwo = gohelper.findChildText(careerTable.go, "#go_twoword/name")
				careerTable.containerfour = gohelper.findChild(careerTable.go, "#go_fourword")
				careerTable.containerthree = gohelper.findChild(careerTable.go, "#go_threeword")
				careerTable.containertwo = gohelper.findChild(careerTable.go, "#go_twoword")

				table.insert(self._careerGOs, careerTable)
			end

			local desc = HeroConfig.instance:getBattleTagConfigCO(tags[i]).tagName
			local wordCount = GameUtil.utf8len(desc)

			gohelper.setActive(careerTable.containertwo, wordCount <= 2)
			gohelper.setActive(careerTable.containerthree, wordCount == 3)
			gohelper.setActive(careerTable.containerfour, wordCount >= 4)

			if wordCount <= 2 then
				careerTable.texttwo.text = desc
			elseif wordCount == 3 then
				careerTable.textthree.text = desc
			else
				careerTable.textfour.text = desc
			end

			gohelper.setActive(careerTable.go, true)
		end

		for i = #tags + 1, #self._careerGOs do
			gohelper.setActive(self._careerGOs[i].go, false)
		end
	end
end

function Season123_3_5PickHeroDetailView:_refreshAttribute()
	if self._heroMO then
		local attrDict = self._heroMO:getTotalBaseAttrDict(self._equips)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			self._attributevalues[index].name.text = co.name
			self._attributevalues[index].value.text = attrDict[attrId]

			CharacterController.instance:SetAttriIcon(self._attributevalues[index].icon, attrId)
		end
	end
end

function Season123_3_5PickHeroDetailView:_refreshPassiveSkill()
	if not self._heroMO then
		return
	end

	local pskills = SkillConfig.instance:getpassiveskillsCO(self._heroMO.heroId)
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local passiveSkillConfig = lua_skill.configDict[skillId]

	if not passiveSkillConfig then
		logError("找不到角色被动技能, skillId: " .. tostring(skillId))
	else
		self._txtpassivename.text = passiveSkillConfig.name
	end

	for i = 1, #pskills do
		local unlock = CharacterModel.instance:isPassiveUnlockByHeroMo(self._heroMO, i)

		gohelper.setActive(self._passiveskillitems[i].on, unlock)
		gohelper.setActive(self._passiveskillitems[i].off, not unlock)
		gohelper.setActive(self._passiveskillitems[i].go, true)
	end

	for i = #pskills + 1, #self._passiveskillitems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end
end

function Season123_3_5PickHeroDetailView:_refreshSkill()
	self._skillContainer:onUpdateMO(self._heroMO and self._heroMO.heroId, false, self._heroMO)
end

function Season123_3_5PickHeroDetailView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local hasFilter = false

	for _, v in pairs(self._selectDmgs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			hasFilter = true
		end
	end

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
end

function Season123_3_5PickHeroDetailView:_btnattributeOnClick()
	if self._heroMO then
		local info = {}

		info.tag = "attribute"
		info.heroid = self._heroMO.heroId
		info.equips = self._equips
		info.showExtraAttr = true
		info.fromHeroGroupEditView = true

		CharacterController.instance:openCharacterTipView(info)
	end
end

function Season123_3_5PickHeroDetailView:_btncharacterOnClick()
	if self._heroMO then
		if not Season123PickHeroModel.instance.heroMOList then
			if self._heroMO:isOtherPlayerHero() then
				local equipMO = Season123HeroGroupEditModel.instance:getEquipMOByHeroUid(self._heroMO.uid)

				if equipMO then
					self._heroMO:setOtherPlayerEquipMo(equipMO)
				end
			end

			CharacterController.instance:openCharacterView(self._heroMO, Season123PickHeroModel.instance.heroMOList)
		end
	end
end

function Season123_3_5PickHeroDetailView:_btnpassiveskillOnClick()
	if not self._heroMO then
		return
	end

	local info = {}

	info.tag = "passiveskill"
	info.heroid = self._heroMO.heroId
	info.tipPos = Vector2.New(851, -59)
	info.buffTipsX = 1603
	info.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}

	CharacterController.instance:openCharacterTipView(info)
end

function Season123_3_5PickHeroDetailView:_refreshFilterView()
	for i = 1, 2 do
		gohelper.setActive(self._dmgUnselects[i], not self._selectDmgs[i])
		gohelper.setActive(self._dmgSelects[i], self._selectDmgs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not self._selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], self._selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._locationUnselects[i], not self._selectLocations[i])
		gohelper.setActive(self._locationSelects[i], self._selectLocations[i])
	end
end

function Season123_3_5PickHeroDetailView:refreshHeroListByFilter()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	Season123PickHeroController.instance:updateFilter()
end

function Season123_3_5PickHeroDetailView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function Season123_3_5PickHeroDetailView:_showCharacterRankUpView(func)
	func()
end

function Season123_3_5PickHeroDetailView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshFilterView()
end

function Season123_3_5PickHeroDetailView:_dmgBtnOnClick(i)
	if not self._selectDmgs[i] then
		self._selectDmgs[3 - i] = self._selectDmgs[i]
	end

	self._selectDmgs[i] = not self._selectDmgs[i]

	self:_refreshFilterView()
end

function Season123_3_5PickHeroDetailView:_locationBtnOnClick(i)
	self._selectLocations[i] = not self._selectLocations[i]

	self:_refreshFilterView()
end

function Season123_3_5PickHeroDetailView:_showRecommendCareer()
	local recommended = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)

	if recommended then
		gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)
	end

	self._txtrecommendAttrDesc.text = recommended and luaLang("herogroupeditview_recommend") or luaLang("herogroupeditview_notrecommend")

	gohelper.setActive(self._goattrlist, recommended)
end

function Season123_3_5PickHeroDetailView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function Season123_3_5PickHeroDetailView:_btncloseFilterViewOnClick()
	self._selectDmgs = LuaUtil.deepCopy(self._curDmgs)
	self._selectAttrs = LuaUtil.deepCopy(self._curAttrs)
	self._selectLocations = LuaUtil.deepCopy(self._curLocations)

	self:_refreshBtnIcon()
	gohelper.setActive(self._gosearchfilter, false)
end

function Season123_3_5PickHeroDetailView:_btnclassifyOnClick()
	gohelper.setActive(self._gosearchfilter, true)
	self:_refreshFilterView()
end

function Season123_3_5PickHeroDetailView:_btnresetOnClick()
	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self:_refreshBtnIcon()
	self:_refreshFilterView()
end

function Season123_3_5PickHeroDetailView:_btnokOnClick()
	gohelper.setActive(self._gosearchfilter, false)
	self:refreshHeroListByFilter()

	self._curDmgs = LuaUtil.deepCopy(self._selectDmgs)
	self._curAttrs = LuaUtil.deepCopy(self._selectAttrs)
	self._curLocations = LuaUtil.deepCopy(self._selectLocations)

	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function Season123_3_5PickHeroDetailView:_btnexskillrankOnClick()
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	self:_refreshBtnIcon()
end

function Season123_3_5PickHeroDetailView:_btnlvrankOnClick()
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	self:_refreshBtnIcon()
end

function Season123_3_5PickHeroDetailView:_btnrarerankOnClick()
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	self:_refreshBtnIcon()
end

return Season123_3_5PickHeroDetailView
