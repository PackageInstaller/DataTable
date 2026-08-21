-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/SkillItem1.lua

module("logic.common.viewlib.item.impl.SkillItem1", package.seeall)

local M = class("SkillItem1", UIReusableLuaBehavior)

function M:ctor(compContainer)
	self._registry = ViewElementsRegistry.New(compContainer)

	M.super.ctor(self, compContainer)
end

function M:buildUI()
	local registry = self:getRegistry()

	self._goCommon = goutil.findChild(self.mainGO, "common")
	self._goSpecial = goutil.findChild(self.mainGO, "pas")
	self._goFinal = goutil.findChild(self.mainGO, "final")
	self._goUpgradeSignCommon = registry:findUIElement("skill_item_1_-2079803042")
	self._goUpgradeSignPas = registry:findUIElement("skill_item_1_-126809233")
	self._goNone = registry:findUIElement("skill_item_1_491627332")
	self._goLockCommon = registry:findUIElement("skill_item_1_-1909552867")
	self._goLockPas = registry:findUIElement("skill_item_1_899496506")
	self._goIsPassive = goutil.findChild(self.mainGO, "passivitySign")
	self._imgIcon = registry:findUIElement("skill_item_1_-2055718383", UIComponentType.Image)
	self._goCd = registry:findUIElement("skill_item_1_849668862")
	self._txtCd = registry:findUIElement("skill_item_1_-30558874", UIComponentType.Text)
	self._goSelected = registry:findUIElement("skill_item_1_1454546744")
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("skill_item_1_1663929415"))
	self._clickHandler = Handler.New()
	self._isPassEvent = true
	self._canClick = true
	self._heroId = false
	self._skillId = false

	goutil.setActive(self._goSelected, false)
	goutil.setActive(self._btnClick.gameObject, true)
	self:setMaskEnable(false)
end

function M:destroyUI()
	self._imgIcon = nil
	self._txtCd = nil
	self._goSelected = nil
	self._btnClick = nil
	self._clickHandler = nil
	self._heroId = nil
	self._skillId = nil
	self._goCd = nil
	self._isPassEvent = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickItem, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._clickHandler:clear()
	IconLoader.clearSprite(self._imgIcon)
end

function M:getRegistry()
	return self._registry
end

function M:setHeroAndSkillId(heroId, skillId)
	self._heroId = heroId
	self._skillId = skillId

	local skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(heroId, skillId)

	if not skillEnhanceMO then
		return false
	end

	self:setSkillEnhanceMO(heroId, skillEnhanceMO)
end

function M:setSkillEnhanceMO(heroId, skillEnhanceMO)
	self._heroId = heroId

	local skillCO = skillEnhanceMO:getSkillCO()
	local skillCOWrapper = skillEnhanceMO:getSkillCOWrapper()
	local skillCategory = skillCOWrapper:getSkillType(BattleEnum.SkillStatus.Normal)
	local isTalent = ActiveSkillCOUtil.isTalent(skillCOWrapper)
	local isAddEnhanced = false

	self._skillId = skillCO.code

	BattleIconName.setSkillIcon(self._imgIcon, self._skillId)

	local cd = skillCO.cd

	goutil.setActive(self._goCd.gameObject, cd > 0)

	self._txtCd.text = cd
	self._isPassiveSkill = ActiveSkillCOUtil.isPassive(skillCOWrapper)

	goutil.setActive(self._goCommon, skillCategory ~= BattleEnum.SkillCategory.SPECIAL and skillCategory ~= BattleEnum.SkillCategory.TRUMP)
	goutil.setActive(self._goSpecial, skillCategory == BattleEnum.SkillCategory.SPECIAL)
	goutil.setActive(self._goFinal, skillCategory == BattleEnum.SkillCategory.TRUMP)
	goutil.setActive(self._goIsPassive, self._isPassiveSkill)
	goutil.setActive(self._goUpgradeSignCommon, isAddEnhanced and (isTalent or not self._isPassiveSkill))
	goutil.setActive(self._goUpgradeSignPas, isAddEnhanced and self._isPassiveSkill)

	local iconMat = self._isPassiveSkill and CommonResPath.SkillIconPassiveMat or CommonResPath.SkillIconMat

	self._imgIcon.material = CommonPreloader.instance:getMaterialsCommAsset(iconMat)
end

function M:setSelected(isSelected)
	goutil.setActive(self._goSelected, isSelected)
end

function M:setCdShow(show)
	goutil.setActive(self._goCd.gameObject, show)
end

function M:setMaskEnable(enable)
	if enable then
		local isPas = self._isPassiveSkill

		goutil.setActive(self._goLockPas, enable and isPas)
		goutil.setActive(self._goLockCommon, enable and not isPas)
	else
		goutil.setActive(self._goLockPas, enable)
		goutil.setActive(self._goLockCommon, enable)
	end
end

function M:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function M:setBindGo(bindGo)
	self._bindGo = bindGo
end

function M:_onClickItem()
	if not self._canClick then
		return
	end

	local hasListener = self._clickHandler:call(self._skillId)

	if not hasListener then
		self:showSkillTips()
	end
end

function M:setPopupSkillItemPassEvent(isPassEvent)
	self._isPassEvent = isPassEvent
end

function M:showSkillTips()
	if not self._bindGo then
		ToolTipsMgr.showSkillTips(self._heroId, self._skillId, self.mainGO.transform.parent, self._isPassEvent)
	else
		ToolTipsMgr.showSkillTips(self._heroId, self._skillId, self._bindGo, self._isPassEvent)
	end
end

function M:setCanClick(status)
	self._canClick = status
end

return M
