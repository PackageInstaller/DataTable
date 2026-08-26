-- chunkname: @modules/logic/activity/view/Role_PanelSignView_Part1_Container.lua

module("modules.logic.activity.view.Role_PanelSignView_Part1_Container", package.seeall)

local Role_PanelSignView_Part1_Container = class("Role_PanelSignView_Part1_Container", Role_SignItem_SignViewContainer)

function Role_PanelSignView_Part1_Container:onGetMainViewClassType()
	return Role_PanelSignView_Part1
end

return Role_PanelSignView_Part1_Container
