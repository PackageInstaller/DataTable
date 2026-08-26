-- chunkname: @modules/logic/enemyinfo/view/EnemyInfoLayoutView.lua

module("modules.logic.enemyinfo.view.EnemyInfoLayoutView", package.seeall)

local EnemyInfoLayoutView = class("EnemyInfoLayoutView", BaseViewExtended)

function EnemyInfoLayoutView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoLayoutView:addEvents()
	return
end

function EnemyInfoLayoutView:removeEvents()
	return
end

function EnemyInfoLayoutView:_editableInitView()
	self.goTabContainer = gohelper.findChild(self.viewGO, "#go_tab_container")
	self.rectTrLeftContainer = gohelper.findChildComponent(self.viewGO, "#go_left_container", gohelper.Type_RectTransform)
	self.rectTrLine = gohelper.findChildComponent(self.viewGO, "#go_line", gohelper.Type_RectTransform)
	self.rectTrRightContainer = gohelper.findChildComponent(self.viewGO, "#go_right_container", gohelper.Type_RectTransform)
	self.rectTrRuleContainer = gohelper.findChildComponent(self.viewGO, "#go_left_container/#go_rule_container", gohelper.Type_RectTransform)
	self.rectTrLeftLine1 = gohelper.findChildComponent(self.viewGO, "#go_left_container/#go_line1", gohelper.Type_RectTransform)
	self.rectTrScrollEnemy = gohelper.findChildComponent(self.viewGO, "#go_left_container/#scroll_enemy", gohelper.Type_RectTransform)
	self.rectTrLeftLine2 = gohelper.findChildComponent(self.viewGO, "#go_left_container/#go_line2", gohelper.Type_RectTransform)
	self.rectTrCareerContainer = gohelper.findChildComponent(self.viewGO, "#go_left_container/#go_career_container", gohelper.Type_RectTransform)
	self.rectTrHeader = gohelper.findChildComponent(self.viewGO, "#go_right_container/#go_header", gohelper.Type_RectTransform)
	self.rectTrRightLine1 = gohelper.findChildComponent(self.viewGO, "#go_right_container/#go_line1", gohelper.Type_RectTransform)
	self.rectTrEnemyInfo = gohelper.findChildComponent(self.viewGO, "#go_right_container/#scroll_enemyinfo", gohelper.Type_RectTransform)
	self.rectTrRightLine2 = gohelper.findChildComponent(self.viewGO, "#go_right_container/#go_line2", gohelper.Type_RectTransform)
	self.rectTrSkillContainer = gohelper.findChildComponent(self.viewGO, "#go_right_container/#go_skill_container", gohelper.Type_RectTransform)
	self.rectTrEnemyInfoContent = gohelper.findChildComponent(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent", gohelper.Type_RectTransform)
	self.rectTrDesc = gohelper.findChildComponent(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#txt_desc", gohelper.Type_RectTransform)
	self.rectTrBossSpecialSkill = gohelper.findChildComponent(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill", gohelper.Type_RectTransform)
	self.rectTrResistance = gohelper.findChildComponent(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_resistance", gohelper.Type_RectTransform)
	self.rectTrPassiveSkill = gohelper.findChildComponent(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill", gohelper.Type_RectTransform)
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	self.addEventCb(self, EnemyInfoController.instance, EnemyInfoEvent.UpdateBattleInfo, self.onUpdateBattleInfo, self)
end

function EnemyInfoLayoutView:onUpdateBattleInfo(battleId)
	if self.battleId == battleId then
		return
	end

	self.battleId = battleId

	self.layoutMo:updateLayout(recthelper.getWidth(self.viewRectTr), self.enemyInfoMo.showLeftTab)
	self:updateRuleCount()

	if self.layouted then
		self:refreshScrollEnemyUpMargin()
	else
		self.layouted = true

		self:refreshLayout()
		self:refreshLeftContainerLayout()
		self:refreshRightContainerLayout()
	end
end

function EnemyInfoLayoutView:updateRuleCount()
	local battleCo = lua_battle.configDict[self.battleId]
	local additionRule = battleCo.additionRule

	self.ruleCount = 0

	if not string.nilorempty(additionRule) then
		local ruleList = string.split(additionRule, "|")

		self.ruleCount = #ruleList
	end
end

function EnemyInfoLayoutView:refreshScrollEnemyUpMargin()
	local lineShowRuleCount = math.floor(self.layoutMo.scrollEnemyWidth / EnemyInfoEnum.RuleItemWeight)
	local lineCount = math.ceil(self.ruleCount / lineShowRuleCount)
	local scrollEnemyTopMargin = lineCount * EnemyInfoEnum.RuleItemHeight + EnemyInfoEnum.RuleTopMargin

	if self.ruleCount < 1 then
		scrollEnemyTopMargin = scrollEnemyTopMargin + EnemyInfoEnum.WithTabOffset.ScrollEnemyUpMargin
	end

	local left = self.layoutMo:getScrollEnemyLeftMargin()

	self.rectTrLeftLine1.offsetMin = Vector2(left, -scrollEnemyTopMargin - EnemyInfoEnum.LineHeight)
	self.rectTrLeftLine1.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -scrollEnemyTopMargin)
	self.rectTrScrollEnemy.offsetMin = Vector2(left, EnemyInfoEnum.ScrollEnemyMargin.Bottom)
	self.rectTrScrollEnemy.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -scrollEnemyTopMargin)
end

function EnemyInfoLayoutView:refreshLayout()
	local layoutMo = self.layoutMo

	gohelper.setActive(self.goTabContainer, self.enemyInfoMo.showLeftTab)
	recthelper.setWidth(self.rectTrLeftContainer, layoutMo.leftTabWidth)
	recthelper.setWidth(self.rectTrRightContainer, layoutMo.rightTabWidth)
	recthelper.setAnchorX(self.rectTrLeftContainer, layoutMo.tabWidth)
	recthelper.setAnchorX(self.rectTrLine, layoutMo.tabWidth + layoutMo.leftTabWidth)
	recthelper.setAnchorX(self.rectTrRightContainer, layoutMo.tabWidth + layoutMo.leftTabWidth)
end

function EnemyInfoLayoutView:refreshLeftContainerLayout()
	local srcOffsetMin = self.rectTrRuleContainer.offsetMin
	local srcOffsetMax = self.rectTrRuleContainer.offsetMax
	local left = self.layoutMo:getScrollEnemyLeftMargin()

	self.rectTrRuleContainer.offsetMin = Vector2(left, srcOffsetMin.y)
	self.rectTrRuleContainer.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, srcOffsetMax.y)

	local scrollWidth = self.layoutMo.leftTabWidth - left - EnemyInfoEnum.ScrollEnemyMargin.Right

	self.layoutMo:setScrollEnemyWidth(scrollWidth)

	local lineShowRuleCount = math.floor(scrollWidth / EnemyInfoEnum.RuleItemWeight)
	local lineCount = math.ceil(self.ruleCount / lineShowRuleCount)
	local scrollEnemyTopMargin = lineCount * EnemyInfoEnum.RuleItemHeight + EnemyInfoEnum.RuleTopMargin

	if self.ruleCount < 1 then
		scrollEnemyTopMargin = scrollEnemyTopMargin + EnemyInfoEnum.WithTabOffset.ScrollEnemyUpMargin
	end

	self.rectTrLeftLine1.offsetMin = Vector2(left, -scrollEnemyTopMargin - EnemyInfoEnum.LineHeight)
	self.rectTrLeftLine1.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -scrollEnemyTopMargin)
	self.rectTrScrollEnemy.offsetMin = Vector2(left, EnemyInfoEnum.ScrollEnemyMargin.Bottom)
	self.rectTrScrollEnemy.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -scrollEnemyTopMargin)
	srcOffsetMin = self.rectTrLeftLine2.offsetMin
	srcOffsetMax = self.rectTrLeftLine2.offsetMax
	self.rectTrLeftLine2.offsetMin = Vector2(left, self.rectTrLeftLine2.offsetMin.y)
	self.rectTrLeftLine2.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, srcOffsetMax.y)
	srcOffsetMin = self.rectTrCareerContainer.offsetMin
	srcOffsetMax = self.rectTrCareerContainer.offsetMax
	self.rectTrCareerContainer.offsetMin = Vector2(left, self.rectTrCareerContainer.offsetMin.y)
	self.rectTrCareerContainer.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, srcOffsetMax.y)
end

function EnemyInfoLayoutView:refreshRightContainerLayout()
	local layoutMo = self.layoutMo
	local rightTabWidth = layoutMo.rightTabWidth
	local srcOffsetMin = self.rectTrHeader.offsetMin
	local srcOffsetMax = self.rectTrHeader.offsetMax
	local left = self.layoutMo:getEnemyInfoLeftMargin()

	self.rectTrHeader.offsetMin = Vector2(left, srcOffsetMin.y)
	self.rectTrHeader.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, srcOffsetMax.y)
	srcOffsetMin = self.rectTrRightLine1.offsetMin
	srcOffsetMax = self.rectTrRightLine1.offsetMax
	self.rectTrRightLine1.offsetMin = Vector2(left, self.rectTrRightLine1.offsetMin.y)
	self.rectTrRightLine1.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, srcOffsetMax.y)
	srcOffsetMin = self.rectTrEnemyInfo.offsetMin
	srcOffsetMax = self.rectTrEnemyInfo.offsetMax
	self.rectTrEnemyInfo.offsetMin = Vector2(left, self.rectTrEnemyInfo.offsetMin.y)
	self.rectTrEnemyInfo.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, srcOffsetMax.y)
	srcOffsetMin = self.rectTrRightLine2.offsetMin
	srcOffsetMax = self.rectTrRightLine2.offsetMax
	self.rectTrRightLine2.offsetMin = Vector2(left, self.rectTrRightLine2.offsetMin.y)
	self.rectTrRightLine2.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, srcOffsetMax.y)
	srcOffsetMin = self.rectTrSkillContainer.offsetMin
	srcOffsetMax = self.rectTrSkillContainer.offsetMax
	self.rectTrSkillContainer.offsetMin = Vector2(left, self.rectTrSkillContainer.offsetMin.y)
	self.rectTrSkillContainer.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, srcOffsetMax.y)

	local enemyInfoWidth = rightTabWidth - left - EnemyInfoEnum.EnemyInfoMargin.Right

	layoutMo:setEnemyInfoWidth(enemyInfoWidth)
	recthelper.setWidth(self.rectTrEnemyInfoContent, enemyInfoWidth)
	recthelper.setWidth(self.rectTrDesc, enemyInfoWidth)
	recthelper.setWidth(self.rectTrBossSpecialSkill, enemyInfoWidth)
	recthelper.setWidth(self.rectTrResistance, enemyInfoWidth)
	recthelper.setWidth(self.rectTrPassiveSkill, enemyInfoWidth)
end

function EnemyInfoLayoutView:onClose()
	return
end

function EnemyInfoLayoutView:onDestroyView()
	return
end

return EnemyInfoLayoutView
