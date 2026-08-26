-- chunkname: @modules/logic/activity/view/V1a4_Role_FullSignView_Part2_Container.lua

module("modules.logic.activity.view.V1a4_Role_FullSignView_Part2_Container", package.seeall)

local V1a4_Role_FullSignView_Part2_Container = class("V1a4_Role_FullSignView_Part2_Container", V1a4_Role_SignItem_SignViewContainer)

function V1a4_Role_FullSignView_Part2_Container:onGetMainViewClassType()
	return V1a4_Role_FullSignView_Part2
end

return V1a4_Role_FullSignView_Part2_Container
