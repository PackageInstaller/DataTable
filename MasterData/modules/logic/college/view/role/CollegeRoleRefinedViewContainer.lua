-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleRefinedViewContainer", package.seeall)

local CollegeRoleRefinedViewContainer = class("CollegeRoleRefinedViewContainer", BaseViewContainer)

function CollegeRoleRefinedViewContainer:buildViews()
	local views = {}

	table.insert(views, CollegeStatIdleTimeView.New(CollegeStatEnum.ViewName.Refined))
	table.insert(views, CollegeRoleRefinedView.New())
	table.insert(views, CollegeVisibleBaseView.New())
	table.insert(views, CollegeCurrencyView.New("#go_righttop"))
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CollegeRoleRefinedViewContainer:buildTabViews(tabContainerId)
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

function CollegeRoleRefinedViewContainer:onContainerInit()
	self._viewAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function CollegeRoleRefinedViewContainer:playCloseTransition()
	self:startViewCloseBlock()
	self._viewAnimator:Play("close", self.onPlayCloseTransitionFinish, self)
end

return CollegeRoleRefinedViewContainer
