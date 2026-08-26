-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3SignInRoleTalkViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3SignInRoleTalkViewContainer", package.seeall)

local Turnback3SignInRoleTalkViewContainer = class("Turnback3SignInRoleTalkViewContainer", BaseViewContainer)

function Turnback3SignInRoleTalkViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3SignInRoleTalkView.New())

	return views
end

return Turnback3SignInRoleTalkViewContainer
