-- chunkname: @modules/logic/weekwalk/view/WeekWalkBuffBindingView.lua

module("modules.logic.weekwalk.view.WeekWalkBuffBindingView", package.seeall)

local WeekWalkBuffBindingView = class("WeekWalkBuffBindingView", BaseView)

function WeekWalkBuffBindingView:onInitView()
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goadventuretarotitem = gohelper.findChild(self.viewGO, "#go_adventuretarotitem")
	self._goselectheroitem1 = gohelper.findChild(self.viewGO, "#go_selectheroitem1")
	self._goselectheroitem2 = gohelper.findChild(self.viewGO, "#go_selectheroitem2")
	self._txteffect = gohelper.findChildText(self.viewGO, "#scroll_effects/Viewport/Content/#txt_effect")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._goattreffect = gohelper.findChild(self.viewGO, "#go_attreffect")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_attreffect/#go_attritem")
	self._scrolleffects = gohelper.findChildScrollRect(self.viewGO, "#scroll_effects")
	self._txtdesitem = gohelper.findChildText(self.viewGO, "#scroll_effects/Viewport/Content/#txt_desitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkBuffBindingView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function WeekWalkBuffBindingView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function WeekWalkBuffBindingView:_btncancelOnClick()
	self:closeThis()
end

function WeekWalkBuffBindingView:_btnconfirmOnClick()
	if not self._hero1Info then
		GameFacade.showToast(ToastEnum.WeekWalkBuffBinding1)

		return
	end

	if not self._hero2Info then
		GameFacade.showToast(ToastEnum.WeekWalkBuffBinding2)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkPray, MsgBoxEnum.BoxType.Yes_No, function()
		WeekwalkRpc.instance:sendWeekwalkBuffRequest(self._buffId, self._hero1Info.heroId, self._hero2Info.heroId)
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnConfirmBindingBuff)
	end, nil, nil, nil, nil, nil, self._hero1Info.config.name, self._hero2Info.config.name)
end

function WeekWalkBuffBindingView:_editableInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))
	HeroGroupEditListModel.instance:setParam(nil, WeekWalkModel.instance:getInfo())
	gohelper.addUIClickAudio(self._btnconfirm.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(self._btncancel.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function WeekWalkBuffBindingView:onUpdateParam()
	return
end

function WeekWalkBuffBindingView:_initHeroItems()
	self._heroItem1 = IconMgr.instance:getCommonHeroItem(self._goselectheroitem1)

	gohelper.setActive(self._heroItem1.go, false)
	self._heroItem1:setLevelContentShow(false)
	self._heroItem1:setNameContentShow(false)
	self._heroItem1:addEventListeners()
	self._heroItem1:addClickListener(self._onHeroItem1Click, self)
	self._heroItem1:setStyle_CharacterBackpack()

	self._hero1Info = nil
	self._heroItem2 = IconMgr.instance:getCommonHeroItem(self._goselectheroitem2)

	gohelper.setActive(self._heroItem2.go, false)
	self._heroItem2:setLevelContentShow(false)
	self._heroItem2:setNameContentShow(false)
	self._heroItem2:addEventListeners()
	self._heroItem2:addClickListener(self._onHeroItem2Click, self)
	self._heroItem2:setStyle_CharacterBackpack()

	self._hero2Info = nil
end

function WeekWalkBuffBindingView:_onHeroItem1Click(heroInfo)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	self._hero1Info = nil

	self:_selectHeroitem()
	self:_showEffect()
end

function WeekWalkBuffBindingView:_onHeroItem2Click(heroInfo)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	self._hero2Info = nil

	self:_selectHeroitem()
end

function WeekWalkBuffBindingView:_initParams()
	self._buffId = self.viewParam.tarotId
	self._buffConfig = lua_weekwalk_buff.configDict[self._buffId]
	self._prayId = tonumber(self._buffConfig.param)
	self._prayConfig = lua_weekwalk_pray.configDict[self._prayId]
	self._sacrificeLimitLevel = 0
	self._sacrificeLimitCareer = 0
	self._sacrificeLimitHeroId = 0

	local limitList = GameUtil.splitString2(self._prayConfig.sacrificeLimit, true, "|", "#")

	if limitList then
		for i, v in ipairs(limitList) do
			local id = v[1]
			local value = v[2]

			if id == 1 then
				self._sacrificeLimitCareer = value
			elseif id == 2 then
				self._sacrificeLimitLevel = value
			elseif id == 3 then
				self._sacrificeLimitHeroId = value
			end
		end
	end

	self._blessingLimit = self._prayConfig.blessingLimit == "1"
	self._effectMap = {}

	local effectList = GameUtil.splitString2(self._prayConfig.effect, true, "|", "#")

	for i, v in ipairs(effectList) do
		local type = v[1]
		local value1 = v[2]
		local value2 = v[3]

		if type == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			self._effectMap[type] = value1 / 1000
		elseif type == WeekWalkEnum.SacrificeEffectType.ExAttr then
			self._effectMap[type] = {
				value1,
				value2 / 1000
			}
		elseif type == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			self._effectMap[type] = value1
		end
	end
end

function WeekWalkBuffBindingView:onOpen()
	self:_initParams()
	self:_initHeroItems()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.TarotReply, self._onTarotReply, self)
	self:_onHeroItemClick(nil)
end

function WeekWalkBuffBindingView:_updateCardList()
	if not self._hero1Info or self._hero2Info and self._lastSetHeroInfo == self._hero1Info then
		self._selectHero1 = true

		WeekWalkCardListModel.instance:setCardList(self._sacrificeLimitCareer, self._sacrificeLimitLevel, self._hero1Info, self._hero2Info, self._sacrificeLimitHeroId)

		return
	end

	if not self._hero2Info or self._lastSetHeroInfo == self._hero2Info then
		local heroConfig = self._hero1Info.config
		local limitCareer = heroConfig.career
		local careerLimit = self._blessingLimit and limitCareer or 0

		self._selectHero1 = false

		WeekWalkCardListModel.instance:setCardList(careerLimit, 0, self._hero1Info, self._hero2Info, 0)
	end
end

function WeekWalkBuffBindingView:_verifyHero2()
	if not self._hero1Info or not self._hero2Info then
		return
	end

	local heroConfig = self._hero1Info.config
	local limitCareer = heroConfig.career
	local careerLimit = self._blessingLimit and limitCareer or 0
	local result = WeekWalkCardListModel.instance:getCardList(careerLimit, 0, self._hero1Info, nil, 0)

	for i, v in ipairs(result) do
		if v == self._hero2Info then
			return
		end
	end

	self._hero2Info = nil
end

function WeekWalkBuffBindingView:_showEffect()
	local targetHeroInfo = self._hero1Info

	for type, v in pairs(self._effectMap) do
		if targetHeroInfo and type == WeekWalkEnum.SacrificeEffectType.BaseAttr then
			local value = v
			local normalids = {
				102,
				101,
				103,
				104,
				105
			}

			for i, id in ipairs(normalids) do
				local attrValue = targetHeroInfo:getAttrValueWithoutTalentByID(id) * value

				attrValue = math.floor(attrValue)

				if attrValue > 0 then
					local co = HeroConfig.instance:getHeroAttributeCO(normalids[i])
					local attributeItem = self:_getAttributeItem(i)

					gohelper.setActive(attributeItem.go, true)

					local iconName = "icon_att_" .. tostring(normalids[i])

					self:_showAttribute(attributeItem, co.name, iconName, attrValue)
				end
			end
		elseif targetHeroInfo and type == WeekWalkEnum.SacrificeEffectType.ExAttr then
			local id = v[1]
			local value = v[2]
			local co = HeroConfig.instance:getHeroAttributeCO(id)
			local gain_tab = targetHeroInfo:getTalentGain()

			gain_tab = HeroConfig.instance:talentGainTab2IDTab(gain_tab)

			local attrValue = gain_tab[co.id]

			if attrValue then
				if not (attrValue.value * value / 10) then
					local attrValueItem = 0
					local attributeItem = self:_getAttributeItem(1)

					gohelper.setActive(attributeItem.go, true)

					local iconName = "icon_att_" .. tostring(co.id)

					self:_showAttribute(attributeItem, co.name, iconName, attrValueItem, true)
				end
			end
		elseif type == WeekWalkEnum.SacrificeEffectType.PassiveSkill then
			local skillId = tonumber(v)
			local desc = lua_skill.configDict[skillId].desc

			self._txteffect.text = HeroSkillModel.instance:skillDesToSpot(desc, "#B64F44", "#3C5784")

			local effectDesTab = self:_getEffectDesc(desc)

			if effectDesTab and #effectDesTab > 0 then
				self._effectDesItems = self._effectDesItems or self:getUserDataTb_()

				for k, des in ipairs(effectDesTab) do
					local item = self._effectDesItems[k]

					if not item then
						local go = gohelper.cloneInPlace(self._txtdesitem.gameObject, "des_" .. k)

						table.insert(self._effectDesItems, go)

						item = go
					end

					gohelper.setActive(item, true)

					item:GetComponent(gohelper.Type_TextMesh).text = des
				end
			end

			if effectDesTab then
				if not (#effectDesTab + 1) then
					local hideIndex = 1

					if self._effectDesItems then
						for i = hideIndex, #self._effectDesItems do
							gohelper.setActive(self._effectDesItems[i], false)
						end
					end
				end
			end
		end

		gohelper.setActive(self._scrolleffects.gameObject, targetHeroInfo and type == WeekWalkEnum.SacrificeEffectType.PassiveSkill)
		gohelper.setActive(self._goattreffect, targetHeroInfo and type ~= WeekWalkEnum.SacrificeEffectType.PassiveSkill)
	end

	if targetHeroInfo and (type == WeekWalkEnum.SacrificeEffectType.ExAttr or type == WeekWalkEnum.SacrificeEffectType.BaseAttr) then
		for i = #self._effectMap + 1, #self._attributeItems do
			gohelper.setActive(self._attributeItems[i], false)
		end
	end
end

function WeekWalkBuffBindingView:_getAttributeItem(index)
	self._attributeItems = self._attributeItems or {}

	local attributeItem = self._attributeItems[index]

	if not attributeItem then
		local item = self:getUserDataTb_()

		item.go = gohelper.cloneInPlace(self._goattritem, "attribute" .. index)
		item.iconImg = gohelper.findChildImage(item.go, "icon")
		item.nameTxt = gohelper.findChildText(item.go, "name")
		item.valueTxt = gohelper.findChildText(item.go, "value")

		table.insert(self._attributeItems, item)

		attributeItem = item
	end

	return attributeItem
end

function WeekWalkBuffBindingView:_showAttribute(attributeItem, name, iconName, value, isShowPercent)
	if not attributeItem then
		return
	end

	attributeItem.nameTxt.text = name

	UISpriteSetMgr.instance:setCommonSprite(attributeItem.iconImg, iconName)

	attributeItem.valueTxt.text = value

	if isShowPercent then
		attributeItem.valueTxt.text = string.format("%s%%", math.floor(value))
	end
end

function WeekWalkBuffBindingView:_selectHeroitem()
	if self._hero1Info then
		self._heroItem1:onUpdateMO(self._hero1Info)
	end

	if self._hero2Info then
		self._heroItem2:onUpdateMO(self._hero2Info)
	end

	gohelper.setActive(self._heroItem1.go, self._hero1Info)
	gohelper.setActive(self._heroItem2.go, self._hero2Info)
	self:_updateCardList()
end

function WeekWalkBuffBindingView:_onTarotReply()
	self:closeThis()
end

function WeekWalkBuffBindingView:_onHeroItemClick(heroMO)
	if heroMO then
		local weekWalkInfo = WeekWalkModel.instance:getInfo()

		if weekWalkInfo:getHeroHp(heroMO.heroId) <= 0 then
			return
		end

		if self._hero1Info and self._hero2Info then
			-- block empty
		end

		if not self._hero1Info or self._selectHero1 then
			self._hero1Info = heroMO

			self:_verifyHero2()
		elseif not self._hero2Info or not self._selectHero1 then
			self._hero2Info = heroMO
		end

		self._lastSetHeroInfo = heroMO
	end

	self:_showEffect()
	self:_selectHeroitem()
end

function WeekWalkBuffBindingView:_getEffectDesc(effectInfo)
	if string.nilorempty(effectInfo) then
		return nil
	end

	local matchTxtTab = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(effectInfo)
	local descTab = {}

	for _, v in ipairs(matchTxtTab) do
		local desc = SkillConfig.instance:processSkillDesKeyWords(SkillConfig.instance:getSkillEffectDescCo(v).desc)
		local name = SkillConfig.instance:processSkillDesKeyWords(SkillConfig.instance:getSkillEffectDescCo(v).name)
		local txt = string.format("[%s]:%s", name, desc)

		txt = HeroSkillModel.instance:skillDesToSpot(txt, "#B64F44", "#3C5784")

		table.insert(descTab, txt)
	end

	return descTab
end

function WeekWalkBuffBindingView:onClose()
	return
end

function WeekWalkBuffBindingView:onDestroyView()
	self._imgBg:UnLoadImage()

	self._attributeItems = nil
end

return WeekWalkBuffBindingView
