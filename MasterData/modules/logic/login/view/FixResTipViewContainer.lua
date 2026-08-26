-- chunkname: @modules/logic/login/view/FixResTipViewContainer.lua

module("modules.logic.login.view.FixResTipViewContainer", package.seeall)

local FixResTipViewContainer = class("FixResTipViewContainer", BaseViewContainer)

function FixResTipViewContainer:buildViews()
	return {
		FixResTipView.New()
	}
end

return FixResTipViewContainer
