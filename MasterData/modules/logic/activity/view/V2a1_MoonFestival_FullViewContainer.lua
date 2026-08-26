-- chunkname: @modules/logic/activity/view/V2a1_MoonFestival_FullViewContainer.lua

module("modules.logic.activity.view.V2a1_MoonFestival_FullViewContainer", package.seeall)

local V2a1_MoonFestival_FullViewContainer = class("V2a1_MoonFestival_FullViewContainer", V2a1_MoonFestival_SignItemViewContainer)

function V2a1_MoonFestival_FullViewContainer:onGetMainViewClassType()
	return V2a1_MoonFestival_FullView
end

return V2a1_MoonFestival_FullViewContainer
