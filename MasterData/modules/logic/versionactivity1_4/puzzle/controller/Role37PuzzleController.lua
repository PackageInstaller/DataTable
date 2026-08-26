-- chunkname: @modules/logic/versionactivity1_4/puzzle/controller/Role37PuzzleController.lua

module("modules.logic.versionactivity1_4.puzzle.controller.Role37PuzzleController", package.seeall)

local Role37PuzzleController = class("Role37PuzzleController", BaseController)

function Role37PuzzleController:openPuzzleResultView()
	ViewMgr.instance:openView(ViewName.Role37PuzzleResultView)
end

Role37PuzzleController.instance = Role37PuzzleController.New()

return Role37PuzzleController
