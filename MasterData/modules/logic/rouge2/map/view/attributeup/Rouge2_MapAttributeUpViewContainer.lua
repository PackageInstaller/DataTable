-- chunkname: @modules/logic/rouge2/map/view/attributeup/Rouge2_MapAttributeUpViewContainer.lua

module("modules.logic.rouge2.map.view.attributeup.Rouge2_MapAttributeUpViewContainer", package.seeall)

local Rouge2_MapAttributeUpViewContainer = class("Rouge2_MapAttributeUpViewContainer", BaseViewContainer)

function Rouge2_MapAttributeUpViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapAttributeUpView.New())
	table.insert(views, TabViewGroup.New(1, "#go_Root/#go_lefttop"))

	return views
end

function Rouge2_MapAttributeUpViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local addAttrPoint = Rouge2_MapAttrUpdateController.instance:getAddAttrPoint()
	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play((not addAttrPoint or addAttrPoint <= 0 or nil) and "openmove", self.onPlayOpenTransitionFinish, self)
end

function Rouge2_MapAttributeUpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			false,
			false,
			true
		})

		self.navigateView:setOverrideHelp(self.overrideHelperBtn, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_MapAttributeUpViewContainer:overrideHelperBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.AttrUpView)
end

return Rouge2_MapAttributeUpViewContainer
