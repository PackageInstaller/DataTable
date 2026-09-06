-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginSimulationSDKViewPresentor.lua

module("logic.extensions.login.view.LoginSimulationSDKViewPresentor", package.seeall)

local LoginSimulationSDKViewPresentor = class("LoginSimulationSDKViewPresentor", ViewPresentor)

LoginSimulationSDKViewPresentor.Url_View = "ui/views/login/loginsimulationsdkview.prefab"

function LoginSimulationSDKViewPresentor:dependWhatResources()
	return {
		LoginSimulationSDKViewPresentor.Url_View
	}
end

function LoginSimulationSDKViewPresentor:buildViews()
	local views = {}

	table.insert(views, LoginSimulationSDKView.New())

	return views
end

return LoginSimulationSDKViewPresentor
