-- chunkname: @modules/logic/weekwalk/view/WeekWalkTarotItem.lua

module("modules.logic.weekwalk.view.WeekWalkTarotItem", package.seeall)

local WeekWalkTarotItem = class("WeekWalkTarotItem", ListScrollCellExtend)

function WeekWalkTarotItem:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#simage_bg/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#simage_bg/#txt_desc")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_bg/#btn_click")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tip/#btn_closetip")
	self._txtheronamecn = gohelper.findChildText(self.viewGO, "#go_tip/#txt_heronamecn")
	self._txtheronameen = gohelper.findChildText(self.viewGO, "#go_tip/#txt_heronamecn/#txt_heronameen")
	self._txteffect = gohelper.findChildText(self.viewGO, "#go_tip/#scroll_effects/Viewport/Content/#txt_effect")
	self._goattreffect = gohelper.findChild(self.viewGO, "#go_tip/#go_attreffect")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_tip/#go_attreffect/#go_attritem")
	self._scrolleffects = gohelper.findChildScrollRect(self.viewGO, "#go_tip/#scroll_effects")
	self._txtdesitem = gohelper.findChildText(self.viewGO, "#go_tip/#scroll_effects/Viewport/Content/#txt_desitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkTarotItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)

	if self._btnclosetip then
		self._btnclosetip:AddClickListener(self._btnclosetipOnClick, self)
	end
end

function WeekWalkTarotItem:removeEvents()
	self._btnclick:RemoveClickListener()

	if self._btnclosetip then
		self._btnclosetip:RemoveClickListener()
	end
end

function WeekWalkTarotItem:_btnclosetipOnClick()
	gohelper.setActive(self._gotip, false)
end

function WeekWalkTarotItem:_btnclickOnClick()
	if self._isSelectTarotView then
		self._callback(self._callbackObj, self)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)
	elseif self._config.type == WeekWalkEnum.BuffType.Pray then
		self:_showPrayInfo()
	end
end

function WeekWalkTarotItem:_showPrayInfo()
	local prayInfo = WeekWalkModel.instance:getInfo():getPrayInfo()

	if not prayInfo then
		return
	end

	gohelper.setActive(self._gotip, true)

	local heroCfg = HeroConfig.instance:getHeroCO(prayInfo.blessingHeroId)

	self._txtheronamecn.text = heroCfg.name
	self._txtheronameen.text = heroCfg.nameEng

	self:_initParams()
	self:_showEffect(prayInfo.sacrificeHeroId)
end

function WeekWalkTarotItem:_editableInitView()
	self._callback = nil
	self._callbackObj = nil
	self._callbackParam = nil
	self._uimeshGo = gohelper.findChild(self.viewGO, "#simage_bg/mesh")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._canvasgroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.removeUIClickAudio(self._btnclick.gameObject)
end

function WeekWalkTarotItem:_editableAddEvents()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnClickTarot, self._playAnimWhenClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._playAnimWhenEnter, self)
end

function WeekWalkTarotItem:_editableRemoveEvents()
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnClickTarot, self._playAnimWhenClick, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._playAnimWhenEnter, self)
end

function WeekWalkTarotItem:onUpdateMO(mo, isSelectTarotView)
	self.info = mo
	self._isSelectTarotView = isSelectTarotView

	self:_refreshUI()
end

function WeekWalkTarotItem:_refreshUI()
	local config = lua_weekwalk_buff.configDict[self.info.tarotId]

	self._config = config
	self._txtname.text = config.name
	self._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(config.desc, "#924840", "#30466A")
	self._tarotItemBgUrl = self._tarotItemBgUrl or ResUrl.getWeekWalkTarotIcon("k" .. config.rare)

	if self._isSelectTarotView and self._isSelectTarotView == true then
		self:_loadTarotItemBg()
	else
		self._simagebg:LoadImage(self._tarotItemBgUrl)
	end

	self._simageicon:LoadImage(ResUrl.getWeekWalkTarotIcon(tostring(config.icon)))

	self._canvasgroup.interactable = true
end

function WeekWalkTarotItem:_loadTarotItemBg()
	if not self._textureLoader then
		self._textureLoader = MultiAbLoader.New()

		self._textureLoader:addPath(self._tarotItemBgUrl)
		self._textureLoader:startLoad(self._loadTarotItemBgCB, self)
	end
end

function WeekWalkTarotItem:_loadTarotItemBgCB()
	local textureItem = self._textureLoader:getAssetItem(self._tarotItemBgUrl)

	self._uimeshGo:GetComponent(typeof(UIMesh)).texture = textureItem:GetResource(self._tarotItemBgUrl)

	local meshAnim = self._uimeshGo.gameObject:GetComponent(typeof(UnityEngine.Animation))

	meshAnim.enabled = true
end

function WeekWalkTarotItem:setClickCallback(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
end

function WeekWalkTarotItem:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageicon:UnLoadImage()

	if self._textureLoader then
		self._textureLoader:dispose()

		self._textureLoader = nil
	end
end

function WeekWalkTarotItem:_initParams()
	local tarotId = self.info.tarotId

	if tarotId == self._buffId then
		return
	end

	self._buffId = tarotId
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

function WeekWalkTarotItem:_showEffect(heroId)
	if heroId == self._sacrificeHeroId then
		return
	end

	self._sacrificeHeroId = heroId

	local targetHeroInfo = HeroModel.instance:getByHeroId(heroId)

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
					local co = HeroConfig.instance:getHeroAttributeCO(id)
					local attributeItem = self:_getAttributeItem(i)

					gohelper.setActive(attributeItem.go, true)

					local iconName = "icon_att_" .. tostring(id)

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
				for k, des in ipairs(effectDesTab) do
					local go = gohelper.cloneInPlace(self._txtdesitem.gameObject, "des_" .. k)

					gohelper.setActive(go, true)

					go:GetComponent(gohelper.Type_TextMesh).text = des
				end
			end
		end

		gohelper.setActive(self._scrolleffects.gameObject, targetHeroInfo and type == WeekWalkEnum.SacrificeEffectType.PassiveSkill)
		gohelper.setActive(self._goattreffect, targetHeroInfo and type ~= WeekWalkEnum.SacrificeEffectType.PassiveSkill)
	end
end

function WeekWalkTarotItem:_getAttributeItem(index)
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

function WeekWalkTarotItem:_showAttribute(attributeItem, name, iconName, value, isShowPercent)
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

function WeekWalkTarotItem:_playAnimWhenClick(clicker)
	if self.viewGO == clicker then
		self._anim:Play(UIAnimationName.Selected, 0, 0)
	else
		self._anim:Play("out", 0, 0)
	end

	self._canvasgroup.interactable = false
end

function WeekWalkTarotItem:_playAnimWhenEnter(viewName)
	if viewName == ViewName.WeekWalkBuffBindingView then
		self._anim:Play("in", 0, 0)

		self._canvasgroup.interactable = true
	end
end

function WeekWalkTarotItem:_getEffectDesc(effectInfo)
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

return WeekWalkTarotItem
