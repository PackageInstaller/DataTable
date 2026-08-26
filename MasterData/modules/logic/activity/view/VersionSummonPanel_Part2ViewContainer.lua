-- chunkname: @modules/logic/activity/view/VersionSummonPanel_Part2ViewContainer.lua

module("modules.logic.activity.view.VersionSummonPanel_Part2ViewContainer", package.seeall)

local VersionSummonPanel_Part2ViewContainer = class("VersionSummonPanel_Part2ViewContainer", VersionSummon_BaseViewContainer)

function VersionSummonPanel_Part2ViewContainer:onGetMainViewClassType()
	return VersionSummonPanel_Part2
end

return VersionSummonPanel_Part2ViewContainer
