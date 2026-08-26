-- chunkname: @modules/logic/sodache/view/inside/SodacheMapSceneView.lua

module("modules.logic.sodache.view.inside.SodacheMapSceneView", package.seeall)

local SodacheMapSceneView = class("SodacheMapSceneView", BaseView)

function SodacheMapSceneView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_full")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self._mapCo = SodacheModel.instance:getInsideMo().mapCo

	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = gohelper.create3d(sceneRoot, "SodacheMapScene")
	self._scenePos = Vector3()
	self._tempVector = Vector3()
	self._unitIconItem = gohelper.findChild(self.viewGO, "Bubble/#go_unitItem/sodache_mapunititem")

	gohelper.setActive(self._unitIconItem, false)

	local _, y = transformhelper.getLocalPos(CameraMgr.instance:getCameraTraceGO().transform)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._mapRoot = gohelper.create3d(self._sceneRoot, "map")
	self._nodeRoot = gohelper.create3d(self._mapRoot, "node")
	self._pathRoot = gohelper.create3d(self._mapRoot, "path")
	self._unitRoot = gohelper.create3d(self._mapRoot, "unit")

	transformhelper.setLocalPos(self._unitRoot.transform, 0, 0, -1)

	self._mapTrans = self._mapRoot.transform
	self._hasBtn = false
	self._curCameraSize = SodacheEnum.DungeonMapCameraSize
	self._toCameraSize = SodacheEnum.DungeonMapCameraSize

	if SodacheModel.instance:getInsideMo().copyCo.type == SodacheEnum.MapType.Hard then
		local filterGo = gohelper.create3d(self._sceneRoot, "filter")
		local loader = PrefabInstantiate.Create(filterGo)

		loader:startLoad("modules/sodache/scene/scenes_prefab/v3a7_m_s08_soudache_filter.prefab")
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.SodacheMap, AudioEnum3_7.Sodache.play_soudache_twist_3_7)
	else
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.SodacheMap, AudioEnum3_7.Sodache.play_soudache_explore_3_7)
	end
end

function SodacheMapSceneView:addEvents()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._click:AddClickDownListener(self._onClickDown, self)
	self._click:AddClickUpListener(self._onClickUp, self)
	SodacheController.instance:registerCallback(SodacheEvent.TweenCameraToNode, self.tweenToNodeId, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnPathCostStrChange, self.onPathCostStrChange, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdatePatrolInfo, self.updatePathLineShow, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdateNodeVision, self._refreshLineAndNodeShow, self)
	self.viewContainer:registerCallback(SodacheEvent.OnMapShowBtnsChange, self._hasButtonChange, self)
	self.viewContainer:registerCallback(SodacheEvent.OnMapFocusEventChange, self._onFocusEventChange, self)
	SodacheController.instance:registerCallback(SodacheEvent.CheckSceneFinish, self.checkSceneFinish, self)
end

function SodacheMapSceneView:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self._click:RemoveClickDownListener()
	self._click:RemoveClickUpListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.TweenCameraToNode, self.tweenToNodeId, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnPathCostStrChange, self.onPathCostStrChange, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdatePatrolInfo, self.updatePathLineShow, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdateNodeVision, self._refreshLineAndNodeShow, self)
	self.viewContainer:unregisterCallback(SodacheEvent.OnMapShowBtnsChange, self._hasButtonChange, self)
	self.viewContainer:unregisterCallback(SodacheEvent.OnMapFocusEventChange, self._onFocusEventChange, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.CheckSceneFinish, self.checkSceneFinish, self)
end

function SodacheMapSceneView:onOpen()
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)

	self._loader = PrefabInstantiate.Create(self._mapRoot)

	self._loader:startLoad(self._mapCo.mapPath, self._onLoadSceneFinish, self)
end

function SodacheMapSceneView:checkSceneFinish(data)
	if not self._sceneGo then
		data.isLoading = true
	end
end

function SodacheMapSceneView:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = self._curCameraSize * scale
	end
end

function SodacheMapSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = self._curCameraSize * scale
end

function SodacheMapSceneView:_onLoadSceneFinish()
	self._sceneGo = self._loader:getInstGO()

	self:_initScene()

	local insideMo = SodacheModel.instance:getInsideMo()
	local id = insideMo.player.locationId
	local nodeInfo = self._mapCo.nodes[id]

	if not nodeInfo then
		logError("角色位置错误！" .. id)

		id, nodeInfo = next(self._mapCo.nodes)

		if not nodeInfo then
			return
		end
	end

	local nodePos = nodeInfo.pos

	self:directSetScenePos(-nodePos)
	self:initNodes()
	self.viewContainer:dispatchEvent(SodacheEvent.OnSceneAssetInited, self._unitRoot)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnSceneFinish)
end

function SodacheMapSceneView:tweenToNodeId(nodeId, subId, callback, callobj)
	if not nodeId then
		nodeId = SodacheModel.instance:getInsideMo().player.locationId
		subId = subId or 0
	end

	self:killTween()

	local nodeInfo = self._mapCo.nodes[nodeId]

	if not nodeInfo or not self._sceneGo then
		if callback then
			callback(callobj)
		end

		return
	end

	local nodePos = nodeInfo.pos
	local offset = nodeInfo.offsetList[subId]

	if offset then
		nodePos = nodePos + offset
	end

	self._beginPos = self._scenePos:Clone()
	self._targetPos = -nodePos
	self._tweenEndCallback = callback
	self._tweenEndCallobj = callobj

	if Vector3.Distance(self._beginPos, self._targetPos) < 0.05 then
		self:killTween()

		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self._onTweenPos, self.killTween, self)
end

function SodacheMapSceneView:_onTweenPos(value)
	self:directSetScenePos(Vector3.Lerp(self._beginPos, self._targetPos, value))
end

function SodacheMapSceneView:killTween()
	local cb = self._tweenEndCallback
	local obj = self._tweenEndCallobj

	self._tweenEndCallback = nil
	self._tweenEndCallobj = nil

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if cb then
		self._tweenEndCallback(obj)
	end
end

function SodacheMapSceneView:killAllTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenCameraSizeId then
		ZProj.TweenHelper.KillById(self._tweenCameraSizeId)

		self._tweenCameraSizeId = nil
	end
end

function SodacheMapSceneView:_initScene()
	if not self._sceneGo then
		return
	end

	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")

	if SodacheUtil.isRookie() then
		local sizeGo2 = gohelper.findChild(self._sceneGo, "root/size2")

		if sizeGo2 then
			sizeGo = sizeGo2
		end
	end

	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local lossyScale = sizeGo.transform.lossyScale

	self._mapSize = box.size
	self._mapSize.x = self._mapSize.x * lossyScale.x
	self._mapSize.y = self._mapSize.y * lossyScale.y

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()

	if uiCamera then
		if not uiCamera.orthographicSize then
			local uiCameraSize = 5
			local cameraSizeRate = self._curCameraSize / uiCameraSize
			local posTL = worldcorners[1] * scale * cameraSizeRate
			local posBR = worldcorners[3] * scale * cameraSizeRate

			self._viewWidth = math.abs(posBR.x - posTL.x)
			self._viewHeight = math.abs(posBR.y - posTL.y)

			local center = box.center
			local posX, posY, posZ = transformhelper.getLocalPos(sizeGo.transform)

			center.x = center.x + posX
			center.y = center.y + posY
			self._mapMinX = posTL.x - (self._mapSize.x / 2 - self._viewWidth) - center.x * lossyScale.x
			self._mapMaxX = posTL.x + self._mapSize.x / 2 - center.x * lossyScale.x
			self._mapMinY = posTL.y - self._mapSize.y / 2 - center.y * lossyScale.y
			self._mapMaxY = posTL.y + (self._mapSize.y / 2 - self._viewHeight) - center.y * lossyScale.y
			self._mapMinX = math.min(self._mapMinX, self._mapMaxX)
			self._mapMinY = math.min(self._mapMinY, self._mapMaxY)
		end
	end
end

function SodacheMapSceneView:initNodes()
	local nodeRoot = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/dianwei")
	local lineRoot = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/luxian")
	local nodeDict = {}
	local nodeAnimPath = self.viewContainer._viewSetting.otherRes.nodeAnim

	self._nodeAnims = self:getUserDataTb_()

	if nodeRoot then
		local trans = nodeRoot.transform

		for i = 0, trans.childCount - 1 do
			local child = trans:GetChild(i)
			local nodeId = tonumber(child.name)

			if self._mapCo.nodes[nodeId] then
				nodeDict[nodeId] = child.gameObject

				local animGo = self:getResInst(nodeAnimPath, nodeDict[nodeId], "anim")

				self._nodeAnims[nodeId] = gohelper.findComponentAnim(animGo)
			else
				gohelper.setActive(child.gameObject, false)
			end
		end
	end

	self.allLines = self:getUserDataTb_()
	self.allLineRenderers = self:getUserDataTb_()
	self._previewLineProp = UnityEngine.MaterialPropertyBlock.New()

	self._previewLineProp:SetColor("_MainCol", SodacheEnum.PreviewLineColor)

	self._patrollLineProp = UnityEngine.MaterialPropertyBlock.New()

	self._patrollLineProp:SetColor("_MainCol", SodacheEnum.PatrollLineColor)

	if lineRoot then
		local trans = lineRoot.transform

		for i = 0, trans.childCount - 1 do
			local child = trans:GetChild(i)
			local arr = GameUtil.splitString2(child.name, true, "#", "_") or {}
			local lineGo = child.gameObject
			local lineMeshRenderer = child:GetComponent(typeof(UnityEngine.MeshRenderer))
			local lineIds = {}

			for _, v in ipairs(arr) do
				local lineId = self:_getLineId(v[1], v[2])

				table.insert(lineIds, lineId)
			end

			if #lineIds <= 0 then
				gohelper.setActive(lineGo, false)
			else
				self.allLines[lineGo] = lineIds
				self.allLineRenderers[lineMeshRenderer] = lineIds
			end
		end
	end

	self.allNodes = {}

	for k, v in pairs(self._mapCo.nodes) do
		local node = gohelper.create3d(self._nodeRoot, tostring(v.id))

		gohelper.setLayer(node, UnityLayer.Scene)

		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(node, SodacheNodeItem)

		comp:initData(v, nodeDict[v.id])

		self.allNodes[v.id] = comp

		local iconGo = gohelper.cloneInPlace(self._unitIconItem, tostring(v.id))

		gohelper.setActive(iconGo, true)

		comp = MonoHelper.addLuaComOnceToGo(iconGo, SodacheUnitIconItem)

		comp:setNodeInfo(v.id, node)
	end

	self:_refreshLineAndNodeShow()
	self:updatePathLineShow()
end

function SodacheMapSceneView:_refreshLineAndNodeShow()
	if not self._sceneGo then
		return
	end

	local insideMo = SodacheModel.instance:getInsideMo()

	for nodeId, nodeComp in pairs(self.allNodes) do
		nodeComp:updateIsActice(insideMo.allShowNodes[nodeId] or false)
	end

	for lineGo, lineArr in pairs(self.allLines) do
		local isActive = self:_containKey(lineArr, insideMo.allShowLines)

		gohelper.setActive(lineGo, isActive)
	end
end

function SodacheMapSceneView:onPathCostStrChange(_, pathInfo)
	self.previewPaths = pathInfo and pathInfo.path

	self:updatePathLineShow()
end

function SodacheMapSceneView:updatePathLineShow()
	if not self._sceneGo then
		return
	end

	local allMovePathIds = {}
	local allMoveNodeIds = {}
	local paths = self.previewPaths

	if paths then
		for i = 1, #paths - 1 do
			local pathId = self:_getLineId(paths[i], paths[i + 1])

			if pathId then
				allMovePathIds[pathId] = true
			end

			allMoveNodeIds[paths[i]] = true
			allMoveNodeIds[paths[i + 1]] = true
		end
	end

	for nodeId, anim in pairs(self._nodeAnims) do
		if anim.isActiveAndEnabled then
			anim:Play(allMoveNodeIds[nodeId] and "select" or "light")
		end
	end

	local patrollLineInfo = SodacheModel.instance:getInsideMo().patrolBox
	local allPatrollLineIds = {}

	for _, v in ipairs(patrollLineInfo) do
		local arr2 = v.patrolPath
		local len = #arr2

		for j = 1, len - 1 do
			local p1 = arr2[j]
			local p2 = arr2[j + 1]
			local pathId = self:_getLineId(p1, p2)

			if pathId then
				allPatrollLineIds[pathId] = true
			end
		end
	end

	for renderer, lineArr in pairs(self.allLineRenderers) do
		local isMovePath = self:_containKey(lineArr, allMovePathIds)
		local isPatrol = self:_containKey(lineArr, allPatrollLineIds)
		local var_17_0

		if isMovePath then
			var_17_0 = self._previewLineProp

			if not self._previewLineProp then
				if isPatrol then
					var_17_0 = self._patrollLineProp or nil
				end
			end
		end

		renderer:SetPropertyBlock(var_17_0)
	end
end

function SodacheMapSceneView:_containKey(arr, dict)
	for i, v in ipairs(arr) do
		if dict[v] then
			return true
		end
	end

	return false
end

function SodacheMapSceneView:_getLineId(nodeId1, nodeId2)
	return self._mapCo:getLineId(nodeId1, nodeId2)
end

function SodacheMapSceneView:getCurVisionVal()
	local attrVal = SodacheUtil.getAttr(SodacheEnum.AttrId.TopVision)

	if attrVal <= 0 then
		attrVal = SodacheUtil.getAttr(SodacheEnum.AttrId.NormalVision)
	end

	return attrVal
end

function SodacheMapSceneView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)
end

function SodacheMapSceneView:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
end

function SodacheMapSceneView:canClickScene()
	local insideMo = SodacheModel.instance:getInsideMo()

	return insideMo and insideMo.prop.status == SodacheEnum.InsideSceneStatus.Normal
end

function SodacheMapSceneView:_onClickDown()
	if not self:canClickScene() then
		return
	end

	SodacheMapUtil.instance:setClickType(SodacheEnum.MapBtnClickType.MapScene)
end

function SodacheMapSceneView:_onClickUp()
	if not SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.MapScene) then
		return
	end

	if SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.NodeClick) or SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.UnitClick) then
		return
	end

	if SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.Drag) then
		SodacheMapUtil.instance:clearClickType()

		return
	end

	SodacheMapUtil.instance:clearClickType()
	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickScene)
end

function SodacheMapSceneView:_hasButtonChange(hasBtn)
	if self._hasBtn == hasBtn then
		return
	end

	self._hasBtn = hasBtn

	self:doCameraSizeTween()
end

function SodacheMapSceneView:_onFocusEventChange(isFocusEvent)
	self._isFocusEvent = isFocusEvent

	self:doCameraSizeTween()
end

function SodacheMapSceneView:doCameraSizeTween()
	if self._hasBtn or self._isFocusEvent then
		if not SodacheEnum.DungeonMapCameraSize2 then
			local toCameraSize = SodacheEnum.DungeonMapCameraSize

			if toCameraSize == self._toCameraSize then
				return
			end

			self._toCameraSize = toCameraSize

			if self._tweenCameraSizeId then
				ZProj.TweenHelper.KillById(self._tweenCameraSizeId)
			end

			self._tweenCameraSizeId = ZProj.TweenHelper.DOTweenFloat(self._curCameraSize, toCameraSize, 0.5, self._onFrameSetCameraSize, self._onTweenCameraSizeComplete, self)
		end
	end
end

function SodacheMapSceneView:_onFrameSetCameraSize(value)
	self._curCameraSize = value

	self:_onScreenResize()
	self:_initScene()
	self:directSetScenePos(self._scenePos)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnMapSceneSizeChange)
end

function SodacheMapSceneView:_onTweenCameraSizeComplete()
	self._tweenCameraSizeId = nil
end

function SodacheMapSceneView:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	if self._hasBtn then
		return
	end

	local pos = self:getDragWorldPos(pointerEventData)
	local deltaPos = pos - self._dragBeginPos

	self._dragBeginPos = pos

	self._tempVector:Set(self._scenePos.x + deltaPos.x, self._scenePos.y + deltaPos.y)
	SodacheMapUtil.instance:setClickType(SodacheEnum.MapBtnClickType.Drag)
	self:directSetScenePos(self._tempVector)
end

function SodacheMapSceneView:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function SodacheMapSceneView:directSetScenePos(targetPos)
	local x, y = self:getTargetPos(targetPos)

	self._scenePos.x = x
	self._scenePos.y = y

	if not self._mapTrans or gohelper.isNil(self._mapTrans) then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnMapSceneDrag, targetPos)
	transformhelper.setLocalPos(self._mapTrans, self._scenePos.x, self._scenePos.y, 0)
end

function SodacheMapSceneView:getTargetPos(targetPos)
	local x, y = targetPos.x, targetPos.y

	if not self._mapMinX or not self._mapMinY then
		return x, y
	end

	if x < self._mapMinX then
		x = self._mapMinX
	elseif x > self._mapMaxX then
		x = self._mapMaxX
	end

	if y < self._mapMinY then
		y = self._mapMinY
	elseif y > self._mapMaxY then
		y = self._mapMaxY
	end

	return x, y
end

function SodacheMapSceneView:onClose()
	self:killAllTween()
	gohelper.destroy(self._sceneRoot)
end

function SodacheMapSceneView:onDestroyView()
	self:killAllTween()
	gohelper.destroy(self._sceneRoot)
end

return SodacheMapSceneView
