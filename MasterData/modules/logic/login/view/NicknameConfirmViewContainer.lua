-- chunkname: @modules/logic/login/view/NicknameConfirmViewContainer.lua

module("modules.logic.login.view.NicknameConfirmViewContainer", package.seeall)

local NicknameConfirmViewContainer = class("NicknameConfirmViewContainer", BaseViewContainer)

function NicknameConfirmViewContainer:buildViews()
	return {
		NickNameConfirmView.New()
	}
end

return NicknameConfirmViewContainer
