-- chunkname: @modules/logic/dungeonmazev3a7/view/DungeonMazeV3a7ResultViewContainer.lua

module("modules.logic.dungeonmazev3a7.view.DungeonMazeV3a7ResultViewContainer", package.seeall)

local DungeonMazeV3a7ResultViewContainer = class("DungeonMazeV3a7ResultViewContainer", BaseViewContainer)

function DungeonMazeV3a7ResultViewContainer:buildViews()
	return {
		DungeonMazeV3a7ResultView.New()
	}
end

return DungeonMazeV3a7ResultViewContainer
