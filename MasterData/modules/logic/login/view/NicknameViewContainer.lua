-- chunkname: @modules/logic/login/view/NicknameViewContainer.lua

module("modules.logic.login.view.NicknameViewContainer", package.seeall)

local NicknameViewContainer = class("NicknameViewContainer", BaseViewContainer)

function NicknameViewContainer:buildViews()
	return {
		NicknameView.New()
	}
end

return NicknameViewContainer
