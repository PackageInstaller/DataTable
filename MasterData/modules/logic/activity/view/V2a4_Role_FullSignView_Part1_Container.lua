-- chunkname: @modules/logic/activity/view/V2a4_Role_FullSignView_Part1_Container.lua

module("modules.logic.activity.view.V2a4_Role_FullSignView_Part1_Container", package.seeall)

local V2a4_Role_FullSignView_Part1_Container = class("V2a4_Role_FullSignView_Part1_Container", V2a4_Role_SignItem_SignViewContainer)

function V2a4_Role_FullSignView_Part1_Container:onGetMainViewClassType()
	return V2a4_Role_FullSignView_Part1
end

return V2a4_Role_FullSignView_Part1_Container
