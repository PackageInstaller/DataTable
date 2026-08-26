-- chunkname: @modules/logic/weather/controller/behaviour/WeatherDayNightChange.lua

module("modules.logic.weather.controller.behaviour.WeatherDayNightChange", package.seeall)

local WeatherDayNightChange = class("WeatherDayNightChange", WeatherBaseBehaviour)

function WeatherDayNightChange:onDestroy()
	if self._nightLightMapLoader then
		self._nightLightMapLoader:dispose()

		self._nightLightMapLoader = nil
	end
end

function WeatherDayNightChange:setLightMats(lightMats)
	self._dayMats = {}
	self._nightMats = {}

	for i = 0, lightMats.Length - 1 do
		local rawMat = lightMats[i]

		if string.find(rawMat.name, "_colorchange_day") then
			table.insert(self._dayMats, rawMat)
		elseif string.find(rawMat.name, "_colorchange_night") then
			table.insert(self._nightMats, rawMat)
		end
	end

	self:_loadNightLightMap()
end

function WeatherDayNightChange:init(go)
	self._sceneGo = go
	self._lightMapPath = "scenes/dynamic/%s/lightmaps/%s_%s.tga"
end

function WeatherDayNightChange:_loadNightLightMap()
	if self._nightLightMapLoader then
		return
	end

	local lightMapList = {}

	for k, mat in pairs(self._nightMats) do
		local resName = self._sceneConfig.resName
		local path = string.format(self._lightMapPath, resName, WeatherHelper.getNightResourcePrefix(mat.name), WeatherEnum.LightModeNight - 1)

		table.insert(lightMapList, path)
	end

	self._nightLightMapLoader = MultiAbLoader.New()

	self._nightLightMapLoader:setPathList(lightMapList)
	self._nightLightMapLoader:startLoad(self._loadNightLightMapCallback, self)
end

function WeatherDayNightChange:_loadNightLightMapCallback()
	for k, mat in pairs(self._nightMats) do
		local resName = self._sceneConfig.resName
		local path = string.format(self._lightMapPath, resName, WeatherHelper.getNightResourcePrefix(mat.name), WeatherEnum.LightModeNight - 1)
		local assetItem = self._nightLightMapLoader:getAssetItem(path)
		local texture = assetItem:GetResource(path)

		mat:SetTexture(ShaderPropertyId.MainTex, texture)
	end
end

function WeatherDayNightChange:_setMatsAlpha(mats, alpha)
	if not mats then
		return
	end

	for i, mat in pairs(mats) do
		local color = MaterialUtil.GetMainColor(mat)

		if color then
			color.a = alpha

			MaterialUtil.setMainColor(mat, color)
		end
	end
end

function WeatherDayNightChange:_onReportChange()
	self._curIsNight = self._curReport.lightMode == WeatherEnum.LightModeNight
	self._prevIsNight = self._prevReport and self._prevReport.lightMode == WeatherEnum.LightModeNight

	if not self._prevReport and self._curReport then
		if self._curIsNight then
			self:_setMatsAlpha(self._nightMats, 1)
			self:_setMatsAlpha(self._dayMats, 0)
		else
			self:_setMatsAlpha(self._nightMats, 0)
			self:_setMatsAlpha(self._dayMats, 1)
		end
	end
end

function WeatherDayNightChange:changeBlendValue(value, isEnd, revert)
	if not self._curIsNight and not self._prevIsNight then
		return
	end

	if self._curIsNight and self._prevIsNight then
		return
	end

	if revert then
		value = 1 - value
	end

	if self._curIsNight then
		self:_setMatsAlpha(self._nightMats, value)
		self:_setMatsAlpha(self._dayMats, 1 - value)
	else
		self:_setMatsAlpha(self._nightMats, 1 - value)
		self:_setMatsAlpha(self._dayMats, value)
	end
end

return WeatherDayNightChange
