-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeSwitchObj.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeSwitchObj", package.seeall)

local PuzzleMazeSwitchObj = class("PuzzleMazeSwitchObj", PuzzleMazeBaseObj)

function PuzzleMazeSwitchObj:ctor(go)
	PuzzleMazeSwitchObj.super.ctor(self, go)

	self._image = gohelper.findChildImage(self.go, "#image_content")
	self._imageindex = gohelper.findChildImage(self.go, "#image_index")
	self._gointeractEffect = gohelper.findChild(self.go, "vx_tips")
	self._goarriveEffect = gohelper.findChild(self.go, "vx_smoke")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.go, "#btn_switch")

	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)

	self._isSwitched = false

	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.OnBeginDragPawn, self._onBeginDragPawn, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.OnEndDragPawn, self._onEndDragPawn, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, self._initGameDone, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.OnSimulatePlaneDone, self._onSimulatePlaneDone, self)
end

function PuzzleMazeSwitchObj:onInit(mo)
	PuzzleMazeSwitchObj.super.onInit(self, mo)

	self._isSwitched = false

	gohelper.setActive(self._btnswitch.gameObject, false)
	self:_setInteractIndex()
end

function PuzzleMazeSwitchObj:onEnter()
	PuzzleMazeSwitchObj.super.onEnter(self)
	self:_tryRecyclePlane()
end

function PuzzleMazeSwitchObj:_setIcon(isLight)
	PuzzleMazeSwitchObj.super._setIcon(self, self._isSwitched)
	ZProj.UGUIHelper.SetGrayscale(self._image.gameObject, not self._isSwitched)
	gohelper.setActive(self._goarriveEffect, self._isSwitched)
end

function PuzzleMazeSwitchObj:_getIcon()
	return self._image
end

function PuzzleMazeSwitchObj:_onBeginDragPawn()
	gohelper.setActive(self._btnswitch.gameObject, false)
end

function PuzzleMazeSwitchObj:_onEndDragPawn()
	self:_checkIfSwitchBtnVisible()
end

function PuzzleMazeSwitchObj:_initGameDone()
	self:_checkIfSwitchBtnVisible()
end

function PuzzleMazeSwitchObj:_setInteractIndex()
	if self.mo then
		local group = self.mo.group
		local iconUrl = group and PuzzleEnum.InteractIndexIcon[group]

		if iconUrl then
			UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(self._imageindex, iconUrl)
		end
	end
end

function PuzzleMazeSwitchObj:_checkIfSwitchBtnVisible()
	local hasAlertObj = PuzzleMazeDrawController.instance:hasAlertObj()

	if hasAlertObj then
		return
	end

	local isPawnAround = self:_isPawnAround()
	local isCanFlyPlane = PuzzleMazeDrawModel.instance:isCanFlyPlane()
	local canInteract = isPawnAround and isCanFlyPlane

	gohelper.setActive(self._btnswitch.gameObject, canInteract)
	gohelper.setActive(self._gointeractEffect, canInteract)
end

function PuzzleMazeSwitchObj:_isPawnAround()
	if not self.mo or not self.mo.x or not self.mo.y then
		return
	end

	local pawnPosX, pawnPosY = PuzzleMazeDrawController.instance:getLastPos()

	if not pawnPosX or not pawnPosY then
		return
	end

	return math.abs(self.mo.x - pawnPosX) + math.abs(self.mo.y - pawnPosY) == 1
end

function PuzzleMazeSwitchObj:_btnswitchOnClick()
	self._isSwitched = true

	gohelper.setActive(self._btnswitch.gameObject, false)
	gohelper.setActive(self._gointeractEffect, false)
	PuzzleMazeDrawController.instance:interactSwitchObj(self.mo.x, self.mo.y)
end

function PuzzleMazeSwitchObj:_tryRecyclePlane()
	local hasAlertObj = PuzzleMazeDrawController.instance:hasAlertObj()

	if hasAlertObj or not self._isSwitched then
		return
	end

	local curPlanePosX, curPlanePosY = PuzzleMazeDrawModel.instance:getCurPlanePos()

	if self.mo and self.mo.x == curPlanePosX and self.mo.y == curPlanePosY then
		self._isSwitched = false

		self:_setIcon()
		PuzzleMazeDrawController.instance:recyclePlane()
		AudioMgr.instance:trigger(AudioEnum.UI.Act176_RecyclePlane)
	end
end

function PuzzleMazeSwitchObj:_onSimulatePlaneDone()
	self:_setIcon()
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_SwitchOn)
end

function PuzzleMazeSwitchObj:destroy()
	self._btnswitch:RemoveClickListener()
	PuzzleMazeSwitchObj.super.destroy(self)
end

return PuzzleMazeSwitchObj
