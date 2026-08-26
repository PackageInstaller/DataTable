-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/puzzle/FairyLandPuzzle2.lua

module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle2", package.seeall)

local FairyLandPuzzle2 = class("FairyLandPuzzle2", FairyLandPuzzleBase)

function FairyLandPuzzle2:onInitView()
	self._puzzleGO = gohelper.findChild(self.viewGO, "main/#go_Root/#go_Puzzle/2")
	self._goShape = gohelper.findChild(self.viewGO, "main/#go_Shape")
	self._shapeGO = gohelper.findChild(self.viewGO, "main/#go_Shape/2")
	self.tipAnim = SLFramework.AnimatorPlayer.Get(self._shapeGO)
	self._shapeTrs = self._shapeGO.transform
	self._goImageShape = gohelper.findChild(self._shapeGO, "image_shape")

	self:addDrag(self._goImageShape)

	self.itemList = self:getUserDataTb_()

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self._puzzleGO, "item" .. tostring(i))
		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		item.transform = item.go.transform
		item.itemGO = gohelper.findChild(item.go, "item")
		item.itemTransform = item.itemGO.transform
		self.itemList[i] = item
	end

	self.mainGO = gohelper.findChild(self.viewGO, "main")
	self.mainTrs = self.mainGO.transform
	self._dragTrs = self._shapeTrs
	self.initPos = recthelper.uiPosToScreenPos(self._dragTrs)
	self.initAngle = self:getRotationZ()
end

function FairyLandPuzzle2:initPuzzleView()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetSceneUpdatePos, true)
	gohelper.addChildPosStay(self.viewGO, self._shapeGO)
end

function FairyLandPuzzle2:resetGOList()
	transformhelper.setLocalRotation(self.mainTrs, 0, 0, self.initAngle)
	transformhelper.setLocalRotation(self._shapeTrs, 0, 0, self.initAngle)
	gohelper.addChildPosStay(self._goShape, self._shapeGO)
end

function FairyLandPuzzle2:addDrag(go)
	if self._drag then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function FairyLandPuzzle2:onStart()
	local isPass = FairyLandModel.instance:isPassPuzzle(self.config.id)

	self._canDrag = not isPass

	gohelper.setActive(self._puzzleGO, not isPass)
	gohelper.setActive(self._shapeGO, not isPass)

	if isPass then
		if self.gyro then
			self.gyro:closeGyro()
		end

		self:resetGOList()
	else
		self:initPuzzleView()
		self:setItemPos(1, 19)
		self:setItemPos(2, 20)
		self:setItemPos(3, 21)
		self:startGyro()
	end

	self:startCheckTips()
end

function FairyLandPuzzle2:startGyro()
	if self.gyro then
		return
	end

	self.gyro = FairyLandGyroRotationComp.New()

	local param = {}

	param.callback = self.checkFinish
	param.callbackObj = self
	param.goList = {
		self._shapeGO,
		self.mainGO
	}

	self.gyro:init(param)
end

function FairyLandPuzzle2:setItemPos(index, pos)
	local item = self.itemList[index]

	if item then
		gohelper.setActive(item.go, true)

		local x = (pos - 1) * 244 - 100
		local y = -((pos - 1) * 73 + 52)

		recthelper.setAnchor(item.transform, x, y)
	end
end

function FairyLandPuzzle2:checkFinish()
	local angle = self:getRotationZ()

	if angle > 160 and angle < 200 then
		self:finished()
	end
end

function FairyLandPuzzle2:finished()
	if self.inDrag then
		return
	end

	self._canDrag = false

	if self.gyro then
		self.gyro:closeGyro()
	end

	self:stopCheckTips()
	self:killTweenId()
	self:playFinishAnim()
end

function FairyLandPuzzle2:playFinishAnim()
	for i, v in ipairs(self.itemList) do
		local x, y, z = transformhelper.getPos(v.itemTransform)

		v.downDir = Vector3.down
		v.initPos = {
			x,
			y,
			z
		}

		v.anim:Play("open", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_barrier_fall)

	self.moveTweenId = ZProj.TweenHelper.DOTweenFloat(0, 10, 0.84, self._itemFrameMove, self._onFinishAnimEnd, self, nil, EaseType.Linear)
end

function FairyLandPuzzle2:_itemFrameMove(value)
	for i, v in ipairs(self.itemList) do
		local dir = v.downDir * value
		local x = dir.x + v.initPos[1]
		local y = dir.y + v.initPos[2]
		local z = dir.z + v.initPos[3]

		transformhelper.setPos(v.itemTransform, x, y, z)
	end
end

function FairyLandPuzzle2:_onFinishAnimEnd()
	self:resetGOList()
	gohelper.setActive(self._puzzleGO, false)
	gohelper.setActive(self._shapeGO, false)
	self:playSuccessTalk()
end

function FairyLandPuzzle2:canDrag()
	return self._canDrag
end

function FairyLandPuzzle2:getRotationZ(transform)
	local x, y, z = transformhelper.getLocalRotation(transform or self._dragTrs)

	return z
end

function FairyLandPuzzle2:vector2Angle(vector)
	return Mathf.Atan2(vector.y - self.initPos.y, vector.x - self.initPos.x) / Mathf.PI * 180
end

function FairyLandPuzzle2:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self:killTweenId()

	self.angleRecord = self:getRotationZ()
	self.clickRecord = self:vector2Angle(pointerEventData.position)
	self.inDrag = true
end

function FairyLandPuzzle2:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local rotAngle = self:vector2Angle(pointerEventData.position)
	local rot2Angle = self.angleRecord + rotAngle - self.clickRecord

	self:_tweenToRotation(self._dragTrs, rot2Angle)
	self:_tween2ToRotation(self.mainTrs, rot2Angle)

	self.inDrag = true
end

function FairyLandPuzzle2:_onEndDrag(dragTransform, pointerEventData)
	self:startCheckTips()

	self.inDrag = false

	if not self:canDrag() then
		return
	end

	self:killTweenId()
	self:checkFinish()
end

function FairyLandPuzzle2:_onDragTweenEnd()
	return
end

function FairyLandPuzzle2:_tweenToRotation(transform, angleZ, callback, callbackObj, param)
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	local curRotationz = self:getRotationZ(transform)

	if math.abs(curRotationz - angleZ) > 1 then
		self.tweenId = ZProj.TweenHelper.DOLocalRotate(transform, 0, 0, angleZ, 0.16, callback, callbackObj, param)
	else
		transformhelper.setLocalRotation(transform, 0, 0, angleZ)

		if callback then
			callback(callbackObj, param)
		end
	end
end

function FairyLandPuzzle2:_tween2ToRotation(transform, angleZ, callback, callbackObj, param)
	if self.tweenId2 then
		ZProj.TweenHelper.KillById(self.tweenId2)

		self.tweenId2 = nil
	end

	local curRotationz = self:getRotationZ(transform)

	if math.abs(curRotationz - angleZ) > 1 then
		self.tweenId2 = ZProj.TweenHelper.DOLocalRotate(transform, 0, 0, angleZ, 0.16, callback, callbackObj, param)
	else
		transformhelper.setLocalRotation(transform, 0, 0, angleZ)

		if callback then
			callback(callbackObj, param)
		end
	end
end

function FairyLandPuzzle2:killTweenId()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.tweenId2 then
		ZProj.TweenHelper.KillById(self.tweenId2)

		self.tweenId2 = nil
	end

	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end
end

function FairyLandPuzzle2:playTipsTalk()
	self.playTalk(self, self.config.tipsTalkId, self.startCheckTalk, self, true, true)
end

function FairyLandPuzzle2:onDestroyView()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self.gyro then
		self.gyro:closeGyro()
	end

	self:killTweenId()
	gohelper.setActive(self._puzzleGO, false)
	gohelper.setActive(self._shapeGO, false)
	self:resetGOList()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetSceneUpdatePos, false)
end

return FairyLandPuzzle2
