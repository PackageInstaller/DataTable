-- chunkname: @modules/logic/scene/room/comp/RoomSceneAmbientComp.lua

module("modules.logic.scene.room.comp.RoomSceneAmbientComp", package.seeall)

local RoomSceneAmbientComp = class("RoomSceneAmbientComp", BaseSceneComp)
local Shader = UnityEngine.Shader
local ShaderIDMap = {
	LIGHTRANGE = Shader.PropertyToID("_LightRange"),
	LIGHTOFFSET = Shader.PropertyToID("_LightOffset"),
	LIGHTPOSITION = Shader.PropertyToID("_LightPosition"),
	LIGHTMAX = Shader.PropertyToID("_LightMax"),
	LIGHTMIN = Shader.PropertyToID("_LightMin"),
	LIGHTCOLA = Shader.PropertyToID("_LightColA"),
	_LightParamOptimize = Shader.PropertyToID("_LightParamOptimize"),
	LIGHTPARAMS = Shader.PropertyToID("_LightParams"),
	BENDING_AMOUNT = Shader.PropertyToID("_Curvature"),
	BENDING_AMOUNT_SCALED = Shader.PropertyToID("_CurvatureScaled"),
	AMBIENTSIZE = Shader.PropertyToID("_AmbientSize"),
	HFLAMBERT = Shader.PropertyToID("_Hflambert"),
	AMBIENTCOL = Shader.PropertyToID("_AmbientCol"),
	_ShadowColor = Shader.PropertyToID("_ShadowColor"),
	SHADOW_PARAMS = Shader.PropertyToID("_ShadowParams"),
	SHADOW_PARAMS_OPT = Shader.PropertyToID("_ShadowParamsOpt"),
	FOGCOLOR = Shader.PropertyToID("_FogColor"),
	FOGCOLOR2 = Shader.PropertyToID("_FogColor2"),
	FOGPARAMS = Shader.PropertyToID("_FogParams"),
	FOGHEIGHT = Shader.PropertyToID("_FogHeight"),
	HEIGHTFOGEDGE = Shader.PropertyToID("_HeightFogEdge"),
	DISFOGSTART = Shader.PropertyToID("_DisFogStart"),
	_DisFogDataAndFogParmasOpt = Shader.PropertyToID("_DisFogDataAndFogParmasOpt"),
	DISFOGEDGE = Shader.PropertyToID("_DisFogEdge"),
	FOGDENSITYMIN = Shader.PropertyToID("_FogDensityMin"),
	FOGDENSITYMAX = Shader.PropertyToID("_FogDensityMax"),
	FOGMAINCOL = Shader.PropertyToID("_MainCol"),
	FOGOUTSIDECOL = Shader.PropertyToID("_OutSideCol"),
	FOGPLANEOUTSIDECOLOR = Shader.PropertyToID("_OutSideColor"),
	FOGPLANEMAINCOLOR = Shader.PropertyToID("_MainColor"),
	FogDensityData = Shader.PropertyToID("_FogDensityData"),
	ADD_RANGE = Shader.PropertyToID("_AddRange")
}

RoomSceneAmbientComp.ShaderIDMap = ShaderIDMap

local KEY_TYPT = {
	vector3 = 3,
	vector4 = 4,
	color = 5,
	vector2 = 2,
	number = 1
}
local Data_KeyTyp_Map = {
	ambientsize = KEY_TYPT.number,
	hflambert = KEY_TYPT.number,
	ambientcol = KEY_TYPT.color,
	outsideShadow = KEY_TYPT.number,
	insideShadow = KEY_TYPT.number,
	shadowColor = KEY_TYPT.color,
	fogColor = KEY_TYPT.color,
	fogColor2 = KEY_TYPT.color,
	fogParams = KEY_TYPT.vector2,
	fogHeight = KEY_TYPT.number,
	heightfogedge = KEY_TYPT.number,
	disfogstart = KEY_TYPT.number,
	disfogedge = KEY_TYPT.number,
	fogdensitymin = KEY_TYPT.number,
	fogdensitymax = KEY_TYPT.number,
	addRange = KEY_TYPT.number,
	dirLightColor = KEY_TYPT.color,
	dirLightIntensity = KEY_TYPT.number,
	lightDir = KEY_TYPT.vector3,
	fogPlaneMainCol = KEY_TYPT.color,
	fogPlaneOutSideCol = KEY_TYPT.color,
	fogMainCol = KEY_TYPT.color,
	fogOutSideCol = KEY_TYPT.color,
	rimcol = KEY_TYPT.color,
	lightRangeNear = KEY_TYPT.number,
	lightRangeFar = KEY_TYPT.number,
	lightOffsetNear = KEY_TYPT.number,
	lightOffsetFar = KEY_TYPT.number,
	cameraDistanceValue = KEY_TYPT.number,
	lightmin = KEY_TYPT.number,
	lightmax = KEY_TYPT.number,
	lightParams = KEY_TYPT.vector2
}
local Scene_Ambient_NightId = "night_1"
local Scene_Ambient_Ids = {
	"day_1",
	"day_2",
	"afternoon",
	"night_1"
}

RoomSceneAmbientComp.Update_Rate_Time = 10
RoomSceneAmbientComp.Switch_Tween_Time = 5

function RoomSceneAmbientComp:onInit()
	return
end

function RoomSceneAmbientComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._matFogPlane = self._scene.go.sceneAmbient.matFogPlane
	self._matFogParticle = self._scene.go.sceneAmbient.matFogParticle
	self._updateRateTime = RoomSceneAmbientComp.Update_Rate_Time
	self._swithchTweenTime = RoomSceneAmbientComp.Switch_Tween_Time

	local str = CommonConfig.instance:getConstStr(ConstEnum.RoomWeatherUpdateTime)

	if not string.nilorempty(str) then
		local nums = string.splitToNumber(str, "#")

		self._updateRateTime = nums[1] or RoomSceneAmbientComp.Update_Rate_Time
		self._swithchTweenTime = nums[2] or 0
	end

	local isAuto = self:_isCanUpdate()

	if self._lastAutoUpdateReport ~= isAuto then
		self._lastAutoUpdateReport = isAuto

		self:reset()
	end
end

function RoomSceneAmbientComp:reset()
	self._ambientId = nil
	self._curDataParams = nil
	self._data = nil
	self._curRoomMode = RoomModel.instance:getGameMode()
	self._ambientIds = {}

	for i, ambientId in ipairs(Scene_Ambient_Ids) do
		if RoomConfig.instance:getSceneAmbientConfig(ambientId) then
			table.insert(self._ambientIds, ambientId)
		end
	end

	TaskDispatcher.cancelTask(self.updateReport, self)
	TaskDispatcher.cancelTask(self._initReport, self)

	if self:_isCanUpdate() then
		TaskDispatcher.runRepeat(self.updateReport, self, self._updateRateTime)
	end

	TaskDispatcher.runDelay(self._initReport, self, 0.1)
end

function RoomSceneAmbientComp:_initReport()
	local index = 1

	if self:_isCanUpdate() then
		local reportConfig, deltaTime = WeatherModel.instance:getReport()

		if reportConfig then
			index = reportConfig.roomMode
		end
	end

	self:tweenToAmbientId(self._ambientIds[index] or self._ambientIds[1])
end

function RoomSceneAmbientComp:_isCanUpdate()
	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		return true
	end

	return false
end

function RoomSceneAmbientComp:updateReport()
	if not self._ambientIds then
		return
	end

	self._ambientIds = self._ambientIds

	local index = tabletool.indexOf(self._ambientIds, self._ambientId) or 0

	index = index + 1

	if index > #self._ambientIds then
		index = 1
	end

	self:tweenToAmbientId(self._ambientIds[index])
end

function RoomSceneAmbientComp:_getKeyTypeFuncMap()
	self._keyTypeFuncMap = self._keyTypeFuncMap or {
		[KEY_TYPT.number] = self._paramToNumber,
		[KEY_TYPT.vector2] = self._paramToVector2,
		[KEY_TYPT.vector3] = self._paramToVector3,
		[KEY_TYPT.vector4] = self._paramToVector4,
		[KEY_TYPT.color] = self._paramToColor
	}

	return self._keyTypeFuncMap
end

function RoomSceneAmbientComp:tweenToAmbientId(ambientId)
	local curAmbientCfg = RoomConfig.instance:getSceneAmbientConfig(ambientId)

	if not curAmbientCfg then
		logError(string.format("room_scene_ambient --> can not find ambientId:[%s]", ambientId))

		return
	end

	self:_killTween()

	self._ambientId = ambientId

	if not self._curDataParams then
		self:_updateData(1, curAmbientCfg, curAmbientCfg)
		self:_nightLight()

		return
	end

	local var_8_0 = {}

	var_8_0.fromAmbientCfg = self:_copyAmbientParam(self._curDataParams or curAmbientCfg)
	var_8_0.toAmbientCfg = curAmbientCfg

	local mps = var_8_0

	if not self._swithchTweenTime then
		self._tweenId = self._scene.tween:tweenFloat(0, 1, self._swithchTweenTime, self._frameCallback, self._finishCallback, self, mps)

		self:_nightLight()
	end
end

function RoomSceneAmbientComp:_killTween()
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end
end

function RoomSceneAmbientComp:_frameCallback(zoom, param)
	self:_updateData(zoom, param.fromAmbientCfg, param.toAmbientCfg)
end

function RoomSceneAmbientComp:_finishCallback(value, param)
	self._tweenId = nil
end

function RoomSceneAmbientComp:_copyAmbientParam(ambientParam)
	local target = {}

	self:_getZoomAmbientParam(1, target, ambientParam, ambientParam)

	return target
end

function RoomSceneAmbientComp:_getZoomAmbientParam(zoom, target, formCfg, toCfg)
	local keyTypeMap = Data_KeyTyp_Map

	for key, key_type in pairs(keyTypeMap) do
		if formCfg[key] ~= nil and toCfg[key] ~= nil then
			if key_type == KEY_TYPT.number then
				self:_zoomToKeyNumber(target, key, zoom, formCfg[key], toCfg[key])
			else
				self:_zoomToKeyTable(target, key, zoom, formCfg[key], toCfg[key])
			end
		end
	end
end

function RoomSceneAmbientComp:_updateData(zoom, fromAmbientCfg, toAmbientCfg)
	if fromAmbientCfg == nil and toAmbientCfg == nil then
		return
	end

	local formCfg = fromAmbientCfg or toAmbientCfg
	local toCfg = toAmbientCfg or fromAmbientCfg

	self._data = self._data or {}
	self._curDataParams = self._curDataParams or {}

	self:_getZoomAmbientParam(zoom, self._curDataParams, formCfg, toCfg)

	local keyTypeMap = Data_KeyTyp_Map
	local keyTypeFuncMap = self:_getKeyTypeFuncMap()

	for key, key_type in pairs(keyTypeMap) do
		if self._curDataParams[key] ~= nil then
			local zoomToFunc = keyTypeFuncMap[key_type]

			if zoomToFunc then
				self._data[key] = zoomToFunc(self, self._curDataParams[key])
			else
				logError(string.format("can not find keyTypeFuncMap[%s]", key_type))
			end
		else
			logError(string.format("can not find key[%s]", key))
		end
	end

	self:applyInspectorParam()
end

function RoomSceneAmbientComp:_zoomToKeyNumber(data, key, zoom, from, to)
	data[key] = self:_zoomToNumber(zoom, from, to)
end

function RoomSceneAmbientComp:_zoomToKeyTable(data, key, zoom, from, to)
	data[key] = data[key] or {}

	local t = data[key]

	for i = 1, #from do
		t[i] = self:_zoomToNumber(zoom, from[i], to[i])
	end
end

function RoomSceneAmbientComp:_zoomToNumber(zoom, from, to)
	if zoom >= 1 then
		return to
	elseif zoom <= 0 then
		return from
	end

	return from + (to - from) * zoom
end

function RoomSceneAmbientComp:_paramToNumber(p)
	return p
end

function RoomSceneAmbientComp:_paramToVector2(p)
	return Vector4(p[1], p[2], 0, 0)
end

function RoomSceneAmbientComp:_paramToVector3(p)
	return Vector4(p[1], p[2], p[3], 0)
end

function RoomSceneAmbientComp:_paramTooVector4(p)
	return Vector4(p[1], p[2], p[3], p[4])
end

function RoomSceneAmbientComp:_paramToColor(p)
	return Color(p[1], p[2], p[3], p[4])
end

function RoomSceneAmbientComp:applyInspectorParam()
	self:_applyShaher()
	self:_applyAmbientData()
	self:_applyLightComp()
	self:_applyFog()
end

function RoomSceneAmbientComp:_applyShaher()
	if not self._data then
		return
	end

	local data = self._data

	Shader.SetGlobalFloat(ShaderIDMap.AMBIENTSIZE, data.ambientsize)
	Shader.SetGlobalFloat(ShaderIDMap.HFLAMBERT, data.hflambert)
	Shader.SetGlobalColor(ShaderIDMap.AMBIENTCOL, data.ambientcol)
	Shader.SetGlobalVector(ShaderIDMap.SHADOW_PARAMS, Vector4(data.outsideShadow, data.insideShadow))
	Shader.SetGlobalVector(ShaderIDMap.SHADOW_PARAMS_OPT, Vector4(data.insideShadow - data.outsideShadow, data.outsideShadow))
	Shader.SetGlobalColor(ShaderIDMap._ShadowColor, data.shadowColor)
	Shader.SetGlobalColor(ShaderIDMap.FOGCOLOR, data.fogColor)
	Shader.SetGlobalColor(ShaderIDMap.FOGCOLOR2, data.fogColor2)
	Shader.SetGlobalVector(ShaderIDMap.FOGPARAMS, data.fogParams)
	Shader.SetGlobalFloat(ShaderIDMap.FOGHEIGHT, data.fogHeight)
	Shader.SetGlobalFloat(ShaderIDMap.HEIGHTFOGEDGE, data.heightfogedge)
	Shader.SetGlobalFloat(ShaderIDMap.DISFOGSTART, data.disfogstart)
	Shader.SetGlobalFloat(ShaderIDMap.DISFOGEDGE, data.disfogedge)
	Shader.SetGlobalFloat(ShaderIDMap.ADD_RANGE, data.addRange)

	local disFogDataX = 1 / data.disfogedge
	local disFogDataY = -data.disfogstart / data.disfogedge
	local fogParamsX = data.fogParams.x
	local fogDis = data.fogParams.y - fogParamsX

	if fogDis ~= 0 then
		if not (1 / fogDis) then
			local fogParamsOptX = fogParamsX
			local fogParamsOptY = -fogParamsX * fogParamsOptX

			Shader.SetGlobalVector(ShaderIDMap._DisFogDataAndFogParmasOpt, Vector4(disFogDataX, disFogDataY, fogParamsOptX, fogParamsOptY))
		end
	end
end

function RoomSceneAmbientComp:_applyAmbientData()
	local ambientData = self._scene.go.sceneAmbientData
	local sceneAmbient = self._scene.go.sceneAmbient
	local data = self._data

	if data and sceneAmbient and ambientData then
		ambientData.rimcol = data.rimcol
		ambientData.lightRangeNear = data.lightRangeNear
		ambientData.lightRangeFar = data.lightRangeFar
		ambientData.lightOffsetNear = data.lightOffsetNear
		ambientData.lightOffsetFar = data.lightOffsetFar
		ambientData.cameraDistanceValue = data.cameraDistanceValue
		ambientData.lightmin = data.lightmin
		ambientData.lightmax = data.lightmax
		ambientData.lightParams = data.lightParams
		sceneAmbient.data = ambientData
	end
end

function RoomSceneAmbientComp:_applyLightComp(data)
	local lightComp = self._scene.light
	local data = self._data

	if lightComp and data then
		lightComp:setLightColor(data.dirLightColor)
		lightComp:setLightIntensity(data.dirLightIntensity)
		lightComp:setLocalRotation(data.lightDir.x, data.lightDir.y, data.lightDir.z)
	end
end

function RoomSceneAmbientComp:_applyFog()
	local data = self._data

	if data then
		if self._matFogParticle then
			self._matFogParticle:SetColor(ShaderIDMap.FOGMAINCOL, data.fogMainCol)
			self._matFogParticle:SetColor(ShaderIDMap.FOGOUTSIDECOL, data.fogOutSideCol)
		end

		if self._matFogPlane then
			self._matFogPlane:SetColor(ShaderIDMap.FOGPLANEMAINCOLOR, data.fogPlaneMainCol)
			self._matFogPlane:SetColor(ShaderIDMap.FOGPLANEOUTSIDECOLOR, data.fogPlaneOutSideCol)
		end
	end
end

function RoomSceneAmbientComp:_nightLight()
	local curIsNight = self._ambientId == Scene_Ambient_NightId

	if RoomWeatherModel.instance:getIsNight() ~= curIsNight then
		RoomWeatherModel.instance:setIsNight(curIsNight)
		RoomMapController.instance:dispatchEvent(RoomEvent.MapEntityNightLight, curIsNight)
	end
end

function RoomSceneAmbientComp:onSceneClose()
	self._matFogParticle = nil
	self._matFogPlane = nil
	self._curRoomMode = nil
	self._lastAutoUpdateReport = nil

	TaskDispatcher.cancelTask(self.updateReport, self)
	TaskDispatcher.cancelTask(self._initReport, self)
	self:_killTween()
end

return RoomSceneAmbientComp
