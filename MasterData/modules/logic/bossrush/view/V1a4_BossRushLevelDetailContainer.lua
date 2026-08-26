-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushLevelDetailContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailContainer", package.seeall)

local V1a4_BossRushLevelDetailContainer = class("V1a4_BossRushLevelDetailContainer", BaseViewContainer)

function V1a4_BossRushLevelDetailContainer:buildViews()
	self._bossRushViewRule = V1a4_BossRushViewRule.New()

	local actId = BossRushConfig.instance:getActivityId()
	local helpId = self:_getHelpId(actId)

	self._levelDetail = V1a4_BossRushLevelDetail.New()

	local views = {
		self._levelDetail,
		TabViewGroup.New(1, "top_left"),
		self._bossRushViewRule
	}

	if helpId then
		local helpShowView = HelpShowView.New()

		helpShowView:setHelpId(helpId)
		helpShowView:setDelayTime(0.5)
		table.insert(views, helpShowView)
	end

	return views
end

function V1a4_BossRushLevelDetailContainer:_getHelpId(actId)
	local stage = self.viewParam.stage

	if stage then
		self._stageHelpId = self._stageHelpId or {
			[VersionActivity2_9Enum.ActivityId.BossRush] = {
				HelpEnum.HelpId.BossRushViewHelpSp01_1,
				HelpEnum.HelpId.BossRushViewHelpSp01_2
			}
		}

		local helps = self._stageHelpId[actId]

		return helps and helps[stage]
	end
end

function V1a4_BossRushLevelDetailContainer:getBossRushViewRule()
	return self._bossRushViewRule
end

function V1a4_BossRushLevelDetailContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local actId = BossRushConfig.instance:getActivityId()
		local helpId = self:_getHelpId(actId)
		local isHelp = helpId ~= nil

		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			isHelp
		}, helpId or 100, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	end
end

function V1a4_BossRushLevelDetailContainer:playCloseTransition()
	self._levelDetail:playCloseTransition()
end

function V1a4_BossRushLevelDetailContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function V1a4_BossRushLevelDetailContainer:diffRootChild(viewGO)
	self:setRootChild(viewGO)

	return true
end

function V1a4_BossRushLevelDetailContainer:setRootChild(viewSelf)
	local root = gohelper.findChild(viewSelf.viewGO, "DetailPanel/Condition")

	viewSelf._goadditionRule = gohelper.findChild(root, "#scroll_ConditionIcons")
	viewSelf._goruletemp = gohelper.findChild(viewSelf._goadditionRule, "#go_ruletemp")
	viewSelf._imagetagicon = gohelper.findChildImage(viewSelf._goruletemp, "#image_tagicon")
	viewSelf._gorulelist = gohelper.findChild(viewSelf._goadditionRule, "Viewport/content")
	viewSelf._btnadditionRuleclick = gohelper.findChildButtonWithAudio(viewSelf._goadditionRule, "#btn_additionRuleclick")
end

return V1a4_BossRushLevelDetailContainer
