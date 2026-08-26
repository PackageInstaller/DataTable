-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_LevelDetailViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_LevelDetailViewContainer", package.seeall)

local V3a2_BossRush_LevelDetailViewContainer = class("V3a2_BossRush_LevelDetailViewContainer", BaseViewContainer)

function V3a2_BossRush_LevelDetailViewContainer:buildViews()
	local views = {}

	self._bossRushViewRule = V1a4_BossRushViewRule.New()

	table.insert(views, V3a2_BossRush_LevelDetailView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, self._bossRushViewRule)

	self._bossRushViewRule.offsetAnchor = {
		-180,
		0
	}

	return views
end

function V3a2_BossRush_LevelDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function V3a2_BossRush_LevelDetailViewContainer:getBossRushViewRule()
	return self._bossRushViewRule
end

function V3a2_BossRush_LevelDetailViewContainer:diffRootChild(viewGO)
	self:setRootChild(viewGO)

	return true
end

function V3a2_BossRush_LevelDetailViewContainer:setRootChild(viewSelf)
	local root = gohelper.findChild(viewSelf.viewGO, "DetailPanel/Condition")

	viewSelf._goadditionRule = gohelper.findChild(root, "#scroll_ConditionIcons")
	viewSelf._goruletemp = gohelper.findChild(viewSelf._goadditionRule, "#go_ruletemp")
	viewSelf._imagetagicon = gohelper.findChildImage(viewSelf._goruletemp, "#image_tagicon")
	viewSelf._gorulelist = gohelper.findChild(viewSelf._goadditionRule, "Viewport/content")
	viewSelf._btnadditionRuleclick = gohelper.findChildButtonWithAudio(viewSelf._goadditionRule, "#btn_additionRuleclick")
end

return V3a2_BossRush_LevelDetailViewContainer
