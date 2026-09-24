-- chunkname: @modules/logic/college/view/role/CollegeRoleBaseViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleBaseViewContainer", package.seeall)

local CollegeRoleBaseViewContainer = class("CollegeRoleBaseViewContainer", BaseViewContainer)

function CollegeRoleBaseViewContainer:buildViews()
	local views = {}

	tabletool.addValues(views, self:buildMainViews())
	table.insert(views, self:buildScrollView())
	table.insert(views, CollegeCurrencyView.New("#go_righttop"))
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CollegeRoleBaseViewContainer:buildMainViews()
	return {
		CollegeRoleBaseView.New()
	}
end

function CollegeRoleBaseViewContainer:buildScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Right/#go_vertical/#scroll_RoleList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes.roleItem
	scrollParam.cellClass = self:getRoleCellClass()
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 182
	scrollParam.cellHeight = 182
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0

	local modelCls = self:getRoleListModelCls()
	local model = modelCls and modelCls.New()

	self._scrollView = LuaListScrollView.New(model, scrollParam)

	return self._scrollView
end

function CollegeRoleBaseViewContainer:buildTabViews(tabContainerId)
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

function CollegeRoleBaseViewContainer:getRoleCellClass()
	return CollegeRoleBaseListItem
end

function CollegeRoleBaseViewContainer:getRoleListModelCls()
	return CollegeRoleListModel
end

function CollegeRoleBaseViewContainer:getScrollView()
	return self._scrollView
end

return CollegeRoleBaseViewContainer
