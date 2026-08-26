-- chunkname: @modules/logic/toughbattle/view/ToughBattleMapScene.lua

module("modules.logic.toughbattle.view.ToughBattleMapScene", package.seeall)

local ToughBattleMapScene = class("ToughBattleMapScene", BaseView)

function ToughBattleMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ToughBattleMapScene:addEvents()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.StageUpdate, self.loadMap, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.BeginPlayFightSucessAnim, self.playSuccAnim, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.GuideSetElementsActive, self._setElementsActive, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.GuideClickElement, self._guideClickElement, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.GuideFocusElement, self._guideFocusElement, self)
end

function ToughBattleMapScene:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, ToughBattleController.instance, ToughBattleEvent.StageUpdate, self.loadMap, self)
	self.removeEventCb(self, ToughBattleController.instance, ToughBattleEvent.BeginPlayFightSucessAnim, self.playSuccAnim, self)
	self.removeEventCb(self, ToughBattleController.instance, ToughBattleEvent.GuideSetElementsActive, self._setElementsActive, self)
	self.removeEventCb(self, ToughBattleController.instance, ToughBattleEvent.GuideClickElement, self._guideClickElement, self)
	self.removeEventCb(self, ToughBattleController.instance, ToughBattleEvent.GuideFocusElement, self._guideFocusElement, self)
end

function ToughBattleMapScene:_editableInitView()
	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()
	self._scenePos = Vector3()

	self:_initMapRootNode()
end

function ToughBattleMapScene:onOpen()
	self:loadMap()
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
end

function ToughBattleMapScene:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = ToughBattleEnum.DungeonMapCameraSize * scale

		self:_initScene()
	end
end

function ToughBattleMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = ToughBattleEnum.DungeonMapCameraSize * scale
end

function ToughBattleMapScene:loadMap()
	if self._mapLoader then
		self._oldMapLoader = self._mapLoader
	end

	local stage = self:getNowShowStage()

	if stage == 1 then
		if not ToughBattleEnum.MapId_stage1 then
			local mapId = ToughBattleEnum.MapId_stage2

			self._mapCfg = lua_chapter_map.configDict[mapId]
			self._mapLoader = MultiAbLoader.New()

			local allResPath = {}

			self:buildLoadRes(allResPath, self._mapCfg, stage)

			self._sceneUrl = allResPath[1]
			self._mapLightUrl = allResPath[2]
			self._mapEffectUrl = allResPath[3]

			self._mapLoader:addPath(self._sceneUrl)
			self._mapLoader:addPath(self._mapLightUrl)

			if self._mapEffectUrl then
				self._mapLoader:addPath(self._mapEffectUrl)
			end

			self._mapLoader:startLoad(self._loadSceneFinish, self)
		end
	end
end

function ToughBattleMapScene:buildLoadRes(allResPath, mapCfg, stage)
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	if stage == 2 then
		table.insert(allResPath, "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect3.prefab")
	end
end

function ToughBattleMapScene:_loadSceneFinish()
	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil

		gohelper.destroy(self._sceneGo)
	end

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	self:_initScene()
	self:_initSceneEffect()
	self:_addMapLight()
	self:_initElements()
	self:_setMapPos()
end

function ToughBattleMapScene:_initSceneEffect()
	if not self._mapEffectUrl then
		return
	end

	local assetItem = self._mapLoader:getAssetItem(self._mapEffectUrl)
	local mainPrefab = assetItem:GetResource(self._mapEffectUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
end

function ToughBattleMapScene:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local center = box.center
	local offsetX = center.x - self._mapSize.x / 2
	local offsetY = center.y + self._mapSize.y / 2
	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()

	if uiCamera then
		if not uiCamera.orthographicSize then
			local uiCameraSize = 5
			local cameraSizeRate = ToughBattleEnum.DungeonMapCameraSize / uiCameraSize
			local posTL = worldcorners[1] * scale * cameraSizeRate
			local posBR = worldcorners[3] * scale * cameraSizeRate

			self._viewWidth = math.abs(posBR.x - posTL.x)
			self._viewHeight = math.abs(posBR.y - posTL.y)
			self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth) - offsetX
			self._mapMaxX = posTL.x - offsetX
			self._mapMinY = posTL.y - offsetY
			self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight) - offsetY
		end
	end
end

function ToughBattleMapScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function ToughBattleMapScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
end

function ToughBattleMapScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	self._downElement = nil

	local pos = self:getDragWorldPos(pointerEventData)
	local deltaPos = pos - self._dragBeginPos

	self._dragBeginPos = pos

	self._tempVector:Set(self._scenePos.x + deltaPos.x, self._scenePos.y + deltaPos.y)
	self:directSetScenePos(self._tempVector)
end

function ToughBattleMapScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function ToughBattleMapScene:_setMapPos()
	if self.tempInitPosX then
		self._tempVector:Set(self.tempInitPosX, self.tempInitPosY, 0)

		self.tempInitPosX = nil
		self.tempInitPosY = nil
	else
		local pos = self._mapCfg.initPos
		local posParam = string.splitToNumber(pos, "#")

		self._tempVector:Set(posParam[1], posParam[2], 0)
	end

	if self.needTween then
		self:tweenSetScenePos(self._tempVector, self._oldScenePos)
	else
		self:directSetScenePos(self._tempVector)
	end
end

function ToughBattleMapScene:_addMapLight()
	local assetUrl = self._mapLightUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
end

function ToughBattleMapScene:tweenFinishCallback()
	self._tempVector:Set(self._tweenTargetPosX, self._tweenTargetPosY, 0)
	self:directSetScenePos(self._tempVector)
	self:onTweenFinish()
end

function ToughBattleMapScene:directSetScenePos(targetPos)
	self._downElement = nil

	local x, y = self:getTargetPos(targetPos)

	self._scenePos.x = x
	self._scenePos.y = y

	if not self._sceneTrans or gohelper.isNil(self._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(self._sceneTrans, self._scenePos.x, self._scenePos.y, 0)
end

function ToughBattleMapScene:_initElements()
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)

	self._elementFinishRoot = UnityEngine.GameObject.New("elementRootFinish")

	gohelper.addChild(self._sceneGo, self._elementFinishRoot)

	self.tempInitPosX = nil
	self.tempInitPosY = nil
	self.needTween = nil
	self._finishIcons = {}

	local nowStage = self:getNowShowStage()

	if nowStage == 1 then
		if not ToughBattleEnum.MapId_stage1 then
			local mapId = ToughBattleEnum.MapId_stage2
			local elements = DungeonConfig.instance:getMapElements(mapId)
			local onlyShowElement
			local info = self:getInfo()

			if nowStage == 1 then
				for i = 1, 5 do
					local co = self:getCo(i)

					if co.guideId and co.guideId > 0 then
						local guideMO = GuideModel.instance:getById(co.guideId)

						if guideMO and guideMO.isFinish and not tabletool.indexOf(info.passChallengeIds, co.id) then
							onlyShowElement = i

							break
						end
					end
				end
			end

			local lastFightSuccIndex = self.viewParam.lastFightSuccIndex

			for _, elementConfig in ipairs(elements) do
				local sort = tonumber(elementConfig.param)
				local co = self:getCo(sort)
				local isFinish = tabletool.indexOf(info.passChallengeIds, co.id)

				if not onlyShowElement or sort == onlyShowElement or isFinish then
					if isFinish then
						local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

						gohelper.addChild(self._elementFinishRoot, go)

						local boss = gohelper.create3d(go, "boss")
						local icon = gohelper.create3d(go, "icon")
						local bossLoader = PrefabInstantiate.Create(boss)
						local iconLoader = PrefabInstantiate.Create(icon)
						local iconPos = ToughBattleEnum.FinishIconPos[sort]

						transformhelper.setLocalPosXY(icon.transform, iconPos.x, iconPos.y)
						bossLoader:startLoad("scenes/v1a9_m_s08_hddt/prefab/m_s08_hddt_obj_boss" .. sort .. ".prefab")
						iconLoader:startLoad("scenes/v1a9_m_s08_hddt/prefab/hddt_icon_toughbattle_wancheng.prefab", ToughBattleMapScene.onFinishIconLoaded, {
							self,
							sort,
							co.sort == lastFightSuccIndex,
							iconLoader
						})
					else
						local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

						gohelper.addChild(self._elementRoot, go)
						MonoHelper.addLuaComOnceToGo(go, ToughBattleMapElement, {
							elementConfig,
							self
						})
					end

					if sort == lastFightSuccIndex then
						local pos = self._mapCfg.initPos
						local posParam = string.splitToNumber(pos, "#")

						self._oldScenePos = Vector2(posParam[1], posParam[2])
						posParam = string.splitToNumber(elementConfig.pos, "#")

						if not -posParam[2] then
							local x, y = -posParam[1] or 0, 0

							self.tempInitPosX = x
							self.tempInitPosY = y
							self.needTween = true
						end
					end
				end
			end

			ToughBattleController.instance:dispatchEvent(ToughBattleEvent.GuideCurStage, nowStage)
			ToughBattleController.instance:dispatchEvent(ToughBattleEvent.InitFightIndex, tostring(#info.passChallengeIds + 1))
		end
	end
end

function ToughBattleMapScene:_setElementsActive(activeStr)
	local active = activeStr == "true"

	gohelper.setActive(self._elementRoot, active)
end

function ToughBattleMapScene:_guideFocusElement(indexStr)
	local index = tonumber(indexStr)
	local nowStage = self:getNowShowStage()

	if nowStage == 1 then
		if not ToughBattleEnum.MapId_stage1 then
			local mapId = ToughBattleEnum.MapId_stage2
			local elements = DungeonConfig.instance:getMapElements(mapId)

			for _, elementConfig in ipairs(elements) do
				local sort = tonumber(elementConfig.param)

				if index == sort then
					local posParam = string.splitToNumber(elementConfig.pos, "#")

					if not -posParam[2] then
						local x, y = -posParam[1] or 0, 0

						self.tempInitPosX = x
						self.tempInitPosY = y
						self.needTween = true

						self:_setMapPos()

						break
					end
				end
			end
		end
	end
end

function ToughBattleMapScene:_guideClickElement(indexStr)
	local index = tonumber(indexStr)
	local elementCfg = self:getCo(index)

	self:onEnterFight(elementCfg, index == 6 and 2 or 1)
end

function ToughBattleMapScene:playSuccAnim()
	if not self._finishIcons or not self._finishIcons[self.viewParam.lastFightSuccIndex] then
		return
	end

	self._finishIcons[self.viewParam.lastFightSuccIndex]:Play("open", 0, 0)
end

function ToughBattleMapScene.onFinishIconLoaded(params)
	local self = params[1]
	local index = params[2]
	local isPlayOpen = params[3]
	local loader = params[4]
	local go = loader:getInstGO()
	local anim = go:GetComponent(typeof(UnityEngine.Animator))

	self._finishIcons[index] = anim

	if isPlayOpen then
		anim:Play("open", 0, 0)
	else
		anim:Play("open", 0, 1)
	end
end

function ToughBattleMapScene:onTweenFinish()
	return
end

function ToughBattleMapScene:getInfo()
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_28_0 = ToughBattleModel.instance:getActInfo()

		if not var_28_0 then
			var_28_0 = ToughBattleModel.instance:getStoryInfo()

			return var_28_0
		end
	end
end

function ToughBattleMapScene:getNowShowStage()
	local info = self:getInfo()

	if #info.passChallengeIds >= 3 and not self.viewParam.lastFightSuccIndex then
		return 2
	else
		return 1
	end
end

function ToughBattleMapScene:setMouseElementUp(element)
	if self._downElement ~= element then
		return
	end

	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self._downElement = false

		return
	end

	if self.viewParam.lastFightSuccIndex then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local co = element._config
	local index = tonumber(co.param)

	self:onEnterFight(self:getCo(index), index == 6 and 2 or 1)
end

function ToughBattleMapScene:getCo(index)
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local info = self:getInfo()
		local diffcultCo = ToughBattleConfig.instance:getCOByDiffcult(info.currDifficulty)

		if index == 6 then
			return diffcultCo.stage2
		else
			return diffcultCo.stage1[index]
		end
	else
		local storyCo = ToughBattleConfig.instance:getStoryCO()

		if index == 6 then
			return storyCo.stage2
		else
			return storyCo.stage1[index]
		end
	end
end

function ToughBattleMapScene:setMouseElementDown(element)
	self._downElement = element
end

function ToughBattleMapScene:onEnterFight(co, stage)
	local info = self:getInfo()

	if tabletool.indexOf(info.passChallengeIds, co.id) then
		return
	end

	if stage == 1 then
		ViewMgr.instance:openView(ViewName.ToughBattleEnemyInfoView, co)
	else
		local episodeId = co.episodeId
		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	end
end

function ToughBattleMapScene:tweenSetScenePos(targetPos, srcPos)
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(targetPos)
	self._tweenStartPosX, self._tweenStartPosY = self:getTargetPos(srcPos or self._scenePos)

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function ToughBattleMapScene:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function ToughBattleMapScene:tweenFrameCallback(value)
	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self._tempVector:Set(x, y, 0)
	self:directSetScenePos(self._tempVector)
end

function ToughBattleMapScene:getTargetPos(targetPos)
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

function ToughBattleMapScene:_initMapRootNode()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("ToughBattleMapScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function ToughBattleMapScene:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)
end

function ToughBattleMapScene:onClose()
	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	gohelper.destroy(self._sceneRoot)
end

return ToughBattleMapScene
