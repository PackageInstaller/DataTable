-- chunkname: @modules/logic/player/view/SignatureContainer.lua

module("modules.logic.player.view.SignatureContainer", package.seeall)

local SignatureContainer = class("SignatureContainer", BaseViewContainer)

function SignatureContainer:buildViews()
	local views = {}

	table.insert(views, Signature.New())

	return views
end

return SignatureContainer
