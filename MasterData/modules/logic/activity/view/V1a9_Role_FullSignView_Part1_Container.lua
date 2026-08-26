-- chunkname: @modules/logic/activity/view/V1a9_Role_FullSignView_Part1_Container.lua

module("modules.logic.activity.view.V1a9_Role_FullSignView_Part1_Container", package.seeall)

local V1a9_Role_FullSignView_Part1_Container = class("V1a9_Role_FullSignView_Part1_Container", V1a9_Role_SignItem_SignViewContainer)

function V1a9_Role_FullSignView_Part1_Container:onGetMainViewClassType()
	return V1a9_Role_FullSignView_Part1
end

return V1a9_Role_FullSignView_Part1_Container
