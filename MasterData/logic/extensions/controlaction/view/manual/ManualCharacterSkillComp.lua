-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualCharacterSkillComp.lua

module("logic.extensions.controlaction.view.manual.ManualCharacterSkillComp", package.seeall)

local M = class("ManualCharacterSkillComp", ViewComponent)

M.AttrType = {
	Shoot = 3,
	Range = 4,
	CD = 2,
	AtkTyp = 1
}
M.LabelDescType = {
	Enhanced = 2,
	Normal = 1
}

function M:buildUI()
	self._btnMore = self:getBtn("skill_detail_tips_copy_-770463590")
	self._goSkillRoot = self:getGo("skill_detail_tips_copy_-584147505")
	self._canvasGroupSkillRoot = goutil.addComponentOnce(self._goSkillRoot, ComponentType.CanvasGroup)
	self._goBgNormal = self:getGo("skill_detail_tips_copy_2063977072")
	self._txtSkillName = self:getText("skill_detail_tips_copy_1418630815")
	self._infoGroup = {
		[M.AttrType.AtkTyp] = {
			go = self:getGo("skill_detail_tips_copy_645298383"),
			txt = self:getText("skill_detail_tips_copy_17506951"),
			goNone = self:getGo("skill_detail_tips_copy_1656295903")
		},
		[M.AttrType.CD] = {
			go = self:getGo("skill_detail_tips_copy_-895559497"),
			txt = self:getText("skill_detail_tips_copy_-2070803934"),
			goNone = self:getGo("skill_detail_tips_copy_-1654773853")
		},
		[M.AttrType.Shoot] = {
			go = self:getGo("skill_detail_tips_copy_1359722719"),
			txt = self:getText("skill_detail_tips_copy_502515716"),
			goNone = self:getGo("skill_detail_tips_copy_-803013539")
		},
		[M.AttrType.Range] = {
			go = self:getGo("skill_detail_tips_copy_1001525276"),
			txt = self:getText("skill_detail_tips_copy_915438173"),
			goNone = self:getGo("skill_detail_tips_copy_2079986615")
		}
	}

	local lableRoot = self:getUIComponent("skill_detail_tips_copy_-1741863685", UIComponentType.RectTransform)

	self._labelGroup = {
		[M.LabelDescType.Normal] = self:_buildLableCell(lableRoot:GetChild(0).gameObject),
		[M.LabelDescType.Enhanced] = self:_buildLableCell(lableRoot:GetChild(1).gameObject)
	}
	self._btnDesc = UIComponentType.ButtonAdapter(goutil.findChild(lableRoot:GetChild(0).gameObject, "click"))
	self._btnDesc2 = UIComponentType.ButtonAdapter(goutil.findChild(lableRoot:GetChild(1).gameObject, "click"))
	self._rectTrAuthorityLstSample = self:getUIComponent("skill_detail_tips_copy_1616474855", UIComponentType.RectTransform)
	self._rectTrAuthorityLstDetail = self:getUIComponent("skill_detail_tips_copy_1618467739", UIComponentType.RectTransform)
	self._goBuffRoot = self:getGo("skill_detail_tips_copy_-814093050")
	self._goBuffScroll = self:getGo("skill_detail_tips_copy_-2024164705")
	self._goBuffContent = self:getGo("skill_detail_tips_copy_-735610502")
	self._buffTipsItem = self:getGo("label_detail_item_-1126607035")

	goutil.setActive(self._buffTipsItem, false)

	self._txtReshapeBefore = self:getUIComponent("skill_detail_tips_copy_354667501", UIComponentType.TextMeshProUGUI)
	self._txtReshapeAfter = self:getUIComponent("skill_detail_tips_copy_2071903027", UIComponentType.TextMeshProUGUI)
	self._goReshape = self:getGo("skill_detail_tips_copy_2109374814")
	self._goName = goutil.findChild(self._goSkillRoot, "nameContent")
	self._goTypeNormal = goutil.findChild(self._goSkillRoot, "stateSkill")
	self._goTypeTalent = goutil.findChild(self._goSkillRoot, "stateHeartAnchors")
	self._goTypeEquip = goutil.findChild(self._goSkillRoot, "stateEquip")
	self._goTypeEcho = goutil.findChild(self._goSkillRoot, "stateEcho")
	self._goTypeThought = goutil.findChild(self._goSkillRoot, "stateThought")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroup = goutil.findChild(self.mainGO, "skill_tips"):GetComponent(ComponentType.CanvasGroup)
	self._scrollEmptyRaycast = self:getGoByPath("skill_tips/middleScroll"):GetComponent(UIComponentType.EmptyRaycast)

	goutil.setActive(self._btnMore.gameObject, false)
	goutil.setActive(self._btnDesc.gameObject, false)
	goutil.setActive(self._btnDesc2.gameObject, false)
end

function M:destroyUI()
	self:_setEvent(false)
end

function M:onEnter()
	self._scrollEmptyRaycast.enabled = true
	self._canvasGroup.alpha = 0
	self._showTalent = false
	self._showMonsterTalent = false
	self._canvasGroupSkillRoot.alpha = 1

	goutil.setActive(self._goReshape, false)
	goutil.setActive(self._labelGroup[M.LabelDescType.Normal].go, true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	self:_setEvent(true)
	self:_initSkillEnhance()

	local info = self:getFirstParam()
	local defaultShowDetail = info and info.defaultShowAll or false
	local viewPortPercent = info.viewPortPercent
	local isRight = viewPortPercent and viewPortPercent[2] and viewPortPercent[2] >= 0.5

	if isRight then
		self._goBuffRoot.transform:SetSiblingIndex(self._goSkillRoot.transform:GetSiblingIndex() - 1)
	else
		self._goBuffRoot.transform:SetSiblingIndex(self._goSkillRoot.transform:GetSiblingIndex() + 1)
	end

	self:refreshView()
	self:refreshDesc()
	self:changeShowType(defaultShowDetail)
	self:_updateBuffView()

	if info.hasDispatch then
		local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()

		GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, true, self._viewPresentor:getViewName(), skillCOWrapper:getSkillCode())
	end

	self._guiAnimation:PlayAniByName("open1")
end

function M:onEnterFinished()
	return
end

function M:onExit()
	self._scrollEmptyRaycast.enabled = false

	self:_setEvent(false)
	SkillEnhanceMO.releaseSharedMO(self._skillEnhanceMO)
	SkillEnhanceMO.releaseSharedMO(self._addSkillEnhanceMO)

	self._skillEnhanceMO = nil
	self._addSkillEnhanceMO = nil
	self._showTalent = false
	self._showMonsterTalent = false

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, false, self._viewPresentor:getViewName())
	self:_clearBuffItems()
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickDesc()
	self:_updateBuffView()
end

function M:changeShowType(showDetail)
	local info = self:getFirstParam()
	local hideEnhanceDetail = info.hideEnhanceDetail

	showDetail = true
	hideEnhanceDetail = true

	local skillCO = self._skillEnhanceMO:getSkillCO()
	local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillCO.code)

	goutil.setActive(self._labelGroup[M.LabelDescType.Enhanced].go, showDetail and (skillCO.hasGodlike or self._addSkillEnhanceMO))
	goutil.setActive(self._rectTrAuthorityLstSample.gameObject, not showDetail and not hideEnhanceDetail)

	local authorityLstDetailShow = showDetail and not hideEnhanceDetail and #allEnhanceCodes > 0

	goutil.setActive(self._rectTrAuthorityLstDetail.gameObject, authorityLstDetailShow)
	self:_onAuthorityLstDetailShow(authorityLstDetailShow)
end

function M:refreshView()
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local skillType = skillCOWrapper:getSkillType()

	goutil.setActive(self._goName, self:_isCommonSkill(skillType) or self._showMonsterTalent)
	goutil.setActive(self._goTypeNormal, self:_isCommonSkill(skillType) or self._showMonsterTalent)
	goutil.setActive(self._goTypeTalent, self._showTalent)
	goutil.setActive(self._goTypeEquip, skillType == BattleEnum.SkillCategory.EQUIPMENT)
	goutil.setActive(self._goTypeEcho, skillType == BattleEnum.SkillCategory.ECHO)
	goutil.setActive(self._goTypeThought, skillType == BattleEnum.SkillCategory.DEPUTY)

	if self:_isCommonSkill(skillType) or self._showMonsterTalent then
		self:_refreshTypeNormal()
	elseif self._showTalent then
		self:_refreshTypeTalent()
	elseif skillType == BattleEnum.SkillCategory.ECHO then
		self:_refreshTypeEcho()
	elseif skillType == BattleEnum.SkillCategory.EQUIPMENT then
		self:_refreshTypeEquip()
	elseif skillType == BattleEnum.SkillCategory.DEPUTY then
		self:_refreshTypeThinking()
	end
end

function M:_isCommonSkill(skillType)
	return skillType == BattleEnum.SkillCategory.NORMAL or skillType == BattleEnum.SkillCategory.SPECIAL or skillType == BattleEnum.SkillCategory.TRUMP or skillType == BattleEnum.SkillCategory.EXTRA or skillType == BattleEnum.SkillCategory.PASSIVE
end

function M:_refreshTypeNormal()
	local info = self:getFirstParam()
	local skillStatus = info.skillStatus or BattleEnum.SkillStatus.Normal
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local isActiveSkill = ActiveSkillCOUtil.isActiveSkill(skillCOWrapper, skillStatus)
	local cd = self._skillEnhanceMO:getSkillCO().cd

	self._txtSkillName.text = skillCOWrapper:getName()

	if not info.hideCD then
		self._infoGroup[M.AttrType.CD].txt.text = langF("tip_skill_round_num", cd)

		goutil.setActive(self._infoGroup[M.AttrType.CD].txt.gameObject, cd > 0)
		goutil.setActive(self._infoGroup[M.AttrType.CD].goNone, cd <= 0)
	end

	goutil.setActive(self._infoGroup[M.AttrType.CD].go, not info.hideCD)

	if isActiveSkill then
		self._infoGroup[M.AttrType.AtkTyp].txt.text = ActiveSkillCOUtil.getCategoryLabel(skillCOWrapper, skillStatus)
		self._infoGroup[M.AttrType.Shoot].txt.text = self._skillEnhanceMO:getReleaseDistanceLabel(skillStatus)
		self._infoGroup[M.AttrType.Range].txt.text = ActiveSkillCOUtil.getRangeLabel(skillCOWrapper, isActiveSkill, skillStatus)

		goutil.setActive(self._infoGroup[M.AttrType.Shoot].txt.gameObject, true)
		goutil.setActive(self._infoGroup[M.AttrType.Range].txt.gameObject, true)
		goutil.setActive(self._infoGroup[M.AttrType.Shoot].goNone, false)
		goutil.setActive(self._infoGroup[M.AttrType.Range].goNone, false)
	else
		self._infoGroup[M.AttrType.AtkTyp].txt.text = ActiveSkillCOUtil.getCategoryLabel(skillCOWrapper, skillStatus)

		goutil.setActive(self._infoGroup[M.AttrType.Shoot].txt.gameObject, false)
		goutil.setActive(self._infoGroup[M.AttrType.Range].txt.gameObject, false)
		goutil.setActive(self._infoGroup[M.AttrType.Shoot].goNone, true)
		goutil.setActive(self._infoGroup[M.AttrType.Range].goNone, true)
	end
end

function M:_refreshTypeTalent()
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local addSkillCOWrapper = false

	if self._addSkillEnhanceMO then
		addSkillCOWrapper = self._addSkillEnhanceMO:getSkillCOWrapper()
	end

	local txtName = goutil.findChildTextComponent(self._goTypeTalent, "txtName")

	txtName.text = addSkillCOWrapper and addSkillCOWrapper:getName() or skillCOWrapper:getName()

	local breakLv = 0
	local heroData = self:_getHeroData()

	if heroData then
		breakLv = heroData:getBreakLv()
	end

	for i = 1, 50 do
		local breakGO = goutil.findChild(self._goTypeTalent, "contract_break_point/done/sign" .. i)

		if breakGO then
			goutil.setActive(breakGO, i <= breakLv)
		else
			break
		end
	end

	local info = self:getFirstParam()
	local isAwake = info.awakeStatus == CommEnum.TalentSkillAwakeStatus.Unlock

	goutil.setActive(goutil.findChild(self._goTypeTalent, "mask/imgNormal"), not isAwake)
	goutil.setActive(goutil.findChild(self._goTypeTalent, "mask/imgSublimation"), isAwake)
	goutil.setActive(goutil.findChild(self._goTypeTalent, "not_reshaped"), not isAwake)
	goutil.setActive(goutil.findChild(self._goTypeTalent, "reshaped"), isAwake)
end

function M:_refreshTypeEcho()
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local txtName = goutil.findChildTextComponent(self._goTypeEcho, "txtName")

	txtName.text = skillCOWrapper:getName()

	local echoLv = 1
	local echoItem = self:_getEchoItem()

	if echoItem then
		echoLv = echoItem:getLevel()
	end

	for i = 1, 50 do
		local breakGO = goutil.findChild(self._goTypeEcho, "break_point/point/Image" .. i)

		if breakGO then
			goutil.setActive(breakGO, i < echoLv)
		else
			break
		end
	end
end

function M:_refreshTypeEquip()
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local txtName = goutil.findChildTextComponent(self._goTypeEquip, "txtName")

	txtName.text = skillCOWrapper:getName()
end

function M:_refreshTypeThinking()
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local skillCode = skillCOWrapper:getSkillCode()
	local lv = ThinkingModel.instance:getThinkingSkillLevel(skillCode)
	local txtName = goutil.findChildTextComponent(self._goTypeThought, "txtlName")
	local txtLevel = goutil.findChildTextComponent(self._goTypeThought, "txtlLevel")

	txtName.text = skillCOWrapper:getName()

	local info = self:getFirstParam()

	if info and info.level then
		txtLevel.text = string.format("Lv.%s", info.level)
	else
		txtLevel.text = string.format("Lv.%s", lv)
	end
end

function M:_getEchoItem()
	local heroData = self:_getHeroData()

	if heroData then
		local echoItem = heroData:getHeroEchoItemData():getEchoItem()

		return echoItem
	end
end

function M:_getHeroData()
	local info = self:getFirstParam()
	local heroId = info.heroId

	return HeroDepotModel.instance:getHeroInfoByID(heroId)
end

function M:_initSkillEnhance()
	local info = self:getFirstParam()
	local heroId = info.heroId
	local awakeStatus = info.awakeStatus
	local skillStatus = info.skillStatus or BattleEnum.SkillStatus.Normal

	self._skillEnhanceMO = info.skillEnhanceMO

	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local isTalent = ActiveSkillCOUtil.isTalent(skillCOWrapper, skillStatus)
	local isCharacter = heroId and ItemUtil.isCharacterById(heroId) or false

	self._showTalent = isTalent and isCharacter
	self._showMonsterTalent = isTalent and not isCharacter
	self._addSkillEnhanceMO = false

	if self._showTalent then
		local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)
		local addSkillId = characterCO.battleTalent[awakeStatus]

		if addSkillId then
			self._addSkillEnhanceMO = SkillEnhanceMO.getSharedMO(addSkillId)
		end
	end

	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local skillType = skillCOWrapper:getSkillType()

	if skillType == BattleEnum.SkillCategory.ECHO then
		local echoItem = self:_getEchoItem()

		if echoItem then
			self._skillEnhanceMO = echoItem:getSkillEnhanceMO()
		end
	end
end

function M:refreshDesc()
	self:_updateDescView()
	self:_updateEnhanceView()
end

function M:_updateDescView()
	local descStr = self._skillEnhanceMO:getDescription()

	if self._addSkillEnhanceMO then
		local skillCO = self._addSkillEnhanceMO:getSkillCO()
		local skillDescBackUp = skillCO.normalConfig.backupDesc
		local isWakeUp = false
		local heroData = self:_getHeroData()

		if heroData then
			isWakeUp = heroData:getAwakeTalent()
		end

		local title = isWakeUp and lang("tip_skill_talent_wakeup") or lang("tip_skill_talent_not_wakeup")

		descStr = string.format("%s%s\n%s", title, skillDescBackUp, self._addSkillEnhanceMO:getDescription())
		self._labelGroup[M.LabelDescType.Enhanced].txt.text = string.format("<nobr>%s</nobr>", self._skillEnhanceMO:getDescription())

		local unlockSkillId
		local info = self:getFirstParam()
		local skillStatus = info.skillStatus or BattleEnum.SkillStatus.Normal

		self._skillEnhanceMO = info.skillEnhanceMO

		local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
		local isTalent = ActiveSkillCOUtil.isTalent(skillCOWrapper, skillStatus)

		if isTalent and not isWakeUp then
			local info = self:getFirstParam()
			local heroId = info.heroId
			local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)

			unlockSkillId = characterCO.battleTalent[CommEnum.TalentSkillAwakeStatus.Unlock]

			if unlockSkillId then
				self._txtReshapeBefore.text = string.format("<nobr>%s</nobr>", self._addSkillEnhanceMO:getDescription())

				local _addSkillEnhanceMO = SkillEnhanceMO.getSharedMO(unlockSkillId)

				self._txtReshapeAfter.text = string.format("<nobr>%s</nobr>", _addSkillEnhanceMO:getDescription())
			end
		end

		goutil.setActive(self._goReshape, not isWakeUp and unlockSkillId ~= nil and isTalent)
		goutil.setActive(self._labelGroup[M.LabelDescType.Normal].go, isWakeUp)
	end

	self._labelGroup[M.LabelDescType.Normal].txt.text = string.format("<nobr>%s</nobr>", descStr)

	local strengthenStr
	local skillCO = self._skillEnhanceMO:getSkillCO()

	if skillCO.hasGodlike then
		strengthenStr = string.format("%s：%s", lang("skill_tip_strengthen_1"), self._skillEnhanceMO:getStrengthenDescription())
		self._labelGroup[M.LabelDescType.Enhanced].txt.text = string.format("<nobr>%s</nobr>", strengthenStr)
	end
end

function M:_updateEnhanceView()
	local info = self:getFirstParam()
	local heroId = info.heroId
	local skillCO = self._skillEnhanceMO:getSkillCO()
	local skillCOWrapper = self._skillEnhanceMO:getSkillCOWrapper()
	local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillCO.code)

	while self._rectTrAuthorityLstSample.childCount < #allEnhanceCodes + 1 do
		goutil.cloneAndSetParent(self._rectTrAuthorityLstSample:GetChild(1).gameObject, self._rectTrAuthorityLstSample)
	end

	while self._rectTrAuthorityLstDetail.childCount < #allEnhanceCodes + 1 do
		goutil.cloneAndSetParent(self._rectTrAuthorityLstDetail:GetChild(1).gameObject, self._rectTrAuthorityLstDetail)
	end

	local hasEnhance = false
	local myEnhanceCodes = self._skillEnhanceMO:getAllSkillEnhanceCode()

	for i = 1, self._rectTrAuthorityLstSample.childCount - 1 do
		local goSample = self._rectTrAuthorityLstSample:GetChild(i).gameObject
		local goDetail = self._rectTrAuthorityLstDetail:GetChild(i).gameObject
		local show = false
		local index = i
		local enhanceCode = allEnhanceCodes[index]

		if enhanceCode then
			local isGained = table.indexof(myEnhanceCodes, enhanceCode)
			local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

			if not skillEnhanceCOWrapper:isAddEnhance() then
				local authorityIndex = self:getAuthorityIndexBySkillEnhancedCode(heroId, skillEnhanceCOWrapper:getCode())

				if authorityIndex then
					local nodeLvOrg = math.ceil(authorityIndex / 5)
					local nodeLv = CommEnum.Num2RomeNum[nodeLvOrg]
					local nodeIndexInLv = authorityIndex % 5 == 0 and 5 or authorityIndex % 5
					local imgDi = goutil.findChildImageComponent(goSample, "Image1")
					local txtLv = goutil.findChildTextComponent(goSample, "txtNum1")
					local txtIndexInLv = goutil.findChildTextComponent(goSample, "txtNum2")
					local imgDiDetail = goutil.findChildImageComponent(goDetail, "level/Image1")
					local imgLvDetail = goutil.findChildImageComponent(goDetail, "level/txtNum1")
					local txtIndexInLvDetail = goutil.findChildTextComponent(goDetail, "level/txtNum2")
					local txtContentDetail = goutil.findChildTextComponent(goDetail, "txtContent")

					txtLv.text = nodeLv
					txtIndexInLv.text = nodeIndexInLv

					IconLoader.setSprite(imgLvDetail, IconType.DynSpriteAtlas_CharacterSystem_Authority, GameUrl.getAuthorityLevelNum(nodeLvOrg))

					txtIndexInLvDetail.text = nodeIndexInLv
					txtContentDetail.text = skillEnhanceCOWrapper:getDescription(isGained)

					if isGained then
						imgDi.color = parsecolor("#FFFFFF")
						txtLv.color = parsecolor("#131313")
					else
						imgDi.color = parsecolor("#000000")
						txtLv.color = parsecolor("#F7F6F1")
					end

					imgDiDetail.color = imgDi.color
					imgLvDetail.color = txtLv.color
					show = true
				end

				hasEnhance = true
			end
		end

		goutil.setActive(goSample, show)
		goutil.setActive(goDetail, show)
	end
end

function M:_onAuthorityLstDetailShow(show)
	if not show then
		return
	end

	for i = 1, self._rectTrAuthorityLstDetail.childCount - 1 do
		local goDetail = self._rectTrAuthorityLstDetail:GetChild(i).gameObject

		if goDetail.activeSelf then
			local txtContentDetail = goutil.findChildTextComponent(goDetail, "txtContent")

			txtContentDetail.text = TextUtils.GetPunctuationFixedText(txtContentDetail.text, txtContentDetail, 0, 2000)
		end
	end
end

function M:getAuthorityIndexBySkillEnhancedCode(heroId, skillEnhancedCode)
	if not self._skillEnCode2AuthorityIndex or self._cacheHeroId ~= heroId then
		self._cacheHeroId = heroId
		self._skillEnCode2AuthorityIndex = HeroPowerConfig.instance:getSkillEnhancedCode2AuthorityIndexMap(heroId)
	end

	return self._skillEnCode2AuthorityIndex[skillEnhancedCode]
end

function M:_updateBuffView()
	local show = true

	if show then
		local buffCodes = {}
		local tagCodes = {}

		self._skillEnhanceMO:fillTagIdList(tagCodes)
		self._skillEnhanceMO:fillBuffCodesList(buffCodes)
		BuffCOUtil.sortBuffCodes(buffCodes)

		local lst = {}

		for _, id in ipairs(buffCodes or {}) do
			table.insert(lst, {
				isTag = false,
				id = id
			})
		end

		for _, id in ipairs(tagCodes or {}) do
			table.insert(lst, {
				isTag = true,
				id = id
			})
		end

		if #lst <= 0 then
			goutil.setActive(self._goBuffRoot, false)

			return
		end

		self:_clearBuffItems()

		local len = #lst

		if len > 0 then
			for i = 1, len do
				self:_addBuffItem(#self._buffCell + 1)
			end
		end

		for index, data in ipairs(lst) do
			self._buffCell[index].updateData(index, data.id, data.isTag)
		end
	end

	goutil.setActive(self._goBuffRoot, show)
end

function M:_addBuffItem(index)
	if self._buffCell[index] then
		printError("已有index:", index)
	else
		local go = goutil.cloneAndSetParent(self._buffTipsItem, self._goBuffContent.transform)
		local cell = self:_buildBuffCell(go, index)

		goutil.setActive(go, true)

		self._buffCell[index] = cell
	end
end

function M:_clearBuffItems()
	for index, cell in ipairs(self._buffCell or {}) do
		cell.destroyUI()
		goutil.destroy(cell.go)
	end

	self._buffCell = {}
end

function M:_buildBuffCell(go, index)
	local data = {}

	data.go = go
	data.index = index
	data.txtName = goutil.findChildComponent(go, "txtName", UIComponentType.TextMeshProUGUI)
	data.txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)

	function data.destroyUI()
		return
	end

	function data.updateData(_index, id, isTag)
		data.index = _index
		data.id = id
		data.isTag = isTag

		local nameStr, contentStr

		if isTag then
			local tagCO = ActiveSkillConfig.instance:getSkillTagCO(id)

			if tagCO then
				contentStr = tagCO.desc

				local icon = ActiveSkillConfig.instance:getTagIconName(tagCO.typeName)

				nameStr = string.format("<sprite name=\"%s\">%s", icon, tagCO.name)
			elseif enableErrorLog then
				printError(string.format("找不到[%s]SkillTagCO", id))
			end
		else
			local buffCO = BuffConfig.instance:getBuffCO(id)

			if buffCO then
				contentStr = buffCO.desc
				nameStr = string.format("<sprite name=\"%s\">%s", buffCO.descIcon, buffCO.name)
			elseif enableErrorLog then
				printError("该技能描述找不到对应buff:", description)
			end
		end

		data.txtName.text = nameStr
		data.txtContent.text = contentStr
	end

	return data
end

function M:_buildLableCell(go)
	local cell = {
		go = go,
		txt = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)
	}

	return cell
end

return M
