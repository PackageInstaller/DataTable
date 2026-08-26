-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameResultViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameResultViewContainer", package.seeall)

local AssassinStealthGameResultViewContainer = class("AssassinStealthGameResultViewContainer", BaseViewContainer)

function AssassinStealthGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStealthGameResultView.New())

	return views
end

return AssassinStealthGameResultViewContainer
