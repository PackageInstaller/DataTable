-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaLevelScene.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelScene", package.seeall)

local TianShiNaNaLevelScene = class("TianShiNaNaLevelScene", TianShiNaNaBaseSceneView)

function TianShiNaNaLevelScene:onInitView()
	return
end

function TianShiNaNaLevelScene:getScenePath()
	return TianShiNaNaModel.instance.mapCo.path
end

function TianShiNaNaLevelScene:beforeLoadScene()
	self._sceneTrans = self._sceneRoot.transform
	self._nodeContainer = gohelper.create3d(self._sceneRoot, "Node")
	self._unitContainer = gohelper.create3d(self._sceneRoot, "Unit")

	transformhelper.setLocalPos(self._nodeContainer.transform, 0, 0, 1)
	self:_initNodeAndUnit()
end

function TianShiNaNaLevelScene:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, self._resetScene, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.DragScene, self._onDragScene, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.CheckMapCollapse, self._checkMapCollapse, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.PlayerMove, self._onPlayerMove, self)
end

function TianShiNaNaLevelScene:removeEvents()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, self._resetScene, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.DragScene, self._onDragScene, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.CheckMapCollapse, self._checkMapCollapse, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.PlayerMove, self._onPlayerMove, self)
end

function TianShiNaNaLevelScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7 * scale
end

function TianShiNaNaLevelScene:onSceneLoaded(sceneGo)
	self._sceneGo = sceneGo

	self:calcSceneBoard()
	self:autoFocusPlayer()
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.LoadLevelFinish, sceneGo)
end

function TianShiNaNaLevelScene:_onScreenResize()
	if self._sceneGo then
		self:calcSceneBoard()
	end
end

function TianShiNaNaLevelScene:calcSceneBoard()
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

	self._mapMinX = posTL.x - (self._mapSize.x / 2 - self._viewWidth) - center.x
	self._mapMaxX = posTL.x + self._mapSize.x / 2 - center.x
	self._mapMinY = posTL.y - self._mapSize.y / 2 + cameraOffsetY - center.y
	self._mapMaxY = posTL.y + (self._mapSize.y / 2 - self._viewHeight) + cameraOffsetY - center.y
end

function TianShiNaNaLevelScene:autoFocusPlayer()
	local heroPos = TianShiNaNaModel.instance:getHeroMo()
	local worldPos = -TianShiNaNaHelper.nodeToV3(heroPos)

	worldPos.y = worldPos.y + 5.8
	worldPos.z = 0

	self:setScenePosSafety(worldPos)
end

local zeroPos = Vector3()

function TianShiNaNaLevelScene:_onDragScene(pointerEventData)
	if not self._targetPos then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local prePos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position - pointerEventData.delta, mainCamera, zeroPos)
	local nowPos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, zeroPos)
	local deltaWorldPos = nowPos - prePos

	deltaWorldPos.z = 0

	self:setScenePosSafety(self._targetPos:Add(deltaWorldPos))
end

function TianShiNaNaLevelScene:_onPlayerMove(localPos)
	local uPos = -localPos

	uPos.y = uPos.y + 5.8
	uPos.z = 0

	self:setScenePosSafety(uPos)
end

function TianShiNaNaLevelScene:setScenePosSafety(targetPos)
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
	TianShiNaNaModel.instance.nowScenePos = targetPos
end

function TianShiNaNaLevelScene:_initNodeAndUnit()
	TianShiNaNaEntityMgr.instance:clear()

	self._mapCo = TianShiNaNaModel.instance.mapCo

	self:_initNode()

	for k, unitMo in pairs(TianShiNaNaModel.instance.unitMos) do
		TianShiNaNaEntityMgr.instance:addEntity(unitMo, self._unitContainer)
	end
end

function TianShiNaNaLevelScene:_initNode()
	for x, dict in pairs(self._mapCo.nodesDict) do
		for y, nodeCo in pairs(dict) do
			if not nodeCo:isCollapse() then
				TianShiNaNaEntityMgr.instance:addNode(nodeCo, self._nodeContainer)
			else
				TianShiNaNaEntityMgr.instance:removeNode(nodeCo)
			end
		end
	end
end

function TianShiNaNaLevelScene:_checkMapCollapse()
	for id, unitMo in pairs(TianShiNaNaModel.instance.unitMos) do
		local nodeCo = TianShiNaNaModel.instance.mapCo:getNodeCo(unitMo.x, unitMo.y)

		if not nodeCo or nodeCo:isCollapse() then
			TianShiNaNaModel.instance:removeUnit(id)
		end
	end

	self:_initNode()
end

function TianShiNaNaLevelScene:_resetScene()
	for k, unitMo in pairs(TianShiNaNaModel.instance.unitMos) do
		TianShiNaNaEntityMgr.instance:addEntity(unitMo, self._unitContainer)
	end

	self:_initNode()
end

function TianShiNaNaLevelScene:onDestroyView()
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ExitLevel)
	TianShiNaNaEntityMgr.instance:clear()
	TianShiNaNaLevelScene.super.onDestroyView(self)
end

return TianShiNaNaLevelScene
