-- chunkname: @modules/logic/summon/view/luckybag/SummonGetLuckyBagViewContainer.lua

module("modules.logic.summon.view.luckybag.SummonGetLuckyBagViewContainer", package.seeall)

local SummonGetLuckyBagViewContainer = class("SummonGetLuckyBagViewContainer", BaseViewContainer)

function SummonGetLuckyBagViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonGetLuckyBagView.New())

	return views
end

return SummonGetLuckyBagViewContainer
