-- chunkname: @modules/logic/login/view/LoginViewContainer.lua

module("modules.logic.login.view.LoginViewContainer", package.seeall)

local LoginViewContainer = class("LoginViewContainer", BaseViewContainer)

function LoginViewContainer:buildViews()
	return {
		LoginBgView.New("#go_bg"),
		LoginView.New(),
		LoginVideoView.New()
	}
end

function LoginViewContainer:setSetting(viewName, viewSetting)
	LoginViewContainer.super.setSetting(self, viewName, viewSetting)
	LoginPageController.instance:resetPageCfg()

	local pageCfg = LoginPageController.instance:getCurPageCfg()

	if viewSetting and pageCfg then
		viewSetting.otherRes = {}
		viewSetting.otherRes[1] = string.format("ui/viewres/login/%s.prefab", pageCfg.prefab)

		if not string.nilorempty(pageCfg.bgimage) then
			viewSetting.otherRes[2] = ResUrl.getLoginBg(pageCfg.bgimage)
		end
	end
end

return LoginViewContainer
