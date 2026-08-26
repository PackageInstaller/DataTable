-- chunkname: @modules/logic/versionactivity1_3/va3chess/view/Va3ChessGameSceneContainer.lua

module("modules.logic.versionactivity1_3.va3chess.view.Va3ChessGameSceneContainer", package.seeall)

local Va3ChessGameSceneContainer = class("Va3ChessGameSceneContainer", BaseViewContainer)

function Va3ChessGameSceneContainer:buildViews()
	local views = {}

	table.insert(views, Va3ChessGameScene.New())

	return views
end

return Va3ChessGameSceneContainer
