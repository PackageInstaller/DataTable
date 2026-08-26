-- chunkname: @modules/logic/weather/controller/WeatherFrameComp.lua

module("modules.logic.weather.controller.WeatherFrameComp", package.seeall)

local WeatherFrameComp = class("WeatherFrameComp")

function WeatherFrameComp:ctor()
	local _shader = UnityEngine.Shader

	self._TintColorId = _shader.PropertyToID("_TintColor")
end

function WeatherFrameComp:onInit(sceneId)
	self._sceneId = sceneId
end

function WeatherFrameComp:getSceneNode(nodePath)
	return gohelper.findChild(self._sceneGo, nodePath)
end

function WeatherFrameComp:initSceneGo(sceneGo)
	self._sceneGo = sceneGo

	self:_initFrame()
	self:loadPhotoFrameBg()
end

function WeatherFrameComp:_initFrame()
	self._frameBg = nil
	self._frameSpineNode = nil
	self._frameBg = self:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not self._frameBg then
		logError("_initFrame no frameBg")
	end

	gohelper.setActive(self._frameBg, false)

	local bgRenderer = self._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	self._frameBgMaterial = UnityEngine.Material.Instantiate(bgRenderer.sharedMaterial)
	bgRenderer.material = self._frameBgMaterial
end

function WeatherFrameComp.getFramePath(sceneId)
	local frameBg = 0
	local sceneConfig = lua_scene_switch.configDict[sceneId]
	local resName = sceneConfig.resName

	return (string.format("scenes/dynamic/%s/lightmaps/%s_back_a_%s.tga", resName, string.gsub(resName, "_zjm_a", ""), frameBg))
end

function WeatherFrameComp:loadPhotoFrameBg()
	local loader = MultiAbLoader.New()

	self._photoFrameBgLoader = loader

	local path = WeatherFrameComp.getFramePath(self._sceneId)

	loader:addPath(path)
	loader:startLoad(function()
		local assetItem = loader:getAssetItem(path)
		local texture = assetItem:GetResource(path)

		self._frameBgMaterial:SetTexture("_MainTex", texture)
		gohelper.setActive(self._frameBg, true)
	end)
end

function WeatherFrameComp.getFrameColor(sceneId, lightMode)
	local targetTintColor
	local config = MainSceneSwitchConfig.instance:getSceneEffect(sceneId, WeatherEnum.EffectTag.Frame)

	if config then
		local color = config["lightColor" .. lightMode]

		targetTintColor = {
			color[1] / 255,
			color[2] / 255,
			color[3] / 255,
			color[4] / 255
		}
	end

	targetTintColor = targetTintColor or WeatherEnum.FrameTintColor[lightMode]

	return Color.New(targetTintColor[1], targetTintColor[2], targetTintColor[3], targetTintColor[4])
end

function WeatherFrameComp:onRoleBlend(weatherComp, value, isEnd)
	if not self._targetFrameTintColor then
		local curLightMode = weatherComp:getCurLightMode()
		local prevLightMode = weatherComp:getPrevLightMode() or curLightMode

		if not curLightMode then
			return
		end

		self._targetFrameTintColor = WeatherFrameComp.getFrameColor(self._sceneId, curLightMode)
		self._srcFrameTintColor = WeatherFrameComp.getFrameColor(self._sceneId, prevLightMode)

		self._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	self._frameBgMaterial:SetColor(self._TintColorId, weatherComp:lerpColorRGBA(self._srcFrameTintColor, self._targetFrameTintColor, value))

	if isEnd then
		local alphaValue = self._targetFrameTintColor.a

		self._targetFrameTintColor = nil

		if weatherComp:getCurLightMode() == 1 and alphaValue and alphaValue <= 0 then
			self._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function WeatherFrameComp:onSceneClose()
	if self._photoFrameBgLoader then
		self._photoFrameBgLoader:dispose()

		self._photoFrameBgLoader = nil
	end
end

return WeatherFrameComp
