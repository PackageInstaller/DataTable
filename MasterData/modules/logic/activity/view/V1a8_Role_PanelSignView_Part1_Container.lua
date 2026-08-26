-- chunkname: @modules/logic/activity/view/V1a8_Role_PanelSignView_Part1_Container.lua

module("modules.logic.activity.view.V1a8_Role_PanelSignView_Part1_Container", package.seeall)

local V1a8_Role_PanelSignView_Part1_Container = class("V1a8_Role_PanelSignView_Part1_Container", V1a8_Role_SignItem_SignViewContainer)

function V1a8_Role_PanelSignView_Part1_Container:onGetMainViewClassType()
	return V1a8_Role_PanelSignView_Part1
end

return V1a8_Role_PanelSignView_Part1_Container
