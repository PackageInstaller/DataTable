-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroEditView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroEditView", package.seeall)

local Act191HeroEditView = class("Act191HeroEditView", BaseView)

function Act191HeroEditView:onInitView()
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	self._goattribute = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._goskill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	self._btnExSkill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/quality/exSkill/#btn_ExSkill")
	self._goFetterIcon = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/fetters/Viewport/Content/#go_FetterIcon")
	self._goDestiny = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_Destiny")
	self._goDestinyLock = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/stone/#go_DestinyLock")
	self._goDestinyUnLock = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/stone/#go_DestinyUnLock")
	self._btnDestiny = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/#btn_Destiny")
	self._goAttrUp = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_AttrUp")
	self._goAttrUpFetter = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_AttrUp/attribute/#go_AttrUpFetter")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._goRareArrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/txt/#go_RareArrow")
	self._btnquickedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._goFetterContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/layout/#go_FetterContent")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/layout/#scroll_card")
	self._scrollquickedit = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/layout/#scroll_quickedit")
	self._goDetail = gohelper.findChild(self.viewGO, "#go_Detail")
	self._btnCloseDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Detail/#btn_CloseDetail")
	self._goDetailPassiveItem = gohelper.findChild(self.viewGO, "#go_Detail/scroll_content/viewport/content/#go_DetailPassiveItem")
	self._goops = gohelper.findChild(self.viewGO, "#go_ops")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191HeroEditView:addEvents()
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnExSkill:AddClickListener(self._btnExSkillOnClick, self)
	self._btnDestiny:AddClickListener(self._btnDestinyOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnquickedit:AddClickListener(self._btnquickeditOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btnCloseDetail:AddClickListener(self._btnCloseDetailOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnclosefilterview:AddClickListener(self._btnclosefilterviewOnClick, self)
end

function Act191HeroEditView:removeEvents()
	self._btnpassiveskill:RemoveClickListener()
	self._btnExSkill:RemoveClickListener()
	self._btnDestiny:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnquickedit:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btnCloseDetail:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnclosefilterview:RemoveClickListener()
end

function Act191HeroEditView:_btnDestinyOnClick()
	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, self.config)
end

function Act191HeroEditView:_btnExSkillOnClick()
	local roleCo = Activity191Config.instance:getRoleCoByNativeId(self._heroMo.heroId, self._heroMo.star)

	if roleCo then
		ViewMgr.instance:openView(ViewName.Act191CharacterExSkillView, {
			config = roleCo
		})
	end
end

function Act191HeroEditView:_btnclosefilterviewOnClick()
	gohelper.setActive(self._gosearchfilter, false)
end

function Act191HeroEditView:_btnCloseDetailOnClick()
	gohelper.setActive(self._goDetail, false)
end

function Act191HeroEditView:_btnclassifyOnClick()
	gohelper.setActive(self._gosearchfilter, true)
end

function Act191HeroEditView:_btnpassiveskillOnClick()
	if not self.config then
		return
	end

	if self.config.type == Activity191Enum.CharacterType.Hero then
		local info = {}

		info.id = self.config.id
		info.tipPos = Vector2.New(851, -59)
		info.buffTipsX = 1603
		info.anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		}
		info.stoneId = self.stoneId

		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, info)
	else
		self:refreshPassiveDetail()
		gohelper.setActive(self._goDetail, true)
	end
end

function Act191HeroEditView:refreshPassiveDetail()
	local passiveSkillCount = #self.passiveSkillIds

	for i = 1, passiveSkillCount do
		local passiveSkillId = tonumber(self.passiveSkillIds[i])
		local skillConfig = lua_skill.configDict[passiveSkillId]

		if skillConfig then
			local detailPassiveTable = self._detailPassiveTables[i]

			if not detailPassiveTable then
				local detailPassiveGO = gohelper.cloneInPlace(self._goDetailPassiveItem, "item" .. i)

				detailPassiveTable = self:getUserDataTb_()
				detailPassiveTable.go = detailPassiveGO
				detailPassiveTable.name = gohelper.findChildText(detailPassiveGO, "title/txt_name")
				detailPassiveTable.icon = gohelper.findChildSingleImage(detailPassiveGO, "title/simage_icon")
				detailPassiveTable.desc = gohelper.findChildText(detailPassiveGO, "txt_desc")

				SkillHelper.addHyperLinkClick(detailPassiveTable.desc, self.onClickHyperLink, self)

				detailPassiveTable.line = gohelper.findChild(detailPassiveGO, "txt_desc/image_line")

				table.insert(self._detailPassiveTables, detailPassiveTable)
			end

			detailPassiveTable.name.text = skillConfig.name
			detailPassiveTable.desc.text = SkillHelper.getSkillDesc(self.config.name, skillConfig)

			gohelper.setActive(detailPassiveTable.go, true)
			gohelper.setActive(detailPassiveTable.line, i < passiveSkillCount)
		else
			logError(string.format("被动技能配置没找到, id: %d", passiveSkillId))
		end
	end

	for i = passiveSkillCount + 1, #self._detailPassiveTables do
		gohelper.setActive(self._detailPassiveTables[i].go, false)
	end
end

function Act191HeroEditView:_btnconfirmOnClick()
	if self._isShowQuickEdit then
		local heroIdMap = Act191HeroQuickEditListModel.instance:getHeroIdMap()

		self.gameInfo:saveQuickGroupInfo(heroIdMap)
	else
		local specialHero = Act191HeroEditListModel.instance.specialHero
		local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

		if self._heroMo then
			if self._heroMo.heroId ~= specialHero then
				gameInfo:replaceHeroInTeam(self._heroMo.heroId, self.curSlotIndex)
			end
		elseif specialHero then
			gameInfo:removeHeroInTeam(specialHero)
		end
	end

	self:closeThis()
end

function Act191HeroEditView:_btncancelOnClick()
	self:closeThis()
end

function Act191HeroEditView:_btnrarerankOnClick()
	self.sortRule = math.abs(self.sortRule - 3)

	self:refreshBtnRare()

	if self._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:filterData(self.filterTag, self.sortRule)
	else
		Act191HeroEditListModel.instance:filterData(self.filterTag, self.sortRule)
	end
end

function Act191HeroEditView:_btnquickeditOnClick()
	self._isShowQuickEdit = not self._isShowQuickEdit

	self:_refreshEditMode()

	if self._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:filterData(self.filterTag, self.sortRule)
		self:_onHeroItemClick(self._quickHeroMo)
	else
		Act191HeroEditListModel.instance:filterData(self.filterTag, self.sortRule)
		self:_onHeroItemClick(self._normalHeroMo)
	end
end

function Act191HeroEditView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
	self._detailPassiveTables = {}
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	self._classifyBtns = self:getUserDataTb_()

	for i = 1, 2 do
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
	end

	self._goBtnEditQuickMode = gohelper.findChild(self._btnquickedit.gameObject, "btn2")
	self._goBtnEditNormalMode = gohelper.findChild(self._btnquickedit.gameObject, "btn1")
	self._attributevalues = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.txtAttr = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.txtUp = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_up")
		self._attributevalues[i] = o
	end

	for i = 1, 3 do
		self["goPassiveSkill" .. i] = gohelper.findChild(self._gopassiveskills, "passiveskill" .. tostring(i))
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, Act191SkillContainer)
	self.exGoList = self:getUserDataTb_()

	for i = 1, 5 do
		local path = "characterinfo/#go_characterinfo/quality/exSkill/go_ex" .. i

		self.exGoList[i] = gohelper.findChild(self.viewGO, path)
	end

	self.fetterIconItemList = {}
	self.fetterItemList = {}
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gononecharacter, true)
	gohelper.setActive(self._gocharacterinfo, false)
	self:_initFilterView()
end

function Act191HeroEditView:onOpen()
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.sortRule = Activity191Enum.SortRule.Down

	Act191HeroEditListModel.instance:initData(self.viewParam)
	Act191HeroQuickEditListModel.instance:initData()

	self.curSlotIndex = self.viewParam.index
	self._isShowQuickEdit = false
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1

	self:_refreshEditMode()
	self:_refreshCharacterInfo()
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.ClickHeroEditItem, self._onHeroItemClick, self)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	self:refreshFetter()

	self.filterTag = nil

	self:refreshBtnRare()
	self:_refreshBtnClassify()
end

function Act191HeroEditView:onClose()
	self._heroMo = nil
	self.config = nil
end

function Act191HeroEditView:onDestroyView()
	Act191HeroEditListModel.instance:clear()
	Act191HeroQuickEditListModel.instance:clear()
	self._imgBg:UnLoadImage()

	self._imgBg = nil
end

function Act191HeroEditView:refreshBtnRare()
	local value = self.sortRule == Activity191Enum.SortRule.Down and 0 or 180

	transformhelper.setLocalRotation(self._goRareArrow.transform, 1, 1, value)
end

function Act191HeroEditView:refreshDestiny()
	if string.nilorempty(self.config.facetsId) then
		gohelper.setActive(self._goDestiny, false)
	else
		gohelper.setActive(self._goDestiny, true)
	end
end

function Act191HeroEditView:_onHeroItemClick(heroMo)
	if self._isShowQuickEdit then
		self._quickHeroMo = heroMo
	else
		self._normalHeroMo = heroMo
	end

	self:refreshFetter()

	if self._heroMo and heroMo and self._heroMo.heroId == heroMo.heroId then
		return
	end

	self._heroMo = heroMo

	if heroMo then
		self.config = heroMo.config or nil
	end

	self:_refreshCharacterInfo()
end

function Act191HeroEditView:_refreshCharacterInfo()
	if self.config then
		if not self.upFetterItemList then
			self.upFetterItemList = {}

			gohelper.setActive(self._goAttrUpFetter, false)
		end

		self.attrUpDic, self.attrUpFetterList = self.gameInfo:getAttrUpDicByRoleId(self.config.roleId)

		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "sx_biandui_" .. tostring(self.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self.config.dmgType))

		self._txtname.text = self.config.name

		gohelper.setActive(self._goAttrUp, next(self.attrUpDic))

		for k, tag in ipairs(self.attrUpFetterList) do
			local item = self.upFetterItemList[k]

			if not item then
				item = self:getUserDataTb_()
				item.go = gohelper.cloneInPlace(self._goAttrUpFetter)
				item.icon = gohelper.findChildImage(item.go, "image_icon")
				self.upFetterItemList[k] = item
			end

			local relationCo = Activity191Config.instance:getRelationCo(tag)

			Activity191Helper.setFetterIcon(item.icon, relationCo.icon)
			gohelper.setActive(item.go, true)
		end

		for i = #self.attrUpFetterList + 1, #self.upFetterItemList do
			local item = self.upFetterItemList[i]

			gohelper.setActive(item.go, false)
		end

		for k, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local upText = self._attributevalues[k].txtUp
			local value = self.attrUpDic[attrId]

			if value then
				upText.text = value / 10 .. "%"
			end

			gohelper.setActive(upText, value)
		end

		local attrCo = lua_activity191_template.configDict[self.config.id]

		if attrCo then
			self._attributevalues[1].txtAttr.text = attrCo.attack
			self._attributevalues[2].txtAttr.text = attrCo.life
			self._attributevalues[3].txtAttr.text = attrCo.defense
			self._attributevalues[4].txtAttr.text = attrCo.mdefense
			self._attributevalues[5].txtAttr.text = attrCo.technic
		end

		self.passiveSkillIds = Activity191Config.instance:getHeroPassiveSkillIdList(self.config.id)

		local skillCo = lua_skill.configDict[self.passiveSkillIds[1]]

		if skillCo then
			self._txtpassivename.text = skillCo.name or ""
		end

		for i = 1, 3 do
			local go = self["goPassiveSkill" .. i]

			gohelper.setActive(go, i <= ((self.config.type == Activity191Enum.CharacterType.Hero or nil) and #SkillConfig.instance:getheroranksCO(self.config.roleId) - 1))
		end

		for k, v in ipairs(self.exGoList) do
			gohelper.setActive(v, k <= self.config.exLevel)
		end

		self:refreshFetterIcon()
		self._skillContainer:setData(self.config)

		self.stoneId = self.gameInfo:getStoneId(self.config)

		if self.stoneId then
			self.passiveSkillIds = Activity191Helper.replaceSkill(self.stoneId, self.passiveSkillIds)
		end

		self:refreshDestiny()
	end

	gohelper.setActive(self._gononecharacter, not self.config)
	gohelper.setActive(self._gocharacterinfo, self.config)
end

function Act191HeroEditView:refreshFetterIcon()
	for _, item in ipairs(self.fetterIconItemList) do
		gohelper.setActive(item.go, false)
	end

	local tagArr = string.split(self.config.tag, "#")

	for k, tag in ipairs(tagArr) do
		local item = self.fetterIconItemList[k]

		if not item then
			local go = gohelper.cloneInPlace(self._goFetterIcon)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterIconItem)
			self.fetterIconItemList[k] = item
		end

		item:setData(tag)
		gohelper.setActive(item.go, true)
	end
end

function Act191HeroEditView:_initFilterView()
	self.filterItemMap = {}

	local goAttr = gohelper.findChild(self._gosearchfilter, "container/ScrollView/Viewport/Content/attrContainer/go_attr")
	local fetterSelectCoMap = lua_activity191_relation_select.configDict[self.actId]

	table.sort(fetterSelectCoMap, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	for _, co in pairs(fetterSelectCoMap) do
		local config = Activity191Config.instance:getRelationCo(co.tag)

		if config then
			local filterItem = self:getUserDataTb_()
			local go = gohelper.cloneInPlace(goAttr, co.tag)

			filterItem.goUnselect = gohelper.findChild(go, "unselected")
			filterItem.goSelect = gohelper.findChild(go, "selected")

			local txtFilterU = gohelper.findChildText(go, "unselected/info1")

			txtFilterU.text = config.name

			local imageFilterU = gohelper.findChildImage(go, "unselected/attrIcon1")

			Activity191Helper.setFetterIcon(imageFilterU, config.icon)

			local txtFilterS = gohelper.findChildText(go, "selected/info2")

			txtFilterS.text = config.name

			local imageFilterS = gohelper.findChildImage(go, "selected/attrIcon2")

			Activity191Helper.setFetterIcon(imageFilterS, config.icon)

			local btnClick = gohelper.findChildButtonWithAudio(go, "click")

			self.addClickCb(self, btnClick, self._filterItemClick, self, co.tag)

			self.filterItemMap[co.tag] = filterItem
		end
	end

	gohelper.setActive(goAttr, false)
end

function Act191HeroEditView:_filterItemClick(tag)
	if self.filterTag == tag then
		self.filterTag = nil
	else
		self.filterTag = tag
	end

	self:_refreshBtnClassify()

	if self._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:filterData(self.filterTag, self.sortRule)
	else
		Act191HeroEditListModel.instance:filterData(self.filterTag, self.sortRule)
	end
end

function Act191HeroEditView:_refreshBtnClassify()
	gohelper.setActive(self._classifyBtns[1], not self.filterTag)
	gohelper.setActive(self._classifyBtns[2], self.filterTag)

	for k, item in pairs(self.filterItemMap) do
		gohelper.setActive(item.goUnselect, k ~= self.filterTag)
		gohelper.setActive(item.goSelect, k == self.filterTag)
	end
end

function Act191HeroEditView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard.gameObject, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode.gameObject, not self._isShowQuickEdit)
end

function Act191HeroEditView:onClickHyperLink(effectId, clickPosition)
	local pos = Vector2.New(0, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(effectId, pos)
end

function Act191HeroEditView:refreshFetter()
	local fetterCntDic

	if self._isShowQuickEdit then
		local heroIdDic = Act191HeroQuickEditListModel.instance:getHeroIdMap()

		fetterCntDic = self.gameInfo:getPreviewFetterCntDic(heroIdDic)
	else
		local heroIdDic = Act191HeroEditListModel.instance:getHeroIdMap()

		fetterCntDic = self.gameInfo:getPreviewFetterCntDic(heroIdDic)
	end

	for _, item in ipairs(self.fetterItemList) do
		gohelper.setActive(item.go, false)
	end

	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	for k, info in ipairs(fetterInfoList) do
		local item = self.fetterItemList[k]

		if not item then
			local go = self:getResInst(Activity191Enum.PrefabPath.FetterItem, self._goFetterContent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterItem)
			self.fetterItemList[k] = item
		end

		item:setData(info.config, info.count)
		gohelper.setActive(item.go, true)
	end

	gohelper.setActive(self._goFetterContent, #fetterInfoList ~= 0)
end

return Act191HeroEditView
