-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/puzzle/FairyLandPuzzle1.lua

module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle1", package.seeall)

local FairyLandPuzzle1 = class("FairyLandPuzzle1", FairyLandPuzzleBase)

FairyLandPuzzle1.ZeroVector2 = Vector2(0, 0)

function FairyLandPuzzle1:onInitView()
	self._puzzleGO = gohelper.findChild(self.viewGO, "main/#go_Root/#go_Puzzle/1")
	self._shapeGO = gohelper.findChild(self.viewGO, "main/#go_Shape/1")
	self.tipAnim = SLFramework.AnimatorPlayer.Get(self._shapeGO)
	self._shapeTrs = self._shapeGO.transform
	self._goImageShape = gohelper.findChild(self._shapeGO, "image_shape")
	self._dragTrs = self._goImageShape.transform

	self:addDrag(self._goImageShape)

	self.itemList = self:getUserDataTb_()

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self._puzzleGO, "item" .. tostring(i))
		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		self.itemList[i] = item
	end

	self.limitPos = 30
	self.shakeLimitPos = 15
	self.initPos = self._dragTrs.anchoredPosition
	self.lastDistance = 0
	self.shakeFinishTime = 3
	self.shakeTime = 0
end

function FairyLandPuzzle1:addDrag(go)
	if self._drag then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function FairyLandPuzzle1:onStart()
	local isPass = FairyLandModel.instance:isPassPuzzle(self.config.id)

	self._canDrag = not isPass

	gohelper.setActive(self._puzzleGO, not isPass)
	gohelper.setActive(self._shapeGO, not isPass)

	self.finishDict = {}

	for i = 1, 3 do
		self.finishDict[i] = isPass
	end

	self:setItemPos(1, 11)
	self:setItemPos(2, 12)
	self:setItemPos(3, 13)

	if isPass then
		if self.gyro then
			self.gyro:closeGyro()
		end
	else
		self:startGyro()
	end

	self:startCheckTips()
end

function FairyLandPuzzle1:startGyro()
	if self.gyro then
		return
	end

	self.gyro = FairyLandGyroComp.New()

	local param = {}

	param.callback = self.frameUpdate
	param.callbackObj = self
	param.go = self._goImageShape
	param.posLimit = self.limitPos

	self.gyro:init(param)
end

function FairyLandPuzzle1:setItemPos(index, pos)
	local item = self.itemList[index]

	if item then
		gohelper.setActive(item.go, not self.finishDict[index])

		local x = (pos - 1) * 244 - 102
		local y = -((pos - 1) * 73 + 59)

		recthelper.setAnchor(item.go.transform, x, y)
	end
end

function FairyLandPuzzle1:moveItem()
	for i, v in ipairs(self.itemList) do
		if not self.finishDict[i] then
			v.anim:Play("move")

			v.anim.speed = 1

			self:playShakeAudio()

			break
		end
	end
end

function FairyLandPuzzle1:stopItem()
	for i, v in ipairs(self.itemList) do
		if not self.finishDict[i] then
			v.anim.speed = 0

			self:stopShakeAudio()

			break
		end
	end
end

function FairyLandPuzzle1:checkFinish()
	for i, v in ipairs(self.itemList) do
		if not self.finishDict[i] then
			self:setItemFinish(i)

			break
		end
	end
end

function FairyLandPuzzle1:setItemFinish(index)
	self.finishDict[index] = true

	local item = self.itemList[index]

	if item then
		item.anim:Play("close", 0, 0)

		item.anim.speed = 1

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bean_fall)
	end

	local allFinish = true

	for i, v in ipairs(self.itemList) do
		if not self.finishDict[i] then
			allFinish = false

			break
		end
	end

	if allFinish then
		self:stopShakeAudio()

		self._canDrag = false

		if self.gyro then
			self.gyro:closeGyro()

			self.gyro = nil
		end

		TaskDispatcher.runDelay(self.onItemTweenFinish, self, 2)
	end
end

function FairyLandPuzzle1:onItemTweenFinish()
	gohelper.setActive(self._puzzleGO, false)
	gohelper.setActive(self._shapeGO, false)
	self:playSuccessTalk()
end

function FairyLandPuzzle1:canDrag()
	return self._canDrag
end

function FairyLandPuzzle1:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self:killTweenId()

	local anchorPos = self:getDragPos(pointerEventData.position)

	self.offsetPos = anchorPos

	self:_tweenToPos(self._dragTrs, anchorPos - self.offsetPos)

	self.inDrag = true
	self.shakeTime = 0
	self.shaking = false
end

function FairyLandPuzzle1:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local anchorPos = self:getDragPos(pointerEventData.position)

	self:_tweenToPos(self._dragTrs, anchorPos - self.offsetPos)

	self.inDrag = true
end

function FairyLandPuzzle1:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false
	self.shaking = false
	self.shakeTime = 0

	if not self:canDrag() then
		return
	end

	self:killTweenId()

	local anchorPos = FairyLandPuzzle1.ZeroVector2

	self._tweenToPos(self, self._dragTrs, anchorPos, self._onDragTweenEnd, self)
end

function FairyLandPuzzle1:_onDragTweenEnd()
	return
end

function FairyLandPuzzle1:frameUpdate()
	self:checkShake()

	if self.shaking then
		self:onShake()
	else
		self:stopItem()
	end
end

function FairyLandPuzzle1:checkShake()
	local curPos = self._dragTrs.anchoredPosition

	self.lastPos = self.lastPos or curPos

	local distance = Vector2.Distance(self.lastPos, curPos)

	self.shaking = distance > 0.1
	self.lastPos = curPos
end

function FairyLandPuzzle1:getDragPos(position)
	return (recthelper.screenPosToAnchorPos(position, self._shapeTrs))
end

function FairyLandPuzzle1:_tweenToPos(transform, anchorPos, callback, callbackObj, param)
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end

	local movePos = self:clampPos(anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - movePos.x) > 10 or math.abs(curAnchorY - movePos.y) > 10 then
		self.posTweenId = ZProj.TweenHelper.DOAnchorPos(transform, movePos.x, movePos.y, 0.16, callback, callbackObj, param)
	else
		recthelper.setAnchor(transform, movePos.x, movePos.y)

		if callback then
			callback(callbackObj, param)
		end
	end
end

function FairyLandPuzzle1:clampPos(anchorPos)
	local distance = Vector2.Distance(self.initPos, anchorPos)

	if distance < self.limitPos then
		return anchorPos
	end

	local offsetPos = anchorPos - self.initPos

	return self.initPos + offsetPos.normalized * self.limitPos
end

function FairyLandPuzzle1:onShake()
	self.shakeTime = self.shakeTime + Time.deltaTime * 0.9

	if self.shakeTime >= self.shakeFinishTime then
		self.shakeTime = 0
		self.shaking = false

		self:checkFinish()
	else
		self:moveItem()
	end
end

function FairyLandPuzzle1:killTweenId()
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end
end

function FairyLandPuzzle1:playShakeAudio()
	if self.playingId then
		return
	end

	self.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bean_shaking)
end

function FairyLandPuzzle1:stopShakeAudio()
	if self.playingId then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function FairyLandPuzzle1:onDestroyView()
	self:stopShakeAudio()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self.gyro then
		self.gyro:closeGyro()

		self.gyro = nil
	end

	self:killTweenId()
	gohelper.setActive(self._puzzleGO, false)
	gohelper.setActive(self._shapeGO, false)
	TaskDispatcher.cancelTask(self.onItemTweenFinish, self)
end

return FairyLandPuzzle1
