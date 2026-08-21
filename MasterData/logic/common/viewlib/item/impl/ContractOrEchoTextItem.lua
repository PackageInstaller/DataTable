-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/ContractOrEchoTextItem.lua

module("logic.common.viewlib.item.impl.ContractOrEchoTextItem", package.seeall)

local M = class("ContractOrEchoTextItem", UIReusableLuaBehavior)
local kColorLight = "#E2E2E2"
local kColorGray = "#737373"

function M:ctor(compContainer)
	self._registry = ViewElementsRegistry.New(compContainer)

	M.super.ctor(self, compContainer)
end

function M:buildUI()
	local registry = self:getRegistry()

	self._goContractBreakPoint = registry:findUIElement("contract_break_point_2103825544")

	local contractRoot = registry:findUIElement("contract_break_point_80752649")

	self._anchorList = {}

	for i = 1, contractRoot.transform.childCount do
		self._anchorList[i] = contractRoot.transform:GetChild(i - 1).gameObject
	end

	local goBreakPoint = registry:findUIElement("break_point_-2114175626")

	self._breakPointView = Astral.SimpleLuaComponentContainer.Add(goBreakPoint, BreakPointItemView)
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtContent")
end

function M:getRegistry()
	return self._registry
end

function M:destroyUI()
	self._breakPointView = nil
	self._txtContent = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:setEnhanceCode(index, skillType, enhanceCode, isGained)
	local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

	goutil.setActive(self._goContractBreakPoint, skillType == BattleEnum.SkillCategory.TALENT)
	self._breakPointView:setVisible(skillType == BattleEnum.SkillCategory.ECHO)

	if skillType == BattleEnum.SkillCategory.ECHO then
		self._breakPointView:setRankView(5)
	elseif skillType == BattleEnum.SkillCategory.TALENT then
		for i, v in ipairs(self._anchorList) do
			goutil.setActive(v, i <= index)
		end
	end

	self._txtContent.text = skillEnhanceCOWrapper:getDescription(isGained)

	local colorString = isGained and kColorLight or kColorGray

	TextUtils.SetColor(self._txtContent, colorString)
end

return M
