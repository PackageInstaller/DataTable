-- chunkname: @modules/logic/activity/view/Role_FullSignView_Part2_Container.lua

module("modules.logic.activity.view.Role_FullSignView_Part2_Container", package.seeall)

local Role_FullSignView_Part2_Container = class("Role_FullSignView_Part2_Container", Role_SignItem_SignViewContainer)

function Role_FullSignView_Part2_Container:onGetMainViewClassType()
	return Role_FullSignView_Part2
end

return Role_FullSignView_Part2_Container
