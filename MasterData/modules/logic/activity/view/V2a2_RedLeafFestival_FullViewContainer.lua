-- chunkname: @modules/logic/activity/view/V2a2_RedLeafFestival_FullViewContainer.lua

module("modules.logic.activity.view.V2a2_RedLeafFestival_FullViewContainer", package.seeall)

local V2a2_RedLeafFestival_FullViewContainer = class("V2a2_RedLeafFestival_FullViewContainer", V2a2_RedLeafFestival_SignItemViewContainer)

function V2a2_RedLeafFestival_FullViewContainer:onGetMainViewClassType()
	return V2a2_RedLeafFestival_FullView
end

return V2a2_RedLeafFestival_FullViewContainer
