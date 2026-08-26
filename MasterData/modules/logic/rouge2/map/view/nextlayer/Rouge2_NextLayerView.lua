-- chunkname: @modules/logic/rouge2/map/view/nextlayer/Rouge2_NextLayerView.lua

module("modules.logic.rouge2.map.view.nextlayer.Rouge2_NextLayerView", package.seeall)

local Rouge2_NextLayerView = class("Rouge2_NextLayerView", BaseView)

function Rouge2_NextLayerView:onInitView()
	self._imageweather = gohelper.findChildImage(self.viewGO, "#image_weather")
	self._txtweather = gohelper.findChildText(self.viewGO, "#txt_weather")
	self._txtweatherdesc = gohelper.findChildText(self.viewGO, "#txt_weatherdesc")
	self._txtplace = gohelper.findChildText(self.viewGO, "#txt_place")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_NextLayerView:addEvents()
	return
end

function Rouge2_NextLayerView:removeEvents()
	return
end

function Rouge2_NextLayerView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onLoadMapDone, self.onLoadMapDone, self)
end

function Rouge2_NextLayerView:onLoadMapDone()
	self.loadDone = true

	self:closeView()
end

function Rouge2_NextLayerView:closeView()
	if not self.loadDone or not self.overMinTime then
		return
	end

	self:closeThis()
end

function Rouge2_NextLayerView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.OpenNextLayerView)

	self.loadDone = not Rouge2_MapModel.instance:checkIsLoading()
	self.overMinTime = false

	if self.viewParam then
		local layerId = self.viewParam.layerId

		if self.viewParam then
			local weatherId = self.viewParam.weatherId

			if self.viewParam then
				local weatherRuleIdList = self.viewParam.weatherRuleIdList
				local layerCo = lua_rouge2_layer.configDict[layerId]
				local weatherCo = Rouge2_MapConfig.instance:getWeatherConfig(weatherId)

				self._txtplace.text = layerCo and layerCo.name
				self._txtweather.text = weatherCo and weatherCo.title
				self._txtweatherdesc.text = Rouge2_MapHelper.getWeatherRuleDesc(weatherRuleIdList)

				Rouge2_IconHelper.setWeatherIcon(weatherId, self._imageweather)
				TaskDispatcher.runDelay(self.onMinTimeDone, self, Rouge2_MapEnum.SwitchLayerMinDuration)
				TaskDispatcher.runDelay(self.onMaxTimeDone, self, Rouge2_MapEnum.SwitchLayerMaxDuration)
			end
		end
	end
end

function Rouge2_NextLayerView:onMinTimeDone()
	self.overMinTime = true

	self:closeView()
end

function Rouge2_NextLayerView:onMaxTimeDone()
	self:closeThis()
end

function Rouge2_NextLayerView:onDestroyView()
	TaskDispatcher.cancelTask(self.onMinTimeDone, self)
	TaskDispatcher.cancelTask(self.onMaxTimeDone, self)
end

return Rouge2_NextLayerView
