-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapLayerWeatherItem.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapLayerWeatherItem", package.seeall)

local Rouge2_MapLayerWeatherItem = class("Rouge2_MapLayerWeatherItem", LuaCompBase)

function Rouge2_MapLayerWeatherItem.Get(go, params)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapLayerWeatherItem, params)
end

function Rouge2_MapLayerWeatherItem:ctor(params)
	self._weatherId = params and params.weatherId
	self._view = params and params.view
	self._weatherCo = Rouge2_MapConfig.instance:getWeatherConfig(self._weatherId)
	self._prefabUrl = self._weatherCo.pathSelectWeatherUrl
end

function Rouge2_MapLayerWeatherItem:init(go)
	self.go = go
	self._isLoadDone = false
	self._loader = PrefabInstantiate.Create(self.go)

	self._loader:startLoad(self._prefabUrl, self._onLoadDone, self)
end

function Rouge2_MapLayerWeatherItem:addEventListeners()
	return
end

function Rouge2_MapLayerWeatherItem:removeEventListeners()
	return
end

function Rouge2_MapLayerWeatherItem:_onLoadDone(loader)
	self._goWeather = loader:getInstGO()
	self._animator = SLFramework.AnimatorPlayer.Get(self._goWeather)
	self._isLoadDone = true

	self:setVisible(false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnWeatherLoadDone, self._weatherId)
end

function Rouge2_MapLayerWeatherItem:playAnim(animName)
	if not self._isLoadDone then
		return
	end

	self:setVisible(true)
	self._animator:Play(animName, self._onPlayAnimDone, self)
end

function Rouge2_MapLayerWeatherItem:_onPlayAnimDone()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnWeatherAnimDone, self._weatherId)
end

function Rouge2_MapLayerWeatherItem:isLoadDone()
	return self._isLoadDone
end

function Rouge2_MapLayerWeatherItem:setVisible(isVisible)
	gohelper.setActive(self._goWeather, isVisible)
end

function Rouge2_MapLayerWeatherItem:onDestroy()
	self._loader = nil
end

return Rouge2_MapLayerWeatherItem
