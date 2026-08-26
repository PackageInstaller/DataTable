-- chunkname: @modules/logic/seasonver/act166/view/Season166TalentInfoView.lua

module("modules.logic.seasonver.act166.view.Season166TalentInfoView", package.seeall)

local Season166TalentInfoView = class("Season166TalentInfoView", BaseView)

function Season166TalentInfoView:onInitView()
	self._btncloseView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeView")
	self._gotalent1 = gohelper.findChild(self.viewGO, "talentIcon/#go_talentIcon1")
	self._gotalent2 = gohelper.findChild(self.viewGO, "talentIcon/#go_talentIcon2")
	self._gotalent3 = gohelper.findChild(self.viewGO, "talentIcon/#go_talentIcon3")
	self._goEquipSlot = gohelper.findChild(self.viewGO, "#go_equipslot")
	self._txttitle = gohelper.findChildText(self.viewGO, "info/#txt_title")
	self._txttitleen = gohelper.findChildText(self.viewGO, "info/#txt_titleen")
	self._txtbasicSkill = gohelper.findChildText(self.viewGO, "info/#txt_basicSkill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166TalentInfoView:addEvents()
	self._btncloseView:AddClickListener(self._btncloseViewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season166TalentInfoView:removeEvents()
	self._btncloseView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function Season166TalentInfoView:_btncloseViewOnClick()
	self:closeThis()
end

function Season166TalentInfoView:_btncloseOnClick()
	self:closeThis()
end

function Season166TalentInfoView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtbasicSkill, self.clcikHyperLink, self)
	self:initEquipSlot()
end

function Season166TalentInfoView:initEquipSlot()
	self.talentSlotTab = self:getUserDataTb_()

	for i = 1, 3 do
		local talentSlotItem = {}

		talentSlotItem.item = gohelper.findChild(self._goEquipSlot, i)
		talentSlotItem.light = gohelper.findChild(talentSlotItem.item, "light")
		talentSlotItem.imageLight = gohelper.findChildImage(talentSlotItem.item, "light")
		talentSlotItem.lineLight = gohelper.findChild(talentSlotItem.item, "line_light")
		talentSlotItem.lineDark = gohelper.findChild(talentSlotItem.item, "line_dark")
		talentSlotItem.effect1 = gohelper.findChild(talentSlotItem.item, "light/qi1")
		talentSlotItem.effect2 = gohelper.findChild(talentSlotItem.item, "light/qi2")
		talentSlotItem.effect3 = gohelper.findChild(talentSlotItem.item, "light/qi3")
		self.talentSlotTab[i] = talentSlotItem
	end
end

function Season166TalentInfoView:onUpdateParam()
	return
end

function Season166TalentInfoView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_hero_sign)
	self:refreshUI()
end

function Season166TalentInfoView:refreshUI()
	self.actId = Season166Model.instance:getCurSeasonId()

	if not self.actId or self.actId == 0 then
		local battleContext = Season166Model.instance:getBattleContext()

		if battleContext then
			self.actId = battleContext.actId or 0
		end
	end

	self.talentParam = Season166Model.instance:getFightTalentParam()
	self.talentId = self.talentParam.talentId
	self.talentLevel = self.talentParam.talentLevel
	self.talentConfig = lua_activity166_talent.configDict[self.actId][self.talentId]
	self.styleCfgDic = lua_activity166_talent_style.configDict[self.talentId]
	self.maxSlot = lua_activity166_talent_style.configDict[self.talentId][self.talentLevel].slot

	self:refreshEquip()
	self:refreshTitle()
	self:initBasicSkill()
	self:refreshSkill()
end

function Season166TalentInfoView:refreshEquip()
	local talentConfig = lua_activity166_talent.configDict[self.actId][self.talentId]

	for i = 1, 3 do
		gohelper.setActive(self["_gotalent" .. i], i == talentConfig.sortIndex)
	end

	local talentSlotCount = self.maxSlot
	local talentEuipCount = #self.talentParam.talentSkillIds

	for index, talentSlotItem in ipairs(self.talentSlotTab) do
		gohelper.setActive(talentSlotItem.item, index <= talentSlotCount)
		gohelper.setActive(talentSlotItem.light, index <= talentEuipCount)
		gohelper.setActive(talentSlotItem.lineLight, index > 1 and index <= talentEuipCount)
		gohelper.setActive(talentSlotItem.lineDark, index > 1 and talentEuipCount < index)
		UISpriteSetMgr.instance:setSeason166Sprite(talentSlotItem.imageLight, "season166_talentree_pointl" .. tostring(talentConfig.sortIndex))

		for i = 1, 3 do
			gohelper.setActive(talentSlotItem["effect" .. i], talentConfig.sortIndex == i)
		end
	end
end

function Season166TalentInfoView:refreshTitle()
	self._txttitle.text = self.talentConfig.name
	self._txttitleen.text = self.talentConfig.nameEn

	local baseSkillIdsStr = self.talentConfig.baseSkillIds

	if string.nilorempty(baseSkillIdsStr) then
		baseSkillIdsStr = self.talentConfig.baseSkillIds2
	end

	local basicSkillIds = string.splitToNumber(baseSkillIdsStr, "#")
	local effectConfig = lua_skill_effect.configDict[basicSkillIds[1]]
	local txt = FightConfig.instance:getSkillEffectDesc("", effectConfig)

	self._txtbasicSkill.text = SkillHelper.buildDesc(txt)
end

function Season166TalentInfoView:initBasicSkill()
	self.selectSkillList = {}

	for i = 1, 3 do
		local selectItem = self:getUserDataTb_()

		selectItem.go = gohelper.findChild(self.viewGO, "info/basicSkill/" .. i)
		selectItem.goUnequip = gohelper.findChild(selectItem.go, "unequip")
		selectItem.goWhiteBg = gohelper.findChild(selectItem.go, "unequip/bg2")
		selectItem.goEquiped = gohelper.findChild(selectItem.go, "equiped")
		selectItem.animEquip = selectItem.goEquiped:GetComponent(gohelper.Type_Animation)
		selectItem.txtDesc = gohelper.findChildText(selectItem.go, "equiped/txt_desc")

		SkillHelper.addHyperLinkClick(selectItem.txtDesc, self.clcikHyperLink, self)

		local imageSlot = gohelper.findChildImage(selectItem.go, "equiped/txt_desc/slot")

		UISpriteSetMgr.instance:setSeason166Sprite(imageSlot, "season166_talentree_pointl" .. tostring(self.talentConfig.sortIndex))

		local goParticle = gohelper.findChild(selectItem.go, "equiped/txt_desc/slot/" .. self.talentConfig.sortIndex)

		gohelper.setActive(goParticle, true)

		selectItem.goLock = gohelper.findChild(selectItem.go, "locked")

		local txtLock = gohelper.findChildText(selectItem.go, "locked/txt_desc")
		local needStar = self.styleCfgDic[i].needStar
		local baseConfig = Season166Config.instance:getBaseSpotByTalentId(self.actId, self.talentId)

		txtLock.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), needStar, baseConfig.name)
		selectItem.anim = selectItem.go:GetComponent(gohelper.Type_Animator)
		self.selectSkillList[i] = selectItem
	end
end

function Season166TalentInfoView:refreshSkill()
	local skillIds = self.talentParam.talentSkillIds
	local selectIndex = #skillIds + 1

	for i, selectItem in ipairs(self.selectSkillList) do
		if i == selectIndex and selectIndex <= self.maxSlot then
			gohelper.setActive(selectItem.goWhiteBg, true)
		else
			gohelper.setActive(selectItem.goWhiteBg, false)
		end

		if i > self.maxSlot then
			gohelper.setActive(selectItem.goUnequip, false)
			gohelper.setActive(selectItem.goEquiped, false)
			gohelper.setActive(selectItem.goLock, true)
		elseif i > #skillIds then
			gohelper.setActive(selectItem.goUnequip, true)
			gohelper.setActive(selectItem.goEquiped, false)
			gohelper.setActive(selectItem.goLock, false)
		else
			local effectConfig = lua_skill_effect.configDict[skillIds[i]]
			local txt = FightConfig.instance:getSkillEffectDesc("", effectConfig)

			selectItem.txtDesc.text = SkillHelper.buildDesc(txt)

			gohelper.setActive(selectItem.goUnequip, false)
			gohelper.setActive(selectItem.goEquiped, true)
			gohelper.setActive(selectItem.goLock, false)
		end
	end
end

function Season166TalentInfoView:clcikHyperLink(effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effectId, Vector2(-742, 178))
end

function Season166TalentInfoView:onClose()
	return
end

function Season166TalentInfoView:onDestroyView()
	return
end

return Season166TalentInfoView
