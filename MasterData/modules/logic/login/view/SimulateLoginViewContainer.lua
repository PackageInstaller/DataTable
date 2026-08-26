-- chunkname: @modules/logic/login/view/SimulateLoginViewContainer.lua

module("modules.logic.login.view.SimulateLoginViewContainer", package.seeall)

local SimulateLoginViewContainer = class("SimulateLoginViewContainer", BaseViewContainer)

function SimulateLoginViewContainer:buildViews()
	return {
		SimulateLoginView.New()
	}
end

return SimulateLoginViewContainer
