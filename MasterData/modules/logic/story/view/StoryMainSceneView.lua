-- chunkname: @modules/logic/story/view/StoryMainSceneView.lua

module("modules.logic.story.view.StoryMainSceneView", package.seeall)

local StoryMainSceneView = class("StoryMainSceneView", BaseView)

function StoryMainSceneView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryMainSceneView:addEvents()
	return
end

function StoryMainSceneView:removeEvents()
	return
end

function StoryMainSceneView:_editableInitView()
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
end

function StoryMainSceneView:onOpen()
	return
end

function StoryMainSceneView:onClose()
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
end

function StoryMainSceneView:setSceneId(sceneId)
	self._sceneId = sceneId
end

function StoryMainSceneView:initSceneGo(sceneGo, resName)
	if self._sceneGo then
		return
	end

	self._resName = resName
	self._revert = true
	self._sceneGo = sceneGo
	self._frameBg = self:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	gohelper.setActive(self._frameBg, false)

	local effectRootGo = self:getSceneNode("s01_obj_a/Anim/Effect")

	self._effectRoot = effectRootGo.transform
	self._effectLightPs = gohelper.findChildComponent(effectRootGo, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)
	self._effectAirPs = gohelper.findChildComponent(effectRootGo, "m_s01_effect_air", WeatherComp.TypeOfParticleSystem)
	self._lightSwitch = sceneGo:GetComponent(WeatherComp.TypeOfLightSwitch)

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

		self._lightMats[prefix] = self._lightMats[prefix] or {}

		table.insert(self._lightMats[prefix], mat)
		table.insert(self._rawLightMats, mat)

		self._matsMap[mat.name] = mat

		if string.find(prefix, "m_s01_obj_e$") then
			self._rainEffectMat = mat
		end
	end

	local curReport = lua_weather_report.configDict[2]

	self:setReport(curReport)
end

function StoryMainSceneView:setReport(report)
	if self._curReport and report.id == self._curReport.id then
		return
	end

	self._prevReport = self._curReport
	self._curReport = report
	self.reportLightMode = self._curReport.lightMode

	self:changeLightEffectColor()
	self:startSwitchReport(self._prevReport, self._curReport)
end

function StoryMainSceneView:changeLightEffectColor()
	if not self._effectLightPs or not self._effectAirPs then
		return
	end

	local lightColor = MainSceneSwitchController.getLightColor(self._curReport.lightMode, self._sceneId)
	local airColor = WeatherEnum.EffectAirColor[self._curReport.lightMode]
	local psHelper = ZProj.ParticleSystemHelper

	psHelper.SetStartColor(self._effectLightPs, lightColor[1] / 255, lightColor[2] / 255, lightColor[3] / 255, lightColor[4] / 255)
	psHelper.SetStartColor(self._effectAirPs, airColor[1] / 255, airColor[2] / 255, airColor[3] / 255, airColor[4] / 255)
	gohelper.setActive(self._effectLightPs, false)
	psHelper.SetStartRotation(self._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(self._curReport.lightMode, self._sceneId))
	gohelper.setActive(self._effectLightPs, true)
end

function StoryMainSceneView:startSwitchReport(src, target)
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

function StoryMainSceneView:switchLight(src, target)
	self:_startLoad(src, target)
end

function StoryMainSceneView:_startLoad(src, target)
	TaskDispatcher.cancelTask(self._resGC, self)

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

	local resName = self._resName
	local lightMapPathList = {}
	local srcList = {}
	local targetList = {}

	for prefix, v in pairs(self._lightMats) do
		if not lightMapPathList[prefix] then
			if src then
				local srcPath = string.format(self._lightMapPath, resName, prefix, src)

				table.insert(srcList, srcPath)

				lightMapPathList[prefix][src] = srcPath
			end

			local targetPath = string.format(self._lightMapPath, resName, prefix, target)

			table.insert(targetList, targetPath)

			lightMapPathList[prefix][target] = targetPath
			lightMapPathList[prefix] = lightMapPathList[prefix]
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

	if #targetList > 0 then
		self._targetLoader = MultiAbLoader.New()

		self._targetLoader:setPathList(targetList)
		self._targetLoader:startLoad(self._onLoadOneDone, self)
	end
end

function StoryMainSceneView:_onLoadOneDone()
	self._loadFinishNum = self._loadFinishNum + 1

	if self._loadFinishNum < self._loadMaxNum then
		return
	end

	self:_loadTexturesFinish(self._srcLoader, self._targetLoader, self._lightMapPathPrefix, self._reportSrc, self._reportTarget)
end

function StoryMainSceneView:_loadTexturesFinish(srcLoader, targetLoader, lightMapPathList, src, target)
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

	self:_setSceneMatMapCfg(0, 1)
	self:_changeBlendValue(self._targetValue, true)
	self:_changeEffectBlendValue(1, true)
	self:_resetMats()
end

function StoryMainSceneView:_resetMats()
	self:_resetGoMats(self:getSceneNode("s01_obj_a/Anim/Sky"))
	self:_resetGoMats(self:getSceneNode("s01_obj_a/Anim/Ground"))
	self:_resetGoMats(self:getSceneNode("s01_obj_a/Anim/Obj"))
end

function StoryMainSceneView:_resetGoMats(go)
	local meshRenderer = go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

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

function StoryMainSceneView:_setSceneMatMapCfg(useFirst, useSecond)
	if useFirst == 0 and useSecond == 0 then
		logError("useFirst useSecond 不能同时为0！ ")

		return
	end

	for _, mat in pairs(self._rawLightMats) do
		local firstKey = "_USEFIRSTMAP_ON"

		if useFirst == 1 then
			mat:EnableKeyword(firstKey)
		else
			mat:DisableKeyword(firstKey)
		end

		local secondKey = "_USESECONDMAP_ON"

		if useSecond == 1 then
			mat:EnableKeyword(secondKey)
		else
			mat:DisableKeyword(secondKey)
		end
	end
end

function StoryMainSceneView:_changeBlendValue(value, isEnd)
	for i, v in ipairs(self._rawLightMats) do
		v:SetFloat(ShaderPropertyId.ChangeTexture, value)
	end

	if isEnd then
		self:addAllEffect()
	end
end

function StoryMainSceneView:addAllEffect()
	self:_addWeatherEffect()
end

function StoryMainSceneView:_addWeatherEffect()
	if self._prevReport and self._prevReport.effect == self._curReport.effect then
		self:_setDynamicEffectLightStartRotation()

		return
	end

	if self._curReport.effect <= 1 then
		return
	end

	if not self._effectLoader then
		self._effectLoader = PrefabInstantiate.Create(self._sceneGo)

		local resName = self._resName
		local path = string.format(self._effectPath, resName, self._curReport.effect - 1)

		self._effectLoader:startLoad(path, self._effectLoaded, self)
	end
end

function StoryMainSceneView:_effectLoaded()
	local effect = self._effectLoader:getInstGO()

	effect.transform.parent = self._effectRoot
	self._dynamicEffectLightPs = gohelper.findChildComponent(effect, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)

	self:_setDynamicEffectLightStartRotation()
end

function StoryMainSceneView:_setDynamicEffectLightStartRotation()
	if self._dynamicEffectLightPs then
		gohelper.setActive(self._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(self._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(self._curReport.lightMode, self._sceneId))
		gohelper.setActive(self._dynamicEffectLightPs, true)
	end
end

function StoryMainSceneView:_changeEffectBlendValue(value, isEnd)
	if not self._rainEffectMat then
		return
	end

	if not self._prevReport then
		local prevReport = self._curReport
		local curReport = self._curReport
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

function StoryMainSceneView:_getRainEffectValue(prop, effect)
	return prop[effect] or prop[WeatherEnum.Default]
end

function StoryMainSceneView:lerpVector4(a, b, t)
	self._tempVector4 = self._tempVector4 or Vector4.New()
	self._tempVector4.x, self._tempVector4.y, self._tempVector4.z, self._tempVector4.w = a.x + t * (b.x - a.x), a.y + t * (b.y - a.y), a.z + t * (b.z - a.z), a.w + t * (b.w - a.w)

	return self._tempVector4
end

function StoryMainSceneView:getSceneNode(nodePath)
	return gohelper.findChild(self._sceneGo, nodePath)
end

return StoryMainSceneView
