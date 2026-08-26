-- chunkname: @modules/logic/weekwalk/view/WeekWalkMap.lua

module("modules.logic.weekwalk.view.WeekWalkMap", package.seeall)

local WeekWalkMap = class("WeekWalkMap", BaseView)

function WeekWalkMap:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkMap:addEvents()
	return
end

function WeekWalkMap:removeEvents()
	return
end

function WeekWalkMap:_editableInitView()
	self._elementList = self:getUserDataTb_()
	self._tempVector = Vector3()
	self._infoNeedUpdate = WeekWalkModel.instance:infoNeedUpdate()

	self:_initMap()
	self:_initClick()
end

function WeekWalkMap:_initClick()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self._click:AddClickUpListener(self._clickUp, self)
end

function WeekWalkMap:setElementDown(item)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkDialogView) or ViewMgr.instance:isOpen(ViewName.WeekWalkTarotView) then
		return
	end

	self._elementMouseDown = item
end

function WeekWalkMap:_clickUp()
	local element = self._elementMouseDown

	self._elementMouseDown = nil

	if element and element:isValid() then
		element:onClick()
	end
end

function WeekWalkMap:setScenePosSafety(targetPos, tween)
	if not self._sceneTrans then
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

	if tween then
		ZProj.TweenHelper.DOLocalMove(self._sceneTrans, targetPos.x, targetPos.y, 0, 0.26)
	else
		self._sceneTrans.localPosition = targetPos
	end
end

function WeekWalkMap:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	transformhelper.setLocalRotation(camera.transform, 0, 0, 0)

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = WeekWalkEnum.orthographicSize * scale
end

function WeekWalkMap:_initMap()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("WeekWalkMap")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function WeekWalkMap:onUpdateParam()
	return
end

function WeekWalkMap:_showMap()
	local curMap = WeekWalkConfig.instance:getMapConfig(self._mapId)

	self:_changeMap(curMap)
end

function WeekWalkMap:_changeMap(curMap)
	if not curMap or self._mapCfg == curMap then
		return
	end

	if not self._oldMapLoader then
		self._oldMapLoader = self._mapLoader
		self._oldSceneGo = self._sceneGo
		self._oldSceneTrans = self._sceneTrans
	elseif self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self._mapCfg = curMap

	local mapInfo = WeekWalkModel.instance:getOldOrNewCurMapInfo()
	local sceneConfig = lua_weekwalk_scene.configDict[mapInfo.sceneId]
	local url = sceneConfig.map

	self._mapLoader = MultiAbLoader.New()

	self._mapLoader:addPath(url)

	self._canvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	self._interactiveItemUrl = "ui/viewres/weekwalk/weekwalkmapinteractiveitem.prefab"

	self._mapLoader:addPath(self._canvasUrl)
	self._mapLoader:addPath(self._interactiveItemUrl)

	if not WeekWalkModel.isShallowMap(mapInfo.id) then
		self._smokeUrl = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_smoke01.prefab"

		self._mapLoader:addPath(self._smokeUrl)
	end

	self._mapLoader:startLoad(function(multiAbLoader)
		self:disposeOldMap()

		local assetItem = self._mapLoader:getAssetItem(url)
		local mainPrefab = assetItem:GetResource(url)

		self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, tostring(curMap.id))

		gohelper.setActive(self._sceneGo, true)

		self._sceneTrans = self._sceneGo.transform
		self._backgroundGo = gohelper.findChild(self._sceneGo, "root/BackGround")
		self._diffuseGo = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse")
		self._elementRoot = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(self._sceneGo, self._elementRoot)

		if self._smokeUrl then
			assetItem = self._mapLoader:getAssetItem(self._smokeUrl)
			mainPrefab = assetItem:GetResource(self._smokeUrl)
			self._smokeGo = gohelper.clone(mainPrefab, self._sceneGo)

			local childGo = gohelper.findChild(self._smokeGo, "smoke01/1")
			local renderer = childGo:GetComponent(typeof(UnityEngine.Renderer))

			self._smokeMaskMat = renderer.sharedMaterial

			self:_updateSmokeMask()
			transformhelper.setLocalPos(self._smokeGo.transform, 0, 0, 0)
		end

		self._anim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		self:_initScene()
		self:_initCanvas()
		self:_onPlayEnterAnim()
	end)
end

function WeekWalkMap:_playEnterAnim()
	self._isPlayAnim = true

	self:_onPlayEnterAnim()
end

function WeekWalkMap:_onPlayEnterAnim()
	if self._anim then
		self._anim.enabled = self._isPlayAnim

		local bg_static = gohelper.findChild(self._backgroundGo, "bg_static")

		if bg_static then
			gohelper.setActive(bg_static, not self._isPlayAnim)
		end

		if self._isPlayAnim and not self._infoNeedUpdate then
			self:_initElements()
		end
	end
end

function WeekWalkMap:_playBgm(bgmId)
	bgmId = tonumber(bgmId)

	if not bgmId or bgmId <= 0 or self._bgmId then
		return
	end

	self._bgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.WeekWalk, self._bgmId, AudioEnum.WeekWalk.stop_sleepwalkingaudio)
end

function WeekWalkMap:_stopBgm()
	if self._bgmId then
		self._bgmId = nil

		AudioBgmManager.instance:stopAndClear(AudioBgmEnum.Layer.WeekWalk)
	end
end

function WeekWalkMap:_initCanvas()
	local assetItem = self._mapLoader:getAssetItem(self._canvasUrl)
	local mainPrefab = assetItem:GetResource(self._canvasUrl)

	self._sceneCanvasGo = gohelper.clone(mainPrefab, self._sceneGo)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	assetItem = self._mapLoader:getAssetItem(self._interactiveItemUrl)
	self._itemPrefab = assetItem:GetResource(self._interactiveItemUrl)
end

function WeekWalkMap:getInteractiveItem()
	self._uiGo = gohelper.clone(self._itemPrefab, self._sceneCanvasGo)
	self._interactiveItem = MonoHelper.addLuaComOnceToGo(self._uiGo, WeekWalkMapInteractiveItem)

	gohelper.setActive(self._uiGo, false)

	return self._interactiveItem
end

function WeekWalkMap:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local posTL = worldcorners[1]
	local posBR = worldcorners[3]

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
	self._mapMaxX = posTL.x
	self._mapMinY = posTL.y
	self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight)

	if self._oldScenePos then
		self._sceneTrans.localPosition = self._oldScenePos
	end

	self._oldScenePos = nil
end

function WeekWalkMap:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function WeekWalkMap:disposeOldMap()
	self._oldScenePos = self._sceneTrans and self._sceneTrans.localPosition or nil

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end

	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end

	self:_clearElements()
	self:_stopBgm()
end

function WeekWalkMap:_clearElements()
	for k, v in pairs(self._elementList) do
		v:dispose()
	end

	self._elementList = self:getUserDataTb_()
end

function WeekWalkMap:_initElements()
	self:_showElements()
	self:_openBattleElement()
end

function WeekWalkMap:_openBattleElement()
	local id = WeekWalkModel.instance:getBattleElementId()

	if not id then
		return
	end

	WeekWalkModel.instance:setBattleElementId(nil)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	local elementInfo = elementComp._info
	local type = elementInfo:getType()

	if type == WeekWalkEnum.ElementType.Battle then
		return
	end

	self:_OnClickElement(elementComp)
end

function WeekWalkMap:_showElements()
	if WeekWalkView._canShowFinishAnim(self._mapId) then
		return
	end

	local elementsList = WeekWalkModel.instance:getOldOrNewElementInfos(self._mapId)
	local resStat = {}

	for i, v in ipairs(elementsList) do
		local resName = v.config.res

		if not string.nilorempty(resName) then
			if not resStat[resName] then
				local t = {}

				if v:isAvailable() or self._elementList[v.elementId] then
					table.insert(t, v)
				end

				resStat[resName] = t
			end
		end
	end

	local addList = {}

	for i = #elementsList, 1, -1 do
		local info = elementsList[i]
		local resName = info.config.res
		local statList = resStat[resName]

		if statList then
			if not #statList then
				local statValue = 0

				if not info:isAvailable() then
					self:_removeElement(info, statValue <= 1)
				else
					table.insert(addList, info)
				end
			end
		end
	end

	for i = #addList, 1, -1 do
		local info = addList[i]
		local resName = info.config.res
		local statList = resStat[resName]

		if statList then
			if not #statList then
				local statValue = 0

				self:_addElement(info, statValue <= 1)
			end
		end
	end
end

function WeekWalkMap:_addElement(elementInfo, fadeIn)
	if elementInfo:getType() == WeekWalkEnum.ElementType.General and elementInfo.config.generalType == WeekWalkEnum.GeneralType.Audio then
		local audioId = tonumber(elementInfo.config.param)

		AudioMgr.instance:trigger(audioId)
		WeekwalkRpc.instance:sendWeekwalkGeneralRequest(elementInfo.elementId)

		return
	end

	local elementComp = self._elementList[elementInfo.elementId]

	if elementComp then
		elementComp:updateInfo(elementInfo)

		return
	end

	local go = UnityEngine.GameObject.New(tostring(elementInfo.elementId))

	gohelper.addChild(self._elementRoot, go)

	elementComp = MonoHelper.addLuaComOnceToGo(go, WeekWalkMapElement, {
		elementInfo,
		self
	})
	self._elementList[elementInfo.elementId] = elementComp

	local resName = elementComp:getResName()

	if string.nilorempty(resName) then
		return
	end

	local resGo = gohelper.findChild(self._diffuseGo, resName)
	local itemGo

	if not resGo then
		resGo = gohelper.findChild(self._backgroundGo, resName)
		itemGo = resGo
	end

	if not resGo then
		logError(string.format("元件id: %s no resGo:%s", elementInfo.elementId, resName))

		return
	end

	itemGo = itemGo or gohelper.clone(resGo, go, resName)

	gohelper.setLayer(itemGo, UnityLayer.Scene, true)
	elementComp:setItemGo(itemGo, fadeIn)

	if elementInfo.elementId == 10112 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShowElement10112)
	end
end

function WeekWalkMap:_removeElement(elementInfo, fadeOut)
	local id = elementInfo.elementId
	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	self._elementList[id] = nil

	elementComp:updateInfo(elementInfo)
	elementComp:disappear(fadeOut)
end

function WeekWalkMap:onOpen()
	self._mapId = WeekWalkModel.instance:getCurMapId()
	self._smokeMaskList = {}
	self._smokeMaskOffset = Vector4()

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self._onGamepadKeyDown, self)
	end

	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnChangeMap, self._OnChangeMap, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnClickElement, self._OnClickElement, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.GuideClickElement, self._OnGuideClickElement, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnDialogReply, self._OnDialogReply, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnAddSmokeMask, self._onAddSmokeMask, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnRemoveSmokeMask, self._onRemoveSmokeMask, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, self._onWeekwalkInfoUpdate, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, self._onWeekwalkResetLayer, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnShowFinishAnimDone, self._onShowFinishAnimDone, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	MainCameraMgr.instance:addView(ViewName.WeekWalkView, self._initCamera, nil, self)
	self:_showMap()
end

function WeekWalkMap:_onGamepadKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
		local maxIndex = allRaycastHit.Length - 1

		for i = 0, maxIndex do
			local hitInfo = allRaycastHit[i]
			local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, WeekWalkMapElement)

			if comp then
				comp:onDown()

				return
			end
		end
	end
end

function WeekWalkMap:_onSceneClose()
	self:_stopBgm()
end

function WeekWalkMap:_onOpenView(viewName)
	self._elementMouseDown = nil
end

function WeekWalkMap:_onShowFinishAnimDone()
	self:_showElements()
end

function WeekWalkMap:_onWeekwalkResetLayer()
	self:_clearElements()
	self:_showElements()

	local animator = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("m_s09_rgmy_in", 0, 0)
end

function WeekWalkMap:_onWeekwalkInfoUpdate()
	self:_showElements()
end

function WeekWalkMap:_onAddSmokeMask(id, offsetPos)
	local param = string.split(offsetPos, "#")
	local x = tonumber(param[1])
	local y = tonumber(param[2])

	self._smokeMaskList[id] = {
		x,
		y
	}

	self:_updateSmokeMask()
end

function WeekWalkMap:_onRemoveSmokeMask(id)
	self._smokeMaskList[id] = nil

	self:_updateSmokeMask()
end

function WeekWalkMap:_updateSmokeMask()
	if not self._smokeMaskMat then
		return
	end

	local index = 0

	for k, v in pairs(self._smokeMaskList) do
		index = index + 1
		self._smokeMaskOffset.x = v[1]
		self._smokeMaskOffset.y = v[2]

		self._smokeMaskMat:SetVector("_TransPos_" .. index, self._smokeMaskOffset)
	end

	for i = index + 1, 5 do
		self._smokeMaskOffset.x = 1000
		self._smokeMaskOffset.y = 1000

		self._smokeMaskMat:SetVector("_TransPos_" .. i, self._smokeMaskOffset)
	end
end

function WeekWalkMap:_OnDialogReply(id)
	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	self:_OnClickElement(elementComp)
end

function WeekWalkMap:_OnGuideClickElement(id)
	local elementId = tonumber(id)

	if not elementId then
		return
	end

	local elementComp = self._elementList[elementId]

	if not elementComp then
		return
	end

	self:_OnClickElement(elementComp)
end

function WeekWalkMap:_OnClickElement(mapElement)
	local elementGo = mapElement._go
	local x, y = transformhelper.getLocalPos(elementGo.transform)
	local config = mapElement._config
	local offsetPos = string.splitToNumber(config.offsetPos, "#")

	x = x + (offsetPos[1] or 0)
	y = y + (offsetPos[2] or 0)
	x = self._mapMaxX - x + self._viewWidth / 2
	y = self._mapMinY - y - self._viewHeight / 2 + 2

	self:_clickElement(mapElement)
end

function WeekWalkMap:_clickElement(mapElement)
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if mapInfo and mapInfo.isFinish > 0 then
		local cur, total = mapInfo:getCurStarInfo()

		if cur ~= total then
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_completelement)
			WeekWalkController.instance:openWeekWalkResetView()
		end

		return
	end

	local elementInfo = mapElement._info
	local id = elementInfo.elementId
	local type = elementInfo:getType()

	if type == WeekWalkEnum.ElementType.Battle then
		if WeekWalkModel.instance:getCurMapIsFinish() then
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_completelement)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		end

		WeekWalkDialogView.startBattle(id)
	elseif type == WeekWalkEnum.ElementType.Respawn then
		-- block empty
	elseif type == WeekWalkEnum.ElementType.Dialog then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		WeekWalkController.instance:openWeekWalkDialogView(mapElement)
	end
end

function WeekWalkMap:_OnChangeMap(mapCfg)
	if mapCfg == self._mapCfg then
		self:_setInitPos(true)

		return
	end

	self:_changeMap(mapCfg)
end

function WeekWalkMap:onClose()
	self:_stopBgm()
end

function WeekWalkMap:onDestroyView()
	gohelper.destroy(self._sceneRoot)
	self:disposeOldMap()

	if self._mapLoader then
		self._mapLoader:dispose()
	end

	self._click:RemoveClickUpListener()
end

return WeekWalkMap
