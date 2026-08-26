-- chunkname: @modules/logic/weather/controller/WeatherSceneEffectComp.lua

module("modules.logic.weather.controller.WeatherSceneEffectComp", package.seeall)

local WeatherSceneEffectComp = class("WeatherSceneEffectComp")

function WeatherSceneEffectComp:ctor()
	return
end

function WeatherSceneEffectComp:onSceneHide()
	return
end

function WeatherSceneEffectComp:onSceneShow()
	return
end

function WeatherSceneEffectComp:onInit(sceneId, isMainScene)
	self._isMainScene = isMainScene
	self._sceneId = sceneId
end

function WeatherSceneEffectComp:_initSettings()
	self._settingsList = {}

	local config = lua_scene_effect_settings.configDict[self._sceneId]

	if config then
		for i, v in ipairs(config) do
			if string.nilorempty(v.tag) then
				local go = self:getSceneNode(v.path)

				if not gohelper.isNil(go) then
					local render = go:GetComponent(typeof(UnityEngine.Renderer))
					local mat = UnityEngine.Material.Instantiate(render.sharedMaterial)

					render.material = mat

					table.insert(self._settingsList, {
						go = go,
						mat = mat,
						config = v
					})
				else
					logError("WeatherSceneEffectComp can not find go by path:" .. v.path)
				end
			end
		end
	end
end

function WeatherSceneEffectComp:getSceneNode(nodePath)
	return gohelper.findChild(self._sceneGo, nodePath)
end

function WeatherSceneEffectComp:initSceneGo(sceneGo)
	self._sceneGo = sceneGo

	self:_initSettings()
end

function WeatherSceneEffectComp:_getColor(color)
	local c = Color.New()

	c.r = color[1] / 255
	c.g = color[2] / 255
	c.b = color[3] / 255
	c.a = color[4] / 255

	return c
end

function WeatherSceneEffectComp:onRoleBlend(weatherComp, value, isEnd)
	if not self._settingsList then
		return
	end

	if not self._blendParams then
		local curLightMode = weatherComp:getCurLightMode()
		local prevLightMode = weatherComp:getPrevLightMode() or curLightMode

		if not curLightMode then
			return
		end

		self._blendParams = {}

		for i, v in ipairs(self._settingsList) do
			table.insert(self._blendParams, {
				mat = v.mat,
				srcColor = self:_getColor(v.config["lightColor" .. prevLightMode]),
				targetColor = self:_getColor(v.config["lightColor" .. curLightMode]),
				colorKey = UnityEngine.Shader.PropertyToID(v.config.colorKey)
			})
		end
	end

	for i, v in ipairs(self._blendParams) do
		v.mat:SetColor(v.colorKey, weatherComp:lerpColorRGBA(v.srcColor, v.targetColor, value))
	end

	if isEnd then
		self._blendParams = nil
	end
end

function WeatherSceneEffectComp:onSceneClose()
	self._settingsList = nil
end

return WeatherSceneEffectComp
