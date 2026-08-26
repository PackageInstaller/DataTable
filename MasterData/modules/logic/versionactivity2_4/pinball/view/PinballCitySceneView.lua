-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCitySceneView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCitySceneView", package.seeall)

local PinballCitySceneView = class("PinballCitySceneView", PinballBaseSceneView)

function PinballCitySceneView:onInitView()
	self._gobuildingui = gohelper.findChild(self.viewGO, "#go_buildingui")
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._clickFull = gohelper.findChildClick(self.viewGO, "#go_full")
end

function PinballCitySceneView:addEvents()
	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._gofull)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetScrollWheelCb(self.onMouseScrollWheelChange, self)

	if BootNativeUtil.isMobilePlayer() then
		self._touchEventMgr:SetOnMultiDragCb(self.onMultDrag, self)
	end

	self._clickFull:AddClickListener(self._onClickFull, self)
	CommonDragHelper.instance:registerDragObj(self._gofull, self._beginDrag, self._onDrag, self._endDrag, nil, self, nil, true)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.calcSceneBoard, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._tweenToMainCity, self)
	PinballController.instance:registerCallback(PinballEvent.TweenToHole, self._tweenToHole, self)
end

function PinballCitySceneView:removeEvents()
	self._clickFull:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self._gofull)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.calcSceneBoard, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._tweenToMainCity, self)
	PinballController.instance:unregisterCallback(PinballEvent.TweenToHole, self._tweenToHole, self)
end

function PinballCitySceneView:beforeLoadScene()
	self._sceneTrans = self._sceneRoot.transform
	self._buildingRoot = gohelper.create3d(self._sceneRoot, "Building")
end

function PinballCitySceneView:onSceneLoaded(sceneGo)
	self._scale = PinballConst.Const105

	transformhelper.setLocalScale(self._sceneTrans, self._scale, self._scale, 1)

	self._sceneGo = sceneGo

	self:calcSceneBoard()
	self:placeBuildings()
	self:setScenePosSafety(self:getMainPos())
end

function PinballCitySceneView:placeBuildings()
	local coDict = PinballConfig.instance:getAllHoleCo(VersionActivity2_4Enum.ActivityId.Pinball)

	self._buildings = {}

	local path = self.viewContainer._viewSetting.otherRes.menu

	for index, co in pairs(coDict) do
		local go = gohelper.create3d(self._buildingRoot, tostring(index))
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballBuildingEntity)

		comp:initCo(co)
		comp:setUI(self:getResInst(path, self._gobuildingui, "UI_" .. index))
		comp:setUIScale(self._scale)
		table.insert(self._buildings, comp)
	end
end

function PinballCitySceneView:calcSceneBoard()
	self._mapMinX = -10
	self._mapMaxX = 10
	self._mapMinY = -10
	self._mapMaxY = 10

	if not self._sceneGo then
		return
	end

	local sizeGo = gohelper.findChild(self._sceneGo, "BackGround/size")

	if not sizeGo then
		return
	end

	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if not box then
		return
	end

	local lossyScale = sizeGo.transform.lossyScale

	self._mapSize = box.size
	self._mapSize.x = self._mapSize.x * lossyScale.x
	self._mapSize.y = self._mapSize.y * lossyScale.y

	local canvasGo
	local scale = GameUtil.getAdapterScale()

	scale = scale * 7 / 5

	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local posTL = worldcorners[1] * scale
	local posBR = worldcorners[3] * scale

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)

	local cameraOffsetY = 5.8
	local center = box.center

	self._mapMinX = posTL.x - (self._mapSize.x / 2 - self._viewWidth) - center.x * lossyScale.x
	self._mapMaxX = posTL.x + self._mapSize.x / 2 - center.x * lossyScale.x
	self._mapMinY = posTL.y - self._mapSize.y / 2 + cameraOffsetY - center.y * lossyScale.y
	self._mapMaxY = posTL.y + (self._mapSize.y / 2 - self._viewHeight) + cameraOffsetY - center.y * lossyScale.y
end

function PinballCitySceneView:onMouseScrollWheelChange(deltaData)
	self:_setScale(self._scale + deltaData * PinballConst.Const103)
end

function PinballCitySceneView:onMultDrag(isEnLarger, delta)
	self:_setScale(self._scale + delta * 0.01 * PinballConst.Const104)
end

function PinballCitySceneView:_setScale(scaleVal)
	if not self._sceneGo then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.PinballCityView) then
		return
	end

	scaleVal = Mathf.Clamp(scaleVal, PinballConst.Const101, PinballConst.Const102)

	if scaleVal == self._scale then
		return
	end

	self._targetPos.x = self._targetPos.x / self._scale * scaleVal
	self._targetPos.y = self._targetPos.y / self._scale * scaleVal
	self._scale = scaleVal

	transformhelper.setLocalScale(self._sceneTrans, self._scale, self._scale, 1)
	self:calcSceneBoard()
	self:setScenePosSafety(self._targetPos)

	for _, building in pairs(self._buildings) do
		building:setUIScale(self._scale)
	end
end

function PinballCitySceneView:_tweenToMainCity(viewName)
	if viewName ~= ViewName.PinballDayEndView then
		return
	end

	local mainPos = self:getMainPos()

	if not mainPos then
		return
	end

	self._fromPos = self._targetPos
	self._toPos = mainPos
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._onTween, self._onTweenFinish, self)
end

function PinballCitySceneView:_tweenToHole(holeIndex)
	local mainPos = self:getHolePos(tonumber(holeIndex) or PinballModel.instance.guideHole or 1)

	if not mainPos then
		return
	end

	self._fromPos = self._targetPos
	self._toPos = mainPos
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._onTween, self._onTweenFinish, self)
end

function PinballCitySceneView:getMainPos()
	if not self._buildings then
		return
	end

	local mainPos

	for _, building in pairs(self._buildings) do
		if building:isMainCity() then
			mainPos = -building.trans.localPosition
			mainPos.y = (-building.trans.localPosition).y + 5.8
		end
	end

	return mainPos
end

function PinballCitySceneView:getHolePos(index)
	if not self._buildings then
		return
	end

	local pos

	for _, building in pairs(self._buildings) do
		if building.co.index == index then
			pos = -building.trans.localPosition
			pos.y = (-building.trans.localPosition).y + 5.8
		end
	end

	return pos
end

function PinballCitySceneView:_onTween(value)
	self:setScenePosSafety(Vector3.Lerp(self._fromPos, self._toPos, value))
end

function PinballCitySceneView:_onTweenFinish()
	self._tweenId = nil
end

local zeroPos = Vector3()

function PinballCitySceneView:_onClickFull()
	if self._isDrag then
		return
	end

	if not self._buildings then
		return
	end

	self.viewContainer:dispatchEvent(PinballEvent.ClickScene)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local worldpos = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), mainCamera, zeroPos)
	local clickIndex

	for _, building in pairs(self._buildings) do
		clickIndex = building:tryClick(worldpos, self._scale) or clickIndex
	end

	PinballController.instance:dispatchEvent(PinballEvent.OnClickBuilding, clickIndex or 0)
end

function PinballCitySceneView:_beginDrag(_, pointerEventData)
	self._isDrag = true
end

function PinballCitySceneView:_endDrag(_, pointerEventData)
	self._isDrag = false
end

function PinballCitySceneView:_onDrag(_, pointerEventData)
	if not self._targetPos then
		return
	end

	if UnityEngine.Input.touchCount > 1 then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local prePos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position - pointerEventData.delta, mainCamera, zeroPos)
	local nowPos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, zeroPos)
	local deltaWorldPos = nowPos - prePos

	deltaWorldPos.z = 0

	self:setScenePosSafety(self._targetPos:Add(deltaWorldPos))
end

function PinballCitySceneView:setScenePosSafety(targetPos)
	if not self._mapMinX then
		return
	end

	if targetPos.x < self._mapMinX then
		targetPos.x = self._mapMinX
	elseif targetPos.x > self._mapMaxX then
		targetPos.x = self._mapMaxX
	end

	if targetPos.y < self._mapMinY then
		targetPos.y = self._mapMinY
	elseif targetPos.y > self._mapMaxY then
		targetPos.y = self._mapMaxY
	end

	self._targetPos = targetPos
	self._sceneTrans.localPosition = targetPos
end

function PinballCitySceneView:getScenePath()
	return "scenes/v2a4_m_s12_ttsz_jshd/scenes_prefab/v2a4_m_s12_ttsz_jshd_p.prefab"
end

function PinballCitySceneView:onClose()
	PinballCitySceneView.super.onClose(self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return PinballCitySceneView
