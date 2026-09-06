-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/topkingspace/TabTopKingPTEliGroupStageSpaceView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.topkingspace.TabTopKingPTEliGroupStageSpaceView", package.seeall)

local TabTopKingPTEliGroupStageSpaceView = class("TabTopKingPTEliGroupStageSpaceView", TabPTEliGroupStageSpaceView)

function TabTopKingPTEliGroupStageSpaceView:_getEliRoundIdList()
	return {
		9,
		10,
		11
	}
end

function TabTopKingPTEliGroupStageSpaceView:_getGroupCount()
	return 4
end

return TabTopKingPTEliGroupStageSpaceView
