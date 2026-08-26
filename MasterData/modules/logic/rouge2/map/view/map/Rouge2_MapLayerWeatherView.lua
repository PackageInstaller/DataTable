-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapLayerWeatherView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapLayerWeatherView", package.seeall)

local Rouge2_MapLayerWeatherView = class("Rouge2_MapLayerWeatherView", BaseView)

Rouge2_MapLayerWeatherView.BlockKey = "Rouge2_MapLayerWeatherView"

function Rouge2_MapLayerWeatherView:onInitView()
	self._goWeatherRoot = gohelper.findChild(self.viewGO, "#go_layer_right_bg/#go_WeatherRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapLayerWeatherView:addEvents()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectLayerWeather, self.onSelectLayerWeather, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLayerChange, self.onSelectLayerChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
end

function Rouge2_MapLayerWeatherView:removeEvents()
	return
end

function Rouge2_MapLayerWeatherView:_editableInitView()
	self._weatherItemTab = self:getUserDataTb_()
end

function Rouge2_MapLayerWeatherView:onChangeMapInfo()
	local isPathSelect = Rouge2_MapModel.instance:isPathSelect()

	gohelper.setActive(self._goWeatherRoot, isPathSelect)
end

function Rouge2_MapLayerWeatherView:onSelectLayerChange(layerId)
	self._layerCo = lua_rouge2_layer.configDict[layerId]
	self._selectWeatherId = nil

	self:refreshWeatherBg()
end

function Rouge2_MapLayerWeatherView:onSelectLayerWeather(layerId, weatherId)
	self._preWeatherId = self._selectWeatherId
	self._selectWeatherId = weatherId

	self:refreshWeatherBg()
end

function Rouge2_MapLayerWeatherView:refreshWeatherBg()
	gohelper.setActive(self._goWeatherRoot, self._selectWeatherId ~= nil)

	if not self._selectWeatherId then
		return
	end

	local preWeatherItem = self:_getOrCreateWeatherItem(self._preWeatherId)
	local selectWeatherItem = self:_getOrCreateWeatherItem(self._selectWeatherId)

	self:_destroyFlow()

	self._flow = FlowSequence.New()

	local parallel = FlowParallel.New()

	if preWeatherItem and not preWeatherItem:isLoadDone() then
		parallel:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;OnWeatherLoadDone;" .. self._preWeatherId))
	end

	if selectWeatherItem and not selectWeatherItem:isLoadDone() then
		parallel:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;OnWeatherLoadDone;" .. self._selectWeatherId))
	end

	self._flow:addWork(parallel)

	if preWeatherItem then
		self._flow:addWork(FunctionWork.New(preWeatherItem.playAnim, preWeatherItem, UIAnimationName.Close))
		self._flow:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;OnWeatherAnimDone;" .. self._preWeatherId))
		self._flow:addWork(FunctionWork.New(preWeatherItem.setVisible, preWeatherItem, false))
	end

	if selectWeatherItem then
		self._flow:addWork(FunctionWork.New(selectWeatherItem.playAnim, selectWeatherItem, UIAnimationName.Open))
		self._flow:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;OnWeatherAnimDone;" .. self._selectWeatherId))
	end

	self._flow:start()
end

function Rouge2_MapLayerWeatherView:_lockScreen(lock)
	GameUtil.setActiveUIBlock(Rouge2_MapLayerWeatherView.BlockKey, lock, not lock)
end

function Rouge2_MapLayerWeatherView:_destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapLayerWeatherView:_getOrCreateWeatherItem(weatherId)
	if not weatherId then
		return
	end

	local weatherItem = self._weatherItemTab[weatherId]

	if not weatherItem then
		local goWeather = gohelper.create2d(self._goWeatherRoot, weatherId)

		weatherItem = Rouge2_MapLayerWeatherItem.Get(goWeather, {
			weatherId = weatherId,
			view = self
		})
		self._weatherItemTab[weatherId] = weatherItem
	end

	return weatherItem
end

function Rouge2_MapLayerWeatherView:onClose()
	self:_destroyFlow()
end

function Rouge2_MapLayerWeatherView:onDestroyView()
	self:_lockScreen(false)
end

return Rouge2_MapLayerWeatherView
