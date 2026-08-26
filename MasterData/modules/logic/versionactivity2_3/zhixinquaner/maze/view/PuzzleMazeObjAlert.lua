-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeObjAlert.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeObjAlert", package.seeall)

local PuzzleMazeObjAlert = class("PuzzleMazeObjAlert", PuzzleMazeBaseAlert)

function PuzzleMazeObjAlert:ctor(go)
	PuzzleMazeObjAlert.super.ctor(self, go)

	self.image = gohelper.findChildImage(self.go, "#image_content")
	self.imageTf = self.image.transform
	self.tf = self.go.transform

	UISpriteSetMgr.instance:setPuzzleSprite(self.image, PuzzleEnum.MazeAlertResPath, true)
end

function PuzzleMazeObjAlert:onEnable(alertType, alertObj)
	gohelper.setActive(self.go, true)
	gohelper.setAsLastSibling(self.go)

	local linePos = string.splitToNumber(alertObj, "_")

	if alertType == PuzzleEnum.MazeAlertType.VisitBlock or alertType == PuzzleEnum.MazeAlertType.DisconnectLine then
		local anchorX, anchorY = PuzzleMazeDrawModel.instance:getLineAnchor(linePos[1], linePos[2], linePos[3], linePos[4])

		recthelper.setAnchor(self.tf, anchorX + PuzzleEnum.MazeAlertBlockOffsetX, anchorY + PuzzleEnum.MazeAlertBlockOffsetY)
	elseif alertType == PuzzleEnum.MazeAlertType.VisitRepeat then
		local anchorX, anchorY = PuzzleMazeDrawModel.instance:getObjectAnchor(linePos[1], linePos[2])

		recthelper.setAnchor(self.tf, anchorX + PuzzleEnum.MazeAlertCrossOffsetX, anchorY + PuzzleEnum.MazeAlertCrossOffsetY)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act176_ForbiddenGo)
end

function PuzzleMazeObjAlert:onDisable()
	gohelper.setActive(self.go, false)
end

function PuzzleMazeObjAlert:onRecycle()
	return
end

function PuzzleMazeObjAlert:getKey()
	return
end

return PuzzleMazeObjAlert
