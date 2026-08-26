-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonSceneView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonSceneView", package.seeall)

local OdysseyDungeonSceneView = class("OdysseyDungeonSceneView", BaseView)

function OdysseyDungeonSceneView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)
	self._gomapName = gohelper.findChild(self.viewGO, "root/#go_mapName")
	self._gotransitionEffect = gohelper.findChild(self.viewGO, "#go_transitionEffect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonSceneView:addEvents()
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnFocusElement, self.onFocusElement, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnFocusMapSelectItem, self.onFocusMapSelectItem, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, self.onMapSelectItemEnter, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.JumpNeedOpenElement, self.onJumpNeedOpenElement, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.JumpToHeroPos, self.onJumpToHeroPos, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, self.refreshMyth, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)

	if self._drag then
		self._drag:AddDragBeginListener(self.onMapDragBegin, self)
		self._drag:AddDragEndListener(self.onMapDragEnd, self)
		self._drag:AddDragListener(self.onMapDrag, self)
	end
end

function OdysseyDungeonSceneView:removeEvents()
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnFocusElement, self.onFocusElement, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnFocusMapSelectItem, self.onFocusMapSelectItem, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, self.onMapSelectItemEnter, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.JumpNeedOpenElement, self.onJumpNeedOpenElement, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.JumpToHeroPos, self.onJumpToHeroPos, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, self.refreshMyth, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end
end

function OdysseyDungeonSceneView:_editableInitView()
	self.tempScenePos = Vector3()
	self.curScenePos = Vector3()

	self:initMapRootNode()

	self.elementRootUrl = "ui/viewres/sp01/odyssey/odysseydungeonelementview.prefab"
	self.sceneCanvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	self.mapSelectRootUrl = "ui/viewres/sp01/odyssey/odysseydungeonmapselectview.prefab"
	self._animMapName = self._gomapName:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._gomapName, false)
end

function OdysseyDungeonSceneView:initMapRootNode()
	self.sceneRoot = UnityEngine.GameObject.New(OdysseyEnum.SceneRootName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self.sceneRoot.transform, 0, y, 0)

	local sceneRoot = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(sceneRoot, self.sceneRoot)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnCreateMapRootGoDone, self.sceneRoot)
end

function OdysseyDungeonSceneView:onUpdateParam()
	self:refreshMap()
end

function OdysseyDungeonSceneView:onOpen()
	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)

	self.lastMapId = 0
	self.canPlayTransitionEffect = true

	if OdysseyDungeonModel.instance:getLastElementFightParam() then
		self.canPlayTransitionEffect = false
	end

	self:refreshMap()
end

function OdysseyDungeonSceneView:initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = OdysseyEnum.DungeonMapCameraSize * scale
end

function OdysseyDungeonSceneView:refreshMapSelectView()
	local mapSelectCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MapSelectUrl)

	self.mapSelectUrl = mapSelectCo.value
	self.lastMapId = 0

	self:refreshMap()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClose(self.curMapId, "switch")
end

function OdysseyDungeonSceneView:onMapSelectItemEnter()
	self.lastMapId = 0

	self:refreshMap()

	local dungeonView = self.viewContainer:getDungeonView()

	if dungeonView then
		dungeonView:setChangeMapUIState(true)
	end
end

function OdysseyDungeonSceneView:onJumpNeedOpenElement(elementId)
	local elementInMapId = OdysseyDungeonModel.instance:getElemenetInMapId(elementId)

	if elementInMapId == 0 then
		return
	end

	self.isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if elementInMapId == self.curMapId and not self.isInMapSelectState then
		local elementConfig = OdysseyConfig.instance:getElementConfig(elementId)

		self:focusElementByCo(elementConfig)

		local sceneElementsView = self.viewContainer:getDungeonSceneElementsView()

		if sceneElementsView then
			sceneElementsView:setHeroItemPos(elementConfig)
			sceneElementsView:playShowOrHideHeroAnim(true, elementConfig.id)
		end

		OdysseyDungeonController.instance:openDungeonInteractView({
			config = elementConfig
		})
	else
		OdysseyDungeonModel.instance:setCurMapId(elementInMapId)
		OdysseyDungeonModel.instance:setIsMapSelect(false)
		self:onMapSelectItemEnter()

		local dungeonView = self.viewContainer:getDungeonView()

		if dungeonView then
			dungeonView:refreshUI()
		end
	end
end

function OdysseyDungeonSceneView:onJumpToHeroPos()
	local curHeroInElementId = OdysseyDungeonModel.instance:getCurInElementId()

	if curHeroInElementId > 0 then
		local elementInMapId = OdysseyDungeonModel.instance:getElemenetInMapId(curHeroInElementId)

		if self.curMapId == elementInMapId then
			local elementConfig = OdysseyConfig.instance:getElementConfig(curHeroInElementId)

			self:focusElementByCo(elementConfig)
			OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, curHeroInElementId, OdysseyEnum.ElementAnimName.Tips)
		else
			self.lastMapId = 0

			OdysseyDungeonModel.instance:setCurMapId(elementInMapId)
			self:refreshMap()
		end
	else
		self:setMapPos()
	end
end

function OdysseyDungeonSceneView:refreshMap(needTween)
	if self.canPlayTransitionEffect then
		gohelper.setActive(self._gotransitionEffect, false)
		gohelper.setActive(self._gotransitionEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_mist)
	end

	self.isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()
	self.needTween = needTween
	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	if self.curMapId == self.lastMapId then
		if not self.mapLoadedDone or not self.elementsRootGO or self.isInMapSelectState then
			return
		end

		self:setMapPos()
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnInitElements, self.elementsRootGO)
	else
		self.lastMapId = self.curMapId

		self:loadMap()
	end

	self:setCloseOverrideFunc()
end

function OdysseyDungeonSceneView:loadMap()
	self.curMapConfig = OdysseyConfig.instance:getDungeonMapConfig(self.curMapId)
	self.mapRes = OdysseyDungeonModel.instance:getMapRes(self.curMapId)
	self.mythCo = OdysseyDungeonModel.instance:getMythCoMyMapId(self.curMapId)

	if not self.isInMapSelectState and self.mythCo then
		self.mythRes = self.mythCo.unlockMap or nil
	end

	if self.mapLoadedDone then
		self.oldMapLoader = self.mapLoader
		self.oldSceneGo = self.sceneGo
		self.oldMythGo = self.mythGo
		self.oldLightGo = self.lightGO
		self.mapLoader = nil
	end

	if self.mapLoader then
		self.mapLoader:dispose()

		self.mapLoader = nil
	end

	self.mapLoadedDone = false
	self.mapLoader = MultiAbLoader.New()

	self:addLoadRes()
	self.mapLoader:startLoad(self.loadSceneFinish, self)
end

function OdysseyDungeonSceneView:addLoadRes()
	if self.isInMapSelectState then
		self.mapLoader:addPath(ResUrl.getDungeonMapRes(self.mapSelectUrl))
		self.mapLoader:addPath(self.mapSelectRootUrl)
	else
		self.mapLoader:addPath(ResUrl.getDungeonMapRes(self.mapRes))
		self.mapLoader:addPath(self.elementRootUrl)

		if self.mythRes then
			self.mapLoader:addPath(ResUrl.getDungeonMapRes(self.mythRes))
		end
	end

	self.mapLoader:addPath(OdysseyEnum.DungeonMapLightUrl)
	self.mapLoader:addPath(self.sceneCanvasUrl)
end

function OdysseyDungeonSceneView:loadSceneFinish()
	self.mapLoadedDone = true

	self:disposeOldMap()

	local assetUrl = self.isInMapSelectState and ResUrl.getDungeonMapRes(self.mapSelectUrl) or ResUrl.getDungeonMapRes(self.mapRes)
	local assetItem = self.mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self.sceneGo = gohelper.clone(mainPrefab, self.sceneRoot, self.curMapId)
	self.sceneTrans = self.sceneGo.transform

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnLoadSceneFinish, {
		mapSceneGo = self.sceneGo
	})
	OdysseyStatHelper.instance:initSceneStartTime()
	self:initScene()
	self:addMapLight()
	self:addMythRes()

	if not self.isInMapSelectState then
		self:initElements()
		self:setMapPos()
		self:refreshMyth()
	else
		self:initMapSelect()
	end

	if self.canPlayTransitionEffect then
		self:closeTransitionEffect()
		TaskDispatcher.runDelay(self.showSubTaskShowEffect, self, 1)
	else
		gohelper.setActive(self._gotransitionEffect, false)

		if not self.isInMapSelectState then
			TaskDispatcher.runDelay(self.popupRewardView, self, 1)
		end

		self:showSubTaskShowEffect()
	end

	self.canPlayTransitionEffect = true
end

function OdysseyDungeonSceneView:_onScreenResize()
	if self.sceneGo then
		self:initScene()
	end
end

function OdysseyDungeonSceneView:initScene()
	local sizeGo = gohelper.findChild(self.sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
	local boxScaleX, boxScaleY, boxScaleZ = transformhelper.getLocalScale(sizeGo.transform, 0, 0, 0)
	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()

	if uiCamera then
		if not uiCamera.orthographicSize then
			local uiCameraSize = 5
			local cameraSizeRate = OdysseyEnum.DungeonMapCameraSize / uiCameraSize
			local posTL = worldcorners[1] * scale * cameraSizeRate
			local posBR = worldcorners[3] * scale * cameraSizeRate

			self.viewWidth = math.abs(posBR.x - posTL.x)
			self.viewHeight = math.abs(posBR.y - posTL.y)
			self.mapMinX = posTL.x - (box.size.x * boxScaleX - self.viewWidth)
			self.mapMaxX = posTL.x
			self.mapMinY = posTL.y
			self.mapMaxY = posTL.y + (box.size.y * boxScaleY - self.viewHeight)
		end
	end
end

function OdysseyDungeonSceneView:setMapPos()
	local curHeroInElementId = OdysseyDungeonModel.instance:getCurInElementId()
	local curHeroInMapId = OdysseyDungeonModel.instance:getHeroInMapId()

	if curHeroInElementId > 0 and self.curMapId == curHeroInMapId then
		local elementConfig = OdysseyConfig.instance:getElementConfig(curHeroInElementId)
		local pos = string.splitToNumber(elementConfig.pos, "#")

		if not -(pos[1] * self.rootScale) then
			if not -(pos[2] * self.rootScale) then
				local elementMapPosY = 0

				self.tempScenePos:Set(-(pos[1] * self.rootScale), elementMapPosY, 0)
			end
		end
	else
		local pos = self.curMapConfig.initPos
		local posParam = string.splitToNumber(pos, "#")

		self.tempScenePos:Set(posParam[1], posParam[2], 0)
	end

	if self.needTween then
		self:tweenSetScenePos(self.tempScenePos)

		self.needTween = false
	else
		self:directSetScenePos(self.tempScenePos)
	end
end

function OdysseyDungeonSceneView:tweenSetScenePos(targetPos)
	self.tweenTargetPosX, self.tweenTargetPosY = self:getTargetPos(targetPos)
	self.tweenStartPosX, self.tweenStartPosY = self:getTargetPos(self.curScenePos)

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function OdysseyDungeonSceneView:tweenFrameCallback(weight)
	local curPosX = Mathf.Lerp(self.tweenStartPosX, self.tweenTargetPosX, weight)
	local curPosY = Mathf.Lerp(self.tweenStartPosY, self.tweenTargetPosY, weight)

	self.tempScenePos:Set(curPosX, curPosY, 0)
	self:directSetScenePos(self.tempScenePos)
end

function OdysseyDungeonSceneView:tweenFinishCallback()
	self.tempScenePos:Set(self.tweenTargetPosX, self.tweenTargetPosY, 0)
	self:directSetScenePos(self.tempScenePos)
end

function OdysseyDungeonSceneView:directSetScenePos(targetPos)
	local x, y = self:getTargetPos(targetPos)

	self.curScenePos:Set(x, y, 0)

	if not self.sceneTrans or gohelper.isNil(self.sceneTrans) then
		return
	end

	transformhelper.setLocalPos(self.sceneTrans, self.curScenePos.x, self.curScenePos.y, 0)

	if not self.isInMapSelectState then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnUpdateElementArrow)
	end
end

function OdysseyDungeonSceneView:getTargetPos(targetPos)
	local x, y = targetPos.x, targetPos.y

	if not self.mapMinX or not self.mapMaxX or not self.mapMinY or not self.mapMaxY then
		if self.curMapConfig then
			local pos = self.curMapConfig.initPos
			local posParam = string.splitToNumber(pos, "#")

			x = posParam[1] or 0
			y = posParam[2] or 0
		end
	else
		x = Mathf.Clamp(x, self.mapMinX, self.mapMaxX)
		y = Mathf.Clamp(y, self.mapMinY, self.mapMaxY)
	end

	return x, y
end

function OdysseyDungeonSceneView:addMapLight()
	local assetUrl = OdysseyEnum.DungeonMapLightUrl
	local assetItem = self.mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self.lightGO = gohelper.clone(mainPrefab, self.sceneGo)
end

function OdysseyDungeonSceneView:addMythRes()
	local mythUrl = self.mythRes and ResUrl.getDungeonMapRes(self.mythRes) or nil

	if mythUrl then
		local mythAssetItem = self.mapLoader:getAssetItem(mythUrl)
		local mythPrefab = mythAssetItem:GetResource(mythUrl)

		self.mythGo = gohelper.clone(mythPrefab, self.sceneGo, "myth" .. self.mythCo.id)

		local posParam = string.splitToNumber(self.mythCo.pos, "#")

		transformhelper.setLocalPos(self.mythGo.transform, posParam[1], posParam[2], posParam[3])
	end
end

function OdysseyDungeonSceneView:refreshMyth()
	if self.mythGo then
		local mythElementMo = self.mythCo and OdysseyDungeonModel.instance:getElementMo(self.mythCo.elementId) or nil

		gohelper.setActive(self.mythGo, mythElementMo)
	end
end

function OdysseyDungeonSceneView:initElements()
	local canvasAssetItem = self.mapLoader:getAssetItem(self.sceneCanvasUrl)
	local canvasPrefab = canvasAssetItem:GetResource(self.sceneCanvasUrl)

	self.elementCanvasGo = gohelper.clone(canvasPrefab, self.sceneGo, "OdysseyElementsCanvas")
	self.elementCanvasGo:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()

	local elementRootAssetItem = self.mapLoader:getAssetItem(self.elementRootUrl)
	local elementRootPrefab = elementRootAssetItem:GetResource(self.elementRootUrl)

	self.elementsRootGO = gohelper.clone(elementRootPrefab, self.elementCanvasGo, "elementsRoot")

	local rootGO = gohelper.findChild(self.elementsRootGO, "root")

	self.rootScale = transformhelper.getLocalScale(rootGO.transform)

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnInitElements, self.elementsRootGO)
end

function OdysseyDungeonSceneView:initMapSelect()
	local canvasAssetItem = self.mapLoader:getAssetItem(self.sceneCanvasUrl)
	local canvasPrefab = canvasAssetItem:GetResource(self.sceneCanvasUrl)

	self.mapSelectCanvasGo = gohelper.clone(canvasPrefab, self.sceneGo, "OdysseyMapSelectCanvas")
	self.mapSelectCanvasGo:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()

	local mapSelectRootAssetItem = self.mapLoader:getAssetItem(self.mapSelectRootUrl)
	local mapSelectRootPrefab = mapSelectRootAssetItem:GetResource(self.mapSelectRootUrl)

	self.mapSelectRootGO = gohelper.clone(mapSelectRootPrefab, self.mapSelectCanvasGo, "mapSelectRoot")

	local rootGO = gohelper.findChild(self.mapSelectRootGO, "root")

	self.rootScale = transformhelper.getLocalScale(rootGO.transform)

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnInitMapSelect, self.mapSelectRootGO)
end

function OdysseyDungeonSceneView:setWholeMapPos()
	local mapSelectPosCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MapSelectPos)
	local posParam = string.splitToNumber(mapSelectPosCo.value, "#")

	self.tempScenePos:Set(posParam[1], posParam[2], 0)
	self:directSetScenePos(self.tempScenePos)
end

function OdysseyDungeonSceneView:onMapDragBegin(param, pointerEventData)
	OdysseyDungeonModel.instance:setDraggingMapState(true)

	self.dragBeginPos = self:getDragWorldPos(pointerEventData)

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_drag)
end

function OdysseyDungeonSceneView:onMapDrag(param, pointerEventData)
	if not self.dragBeginPos then
		return
	end

	local dragPos = self:getDragWorldPos(pointerEventData)
	local posOffset = dragPos - self.dragBeginPos

	self.dragBeginPos = dragPos

	self.tempScenePos:Set(self.curScenePos.x + posOffset.x, self.curScenePos.y + posOffset.y)
	self:directSetScenePos(self.tempScenePos)
	OdysseyDungeonModel.instance:setDraggingMapState(true)
end

function OdysseyDungeonSceneView:onMapDragEnd(param, pointerEventData)
	self.dragBeginPos = nil

	OdysseyDungeonModel.instance:setDraggingMapState(false)
end

function OdysseyDungeonSceneView:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function OdysseyDungeonSceneView:onClickElement(elementComp)
	if elementComp and elementComp.config then
		self:focusElementByComp(elementComp)
	end
end

function OdysseyDungeonSceneView:focusElementByComp(elementComp)
	local elementPos = self.elementsRootGO.transform:InverseTransformPoint(elementComp.go.transform.position)

	if not -elementPos.x then
		if not -elementPos.y then
			local elementMapPosY = 0

			self.tempScenePos:Set(-elementPos.x, elementMapPosY, 0)
			self:tweenSetScenePos(self.tempScenePos)
		end
	end
end

function OdysseyDungeonSceneView:focusElementByCo(elementConfig)
	local pos = string.splitToNumber(elementConfig.pos, "#")

	if not -(pos[1] * self.rootScale) then
		if not -(pos[2] * self.rootScale) then
			local elementMapPosY = 0

			self.tempScenePos:Set(-(pos[1] * self.rootScale), elementMapPosY, 0)
			self:tweenSetScenePos(self.tempScenePos)
		end
	end
end

function OdysseyDungeonSceneView:onFocusElement(elementId, force)
	local sceneElementsView = self.viewContainer:getDungeonSceneElementsView()

	if not sceneElementsView then
		return
	end

	local elementComp = sceneElementsView:getElemenetComp(elementId)

	if elementComp and elementComp.config then
		self:focusElementByComp(elementComp)
	elseif force then
		local elementCo = OdysseyConfig.instance:getElementConfig(elementId)

		self:focusElementByCo(elementCo)
	end
end

function OdysseyDungeonSceneView:onFocusMapSelectItem(targetPos, needTween)
	if needTween then
		self:tweenSetScenePos(targetPos)
	else
		self:directSetScenePos(targetPos)
	end

	OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(false)
end

function OdysseyDungeonSceneView:closeTransitionEffect()
	TaskDispatcher.runDelay(self.hideTransitionEffect, self, 1.7)
end

function OdysseyDungeonSceneView:hideTransitionEffect()
	gohelper.setActive(self._gotransitionEffect, false)
	TaskDispatcher.cancelTask(self.hideMapName, self)

	local isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if not isInMapSelectState then
		gohelper.setActive(self._gomapName, true)
		self._animMapName:Play("open", 0, 0)
		TaskDispatcher.runDelay(self.hideMapName, self, 1)
	end

	self:popupRewardView()
	self:showJumpNeedShowElement()
end

function OdysseyDungeonSceneView:popupRewardView()
	OdysseyDungeonController.instance:popupRewardView()
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, true)
end

function OdysseyDungeonSceneView:hideMapName()
	self._animMapName:Play("close", 0, 0)
end

function OdysseyDungeonSceneView:showJumpNeedShowElement()
	local jumpNeedOpenElement = OdysseyDungeonModel.instance:getJumpNeedOpenElement()

	if jumpNeedOpenElement > 0 then
		local jumpNeedOpenElementCo = OdysseyConfig.instance:getElementConfig(jumpNeedOpenElement)

		if jumpNeedOpenElementCo and jumpNeedOpenElementCo.mapId == self.curMapId then
			OdysseyDungeonController.instance:openDungeonInteractView({
				config = jumpNeedOpenElementCo
			})
		end
	end
end

function OdysseyDungeonSceneView:showSubTaskShowEffect()
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlaySubTaskShowEffect)
end

function OdysseyDungeonSceneView:setCloseOverrideFunc()
	self.isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if self.isInMapSelectState then
		self.viewContainer:setOverrideCloseClick(self.backToLastMap, self)
	else
		self.viewContainer:setOverrideCloseClick(self.closeThis, self)
	end
end

function OdysseyDungeonSceneView:backToLastMap()
	self.canPlayTransitionEffect = false

	ViewMgr.instance:closeView(ViewName.OdysseyDungeonMapSelectInfoView)
	OdysseyDungeonModel.instance:setIsMapSelect(false)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnMapSelectItemEnter)
end

function OdysseyDungeonSceneView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function OdysseyDungeonSceneView:onClose()
	self:killTween()
	self:resetCamera()
	TaskDispatcher.cancelTask(self.hideTransitionEffect, self)
	TaskDispatcher.cancelTask(self.hideMapName, self)
	TaskDispatcher.cancelTask(self.popupRewardView, self)
	TaskDispatcher.cancelTask(self.showSubTaskShowEffect, self)
	OdysseyDungeonModel.instance:setDraggingMapState(false)
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClose(self.curMapId, "close")
end

function OdysseyDungeonSceneView:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function OdysseyDungeonSceneView:onDestroyView()
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnDisposeScene)
	gohelper.destroy(self.sceneRoot)
	self:disposeOldMap()

	self.sceneTrans = nil

	if self.sceneGo then
		gohelper.destroy(self.sceneGo)

		self.sceneGo = nil
	end

	if self.mapLoader then
		self.mapLoader:dispose()
	end
end

function OdysseyDungeonSceneView:disposeOldMap()
	if self.oldMapLoader then
		self.oldMapLoader:dispose()

		self.oldMapLoader = nil
	end

	if self.elementCanvasGo then
		gohelper.destroy(self.elementCanvasGo)

		self.elementCanvasGo = nil
	end

	if self.elementsRootGO then
		gohelper.destroy(self.elementsRootGO)

		self.elementsRootGO = nil
	end

	if self.mapSelectCanvasGo then
		gohelper.destroy(self.mapSelectCanvasGo)

		self.mapSelectCanvasGo = nil
	end

	if self.mapSelectRootGO then
		gohelper.destroy(self.mapSelectRootGO)

		self.mapSelectRootGO = nil
	end

	if self.oldMythGo then
		gohelper.destroy(self.oldMythGo)

		self.oldMythGo = nil
	end

	if self.oldLightGo then
		gohelper.destroy(self.oldLightGo)

		self.oldLightGo = nil
	end

	if self.oldSceneGo then
		gohelper.destroy(self.oldSceneGo)

		self.oldSceneGo = nil
	end

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnDisposeOldMap)
end

return OdysseyDungeonSceneView
