-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillRootView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillRootView", package.seeall)

local Rouge2_BackpackSkillRootView = class("Rouge2_BackpackSkillRootView", BaseViewExtended)

Rouge2_BackpackSkillRootView.ViewType = {
	TalentTree = 2,
	List = 1
}

function Rouge2_BackpackSkillRootView:onInitView()
	self._goTeamTips = gohelper.findChild(self.viewGO, "#go_TeamTips")
	self._goMode = gohelper.findChild(self.viewGO, "#go_Mode")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillRootView:addEvents()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectActiveSkillHole, self._onSelectSkillHole, self)
end

function Rouge2_BackpackSkillRootView:removeEvents()
	return
end

function Rouge2_BackpackSkillRootView:_editableInitView()
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)
	Rouge2_TeamRecommendTipsLoader.LoadWithParams(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.Single)
	self:_initOpenViewFunc()
	self:_loadSubView()
end

function Rouge2_BackpackSkillRootView:_initOpenViewFunc()
	self._openViewFunc = self:getUserDataTb_()
	self._openViewFunc[Rouge2_BackpackSkillRootView.ViewType.TalentTree] = function()
		return self:openExclusiveView(1, 1, Rouge2_BackpackSkillTalentView, Rouge2_Enum.ResPath.BackpackTalentView, self._goContainer)
	end
	self._openViewFunc[Rouge2_BackpackSkillRootView.ViewType.List] = function()
		return self:openExclusiveView(1, 2, Rouge2_BackpackSkillView, Rouge2_Enum.ResPath.BackpackSkillView, self._goContainer)
	end
end

function Rouge2_BackpackSkillRootView:_openViewByType(viewType)
	if self._viewType == viewType then
		return
	end

	local openViewFunc = self._openViewFunc[viewType]

	if not openViewFunc then
		logError(string.format("肉鸽背包共鸣器界面缺少打开方法 viewType = %s", viewType))

		return
	end

	self._curShowView = openViewFunc(self)
	self._viewType = viewType
end

function Rouge2_BackpackSkillRootView:_loadSubView()
	if Rouge2_Model.instance:isUseYBXCareer() then
		self:_openViewByType(Rouge2_BackpackSkillRootView.ViewType.TalentTree)
	else
		self:_openViewByType(Rouge2_BackpackSkillRootView.ViewType.List)
	end
end

function Rouge2_BackpackSkillRootView:_onSelectSkillHole(index)
	self:_openViewByType(Rouge2_BackpackSkillRootView.ViewType.List)
end

function Rouge2_BackpackSkillRootView:_onClickEscapeCallback()
	if Rouge2_Model.instance:isUseYBXCareer() and self._viewType == Rouge2_BackpackSkillRootView.ViewType.List then
		self:_openViewByType(Rouge2_BackpackSkillRootView.ViewType.TalentTree)

		return
	end

	self:closeThis()
end

function Rouge2_BackpackSkillRootView:getView(viewType)
	if self._viewType ~= viewType then
		return
	end

	return self._curShowView
end

return Rouge2_BackpackSkillRootView
