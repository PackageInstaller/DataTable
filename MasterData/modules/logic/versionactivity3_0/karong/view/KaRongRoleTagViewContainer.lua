-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongRoleTagViewContainer.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongRoleTagViewContainer", package.seeall)

local KaRongRoleTagViewContainer = class("KaRongRoleTagViewContainer", BaseViewContainer)

function KaRongRoleTagViewContainer:buildViews()
	local views = {}

	table.insert(views, KaRongRoleTagView.New())

	return views
end

return KaRongRoleTagViewContainer
