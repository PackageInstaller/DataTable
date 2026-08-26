-- chunkname: @modules/logic/scene/survival/util/SurvivalSceneAmbientUtil.lua

module("modules.logic.scene.survival.util.SurvivalSceneAmbientUtil", package.seeall)

local SurvivalSceneAmbientUtil = class("SurvivalSceneAmbientUtil")
local Shader = UnityEngine.Shader
local ShaderIDMap = RoomSceneAmbientComp.ShaderIDMap

function SurvivalSceneAmbientUtil:_onLightLoaded(lightGo, isUseShelterAmbient)
	if not lightGo then
		return
	end

	local lights = lightGo:GetComponentsInChildren(typeof(UnityEngine.Light))

	for i = 0, lights.Length - 1 do
		local light = lights[i]

		if light.type == UnityEngine.LightType.Directional then
			self._light = light
			self._lightTrans = self._light.transform

			break
		end
	end

	if not self._light then
		logError("没有平行光")
	end

	self._sceneAmbient = lightGo:GetComponentInChildren(typeof(ZProj.SceneAmbient))
	self._sceneAmbientData = self._sceneAmbient and self._sceneAmbient.data
	self._matFogPlane = self._sceneAmbient and self._sceneAmbient.matFogPlane
	self._matFogParticle = self._sceneAmbient and self._sceneAmbient.matFogParticle

	if isUseShelterAmbient == nil then
		isUseShelterAmbient = SurvivalMapHelper.instance:isUseShelterAmbient()
	end

	self:initData(isUseShelterAmbient)
	self:updateSceneAmbient(isUseShelterAmbient)
end

function SurvivalSceneAmbientUtil:disable()
	self:killTween()

	self._light = nil
	self._lightTrans = nil
	self._data = nil
	self._fromData = nil
	self._toData = nil
	self._configs = nil
end

function SurvivalSceneAmbientUtil:initData(isUseShelterAmbient)
	self._configs = {}
	self._tempV2 = Vector2()
	self._tempV4 = Vector4()
	self._tempColor = Color()

	local Scene_Ambient_Ids

	if isUseShelterAmbient then
		Scene_Ambient_Ids = {
			"sur_day3",
			"sur_day",
			"sur_day2",
			"sur_night"
		}
	else
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local mode = sceneMo.sceneProp.mode

		Scene_Ambient_Ids = mode == 0 and {
			"sur_day",
			"sur_day2"
		} or {
			"sur_night",
			"sur_day3"
		}
	end

	for k, v in ipairs(Scene_Ambient_Ids) do
		local curAmbientCfg = RoomConfig.instance:getSceneAmbientConfig(v)

		if not curAmbientCfg then
			logError("配置不存在" .. v)
		else
			table.insert(self._configs, curAmbientCfg)
		end
	end
end

function SurvivalSceneAmbientUtil:TrV2(data)
	self._tempV2:Set(unpack(data))

	return self._tempV2
end

function SurvivalSceneAmbientUtil:TrV4(data)
	self._tempV4:Set(unpack(data))

	return self._tempV4
end

function SurvivalSceneAmbientUtil:V4(...)
	self._tempV4:Set(...)

	return self._tempV4
end

function SurvivalSceneAmbientUtil:TrColor(data)
	self._tempColor:Set(unpack(data))

	return self._tempColor
end

function SurvivalSceneAmbientUtil:updateSceneAmbient(isUseShelterAmbient)
	if isUseShelterAmbient then
		self._data = self._configs[1]

		self:applyData()
	else
		if not self._configs or not self._configs[2] then
			return
		end

		self:calcData()

		if not self._data then
			self._data = self:simpleCopy(self._toData, self._data)

			self:applyData()
		else
			self._fromData = self:simpleCopy(self._data, self._fromData)

			self:killTween()

			self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, SurvivalConst.PlayerMoveSpeed, self._onTweenFrame, self._onTweenEnd, self, nil, EaseType.Linear)
		end
	end
end

function SurvivalSceneAmbientUtil:applyData()
	self:applyShaher()
	self:applyAmbient()
	self:applyLight()
	self:applyFog()
end

function SurvivalSceneAmbientUtil:killTween()
	if not self._tweenId then
		return
	end

	ZProj.TweenHelper.KillById(self._tweenId)

	self._tweenId = nil
end

function SurvivalSceneAmbientUtil:_onTweenFrame(value)
	self._data = self:lerpVal(value, self._fromData, self._toData, self._data)

	self:applyData()
end

function SurvivalSceneAmbientUtil:_onTweenEnd()
	self._tweenId = nil
end

function SurvivalSceneAmbientUtil:calcData()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local curTime = sceneMo.gameTime - sceneMo.addTime
	local totalTime = sceneMo.currMaxGameTime - sceneMo.addTime
	local dtTime = totalTime / (#self._configs - 1)
	local index = math.ceil(curTime / dtTime)

	index = Mathf.Clamp(index, 1, #self._configs - 1)

	local nextIndex = index + 1
	local value = (curTime - (index - 1) * dtTime) / dtTime
	local fromConfig, toConfig = self._configs[index], self._configs[nextIndex]

	self._toData = self:lerpVal(value, fromConfig, toConfig, self._toData)
end

function SurvivalSceneAmbientUtil:lerpVal(value, from, to, data)
	if type(from) == "table" then
		data = data or {}

		for k in pairs(from) do
			data[k] = self:lerpVal(value, from[k], to[k], data[k])
		end

		return data
	elseif type(from) == "number" then
		return Mathf.Lerp(from, to, value)
	end
end

function SurvivalSceneAmbientUtil:simpleCopy(fromVal, toVal)
	if type(fromVal) == "table" then
		toVal = toVal or {}

		for k, v in pairs(fromVal) do
			toVal[k] = self:simpleCopy(v, toVal[k])
		end

		return toVal
	else
		return fromVal
	end
end

function SurvivalSceneAmbientUtil:applyShaher()
	if not self._data then
		return
	end

	Shader.SetGlobalFloat(ShaderIDMap.AMBIENTSIZE, self._data.ambientsize)
	Shader.SetGlobalFloat(ShaderIDMap.HFLAMBERT, self._data.hflambert)
	Shader.SetGlobalColor(ShaderIDMap.AMBIENTCOL, self:TrColor(self._data.ambientcol))
	Shader.SetGlobalVector(ShaderIDMap.SHADOW_PARAMS, self:V4(self._data.outsideShadow, self._data.insideShadow))
	Shader.SetGlobalVector(ShaderIDMap.SHADOW_PARAMS_OPT, self:V4(self._data.insideShadow - self._data.outsideShadow, self._data.outsideShadow))
	Shader.SetGlobalColor(ShaderIDMap._ShadowColor, self:TrColor(self._data.shadowColor))
	Shader.SetGlobalColor(ShaderIDMap.FOGCOLOR, self:TrColor(self._data.fogColor))
	Shader.SetGlobalColor(ShaderIDMap.FOGCOLOR2, self:TrColor(self._data.fogColor2))
	Shader.SetGlobalVector(ShaderIDMap.FOGPARAMS, self:TrV4(self._data.fogParams))
	Shader.SetGlobalFloat(ShaderIDMap.FOGHEIGHT, self._data.fogHeight)
	Shader.SetGlobalFloat(ShaderIDMap.HEIGHTFOGEDGE, self._data.heightfogedge)
	Shader.SetGlobalFloat(ShaderIDMap.DISFOGSTART, self._data.disfogstart)
	Shader.SetGlobalFloat(ShaderIDMap.DISFOGEDGE, self._data.disfogedge)
	Shader.SetGlobalFloat(ShaderIDMap.ADD_RANGE, self._data.addRange)

	local disFogDataX = 1 / self._data.disfogedge
	local disFogDataY = -self._data.disfogstart / self._data.disfogedge
	local fogParams = self:TrV4(self._data.fogParams)
	local fogParamsX = fogParams.x
	local fogDis = fogParams.y - fogParamsX

	if fogDis ~= 0 then
		if not (1 / fogDis) then
			local fogParamsOptX = fogParamsX
			local fogParamsOptY = -fogParamsX * fogParamsOptX

			Shader.SetGlobalVector(ShaderIDMap._DisFogDataAndFogParmasOpt, self:V4(disFogDataX, disFogDataY, fogParamsOptX, fogParamsOptY))
		end
	end
end

function SurvivalSceneAmbientUtil:applyAmbient()
	if not self._sceneAmbient or not self._data or not self._sceneAmbientData then
		return
	end

	self._sceneAmbientData.rimcol = self:TrColor(self._data.rimcol)
	self._sceneAmbientData.lightRangeNear = self._data.lightRangeNear
	self._sceneAmbientData.lightRangeFar = self._data.lightRangeFar
	self._sceneAmbientData.lightOffsetNear = self._data.lightOffsetNear
	self._sceneAmbientData.lightOffsetFar = self._data.lightOffsetFar
	self._sceneAmbientData.cameraDistanceValue = self._data.cameraDistanceValue
	self._sceneAmbientData.lightmin = self._data.lightmin
	self._sceneAmbientData.lightmax = self._data.lightmax
	self._sceneAmbientData.lightParams = self:TrV2(self._data.lightParams)
	self._sceneAmbient.data = self._sceneAmbientData
end

function SurvivalSceneAmbientUtil:applyLight()
	if not self._light or not self._data then
		return
	end

	self._light.color = self:TrColor(self._data.dirLightColor)
	self._light.intensity = self._data.dirLightIntensity

	local v3 = self:TrV4(self._data.lightDir)

	transformhelper.setLocalRotation(self._lightTrans, v3.x, v3.y, v3.z)
end

function SurvivalSceneAmbientUtil:applyFog()
	if not self._data then
		return
	end

	if self._matFogParticle then
		self._matFogParticle:SetColor(ShaderIDMap.FOGMAINCOL, self:TrColor(self._data.fogMainCol))
		self._matFogParticle:SetColor(ShaderIDMap.FOGOUTSIDECOL, self:TrColor(self._data.fogOutSideCol))
	end

	if self._matFogPlane then
		self._matFogPlane:SetColor(ShaderIDMap.FOGPLANEMAINCOLOR, self:TrColor(self._data.fogPlaneMainCol))
		self._matFogPlane:SetColor(ShaderIDMap.FOGPLANEOUTSIDECOLOR, self:TrColor(self._data.fogPlaneOutSideCol))
	end
end

SurvivalSceneAmbientUtil.instance = SurvivalSceneAmbientUtil.New()

return SurvivalSceneAmbientUtil
