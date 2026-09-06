-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/topkingspace/TabTopKingPTEliQuarterFinalSpaceView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.topkingspace.TabTopKingPTEliQuarterFinalSpaceView", package.seeall)

local TabTopKingPTEliQuarterFinalSpaceView = class("TabTopKingPTEliQuarterFinalSpaceView", TabPTEliQuarterFinalSpaceView)

function TabTopKingPTEliQuarterFinalSpaceView:_getEliRoundIdList()
	return {
		12
	}
end

function TabTopKingPTEliQuarterFinalSpaceView:_getGroupCount()
	return 1
end

return TabTopKingPTEliQuarterFinalSpaceView
