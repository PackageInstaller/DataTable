-- chunkname: @modules/logic/dungeon/view/jump/DungeonJumpGameResultViewContainer.lua

module("modules.logic.dungeon.view.jump.DungeonJumpGameResultViewContainer", package.seeall)

local DungeonJumpGameResultViewContainer = class("DungeonJumpGameResultViewContainer", BaseViewContainer)

function DungeonJumpGameResultViewContainer:buildViews()
	return {
		DungeonJumpGameResultView.New()
	}
end

return DungeonJumpGameResultViewContainer
