-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStatsView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStatsView", package.seeall)

local AssassinStatsView = class("AssassinStatsView", BaseView)

function AssassinStatsView:onInitView()
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goPanel = gohelper.findChild(self.viewGO, "StatsPanel")
	self._goArrow1 = gohelper.findChild(self.viewGO, "StatsPanel/StatsTitle/#go_Arrow")
	self._goattrLayout = gohelper.findChild(self.viewGO, "StatsPanel/#go_attrLayout")
	self._goattrItem = gohelper.findChild(self.viewGO, "StatsPanel/#go_attrLayout/#go_attrItem")
	self._btnattribute = gohelper.findChildClickWithAudio(self.viewGO, "StatsPanel/#btn_attribute", AudioEnum.UI.Play_ui_role_description)
	self._gopassiveskills = gohelper.findChild(self.viewGO, "StatsPanel/passiveskill/bg/#go_passiveskills")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "StatsPanel/passiveskill/bg/passiveskillimage/#txt_passivename")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "StatsPanel/passiveskill/#btn_passiveskill", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goArrow2 = gohelper.findChild(self.viewGO, "StatsPanel/passiveskill/#go_Arrow")
	self._goskill = gohelper.findChild(self.viewGO, "StatsPanel/#go_skill")
	self._goArrow3 = gohelper.findChild(self.viewGO, "StatsPanel/#go_skill/#go_Arrow")
	self._goskilltipview = gohelper.findChild(self.viewGO, "#go_skilltipview")
	self._gocharactertipview = gohelper.findChild(self.viewGO, "#go_charactertipview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStatsView:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function AssassinStatsView:removeEvents()
	self._btnInfo:RemoveClickListener()
	self._btnpassiveskill:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function AssassinStatsView:_btnInfoOnClick()
	self:closeThis()
end

function AssassinStatsView:_btnpassiveskillOnClick()
	local info = {}

	info.tag = "passiveskill"

	local heroMo = AssassinHeroModel.instance:getHeroMo(self.assassinHeroId)

	info.heroid = heroMo.heroId

	local panelX = transformhelper.getLocalPos(self._transPanel)

	info.anchorParams = {
		Vector2.New(0.5, 0.5),
		Vector2.New(0.5, 0.5)
	}
	info.tipPos = Vector2.New(panelX + 795, 40)
	info.buffTipsX = -863
	info.heroMo = heroMo
	info.showAssassinBg = true
	self._showPassiveSkill = true

	CharacterController.instance:openCharacterTipView(info)
end

function AssassinStatsView:_btnattributeOnClick()
	local info = {}

	info.tag = "attribute"

	local heroMo = AssassinHeroModel.instance:getHeroMo(self.assassinHeroId)

	info.heroMo = heroMo
	info.heroid = heroMo.heroId
	info.equips = heroMo.defaultEquipUid ~= "0" and {
		heroMo.defaultEquipUid
	} or nil
	info.trialEquipMo = heroMo.trialEquipMo

	local panelX = transformhelper.getLocalPos(self._transPanel)

	info.anchorParams = {
		Vector2.New(0.5, 0.5),
		Vector2.New(0.5, 0.5)
	}
	info.tipPos = Vector2.New(panelX + 636, 35)
	info.showAssassinBg = true
	info.hideAttrDetail = true
	self._showAttr = true

	CharacterController.instance:openCharacterTipView(info)
end

function AssassinStatsView:_onOpenView(viewName)
	self:refreshArrow()
end

function AssassinStatsView:_onCloseView(viewName)
	if viewName == ViewName.CharacterTipView then
		self._showPassiveSkill = false
		self._showAttr = false
	end

	self:refreshArrow()
end

function AssassinStatsView:_editableInitView()
	self._transPanel = self._goPanel.transform
	self._showPassiveSkill = false
	self._showAttr = false
	self._passiveskillitems = {}

	for i = 1, 3 do
		local passiveSkillItem = self:getUserDataTb_()

		passiveSkillItem.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. tostring(i))
		passiveSkillItem.on = gohelper.findChild(passiveSkillItem.go, "on")
		passiveSkillItem.off = gohelper.findChild(passiveSkillItem.go, "off")
		self._passiveskillitems[i] = passiveSkillItem
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer, {
		skillTipY = 17,
		adjustBuffTip = true,
		skillTipX = 409,
		showAssassinBg = true
	})
end

function AssassinStatsView:onUpdateParam()
	self.assassinHeroId = self.viewParam.assassinHeroId

	self:setAttribute()
	self:setHeroSkill()
end

function AssassinStatsView:onOpen()
	self:onUpdateParam()
	self:refreshArrow()
end

function AssassinStatsView:onOpenFinish()
	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function AssassinStatsView:setAttribute()
	local attrList = AssassinHeroModel.instance:getAssassinHeroAttributeList(self.assassinHeroId)

	gohelper.CreateObjList(self, self._onCreateHeroAttributeItem, attrList, self._goattrLayout, self._goattrItem)
end

function AssassinStatsView:_onCreateHeroAttributeItem(obj, data, index)
	local attrIcon = gohelper.findChildImage(obj, "icon")
	local attrName = gohelper.findChildText(obj, "#txt_attrName")
	local attrValue = gohelper.findChildText(obj, "#txt_attrValue")
	local attrId = data.id
	local attrCO = HeroConfig.instance:getHeroAttributeCO(attrId)

	CharacterController.instance:SetAttriIcon(attrIcon, attrId)

	attrName.text = attrCO.name
	attrValue.text = data.value
end

function AssassinStatsView:setHeroSkill()
	local heroMo = AssassinHeroModel.instance:getHeroMo(self.assassinHeroId)
	local pskills = heroMo:getpassiveskillsCO()
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local skillConfig = lua_skill.configDict[skillId]

	if not skillConfig then
		logError("AssassinHeroView:refreshHeroSkill error, no skillCfg, skillId: " .. tostring(skillId))

		return
	end

	self._txtpassivename.text = skillConfig.name

	for i = 1, #pskills do
		local unlock = CharacterModel.instance:isPassiveUnlockByHeroMo(heroMo, i)

		gohelper.setActive(self._passiveskillitems[i].on, unlock)
		gohelper.setActive(self._passiveskillitems[i].off, not unlock)
		gohelper.setActive(self._passiveskillitems[i].go, true)
	end

	for i = #pskills + 1, #self._passiveskillitems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end

	self._skillContainer:onUpdateMO(heroMo.heroId, nil, heroMo)
end

function AssassinStatsView:refreshArrow()
	local isOpenCharacterTipView = ViewMgr.instance:isOpen(ViewName.CharacterTipView)
	local isOpenSkillTipView = ViewMgr.instance:isOpen(ViewName.SkillTipView)

	gohelper.setActive(self._goArrow1, isOpenCharacterTipView and self._showAttr)
	gohelper.setActive(self._goArrow2, isOpenCharacterTipView and self._showPassiveSkill)
	gohelper.setActive(self._goArrow3, isOpenSkillTipView)
end

function AssassinStatsView:onClose()
	PostProcessingMgr.instance:setIgnoreUIBlur(false)
end

function AssassinStatsView:onDestroyView()
	return
end

return AssassinStatsView
