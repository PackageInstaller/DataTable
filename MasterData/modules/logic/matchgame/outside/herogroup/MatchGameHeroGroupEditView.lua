-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroGroupEditView.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroGroupEditView", package.seeall)

local MatchGameHeroGroupEditView = class("MatchGameHeroGroupEditView", BaseView)

function MatchGameHeroGroupEditView:onInitView()
	self._goNoneCharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._goCharacterInfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imageCareerIcon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_careericon")
	self._txtCareer = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/#txt_career")
	self._txtName = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/#txt_name")
	self._imageRecommendCareer = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_recommendcareer")
	self._goAttrList = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._goAttrItem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute/#go_attributeitem")
	self._txtLevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._btnLevelUp = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_levelup")
	self._goLevelUpCost = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_levelup/#go_levelupcost")
	self._goLevelUpEffect = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_levelup/upgradeable_eff")
	self._goSkill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#scroll_Skill")
	self._goSkillContent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#scroll_Skill/Viewport/Content")
	self._goSkillItem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#scroll_Skill/Viewport/Content/#go_skillitem")
	self._goRoleContainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._goRoleSort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnQuickEdit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	self._goQuickEditBtn1 = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit/btn1")
	self._goQuickEditBtn2 = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit/btn2")
	self._goOps = gohelper.findChild(self.viewGO, "#go_ops")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btnCancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")
	self._posIndex = 0
	self._teamId = 1
	self._levelUpCostComp = MatchGameCostComp.Get(self._goLevelUpCost)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameHeroGroupEditView:addEvents()
	self._btnLevelUp:AddClickListener(self._btnLevelUpOnClick, self)
	self._btnQuickEdit:AddClickListener(self._btnQuickEditOnClick, self)
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self._btnCancel:AddClickListener(self._btnCancelOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateCharacter, self._onCharacterUpdated, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateItemInfo, self._onItemInfoUpdated, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnSaveTeamSuccess, self._onSaveTeamSuccess, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnSelectionChanged, self._onSelectionChanged, self)
end

function MatchGameHeroGroupEditView:removeEvents()
	self._btnLevelUp:RemoveClickListener()
	self._btnQuickEdit:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function MatchGameHeroGroupEditView:checkParam()
	local param = self.viewParam

	if param then
		self._posIndex = param.posIndex or 0
	end

	self._teamId = MatchGameHeroGroupModel.instance:getCurTeamId()

	local teamHeroes = MatchGameHeroGroupModel.instance:getCurTeamHeroes()
	local selectHeroMo = teamHeroes and teamHeroes[self._posIndex]

	MatchGameHeroGroupModel.instance:setCurEditPosHeroUid(selectHeroMo and selectHeroMo.id)

	selectHeroMo = selectHeroMo or MatchGameHeroGroupEditListModel.instance:getByIndex(1)

	if selectHeroMo then
		MatchGameHeroGroupEditListModel.instance:handleSelect(selectHeroMo.id)
	end
end

function MatchGameHeroGroupEditView:onOpen()
	MatchGameHeroGroupEditListModel.instance:initList()
	self:checkParam()
	self:refreshUI()
end

function MatchGameHeroGroupEditView:onClose()
	return
end

function MatchGameHeroGroupEditView:onDestroyView()
	return
end

function MatchGameHeroGroupEditView:_updateRefreshContext()
	self._selectedId = MatchGameHeroGroupEditListModel.instance:getSelectedCharacterId()

	if self._selectedId ~= 0 then
		self._heroMo = MatchGameHeroGroupEditListModel.instance:getById(self._selectedId)

		if self._heroMo then
			self._level = self._heroMo.level or 1
		end

		self._heroCo = self._heroMo.heroCo
		self._heroId = self._heroMo.heroId
		self._levelCost = MatchGameConfig.instance:getCharacterLevelUpCost(self._heroId, self._level + 1)
		self._isItemEnough = MatchGameModel.instance:isItemEnough(self._levelCost)
		self._maxLevel = MatchGameConfig.instance:getCharacterMaxLevel(self._heroId)
	else
		self._heroMo = nil
	end
end

function MatchGameHeroGroupEditView:refreshUI()
	self:_updateRefreshContext()
	self:_refreshCharacterInfo()
	self:_refreshLevelUpPanel()
	self:_refreshSkillList()
	self:_refreshQuickEditBtnState()
	self.viewContainer:getScrollView():refreshScroll()
end

function MatchGameHeroGroupEditView:_refreshCharacterInfo()
	if not self._heroMo then
		gohelper.setActive(self._goNoneCharacter, true)
		gohelper.setActive(self._goCharacterInfo, false)

		return
	end

	gohelper.setActive(self._goNoneCharacter, false)
	gohelper.setActive(self._goCharacterInfo, true)

	self._txtName.text = self._heroCo.name or ""

	MatchGameHelper.setCharacterElement(self._heroCo.elementId, self._imageCareerIcon, self._txtCareer)

	local curEpisodeCo = MatchGameLevelModel.instance:getCurEpisodeCo()

	MatchGameHelper.setCharacterElement(curEpisodeCo.recCareer, self._imageRecommendCareer)

	local attrList = lua_activity244_character_attr.configList

	gohelper.CreateObjList(self, self._refreshAttributeItem, attrList, self._goAttrList, self._goAttrItem)
end

function MatchGameHeroGroupEditView:_refreshAttributeItem(goAttr, attrCo, index)
	local txtValue = gohelper.findChildText(goAttr, "txt_attribute")
	local txtName = gohelper.findChildText(goAttr, "txt_name")
	local imageIcon = gohelper.findChildImage(goAttr, "image_icon")

	if self._heroMo then
		local attrValue = self._heroMo:getTotalAttrValue(attrCo.id)
		local changeAttrValue = 0

		if not self._heroMo:isTrial() and self._level < self._maxLevel then
			local nextAttrValue = MatchGameModel.instance:getCharacterAttrValue(self._heroCo.characterId, self._level + 1, attrCo.id)

			changeAttrValue = nextAttrValue - attrValue
		end

		if changeAttrValue ~= 0 then
			local updateAbsValue = math.abs(changeAttrValue)
			local valueSignal = changeAttrValue > 0 and "+" or "-"

			txtValue.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("matchgameherogroupeditview_updateattrvalue"), attrValue, valueSignal, updateAbsValue)
		else
			txtValue.text = tostring(attrValue)
		end

		MatchGameHelper.setCharacterAttr(attrCo.id, imageIcon, txtName)
	end
end

function MatchGameHeroGroupEditView:_refreshLevelUpPanel()
	if not self._heroMo then
		return
	end

	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("matchgameherogroupeditview_level"), self._level, self._maxLevel)

	if self._heroMo then
		local isTrial = self._heroMo:isTrial()

		if self._heroMo or self._level >= self._maxLevel then
			gohelper.setActive(self._btnLevelUp.gameObject, false)

			return
		end

		gohelper.setActive(self._btnLevelUp.gameObject, true)
		self._levelUpCostComp:onUpdateMO(self._levelCost)

		local isEnough = MatchGameModel.instance:isItemEnough(self._levelCost)

		gohelper.setActive(self._goLevelUpEffect, isEnough)
		ZProj.UGUIHelper.SetGrayscale(self._btnLevelUp.gameObject, not isEnough)
	end
end

function MatchGameHeroGroupEditView:_refreshSkillList()
	if self._heroCo then
		local activeSkillId = self._heroCo.activeSkillId
		local skillIdList = string.splitToNumber(activeSkillId, "#")
		local hasSkill = skillIdList and #skillIdList > 0

		gohelper.setActive(self._goSkill, hasSkill)

		if not hasSkill then
			return
		end

		gohelper.CreateObjList(self, self._refreshSkillItem, skillIdList, self._goSkillContent, self._goSkillItem)
	end
end

function MatchGameHeroGroupEditView:_refreshSkillItem(goItem, skillId, index)
	local txtName = gohelper.findChildText(goItem, "namebg/txt_Name")
	local txtDesc = gohelper.findChildText(goItem, "txt_Desc")
	local goTagList = gohelper.findChild(goItem, "go_TagList")
	local goTagItem = gohelper.findChild(goItem, "go_TagList/go_TagItem")

	SkillHelper.addHyperLinkClick(txtDesc)

	local skillCo = lua_activity244_character_skill.configDict[skillId]

	txtName.text = skillCo and skillCo.name
	txtDesc.text = SkillHelper.buildDesc((skillCo or nil) and (skillCo.desc or ""))

	local tagList = string.split(skillCo.skillTag, "|") or {}

	gohelper.CreateObjList(self, self._refreshSkillTag, tagList, goTagList, goTagItem)
end

function MatchGameHeroGroupEditView:_refreshSkillTag(goItem, tag, index)
	local txtTag = gohelper.findChildText(goItem, "txt_TagName")

	txtTag.text = tag
end

function MatchGameHeroGroupEditView:_refreshQuickEditBtnState()
	local isQuickEdit = MatchGameHeroGroupEditListModel.instance:isQuickEditMode()

	gohelper.setActive(self._goQuickEditBtn1, not isQuickEdit)
	gohelper.setActive(self._goQuickEditBtn2, isQuickEdit)
end

function MatchGameHeroGroupEditView:_onSelectionChanged()
	self:refreshUI()
end

function MatchGameHeroGroupEditView:_btnLevelUpOnClick()
	if not self._isItemEnough then
		GameFacade.showToast(ToastEnum.MatchGameItemNotEnough)

		return
	end

	local actId = MatchGameModel.instance:getCurActId()

	MatchGameRpc.instance:sendAct244UpgradeHeroRequest(actId, self._heroId)
end

function MatchGameHeroGroupEditView:_btnQuickEditOnClick()
	MatchGameHeroGroupEditListModel.instance:handleQuickEditToggle()
	self:_refreshQuickEditBtnState()
end

function MatchGameHeroGroupEditView:_btnConfirmOnClick()
	local isSuccess = MatchGameHeroGroupController.instance:confirmEdit(self._posIndex)

	if not isSuccess then
		self:closeThis()

		return
	end
end

function MatchGameHeroGroupEditView:_btnCancelOnClick()
	self:closeThis()
end

function MatchGameHeroGroupEditView:_btnBackOnClick()
	self:closeThis()
end

function MatchGameHeroGroupEditView:_onCharacterUpdated(heroId)
	self:refreshUI()
end

function MatchGameHeroGroupEditView:_onItemInfoUpdated(updateItemIdMap)
	self:_updateRefreshContext()
	self:_refreshLevelUpPanel()
end

function MatchGameHeroGroupEditView:_onSaveTeamSuccess()
	self:closeThis()
end

return MatchGameHeroGroupEditView
