-- chunkname: @modules/logic/activity/view/V2a2_Role_PanelSignView_Part2_Container.lua

module("modules.logic.activity.view.V2a2_Role_PanelSignView_Part2_Container", package.seeall)

local V2a2_Role_PanelSignView_Part2_Container = class("V2a2_Role_PanelSignView_Part2_Container", V2a2_Role_SignItem_SignViewContainer)

function V2a2_Role_PanelSignView_Part2_Container:onGetMainViewClassType()
	return V2a2_Role_PanelSignView_Part2
end

return V2a2_Role_PanelSignView_Part2_Container
