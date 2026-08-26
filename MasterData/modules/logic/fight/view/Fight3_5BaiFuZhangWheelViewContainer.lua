-- chunkname: @modules/logic/fight/view/Fight3_5BaiFuZhangWheelViewContainer.lua

module("modules.logic.fight.view.Fight3_5BaiFuZhangWheelViewContainer", package.seeall)

local Fight3_5BaiFuZhangWheelViewContainer = class("Fight3_5BaiFuZhangWheelViewContainer", BaseViewContainer)

function Fight3_5BaiFuZhangWheelViewContainer:buildViews()
	local views = {}

	table.insert(views, Fight3_5BaiFuZhangWheelView.New())

	return views
end

return Fight3_5BaiFuZhangWheelViewContainer
