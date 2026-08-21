-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uipool/BattleSkillIcon.lua

module("logic.battle.uipool.BattleSkillIcon", package.seeall)

local BattleSkillIcon = class("BattleSkillIcon", IBattleReusable)
local kPoolRoot = PoolRootUtil.createUIPoolRoot("BattleSkillIconPool")

function BattleSkillIcon:ctor(gameObject)
	if gameObject then
		self.mainGO = gameObject
	else
		local resMgr = BattleMgr.instance:getResourceMgr()
		local mainGO = resMgr:getInst(ViewlibResPath.SkillItem1)

		goutil.addChildToParent(mainGO, kPoolRoot)

		self.mainGO = mainGO
	end

	self:buildUI()
end

function BattleSkillIcon:reuse()
	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
end

function BattleSkillIcon:reset()
	self:resetUI()
	goutil.addChildToParent(self.mainGO, kPoolRoot)
end

function BattleSkillIcon:destroy()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function BattleSkillIcon:buildUI()
	self._goCommon = goutil.findChild(self.mainGO, "common")
	self._goSpecial = goutil.findChild(self.mainGO, "pas")
	self._goFinal = goutil.findChild(self.mainGO, "final")
	self._goNone = goutil.findChild(self.mainGO, "none").gameObject
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgIcon")
	self._goSelect = goutil.findChild(self.mainGO, "imgSelect").gameObject
	self._goCd = goutil.findChild(self.mainGO, "cd")
	self._goHasCd = goutil.findChild(self.mainGO, "cdSign")
	self._imgSign = goutil.addComponentOnce(goutil.findChild(self.mainGO, "passivitySign"), ComponentType.ImageLocalization)
	self._txtCd = goutil.findChildTextComponent(self.mainGO, "cd/txtNum")
	self._btnClick = Astral.UIClickTrigger.Get(goutil.findChild(self.mainGO, "click"))
	self._clickHandler = Handler.New()

	self._btnClick:AddClickListener(self._onClick, self)

	self._skillId = false
end

function BattleSkillIcon:resetUI()
	self._clickHandler:clear()
	IconLoader.clearSprite(self._imgIcon)
	goutil.setActive(self._imgIcon.gameObject, true)
	self:setSelected(false)
end

function BattleSkillIcon:destroyUI()
	self._btnClick:RemoveClickListener()
	self._clickHandler:clear()

	self._goNone = nil
	self._goCd = nil
	self._imgIcon = nil
	self._txtCd = nil
end

function BattleSkillIcon:OnDestroy()
	self:destroyUI()
end

function BattleSkillIcon:setEmpty(skillType)
	goutil.setActive(self._goNone, true)
	goutil.setActive(self._goCd, false)
	goutil.setActive(self._goCommon, skillType ~= BattleEnum.SkillCategory.SPECIAL and skillType ~= BattleEnum.SkillCategory.TRUMP)
	goutil.setActive(self._goSpecial, skillType == BattleEnum.SkillCategory.SPECIAL)
	goutil.setActive(self._goFinal, skillType == BattleEnum.SkillCategory.TRUMP)
	IconLoader.clearSprite(self._imgIcon)
	goutil.setActive(self._imgIcon.gameObject, false)
	goutil.setActive(self._imgSign.gameObject, false)
	goutil.setActive(self._goHasCd, false)

	self._isInCd = false
	self._heroId = false
	self._entityId = false
	self._skillId = false
	self._skillStatus = false
	self._skillEnhanceCodes = {}
	self.mainGO.name = "skill_icon"
end

function BattleSkillIcon:setSkillInfo(heroId, skillId, skillStatus, skillEnhanceCodes, entityId)
	self._heroId = heroId
	self._skillId = skillId
	self._entityId = entityId
	self._skillStatus = skillStatus
	self._skillEnhanceCodes = skillEnhanceCodes
	self._isInCd = false

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	self._hasCd = skillCOWrapper:getCd() > 0
	self._skillType = skillCOWrapper:getSkillType(skillStatus)

	local isPassiveSkill = ActiveSkillCOUtil.isPassive(skillCOWrapper, skillStatus)

	goutil.setActive(self._goNone, false)
	goutil.setActive(self._goCommon, self._skillType ~= BattleEnum.SkillCategory.SPECIAL and self._skillType ~= BattleEnum.SkillCategory.TRUMP)
	goutil.setActive(self._goSpecial, self._skillType == BattleEnum.SkillCategory.SPECIAL)
	goutil.setActive(self._goFinal, self._skillType == BattleEnum.SkillCategory.TRUMP)

	local signInfo = ActiveSkillCOUtil.getSkillSignInfo(skillCOWrapper:getSkillCode(), skillStatus)

	self._imgSign:SetSprite(signInfo.spriteName)
	goutil.setActive(self._imgSign.gameObject, signInfo.isSign)
	BattleIconName.setSkillIcon(self._imgIcon, skillId)

	local iconMat = isPassiveSkill and CommonResPath.SkillIconPassiveMat or CommonResPath.SkillIconMat

	goutil.setActive(self._imgIcon.gameObject, true)

	self._imgIcon.material = CommonPreloader.instance:getMaterialsCommAsset(iconMat)
	self.mainGO.name = "skill_icon" .. skillCOWrapper:getSkillType(skillStatus)
end

function BattleSkillIcon:getHeroId()
	return self._heroId
end

function BattleSkillIcon:getSkillId()
	return self._skillId
end

function BattleSkillIcon:setCd(cd)
	if cd and cd > 0 then
		self._isInCd = true
		self._txtCd.text = cd

		goutil.setActive(self._goCd, true)
	else
		self._isInCd = false

		goutil.setActive(self._goCd, false)
	end

	self:_updateHasCd()
end

function BattleSkillIcon:setSelected(selected)
	goutil.setActive(self._goSelect, selected)
end

function BattleSkillIcon:_updateHasCd()
	goutil.setActive(self._goHasCd, false)
end

function BattleSkillIcon:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function BattleSkillIcon:setTipsPopType(popType)
	self._popType = popType
end

function BattleSkillIcon:_onClick()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._skillId
	skillInfo.enhanceCodes = self._skillEnhanceCodes
	skillInfo.skillStatus = self._skillStatus
	skillInfo.awakeStatus = false
	skillInfo.entityId = self._entityId
	skillInfo.popType = self._popType

	self._clickHandler:call(skillInfo, self.mainGO)
end

return BattleSkillIcon
