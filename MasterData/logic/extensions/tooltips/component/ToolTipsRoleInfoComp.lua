-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsRoleInfoComp.lua

module("logic.extensions.tooltips.component.ToolTipsRoleInfoComp", package.seeall)

local M = class("ToolTipsRoleInfoComp", ViewComponent)

function M:buildUI()
	self._nameTxt = self:getText("role_info_tips_-782216385")
	self._txtMoveValue = self:getText("role_info_tips_-404342445")
	self._txtShootValue = self:getText("role_info_tips_-728043939")
	self._txtStar = self:getText("role_info_tips_-1700357770")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "top/cell/battleheroitem/heroMask/heroIcon")
	self._imgQuality = goutil.findChildImageComponent(self.mainGO, "top/cell/battleheroitem/imgQuality")
	self._imgQualityLine = goutil.findChildImageComponent(self.mainGO, "top/cell/battleheroitem/imgQuality/imgLine")
	self._imgCamp = goutil.findChildImageComponent(self.mainGO, "top/cell/battleheroitem/camp/imgCamp")
	self._imgCareerBg = goutil.findChildImageComponent(self.mainGO, "top/cell/battleheroitem/imgCareerDi_1")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "top/cell/battleheroitem/txtLv")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "top/cell/battleheroitem/imgCareerDi"))
	self._talentSkill = ViewlibUtil.getItem(ViewlibResPath.SkillItem1, self:getGo("role_info_tips_-1280833065"))
	self._skillItemCollection = ViewlibCollection:create(ViewlibResPath.SkillItem1, 3)
	self._skillBindGo = self:getGo("role_info_tips_-420322307")
	self._labAttributeGrade = {
		self:getText("role_info_tips_-962259253"),
		self:getText("role_info_tips_-901455366"),
		self:getText("role_info_tips_-518797324"),
		self:getText("role_info_tips_-37581206"),
		self:getText("role_info_tips_-1541998147"),
		self:getText("role_info_tips_-306019158")
	}
	self._attackTxt = self:getText("role_info_tips_-760408204")
	self._defenseTxt = self:getText("role_info_tips_-112536908")
	self._hpTxt = self:getText("role_info_tips_-1882599677")
	self._atkMagTxt = self:getText("role_info_tips_-2052011764")
	self._defMagTxt = self:getText("role_info_tips_-689358872")
	self._afflatusTxt = self:getText("role_info_tips_-1418310645")
	self._addAttackTxt = self:getText("role_info_tips_-361093906")
	self._addDefenseTxt = self:getText("role_info_tips_-1509344006")
	self._addHpTxt = self:getText("role_info_tips_-1242516705")
	self._addAtkMagTxt = self:getText("role_info_tips_-553646395")
	self._addDefMagTxt = self:getText("role_info_tips_-275828971")
	self._addAfflatusTxt = self:getText("role_info_tips_-1332347139")
	self._normalSkillBind = self:getGo("role_info_tips_752594588")
	self._carrySkillBind = self:getGo("role_info_tips_-1588945822")
end

function M:destroyUI()
	self._skillItemCollection:clear()

	self._skillItemCollection = nil
	self._nameTxt = nil
	self._txtMoveValue = nil
	self._txtShootValue = nil
	self._txtStar = nil
	self._imgIcon = nil
	self._imgQuality = nil
	self._imgCamp = nil
	self._imgCareerBg = nil
	self._txtLv = nil
	self._career = nil

	self._talentSkill:destroy()

	self._talentSkill = nil
	self._skillBindGo = nil

	table.clear(self._labAttributeGrade)

	self._attackTxt = nil
	self._defenseTxt = nil
	self._hpTxt = nil
	self._atkMagTxt = nil
	self._defMagTxt = nil
	self._afflatusTxt = nil
	self._addAttackTxt = nil
	self._addDefenseTxt = nil
	self._addHpTxt = nil
	self._addAtkMagTxt = nil
	self._addDefMagTxt = nil
	self._addAfflatusTxt = nil
	self._normalSkillBind = nil
	self._carrySkillBind = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	local info = self:getFirstParam()
	local heroId = info.heroId
	local isConfigOnly = info.isConfigOnly
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self._carrySkillLlist = {}

	self:_showInfo(heroData)
end

function M:_showInfo(heroData)
	local characterCO = heroData:getCharacterCo()
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroData:getId())

	self._heroId = heroData:getId()
	self._txtLv.text = heroData:getLevel()

	self._career:setCareerAndColorType(heroData:getCareer(), heroData:getColorType())

	if characterCO then
		self._nameTxt.text = heroInfoCO.name
		self._txtMoveValue.text = characterCO.move
		self._txtShootValue.text = heroData:getAtkRange()
		self._modelID = characterCO.modelId

		local curSan = heroData:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

		self._txtStar.text = curSan

		local modelCO = heroData:getModelCo()

		if modelCO then
			local modelCO = ModelConfig.instance:getModelConfig(heroData:getModelId())

			IconLoader.setSprite(self._imgIcon, IconType.HeadIcon, modelCO.headIconName)
			IconLoader.setSprite(self._imgCamp, IconType.CampBattle, BattleIconName.getCampIcon(heroData:getCamp()))
			IconLoader.setSprite(self._imgCareerBg, IconType.DynSpriteAtlas_Battle, BattleIconName.getColorTypeBg(heroData:getColorType()))
			IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityIcon(heroData:getQuality()))
			IconLoader.setSprite(self._imgQualityLine, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityLineIcon(heroData:getQuality()))
		end

		self._talentSkill:setBindGo(self._skillBindGo)
		self._talentSkill:setHeroAndSkillId(characterCO.id, characterCO.battleTalent)

		local skillCount = #heroData:getSkills()

		for i = 1, skillCount do
			local skillInfo = heroData:getSkills()[i]
			local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillInfo.key)
			local skillType = skillCOWrapper:getSkillType()

			if skillType >= 1 and skillType <= 3 or skillType == 9 then
				local skillItem = self._skillItemCollection:createInstance(self._normalSkillBind)

				skillItem:setBindGo(self._skillBindGo)
				skillItem:setHeroAndSkillId(characterCO.id, skillInfo.key)
			elseif skillType >= 5 and skillType < 7 then
				local skillItem = self._skillItemCollection:createInstance(self._carrySkillBind)

				skillItem:setBindGo(self._skillBindGo)
				skillItem:setHeroAndSkillId(characterCO.id, skillInfo.key)
			end
		end

		for _, v in ipairs(self._labAttributeGrade) do
			v.text = string.format("<color=%s>%s</color>", self:_getAttrLabColor(characterCO.attributeGrade[_]), characterCO.attributeGrade[_])
		end
	end

	local totalHp = heroData:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local totalAfflatus = heroData:getAttribute(BattleExtension_pb.Attribute.INSPIRATION)
	local totalAttack = heroData:getAttribute(BattleExtension_pb.Attribute.ATK_PHY)
	local totalDefense = heroData:getAttribute(BattleExtension_pb.Attribute.DEF_PHY)
	local totalAtkMag = heroData:getAttribute(BattleExtension_pb.Attribute.ATK_MAG)
	local totalDefMag = heroData:getAttribute(BattleExtension_pb.Attribute.DEF_MAG)
	local addHp = heroData:getAttrPartsBase(BattleExtension_pb.AttributePart.PART_MAX_HP_ADDITION)
	local addAck = heroData:getAttrPartsBase(BattleExtension_pb.AttributePart.PART_ATK_PHY_ADDITION)
	local addDes = heroData:getAttrPartsBase(BattleExtension_pb.AttributePart.PART_DEF_PHY_ADDITION)
	local addMagAck = heroData:getAttrPartsBase(BattleExtension_pb.AttributePart.PART_ATK_MAG_ADDITION)
	local addMagDes = heroData:getAttrPartsBase(BattleExtension_pb.AttributePart.PART_DEF_MAG_ADDITION)

	self._attackTxt.text = totalAttack - addAck
	self._defenseTxt.text = totalDefense - addDes
	self._hpTxt.text = totalHp - addHp
	self._atkMagTxt.text = totalAtkMag - addMagAck
	self._defMagTxt.text = totalDefMag - addMagDes
	self._afflatusTxt.text = totalAfflatus
	self._addAttackTxt.text = string.format("<color=#00FF00>+ %s</color>", addAck)
	self._addDefenseTxt.text = string.format("<color=#00FF00>+ %s</color>", addDes)
	self._addHpTxt.text = string.format("<color=#00FF00>+ %s</color>", addHp)
	self._addAtkMagTxt.text = string.format("<color=#00FF00>+ %s</color>", addMagAck)
	self._addDefMagTxt.text = string.format("<color=#00FF00>+ %s</color>", addMagDes)
	self._addAfflatusTxt.text = string.format("<color=#00FF00>+ %s</color>", 0)
end

function M:_getAttrLabColor(attr)
	local colorTb = {
		A = "#FE5D5D",
		C = "#8de74b",
		D = "#FFFFFF",
		S = "#eedf3b",
		F = "#FFFFFF",
		B = "#60d3ec"
	}

	return colorTb[attr] or "#FFFFFF"
end

function M:onExit()
	IconLoader.clearSprite(self._imgIcon)
	self._skillItemCollection:clearAllInstance()
	TeamDispatcher:dispatchEvent(TeamEventType.ON_HIDE_ROLE_TIPS)
end

return M
