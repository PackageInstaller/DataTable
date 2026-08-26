-- chunkname: @modules/logic/seasonver/act123/view3_5/component/Season123_3_5EntryDrag.lua

module("modules.logic.seasonver.act123.view3_5.component.Season123_3_5EntryDrag", package.seeall)

local Season123_3_5EntryDrag = class("Season123_3_5EntryDrag", UserDataDispose)

function Season123_3_5EntryDrag:init(goFullScreen, tfScene)
	self:__onInit()

	self._goFullScreen = goFullScreen
	self._sceneGo = tfScene.gameObject
	self._tfScene = tfScene
	self._tempVector = Vector3.New()
	self._dragDeltaPos = Vector3.New()
	self._tweenId = nil
	self._dragEnabled = true
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goFullScreen)

	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)
	self._drag:AddDragListener(self.onDrag, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.handleScreenResize, self)
end

function Season123_3_5EntryDrag:dispose()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self:killTween()
	self:__onDispose()
end

function Season123_3_5EntryDrag:initBound()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")

	if gohelper.isNil(sizeGo) then
		self:setDragEnabled(false)

		return
	end

	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local posTL = worldcorners[1] * scale
	local posBR = worldcorners[3] * scale

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
	self._mapMaxX = posTL.x
	self._mapMinY = posTL.y
	self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight)
end

function Season123_3_5EntryDrag:onDragBegin(param, pointerEventData)
	if not self._dragEnabled then
		return
	end

	self:killTween()

	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._tfScene then
		self._beginDragPos = self._tfScene.localPosition
	end
end

function Season123_3_5EntryDrag:onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil
end

function Season123_3_5EntryDrag:onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
end

function Season123_3_5EntryDrag:drag(deltaPos)
	if not self._tfScene or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosDrag(targetPos)
end

function Season123_3_5EntryDrag:setScenePosDrag(targetPos)
	targetPos.x, targetPos.y = self:fixTargetPos(targetPos)
	self._targetPos = targetPos

	transformhelper.setLocalPos(self._tfScene, targetPos.x, targetPos.y, 0)
end

function Season123_3_5EntryDrag:setScenePosTween(targetPos, tweenTime, callback, callbackObj)
	if not self._tfScene then
		return
	end

	self._targetPos = targetPos

	local t = tweenTime or 0.46

	self:killTween()

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._tfScene, targetPos.x, targetPos.y, 0, t, self.localMoveDone, self, nil, EaseType.OutQuad)
end

function Season123_3_5EntryDrag:fixTargetPos(targetPos)
	local targetX = targetPos.x
	local targetY = targetPos.y

	if self._mapMinX and self._mapMaxX then
		if targetPos.x < self._mapMinX then
			targetX = self._mapMinX
		elseif targetPos.x > self._mapMaxX then
			targetX = self._mapMaxX
		end
	end

	if self._mapMinY and self._mapMaxY then
		if targetPos.y < self._mapMinY then
			targetY = self._mapMinY
		elseif targetPos.y > self._mapMaxY then
			targetY = self._mapMaxY
		end
	end

	return targetX, targetY
end

function Season123_3_5EntryDrag:localMoveDone()
	self._tweenId = nil
end

function Season123_3_5EntryDrag:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function Season123_3_5EntryDrag:getTempPos()
	return self._tempVector
end

function Season123_3_5EntryDrag:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Season123_3_5EntryDrag:setDragEnabled(value)
	self._dragEnabled = value
end

function Season123_3_5EntryDrag:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._goFullScreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function Season123_3_5EntryDrag:handleScreenResize()
	self:initBound()

	if self._dragEnabled then
		local pos = self:getTempPos()

		pos.x, pos.y = SeasonEntryEnum.DefaultScenePosX, SeasonEntryEnum.DefaultScenePosY

		self:setScenePosDrag(pos)
	end
end

return Season123_3_5EntryDrag
