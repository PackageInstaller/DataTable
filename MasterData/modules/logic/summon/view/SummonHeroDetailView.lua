-- chunkname: @modules/logic/summon/view/SummonHeroDetailView.lua

module("modules.logic.summon.view.SummonHeroDetailView", package.seeall)

local SummonHeroDetailView = class("SummonHeroDetailView", BaseView)

function SummonHeroDetailView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simageredlight = gohelper.findChildSingleImage(self.viewGO, "bg/lightcontainer/#simage_redlight")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._gospecialitem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	self._gofourword = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_fourword")
	self._gothreeword = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_threeword")
	self._gotwoword = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_twoword")
	self._txtlevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._goskill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	self._btnexskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/exskill/#btn_exskill")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	self._btnattribute = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	self._goattribute = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._simagecharacter = gohelper.findChildSingleImage(self.viewGO, "charactercontainer/#simage_character")
	self._gostarList = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_starList")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnuniqueSkill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/#btn_uniqueSkill")
	self._btnrecommed = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_recommed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonHeroDetailView:addEvents()
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self._btnexskill:AddClickListener(self._btnexskillOnClick, self)
	self._btnuniqueSkill:AddClickListener(self._btnuniqueSkillOnClick, self)
	self._btnrecommed:AddClickListener(self._btnrecommedOnClick, self)
end

function SummonHeroDetailView:removeEvents()
	self._btnpassiveskill:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnexskill:RemoveClickListener()
	self._btnuniqueSkill:RemoveClickListener()
	self._btnrecommed:RemoveClickListener()
end

SummonHeroDetailView.HpAttrId = 101
SummonHeroDetailView.AttackAttrId = 102
SummonHeroDetailView.DefenseAttrId = 103
SummonHeroDetailView.MdefenseAttrId = 104
SummonHeroDetailView.TechnicAttrId = 105

function SummonHeroDetailView:_btnpassiveskillOnClick()
	local info = {}

	info.tag = "passiveskill"
	info.heroid = self._heroId
	info.tipPos = Vector2.New(909, -13.8)
	info.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}
	info.buffTipsX = 1666
	info.showAttributeOption = CharacterEnum.showAttributeOption.ShowMin

	CharacterController.instance:openCharacterTipView(info)
end

function SummonHeroDetailView:_btnattributeOnClick()
	local info = {}

	info.tag = "attribute"
	info.heroid = self._heroId
	info.showAttributeOption = CharacterEnum.showAttributeOption.ShowMin

	CharacterController.instance:openCharacterTipView(info)
end

function SummonHeroDetailView:_btnexskillOnClick()
	local _tempHeroMO, _params = self:_getReplaceSkillHeroMO(self._heroId, self._skinId)

	CharacterController.instance:openCharacterExSkillView({
		fromHeroDetailView = true,
		heroId = self._heroId,
		showAttributeOption = CharacterEnum.showAttributeOption.ShowMin,
		heroMo = _tempHeroMO
	})
end

function SummonHeroDetailView:_btnuniqueSkillOnClick()
	if not self._nextSkillOnClickTime then
		if self._replaceHeroMOParams and self._nextSkillOnClickTime <= Time.time then
			self._replaceHeroMOParams.rank = self._replaceHeroMOParams.rank == self._replaceHeroMOParams.replaceSkillRank and 1 or self._replaceHeroMOParams.replaceSkillRank

			TaskDispatcher.cancelTask(self._onDelayRefeshSkill, self)
			TaskDispatcher.runDelay(self._onDelayRefeshSkill, self, 0.16)

			self._nextSkillOnClickTime = Time.time + 0.2

			self._animator:Play("switch", 0, 0)
		end
	end
end

function SummonHeroDetailView:_btnrecommedOnClick()
	if not self._fromViewName then
		CharacterRecommedController.instance:openRecommedView(self._heroId, self._fromViewName, nil, self._hideTab)
	end
end

function SummonHeroDetailView:_onDelayRefeshSkill()
	self:_refreshSkill(self._heroId)
end

function SummonHeroDetailView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	self._imagecharacter = gohelper.findChildImage(self.viewGO, "charactercontainer/#simage_character")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._careerGOs = {}

	gohelper.setActive(self._gospecialitem, false)
	self._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	for i = 1, 6 do
		self["_gostar" .. i] = gohelper.findChild(self._gostarList, "star" .. i)
	end

	local param = {
		deviceType = 2
	}

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer, param)
	self._attributevalues = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.value = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.name = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/name")
		o.icon = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/icon")
		o.rate = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/rate")

		gohelper.setActive(o.rate.gameObject, false)

		self._attributevalues[i] = o
	end

	self._passiveskillGOs = {}

	for i = 1, 3 do
		local passiveSkillGO = self:_findPassiveskillitems(i)

		table.insert(self._passiveskillGOs, passiveSkillGO)
	end

	self._passiveskillGOs[0] = self:_findPassiveskillitems(4)
end

function SummonHeroDetailView:_findPassiveskillitems(index)
	return (gohelper.findChild(self._gopassiveskills, "passiveskill" .. index))
end

function SummonHeroDetailView:_refreshUI()
	gohelper.setActive(self._btnuniqueSkill, self._replaceHeroMOParams)
	self:_refreshHero(self._heroId)
	self:_refreshSkin(self._skinId)

	local isShowRecommed = false
	local isOpenSummonView = ViewMgr.instance:isOpen(ViewName.SummonADView)

	if isOpenSummonView then
		local isShowRecommedView = CharacterRecommedModel.instance:isShowRecommedView(self._heroId)

		if self.viewParam.formView then
			local isFormRecommedView = self.viewParam.formView == ViewName.CharacterRecommedView

			isShowRecommed = isShowRecommedView and not isFormRecommedView
		end
	end

	isShowRecommed = isShowRecommed or not not self._isShowRecommed

	gohelper.setActive(self._btnrecommed.gameObject, isShowRecommed)
end

function SummonHeroDetailView:_getSkinId()
	local rank = CharacterModel.instance:getMaxRank(self._heroId)

	for i = rank, 1, -1 do
		local effCo = GameUtil.splitString2(SkillConfig.instance:getherorankCO(self._heroId, i).effect, true, "|", "#")

		for _, v in pairs(effCo) do
			if tonumber(v[1]) == 3 then
				return tonumber(v[2])
			end
		end
	end

	return nil
end

function SummonHeroDetailView:_refreshHero(heroId)
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	for i = 1, 6 do
		gohelper.setActive(self["_gostar" .. i], i <= CharacterEnum.Star[heroConfig.rare])
	end

	self._txtname.text = heroConfig.name
	self._txtnameen.text = heroConfig.nameEng

	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareericon, "charactercareer" .. tostring(heroConfig.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(heroConfig.dmgType))

	local maxRank = CharacterModel.instance:getMaxRank(heroId)
	local maxLevel = CharacterModel.instance:getrankEffects(heroId, maxRank)[1]
	local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

	self._txtlevel.text = string.format("%d/%d", showMaxLevel, showMaxLevel)

	self:_refreshSpecial(heroId, heroConfig)
	self:_refreshSkill(heroId)
	self:_refreshPassiveSkill(heroId, heroConfig)
	self:_refreshAttribute(heroId, heroConfig)
end

function SummonHeroDetailView:_refreshSpecial(heroId, heroConfig)
	local tags = {}

	if not string.nilorempty(heroConfig.battleTag) then
		tags = string.split(heroConfig.battleTag, "#")
	end

	for i = 1, #tags do
		local careerTable = self._careerGOs[i]

		if not careerTable then
			careerTable = self:getUserDataTb_()
			careerTable.go = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)
			careerTable.textfour = gohelper.findChildText(careerTable.go, "#go_fourword/name")
			careerTable.textthree = gohelper.findChildText(careerTable.go, "#go_threeword/name")
			careerTable.texttwo = gohelper.findChildText(careerTable.go, "#go_twoword/name")
			careerTable.containerfour = gohelper.findChild(careerTable.go, "#go_fourword")
			careerTable.containerthree = gohelper.findChild(careerTable.go, "#go_threeword")
			careerTable.containertwo = gohelper.findChild(careerTable.go, "#go_twoword")

			table.insert(self._careerGOs, careerTable)
		end

		local desc = HeroConfig.instance:getBattleTagConfigCO(tags[i]).tagName
		local wordCount = GameUtil.utf8len(desc)

		gohelper.setActive(careerTable.containertwo, wordCount <= 2)
		gohelper.setActive(careerTable.containerthree, wordCount == 3)
		gohelper.setActive(careerTable.containerfour, wordCount >= 4)

		if wordCount <= 2 then
			careerTable.texttwo.text = desc
		elseif wordCount == 3 then
			careerTable.textthree.text = desc
		else
			careerTable.textfour.text = desc
		end

		gohelper.setActive(careerTable.go, true)
	end

	for i = #tags + 1, #self._careerGOs do
		gohelper.setActive(self._careerGOs[i].go, false)
	end
end

function SummonHeroDetailView:_refreshSkill(heroId)
	self._skillContainer:onUpdateMO(heroId, CharacterEnum.showAttributeOption.ShowMin, self._tempHeroMO)
end

function SummonHeroDetailView:_refreshPassiveSkill(heroId, heroConfig)
	local pskills = SkillConfig.instance:getpassiveskillsCO(heroId)
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local passiveSkillConfig = lua_skill.configDict[skillId]

	if not passiveSkillConfig then
		logError("找不到角色被动技能, skillId: " .. tostring(skillId))
	end

	self._txtpassivename.text = passiveSkillConfig.name

	for i = 1, #self._passiveskillGOs do
		gohelper.setActive(self._passiveskillGOs[i], i <= #pskills)
	end

	gohelper.setActive(self._passiveskillGOs[0], pskills[0] and true or false)
end

function SummonHeroDetailView:_refreshAttribute(heroId, heroConfig)
	local ids = {
		SummonHeroDetailView.HpAttrId,
		SummonHeroDetailView.DefenseAttrId,
		SummonHeroDetailView.TechnicAttrId,
		SummonHeroDetailView.MdefenseAttrId,
		SummonHeroDetailView.AttackAttrId
	}

	for i = 1, 5 do
		local co = HeroConfig.instance:getHeroAttributeCO(ids[i])

		self._attributevalues[i].name.text = co.name

		CharacterController.instance:SetAttriIcon(self._attributevalues[i].icon, ids[i], GameUtil.parseColor("#9b795e"))
	end

	local lvCo = SkillConfig.instance:getherolevelCO(heroId, 1)

	self._attributevalues[1].value.text = lvCo.hp
	self._attributevalues[2].value.text = lvCo.def
	self._attributevalues[3].value.text = lvCo.technic
	self._attributevalues[4].value.text = lvCo.mdef
	self._attributevalues[5].value.text = lvCo.atk
end

function SummonHeroDetailView:_getLevel1Atrributes()
	local level = 1
	local lvCo = SkillConfig.instance:getherolevelCO(self._heroId, level)

	return {
		[SummonHeroDetailView.HpAttrId] = lvCo.hp,
		[SummonHeroDetailView.AttackAttrId] = lvCo.atk,
		[SummonHeroDetailView.DefenseAttrId] = lvCo.def,
		[SummonHeroDetailView.MdefenseAttrId] = lvCo.mdef,
		[SummonHeroDetailView.TechnicAttrId] = lvCo.technic
	}
end

function SummonHeroDetailView:_getAttributeRates(baseAttributes)
	local growCo = SkillConfig.instance:getGrowCo()
	local stages = {
		[SummonHeroDetailView.HpAttrId] = {},
		[SummonHeroDetailView.AttackAttrId] = {},
		[SummonHeroDetailView.DefenseAttrId] = {},
		[SummonHeroDetailView.MdefenseAttrId] = {},
		[SummonHeroDetailView.TechnicAttrId] = {}
	}

	for i = 1, 8 do
		table.insert(stages[SummonHeroDetailView.AttackAttrId], growCo[i].atk)
		table.insert(stages[SummonHeroDetailView.HpAttrId], growCo[i].hp)
		table.insert(stages[SummonHeroDetailView.DefenseAttrId], growCo[i].def)
		table.insert(stages[SummonHeroDetailView.MdefenseAttrId], growCo[i].mdef)
		table.insert(stages[SummonHeroDetailView.TechnicAttrId], growCo[i].technic)
	end

	return {
		[SummonHeroDetailView.HpAttrId] = self:_countRate(baseAttributes[SummonHeroDetailView.HpAttrId], stages[SummonHeroDetailView.HpAttrId], 8),
		[SummonHeroDetailView.AttackAttrId] = self:_countRate(baseAttributes[SummonHeroDetailView.AttackAttrId], stages[SummonHeroDetailView.AttackAttrId], 8),
		[SummonHeroDetailView.DefenseAttrId] = self:_countRate(baseAttributes[SummonHeroDetailView.DefenseAttrId], stages[SummonHeroDetailView.DefenseAttrId], 8),
		[SummonHeroDetailView.MdefenseAttrId] = self:_countRate(baseAttributes[SummonHeroDetailView.MdefenseAttrId], stages[SummonHeroDetailView.MdefenseAttrId], 8),
		[SummonHeroDetailView.TechnicAttrId] = self:_countRate(baseAttributes[SummonHeroDetailView.TechnicAttrId], stages[SummonHeroDetailView.TechnicAttrId], 8)
	}
end

function SummonHeroDetailView:_countRate(baseCo, attr, max)
	for i = 1, max - 1 do
		if baseCo < attr[i + 1] then
			return i
		end
	end

	return max
end

function SummonHeroDetailView:_refreshSkin(skinId)
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	if not skinConfig then
		logError("没有找到配置, skinId: " .. tostring(skinId))

		return
	end

	local haloOffset = SkinConfig.instance:getSkinOffset(skinConfig.haloOffset)
	local haloX = tonumber(haloOffset[1])
	local haloY = tonumber(haloOffset[2])
	local haloScale = tonumber(haloOffset[3])

	recthelper.setAnchor(self._simageredlight.transform, haloX, haloY)
	transformhelper.setLocalScale(self._simageredlight.transform, haloScale, haloScale, haloScale)

	self._skinConfig = skinConfig

	self._simagecharacter:LoadImage(ResUrl.getHeadIconImg(skinConfig.drawing), self._onImageLoaded, self)

	if self._skinColorStr then
		SLFramework.UGUI.GuiHelper.SetColor(self._imagecharacter, self._skinColorStr)
	end
end

function SummonHeroDetailView:_onImageLoaded()
	ZProj.UGUIHelper.SetImageSize(self._simagecharacter.gameObject)

	local offsets = SkinConfig.instance:getSkinOffset(self._skinConfig.summonHeroViewOffset)

	recthelper.setAnchor(self._simagecharacter.transform.parent, offsets[1], offsets[2])
	transformhelper.setLocalScale(self._simagecharacter.transform.parent, offsets[3], offsets[3], offsets[3])
end

function SummonHeroDetailView:_initViewParam()
	self._hideTab = self.viewParam.hideTab
	self._fromViewName = self.viewParam.fromView
	self._isShowRecommed = self.viewParam.isShowRecommed
	self._characterDetailId = self.viewParam.id
	self._heroId = self.viewParam.heroId
	self._skinId = self.viewParam.skinId
	self._skinColorStr = self.viewParam.skinColorStr or "#FFFFFF"

	if self._skinId == nil then
		if self._heroId then
			local heroCO = HeroConfig.instance:getHeroCO(self._heroId)

			self._skinId = self:_getSkinId() or heroCO.skinId
		end

		if self._characterDetailId then
			local characterDetailConfig = SummonConfig.instance:getCharacterDetailConfig(self._characterDetailId)

			self._heroId = characterDetailConfig.heroId
			self._skinId = self:_getSkinId() or characterDetailConfig.skinId
		end
	end

	self._tempHeroMO, self._replaceHeroMOParams = self:_getReplaceSkillHeroMO(self._heroId, self._skinId)
end

function SummonHeroDetailView:_getReplaceSkillHeroMO(heroId, skinId)
	local rank = CharacterModel.instance:getReplaceSkillRankBySkinId(skinId)

	if not rank or rank <= 1 then
		return
	end

	local heroMO = HeroModel.instance:getByHeroId(heroId)

	if not heroMO then
		local config = HeroConfig.instance:getHeroCO(heroId)

		if config then
			heroMO = HeroMo.New()

			heroMO:initFromConfig(config)
		end
	end

	if heroMO then
		local mergeInfo = {
			rank = rank,
			replaceSkillRank = rank
		}

		return RoomHelper.mergeCfg(heroMO, mergeInfo), mergeInfo
	end
end

function SummonHeroDetailView:onUpdateParam()
	self:_initViewParam()
	self:_refreshUI()
	self:_statEnterView(self._heroId)
end

function SummonHeroDetailView:onOpen()
	self:_initViewParam()
	self:_refreshUI()
	self:_statEnterView(self._heroId)
end

function SummonHeroDetailView:onClose()
	return
end

function SummonHeroDetailView:onDestroyView()
	self._simageredlight:UnLoadImage()
	self._simagebg:UnLoadImage()
end

function SummonHeroDetailView:_statEnterView(heroId)
	if self._lasHeroId == heroId then
		return
	end

	self._lasHeroId = heroId

	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if heroCfg then
		local chineseViewNameStr = (StatViewNameEnum.ChineseViewName[self.viewName] or self.viewName) .. "-" .. (heroCfg.name or "")

		StatViewController.instance:trackViewName(chineseViewNameStr)
	end
end

return SummonHeroDetailView
