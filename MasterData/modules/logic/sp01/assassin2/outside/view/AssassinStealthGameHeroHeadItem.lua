-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameHeroHeadItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameHeroHeadItem", package.seeall)

local AssassinStealthGameHeroHeadItem = class("AssassinStealthGameHeroHeadItem", LuaCompBase)
local SelectedScale = 1
local NormalScale = 0.8

function AssassinStealthGameHeroHeadItem:init(go)
	self.go = go
	self.trans = go.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameHeroHeadItem:_editableInitView()
	self._goselected = gohelper.findChild(self.go, "#go_selected")
	self._goitemlayout = gohelper.findChild(self.go, "#go_selected/#go_itemlayout")
	self._goitem = gohelper.findChild(self.go, "#go_selected/#go_itemlayout/#go_item")
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._imagehead1 = gohelper.findChildImage(self.go, "#go_normal/#simage_head")
	self._imagehp1 = gohelper.findChildImage(self.go, "#go_normal/#image_hp")
	self._goapLayout = gohelper.findChild(self.go, "#go_normal/#go_apLayout")
	self._goselectedarrow = gohelper.findChild(self.go, "#go_selected_arrow")
	self._godead = gohelper.findChild(self.go, "#go_dead")
	self._imagehead2 = gohelper.findChildImage(self.go, "#go_dead/#simage_head")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._gohl = gohelper.findChild(self.go, "#go_normal/image_light")
	self._apComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goapLayout, AssassinStealthGameAPComp)
end

function AssassinStealthGameHeroHeadItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinStealthGameHeroHeadItem:removeEventListeners()
	self._btnclick:RemoveClickListener()

	for _, skillPropItem in ipairs(self._skillPropItemList) do
		skillPropItem.btnclick:RemoveClickListener()
	end
end

function AssassinStealthGameHeroHeadItem:_btnclickOnClick()
	AssassinStealthGameController.instance:clickHeroEntity(self.uid, true)
end

function AssassinStealthGameHeroHeadItem:_btnClickSkillProp(index)
	local skillPropItem = self._skillPropItemList[index]

	if not skillPropItem then
		return
	end

	AssassinStealthGameController.instance:clickSkillProp(skillPropItem.id, skillPropItem.isSkill)
end

function AssassinStealthGameHeroHeadItem:onSkillPropChange(newItemDict)
	self:setSkillPropList(newItemDict)
	self:refreshSkillProp()
end

function AssassinStealthGameHeroHeadItem:setData(data)
	self.uid = data.heroUid
	self.isLastHeroHead = data.isLastHeroHead

	self._apComp:setHeroUid(self.uid)

	local heroGameMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local assassinHeroId = heroGameMo and heroGameMo:getHeroId()
	local headIcon = AssassinConfig.instance:getAssassinHeroEntityIcon(assassinHeroId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imagehead1, headIcon)
	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imagehead2, headIcon)
	self:setSkillPropList()

	local checkSelectedAnim = data.checkSelectedAnim
	local oldSelectedHeroUid = data.oldSelectedHeroUid

	self:refresh(checkSelectedAnim, oldSelectedHeroUid)
end

function AssassinStealthGameHeroHeadItem:setSkillPropList(newItemDict)
	if self._skillPropItemList then
		for _, skillPropItem in ipairs(self._skillPropItemList) do
			skillPropItem.btnclick:RemoveClickListener()
		end
	end

	self._skillPropItemList = {}

	local skillPropList = AssassinStealthGameModel.instance:getHeroSkillPropList(self.uid)

	if newItemDict then
		for _, skillPropData in ipairs(skillPropList) do
			if not skillPropData.isSkill then
				skillPropData.isNew = newItemDict[skillPropData.id]
			end
		end
	end

	gohelper.CreateObjList(self, self._onCreateSkillPropItem, skillPropList, self._goitemlayout, self._goitem)
end

function AssassinStealthGameHeroHeadItem:_onCreateSkillPropItem(obj, data, index)
	local skillPropItem = self:getUserDataTb_()

	skillPropItem.go = obj
	skillPropItem.id = data.id
	skillPropItem.isSkill = not not data.isSkill
	skillPropItem.animator = skillPropItem.go:GetComponent(typeof(UnityEngine.Animator))
	skillPropItem.gonormal = gohelper.findChild(skillPropItem.go, "#go_normal")
	skillPropItem.goselected = gohelper.findChild(skillPropItem.go, "#go_normal/#go_selected")
	skillPropItem.txtnum = gohelper.findChildText(skillPropItem.go, "#go_normal/#txt_num")
	skillPropItem.goapLayout = gohelper.findChild(skillPropItem.go, "#go_normal/#go_apLayout")
	skillPropItem.imageicon1 = gohelper.findChildImage(skillPropItem.go, "#go_normal/#simage_icon")
	skillPropItem.godisable = gohelper.findChild(skillPropItem.go, "#go_disable")
	skillPropItem.imageicon2 = gohelper.findChildImage(skillPropItem.go, "#go_disable/#simage_icon")
	skillPropItem.btnclick = gohelper.findChildClickWithAudio(skillPropItem.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	skillPropItem.btnclick:AddClickListener(self._btnClickSkillProp, self, index)

	local costAP = 0

	skillPropItem.apComp = MonoHelper.addNoUpdateLuaComOnceToGo(skillPropItem.goapLayout, AssassinStealthGameAPComp)

	if skillPropItem.isSkill then
		local costType, cost = AssassinConfig.instance:getAssassinSkillCost(skillPropItem.id)

		if costType == AssassinEnum.SkillCostType.AP then
			costAP = cost
		else
			logError(string.format("AssassinStealthGameHeroHeadItem:_onCreateSkillPropItem error, not support cost type:%s, skillId:%s", costType, skillPropItem.id))
		end

		AssassinHelper.setAssassinSkillIcon(skillPropItem.id, skillPropItem.imageicon1)
		AssassinHelper.setAssassinSkillIcon(skillPropItem.id, skillPropItem.imageicon2)
	else
		costAP = AssassinConfig.instance:getAssassinItemCostPoint(skillPropItem.id)

		AssassinHelper.setAssassinItemIcon(skillPropItem.id, skillPropItem.imageicon1)
		AssassinHelper.setAssassinItemIcon(skillPropItem.id, skillPropItem.imageicon2)
	end

	skillPropItem.apComp:setAPCount(costAP)

	if data.isNew then
		skillPropItem.animator:Play("open", 0, 0)
	end

	self._skillPropItemList[index] = skillPropItem
end

function AssassinStealthGameHeroHeadItem:refresh(checkSelectedAnim, oldSelectedHeroUid)
	self:refreshStatus()
	self:refreshHp()
	self:refreshSelected(checkSelectedAnim, oldSelectedHeroUid)
	self:refreshHighlight()
end

function AssassinStealthGameHeroHeadItem:refreshStatus()
	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local status = gameHeroMo:getStatus()
	local isDead = status == AssassinEnum.HeroStatus.Dead

	gohelper.setActive(self._gonormal, not isDead)
	gohelper.setActive(self._godead, isDead)
end

function AssassinStealthGameHeroHeadItem:refreshHp()
	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local hp = gameHeroMo:getHp()

	self._imagehp1.fillAmount = hp / AssassinEnum.StealthConst.HpRatePoint
end

function AssassinStealthGameHeroHeadItem:refreshSelected(checkSelectedAnim, oldSelectedHeroUid)
	local isCanSelect = AssassinStealthGameHelper.isCanSelectHero(self.uid)
	local isSelected = AssassinStealthGameModel.instance:isSelectedHero(self.uid)

	if isSelected then
		if not SelectedScale then
			local scale = NormalScale

			transformhelper.setLocalScale(self.trans, scale, scale, scale)

			local animName

			if self._skillPropItemList then
				local hasItem = #self._skillPropItemList > 0

				animName = isCanSelect and isSelected and (hasItem and "select_in" or "select_in1") or hasItem and "select_out" or "select_out1"

				local needPlay = false

				if checkSelectedAnim then
					local selectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()

					if not oldSelectedHeroUid and selectedHeroUid or oldSelectedHeroUid and not selectedHeroUid then
						needPlay = true
					end
				end

				self._animator:Play(animName, 0, self.isLastHeroHead and needPlay and 0 or 1)
				self:refreshSkillProp()
			end
		end
	end
end

function AssassinStealthGameHeroHeadItem:refreshSkillProp()
	local isCanSelect = AssassinStealthGameHelper.isCanSelectHero(self.uid)

	if not ((isCanSelect or nil) and AssassinStealthGameModel.instance:isSelectedHero(self.uid)) or not self._skillPropItemList then
		return
	end

	for _, skillPropItem in ipairs(self._skillPropItemList) do
		local skillPropId = skillPropItem.id
		local isSkill = skillPropItem.isSkill
		local isCanUse = AssassinStealthGameHelper.isCanUseSkillProp(self.uid, skillPropId, isSkill)

		gohelper.setActive(skillPropItem.gonormal, isCanUse)
		gohelper.setActive(skillPropItem.godisable, not isCanUse)

		local isSelectedSkillProp = false

		if isCanUse then
			local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

			isSelectedSkillProp = selectedSkillPropId == skillPropId and selectedIsSkill == isSkill
		end

		gohelper.setActive(skillPropItem.goselected, isSelectedSkillProp)

		local count = ""

		if not isSkill then
			local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)

			if gameHeroMo then
				count = gameHeroMo:getItemCount(skillPropId)
			end
		end

		skillPropItem.txtnum.text = count
	end
end

function AssassinStealthGameHeroHeadItem:refreshHighlight()
	local isShowHL = AssassinStealthGameModel.instance:getIsShowHeroHighlight()

	gohelper.setActive(self._gohl, isShowHL)
end

function AssassinStealthGameHeroHeadItem:playGetItem(uid, newItemDict)
	if not self.uid or self.uid ~= uid then
		return
	end

	self._animator:Play("get", 0, 0)
	self:onSkillPropChange(newItemDict)
end

function AssassinStealthGameHeroHeadItem:onDestroy()
	self.uid = nil
	self._skillPropItemList = nil
end

return AssassinStealthGameHeroHeadItem
