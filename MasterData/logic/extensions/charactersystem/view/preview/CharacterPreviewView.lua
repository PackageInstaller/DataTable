-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterPreviewView.lua

module("logic.extensions.charactersystem.view.preview.CharacterPreviewView", package.seeall)

local M = class("CharacterPreviewView", ViewComponent)
local index2Attribure = {
	BattleExtension_pb.Attribute.MAX_HP,
	BattleExtension_pb.Attribute.INSPIRATION,
	BattleExtension_pb.Attribute.ATK_PHY,
	BattleExtension_pb.Attribute.ATK_MAG,
	BattleExtension_pb.Attribute.DEF_PHY,
	BattleExtension_pb.Attribute.DEF_MAG
}
local index2AttrGrade = {
	1,
	2,
	3,
	5,
	4,
	6
}

function M:ctor()
	self._heroMaxData = nil
	self._skillCells = {}
	self._authorityCells = {}
	self._anchorBreakCells = {}
	self._heroCfgInfo = nil
	self._talentId = nil
end

function M:buildUI()
	self._btnClose = self:getBtn("role_preview_view_-1004126632")
	self._goFullLevelPanel = self:getGo("role_preview_view_-1953597862")
	self._goDetailPanel = self:getGo("role_preview_view_-1974066106")
	self._goSkillPanel = self:getGo("role_preview_view_-1341573419")
	self._scrollRect = self:getGo("role_preview_view_-275799534"):GetComponent(UIComponentType.ScrollRect)
	self._goHeadIcon = self:getGo("role_preview_view_1318559495")
	self._imgHeadIcon = self:getImage("role_preview_view_205385622")
	self._textName = self:getText("role_preview_view_-436860780")
	self._textLevel = self:getText("role_preview_view_-305158113")
	self._imgQuality = self:getImage("role_preview_view_-1671789256")
	self._goCareer = self:getGo("0&career_475494592")
	self._textMove = self:getText("role_preview_view_-637490103")
	self._textRange = self:getText("role_preview_view_-854082166")
	self._transfArrt = self:getGo("role_preview_view_-70499959").transform
	self._imgOriginTalent = self:getImage("role_preview_view_-713417408")
	self._imgAwakeTalent = self:getImage("role_preview_view_-201273181")
	self._textOriginTalent = self:getText("role_preview_view_-1985831459")
	self._textAwakeTalent = self:getText("role_preview_view_-1679361821")
	self._btnOriginTalent = self:getBtn("role_preview_view_-713417408")
	self._btnAwakeTalent = self:getBtn("role_preview_view_-201273181")
	self._goTalentPos1 = self:getGo("role_preview_view_-377470482")
	self._goTalentPos2 = self:getGo("role_preview_view_-526264990")
	self._textTalentTitle = self:getText("role_preview_view_-20954860")
	self._goSkill1 = self:getGo("1&skill_item_1_-706685850")
	self._goSkill2 = self:getGo("2&skill_item_1_-706685850")
	self._goSkill3 = self:getGo("3&skill_item_1_-706685850")
	self._textSkillTitle = self:getText("role_preview_view_-1171141043")
	self._goAuthorityNode1 = self:getGo("role_preview_view_-1803191123")
	self._goAuthorityNode2 = self:getGo("role_preview_view_-645747138")
	self._goAuthorityNode1_1 = goutil.findChild(self._goAuthorityNode1, "authority_node")
	self._goAuthorityNode2_1 = goutil.findChild(self._goAuthorityNode2, "authority_node1")
	self._goAuthorityNode2_2 = goutil.findChild(self._goAuthorityNode2, "authority_node2")
	self._textAuthorityTitle = self:getText("role_preview_view_-1916149224")
	self._goAnchorBreak1 = self:getGo("4&contract_break_point_2103825544")
	self._goAnchorBreak2 = self:getGo("5&contract_break_point_2103825544")
	self._goAnchorBreak3 = self:getGo("6&contract_break_point_2103825544")
	self._goAnchorBreak4 = self:getGo("7&contract_break_point_2103825544")
	self._goAnchorBreak5 = self:getGo("8&contract_break_point_2103825544")
	self._textBreakTitle = self:getText("role_preview_view_-2067380647")
	self._polygon = UIPolygon.Get(self:getGo("9&sixdimensioninfo_-492787873"))
	self._textDimensionTitle = self:getText("role_preview_view_-1800441236")
	self._textDimension1 = self:getText("9&sixdimensioninfo_-2033388935")
	self._textDimension2 = self:getText("9&sixdimensioninfo_-1335132831")
	self._textDimension3 = self:getText("9&sixdimensioninfo_-410819544")
	self._textDimension4 = self:getText("9&sixdimensioninfo_-61014096")
	self._textDimension5 = self:getText("9&sixdimensioninfo_1337588298")
	self._textDimension6 = self:getText("9&sixdimensioninfo_-605687856")

	goutil.setActive(self._goFullLevelPanel, true)
	goutil.setActive(self._goDetailPanel, false)
	goutil.setActive(self._goSkillPanel, false)
end

function M:bindEvents()
	self._btnOriginTalent:AddClickListener(self._onClickOriginTalent, self)
	self._btnAwakeTalent:AddClickListener(self._onClickAwakeTalent, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnOriginTalent:RemoveClickListener()
	self._btnAwakeTalent:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._heroId = self:getFirstParam()
	self._heroMaxData = CharacterUtil.getPreviewHeroData(self._heroId)
	self._heroCfgInfo = CharacterConfig.instance:getCfgInfoByID(self._heroId)

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)

	self._scrollRect.horizontalNormalizedPosition = 0

	self:_refreshHeroInfo()
	self:_refreshTalent()
	self:_refreshSkills()
	self:_refreshAuthority()
	self:_refreshAnchor()
	self:_refreshSixDimension()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
end

function M:destroyUI()
	for _, cell in ipairs(self._skillCells) do
		cell:destroyUI()
	end

	for _, cell in ipairs(self._authorityCells) do
		cell:destroyUI()
	end

	for _, cell in ipairs(self._anchorBreakCells) do
		cell:destroyUI()
	end

	self._skillCells = nil
	self._authorityCells = nil
	self._anchorBreakCells = nil
	self._heroMaxData = nil
	self._heroCfgInfo = nil
end

function M:_refreshHeroInfo()
	local heroMaxData = self._heroMaxData

	self._textName.text = heroMaxData:getName()
	self._textLevel.text = heroMaxData:getLevel()

	local careerCell = Astral.SimpleLuaComponentContainer.Add(self._goCareer, CareerCell)

	careerCell:setData(self._heroId)
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem_Com, GameUrl.getQualityUrl(heroMaxData:getQuality()))
	IconLoader.setSprite(self._imgHeadIcon, IconType.RoleCard, self._heroMaxData:getModelCo().halfIconName)
	goutil.setActive(self._goHeadIcon, true)

	self._textMove.text = heroMaxData:getMove()
	self._textRange.text = heroMaxData:getAtkRange()

	for i = 0, self._transfArrt.childCount - 1 do
		local goItem = self._transfArrt:GetChild(i).gameObject
		local textValue = goutil.findChildTextComponent(goItem, "txtValue1")
		local textQuality = goutil.findChildTextComponent(goItem, "txtLevel")

		textValue.text = heroMaxData:getAttribute(index2Attribure[i + 1]) or "0"

		local attributeGrade = self._heroCfgInfo and self._heroCfgInfo.attributeGrade or {}

		textQuality.text = attributeGrade[index2AttrGrade[i + 1]] or CommEnum.Quality2UpperChar[GameEnum.QualityEnum.A]
	end
end

function M:_refreshTalent()
	self._textTalentTitle.text = lang("tip_talent")

	local characterCO = CharacterConfig.instance:getCharacterItemInfo(self._heroId)
	local talentSkills = characterCO.battleTalent

	self._talentId = talentSkills[1] or 0

	local unAwakeTalentId = talentSkills[2] or talentSkills[1] or 0
	local awakeTalentId = talentSkills[3] or talentSkills[2] or talentSkills[1] or 0

	self:_setTalent(self._imgOriginTalent, self._textOriginTalent, unAwakeTalentId)
	self:_setTalent(self._imgAwakeTalent, self._textAwakeTalent, awakeTalentId)
end

function M:_setTalent(img, nameText, skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
	local skillCo = skillCOWrapper:getSkillCO()

	nameText.text = StringUtil.randomReplaceBlackBlock(skillCo.name)

	local iconPath = ActiveSkillCOUtil.getSkillIcon(skillCo)

	if not string.nilorempty(iconPath) then
		IconLoader.setSprite(img, IconType.SkillIcon, iconPath, function()
			img:SetNativeSize()
		end, self)
	end
end

function M:_onClickOriginTalent()
	self:_showTalentTips(self._goTalentPos1, CommEnum.TalentSkillAwakeStatus.Locked, nil)
end

function M:_onClickAwakeTalent()
	local enhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(self._talentId)

	self:_showTalentTips(self._goTalentPos2, CommEnum.TalentSkillAwakeStatus.Unlock, enhanceCodes)
end

function M:_showTalentTips(posGo, awakeStatus, enhanceCodes)
	if self._talentId and self._talentId > 0 then
		local skillInfo = ToolTipsMgr.getSkillTipsInfo()

		skillInfo.heroId = self._heroId
		skillInfo.skillId = self._talentId
		skillInfo.defaultShowAll = true
		skillInfo.hangGO = posGo
		skillInfo.enhanceCodes = enhanceCodes
		skillInfo.awakeStatus = awakeStatus

		ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
	end
end

function M:_refreshSkills()
	self._textSkillTitle.text = lang("tip_skill")

	table.clear(self._skillCells)

	local skills = self._heroMaxData:getActiveNormalSkill()
	local skillsMO = {}

	for _, skill in ipairs(skills) do
		local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skill.key)
		local skillCOWrapper = skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil

		table.insert(skillsMO, skillCOWrapper)
	end

	for i = 1, 3 do
		local skillMO = skillsMO[i]
		local enhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillMO:getSkillCode())
		local cell = Astral.SimpleLuaComponentContainer.Add(self["_goSkill" .. i], CharacterSkillCell)

		cell:setData(skillMO, self._heroId)
		cell:setTipsPosType(CommEnum.TipsPopType.Right)
		cell:addEnhanceCodes(enhanceCodes)
		table.insert(self._skillCells, cell)
	end
end

function M:_refreshAuthority()
	self._textAuthorityTitle.text = lang("tip_Authority")

	table.clear(self._authorityCells)

	local skillNodeList = HeroPowerConfig.instance:getSkillNodeCoList(self._heroId)
	local count = TableUtil.getLen(skillNodeList)

	goutil.setActive(self._goAuthorityNode1, count <= 1)
	goutil.setActive(self._goAuthorityNode2, count > 1)

	local cell1_1 = Astral.SimpleLuaComponentContainer.Add(self._goAuthorityNode1_1, CharacterAuthorityCell)
	local cell2_1 = Astral.SimpleLuaComponentContainer.Add(self._goAuthorityNode2_1, CharacterAuthorityCell)
	local cell2_2 = Astral.SimpleLuaComponentContainer.Add(self._goAuthorityNode2_2, CharacterAuthorityCell)

	cell1_1:setData(skillNodeList[1], self._heroId)
	cell2_1:setData(skillNodeList[1], self._heroId)
	cell2_2:setData(skillNodeList[2], self._heroId)
	table.insert(self._authorityCells, cell1_1)
	table.insert(self._authorityCells, cell2_1)
	table.insert(self._authorityCells, cell2_2)
end

function M:_refreshAnchor()
	self._textBreakTitle.text = lang("tip_break")

	table.clear(self._anchorBreakCells)

	for breakIndex = 1, HeroBreakConfig.instance:getMaxBreakLevel() do
		local cell = Astral.SimpleLuaComponentContainer.Add(self["_goAnchorBreak" .. breakIndex], CharacterAnchorBreakCell)

		cell:setData(self._heroId, breakIndex)
		table.insert(self._anchorBreakCells, cell)
	end
end

function M:_refreshSixDimension()
	self._textDimensionTitle.text = lang("tip_six_dimension")

	local heroDimention = self._heroMaxData:getSixDim()

	for dimention, value in ipairs(heroDimention) do
		self["_textDimension" .. dimention].text = value

		self:_setOneValueTween(CommEnum.D62PolygonIndex[dimention], 0, CharacterCOUtil.qua2Ratio(value))
	end
end

function M:_setOneValueTween(index, startValue, endValue)
	DoTweenUtil.ToWithEase(startValue, endValue, 0.3 + index * 0.1, DG.Tweening.Ease.InCubic, function(value)
		self._polygon:InitPolygon(index, value)
	end)
end

function M:_onClickClose()
	self:close()
end

return M
