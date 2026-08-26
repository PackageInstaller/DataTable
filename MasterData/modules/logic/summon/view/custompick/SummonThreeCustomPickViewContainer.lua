-- chunkname: @modules/logic/summon/view/custompick/SummonThreeCustomPickViewContainer.lua

module("modules.logic.summon.view.custompick.SummonThreeCustomPickViewContainer", package.seeall)

local SummonThreeCustomPickViewContainer = class("SummonThreeCustomPickViewContainer", BaseViewContainer)

function SummonThreeCustomPickViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonThreeCustomPickView.New())

	return views
end

return SummonThreeCustomPickViewContainer
