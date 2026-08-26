-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapLayerChoiceItem.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapLayerChoiceItem", package.seeall)

local Rouge2_MapLayerChoiceItem = class("Rouge2_MapLayerChoiceItem", LuaCompBase)

function Rouge2_MapLayerChoiceItem:init(go)
	self.go = go
	self._goSelected = gohelper.findChild(self.go, "go_Selected")
	self._imageIcon = gohelper.findChildImage(self.go, "go_Selected/image_Icon")
	self._txtWeather = gohelper.findChildText(self.go, "go_Selected/txt_Weather")
	self._txtDesc = gohelper.findChildText(self.go, "go_Selected/scroll_Desc/Viewport/Content/txt_Desc")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "go_Selected/btn_Click", AudioEnum.Rouge2.SelectWeather)
	self._goUnSelected = gohelper.findChild(self.go, "go_UnSelected")
	self._imageIcon2 = gohelper.findChildImage(self.go, "go_UnSelected/image_Icon")
	self._txtWeather2 = gohelper.findChildText(self.go, "go_UnSelected/txt_Weather")
	self._txtDesc2 = gohelper.findChildText(self.go, "go_UnSelected/scroll_Desc/Viewport/Content/txt_Desc")
	self._btnClick2 = gohelper.findChildButtonWithAudio(self.go, "go_UnSelected/btn_Click", AudioEnum.Rouge2.SelectWeather)
end

function Rouge2_MapLayerChoiceItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClick2OnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectLayerWeather, self._onSelectLayerWeather, self)
end

function Rouge2_MapLayerChoiceItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
end

function Rouge2_MapLayerChoiceItem:_btnClickOnClick()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onConfirmSelectLayer, self._layerId, self._weatherId)
end

function Rouge2_MapLayerChoiceItem:_btnClick2OnClick()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectLayerWeather, self._layerId, self._weatherId)
end

function Rouge2_MapLayerChoiceItem:onUpdateMO(layerId, weatherMo, isSelect)
	self._layerId = layerId
	self._weatherMo = weatherMo
	self._weatherId = weatherMo and weatherMo:getWeatherId()
	self._weatherRuleIdList = weatherMo and weatherMo:getWeatherRuleIdList()
	self._weatherCo = Rouge2_MapConfig.instance:getWeatherConfig(self._weatherId)

	Rouge2_IconHelper.setWeatherIcon(self._weatherId, self._imageIcon, Rouge2_MapEnum.WeatherIconSuffix.PathSelect)
	Rouge2_IconHelper.setWeatherIcon(self._weatherId, self._imageIcon2, Rouge2_MapEnum.WeatherIconSuffix.PathSelect)

	local weatherRuleDesc = Rouge2_MapHelper.getWeatherRuleDesc(self._weatherRuleIdList)

	self._txtDesc.text = weatherRuleDesc
	self._txtDesc2.text = weatherRuleDesc
	self._txtWeather.text = self._weatherCo and self._weatherCo.title
	self._txtWeather2.text = self._weatherCo and self._weatherCo.title

	self:onSelect(isSelect)
	self:setUse(true)
end

function Rouge2_MapLayerChoiceItem:setUse(isUse)
	self._isUse = isUse

	gohelper.setActive(self.go, isUse)
end

function Rouge2_MapLayerChoiceItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelected, isSelect)
	gohelper.setActive(self._goUnSelected, not isSelect)
end

function Rouge2_MapLayerChoiceItem:_onSelectLayerWeather(layerId, weatherId)
	if not self._isUse then
		return
	end

	local isSelect = self._layerId == layerId and self._weatherId == weatherId

	self:onSelect(isSelect)
end

return Rouge2_MapLayerChoiceItem
