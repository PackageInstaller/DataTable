-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneMgr.lua

module("logicscene.scene.SceneMgr", package.seeall)

local SceneMgr = class("SceneMgr", SceneMgrBase)

function SceneMgr:ctor()
	SceneExtend.extend()
	SceneMgr.super.ctor(self)

	self.VirtualJoystickKey = "SceneMgr"

	AoSceneManager.CreateSceneManager()
	DepthFilter.Initialize(-1800)

	self._tryEnterSceneType = nil
	self._transitionQualityHigh = true
	self._needLoadingSceneType = {}
	self._needLoadingSceneType[SceneType.City] = true
	self._needLoadingSceneType[SceneType.CreateRole] = true
	self._needLoadingSceneType[SceneType.Battle] = true
	self._sceneType2LoadingTipsEnum = {}
	self._sceneType2LoadingTipsEnum[SceneType.City] = LoadingTipsEnum.City
	self._sceneType2LoadingTipsEnum[SceneType.Battle] = LoadingTipsEnum.Battle
	self._sceneType2LoadingTipsEnum[SceneType.CreateRole] = LoadingTipsEnum.CreateRole

	BattleHudMovingMgr.initBaziers()
	AoSceneManager.Instance:AddSceneQueryListener(self._onQueryObject, self._onQueryFindWay, self._onQueryNoneObject, self)
	AoSceneManager.Instance:AddNpcFuncTypeQueryListener(self._onNpcFuncType, self)
	BattleEffectOrderCtrl.reset()
	UIEffectManager.instance:setPermanent("fx_ui_dianji.prefab", true)
	HardwareQuality.applySceneReadyQualitySettings()

	self._currScene = nil
	self._enabledTransition = true

	self:_createUpdateHandler()
end

function SceneMgr:_setSpeed()
	if not self._obscuredSpeed then
		local value = ConstConfig.instance:getNumValueByKey("MainPlayerSpeed")

		self._obscuredSpeed = Framework.ObscuredFloat.Encrypt(value)
	end
end

function SceneMgr:getRoot()
	return self._root
end

function SceneMgr:getCurSceneId()
	return self._curSceneId
end

function SceneMgr:getCurScene()
	return self._currScene
end

function SceneMgr:setTransitionQualityHigh(high)
	self._transitionQualityHigh = high
end

function SceneMgr:isTransitionQualityHigh()
	return self._transitionQualityHigh
end

function SceneMgr:_createSingletonComps()
	MainPlayerWalkDestEff.instance = MainPlayerWalkDestEff.New()
end

function SceneMgr:setVisible(visible)
	AoSceneManager.Instance:SetVisible(visible)
end

function SceneMgr:_extendConstDef()
	SceneTagExtend.extend()
	SceneLayerExtend.extend()
	SceneNotifyExtend.extend()
end

function SceneMgr:_registerScenes()
	self:_registerScene(SceneType.Battle, BattleScene)
	self:_registerScene(SceneType.CreateRole, CreateRoleScene)
end

function SceneMgr:_createUpdateHandler()
	UpdateBeat:Add(self._updateHandler, self)
	LateUpdateBeat:Add(self._lateUpdateHandler, self)
end

function SceneMgr:disableTransition()
	self._enabledTransition = nil
end

function SceneMgr:enabledTransition()
	self._enabledTransition = true
end

function SceneMgr:isTransitionEnabled()
	return self._enabledTransition
end

function SceneMgr:exitCurScene()
	if self._curSceneType == 0 or self._curSceneId == 0 then
		return
	end

	self:showLoading()

	self._lastSceneType = self._curSceneType
	self._lastSceneId = self._curSceneId

	ScenePreLoaderMgr.instance:clearAll()
	self._currScene:onExit()
	self._currScene:onExitFinished()
	self._currScene.stage:unload()

	self._curSceneType = 0
	self._curSceneId = 0
	self._currScene = nil

	if self._transition then
		self._transition:clear()

		self._transition = nil
	end

	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	self._preScene = nil
	LoginModel.instance.isSceneLoaded = false
	self._isEnetering = false
	self._currScene = nil
end

function SceneMgr:onExitFinished()
	self:hideLoading()
end

function SceneMgr:getScene(sceneType)
	if sceneType == SceneType.City then
		return self._currScene
	end

	return SceneMgr.super.getScene(self, sceneType)
end

function SceneMgr:_createScene(sceneId, sceneType)
	if sceneType == SceneType.City then
		local sceneCo = SceneConfig.instance:getSceneCo(sceneId)
		local sceneCls = string.nilorempty(sceneCo.sceneCls) and CityScene or _G[sceneCo.sceneCls]
		local container = goutil.create(sceneCls.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (sceneCls.New(container))
	elseif sceneType == SceneType.ExpedScene then
		local container = goutil.create(ExpedScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (ExpedScene.New(container))
	elseif sceneType == SceneType.PetZoo then
		local container = goutil.create(PetZooScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (PetZooScene.New(container))
	elseif sceneType == SceneType.SeasonTiling then
		local container = goutil.create(SeasonTilingScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (SeasonTilingScene.New(container))
	elseif sceneType == SceneType.TreasureRaider then
		local container = goutil.create(TreasureRaiderScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (TreasureRaiderScene.New(container))
	elseif sceneType == SceneType.CutePet then
		local container = goutil.create(CutePetScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (CutePetScene.New(container))
	elseif sceneType == SceneType.ElementSpark then
		local container = goutil.create(ElementSparkScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (ElementSparkScene.New(container))
	elseif sceneType == SceneType.Family then
		local container = goutil.create(FamilyScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (FamilyScene.New(container))
	elseif sceneType == SceneType.DomainAdventure then
		local container = goutil.create(DomainAdventureScene.__cname, false)

		goutil.addChildToParent(container, self._root)

		return (DomainAdventureScene.New(container))
	end

	return self:getScene(sceneType)
end

function SceneMgr:_registerScene(sceneType, SceneCls)
	local container = goutil.create(SceneCls.__cname, false)

	goutil.addChildToParent(container, self._root)

	self._scenes[sceneType] = SceneCls.New(container)
end

function SceneMgr:enter(sceneType, sceneId, bornX, bornZ, underBridge, userVariabls, defaultView, festivel)
	if self._transition then
		return
	end

	if string.nilorempty(festivel) then
		local festivalMo = SceneFestivalMgr.instance:getActiveFestival(sceneId)

		if festivalMo then
			festivel = festivalMo.festival
		end
	end

	if self._curSceneType == sceneType and self._curSceneId == sceneId and self._currSceneFestival == festivel then
		return
	end

	local isSwitchFestival = self._curSceneType == sceneType and self._curSceneId == sceneId and self._currSceneFestival ~= festivel

	AudioPlayerEx.instance:init()
	self:_setSpeed()

	if isSwitchFestival then
		self:_buildTransition(sceneId, sceneType, self._currSceneFestival, festivel)
	else
		self:_buildTransition(sceneId, sceneType)
	end

	ScenePreLoaderMgr.instance:onEnterScene()

	local preScene = self._currScene

	if preScene then
		preScene:onExit()
	end

	self._preScene = preScene
	self._curSceneType = sceneType
	self._curSceneId = sceneId
	self._underBridge = underBridge
	self._userVariabls = userVariabls
	self._currSceneFestival = festivel
	self._currScene = self:_createScene(sceneId, sceneType)
	self._currScene.defaultView = defaultView

	if self._currScene.setSwithFestival then
		self._currScene:setSwithFestival(isSwitchFestival)
	end

	if self._currScene.setFestival then
		self._currScene:setFestival(festivel)
	end

	self._currScene:onEnter(sceneId, bornX, bornZ)

	if self._currScene.setUnderBridge then
		self._currScene:setUnderBridge(self._underBridge)
	end

	self._isEntering = true
	self._tryEnterSceneType = sceneType

	self._transition:prepareTransition(preScene, self._currScene, isSwitchFestival)
end

function SceneMgr:_buildTransition(sceneId, sceneType, currFestival, festival)
	if not string.nilorempty(festival) then
		local animationName
		local festivalCo = SceneConfig.instance:getSceneFestivalCo(sceneId, festival)

		if festivalCo then
			animationName = festivalCo.toFestivalEff
		end

		if string.nilorempty(animationName) then
			festivalCo = SceneConfig.instance:getSceneFestivalCo(sceneId, currFestival or "")

			if festivalCo then
				animationName = festivalCo.festivalBackEff
			end
		end

		if not string.nilorempty(animationName) then
			self._transition = SceneTransitionAnimEff.instance
			self._transition.animationName = animationName

			return
		end
	end

	if sceneType == SceneType.Battle and BattleController.instance:isGoingToBattleCg() then
		self._transition = SceneTransitionWaiting.instance

		return
	end

	local preSceneType

	if self._currScene then
		preSceneType = self._currScene:getSceneType()
	end

	if sceneType == SceneType.CreateRole then
		self:_enterCreateRoleSceneTrans(preSceneType)

		return
	end

	if preSceneType ~= SceneType.Battle and sceneType == SceneType.SeasonTiling then
		self._transition = SceneTransitionAnimEff.instance
		self._transition.animationName = "story_saijizc"

		return
	end

	if preSceneType ~= SceneType.Battle and sceneType == SceneType.DomainAdventure then
		local storyId = DomainAdventureController.instance:getStoryIdInEnterScene()

		if storyId > 0 then
			self._transition = SceneTransitionStory.instance

			self._transition:setStoryId(storyId)

			return
		end
	end

	if preSceneType == SceneType.CreateRole and sceneType == SceneType.City then
		self:_enterCityFromCreateRoleSceneTrans()
	elseif sceneType == SceneType.City and preSceneType == SceneType.City then
		if self._currScene then
			SceneFacade.instance:showSceneObjects(true)
		end

		self._transition = SceneTransitionFade.instance
	else
		self._transition = SceneTransitionWaiting.instance

		if preSceneType == SceneType.City and (sceneType == SceneType.ExpedScene or sceneType == SceneType.PetZoo) then
			self._transition.holdUIStatus = true
		end

		if sceneType == SceneType.Battle then
			-- block empty
		end
	end
end

function SceneMgr:_enterCreateRoleSceneTrans(preSceneType)
	if preSceneType then
		self._transition = SceneTransitionPlayVideo.instance
		self._transition.traceStartKeys = {
			"stl_xiaonuo_pv_start"
		}
		self._transition.traceEndKeys = {
			"stl_xiaonuo_pv_end"
		}
		self._transition.traceStartNames = {
			"小诺坠落PV开始"
		}
		self._transition.traceEndNames = {
			"小诺坠落PV结束"
		}
		self._transition.videoNames = {
			"chuangjuedonghua02"
		}
	else
		self._transition = SceneTransitionPlayVideo.instance
		self._transition.traceStartKeys = {
			"stl_login_to_cr_pv_start"
		}
		self._transition.traceEndKeys = {
			"stl_login_to_cr_pv_end"
		}
		self._transition.traceStartNames = {
			"登录进创角PV开始"
		}
		self._transition.traceEndNames = {
			"登录进创角PV结束"
		}
		self._transition.videoNames = {
			"cg_0_1"
		}
	end
end

function SceneMgr:_enterCityFromCreateRoleSceneTrans()
	local videoNames, traceStartKeys, traceEndKeys, traceStartNames, traceEndNames
	local gender = RoleModel.instance:getGender()

	if gender == GameEnum.Gender.Female then
		videoNames = {
			"chuangjuedonghua03_female"
		}
		traceStartKeys = {
			"stl_createrole_female1_start"
		}
		traceEndKeys = {
			"stl_createrole_female1_end"
		}
		traceStartNames = {
			"创角PV_开始"
		}
		traceEndNames = {
			"创角PV_结束"
		}
	else
		videoNames = {
			"chuangjuedonghua03_male"
		}
		traceStartKeys = {
			"stl_createrole_male1_start"
		}
		traceEndKeys = {
			"stl_createrole_male1_end"
		}
		traceStartNames = {
			"创角PV_开始"
		}
		traceEndNames = {
			"创角PV_结束"
		}
	end

	self._transition = SceneTransitionPlayVideo.instance
	self._transition.videoNames = videoNames
	self._transition.traceStartKeys = traceStartKeys
	self._transition.traceEndKeys = traceEndKeys
	self._transition.traceStartNames = traceStartNames
	self._transition.traceEndNames = traceEndNames
end

function SceneMgr:onEnterFinished()
	if self._transition == SceneTransitionWaiting.instance then
		self:notifyEnterFinished()
	end
end

function SceneMgr:notifyEnterFinished()
	self._lastSceneType = self._curSceneType
	self._lastSceneId = self._curSceneId

	ScenePreLoaderMgr.instance:onEnterSceneFinished(self._currScene)
	self._transition:onEnterFinished()
	self._currScene:onEnterFinished()
	SceneMainPlayer.instance:updateVariablesView()

	self._isEnetering = false

	self:_checkNextEnterCmd()

	self._isEntering = false
	self._transition = nil
	self._preScene = nil

	ResGcMgr.instance:gc()
	GlobalDispatcher:dispatch(GlobalNotify.SceneLoaded, self._curSceneType, self._curSceneId)
	WaterMgr.instance:_onSceneLoaded(self._curSceneId)
	self._currScene:lateEnterFinished()
end

function SceneMgr:enabledSceneQuery(enabled)
	AoSceneManager.Instance:EnabledSceneQuery(enabled)
end

function SceneMgr:getSceneCharactorParams()
	self:_setSpeed()

	local scale = SceneMainPlayer.localScale
	local speed = Framework.ObscuredFloat.Decrypt(self._obscuredSpeed)
	local hudHeight = 1.5
	local currScene = self:getCurScene()

	if currScene then
		local sceneCo = SceneConfig.instance:getSceneCo(currScene:getSceneId())

		if sceneCo and sceneCo.sceneParams then
			scale = sceneCo.sceneParams[2] or scale
			hudHeight = sceneCo.sceneParams[3] or hudHeight * scale
			speed = sceneCo.sceneParams[4] or speed
		end
	end

	return scale, speed, hudHeight
end

function SceneMgr:getSceneCameraParams(sceneId)
	local orthographicSize = CitySceneCameraEx.orthographicSize
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	orthographicSize = sceneCo and sceneCo.sceneParams and sceneCo.sceneParams[1] or orthographicSize

	return orthographicSize
end

function SceneMgr:showLoading()
	if not self:_isNeedLoading() then
		return
	end
end

function SceneMgr:hideLoading()
	if not self:_isNeedLoading() then
		return
	end
end

function SceneMgr:isTransitionFade()
	return self._transition == SceneTransitionFade.instance
end

function SceneMgr:_isNeedLoading()
	return self._needLoadingSceneType[self._tryEnterSceneType]
end

function SceneMgr:_onQueryFindWay(x, y)
	local scene = self:getCurScene()

	if scene and scene.picker then
		scene.picker:onQueryFindWay(x, y)
	end
end

function SceneMgr:_onQueryObject(go)
	local scene = self:getCurScene()

	if scene and scene.picker then
		scene.picker:onQueryObject(go)
	end
end

function SceneMgr:_onQueryNoneObject(screenPos)
	local eff = UIEffectManager.instance:playScreenEffect("fx_ui_dianji.prefab", screenPos)

	eff:setScale(0.6)

	local scene = self:getCurScene()

	if scene and scene.picker and scene.picker.onQueryNoneObject then
		scene.picker:onQueryNoneObject(screenPos)
	end
end

function SceneMgr:_onNpcFuncType(npcId)
	local npcCo = SceneConfig.instance:getNpcCo(npcId)

	if npcCo then
		return npcCo.funcType
	end

	return -1
end

function SceneMgr:_updateHandler()
	local deltaTime = Time.deltaTime
	local currScene = self:getCurScene()

	if currScene and currScene.update ~= nil then
		currScene:update(deltaTime)
	end

	UIEffectManager.instance:update(deltaTime)
	GameEffectManager.instance:update(deltaTime)
	SoloAudioMgr.instance:update()
	UnlockController.instance:checkSceneUnlockByTime()
	NetConnMgrExt.checkNetword()
end

function SceneMgr:_lateUpdateHandler()
	local currScene = self:getCurScene()

	if currScene and currScene.lateUpdate ~= nil then
		currScene:lateUpdate()
	end

	UIEffectManager.instance:lateUpdate()
	GameEffectManager.instance:lateUpdate()
	RoleObjectPool.instance:lateUpdate()
	MaterialMgr.instance:lateUpdate()
	CommonTipsMgr.instance:lateUpdate()
	AcceleratorCheckController.instance:update()
	RedPointController.instance:lateUpdateRedPoint()
	MaterialController.instance:lateUpdateMaterial()

	self._locked = false
end

function SceneMgr:getIsLocked()
	return self._locked == true
end

function SceneMgr:tryClick()
	if self._locked == true then
		return false
	else
		self._locked = true

		return true
	end
end

SceneMgr.instance = SceneMgr.New()

return SceneMgr
