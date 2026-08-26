-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectRoleView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleView", package.seeall)

local EliminateSelectRoleView = class("EliminateSelectRoleView", BaseView)

function EliminateSelectRoleView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._scrollRoleList = gohelper.findChildScrollRect(self.viewGO, "#scroll_RoleList")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_RoleList/Viewport/#go_Content")
	self._goRoleSkill = gohelper.findChild(self.viewGO, "Tips/Skill/#go_RoleSkill")
	self._goRoleSkillBG = gohelper.findChild(self.viewGO, "Tips/Skill/#go_RoleSkill/#go_RoleSkillBG")
	self._simageSkill = gohelper.findChildSingleImage(self.viewGO, "Tips/Skill/#go_RoleSkill/image/#simage_Skill")
	self._imageRoleSkillFG = gohelper.findChildImage(self.viewGO, "Tips/Skill/#go_RoleSkill/#image_RoleSkillFG")
	self._goRoleSkillClick = gohelper.findChild(self.viewGO, "Tips/Skill/#go_RoleSkill/#go_RoleSkillClick")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "Tips/Skill/image_SkillName/#txt_SkillName")
	self._txtCost = gohelper.findChildText(self.viewGO, "Tips/Skill/#txt_Cost")
	self._txtCostNum = gohelper.findChildText(self.viewGO, "Tips/Skill/#txt_Cost/#txt_CostNum")
	self._txtSkill1 = gohelper.findChildText(self.viewGO, "Tips/Skill/#txt_Skill1")
	self._txtSkill2 = gohelper.findChildText(self.viewGO, "Tips/Skill/#txt_Skill2")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateSelectRoleView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function EliminateSelectRoleView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function EliminateSelectRoleView:_btnLeftOnClick()
	if self._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	self._roleIndex = self._roleIndex - 1

	self:_updateSelectedItem()
end

function EliminateSelectRoleView:_btnRightOnClick()
	if self._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	self._roleIndex = self._roleIndex + 1

	self:_updateSelectedItem()
end

function EliminateSelectRoleView:_btnconfirmOnClick()
	EliminateTeamSelectionModel.instance:setSelectedCharacterId(self._characterConfigList[self._roleIndex].id)
	EliminateMapController.instance:openEliminateSelectChessMenView()
end

function EliminateSelectRoleView:_editableInitView()
	local tipsGo = gohelper.findChild(self.viewGO, "Tips")

	self._tipsAnimator = tipsGo:GetComponent("Animator")
	self._isPreset = EliminateTeamSelectionModel.instance:isPreset()
	self._roleIndex = 1
	self._maxRoleIndex = 1

	self:_initItems()
	self:_initSelectCharacter()

	self._imageSkill = self._simageSkill.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

	self:_updateSelectedItem()
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.ClickCharacter, self.onClickCharacter, self)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.ComeShow)
end

function EliminateSelectRoleView:onClickCharacter(index)
	if self._isPreset then
		GameFacade.showToast(ToastEnum.EliminatePresetTip2)

		return
	end

	self._roleIndex = index

	self:_updateSelectedItem()
end

function EliminateSelectRoleView:_initItems()
	self._roleList = self:getUserDataTb_()
	self._characterConfigList = EliminateTeamSelectionModel.instance:getCharacterList()

	local path = self.viewContainer:getSetting().otherRes[1]

	for i, v in ipairs(self._characterConfigList) do
		local itemGO = self:getResInst(path, self._goContent)

		itemGO.name = "item_" .. tostring(v.id)

		local roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, EliminateSelectRoleItem)

		roleItem:onUpdateMO(v, i)
		table.insert(self._roleList, roleItem)

		if roleItem:isUnlocked() then
			self._maxRoleIndex = i
		end
	end
end

function EliminateSelectRoleView:_initSelectCharacter()
	if self._isPreset then
		for i, v in ipairs(self._characterConfigList) do
			if EliminateTeamSelectionModel.instance:isPresetCharacter(v.id) then
				self._roleIndex = i

				break
			end
		end

		return
	end

	local str = EliminateMapController.getPrefsString(EliminateMapEnum.PrefsKey.RoleSelected, "")
	local characterId = tonumber(str)

	if not characterId then
		return
	end

	for i, v in ipairs(self._characterConfigList) do
		if v.id == characterId then
			self._roleIndex = i

			break
		end
	end
end

function EliminateSelectRoleView:_updateSelectedItem()
	local leftEnabled = self._roleIndex > 1
	local rightEnabled = self._roleIndex < self._maxRoleIndex
	local showAllBtn = leftEnabled or rightEnabled

	self._btnLeft.button.interactable = leftEnabled and not self._isPreset
	self._btnRight.button.interactable = rightEnabled and not self._isPreset

	gohelper.setActive(self._btnLeft, showAllBtn)
	gohelper.setActive(self._btnRight, showAllBtn)
	self:_selectRoleItem(self._roleList[self._roleIndex])
	self._tipsAnimator:Play("open", 0, 0)
end

function EliminateSelectRoleView:_selectRoleItem(item)
	for i, v in ipairs(self._roleList) do
		v:onSelect(false)
	end

	item:onSelect(true)
	ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)

	local config = item:getConfig()
	local firstSkillConfig = self:_getFirstSkillConfig(config.activeSkillIds)

	if firstSkillConfig then
		self._txtCostNum.text = firstSkillConfig.cost
		self._txtSkill1.text = EliminateLevelModel.instance.formatString(firstSkillConfig.desc, EliminateTeamChessEnum.PreBattleFormatType)
		self._txtSkillName.text = firstSkillConfig.name

		UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageSkill, firstSkillConfig.icon)
	else
		self._txtCostNum.text = ""
		self._txtSkill1.text = ""
		self._txtSkillName.text = ""
	end

	self._txtSkill2.text = self:_getSkillDesc(config.passiveSkillIds)
end

function EliminateSelectRoleView:_getSkillDesc(skillIds)
	local config = self:_getFirstSkillConfig(skillIds)

	return config and EliminateLevelModel.instance.formatString(config.desc, EliminateTeamChessEnum.PreBattleFormatType) or ""
end

function EliminateSelectRoleView:_getFirstSkillConfig(skillIds)
	local list = string.splitToNumber(skillIds, "#")
	local id = list[1]

	return lua_character_skill.configDict[id]
end

function EliminateSelectRoleView:onUpdateParam()
	return
end

function EliminateSelectRoleView:onOpen()
	return
end

function EliminateSelectRoleView:onClose()
	return
end

function EliminateSelectRoleView:onDestroyView()
	return
end

return EliminateSelectRoleView
