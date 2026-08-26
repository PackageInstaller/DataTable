-- chunkname: @modules/logic/fight/view/Fight3_5BaiFuZhangWheelSelectCardViewContainer.lua

module("modules.logic.fight.view.Fight3_5BaiFuZhangWheelSelectCardViewContainer", package.seeall)

local Fight3_5BaiFuZhangWheelSelectCardViewContainer = class("Fight3_5BaiFuZhangWheelSelectCardViewContainer", BaseViewContainer)

function Fight3_5BaiFuZhangWheelSelectCardViewContainer:buildViews()
	local views = {}

	table.insert(views, Fight3_5BaiFuZhangWheelSelectCardView.New())

	return views
end

return Fight3_5BaiFuZhangWheelSelectCardViewContainer
