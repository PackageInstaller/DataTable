-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapWeatherView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapWeatherView", package.seeall)

local Rouge2_MapWeatherView = class("Rouge2_MapWeatherView", BaseView)

function Rouge2_MapWeatherView:onInitView()
	self._goWeather = gohelper.findChild(self.viewGO, "Top/#go_Weather")
	self._imageWeather = gohelper.findChildImage(self.viewGO, "Top/#go_Weather/#image_Weather")
	self._btnOpenWeatherTips = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#go_Weather/#btn_OpenWeatherTips")
	self._goWeatherTips = gohelper.findChild(self.viewGO, "#go_WeatherTips")
	self._btnCloseWeatherTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_WeatherTips/#btn_CloseWeatherTips")
	self._txtWeatherTips = gohelper.findChildText(self.viewGO, "#go_WeatherTips/bg/#txt_WeatherTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapWeatherView:addEvents()
	self._btnOpenWeatherTips:AddClickListener(self._btnOpenWeatherTipsOnClick, self)
	self._btnCloseWeatherTips:AddClickListener(self._btnCloseWeatherTipsOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
end

function Rouge2_MapWeatherView:removeEvents()
	self._btnOpenWeatherTips:RemoveClickListener()
	self._btnCloseWeatherTips:RemoveClickListener()
end

function Rouge2_MapWeatherView:_btnOpenWeatherTipsOnClick()
	gohelper.setActive(self._goWeatherTips, true)
end

function Rouge2_MapWeatherView:_btnCloseWeatherTipsOnClick()
	gohelper.setActive(self._goWeatherTips, false)
end

function Rouge2_MapWeatherView:_editableInitView()
	gohelper.setActive(self._goWeatherTips, false)
end

function Rouge2_MapWeatherView:onOpen()
	self:refreshWeather()
end

function Rouge2_MapWeatherView:refreshWeather()
	local isNormalLayer = Rouge2_MapModel.instance:isNormalLayer()

	gohelper.setActive(self._goWeather, isNormalLayer)
	gohelper.setActive(self._btnOpenWeatherTips.gameObject, isNormalLayer)

	if not isNormalLayer then
		gohelper.setActive(self._goWeatherTips, false)

		return
	end

	local weatherMo = Rouge2_MapModel.instance:getCurMapWeatherInfo()
	local weatherId = weatherMo and weatherMo:getWeatherId()
	local weatherRuleIdList = weatherMo and weatherMo:getWeatherRuleIdList()

	self._txtWeatherTips.text = Rouge2_MapHelper.getWeatherRuleDesc(weatherRuleIdList)

	Rouge2_IconHelper.setWeatherIcon(weatherId, self._imageWeather)
end

function Rouge2_MapWeatherView:onChangeMapInfo()
	self:refreshWeather()
end

function Rouge2_MapWeatherView:onClose()
	return
end

function Rouge2_MapWeatherView:onDestroyView()
	return
end

return Rouge2_MapWeatherView
