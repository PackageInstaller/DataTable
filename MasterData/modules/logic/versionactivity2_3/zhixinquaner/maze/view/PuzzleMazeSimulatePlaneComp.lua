-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeSimulatePlaneComp.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeSimulatePlaneComp", package.seeall)

local PuzzleMazeSimulatePlaneComp = class("PuzzleMazeSimulatePlaneComp", BaseView)
local PLANE_SIMULATE_DURATION = 1
local PlaneRotation_XYZ = {
	[PuzzleEnum.dir.left] = {
		0,
		180,
		0
	},
	[PuzzleEnum.dir.right] = {
		0,
		0,
		0
	},
	[PuzzleEnum.dir.up] = {
		0,
		0,
		0
	},
	[PuzzleEnum.dir.down] = {
		0,
		0,
		0
	}
}

function PuzzleMazeSimulatePlaneComp:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._goplane = gohelper.findChild(self.viewGO, "#go_map/#go_plane")
	self._gobigplane = gohelper.findChild(self.viewGO, "image_Dec")
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self._gobigplane)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PuzzleMazeSimulatePlaneComp:addEvents()
	return
end

function PuzzleMazeSimulatePlaneComp:removeEvents()
	return
end

function PuzzleMazeSimulatePlaneComp:onOpen()
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, self._initGameDone, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.SimulatePlane, self._onTriggerSwitch, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.RecyclePlane, self._recyclePlane, self)
end

function PuzzleMazeSimulatePlaneComp:_initGameDone()
	self._animatorPlayer.animator.enabled = true

	self._animatorPlayer.animator:Play("in", 0, 0)
end

function PuzzleMazeSimulatePlaneComp:_onTriggerSwitch(objPosX, objPosY)
	self._objPosX = objPosX
	self._objPosY = objPosY

	self._animatorPlayer:Play("out", self._simulateFlyPlane, self)
end

function PuzzleMazeSimulatePlaneComp:_simulateFlyPlane()
	local originPosX, originPosY = PuzzleMazeDrawController.instance:getLastPos()
	local originAnchorX, originAnchorY = PuzzleMazeDrawModel.instance:getObjectAnchor(originPosX, originPosY)
	local targetAnchorX, targetAnchorY = PuzzleMazeDrawModel.instance:getObjectAnchor(self._objPosX, self._objPosY)
	local rotationX, rotationY, rotationZ = self:_getPlaneTargetRotation(originPosX, originPosY, self._objPosX, self._objPosY)

	transformhelper.setEulerAngles(self._goplane.transform, rotationX, rotationY, rotationZ)
	recthelper.setAnchor(self._goplane.transform, originAnchorX, originAnchorY)
	gohelper.setAsLastSibling(self._goplane)
	gohelper.setActive(self._goplane, true)
	self:_lockScreen(true)

	self._moveTweenId = ZProj.TweenHelper.DOAnchorPos(self._goplane.transform, targetAnchorX, targetAnchorY, PLANE_SIMULATE_DURATION, self._onSlimulateFlyPlaneDone, self)
end

function PuzzleMazeSimulatePlaneComp:_getPlaneTargetRotation(originPosX, originPosY, targetPosX, targetPosY)
	local dir = PuzzleEnum.dir.left

	if originPosX ~= targetPosX then
		dir = targetPosX < originPosX and PuzzleEnum.dir.left or PuzzleEnum.dir.right
	elseif originPosY ~= targetPosY then
		dir = targetPosY < originPosY and PuzzleEnum.dir.down or PuzzleEnum.dir.up
	end

	if PlaneRotation_XYZ then
		local rotationXYZ = PlaneRotation_XYZ[dir]

		if rotationXYZ then
			if not rotationXYZ[1] then
				local rotationX = 0

				if rotationXYZ then
					if not rotationXYZ[2] then
						local rotationY = 0

						if rotationXYZ then
							if not rotationXYZ[3] then
								local rotationZ = 0

								return rotationX, rotationY, rotationZ
							end
						end
					end
				end
			end
		end
	end
end

function PuzzleMazeSimulatePlaneComp:_onSlimulateFlyPlaneDone()
	self:_lockScreen(false)
	self:_killSimulatePlaneTween()
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnSimulatePlaneDone)
end

function PuzzleMazeSimulatePlaneComp:_killSimulatePlaneTween()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

function PuzzleMazeSimulatePlaneComp:_recyclePlane()
	gohelper.setActive(self._goplane, false)

	self._animatorPlayer.animator.enabled = true

	self._animatorPlayer.animator:Play("in", 0, 0)
end

function PuzzleMazeSimulatePlaneComp:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("PuzzleMazeSimulatePlaneComp SimulatePlane")
	else
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("PuzzleMazeSimulatePlaneComp SimulatePlane")
	end
end

function PuzzleMazeSimulatePlaneComp:onClose()
	self:_lockScreen(false)
	self:_killSimulatePlaneTween()
end

return PuzzleMazeSimulatePlaneComp
