-- chunkname: @modules/logic/character/view/CharacterRankUpResultView.lua

module("modules.logic.character.view.CharacterRankUpResultView", package.seeall)

local CharacterRankUpResultView = class("CharacterRankUpResultView", BaseView)

function CharacterRankUpResultView:onInitView()
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")
	self._simagecenterbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_centerbg")
	self._gospine = gohelper.findChild(self.viewGO, "spineContainer/#go_spine")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._goranknormal = gohelper.findChild(self.viewGO, "rank/#go_ranknormal")
	self._goimagemask = gohelper.findChild(self.viewGO, "#scroll_info/image_mask")
	self._goeffect = gohelper.findChild(self.viewGO, "#scroll_info/viewport/#go_effect")
	self._golevel = gohelper.findChild(self._goeffect, "#go_level")
	self._goskill = gohelper.findChild(self._goeffect, "#go_skill")
	self._txttalentlevel = gohelper.findChildText(self._goeffect, "#go_talentlevel")
	self._txtskillRankUp = gohelper.findChildText(self._goeffect, "#go_skill/#txt_skillRankUp")
	self._txtskillDetail = gohelper.findChildText(self._goeffect, "#go_skill/skilldetail/#txt_skillDetail")
	self._goattribute = gohelper.findChild(self._goeffect, "#go_attribute")
	self._goattributedetail = gohelper.findChild(self._goeffect, "#go_attribute/#go_attributedetail")
	self._btnheroDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_heroDetail")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRankUpResultView:addEvents()
	self._btnheroDetail:AddClickListener(self._btnheroDetailOnClick, self)
end

function CharacterRankUpResultView:removeEvents()
	self._btnheroDetail:RemoveClickListener()
end

CharacterRankUpResultView.characterTalentLevel = {
	[2] = 10,
	[3] = 15
}

function CharacterRankUpResultView:_btnheroDetailOnClick()
	local co = SkinConfig.instance:getSkinCo(self._skinId)

	CharacterController.instance:openCharacterSkinFullScreenView(co, true)
end

function CharacterRankUpResultView:_editableInitView()
	self._simagecenterbg:LoadImage(ResUrl.getCharacterIcon("guang_005"))

	self._txtlevel = gohelper.findChildText(self._goeffect, "#go_level")
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
	self._uiSpine:useRT()

	self._rareGos = self:getUserDataTb_()
	self._norrank = {}
	self._norrank.insights = {}

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._goranknormal, "insightlight" .. tostring(i))
		o.lights = {}

		for j = 1, i do
			table.insert(o.lights, gohelper.findChild(o.go, "star" .. j))
		end

		self._norrank.insights[i] = o
		self._rareGos[i] = gohelper.findChild(self._txtskillDetail.gameObject, "rare" .. i)
	end

	self._norrank.eyes = self:getUserDataTb_()

	for i = 1, 2 do
		table.insert(self._norrank.eyes, gohelper.findChild(self._goranknormal, "eyes/eye" .. tostring(i)))
	end

	self._attributeItems = self:getUserDataTb_()

	for i = 1, 5 do
		local item = {}

		item.go = gohelper.findChild(self._goattributedetail, "attributeItem" .. i)
		item.icon = gohelper.findChildImage(item.go, "image_icon")
		item.preNumTxt = gohelper.findChildText(item.go, "txt_prevnum")
		item.curNumTxt = gohelper.findChildText(item.go, "txt_nextnum")

		table.insert(self._attributeItems, item)
	end

	self:_initSpecialEffectItem()
end

function CharacterRankUpResultView:_initSpecialEffectItem()
	self._specialEffectItem = self:getUserDataTb_()

	local specailEffectItemGo = gohelper.findChild(self._goeffect, "#go_SpecialEffect")
	local item = self:getUserDataTb_()

	item.go = specailEffectItemGo
	item.txt = gohelper.findChildText(specailEffectItemGo, "#txt_SpecialEffect")
	self._specialEffectItem[1] = item

	gohelper.setSibling(item.go, 0)

	local item1 = self:getUserDataTb_()

	item1.go = gohelper.cloneInPlace(specailEffectItemGo)
	item1.txt = gohelper.findChildText(item1.go, "#txt_SpecialEffect")

	gohelper.setSibling(item1.go, 1)

	self._specialEffectItem[2] = item1
end

function CharacterRankUpResultView:onUpdateParam()
	return
end

function CharacterRankUpResultView:onOpen()
	self.heroMo = HeroModel.instance:getByHeroId(self.viewParam)

	self:_refreshView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self:_showMask()
end

function CharacterRankUpResultView:_showMask()
	if self.heroMo and CharacterVoiceEnum.RankUpResultShowMask[self.heroMo.heroId] then
		gohelper.setActive(self._goimagemask, true)

		return
	end

	gohelper.setActive(self._goimagemask, false)
end

function CharacterRankUpResultView:_onOpenViewFinish(viewName)
	if viewName == ViewName.CharacterSkinFullScreenView and self._uiSpine then
		self._uiSpine:hideModelEffect()
	end
end

function CharacterRankUpResultView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CharacterSkinFullScreenView and self._uiSpine then
		self._uiSpine:showModelEffect()
	end
end

function CharacterRankUpResultView:_refreshView()
	self:_refreshSpine()
	self:_refreshRank()
	self:_refreshEffect()
	self:_refreshAttribute()
end

function CharacterRankUpResultView:_refreshSpine()
	local skinCo = SkinConfig.instance:getSkinCo(self.heroMo.skin)

	self._uiSpine:setResPath(skinCo, self._onSpineLoaded, self)

	local offsetStr = skinCo.characterRankUpViewOffset
	local offsets

	if string.nilorempty(offsetStr) then
		offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)

		local constVal = CommonConfig.instance:getConstStr(ConstEnum.CharacterTitleViewOffset)
		local characterTitleViewOffsets = SkinConfig.instance:getSkinOffset(constVal)

		offsets[1] = offsets[1] + characterTitleViewOffsets[1]
		offsets[2] = offsets[2] + characterTitleViewOffsets[2]
		offsets[3] = offsets[3] + characterTitleViewOffsets[3]
	else
		offsets = SkinConfig.instance:getSkinOffset(offsetStr)
	end

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterRankUpResultView:_refreshRank()
	local rank = self.heroMo.rank
	local target = HeroConfig.instance:getMaxRank(self.heroMo.config.rare)

	for i = 1, 3 do
		gohelper.setActive(self._norrank.insights[i].go, target == i)

		for j = 1, i do
			if j <= rank - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(self._norrank.insights[i].lights[j]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(self._norrank.insights[i].lights[j]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(self._norrank.eyes[1], target ~= rank - 1)
	gohelper.setActive(self._norrank.eyes[2], target == rank - 1)
end

function CharacterRankUpResultView:_refreshEffect()
	local rankCo = SkillConfig.instance:getherorankCO(self.heroMo.heroId, self.heroMo.rank)

	if not rankCo or rankCo.effects == "" then
		gohelper.setActive(self._goeffect, false)

		return
	end

	gohelper.setActive(self._goeffect, true)
	gohelper.setActive(self._txttalentlevel.gameObject, false)
	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._goskill, false)
	gohelper.setActive(self._btnheroDetail.gameObject, false)

	local effects = string.split(rankCo.effect, "|")

	for i = 1, #effects do
		local effect = string.splitToNumber(effects[i], "#")

		if effect[1] == 1 then
			gohelper.setActive(self._golevel, true)

			local showLevel = HeroConfig.instance:getShowLevel(tonumber(effect[2]))
			local tag = {
				self.heroMo.config.name,
				showLevel
			}

			self._txtlevel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankupresult_levellimit"), tag)
		elseif effect[1] == 2 then
			gohelper.setActive(self._goskill, true)

			local maxPassiveLv = CharacterModel.instance:getMaxUnlockPassiveLevel(self.heroMo.heroId)
			local passiveCoSkillDict = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(self.heroMo.heroId, self.heroMo.exSkillLevel)

			for _, v in pairs(self._rareGos) do
				gohelper.setActive(v, false)
			end

			gohelper.setActive(self._rareGos[maxPassiveLv], true)

			local skillCo = lua_skill.configDict[passiveCoSkillDict[1].skillPassive]

			if skillCo then
				if not skillCo.name then
					local skillname = ""

					self._txtskillRankUp.text = string.format(luaLang("character_rankupresult_skill"), tostring(skillname))

					local skillId = passiveCoSkillDict[maxPassiveLv].skillPassive
					local desc = FightConfig.instance:getSkillEffectDesc(self.heroMo:getHeroName(), lua_skill.configDict[skillId])

					self._txtskillDetail.text = HeroSkillModel.instance:skillDesToSpot(desc, "#CE9358", "#CE9358")
				end
			end
		elseif effect[1] == 3 then
			gohelper.setActive(self._btnheroDetail.gameObject, true)

			self._skinId = effect[2]
		end
	end

	local ranklevel = self.heroMo.rank - 1

	gohelper.setActive(self._txttalentlevel.gameObject, ranklevel > 1)

	if ranklevel > 1 then
		local formatStr = luaLang("talent_characterrankup_talentlevellimit" .. self.heroMo:getTalentTxtByHeroType())

		self._txttalentlevel.text = string.format(formatStr, CharacterRankUpResultView.characterTalentLevel[ranklevel])
	end

	self:_cheskExtra()
	self:_refreshSpecialEffect()
end

function CharacterRankUpResultView:_cheskExtra()
	if self.heroMo.extraMo then
		local showTxt
		local mo = self.heroMo.extraMo:getSkillTalentMo()

		if mo then
			showTxt = mo:getUnlockRankStr(self.heroMo.rank)
		end

		if self.heroMo.extraMo:hasWeapon() then
			local mo = self.heroMo.extraMo:getWeaponMo()

			if mo then
				showTxt = mo:getUnlockRankStr(self.heroMo.rank)
			end
		end

		if showTxt then
			for i, txt in ipairs(showTxt) do
				self._txtextra = self._txtextra or self:getUserDataTb_()

				if not self._txtextra[i] then
					local go = gohelper.cloneInPlace(self._txtlevel.gameObject, "extra")

					self._txtextra[i] = go:GetComponent(typeof(TMPro.TMP_Text))
				end

				self._txtextra[i].text = txt
			end
		end
	end
end

function CharacterRankUpResultView:_refreshSpecialEffect()
	local descList = CharacterModel.instance:getSpecialEffectDesc(self.heroMo.skin, self.heroMo.rank - 1)
	local count = 0

	if descList then
		for i, desc in ipairs(descList) do
			self._specialEffectItem[i].txt.text = desc
			count = count + 1
		end
	end

	for i = 1, #self._specialEffectItem do
		gohelper.setActive(self._specialEffectItem[i].go, i <= count)
	end
end

function CharacterRankUpResultView:_refreshAttribute()
	local totals = self:getCurrentHeroAttribute()
	local preTotals = self:getHeroPreAttribute()

	for index, attrItem in ipairs(self._attributeItems) do
		UISpriteSetMgr.instance:setCommonSprite(attrItem.icon, "icon_att_" .. CharacterEnum.BaseAttrIdList[index])

		attrItem.preNumTxt.text = preTotals[index]
		attrItem.curNumTxt.text = totals[index]
	end
end

function CharacterRankUpResultView:getHeroPreAttribute()
	return self:_getHeroAttribute(self.heroMo.level - 1, self.heroMo.rank - 1)
end

function CharacterRankUpResultView:getCurrentHeroAttribute()
	return self:_getHeroAttribute()
end

function CharacterRankUpResultView:_getHeroAttribute(level, rankLevel)
	level = level or self.heroMo.level
	rankLevel = rankLevel or self.heroMo.rank

	local equipUidList

	return self.heroMo:getTotalBaseAttrList((self.heroMo:hasDefaultEquip() or nil) and {
		self.heroMo.defaultEquipUid
	}, level, rankLevel)
end

function CharacterRankUpResultView:onClose()
	self._simagecenterbg:UnLoadImage()
	self._uiSpine:setModelVisible(false)
end

function CharacterRankUpResultView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

return CharacterRankUpResultView
