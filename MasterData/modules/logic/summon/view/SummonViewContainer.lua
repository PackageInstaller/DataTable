-- chunkname: @modules/logic/summon/view/SummonViewContainer.lua

module("modules.logic.summon.view.SummonViewContainer", package.seeall)

local SummonViewContainer = class("SummonViewContainer", BaseViewContainer)

function SummonViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_content"))
	table.insert(views, SummonView.New())

	return views
end

function SummonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			MultiView.New({
				SummonCharView.New()
			}),
			MultiView.New({
				SummonEquipView.New(),
				SummonEquipFloatView.New()
			})
		}
	end
end

return SummonViewContainer
