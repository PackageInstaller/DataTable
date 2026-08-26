-- chunkname: @modules/logic/gm/view/GMFightRuleView.lua

module("modules.logic.gm.view.GMFightRuleView", package.seeall)

local GMFightRuleView = class("GMFightRuleView", BaseView)
local RuleType = {
	Left = 1,
	Right = 2
}

function GMFightRuleView:onInitView()
	self.goLeftRuleTitleItem = gohelper.findChild(self.viewGO, "left/Scroll View/Viewport/Content/rule_title")
	self.goLeftRuleItem = gohelper.findChild(self.viewGO, "left/Scroll View/Viewport/Content/ruleitem")
	self.goLeftIndicatorTitleItem = gohelper.findChild(self.viewGO, "left/Scroll View/Viewport/Content/indicator_title")
	self.goLeftIndicatorItem = gohelper.findChild(self.viewGO, "left/Scroll View/Viewport/Content/indicator_item")

	gohelper.setActive(self.goLeftRuleTitleItem, false)
	gohelper.setActive(self.goLeftRuleItem, false)
	gohelper.setActive(self.goLeftIndicatorTitleItem, false)
	gohelper.setActive(self.goLeftIndicatorItem, false)

	self.goRightRuleItem = gohelper.findChild(self.viewGO, "right/Scroll View/Viewport/Content/ruleitem")
	self.goRightRuleTitleItem = gohelper.findChild(self.viewGO, "right/Scroll View/Viewport/Content/rule_title")
	self.goRightIndicatorTitleItem = gohelper.findChild(self.viewGO, "right/Scroll View/Viewport/Content/indicator_title")
	self.goRightIndicatorItem = gohelper.findChild(self.viewGO, "right/Scroll View/Viewport/Content/indicator_item")

	gohelper.setActive(self.goRightRuleItem, false)
	gohelper.setActive(self.goRightRuleTitleItem, false)
	gohelper.setActive(self.goRightIndicatorTitleItem, false)
	gohelper.setActive(self.goRightIndicatorItem, false)

	self.ruleItemDict = {
		[RuleType.Left] = {},
		[RuleType.Right] = {}
	}
	self.ruleItemPrefabDict = self:getUserDataTb_()
	self.ruleItemPrefabDict[RuleType.Left] = self.goLeftRuleItem
	self.ruleItemPrefabDict[RuleType.Right] = self.goRightRuleItem
	self.ruleItemTitlePrefabDict = self:getUserDataTb_()
	self.ruleItemTitlePrefabDict[RuleType.Left] = self.goLeftRuleTitleItem
	self.ruleItemTitlePrefabDict[RuleType.Right] = self.goRightRuleTitleItem
	self.indicatorItemDict = {
		[RuleType.Left] = {},
		[RuleType.Right] = {}
	}
	self.indicatorItemPrefabDict = self:getUserDataTb_()
	self.indicatorItemPrefabDict[RuleType.Left] = self.goLeftIndicatorItem
	self.indicatorItemPrefabDict[RuleType.Right] = self.goRightIndicatorItem
	self.indicatorItemTitlePrefabDict = self:getUserDataTb_()
	self.indicatorItemTitlePrefabDict[RuleType.Left] = self.goLeftIndicatorTitleItem
	self.indicatorItemTitlePrefabDict[RuleType.Right] = self.goRightIndicatorTitleItem
end

function GMFightRuleView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnReceiveGmFightTeamDetailInfo, self.onReceiveMsg, self)
end

function GMFightRuleView:removeEvents()
	return
end

function GMFightRuleView:onReceiveMsg()
	self:refreshUI()
end

function GMFightRuleView:onOpen()
	self:refreshUI()
end

function GMFightRuleView:refreshUI()
	self:refreshItem(RuleType.Left)
	self:refreshItem(RuleType.Right)
end

function GMFightRuleView:refreshItem(ruleType)
	self:refreshRuleItem(ruleType)
	self:refreshIndicatorItem(ruleType)
end

function GMFightRuleView:refreshRuleItem(ruleType)
	local itemList = self.ruleItemDict[ruleType]

	for _, item in ipairs(itemList) do
		gohelper.setActive(item.go, false)
	end

	gohelper.setActive(self.ruleItemTitlePrefabDict[ruleType], false)

	if ruleType == RuleType.Left then
		if not GMFightEntityModel.instance.myTeamRuleList then
			local moList = GMFightEntityModel.instance.enemyTeamRuleList

			if not moList or #moList < 1 then
				return
			end

			gohelper.setActive(self.ruleItemTitlePrefabDict[ruleType], true)
			gohelper.setAsLastSibling(self.ruleItemTitlePrefabDict[ruleType])

			for index, ruleId in ipairs(moList) do
				local item = itemList[index]

				if not item then
					item = self:createRuleItem(ruleType)

					table.insert(itemList, item)
				end

				gohelper.setActive(item.go, true)
				gohelper.setAsLastSibling(item.go)

				item.txtId.text = string.format("id : " .. tostring(ruleId))

				local ruleCo = lua_skill.configDict[ruleId]

				item.txtName.text = string.format("名称 : " .. ((ruleCo or nil) and (ruleCo.name or "nil")))
			end
		end
	end
end

function GMFightRuleView:refreshIndicatorItem(ruleType)
	local itemList = self.indicatorItemDict[ruleType]

	for _, item in ipairs(itemList) do
		gohelper.setActive(item.go, false)
	end

	gohelper.setActive(self.indicatorItemTitlePrefabDict[ruleType], false)

	if ruleType == RuleType.Left then
		if not FightDataHelper.fieldMgr.indicatorDict then
			local dict = FightDataHelper.fieldMgr.enemyIndicatorDict
			local len = dict and tabletool.len(dict) or 0

			if len < 1 then
				return
			end

			gohelper.setActive(self.indicatorItemTitlePrefabDict[ruleType], true)
			gohelper.setAsLastSibling(self.indicatorItemTitlePrefabDict[ruleType])

			local index = 0

			for indicatorId, value in pairs(dict) do
				index = index + 1

				local item = itemList[index]

				if not item then
					item = self:createIndicatorItem(ruleType)

					table.insert(itemList, item)
				end

				gohelper.setActive(item.go, true)
				gohelper.setAsLastSibling(item.go)

				item.txtId.text = string.format("id : " .. tostring(indicatorId))
				item.txtValue.text = string.format("值 : " .. tostring(value.num))
			end
		end
	end
end

function GMFightRuleView:createRuleItem(ruleType)
	local rulePrefabItem = self.ruleItemPrefabDict[ruleType]
	local ruleItem = self:getUserDataTb_()

	ruleItem.go = gohelper.cloneInPlace(rulePrefabItem)
	ruleItem.txtId = gohelper.findChildText(ruleItem.go, "rule_id")
	ruleItem.txtName = gohelper.findChildText(ruleItem.go, "rule_name")

	return ruleItem
end

function GMFightRuleView:createIndicatorItem(ruleType)
	local itemPrefab = self.indicatorItemPrefabDict[ruleType]
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(itemPrefab)
	item.txtId = gohelper.findChildText(item.go, "indicator_id")
	item.txtValue = gohelper.findChildText(item.go, "indicator_value")

	return item
end

function GMFightRuleView:onClose()
	return
end

return GMFightRuleView
