-- chunkname: @modules/logic/college/view/role/CollegeRoleRecruitViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleRecruitViewContainer", package.seeall)

local CollegeRoleRecruitViewContainer = class("CollegeRoleRecruitViewContainer", BaseViewContainer)

function CollegeRoleRecruitViewContainer:buildViews()
	local views = {}

	table.insert(views, CollegeStatIdleTimeView.New(CollegeStatEnum.ViewName.Recruit))
	table.insert(views, CollegeRoleRecruitView.New())
	table.insert(views, CollegeRoleRecruitSuccView.New())
	table.insert(views, CollegeVisibleBaseView.New())
	table.insert(views, CollegeCurrencyView.New("#go_righttop"))
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CollegeRoleRecruitViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	end
end

function CollegeRoleRecruitViewContainer:onContainerInit()
	self._viewAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function CollegeRoleRecruitViewContainer:playOpenTransition()
	self:startViewOpenBlock()
	self._viewAnimator:Play("open", self.onPlayOpenTransitionFinish, self)
end

function CollegeRoleRecruitViewContainer:playCloseTransition()
	self:startViewCloseBlock()
	self._viewAnimator:Play("close", self.onPlayCloseTransitionFinish, self)
end

return CollegeRoleRecruitViewContainer
