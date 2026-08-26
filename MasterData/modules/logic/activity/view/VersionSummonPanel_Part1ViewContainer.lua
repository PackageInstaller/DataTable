-- chunkname: @modules/logic/activity/view/VersionSummonPanel_Part1ViewContainer.lua

module("modules.logic.activity.view.VersionSummonPanel_Part1ViewContainer", package.seeall)

local VersionSummonPanel_Part1ViewContainer = class("VersionSummonPanel_Part1ViewContainer", VersionSummon_BaseViewContainer)

function VersionSummonPanel_Part1ViewContainer:onGetMainViewClassType()
	return VersionSummonPanel_Part1
end

return VersionSummonPanel_Part1ViewContainer
