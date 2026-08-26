-- chunkname: @modules/logic/weather/controller/WeatherComp.lua

module("modules.logic.weather.controller.WeatherComp", package.seeall)

local WeatherComp = class("WeatherComp")

WeatherComp.TypeOfLightSwitch = typeof(ZProj.SwitchLight)
WeatherComp.TypeOfParticleSystem = typeof(UnityEngine.ParticleSystem)

local audioMgr = AudioMgr.instance

function WeatherComp:ctor(weatherController, isMain)
	self._weatherController = weatherController
	self._isMain = isMain

	if self._isMain then
		self._randomMainHero = true
	end
end

function WeatherComp:onInit()
	self._str2Id = {}
	self._lightMapPath = "scenes/dynamic/%s/lightmaps/%s_%s.tga"
	self._effectPath = "scenes/%s/effect/s01_effect_0%s.prefab"

	local _shader = UnityEngine.Shader

	self._MainColorId = _shader.PropertyToID("_MainColor")
	self._EmissionColorId = _shader.PropertyToID("_EmissionColor")
	self._UseSecondMapId = _shader.PropertyToID("_UseSecondMap")
	self._UseFirstMapId = _shader.PropertyToID("_UseFirstMap")
	self._PercentId = _shader.PropertyToID("_Percent")
	self._LightmaplerpId = _shader.PropertyToID("_Lightmaplerp")
	self._BloomFactorId = _shader.PropertyToID("_BloomFactor")
	self._BloomFactor2Id = _shader.PropertyToID("_BloomFactor2")
	self._LuminanceId = _shader.PropertyToID("Luminance")
	self._RainId = _shader.PropertyToID("_Rain")
	self._RainDistortionFactorId = _shader.PropertyToID("_DistortionFactor")
	self._RainEmissionId = _shader.PropertyToID("_Emission")
	self._UseFirstMapKey = "_USEFIRSTMAP_ON"
	self._UseSecondMapKey = "_USESECONDMAP_ON"

	if self._isMain then
		self:onInitFinish()
	end
end

function WeatherComp:_onApplicationQuit()
	self:_clearMats()
end

function WeatherComp:onInitFinish()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnApplicationQuit, self._onApplicationQuit, self)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.SwitchSceneFinish, self._onSwitchSceneFinish, self, LuaEventSystem.High)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.CloseSwitchSceneLoading, self._onCloseSwitchSceneLoading, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.SceneGoChangeVisible, self._onSceneGoChangeVisible, self)
end

function WeatherComp:_onSceneGoChangeVisible(value)
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Main then
		return
	end

	if value then
		self:_playWeatherEffectAudio()
	else
		self:_stopWeatherEffectAudio()
	end
end

function WeatherComp:doCallback()
	if not self._callbackTarget then
		return
	end

	self._callback(self._callbackTarget)

	self._callback = nil
	self._callbackTarget = nil
end

function WeatherComp:resetWeatherChangeVoiceFlag()
	self._weatherChangeVoice = false
end

function WeatherComp:setLightModel(lightModel)
	self._lightModel = lightModel
end

function WeatherComp:initRoleGo(roleGo, heroId, sharedMaterial, playVoice, skinId)
	self._weatherChangeVoice = false
	self._dispatchParam = self._dispatchParam or {}

	self:_changeRoleGo(roleGo, heroId, sharedMaterial, true, skinId)

	if playVoice then
		self:playWeatherVoice(true)
	end
end

function WeatherComp:changeRoleGo(param)
	self:_changeRoleGo(param.roleGo, param.heroId, param.sharedMaterial, param.heroPlayWeatherVoice, param.skinId)
end

function WeatherComp:clearMat()
	self._roleSharedMaterial = nil
end

function WeatherComp:_changeRoleGo(roleGo, heroId, sharedMaterial, heroPlayWeatherVoice, skinId)
	self._tempRoleParam = nil
	self._changeRoleParam = {
		roleGo = roleGo,
		heroId = heroId,
		sharedMaterial = sharedMaterial,
		heroPlayWeatherVoice = heroPlayWeatherVoice,
		skinId = skinId
	}
	self._roleGo = roleGo
	self._heroId = heroId
	self._skinId = skinId
	self._heroPlayWeatherVoice = heroPlayWeatherVoice
	self._roleSharedMaterial = sharedMaterial

	local mask = roleGo:GetComponent(PostProcessingMgr.PPEffectMaskType)

	self._postProcessMask = mask and mask or nil

	self:initRoleParam(self._curReport)
	self:blendRoleLightMode(self._targetValue, true)
end

function WeatherComp:setRoleMaskEnabled(value)
	if not gohelper.isNil(self._postProcessMask) then
		self._postProcessMask.enabled = value
	end
end

function WeatherComp:playWeatherVoice(force)
	if not self._weatherController then
		return
	end

	if self._weatherChangeVoice or not self._heroPlayWeatherVoice then
		return
	end

	local prevWeatherVoice = false
	local curWeatherVoice = false
	local heroId = self._heroId
	local weatherChangeVoices = HeroModel.instance:getVoiceConfig(heroId, CharacterEnum.VoiceType.WeatherChange, function(config)
		local param = string.split(config.param, "#")

		for i, v in ipairs(param) do
			local reportId = tonumber(v)

			if self._prevReport and reportId == self._prevReport.id then
				prevWeatherVoice = true
			end

			if reportId == self._curReport.id then
				curWeatherVoice = true
			end
		end

		return curWeatherVoice
	end, self._skinId)

	if weatherChangeVoices and #weatherChangeVoices > 0 and (force or prevWeatherVoice == false and curWeatherVoice or math.random() <= 0.3) then
		local weatherConfig = weatherChangeVoices[1]

		self._dispatchParam[1] = MainHeroView.getRandomMultiVoice(weatherConfig, self._heroId, self._skinId)
		self._dispatchParam[2] = false

		self._weatherController:dispatchEvent(WeatherEvent.PlayVoice, self._dispatchParam)

		if self._dispatchParam[2] then
			self._weatherChangeVoice = true
		end
	end
end

function WeatherComp:getSceneNode(nodePath)
	return gohelper.findChild(self._sceneGo, nodePath)
end

function WeatherComp:playAnim(name)
	if not self._animator then
		local anim = self:getSceneNode("s01_obj_a/Anim")

		if anim then
			self._animator = anim:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	if self._animator and self._sceneGo.activeInHierarchy then
		self._animator:Play(name)
	end
end

function WeatherComp:_onCloseSwitchSceneLoading()
	self:playAnim("s01_character_switch_bg")
end

function WeatherComp:_onStartSwitchScene()
	self._tempRoleParam = self._changeRoleParam

	self:onSceneClose()

	if self._isMain then
		self._randomMainHero = false
	end
end

function WeatherComp:_onSwitchSceneInitFinish()
	if not self._weatherController then
		return
	end

	if self._isSceneHide then
		self:onSceneHide()
	end

	if self._startInitSceneTime then
		-- block empty
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneInitFinish)
end

function WeatherComp:_onSwitchSceneFinish()
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGO = scene.level:getSceneGo()

	self._startInitSceneTime = Time.realtimeSinceStartup

	self:setSceneId(MainSceneSwitchModel.instance:getCurSceneId())
	self.initSceneGo(self, sceneGO, self._onSwitchSceneInitFinish, self)

	if self._tempRoleParam then
		local param = self._tempRoleParam

		self._tempRoleParam = nil

		self:_changeRoleGo(param.roleGo, param.heroId, param.sharedMaterial, param.heroPlayWeatherVoice, param.skinId)
	end
end

function WeatherComp:changeReportId(reportId, deltaTime)
	self._reportId = reportId
	self._reportDeltaTime = deltaTime

	if self._sceneGo then
		self:updateReport(false)
	end
end

function WeatherComp:setSceneId(sceneId)
	self._sceneId = sceneId
end

function WeatherComp:_checkMatTexture(mat)
	if mat:GetTexture(ShaderPropertyId.MainTex) then
		logError(string.format("_checkMatTexture mat:{%s} MainTex is not nil", mat.name))
	end

	if mat:GetTexture(ShaderPropertyId.MainTexSecond) then
		logError(string.format("_checkMatTexture mat:{%s} MainTexSecond is not nil", mat.name))
	end
end

function WeatherComp:getSceneGo()
	return self._sceneGo
end

function WeatherComp:initSceneGo(sceneGo, callback, callbackTarget)
	self._revert = true

	if self._isMain then
		WeatherModel.instance:initDay(self._sceneId)
	end

	self._sceneGo = sceneGo

	local effectRootGo = self:getSceneNode("s01_obj_a/Anim/Effect")

	self._effectRoot = effectRootGo.transform
	self._effectLightPs = gohelper.findChildComponent(effectRootGo, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)
	self._effectAirPs = gohelper.findChildComponent(effectRootGo, "m_s01_effect_air", WeatherComp.TypeOfParticleSystem)
	self._lightSwitch = sceneGo:GetComponent(WeatherComp.TypeOfLightSwitch)
	self._callback = callback
	self._callbackTarget = callbackTarget

	local isEditor = SLFramework.FrameworkSettings.IsEditor
	local lightMats = self._lightSwitch.lightMats

	self._lightMats = {}
	self._matsMap = {}
	self._rawLightMats = {}
	self._rainEffectMat = nil

	for i = 0, lightMats.Length - 1 do
		local rawMat = lightMats[i]
		local mat = UnityEngine.Material.Instantiate(rawMat)

		mat.name = rawMat.name
		lightMats[i] = mat

		local nameParam = string.split(mat.name, "#")
		local prefix = nameParam[1]

		if not WeatherHelper.skipLightMap(self._sceneId, prefix) then
			self._lightMats[prefix] = self._lightMats[prefix] or {}

			table.insert(self._lightMats[prefix], mat)
			table.insert(self._rawLightMats, mat)
		end

		self._matsMap[mat.name] = mat

		if isEditor then
			self:_checkMatTexture(mat)
		end

		if string.find(prefix, "m_s01_obj_e$") then
			self._rainEffectMat = mat
		end
	end

	self._behaviourContainer = WeatherBehaviourContainer.Create(self._sceneGo)

	self._behaviourContainer:setSceneId(self._sceneId)
	self._behaviourContainer:setLightMats(lightMats)

	if not self._rainEffectMat then
		logError("WeatherComp initSceneGo no rainEffectMat")
	end

	self:_initMatReportSettings()

	if self._isMain then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
		MainController.instance:registerCallback(MainEvent.OnShowSceneNewbieOpen, self._OnShowSceneNewbieOpen, self)
		self._weatherController:updateOtherComps(sceneGo)
	end

	self:updateReport(false)
end

function WeatherComp:_initMatReportSettings()
	self._matReportSettings = WeatherConfig.instance:getMatReportSettings(self._sceneId)

	if SLFramework.FrameworkSettings.IsEditor and self._matReportSettings then
		for matName, v in pairs(self._matReportSettings) do
			local mat = self._matsMap[matName]

			if not mat then
				logError(string.format("WeatherComp _initMatReportSettings mat:{%s} is nil", matName))
			elseif mat:GetTexture(ShaderPropertyId.LightMap) then
				logError(string.format("WeatherComp _initMatReportSettings mat:{%s} LightMap is not nil", matName))
			end
		end
	end
end

function WeatherComp:_OnShowSceneNewbieOpen()
	callWithCatch(self._playNewbieShowAnim, self)
end

function WeatherComp:_playNewbieShowAnim()
	self:playAnim("s01_character_switch_xingshou")
end

function WeatherComp:_onCloseFullView(viewName)
	if not ViewMgr.instance:hasOpenFullView() then
		self:_checkReport()
	end
end

function WeatherComp:setReportId(id)
	local curReport, deltaTime = lua_weather_report.configDict[id], 60

	if curReport and deltaTime then
		print(WeatherModel.instance:debug(curReport.id, self._sceneId))
		self:setReport(curReport)

		if not self._reportEndTime then
			TaskDispatcher.runRepeat(self._checkReport, self, 60)
		end

		self._reportEndTime = os.time() + deltaTime

		if self._weatherController then
			self._weatherController:dispatchEvent(WeatherEvent.WeatherChanged, curReport.id, deltaTime)
		end
	end
end

function WeatherComp:updateReport(dispatchChange)
	local curReport, deltaTime = WeatherModel.instance:getReport()
	local status, welcomeReport = xpcall(self._getWelcomeReport, __G__TRACKBACK__, self)

	if status and welcomeReport then
		curReport = welcomeReport
		deltaTime = 3600
	end

	if GuideModel.instance:isDoingFirstGuide() then
		deltaTime = 86400
		curReport = lua_weather_report.configDict[2]
	end

	if self._reportId and self._reportDeltaTime then
		curReport = lua_weather_report.configDict[self._reportId]
		deltaTime = self._reportDeltaTime
	end

	if curReport and deltaTime then
		print(WeatherModel.instance:debug(curReport.id, self._sceneId))
		self:setReport(curReport)

		if not self._reportEndTime then
			TaskDispatcher.runRepeat(self._checkReport, self, 60)
		end

		self._reportEndTime = os.time() + deltaTime

		if dispatchChange and self._weatherController then
			self._weatherController:dispatchEvent(WeatherEvent.WeatherChanged, curReport.id, deltaTime)
		end
	else
		logError(string.format("WeatherComp:updateReport error,curReport:%s,deltaTime:%s", curReport, deltaTime))
	end
end

function WeatherComp:_getWelcomeReport()
	if not MainThumbnailWork._checkShow() then
		return
	end

	local curHeroId, curSkinId = CharacterSwitchListModel.instance:getMainHero()
	local config = MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, curHeroId, curSkinId)

	if not config then
		return
	end

	local param = string.split(config.time, "#")
	local timeList = string.split(param[1], ":")
	local h = tonumber(timeList[1])
	local inTheMorning = h < 12

	if inTheMorning then
		return (WeatherConfig.instance:getRandomReport(WeatherEnum.LightModeDuring or WeatherEnum.LightModeDusk, self._sceneId))
	end
end

function WeatherComp:_checkReport()
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not self._isSceneHide and self._reportEndTime and self._reportEndTime <= os.time() then
		self:updateReport(true)
	end
end

function WeatherComp:getPrevLightMode()
	return self._prevReport and self._prevReport.lightMode
end

function WeatherComp:getCurLightMode()
	return self._curReport and self._curReport.lightMode
end

function WeatherComp:getReportId()
	return self._curReport and self._curReport.id
end

function WeatherComp:_finishAllUpdate()
	if self._effectStartTime then
		self:_onEffectUpdateHandler(self._effectStartTime + 5)
	end

	if self._startTime then
		self:_onUpdateHandler(self._startTime + 5)
	end
end

function WeatherComp:setReport(report)
	if self._curReport and report.id == self._curReport.id then
		return
	end

	if not WeatherConfig.instance:sceneContainReport(self._sceneId, report.id) then
		logError(string.format("WeatherComp setReport sceneId:%s,reportId:%s,not in scene", self._sceneId, report.id))

		report = lua_weather_report.configDict[1]
	end

	self:_finishAllUpdate()

	self._prevReport = self._curReport
	self._curReport = report
	self.reportLightMode = self._curReport.lightMode

	if self._changeReportCallback then
		self._changeReportCallback(self._changeReportCallbackTarget, self._curReport)
	end

	if self._prevReport and self._prevReport.effect ~= self._curReport.effect then
		self:removeAllEffect()
	end

	if self._behaviourContainer then
		self._behaviourContainer:setReport(self._prevReport, self._curReport)
	end

	self:_playVoice()

	if self._prevReport and self._prevReport.lightMode == self._curReport.lightMode then
		self:addAllEffect()
		self:startEffectBlend()
		self:playWeatherVoice()

		return
	end

	self:changeLightEffectColor()
	self:initRoleParam(self._curReport)
	self:startSwitchReport(self._prevReport, self._curReport)
end

function WeatherComp:getCurrReport()
	return self._curReport
end

function WeatherComp:startSwitchReport(src, target)
	self._speed = 0.5
	self._revert = not self._revert

	if self._revert then
		self._startValue = 1
		self._targetValue = 0
		self._srcReport = target
		self._targetReport = src
	else
		self._startValue = 0
		self._targetValue = 1
		self._srcReport = src
		self._targetReport = target
	end

	self._deltaValue = self._targetValue - self._startValue

	self:switchLight((self._srcReport or nil) and (self._srcReport.lightMode - 1 or nil), self._targetReport.lightMode - 1)
end

function WeatherComp:switchLight(src, target)
	self:_startLoad(src, target)
end

function WeatherComp:_getSceneResName()
	return self._sceneResName or MainSceneSwitchModel.instance:getCurSceneResName()
end

function WeatherComp:setSceneResName(name)
	self._sceneResName = name
end

function WeatherComp:_startLoad(src, target)
	TaskDispatcher.cancelTask(self._resGC, self)
	TaskDispatcher.cancelTask(self._repeatPlayEffectAndAudio, self)

	self._reportSrc = src
	self._reportTarget = target

	if self._srcLoader then
		self._srcLoader:dispose()

		self._srcLoader = nil
	end

	if self._targetLoader then
		self._targetLoader:dispose()

		self._targetLoader = nil
	end

	local resName = self:_getSceneResName()
	local lightMapPathList = {}
	local srcList = {}
	local targetList = {}

	for prefix, v in pairs(self._lightMats) do
		if not lightMapPathList[prefix] then
			local t = {}

			if src then
				local srcPath = string.format(self._lightMapPath, resName, WeatherHelper.getResourcePrefix(prefix), src)

				if not tabletool.indexOf(srcList, srcPath) then
					table.insert(srcList, srcPath)
				end

				t[src] = srcPath
			end

			local targetPath = string.format(self._lightMapPath, resName, WeatherHelper.getResourcePrefix(prefix), target)

			if not tabletool.indexOf(targetList, targetPath) then
				table.insert(targetList, targetPath)
			end

			t[target] = targetPath
			lightMapPathList[prefix] = t
		end
	end

	self._lightMapPathPrefix = lightMapPathList
	self._loadFinishNum = 0

	if #srcList > 0 then
		self._loadMaxNum = 2
		self._srcLoader = MultiAbLoader.New()

		self._srcLoader:setPathList(srcList)
		self._srcLoader:startLoad(self._onLoadOneDone, self)
	else
		self._loadMaxNum = 1
	end

	if self._matReportSettings and #targetList > 0 then
		for k, v in pairs(self._matReportSettings) do
			local path = v[self._curReport.lightMode]

			if path then
				table.insert(targetList, path)
			end
		end
	end

	if #targetList > 0 then
		self._targetLoader = MultiAbLoader.New()

		self._targetLoader:setPathList(targetList)
		self._targetLoader:startLoad(self._onLoadOneDone, self)
	end
end

function WeatherComp:_onLoadOneDone()
	self._loadFinishNum = self._loadFinishNum + 1

	if self._loadFinishNum < self._loadMaxNum then
		return
	end

	self:_loadTexturesFinish(self._srcLoader, self._targetLoader, self._lightMapPathPrefix, self._reportSrc, self._reportTarget)
end

function WeatherComp:_loadTexturesFinish(srcLoader, targetLoader, lightMapPathList, src, target)
	self:doCallback()

	local srcTexture

	for prefix, v in pairs(lightMapPathList) do
		if src then
			local srcPath = v[src]
			local srcItem = srcLoader:getAssetItem(srcPath)

			srcTexture = srcItem:GetResource(srcPath)
		end

		local targetPath = v[target]
		local targetItem = targetLoader:getAssetItem(targetPath)
		local targetTexture = targetItem:GetResource(targetPath)

		for _, mat in pairs(self._lightMats[prefix]) do
			if src then
				mat:SetTexture(ShaderPropertyId.MainTex, srcTexture)
			end

			mat:SetTexture(ShaderPropertyId.MainTexSecond, targetTexture)
		end
	end

	self:_setMatReportLightMap(targetLoader)
	self:_setSceneMatMapCfg(1, 1)

	if not MainSceneSwitchEnum.SceneGCTime[self._sceneId] then
		TaskDispatcher.runDelay(self._resGC, self, MainSceneSwitchEnum.SceneGCTime[self._sceneId])

		if src then
			self:startLightBlend()
			self:startEffectBlend()
		else
			self:_changeBlendValue(self._targetValue, true)
			self:_changeEffectBlendValue(1, true)
			self:_updateSceneMatMapCfg()
		end

		self:_resetMats()
	end
end

function WeatherComp:_setMatReportLightMap(targetLoader)
	if not self._matReportSettings then
		return
	end

	for matName, v in pairs(self._matReportSettings) do
		local mat = self._matsMap[matName]
		local path = v[self._curReport.lightMode]

		if path then
			if mat then
				local targetItem = targetLoader:getAssetItem(path)
				local targetTexture = targetItem and targetItem:GetResource(path)

				if targetTexture then
					mat:SetTexture(ShaderPropertyId.LightMap, targetTexture)
				else
					logError(string.format("WeatherComp:_setMatReportLightMap targetTexture is nil, path: %s", path))
				end
			end
		elseif mat then
			mat:SetTexture(ShaderPropertyId.LightMap, nil)
		end
	end
end

function WeatherComp:_resetMats()
	self:_resetGoMats(self:getSceneNode("s01_obj_a/Anim/Sky"))
	self:_resetGoMats(self:getSceneNode("s01_obj_a/Anim/Ground"))
	self:_resetGoMats(self:getSceneNode("s01_obj_a/Anim/Obj"))
end

function WeatherComp:_resetGoMats(go)
	local meshRenderer = go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	if meshRenderer then
		for index = 0, meshRenderer.Length - 1 do
			local render = meshRenderer[index]
			local mat = render.sharedMaterial
			local matName = mat and string.split(mat.name, " ")[1]

			if matName and self._matsMap[matName] then
				render.sharedMaterial = self._matsMap[matName]
			end
		end
	end
end

function WeatherComp:startEffectBlend()
	self._effectStartTime = Time.time

	TaskDispatcher.runRepeat(self._onEffectUpdate, self, 0.033)
end

function WeatherComp:_onEffectUpdate()
	self:_onEffectUpdateHandler(Time.time)
end

function WeatherComp:_onEffectUpdateHandler(curTime)
	local value = (curTime - self._effectStartTime) * self._speed
	local isEnd = value >= 1 or value <= 0
	local target = value

	if isEnd then
		if value > 1 then
			target = 1
		elseif value < 0 then
			target = 0
		end
	end

	if isEnd then
		self._effectStartTime = nil

		TaskDispatcher.cancelTask(self._onEffectUpdate, self)
	end

	self:_changeEffectBlendValue(target, isEnd)
end

function WeatherComp:_changeEffectBlendValue(value, isEnd)
	if not self._rainEffectMat then
		return
	end

	if not self._prevReport then
		local prevReport = self._curReport
		local curReport = self._curReport

		if not prevReport or not curReport then
			logError("WeatherComp _changeEffectBlendValue prevReport or curReport is nil")

			return
		end

		local rainOn = self:_getRainEffectValue(WeatherEnum.RainOn, curReport.effect)
		local rainValue = self:_getRainEffectValue(WeatherEnum.RainValue, curReport.effect)

		if rainOn == 1 then
			self._rainEffectMat:EnableKeyword("_RAIN_ON")
			self._rainEffectMat:SetInt(self._RainId, rainValue)
		elseif isEnd then
			self._rainEffectMat:DisableKeyword("_RAIN_ON")
			self._rainEffectMat:SetInt(self._RainId, rainValue)
		end

		local prevDistortion = self:_getRainEffectValue(WeatherEnum.RainDistortionFactor, prevReport.effect)
		local curDistortion = self:_getRainEffectValue(WeatherEnum.RainDistortionFactor, curReport.effect)
		local lerpDistortion = self:lerpVector4(prevDistortion, curDistortion, value)

		self._rainEffectMat:SetVector(self._RainDistortionFactorId, lerpDistortion)

		local prevEmission = self:_getRainEffectValue(WeatherEnum.RainEmission, prevReport.effect)
		local curEmission = self:_getRainEffectValue(WeatherEnum.RainEmission, curReport.effect)
		local lerpEmission = self:lerpVector4(prevEmission, curEmission, value)

		self._rainEffectMat:SetVector(self._RainEmissionId, lerpEmission)
	end
end

function WeatherComp:_getRainEffectValue(prop, effect)
	return prop[effect] or prop[WeatherEnum.Default]
end

function WeatherComp:startLightBlend()
	self._startTime = Time.time

	TaskDispatcher.runRepeat(self._onUpdate, self, 0.033)
end

function WeatherComp:_onUpdate()
	self:_onUpdateHandler(Time.time)
end

function WeatherComp:_onUpdateHandler(curTime)
	local value = self._startValue + self._deltaValue * (curTime - self._startTime) * self._speed
	local isEnd = value >= 1 or value <= 0
	local target = value

	if isEnd then
		if value > 1 then
			target = 1
		elseif value < 0 then
			target = 0
		end
	end

	if isEnd then
		TaskDispatcher.cancelTask(self._onUpdate, self)

		self._startTime = nil

		self:_updateSceneMatMapCfg()
	end

	self:_changeBlendValue(target, isEnd)
end

function WeatherComp:_updateSceneMatMapCfg()
	local value = self._targetValue

	if value >= 1 then
		self:_setSceneMatMapCfg(0, 1)
	else
		self:_setSceneMatMapCfg(1, 0)
	end
end

function WeatherComp:_setSceneMatMapCfg(useFirst, useSecond)
	if useFirst == 0 and useSecond == 0 then
		logError("useFirst useSecond 不能同时为0！ ")

		return
	end

	for _, mat in pairs(self._rawLightMats) do
		local firstKey = self._UseFirstMapKey

		if useFirst == 1 then
			mat:EnableKeyword(firstKey)
		else
			mat:DisableKeyword(firstKey)
		end

		local secondKey = self._UseSecondMapKey

		if useSecond == 1 then
			mat:EnableKeyword(secondKey)
		else
			mat:DisableKeyword(secondKey)
		end
	end
end

function WeatherComp:_changeBlendValue(value, isEnd)
	for i, v in ipairs(self._rawLightMats) do
		v:SetFloat(ShaderPropertyId.ChangeTexture, value)
	end

	if isEnd then
		self:addAllEffect()
		self:playWeatherVoice()
	end

	self:blendRoleLightMode(value, isEnd)

	if self._behaviourContainer then
		self._behaviourContainer:changeBlendValue(value, isEnd, self._revert)
	end
end

function WeatherComp:blendRoleLightMode(value, isEnd)
	if value ~= self._targetValue then
		if not gohelper.isNil(self._roleSharedMaterial) then
			self._roleSharedMaterial:SetInt(self._UseSecondMapId, 1)
		end
	elseif not gohelper.isNil(self._roleSharedMaterial) then
		self._roleSharedMaterial:SetInt(self._UseSecondMapId, 0)
	end

	if self._revert then
		value = 1 - value
	end

	if self._roleBlendCallback then
		self._roleBlendCallback(self._roleBlendCallbackTarget, self, value, isEnd)
	end

	if not self._roleGo or not self._dispatchParam then
		return
	end

	local _BloomColor = self:lerpColorIntensity(self._srcBloomColor or self._targetBloomColor, self._targetBloomColor, value, true)

	PostProcessingMgr.instance:setLocalBloomColor(_BloomColor)

	local _MainColor = self:lerpColorIntensity(self._srcMainColor or self._targetMainColor, self._targetMainColor, value)

	if not gohelper.isNil(self._roleSharedMaterial) then
		self._roleSharedMaterial:SetColor(self._MainColorId, _MainColor)
	end

	self:_setMainColor(_MainColor)

	local _EmissionColor = self:lerpColorIntensity(self._srcEmissionColor or self._targetEmissionColor, self._targetEmissionColor, value, true)

	if not gohelper.isNil(self._roleSharedMaterial) then
		self._roleSharedMaterial:SetColor(self._EmissionColorId, _EmissionColor)
	end

	if self._lightModel then
		self._lightModel:setEmissionColor(_EmissionColor)
	end

	if self._weatherController then
		self._dispatchParam[1] = value
		self._dispatchParam[2] = isEnd

		self._weatherController:dispatchEvent(WeatherEvent.OnRoleBlend, self._dispatchParam)
	end
end

function WeatherComp:addRoleBlendCallback(callback, callbackTarget)
	self._roleBlendCallback = callback
	self._roleBlendCallbackTarget = callbackTarget
end

function WeatherComp:addChangeReportCallback(callback, callbackTarget, executeCallback)
	self._changeReportCallback = callback
	self._changeReportCallbackTarget = callbackTarget

	if executeCallback then
		self._changeReportCallback(self._changeReportCallbackTarget, self._curReport)
	end
end

function WeatherComp:_setMainColor(color)
	self._mainColor = Color.New(color.r, color.g, color.b, color.a)

	if self._lightModel then
		self._lightModel:setMainColor(color)
	end
end

function WeatherComp:getMainColor()
	return self._mainColor
end

function WeatherComp:lerpColorIntensity(srcColorIntensity, targetColorIntensity, value, lerpWithBlack)
	local srcColor = srcColorIntensity[1]
	local srcIntensity = srcColorIntensity[2]
	local targetColor = targetColorIntensity[1]
	local targetIntensity = targetColorIntensity[2]
	local color
	local intensity = 0

	intensity = value <= 0.5 and Mathf.Lerp(srcIntensity, 0, value / 0.5) or Mathf.Lerp(0, targetIntensity, (value - 0.5) / 0.5)

	return lerpWithBlack and (value <= 0.5 and self:lerpColor(srcColor, self._blackColor, value / 0.5, Mathf.Pow(2, intensity)) or self:lerpColor(self._blackColor, targetColor, (value - 0.5) / 0.5, Mathf.Pow(2, intensity))) or self:lerpColor(srcColor, targetColor, value, Mathf.Pow(2, intensity))
end

function WeatherComp:lerpColor(a, b, t, intensity)
	self._tempColor = self._tempColor or Color.New()
	self._tempColor.r, self._tempColor.g, self._tempColor.b = (a.r + t * (b.r - a.r)) * intensity, (a.g + t * (b.g - a.g)) * intensity, (a.b + t * (b.b - a.b)) * intensity
	self._tempColor.a = intensity

	return self._tempColor
end

function WeatherComp:lerpColorRGBA(a, b, t)
	self._tempColor = self._tempColor or Color.New()
	self._tempColor.r, self._tempColor.g, self._tempColor.b, self._tempColor.a = a.r + t * (b.r - a.r), a.g + t * (b.g - a.g), a.b + t * (b.b - a.b), a.a + t * (b.a - a.a)

	return self._tempColor
end

function WeatherComp:lerpVector4(a, b, t)
	self._tempVector4 = self._tempVector4 or Vector4.New()
	self._tempVector4.x, self._tempVector4.y, self._tempVector4.z, self._tempVector4.w = a.x + t * (b.x - a.x), a.y + t * (b.y - a.y), a.z + t * (b.z - a.z), a.w + t * (b.w - a.w)

	return self._tempVector4
end

function WeatherComp.getEffectAirColor(lightMode, sceneId)
	local targetTintColor
	local config = MainSceneSwitchConfig.instance:getSceneEffect(sceneId, WeatherEnum.EffectTag.EffectAirStartColor)

	if config then
		local color = config["lightColor" .. lightMode]

		targetTintColor = {
			color[1],
			color[2],
			color[3],
			color[4]
		}
	end

	targetTintColor = targetTintColor or WeatherEnum.EffectAirColor[lightMode]

	return targetTintColor
end

function WeatherComp:changeLightEffectColor()
	if not self._effectLightPs or not self._effectAirPs then
		return
	end

	local lightColor = MainSceneSwitchController.getLightColor(self._curReport.lightMode, self._sceneId)
	local airColor = WeatherComp.getEffectAirColor(self._curReport.lightMode, self._sceneId)
	local psHelper = ZProj.ParticleSystemHelper

	psHelper.SetStartColor(self._effectLightPs, lightColor[1] / 255, lightColor[2] / 255, lightColor[3] / 255, lightColor[4] / 255)
	psHelper.SetStartColor(self._effectAirPs, airColor[1] / 255, airColor[2] / 255, airColor[3] / 255, airColor[4] / 255)
	gohelper.setActive(self._effectLightPs, false)
	psHelper.SetStartRotation(self._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(self._curReport.lightMode, self._sceneId))
	gohelper.setActive(self._effectLightPs, true)
end

function WeatherComp:removeAllEffect()
	self:_removeWeatherEffect()
end

function WeatherComp:_removeWeatherEffect()
	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	self._weatherEffectGo = nil

	self:_stopWeatherEffectAudio()
end

function WeatherComp:addAllEffect()
	self:_addWeatherEffect()

	if self._weatherController then
		self._weatherController:dispatchEvent(WeatherEvent.LoadPhotoFrameBg)
	end
end

function WeatherComp:_addWeatherEffect()
	if self._prevReport and self._prevReport.effect == self._curReport.effect then
		self:_setDynamicEffectLightStartRotation()

		return
	end

	if self._curReport.effect <= 1 then
		return
	end

	if not self._effectLoader then
		self._effectLoader = PrefabInstantiate.Create(self._sceneGo)

		local resName = self:_getSceneResName()
		local path = string.format(self._effectPath, resName, self._curReport.effect - 1)

		self._effectLoader:startLoad(path, self._effectLoaded, self)
	end
end

function WeatherComp:_effectLoaded()
	local effect = self._effectLoader:getInstGO()

	effect.transform.parent = self._effectRoot
	self._weatherEffectGo = effect
	self._dynamicEffectLightPs = gohelper.findChildComponent(effect, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)

	self:_setDynamicEffectLightStartRotation()
	self:_playWeatherEffectAudio()
end

function WeatherComp:_setDynamicEffectLightStartRotation()
	if not gohelper.isNil(self._dynamicEffectLightPs) then
		gohelper.setActive(self._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(self._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(self._curReport.lightMode, self._sceneId))
		gohelper.setActive(self._dynamicEffectLightPs, true)
	end
end

function WeatherComp:_playVoice()
	if not self._curReport or GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	local lightMode = WeatherEnum.LightMode[self._curReport.lightMode]
	local effect = WeatherEnum.EffectMode[self._curReport.effect]
	local effectChange = self._prevEffect ~= self._curReport.effect

	self._prevEffect = self._curReport.effect

	if effectChange and effect then
		if not self._isSceneHide then
			audioMgr:setSwitch(self:getId("WeatherState"), self:getId(effect))
		end

		self._curWeatherEffect = effect
		self._curWeatherState = self._curReport.effect
	end

	local lightModeChange = self._prevLightMode ~= self._curReport.lightMode

	self._prevLightMode = self._curReport.lightMode

	if lightModeChange and lightMode then
		if not self._isSceneHide then
			audioMgr:setSwitch(self:getId("Daytimestate"), self:getId(lightMode))
		end

		self._curLightMode = lightMode
	end

	print("===playVoice:", lightMode, lightModeChange, effect, effectChange)
end

function WeatherComp:playWeatherAudio()
	self:_playVoice()
	self:_playWeatherEffectAudio()
end

function WeatherComp:stopWeatherAudio()
	self._prevLightMode = nil
	self._prevEffect = nil
	self._curWeatherEffect = nil
	self._curWeatherState = nil
	self._curLightMode = nil

	self:_stopWeatherEffectAudio()
end

function WeatherComp:setStateByString(stateGroup, stateState)
	audioMgr:setState(self:getId(stateGroup), self:getId(stateState))
end

function WeatherComp:getId(str)
	local id = self._str2Id[str]

	if not id then
		id = audioMgr:getIdFromString(str)
		self._str2Id[str] = id
	end

	return id
end

function WeatherComp:initRoleParam(targetReport)
	local heroId, skinId = CharacterSwitchListModel.instance:getMainHero(self._randomMainHero)

	self._randomMainHero = false

	if not heroId then
		return
	end

	local hero = HeroModel.instance:getByHeroId(heroId)

	if not hero then
		return
	end

	self._blackColor = self._blackColor or Color()
	self._srcBloomColor = self._targetBloomColor
	self._srcMainColor = self._targetMainColor
	self._srcEmissionColor = self._targetEmissionColor
	self._srcBloomFactor = self._targetBloomFactor
	self._srcPercent = self._targetPercent
	self._srcBloomFactor2 = self._targetBloomFactor2
	self._srcLuminance = self._targetLuminance

	local skinCo = SkinConfig.instance:getSkinCo(skinId or hero.skin)

	if skinCo then
		local skinWeatherParam = WeatherConfig.instance:getSkinWeatherParam(skinCo.weatherParam)

		if skinWeatherParam then
			local targetLightMode = targetReport.lightMode

			self._targetBloomColor = self:createColorIntensity(skinWeatherParam["bloomColor" .. targetLightMode])
			self._targetMainColor = self:createColorIntensity(skinWeatherParam["mainColor" .. targetLightMode])
			self._targetEmissionColor = self:createColorIntensity(skinWeatherParam["emissionColor" .. targetLightMode])
			self._targetBloomFactor = WeatherEnum.BloomFactor
			self._targetPercent = WeatherEnum.Percent
			self._targetBloomFactor2 = WeatherEnum.BloomFactor2[targetLightMode]
			self._targetLuminance = WeatherEnum.Luminance[targetLightMode]
		elseif isDebugBuild then
			local skinStr = skinCo and tostring(skinCo.id) or "nil"
			local weatherStr = skinCo and tostring(skinCo.weatherParam) or "nil"

			logError(string.format("skin_%s 天气参数_%s P皮肤表.xlsx-export_皮肤天气颜色参数 未配置", skinStr, weatherStr))
		end
	elseif isDebugBuild then
		local heroStr = tostring(hero.heroId)
		local skinStr = tostring(skinId or hero.skin)

		logError(string.format("hero_%s skin_%s 皮肤id 不存在", heroStr, skinStr))
	end
end

function WeatherComp:createColorIntensity(rgbintensityStr)
	local rgbintensity = string.split(rgbintensityStr, "#")

	if not rgbintensity or #rgbintensity < 4 then
		logError("createColorIntensity rgbintensity error,report id:" .. self._curReport.id .. " rgbintensityStr:" .. rgbintensityStr)

		return {
			Color.New(),
			0
		}
	end

	local r = tonumber(rgbintensity[1]) / 255
	local g = tonumber(rgbintensity[2]) / 255
	local b = tonumber(rgbintensity[3]) / 255
	local intensity = tonumber(rgbintensity[4])
	local c = Color.New(r, g, b)

	return {
		c,
		intensity
	}
end

function WeatherComp:_resGC()
	if self._sceneGo then
		for prefix, v in pairs(self._lightMapPathPrefix) do
			for _, mat in pairs(self._lightMats[prefix]) do
				if not self._revert then
					mat:SetTexture(ShaderPropertyId.MainTex, nil)
				else
					mat:SetTexture(ShaderPropertyId.MainTexSecond, nil)
				end
			end
		end

		if not self._revert then
			if self._srcLoader then
				self._srcLoader:dispose()

				self._srcLoader = nil
			end
		elseif self._targetLoader then
			self._targetLoader:dispose()

			self._targetLoader = nil
		end

		SLFramework.UnityHelper.ResGC()
	end
end

function WeatherComp:_clearMats()
	if not self._rawLightMats then
		return
	end

	for _, mat in pairs(self._rawLightMats) do
		mat:SetTexture(ShaderPropertyId.MainTex, nil)
		mat:SetTexture(ShaderPropertyId.MainTexSecond, nil)
	end
end

function WeatherComp:onSceneShow()
	if self._isSceneHide == false then
		return
	end

	gohelper.setActive(self._sceneGo, true)

	self._isSceneHide = false

	if self._curWeatherEffect then
		audioMgr:setSwitch(self:getId("WeatherState"), self:getId(self._curWeatherEffect))
	end

	if self._curLightMode then
		audioMgr:setSwitch(self:getId("Daytimestate"), self:getId(self._curLightMode))
	end

	self:_playWeatherEffectAudio()
end

function WeatherComp:_playWeatherEffectAudio(isRepeat)
	self:_stopWeatherEffectAudio()

	if self._curWeatherState and not gohelper.isNil(self._weatherEffectGo) then
		local playAudioId = WeatherEnum.EffectPlayAudio[self._curWeatherState]

		if playAudioId and not self._isSceneHide then
			self._stopWeatherEffectAudioId = WeatherEnum.EffectStopAudio[self._curWeatherState]

			audioMgr:trigger(playAudioId)

			if not isRepeat then
				gohelper.setActive(self._weatherEffectGo, false)
				gohelper.setActive(self._weatherEffectGo, true)
			end

			TaskDispatcher.cancelTask(self._repeatPlayEffectAndAudio, self)
			TaskDispatcher.runDelay(self._repeatPlayEffectAndAudio, self, WeatherEnum.EffectAudioTime[self._curWeatherState])
		end
	end
end

function WeatherComp:onSceneHide()
	gohelper.setActive(self._sceneGo, false)

	self._isSceneHide = true

	self:_stopWeatherEffectAudio()
end

function WeatherComp:_stopWeatherEffectAudio()
	if self._stopWeatherEffectAudioId then
		audioMgr:trigger(self._stopWeatherEffectAudioId)

		self._stopWeatherEffectAudioId = nil
	end

	TaskDispatcher.cancelTask(self._repeatPlayEffectAndAudio, self)
end

function WeatherComp:_repeatPlayEffectAndAudio()
	self:_playWeatherEffectAudio(true)
end

function WeatherComp:onSceneClose()
	if self._isMain then
		self:_clearMats()

		self._randomMainHero = true
	end

	if self._srcLoader then
		self._srcLoader:dispose()

		self._srcLoader = nil
	end

	if self._targetLoader then
		self._targetLoader:dispose()

		self._targetLoader = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	TaskDispatcher.cancelTask(self._onUpdate, self)
	TaskDispatcher.cancelTask(self._onEffectUpdate, self)
	TaskDispatcher.cancelTask(self._checkReport, self)
	TaskDispatcher.cancelTask(self._resGC, self)
	TaskDispatcher.cancelTask(self._repeatPlayEffectAndAudio, self)

	self._sceneGo = nil
	self._effectRoot = nil
	self._lightMats = nil
	self._matsMap = nil
	self._lightSwitch = nil
	self._rawLightMats = nil
	self._rainEffectMat = nil
	self._roleGo = nil
	self._roleSharedMaterial = nil
	self._postProcessMask = null
	self._curReport = nil
	self._prevReport = nil
	self._srcReport = nil
	self._targetReport = nil
	self._animator = nil
	self._prevEffect = nil
	self._prevLightMode = nil
	self._curWeatherEffect = nil
	self._curLightMode = nil
	self._curWeatherState = nil
	self._isSceneHide = nil

	self:_stopWeatherEffectAudio()

	self._effectLightPs = nil
	self._effectAirPs = nil
	self._dynamicEffectLightPs = nil
	self._heroPlayWeatherVoice = nil
	self._lightModel = nil
	self._changeRoleParam = nil
	self._roleBlendCallback = nil
	self._roleBlendCallbackTarget = nil
	self._changeReportCallback = nil
	self._changeReportCallbackTarget = nil
	self._weatherEffectGo = nil
	self._startTime = nil
	self._effectStartTime = nil
	self._reportEndTime = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	MainController.instance:unregisterCallback(MainEvent.OnShowSceneNewbieOpen, self._OnShowSceneNewbieOpen, self)
end

return WeatherComp
