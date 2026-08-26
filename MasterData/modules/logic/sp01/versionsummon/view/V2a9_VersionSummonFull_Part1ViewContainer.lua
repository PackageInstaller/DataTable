-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummonFull_Part1ViewContainer.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonFull_Part1ViewContainer", package.seeall)

local V2a9_VersionSummonFull_Part1ViewContainer = class("V2a9_VersionSummonFull_Part1ViewContainer", V2a9_VersionSummon_BaseViewContainer)

function V2a9_VersionSummonFull_Part1ViewContainer:onGetMainViewClassType()
	return V2a9_VersionSummonFull_Part1
end

return V2a9_VersionSummonFull_Part1ViewContainer
