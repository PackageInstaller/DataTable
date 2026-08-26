-- chunkname: @modules/logic/weekwalk/view/WeekWalkEnemyInfoViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkEnemyInfoViewContainer", package.seeall)

local WeekWalkEnemyInfoViewContainer = class("WeekWalkEnemyInfoViewContainer", BaseViewContainer)

function WeekWalkEnemyInfoViewContainer:buildViews()
	self.weekWalkOriginalEnemyInfoView = WeekWalkOriginalEnemyInfoView.New()
	self.weekWalkEnemyInfoViewRule = WeekWalkEnemyInfoViewRule.New()

	return {
		WeekWalkEnemyInfoView.New(),
		self.weekWalkOriginalEnemyInfoView,
		self.weekWalkEnemyInfoViewRule,
		TabViewGroup.New(1, "#go_btns")
	}
end

function WeekWalkEnemyInfoViewContainer:getEnemyInfoView()
	return self.weekWalkOriginalEnemyInfoView
end

function WeekWalkEnemyInfoViewContainer:getWeekWalkEnemyInfoViewRule()
	return self.weekWalkEnemyInfoViewRule
end

function WeekWalkEnemyInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

function WeekWalkEnemyInfoViewContainer:onContainerOpenFinish()
	return
end

return WeekWalkEnemyInfoViewContainer
