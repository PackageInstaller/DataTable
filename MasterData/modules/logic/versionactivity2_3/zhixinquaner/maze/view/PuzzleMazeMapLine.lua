-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeMapLine.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeMapLine", package.seeall)

local PuzzleMazeMapLine = class("PuzzleMazeMapLine", PuzzleMazeBaseLine)

PuzzleMazeMapLine.SwitchOffIconUrl = "duandian_1"

function PuzzleMazeMapLine:ctor(go, fillOrigin_left, fillOrigin_right)
	PuzzleMazeMapLine.super.ctor(self, go)

	self._fillOrigin_left = fillOrigin_left
	self._fillOrigin_right = fillOrigin_right
	self._width, self._height = PuzzleMazeDrawModel.instance:getUIGridSize()
	self._gomap = gohelper.findChild(self.go, "#go_map")
	self._gopath = gohelper.findChild(self.go, "#go_path")
	self._goswitch = gohelper.findChild(self.go, "#go_map/#go_switch")
	self._imageindex = gohelper.findChildImage(self.go, "#go_map/#go_switch/#image_index")
	self._imagecontent = gohelper.findChildImage(self.go, "#go_map/#go_switch/#image_content")
	self._switchAnim = gohelper.findChildComponent(self.go, "#go_map/#go_switch", gohelper.Type_Animator)

	gohelper.setActive(self._gomap, true)
	gohelper.setActive(self._gopath, false)
end

function PuzzleMazeMapLine:onInit(x1, y1, x2, y2)
	PuzzleMazeMapLine.super.onInit(self, x1, y1, x2, y2)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.SwitchLineState, self.onSwitchLine, self)

	local anchorX, anchorY = PuzzleMazeDrawModel.instance:getLineAnchor(x1, y1, x2, y2)

	recthelper.setAnchor(self.go.transform, anchorX, anchorY)
	self:_setIcon()
end

function PuzzleMazeMapLine:_setIcon()
	local lineState = PuzzleMazeDrawModel.instance:getMapLineState(self.x1, self.y1, self.x2, self.y2)
	local isSwitchOff = lineState == PuzzleEnum.LineState.Switch_Off
	local isSwitchOn = lineState == PuzzleEnum.LineState.Switch_On

	if isSwitchOff then
		local ctrlMo = PuzzleMazeDrawModel.instance:getInteractLineCtrl(self.x1, self.y1, self.x2, self.y2)
		local group = ctrlMo and ctrlMo.group
		local iconUrl = group and PuzzleEnum.InteractIndexIcon[group]

		if iconUrl then
			UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(self._imageindex, iconUrl)
		end

		UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(self._imagecontent, PuzzleMazeMapLine.SwitchOffIconUrl)
	end

	if isSwitchOff or isSwitchOn then
		gohelper.setActive(self._goswitch, true)

		local switchAnim = isSwitchOff and "none" or "disappear"

		self._switchAnim:Play(switchAnim, 0, 0)
	else
		gohelper.setActive(self._goswitch, false)
	end
end

function PuzzleMazeMapLine:onSwitchLine(startPosX, startPosY, endPosX, endPosY)
	if startPosX ~= self.x1 or startPosY ~= self.y1 or self.x2 ~= endPosX or self.y2 ~= endPosY then
		return
	end

	self:_setIcon()
end

return PuzzleMazeMapLine
