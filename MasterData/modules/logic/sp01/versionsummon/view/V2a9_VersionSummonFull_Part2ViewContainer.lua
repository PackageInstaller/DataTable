-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummonFull_Part2ViewContainer.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonFull_Part2ViewContainer", package.seeall)

local V2a9_VersionSummonFull_Part2ViewContainer = class("V2a9_VersionSummonFull_Part2ViewContainer", V2a9_VersionSummon_BaseViewContainer)

function V2a9_VersionSummonFull_Part2ViewContainer:onGetMainViewClassType()
	return V2a9_VersionSummonFull_Part2
end

return V2a9_VersionSummonFull_Part2ViewContainer
