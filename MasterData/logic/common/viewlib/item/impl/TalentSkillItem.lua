-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/TalentSkillItem.lua

module("logic.common.viewlib.item.impl.TalentSkillItem", package.seeall)

local M = class("TalentSkillItem", UIReusableLuaBehavior)

function M:ctor(compContainer)
	self._registry = ViewElementsRegistry.New(compContainer)

	M.super.ctor(self, compContainer)
end

function M:buildUI()
	local registry = self:getRegistry()

	self._goRootUnlock = registry:findUIElement("talent_skill_item_-1919648946")
	self._goRootLock = registry:findUIElement("talent_skill_item_-87700964")
	self._goName = registry:findUIElement("talent_skill_item_-922847846")
	self._imgIconUnlock = registry:findUIElement("talent_skill_item_-1738626459", UIComponentType.Image)
	self._imgIconLock = registry:findUIElement("talent_skill_item_-756015567", UIComponentType.Image)
	self._txtName = registry:findUIElement("talent_skill_item_-628747181", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("talent_skill_item_651467712"))
	self._goEmpty = goutil.findChild(self.mainGO, "lock/wenhao")
	self._clickHandler = Handler.New()
	self._isPassEvent = true
	self._canClick = true
	self._heroId = false
	self._skillId = false
	self._skillEnhanceCodes = false
	self._skillStatus = false
	self._isBattleView = false
	self._isSetNativeSize = false
	self._scaleChanged = false

	goutil.setActive(self._goName, true)
end

function M:destroyUI()
	self._imgIconUnlock = nil
	self._imgIconLock = nil
	self._txtName = nil
	self._btnClick = nil
	self._clickHandler = nil
	self._heroId = nil
	self._skillId = nil
	self._isPassEvent = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end

	self._isBattleView = false
	self._skillEnhanceCodes = nil
	self._skillStatus = nil
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
	IconLoader.clearSprite(self._imgIconUnlock)
	IconLoader.clearSprite(self._imgIconLock)
end

function M:getRegistry()
	return self._registry
end

function M:setHeroAndSkillId(heroId, skillId, additionalSkillId)
	self._heroId = heroId
	self._skillId = skillId

	if not skillId then
		goutil.setActive(self._imgIconUnlock.gameObject, false)
		goutil.setActive(self._imgIconLock.gameObject, false)
		goutil.setActive(self._goEmpty, true)

		return
	end

	local skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(heroId, skillId)

	if not skillEnhanceMO then
		goutil.setActive(self._goEmpty, true)

		return false
	end

	goutil.setActive(self._goEmpty, false)

	local addSkillEnhanceMO = false

	if additionalSkillId then
		addSkillEnhanceMO = SkillEnhanceMO.getSharedMO(additionalSkillId)

		addSkillEnhanceMO:rebuild()
	end

	self:setSkillEnhanceMO(heroId, skillEnhanceMO, addSkillEnhanceMO)
	SkillEnhanceMO.releaseSharedMO(addSkillEnhanceMO)
end

function M:setSkillEnhanceMO(heroId, skillEnhanceMO, addSkillEnhanceMO)
	self._heroId = heroId

	local skillCO = skillEnhanceMO:getSkillCO()
	local skillId = skillCO.code
	local skillName = skillCO.name

	self._skillId = skillCO.code

	if addSkillEnhanceMO then
		local addSkillCO = addSkillEnhanceMO:getSkillCO()

		skillId = addSkillCO.code
		skillName = addSkillCO.name
	end

	self._txtName.text = StringUtil.randomReplaceBlackBlock(skillName)

	goutil.setActive(self._imgIconUnlock.gameObject, true)
	goutil.setActive(self._imgIconLock.gameObject, true)
	BattleIconName.setSkillIcon(self._imgIconUnlock, skillId, self._onIconLoaded, self)
	BattleIconName.setSkillIcon(self._imgIconLock, skillId, self._onIconLoaded, self)
end

function M:_onIconLoaded(img)
	if self._isSetNativeSize then
		img:SetNativeSize()

		if self._scaleChanged then
			local width = goutil.getWidth(img.gameObject.transform)

			if width > 200 then
				TransformUtils.SetLocalScale(img.gameObject.transform, 0.6, 0.6, 0.6)
			else
				TransformUtils.SetLocalScale(img.gameObject.transform, 1.3, 1.3, 1)
			end
		end
	end
end

function M:setNativeSize(state)
	self._isSetNativeSize = state
end

function M:setScaleChanged(state)
	self._scaleChanged = state
end

function M:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function M:setBindGo(bindGo)
	self._bindGo = bindGo
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:_onClickItem()
	if not self._canClick then
		return
	end

	if self._clickHandler:hadCallback() then
		local skillInfo = ToolTipsMgr.getSkillTipsInfo()

		skillInfo.heroId = self._heroId
		skillInfo.skillId = self._skillId
		skillInfo.enhanceCodes = self._skillEnhanceCodes
		skillInfo.skillStatus = self._skillStatus
		skillInfo.awakeStatus = self._awakeStatus
		skillInfo.entityId = self._entityId
		skillInfo.popType = CommEnum.TipsPopType.Right

		self._clickHandler:call(skillInfo, self.mainGO)
	else
		self:showSkillTips()
	end
end

function M:setPopupSkillItemPassEvent(isPassEvent)
	self._isPassEvent = isPassEvent
end

function M:showSkillTips()
	local hideCD = false
	local awakeStatus = self._awakeStatus
	local enhanceCodes, skillStatus
	local hideEnhanceDetail = false
	local hasDispatch
	local simulateCloseWhenDraging = true
	local passEvent = self._isPassEvent
	local bindGo = self._bindGo
	local popType = CommEnum.TipsPopType.Right

	if not self._bindGo then
		bindGo = self.mainGO.transform.parent
	end

	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._skillId
	skillInfo.defaultShowAll = true
	skillInfo.hangGO = bindGo
	skillInfo.popType = popType
	skillInfo.enhanceCodes = enhanceCodes
	skillInfo.skillStatus = skillStatus
	skillInfo.awakeStatus = awakeStatus
	skillInfo.hideEnhanceDetail = hideEnhanceDetail
	skillInfo.hasDispatch = hasDispatch
	skillInfo.simulateCloseWhenDraging = simulateCloseWhenDraging
	skillInfo.isPassEvent = true

	ToolTipsMgr.showBattleSkillTips(skillInfo)
end

function M:setCanClick(status)
	self._canClick = status
end

function M:setNameVisible(isShow)
	goutil.setActive(self._goName, isShow)
end

function M:setIsBattleView(isBattleView)
	self._isBattleView = isBattleView
end

function M:setAwakeStatus(awakeStatus)
	self._awakeStatus = awakeStatus

	local isAwake = awakeStatus == CommEnum.TalentSkillAwakeStatus.Unlock

	goutil.setActive(self._goRootUnlock, isAwake)
	goutil.setActive(self._goRootLock, not isAwake)
end

function M:setEnhanceCodesAndStatus(skillEnhanceCodes, skillStatus)
	self._skillEnhanceCodes = skillEnhanceCodes
	self._skillStatus = skillStatus
end

function M:getHeroId()
	return self._heroId
end

function M:getSkillId()
	return self._skillId
end

function M:setSelectGo(go)
	goutil.setActive(go, false)

	self._selectGo = go
end

function M:setSelected(status)
	goutil.setActive(self._selectGo, status)
end

return M
