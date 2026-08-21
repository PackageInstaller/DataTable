-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsSkillInfoComp.lua

module("logic.extensions.tooltips.component.ToolTipsSkillInfoComp", package.seeall)

local M = class("ToolTipsSkillInfoComp", ViewComponent)

function M:buildUI()
	self._goSkillIcon = self:getGo("skill_item_1_-706685850")
	self._goTalentSkill = goutil.findChild(self.mainGO, "skill_tips/top/skillIcon/talent_skill_item1")
	self._goCarrySkill = self:getGoByPath("skill_tips/top/skillIcon/carry_icon")
	self._goNormalTalentBg = self:getGoByPath("skill_tips/top/skillIcon/mask")
	self._goNormalDi = self:getGo("skill_detail_tips_2063977072")
	self._goTalentUnlockDi = self:getGo("skill_detail_tips_732396713")
	self._goTalentLockDi = self:getGo("skill_detail_tips_1265247508")
	self._skillIcon = Astral.LuaComponentContainer.Add(self._goSkillIcon, SkillItem1)
	self._talentSkill = Astral.LuaComponentContainer.Add(self._goTalentSkill, TalentSkillItem)
	self._carrySkill = Astral.LuaComponentContainer.Add(self._goCarrySkill, CarrySkillItem)
	self._txtSkillName = self:getText("skill_detail_tips_-2120391744")
	self._txtTalentSkillDesc = self:getText("skill_detail_tips_-954611316")
	self._goRootKind = self:getGo("skill_detail_tips_-1273998599")
	self._goRootShoot = self:getGo("skill_detail_tips_-1016229143")
	self._goRootRange = self:getGo("skill_detail_tips_-1445709270")
	self._txtKind = self:getText("skill_detail_tips_-736569384")
	self._txtShoot = self:getText("skill_detail_tips_-924828325")
	self._txtRange = self:getText("skill_detail_tips_-477917438")
	self._txtKindNone = self:getText("skill_detail_tips_-1213537152")
	self._txtShootNone = self:getText("skill_detail_tips_87099650")
	self._txtRangeNone = self:getText("skill_detail_tips_-1360402712")
	self._goBuffRoot = self:getGo("skill_detail_tips_673836289")
	self._goSkillRoot = self:getGo("skill_detail_tips_1330165753")
	self._goAwakeRoot = self:getGo("skill_detail_tips_1059891823")
	self._btnAwake = self:getBtn("skill_detail_tips_1482066144")
end

function M:destroyUI()
	self._skillIcon:destroy()
	self._talentSkill:destroy()
	self._carrySkill:destroy()

	self._skillIcon = nil
	self._talentSkill = nil
	self._carrySkill = nil
	self._txtSkillName = nil
	self._txtKind = nil
	self._txtShoot = nil
	self._txtRange = nil
	self._txtKindNone = nil
	self._txtShootNone = nil
	self._txtRangeNone = nil
	self._goBuffRoot = nil
	self._goSkillRoot = nil
end

function M:onEnter()
	self:_setEvent(true)
	self:_updateDirection()
	self:_onEnhanceInfoUpdate()
end

function M:onExit()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SKILL_ENHANCE_INFO_UPDATE, self._onEnhanceInfoUpdate, self)
		self._btnAwake:AddClickListener(self._onClickAwake, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SKILL_ENHANCE_INFO_UPDATE, self._onEnhanceInfoUpdate, self)
		self._btnAwake:RemoveClickListener()
	end
end

function M:_updateDirection()
	local info = self:getFirstParam()
	local direction = info.direction or 1

	if direction >= 0 then
		self._goBuffRoot.transform:SetSiblingIndex(1)
		self._goSkillRoot.transform:SetSiblingIndex(2)
	else
		self._goSkillRoot.transform:SetSiblingIndex(1)
		self._goBuffRoot.transform:SetSiblingIndex(2)
	end
end

function M:_onEnhanceInfoUpdate()
	local info = self:getFirstParam()
	local heroId = info.heroId
	local awakeStatus = info.awakeStatus
	local skillStatus = info.skillStatus or BattleEnum.SkillStatus.Normal
	local skillEnhanceMO = info.skillEnhanceMO
	local skillCOWrapper = skillEnhanceMO:getSkillCOWrapper()
	local addSkillCOWrapper = false
	local isActiveSkill = ActiveSkillCOUtil.isActiveSkill(skillCOWrapper, skillStatus)
	local isTalent = ActiveSkillCOUtil.isTalent(skillCOWrapper, skillStatus)
	local isCharacter = heroId and ItemUtil.isCharacterById(heroId) or false
	local showTalent = isTalent and isCharacter
	local awakeTalent = awakeStatus == CommEnum.TalentSkillAwakeStatus.Unlock
	local isCarry = ActiveSkillCOUtil.isCarry(skillCOWrapper, skillStatus)

	goutil.setActive(self._goNormalTalentBg, isTalent and not isCharacter)

	if showTalent then
		goutil.setActive(self._skillIcon.mainGO, false)
		goutil.setActive(self._carrySkill.mainGO, false)
		goutil.setActive(self._talentSkill.mainGO, true)

		local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)
		local addSkillId = characterCO.battleTalent[awakeStatus]
		local addSkillEnhanceMO = false

		if addSkillId then
			addSkillEnhanceMO = SkillEnhanceMO.getSharedMO(addSkillId)
			addSkillCOWrapper = addSkillEnhanceMO:getSkillCOWrapper()
		end

		self._talentSkill:setSkillEnhanceMO(heroId, skillEnhanceMO, addSkillEnhanceMO)
		SkillEnhanceMO.releaseSharedMO(addSkillEnhanceMO)
	else
		goutil.setActive(self._talentSkill.mainGO, false)

		if isCarry then
			goutil.setActive(self._skillIcon.mainGO, false)
			goutil.setActive(self._carrySkill.mainGO, true)
			self._carrySkill:setSkillInfo(heroId, skillCOWrapper:getSkillCode(), skillEnhanceMO:getAllSkillEnhanceCode())
		else
			goutil.setActive(self._skillIcon.mainGO, true)
			goutil.setActive(self._carrySkill.mainGO, false)
			self._skillIcon:setSkillEnhanceMO(heroId, skillEnhanceMO)
		end
	end

	self._talentSkill:setNameVisible(false)
	self._talentSkill:setAwakeStatus(awakeStatus)

	if info.hideCD then
		self._skillIcon:setCdShow(false)
	end

	if showTalent then
		if addSkillCOWrapper then
			self._txtSkillName.text = addSkillCOWrapper:getName()
			self._txtTalentSkillDesc.text = addSkillCOWrapper:getTalentSkillDesc(skillStatus)
		else
			self._txtSkillName.text = skillCOWrapper:getName()
			self._txtTalentSkillDesc.text = ""
		end
	else
		self._txtSkillName.text = skillCOWrapper:getName()
	end

	if isActiveSkill then
		self._txtShoot.text = skillEnhanceMO:getReleaseDistanceLabel(skillStatus)
		self._txtRange.text = ActiveSkillCOUtil.getRangeLabel(skillCOWrapper, isActiveSkill, skillStatus)
		self._txtKind.text = ActiveSkillCOUtil.getCategoryLabel(skillCOWrapper, skillStatus)

		goutil.setActive(self._txtShoot.gameObject, true)
		goutil.setActive(self._txtRange.gameObject, true)
		goutil.setActive(self._txtShootNone.gameObject, false)
		goutil.setActive(self._txtRangeNone.gameObject, false)
	else
		self._txtKind.text = ActiveSkillCOUtil.getCategoryLabel(skillCOWrapper, skillStatus)

		goutil.setActive(self._txtShoot.gameObject, false)
		goutil.setActive(self._txtRange.gameObject, false)
		goutil.setActive(self._txtShootNone.gameObject, true)
		goutil.setActive(self._txtRangeNone.gameObject, true)
	end

	goutil.setActive(self._goNormalDi, not showTalent)
	goutil.setActive(self._goTalentUnlockDi, showTalent and awakeTalent)
	goutil.setActive(self._goTalentLockDi, showTalent and not awakeTalent)
	goutil.setActive(self._goAwakeRoot, showTalent and not awakeTalent and not BattleMgr.instance:isInBattle())
	goutil.setActive(self._txtTalentSkillDesc.gameObject, showTalent)

	local isPassiveSkill = ActiveSkillCOUtil.isPassive(skillCOWrapper, skillStatus)
	local skillType = skillCOWrapper:getSkillType(skillStatus)
	local typDef = BattleEnum.SkillCategory

	goutil.setActive(self._goRootKind, skillType < typDef.TALENT)
	goutil.setActive(self._goRootShoot, skillType < typDef.TALENT and not isPassiveSkill)
	goutil.setActive(self._goRootRange, skillType < typDef.TALENT and not isPassiveSkill)
end

function M:_onClickAwake()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, true) then
		return
	end

	local info = self:getFirstParam()
	local heroId = info.heroId

	printWarn("----has delete---")
end

return M
