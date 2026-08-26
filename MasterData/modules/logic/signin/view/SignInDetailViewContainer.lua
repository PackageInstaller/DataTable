-- chunkname: @modules/logic/signin/view/SignInDetailViewContainer.lua

module("modules.logic.signin.view.SignInDetailViewContainer", package.seeall)

local SignInDetailViewContainer = class("SignInDetailViewContainer", BaseViewContainer)

function SignInDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, SignInDetailView.New())

	return views
end

function SignInDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local view = NavigateButtonsView.New({
			false,
			false,
			false
		})

		view:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			view
		}
	end
end

function SignInDetailViewContainer:overrideOnCloseClick()
	SignInController.instance:dispatchEvent(SignInEvent.CloseSignInDetailView)
end

return SignInDetailViewContainer
