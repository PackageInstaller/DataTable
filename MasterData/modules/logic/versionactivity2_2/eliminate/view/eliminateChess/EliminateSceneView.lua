-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateSceneView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateSceneView", package.seeall)

local EliminateSceneView = class("EliminateSceneView", BaseView)

function EliminateSceneView:onOpen()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	transformhelper.setLocalPos(sceneRoot.transform, 0, 0, 0)

	self._sceneRoot = UnityEngine.GameObject.New(self.__cname)

	self:beforeLoadScene()
	gohelper.addChild(sceneRoot, self._sceneRoot)
	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)

	self._loader1 = PrefabInstantiate.Create(self._eliminateSceneGo)

	self._loader1:startLoad(self:getEliminateScenePath(), self._onEliminateSceneLoadEnd, self)

	self._loader2 = PrefabInstantiate.Create(self._teamChessGo)

	self._loader2:startLoad(self:getTeamChessScenePath(), self._onTeamChessSceneLoadEnd, self)
end

function EliminateSceneView:beforeLoadScene()
	self._sceneTrans = self._sceneRoot.transform
	self._unitContainer = gohelper.create3d(self._sceneRoot, "Unit")
	self._unitPosition = self._unitContainer.transform.position
	self._unitEffectContainer = gohelper.create3d(self._sceneRoot, "UnitEffect")

	TeamChessEffectPool.setPoolContainerGO(self._unitEffectContainer)
	self:_initCanvas()
	transformhelper.setLocalPos(self._unitContainer.transform, 0, 0, 0)

	self._eliminateSceneGo = gohelper.create3d(self._sceneRoot, "EliminateScene")
	self._teamChessGo = gohelper.create3d(self._sceneRoot, "TeamChessScene")

	self:updateSceneState()
end

function EliminateSceneView:setGoPosZ(go, posZ)
	local x, y, _ = transformhelper.getPos(go.transform)

	transformhelper.setPos(go.transform, x, y, posZ)
end

function EliminateSceneView:getTeamChessScenePath()
	local config = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

	return config.chessScene
end

function EliminateSceneView:getEliminateScenePath()
	local config = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

	return config.eliminateScene
end

function EliminateSceneView:_onEliminateSceneLoadEnd()
	local go = self._loader1:getInstGO()

	transformhelper.setLocalPos(go.transform, 0, 0.8, 0)
	self:setGoPosZ(go, 1)
end

function EliminateSceneView:_onTeamChessSceneLoadEnd()
	local go = self._loader2:getInstGO()

	transformhelper.setLocalPos(go.transform, 0, 0.8, 0)

	local x, y, z = transformhelper.getPos(go.transform)

	transformhelper.setPos(go.transform, x, y, 1)
end

function EliminateSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local cameraTr = CameraMgr.instance:getMainCameraTrs()
	local scale = GameUtil.getAdapterScale(true)

	transformhelper.setLocalRotation(cameraTr, 0, 0, 0)
	transformhelper.setLocalPos(cameraTr, 0, 0, 0)

	camera.orthographic = true
	camera.orthographicSize = 5 * scale
	camera.nearClipPlane = 0.3
	camera.farClipPlane = 1500
end

function EliminateSceneView:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)
end

function EliminateSceneView:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemBeginDrag, self.soliderItemDragBegin, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDrag, self.soliderItemDrag, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragEnd, self.soliderItemDragEnd, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.RefreshStronghold3DChess, self.refreshStronghold3DChess, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.RemoveStronghold3DChess, self.removeStronghold3DChess, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.HideAllStronghold3DChess, self.hideAllStronghold3DChess, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.ShowChessEffect, self.showEffect, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, self.updateViewState, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, self.updateSceneState, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessViewWatchView, self.updateTeamChessViewWatchState, self)
end

function EliminateSceneView:removeEvents()
	return
end

function EliminateSceneView:updateSceneState()
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isTeamChess = roundType == EliminateEnum.RoundType.TeamChess
	local isMatch3Chess = roundType == EliminateEnum.RoundType.Match3Chess

	if self._eliminateSceneGo then
		gohelper.setActive(self._eliminateSceneGo, isMatch3Chess)
	end

	if self._teamChessGo then
		gohelper.setActive(self._teamChessGo, isTeamChess)
	end

	if isMatch3Chess then
		self:updateViewState()
	end
end

local tempV2 = Vector2.zero

function EliminateSceneView:soliderItemDragBegin(soliderId, x, y)
	local entity = TeamChessUnitEntityMgr.instance:getEmptyEntity(self._unitContainer, soliderId)

	tempV2.x, tempV2.y = x, y

	entity:setScreenPoint(tempV2)
	entity:setUnitParentPosition(self._unitPosition)
	entity:updateByScreenPos()
	entity:setActive(true)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemBeginModelUpdated, soliderId, x, y)
end

function EliminateSceneView:soliderItemDrag(soliderId, uid, strongHoldId, x, y)
	local entity = TeamChessUnitEntityMgr.instance:getEmptyEntity(self._unitContainer, soliderId)

	tempV2.x, tempV2.y = x, y

	entity:setScreenPoint(tempV2)
	entity:setUnitParentPosition(self._unitPosition)
	entity:updateByScreenPos()
	entity:setActive(true)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragModelUpdated, soliderId, uid, strongHoldId, x, y)
end

function EliminateSceneView:soliderItemDragEnd(soliderId, uid, strongHoldId, x, y)
	local entity = TeamChessUnitEntityMgr.instance:getEmptyEntity(self._unitContainer, soliderId)

	entity:setActive(false)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEndModelUpdated, soliderId, uid, strongHoldId, x, y)
end

function EliminateSceneView:refreshStronghold3DChess(data, strongholdId, pos, itemTr, playOutAndIn)
	if data == nil then
		return
	end

	if self.teamChessUnitMoList == nil then
		self.teamChessUnitMoList = {}
		self.teamChessUnitItem = {}
	end

	local uid = data.uid
	local mo = self.teamChessUnitMoList[uid]
	local entity = TeamChessUnitEntityMgr.instance:getEntity(uid)

	if mo ~= nil then
		mo:update(data.uid, data.id, strongholdId, pos, data.teamType)
	else
		mo = TeamChessUnitMO.New()

		mo:init(data.uid, data.id, strongholdId, pos, data.teamType)

		entity = TeamChessUnitEntityMgr.instance:addEntity(mo, self._unitContainer)
	end

	if canLogNormal then
		logNormal("EliminateSceneView==>refreshStronghold3DChess--1", data.uid)
	end

	if entity ~= nil then
		entity:refreshTransform(itemTr, self._unitPosition)
		entity:setCanClick(true)
		entity:setCanDrag(true)
		entity:setActive(true)
		entity:refreshMeshOrder()
	end

	self.teamChessUnitMoList[data.uid] = mo
end

function EliminateSceneView:removeStronghold3DChess(uid)
	if self.teamChessUnitMoList == nil then
		return
	end

	self.teamChessUnitMoList[uid] = nil

	TeamChessUnitEntityMgr.instance:removeEntity(uid)
end

function EliminateSceneView:hideAllStronghold3DChess()
	TeamChessUnitEntityMgr.instance:setAllEntityActive(false)
end

function EliminateSceneView:updateViewState()
	local roundType = EliminateLevelModel.instance:getCurRoundType()

	TeamChessUnitEntityMgr.instance:setAllEntityActiveAndPlayAni(roundType == EliminateEnum.RoundType.TeamChess)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(roundType == EliminateEnum.RoundType.TeamChess)
	TeamChessUnitEntityMgr.instance:setAllEmptyEntityActive(false)
end

function EliminateSceneView:updateTeamChessViewWatchState(state)
	if state then
		TeamChessUnitEntityMgr.instance:cacheAllEntityShowMode()
		TeamChessUnitEntityMgr.instance:setAllEntityNormal()
	else
		TeamChessUnitEntityMgr.instance:restoreEntityShowMode()
	end

	TeamChessUnitEntityMgr.instance:setAllEntityActiveAndPlayAni(state)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(state)

	if self._eliminateSceneGo then
		gohelper.setActive(self._eliminateSceneGo, not state)
	end

	if self._teamChessGo then
		gohelper.setActive(self._teamChessGo, state)
	end
end

function EliminateSceneView:onOpenFinish()
	if self._sceneGo then
		self:calcSceneBoard()
	end
end

function EliminateSceneView:_onScreenResize()
	if self._sceneGo then
		self:calcSceneBoard()
	end

	self:calCanvasWidthAndHeight()
end

function EliminateSceneView:calcSceneBoard()
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

	self._mapSize = box.size

	local canvasGo
	local scale = GameUtil.getAdapterScale()
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

	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 5 * scale
end

function EliminateSceneView:calCanvasWidthAndHeight()
	if self._sceneCanvasGo == nil then
		return
	end

	local popupTop = gohelper.find("POPUP_TOP")
	local uiRootTr = popupTop.transform
	local width = recthelper.getWidth(uiRootTr)
	local height = recthelper.getHeight(uiRootTr)

	recthelper.setSize(self._sceneCanvasGo.transform, width, height)
	recthelper.setSize(self._sceneTipCanvasGo.transform, width, height)

	local mainView = gohelper.findChild(self._sceneCanvasGo, "#go_cameraMain")

	if mainView ~= nil then
		recthelper.setSize(mainView.transform, width, height)
	end
end

function EliminateSceneView:_initCanvas()
	local path = self.viewContainer:getSetting().otherRes[4]

	self._sceneCanvasGo = self:getResInst(path, self._sceneRoot)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	self._sceneCanvas.sortingOrder = -1
	self._sceneTipCanvasGo = gohelper.clone(self._sceneCanvasGo, self._sceneRoot, "SceneTipCanvas")
	self._sceneTipCanvas = self._sceneTipCanvasGo:GetComponent("Canvas")
	self._sceneTipCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	self._sceneTipCanvas.sortingOrder = 30

	self.viewContainer:setTeamChessViewParent(self._sceneCanvasGo, self._sceneCanvas)
	self.viewContainer:setTeamChessTipViewParent(self._sceneTipCanvasGo, self._sceneTipCanvas)
	transformhelper.setPosXY(self._sceneCanvasGo.transform, 0, 0.8798389)
	transformhelper.setPosXY(self._sceneTipCanvasGo.transform, 0, 0.8798389)
end

function EliminateSceneView:showEffect(effectType, posX, posY, posZ, scaleX, scaleY, scaleZ, time)
	scaleX = scaleX or 1
	scaleY = scaleY or 1
	scaleZ = scaleZ or 1

	local effect = TeamChessEffectPool.getEffect(effectType, self._onEffectLoadEnd, self)

	effect:setWorldPos(posX, posY, posZ)
	effect:setWorldScale(scaleX, scaleY, scaleZ)
	effect:play(time)
end

function EliminateSceneView:onDestroyView()
	if self.teamChessUnitMoList then
		tabletool.clear(self.teamChessUnitMoList)

		self.teamChessUnitMoList = nil
	end

	if self._eliminateSceneGo then
		self._eliminateSceneGo = nil
	end

	if self._teamChessGo then
		self._teamChessGo = nil
	end

	if self._sceneTipCanvasGo then
		self._sceneTipCanvas = nil
		self._sceneTipCanvasGo = nil
	end

	if self._sceneCanvasGo then
		self._sceneCanvas = nil
		self._sceneCanvasGo = nil
	end

	self._unitContainer = nil
	self._unitEffectContainer = nil

	if self._loader1 then
		self._loader1:dispose()

		self._loader1 = nil
	end

	if self._loader2 then
		self._loader2:dispose()

		self._loader2 = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return EliminateSceneView
