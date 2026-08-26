-- chunkname: @modules/logic/survival/view/SurvivalMapDragBaseView.lua

module("modules.logic.survival.view.SurvivalMapDragBaseView", package.seeall)

local SurvivalMapDragBaseView = class("SurvivalMapDragBaseView", BaseView)

function SurvivalMapDragBaseView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._clickFull = gohelper.findChildClick(self.viewGO, "#go_full")
end

function SurvivalMapDragBaseView:addEvents()
	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._gofull)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetScrollWheelCb(self.onMouseScrollWheelChange, self)

	if BootNativeUtil.isMobilePlayer() then
		self._touchEventMgr:SetOnMultiDragCb(self.onMultDrag, self)
	end

	self._clickFull:AddClickListener(self._onClickFull, self)
	CommonDragHelper.instance:registerDragObj(self._gofull, self._beginDrag, self._onDrag, self._endDrag, nil, self, nil, true)
	SurvivalController.instance:registerCallback(SurvivalEvent.TweenCameraFocus, self._onTweenToPos, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.GuideClickPos, self._onGuideClickPos, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.GuideTweenCameraPos, self._onGuideTweenCameraPos, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.ChangeCameraScale, self._onChangeCameraScale, self)
	UpdateBeat:Add(self._onUpdate, self)
end

function SurvivalMapDragBaseView:removeEvents()
	self._clickFull:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self._gofull)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.TweenCameraFocus, self._onTweenToPos, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.GuideClickPos, self._onGuideClickPos, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.GuideTweenCameraPos, self._onGuideTweenCameraPos, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.ChangeCameraScale, self._onChangeCameraScale, self)
	UpdateBeat:Remove(self._onUpdate, self)
end

function SurvivalMapDragBaseView:onOpen()
	self._scale = 1

	self:calcSceneBoard()
end

function SurvivalMapDragBaseView:_onDrag(_, pointerEventData)
	if UnityEngine.Input.touchCount > 1 or UIBlockMgr.instance:isBlock() then
		return
	end

	local prePos = SurvivalHelper.instance:getScene3DPos(pointerEventData.position - pointerEventData.delta)
	local nowPos = SurvivalHelper.instance:getScene3DPos()
	local deltaWorldPos = nowPos - prePos

	deltaWorldPos.y = 0

	self:setScenePosSafety(self._targetPos:Sub(deltaWorldPos))
end

function SurvivalMapDragBaseView:_onClickFull()
	if self._isDrag then
		return
	end

	local worldpos = SurvivalHelper.instance:getScene3DPos()
	local q, r, s = SurvivalHelper.instance:worldPointToHex(worldpos.x, worldpos.y, worldpos.z)
	local hexPos = SurvivalHexNode.New(q, r, s)

	self:onClickScene(worldpos, hexPos)
end

function SurvivalMapDragBaseView:onClickScene(worldpos, hexPos)
	return
end

function SurvivalMapDragBaseView:_beginDrag(_, pointerEventData)
	self._isDrag = true
end

function SurvivalMapDragBaseView:_endDrag(_, pointerEventData)
	self._isDrag = false
end

function SurvivalMapDragBaseView:onMouseScrollWheelChange(deltaData)
	self:_setScale(self._scale + deltaData)
end

function SurvivalMapDragBaseView:onMultDrag(isEnLarger, delta)
	self:_setScale(self._scale + delta * 0.01)
end

function SurvivalMapDragBaseView:_setScale(scaleVal, isForce)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.SurvivalToastView
	}) and not isForce then
		return
	end

	scaleVal = Mathf.Clamp(scaleVal, 0, 1)

	if scaleVal == self._scale and not isForce then
		return
	end

	self._lastScale = self._scale
	self._scale = scaleVal

	SurvivalMapHelper.instance:setDistance(self._maxDis - (self._maxDis - self._minDis) * self._scale)
	self:onSceneScaleChange()
end

function SurvivalMapDragBaseView:onSceneScaleChange()
	return
end

function SurvivalMapDragBaseView:calcSceneBoard()
	self._mapMinX = -10
	self._mapMaxX = 10
	self._mapMinY = -10
	self._mapMaxY = 10
	self._maxDis = 10
	self._minDis = 5
end

function SurvivalMapDragBaseView:_onTweenToPos(pos, time, callback, callbackObj)
	self._tweenFinishCallback = callback
	self._tweenFinishCallbackObj = callbackObj
	self._fromPos = self._targetPos
	self._toPos = pos

	self:cancelCameraTween()

	time = time or 0.5

	if time <= 0 then
		self:setScenePosSafety(self._toPos)
		self:doTweenFinishCallback()
	else
		self._cameraTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, time, self._onTweenCamera, self._onTweenCameraFinish, self)
	end
end

function SurvivalMapDragBaseView:doTweenFinishCallback()
	if self._tweenFinishCallback then
		self._tweenFinishCallback(self._tweenFinishCallbackObj)

		self._tweenFinishCallback = nil
		self._tweenFinishCallbackObj = nil
	end
end

function SurvivalMapDragBaseView:_onGuideClickPos(str)
	if string.nilorempty(str) then
		return
	end

	local q, r = string.match(str, "([-%d.]+)_([-%d.]+)")

	if q and r then
		q = tonumber(q)
		r = tonumber(r)

		local hexPos = SurvivalHexNode.New(q, r)
		local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(q, r)
		local worldpos = Vector3(x, y, z)

		self:onClickScene(worldpos, hexPos)
	end
end

function SurvivalMapDragBaseView:_onGuideTweenCameraPos(str)
	if string.nilorempty(str) then
		return
	end

	local q, r, time = string.match(str, "([-%d.]+)_([-%d.]+)_([-%d.]+)")

	if q and r then
		q = tonumber(q)
		r = tonumber(r)
		time = tonumber(time)

		local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(q, r)
		local worldpos = Vector3(x, y, z)

		self:_onTweenToPos(worldpos, time)
	end
end

function SurvivalMapDragBaseView:_onTweenCameraFinish()
	self._cameraTweenId = nil

	self:doTweenFinishCallback()
end

function SurvivalMapDragBaseView:_onTweenCamera(value)
	self:setScenePosSafety(Vector3.Lerp(self._fromPos, self._toPos, value))
end

function SurvivalMapDragBaseView:cancelCameraTween()
	if self._cameraTweenId then
		ZProj.TweenHelper.KillById(self._cameraTweenId)

		self._cameraTweenId = nil
	end
end

function SurvivalMapDragBaseView:setScenePosSafety(targetPos)
	if targetPos.x < self._mapMinX then
		targetPos.x = self._mapMinX
	elseif targetPos.x > self._mapMaxX then
		targetPos.x = self._mapMaxX
	end

	if targetPos.z < self._mapMinY then
		targetPos.z = self._mapMinY
	elseif targetPos.z > self._mapMaxY then
		targetPos.z = self._mapMaxY
	end

	self._targetPos = targetPos

	SurvivalMapHelper.instance:setFocusPos(targetPos.x, targetPos.y, targetPos.z)
end

function SurvivalMapDragBaseView:setFollower(followerGO)
	self._followerTrs = nil

	if not gohelper.isNil(followerGO) then
		self._followerTrs = followerGO.transform
	end
end

function SurvivalMapDragBaseView:_onUpdate()
	self:_followerTarget(self._followerTrs)
end

function SurvivalMapDragBaseView:_followerTarget(transform)
	if gohelper.isNil(transform) then
		return
	end

	if self._followerPos == nil then
		self._followerPos = Vector3.zero
	end

	local x, y, z = transformhelper.getPos(transform)
	local isSamePos = self:_equalsZero(x - self._followerPos.x) and self:_equalsZero(y - self._followerPos.y) and self:_equalsZero(z - self._followerPos.z)

	if isSamePos then
		return
	end

	self._followerPos:Set(x, y, z)
	self:setScenePosSafety(self._followerPos)
end

function SurvivalMapDragBaseView:_equalsZero(val)
	local _zeroEpsion = 1e-06

	return val >= -_zeroEpsion and val <= _zeroEpsion
end

function SurvivalMapDragBaseView:_onChangeCameraScale(scale, tween)
	if scale == nil then
		scale = self._lastScale
	end

	if not scale then
		return
	end

	self:_setScale(scale, true)

	if not tween then
		SurvivalMapHelper.instance:applyDirectly()
	end
end

return SurvivalMapDragBaseView
