-- chunkname: @modules/logic/limited/view/LimitedRoleViewContainer.lua

module("modules.logic.limited.view.LimitedRoleViewContainer", package.seeall)

local LimitedRoleViewContainer = class("LimitedRoleViewContainer", BaseViewContainer)

function LimitedRoleViewContainer:buildViews()
	return {
		LimitedRoleView.New(),
		LimitedRoleVoiceView.New()
	}
end

return LimitedRoleViewContainer
