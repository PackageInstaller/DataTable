-- chunkname: @modules/logic/activity/view/VersionSummonFull_Part1ViewContainer.lua

module("modules.logic.activity.view.VersionSummonFull_Part1ViewContainer", package.seeall)

local VersionSummonFull_Part1ViewContainer = class("VersionSummonFull_Part1ViewContainer", VersionSummon_BaseViewContainer)

function VersionSummonFull_Part1ViewContainer:onGetMainViewClassType()
	return VersionSummonFull_Part1
end

return VersionSummonFull_Part1ViewContainer
