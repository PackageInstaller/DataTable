-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/CharacterThinkingPanelFragmentView.lua

module("logic.extensions.charactersystem.view.thinking.CharacterThinkingPanelFragmentView", package.seeall)

local M = class("CharacterThinkingPanelFragmentView", CharacterMainSystemSubViewBase)
local kMaxThinkingCount = 3

function M:getPageIndex()
	return CommEnum.CharacterSystemTab.Thinking
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()
	local rectRootThinking = self._registry:getUIComponent("carry_thought_panel_2014761685", UIComponentType.RectTransform)

	self._thinkingItemViews = {}

	for i = 0, rectRootThinking.childCount - 1 do
		local go = rectRootThinking:GetChild(i).gameObject

		table.insert(self._thinkingItemViews, Astral.SimpleLuaComponentContainer.Add(go, ThinkingItemView))
	end

	self._stateGo1 = self._registry:getGo("carry_thought_panel_1234963879")
	self._stateGo2 = self._registry:getGo("carry_thought_panel_-1059489695")
	self._cellTipsSkill1 = Astral.SimpleLuaComponentContainer.Add(self._registry:getGo("6&thought_skill_item_-1906135219"), ThinkingSkillItemView)
	self._cellTipsSkill2 = Astral.SimpleLuaComponentContainer.Add(self._registry:getGo("7&thought_skill_item_-1906135219"), ThinkingSkillItemView)
	self._thoughtBg = self._registry:getImage("carry_thought_panel_1241284010")
	self._txtTipsSkillLevelPre = self._registry:getText("carry_thought_panel_-1393159721")
	self._txtTipsThinkName = self._registry:getText("carry_thought_panel_500695830")
	self._txtTipsSkillName = self._registry:getText("carry_thought_panel_1334073024")
	self._txtTipsSkillDesc = self._registry:getUIComponent("carry_thought_panel_1700982771", UIComponentType.TextMeshProUGUI)
	self._btnLeft = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("8&btn_left_-1571983320"), CommButton)
	self._btnRight = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("9&btn_right_1251431307"), CommButton)
	self._btnMiddle = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("10&btn_middle_-31477526"), CommButton)
	self._btnReturnPre = self._registry:getBtn("carry_thought_panel_-1352687186")
	self._btnSkillDesc = self._registry:getBtn("carry_thought_panel_665550729")
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._attributeLst = nil
end

function M:bindEvents()
	self._btnLeft:AddClickListener(self._onClickChange, self)
	self._btnRight:AddClickListener(self._onClickUpgrade, self)
	self._btnMiddle:AddClickListener(self._onClickChange, self)
	self._btnReturnPre:AddClickListener(self._onClickReturnPre, self)
	self._btnSkillDesc:AddClickListener(self._onClickSkillDesc, self)

	for _, cell in pairs(self._thinkingItemViews or {}) do
		cell:setClickCallback(self._onClickThinkingItemCell, self)
	end

	self._cellTipsSkill2:setClickCallback(self._onClickSkill, self)
end

function M:unbindEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnMiddle:RemoveClickListener()
	self._btnReturnPre:RemoveClickListener()
	self._btnSkillDesc:RemoveClickListener()

	for _, cell in pairs(self._thinkingItemViews or {}) do
		cell:setClickCallback(nil, nil)
	end

	self._cellTipsSkill2:setClickCallback(nil, nil)
end

function M:onEnter()
	M.super.onEnter(self)
	self:setEvents(true)

	local selectedThinkingId = ThinkingController.instance:getSelectedThinkingId()

	if not selectedThinkingId then
		local heroData = self:getHeroData()
		local thinkingIds = heroData:getAvailableThinkingIds()

		selectedThinkingId = thinkingIds and thinkingIds[1] or -1
	end

	ThinkingController.instance:setSelectedThinkingId(selectedThinkingId)

	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkId = thinkingItemData:getThinkingMoId()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()
	local hasUsingThinkingSkill = usingThinkingSkillId and usingThinkingSkillId > 0

	if usingThinkId then
		ThinkingController.instance:setSelectedThinkingId(usingThinkId)
	end

	local isChangeState = ThinkingModel.instance:getShowChangeState()

	goutil.setActive(self._stateGo1, not hasUsingThinkingSkill or isChangeState)
	goutil.setActive(self._stateGo2, hasUsingThinkingSkill and not isChangeState)
	ThinkingModel.instance:setShowChangeState(false)
	self:_refreshView()

	if hasUsingThinkingSkill then
		self:_refreshTipsThinkingSkill()
	end
end

function M:onExit()
	self:setEvents(false)
end

function M:setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.THINKING_REFRESH, self._handleThinkingHeroRefresh, self)
		GlobalDispatcher:addEventListener(EventType.THINKING_HERO_REFRESH, self._handleThinkingHeroRefresh, self)
		GlobalDispatcher:addEventListener(EventType.THINKING_CHANGE_VIEW, self._changeStatePanel, self)
	else
		GlobalDispatcher:removeEventListener(EventType.THINKING_REFRESH, self._handleThinkingHeroRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.THINKING_HERO_REFRESH, self._handleThinkingHeroRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.THINKING_CHANGE_VIEW, self._changeStatePanel, self)
	end
end

function M:_handleThinkingHeroRefresh(e)
	self:_refreshView()

	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()
	local hasUsingThinkingSkill = usingThinkingSkillId and usingThinkingSkillId > 0

	if hasUsingThinkingSkill then
		self:_refreshTipsThinkingSkill()
	end

	local selectedThinkingId = ThinkingController.instance:getSelectedThinkingId()

	if not selectedThinkingId then
		local heroData = self:getHeroData()
		local thinkingIds = heroData:getAvailableThinkingIds()

		selectedThinkingId = thinkingIds and thinkingIds[1] or -1
	end
end

function M:_onClickSkill(skillId)
	skillId = skillId or 0

	if skillId <= 0 then
		return
	end

	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self:getHeroId()
	skillInfo.skillId = skillId
	skillInfo.hangGO = self._cellTipsSkill2:getMainGo()

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onClickThinkingItemCell(thinkingId)
	thinkingId = thinkingId or 0

	local online = ThinkingConfig.instance:getThinkingOnline(thinkingId)

	if thinkingId <= 0 or not online then
		ToolTipsMgr.showCharacterTopToast(lang("tip_thought_or_skill_not_online"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	ThinkingController.instance:setSelectedThinkingId(thinkingId)
	self:_refreshView()
	ViewMgr.instance:open(ViewName.ThinkingInfoView, {
		isFromTotalPreview = false,
		thinkingId = thinkingId
	})
end

function M:getHeroId()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		return heroData:getId()
	end

	return nil
end

function M:getHeroData(heroId)
	heroId = heroId or self:getHeroId()

	local data = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not data then
		printError(string.format("无法找到角色[%s]的数据", heroId))
	end

	return data
end

function M:_refreshView()
	local heroData = self:getHeroData()
	local thinkingIds = heroData:getAvailableThinkingIds()
	local thinkingItemData = heroData:getThinkingItemData()

	for index, cell in ipairs(self._thinkingItemViews) do
		local thinkingId = thinkingIds[index] or -1
		local isExist = thinkingId > 0
		local isLock = true
		local isSelect = thinkingId == ThinkingController.instance:getSelectedThinkingId()
		local isUsing = false

		if isExist then
			isUsing = thinkingItemData:getThinkingMoId() == thinkingId
			isLock = not thinkingItemData:isThinkingUnlocked(thinkingId)
		end

		cell:refreshView(thinkingId, thinkingItemData)
		cell:setLockVisible(isLock)
		cell:setSelected(isSelect, true)
		cell:setIsUsing(isUsing)
		cell:setActiveFlagVisible(false)
	end
end

function M:_refreshTipsThinkingSkill()
	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()
	local thinkingId = ThinkingController.instance:getSelectedThinkingId()
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillId = usingThinkingSkillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local isMaxLevel = thinkingMO:isMaxLevelSkill(skillId)

	self._txtTipsSkillLevelPre.text = string.format("Lv.%s", skillLevel)

	local skillName, skillDesc, skillIcon = thinkingMO:getSkillData(skillId, skillLevel)

	self._txtTipsThinkName.text = thinkingMO:getName()
	self._txtTipsSkillName.text = skillName
	self._txtTipsSkillDesc.text = skillDesc

	self._cellTipsSkill1:refreshView(skillId, skillLevel + 1, false)
	self._cellTipsSkill1:setAtPresentVisible(true)
	self._cellTipsSkill2:refreshView(skillId, skillLevel + 1, false)

	local cfg = ThinkingConfig.instance:getThinkingCO(thinkingId)

	if cfg then
		IconLoader.setSprite(self._thoughtBg, IconType.Thought, cfg.iconBg)
	end

	self._btnLeft:setActive(not isMaxLevel)
	self._btnRight:setActive(not isMaxLevel)
	self._btnMiddle:setActive(isMaxLevel)
end

function M:_changeStatePanel()
	goutil.setActive(self._stateGo1, true)
	goutil.setActive(self._stateGo2, false)
end

function M:_onClickChange()
	self:_changeStatePanel()
end

function M:_onClickUpgrade()
	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local skillId = thinkingItemData:getWearingSkillId()
	local thinkingId = ThinkingController.instance:getSelectedThinkingId()

	ViewMgr.instance:open(ViewName.ThinkingUpgradeView, {
		skillId = skillId,
		thinkingId = thinkingId
	})
end

function M:_onClickReturnPre()
	goutil.setActive(self._stateGo1, false)
	goutil.setActive(self._stateGo2, true)
end

function M:_onClickSkillDesc()
	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local skillId = thinkingItemData:getWearingSkillId()
	local thinkingId = ThinkingController.instance:getSelectedThinkingId()
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local skillEnhanceMO = thinkingMO:getSkillEnhanceMO(skillId, skillLevel)

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()

		local bindGo = self._btnSkillDesc.gameObject
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

return M
