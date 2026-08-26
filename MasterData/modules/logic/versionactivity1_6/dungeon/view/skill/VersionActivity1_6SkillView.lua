-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/skill/VersionActivity1_6SkillView.lua

module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillView", package.seeall)

local remainSkillPointNumColor = "#E4C599"
local VersionActivity1_6SkillView = class("VersionActivity1_6SkillView", BaseView)
local SkillItemNum = 4

function VersionActivity1_6SkillView:onInitView()
	self._goItem1 = gohelper.findChild(self.viewGO, "#go_Item1")
	self._goItem2 = gohelper.findChild(self.viewGO, "#go_Item2")
	self._goItem3 = gohelper.findChild(self.viewGO, "#go_Item3")
	self._goItem4 = gohelper.findChild(self.viewGO, "#go_Item4")
	self._goDetailPanel = gohelper.findChild(self.viewGO, "SkillPanel")
	self._detailAnimator = self._goDetailPanel:GetComponent(typeof(UnityEngine.Animator))
	self._goSkillEffectDesc = gohelper.findChild(self.viewGO, "SkillPanel/Skill/Scroll View/Viewport/Content/#go_SkillDescr")
	self._goSkillAttrDesc = gohelper.findChild(self.viewGO, "SkillPanel/Value/Layout/#go_Attri")
	self._goSkillEffectEmpty = gohelper.findChild(self.viewGO, "SkillPanel/Skill/#go_Empty")
	self._goSkillAttrEmpty = gohelper.findChild(self.viewGO, "SkillPanel/Value/#go_Empty")
	self._goBuffItemTemplate = gohelper.findChild(self.viewGO, "v1a6_talent_lvupitem")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset")
	self._btnPreview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Wish")
	self._btnClosePreview = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPanel/#btn_close")
	self._btnSkillPointArea = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPoint/#btn_Info/Click")
	self._btnSkillPointTips = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPoint/#btn_Info")
	self._btnTipsClose = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPoint/#btn_Info/image_TipsBG/#btn_Tips_Close")
	self._goSkilPointTips = gohelper.findChild(self.viewGO, "SkillPoint/#btn_Info/image_TipsBG")
	self._txtSkillPointNum = gohelper.findChildText(self.viewGO, "SkillPoint/#btn_Info/image_TipsBG/txt_Tips_Num")
	self._txtRemainSkillPointNum = gohelper.findChildText(self.viewGO, "SkillPoint/txt_Skill_Num")
	self._imageSkillPoint = gohelper.findChildImage(self.viewGO, "SkillPoint/#simage_Prop")
	self._goSkillPointEffect = gohelper.findChild(self.viewGO, "SkillPoint/eff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6SkillView:addEvents()
	self._btnPreview:AddClickListener(self._btnPreviewOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnClosePreview:AddClickListener(self._btnPreviewCloseOnClick, self)
	self._btnSkillPointArea:AddClickListener(self._btnSkillPointOnClick, self)
	self._btnSkillPointTips:AddClickListener(self._btnSkillPointTipsOnClick, self)
	self._btnTipsClose:AddClickListener(self._btnSkillPointTipsCloseOnClick, self)
end

function VersionActivity1_6SkillView:removeEvents()
	self._btnPreview:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnClosePreview:RemoveClickListener()
	self._btnSkillPointTips:RemoveClickListener()
	self._btnSkillPointArea:RemoveClickListener()
	self._btnTipsClose:RemoveClickListener()
end

function VersionActivity1_6SkillView:_editableInitView()
	gohelper.setActive(self._goBuffItemTemplate, false)
	gohelper.setActive(self._goDetailPanel, false)
	gohelper.setActive(self._goSkilPointTips, false)
	gohelper.setActive(self._goSkillEffectDesc, false)
	gohelper.setActive(self._goSkillAttrDesc, false)

	self._buffItemList = {}
end

function VersionActivity1_6SkillView:onUpdateParam()
	return
end

function VersionActivity1_6SkillView:onOpen()
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, Act148Event.SkillReset, self._onSkillReset, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, Act148Event.SkillLvDown, self._onLvChange, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, Act148Event.SkillLvUp, self._onLvChange, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterSkillView)
end

function VersionActivity1_6SkillView:onOpenFinish()
	self:_initSkillItem()
	self:_refreshSkillPoint()
	self:_refreshSkillEffects()
	self:_refreshSkillAttrs()
end

function VersionActivity1_6SkillView:_initSkillItem()
	for i = 1, SkillItemNum do
		local buffItem = VersionActivity1_6SkillItem.New()
		local buffItemGo = gohelper.cloneInPlace(self._goBuffItemTemplate)

		gohelper.setActive(buffItemGo, true)
		buffItemGo.transform:SetParent(self["_goItem" .. i].transform)
		transformhelper.setLocalPos(buffItemGo.transform, 0, 0, 0)
		buffItem:init(buffItemGo, i)

		self._buffItemList[i] = buffItem
	end
end

function VersionActivity1_6SkillView:_refreshSkillItems()
	for i = 1, SkillItemNum do
		self._buffItemList[i]:refreshItemUI()
	end
end

function VersionActivity1_6SkillView:_refreshSkillPoint()
	local maxSkillPointNum = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)

	if currencyCfg then
		local currencyname = string.format("%s_1", currencyCfg and currencyCfg.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageSkillPoint, currencyname)
	end

	if currencyMO then
		if not currencyMO.quantity then
			self._txtRemainSkillPointNum.text = 0

			SLFramework.UGUI.GuiHelper.SetColor(self._txtRemainSkillPointNum, remainSkillPointNumColor)

			local totalGotSkillPointNum = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum()

			self._txtSkillPointNum.text = string.format("<color=#EB5F34>%s</color>/%s", totalGotSkillPointNum or 0, maxSkillPointNum)
		end
	end
end

function VersionActivity1_6SkillView:refreshSkillDetailPanel(show)
	gohelper.setActive(self._goDetailPanel, true)
	gohelper.setActive(self._btnClosePreview.gameObject, show)
	self._detailAnimator:Play((show or nil) and (UIAnimationName.Open or UIAnimationName.Close), 0, 0)
end

function VersionActivity1_6SkillView:_refreshSkillEffects()
	local skillEffects = {}

	for i = 1, SkillItemNum do
		local skillType = i
		local skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(skillType)
		local skillLv = skillMo and skillMo:getLevel() or 0

		for j = 1, skillLv do
			local isKeyPoint = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[j]

			if isKeyPoint then
				skillEffects[#skillEffects + 1] = Activity148Config.instance:getAct148CfgByTypeLv(skillType, j)
			end
		end
	end

	self._skillEffectItemList = {}

	for i = 1, #skillEffects do
		local skillCfg = skillEffects[i]
		local skillTypeCfg = Activity148Config.instance:getAct148SkillTypeCfg(skillCfg.type)
		local skillEffectGo = gohelper.cloneInPlace(self._goSkillEffectDesc)

		gohelper.setActive(skillEffectGo, true)

		self._skillEffectItemList[i] = self:getUserDataTb_()
		self._skillEffectItemList[i].go = skillEffectGo

		local textEffect = skillEffectGo:GetComponent(gohelper.Type_TextMesh)
		local skillEffectCfg = FightConfig.instance:getSkillEffectCO(skillCfg.skillId)

		if skillEffectCfg then
			::label_12_0::

			local effectDesc = FightConfig.instance:getSkillEffectDesc(nil, skillEffectCfg)
			local effectNameLvStr = gohelper.getRichColorText(skillTypeCfg.skillName .. " Lv." .. skillCfg.level .. "：", "#E99B56")

			textEffect.text = effectNameLvStr .. effectDesc
		end
	end

	gohelper.setActive(self._goSkillEffectEmpty, #skillEffects == 0)
end

function VersionActivity1_6SkillView:_refreshSkillAttrs()
	local skillAttrs = {}

	for i = 1, SkillItemNum do
		local skillType = i
		local skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(skillType)
		local skillLv = skillMo and skillMo:getLevel() or 0

		for j = 1, skillLv do
			local isKeyPoint = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[j]

			if not isKeyPoint then
				local skillCfg = Activity148Config.instance:getAct148CfgByTypeLv(skillType, j)
				local attrStr = skillCfg.attrs
				local attributeArr = string.splitToNumber(attrStr, "#")
				local attrId = attributeArr[1]
				local attrValue = attributeArr[2]

				skillAttrs[attrId] = skillAttrs[attrId] or 0
				skillAttrs[attrId] = skillAttrs[attrId] + attrValue
			end
		end
	end

	self._skillAttrItemList = {}

	local attrCount = 0

	for attrId, value in pairs(skillAttrs) do
		local attrCfg = HeroConfig.instance:getHeroAttributeCO(attrId)
		local skillAttrGo = gohelper.cloneInPlace(self._goSkillAttrDesc)

		gohelper.setActive(skillAttrGo, true)

		self._skillAttrItemList[attrId] = self:getUserDataTb_()
		self._skillAttrItemList[attrId].go = skillAttrGo

		local txtAttrName = skillAttrGo:GetComponent(gohelper.Type_TextMesh)

		txtAttrName.text = attrCfg.name
		value = tonumber(string.format("%.3f", value / 10)) .. "%"

		local txtAttrValue = gohelper.findChildText(skillAttrGo, "#go_AttriNum")

		txtAttrValue.text = "+" .. value

		local image = gohelper.findChildImage(skillAttrGo, "#image_Icon")

		UISpriteSetMgr.instance:setCommonSprite(image, "icon_att_" .. attrCfg.id, true)

		attrCount = attrCount + 1
	end

	gohelper.setActive(self._goSkillAttrEmpty, attrCount == 0)
end

function VersionActivity1_6SkillView:_clearSkillDetailItems()
	if self._skillEffectItemList then
		for k, item in pairs(self._skillEffectItemList) do
			gohelper.destroy(item.go)

			item.go = nil
		end
	end

	self._skillEffectItemList = nil

	if self._skillAttrItemList then
		for k, item in pairs(self._skillAttrItemList) do
			gohelper.destroy(item.go)

			item.go = nil
		end
	end

	self._skillAttrItemList = nil
end

function VersionActivity1_6SkillView:refreshSkillPointTips(show)
	gohelper.setActive(self._goSkilPointTips, show)
end

function VersionActivity1_6SkillView:onClose()
	return
end

function VersionActivity1_6SkillView:onDestroyView()
	for _, item in ipairs(self._buffItemList) do
		item:onDestroyItem()
	end

	self._buffItemList = nil
end

function VersionActivity1_6SkillView:_onCurrencyChange()
	self:_refreshSkillPoint()
end

function VersionActivity1_6SkillView:_onSkillReset()
	for i = 1, SkillItemNum do
		self._buffItemList[i]:refreshResetEffect()
	end

	gohelper.setActive(self._goSkillPointEffect, false)
	gohelper.setActive(self._goSkillPointEffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonSkillViewReset)
	self:_onLvChange()
end

function VersionActivity1_6SkillView:_onLvChange()
	self:_refreshSkillItems()
	self:_refreshSkillPoint()
	self:_clearSkillDetailItems()
	self:_refreshSkillEffects()
	self:_refreshSkillAttrs()
end

function VersionActivity1_6SkillView:_btnPreviewOnClick()
	self:refreshSkillDetailPanel(true)
end

function VersionActivity1_6SkillView:_btnPreviewCloseOnClick()
	self:refreshSkillDetailPanel(false)
end

function VersionActivity1_6SkillView:_btnSkillPointOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6DungeonSkill, false, nil, false)
end

function VersionActivity1_6SkillView:_btnSkillPointTipsOnClick()
	self:refreshSkillPointTips(true)
end

function VersionActivity1_6SkillView:_btnSkillPointTipsCloseOnClick()
	self:refreshSkillPointTips(false)
end

function VersionActivity1_6SkillView:_btnResetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6ResetSkill, MsgBoxEnum.BoxType.Yes_No, self.btnResetFunc, nil, nil, self)
end

function VersionActivity1_6SkillView:btnResetFunc()
	VersionActivity1_6DungeonRpc.instance:sendAct148ResetRequest()
end

return VersionActivity1_6SkillView
