-- chunkname: @modules/logic/activity/view/VersionSummonFull_Part2ViewContainer.lua

module("modules.logic.activity.view.VersionSummonFull_Part2ViewContainer", package.seeall)

local VersionSummonFull_Part2ViewContainer = class("VersionSummonFull_Part2ViewContainer", VersionSummon_BaseViewContainer)

function VersionSummonFull_Part2ViewContainer:onGetMainViewClassType()
	return VersionSummonFull_Part2
end

return VersionSummonFull_Part2ViewContainer
