-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapLayerRightView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapLayerRightView", package.seeall)

local Rouge2_MapLayerRightView = class("Rouge2_MapLayerRightView", BaseView)

function Rouge2_MapLayerRightView:onInitView()
	self.goPathSelectBg = gohelper.findChild(self.viewGO, "#go_PathSelectBg")
	self.goLayerRightBg = gohelper.findChild(self.viewGO, "#go_layer_right_bg")
	self.goLayerRight = gohelper.findChild(self.viewGO, "#go_layer_right")
	self._simageMap1 = gohelper.findChildSingleImage(self.viewGO, "#go_PathSelectBg/#simage_Map")
	self._simageMap2 = gohelper.findChildSingleImage(self.viewGO, "#go_PathSelectBg/#simage_Map/#simage_Map")
	self._goChoiceList = gohelper.findChild(self.viewGO, "#go_layer_right/#go_ChoiceList")
	self._goChoiceItem = gohelper.findChild(self.viewGO, "#go_layer_right/#go_ChoiceList/#go_ChoiceItem")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layer_right/#btn_next")
	self._btnLast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layer_right/#btn_last")
	self.goStartBg = gohelper.findChild(self.viewGO, "#go_layer_right_bg/#go_layer_bottom/#go_StartBg")
	self.txtStartDesc = gohelper.findChildText(self.viewGO, "#go_layer_right_bg/#go_layer_bottom/#go_StartBg/#txt_StartDesc")
	self.goConfirmBg = gohelper.findChild(self.viewGO, "#go_layer_right_bg/#go_layer_bottom/#go_ConfirmBg")
	self.txtConfirmDesc = gohelper.findChildText(self.viewGO, "#go_layer_right_bg/#go_layer_bottom/#go_ConfirmBg/#txt_ConfirmDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapLayerRightView:addEvents()
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
	self._btnLast:AddClickListener(self._btnLastOnClick, self)
end

function Rouge2_MapLayerRightView:removeEvents()
	self._btnNext:RemoveClickListener()
	self._btnLast:RemoveClickListener()
end

function Rouge2_MapLayerRightView:_btnLastOnClick()
	if self.curSelectIndex <= 1 then
		return
	end

	self.curSelectIndex = self.curSelectIndex - 1

	self:changeSelectLayer()
end

function Rouge2_MapLayerRightView:_btnNextOnClick()
	if self.curSelectIndex >= self.nextLayerLen then
		return
	end

	self.curSelectIndex = self.curSelectIndex + 1

	self:changeSelectLayer()
end

function Rouge2_MapLayerRightView:changeSelectLayer()
	local layerId = self.nextLayerList[self.curSelectIndex]

	Rouge2_MapModel.instance:updateSelectLayerId(layerId)
end

function Rouge2_MapLayerRightView:_editableInitView()
	self.goNextBtn = self._btnNext.gameObject
	self.goLastBtn = self._btnLast.gameObject
	self.layerAnimator = self.goLayerRight:GetComponent(gohelper.Type_Animator)

	self:hide()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectLayerWeather, self.onSelectLayerWeather, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLayerChange, self.onSelectLayerChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onPathSelectMapFocusDone, self.onPathSelectMapFocusDone, self)
end

function Rouge2_MapLayerRightView:onChangeMapInfo()
	local isPathSelect = Rouge2_MapModel.instance:isPathSelect()

	if not isPathSelect then
		self:hide()

		return
	end

	self:initData()
	self:refreshBg()
end

function Rouge2_MapLayerRightView:onSelectLayerChange(layerId)
	self.layerCo = lua_rouge2_layer.configDict[layerId]
	self.selectWeatherId = nil

	self:updateSelectIndex()
	self.layerAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self.refresh, self)
	TaskDispatcher.runDelay(self.refresh, self, Rouge2_MapEnum.WaitMapRightRefreshTime)
end

function Rouge2_MapLayerRightView:onSelectLayerWeather(layerId, weatherId)
	self.selectWeatherId = weatherId

	self:refreshConfirmDesc()
end

function Rouge2_MapLayerRightView:onOpen()
	if not Rouge2_MapModel.instance:isPathSelect() then
		return
	end

	self:initData()
	self:refreshBg()
end

function Rouge2_MapLayerRightView:initData()
	self.nextLayerList = Rouge2_MapModel.instance:getNextLayerList()
	self.nextLayerLen = #self.nextLayerList

	local selectLayerId = Rouge2_MapModel.instance:getSelectLayerId()

	self.layerCo = lua_rouge2_layer.configDict[selectLayerId]

	if not self.layerCo then
		self.nextLayerList = self.nextLayerList or {}

		local middleLayerId = Rouge2_MapModel.instance:getMiddleLayerId()

		logError(string.format("路线层配置不存在 curMiddleLayerId = %s, selectLayerId = %s, nextLayerList = %s, nextLayerLen = %s", middleLayerId, selectLayerId, table.concat(self.nextLayerList, "#"), self.nextLayerLen))
	end

	self:updateSelectIndex()
end

function Rouge2_MapLayerRightView:updateSelectIndex()
	self.curSelectIndex = 1

	for index, nextLayerId in ipairs(self.nextLayerList) do
		if self.layerCo.id == nextLayerId then
			self.curSelectIndex = index
		end
	end
end

function Rouge2_MapLayerRightView:onPathSelectMapFocusDone()
	self:refresh()
	self:initStartDesc()
end

function Rouge2_MapLayerRightView:refresh()
	self:show()
	self:refreshArrow()
	self:refreshChoiceList()
	self:refreshConfirmDesc()
end

function Rouge2_MapLayerRightView:refreshBg()
	local pathSelectCo = Rouge2_MapModel.instance:getPathSelectCo()
	local simageMapPos = string.splitToNumber(pathSelectCo.simageMapPos, "#")
	local mapResList = string.split(pathSelectCo.mapRes, "#")

	self._simageMap1:LoadImage(mapResList[1])
	self._simageMap2:LoadImage(mapResList[2])
	recthelper.setAnchor(self._simageMap1.transform, simageMapPos[1] or 0, simageMapPos[2] or 0)
	gohelper.setActive(self.goPathSelectBg, true)
end

function Rouge2_MapLayerRightView:initStartDesc()
	local pathSelectCo = Rouge2_MapModel.instance:getPathSelectCo()
	local startDesc = pathSelectCo.startDesc

	self.txtStartDesc.text = startDesc

	gohelper.setActive(self.goStartBg, not string.nilorempty(startDesc))
end

function Rouge2_MapLayerRightView:refreshConfirmDesc()
	gohelper.setActive(self.goConfirmBg, false)

	local pathSelectCo = Rouge2_MapModel.instance:getPathSelectCo()
	local confirmDescList = GameUtil.splitString2(pathSelectCo.confirmDesc)

	if confirmDescList then
		for _, confirmInfo in ipairs(confirmDescList) do
			local confirmWeatherId = tonumber(confirmInfo[1])
			local confirmDesc = confirmInfo[2]

			if confirmWeatherId == self.selectWeatherId then
				gohelper.setActive(self.goStartBg, false)
				gohelper.setActive(self.goConfirmBg, true)

				self.txtConfirmDesc.text = confirmDesc

				break
			end
		end
	end
end

function Rouge2_MapLayerRightView:refreshArrow()
	gohelper.setActive(self.goNextBtn, self.curSelectIndex < self.nextLayerLen)
	gohelper.setActive(self.goLastBtn, self.curSelectIndex > 1)
end

function Rouge2_MapLayerRightView:refreshChoiceList()
	local weatherInfoList = self:getSortWeatherInfo()

	gohelper.CreateObjList(self, self._refreshSingleChoiceItem, weatherInfoList, self._goChoiceList, self._goChoiceItem, Rouge2_MapLayerChoiceItem)
end

function Rouge2_MapLayerRightView:getSortWeatherInfo()
	local sortWeatherInfoList = {}
	local markWeatherIdMap = {}
	local weatherInfoMap = Rouge2_MapModel.instance:getNextLayerWeatherInfoMap(self.layerCo.id) or {}
	local sortWeatherIdList = string.splitToNumber(self.layerCo.weather, "#")

	for _, weatherId in ipairs(sortWeatherIdList) do
		local weatherInfo = weatherInfoMap and weatherInfoMap[weatherId]

		if weatherInfo then
			table.insert(sortWeatherInfoList, weatherInfo)

			markWeatherIdMap[weatherId] = true
		end
	end

	for _, weatherInfo in pairs(weatherInfoMap) do
		local weatherId = weatherInfo and weatherInfo:getWeatherId()

		if weatherId and not markWeatherIdMap[weatherId] then
			table.insert(sortWeatherInfoList, weatherInfo)
			logError(string.format("肉鸽天气排序规则错误,服务器推送了layerId = %s, weatherId = %s的天气,但排序字段中不存在", self.layerCo.id, weatherId))
		end
	end

	return sortWeatherInfoList
end

function Rouge2_MapLayerRightView:_refreshSingleChoiceItem(choiceItem, weatherMo, index)
	choiceItem:onUpdateMO(self.layerCo.id, weatherMo, weatherMo:getWeatherId() == self.selectWeatherId)
end

function Rouge2_MapLayerRightView:show()
	gohelper.setActive(self.goLayerRight, true)
	gohelper.setActive(self.goLayerRightBg, true)
	gohelper.setActive(self.goStartBg, true)
	gohelper.setActive(self.goPathSelectBg, true)
end

function Rouge2_MapLayerRightView:hide()
	gohelper.setActive(self.goLayerRight, false)
	gohelper.setActive(self.goLayerRightBg, false)
	gohelper.setActive(self.goStartBg, false)
	gohelper.setActive(self.goPathSelectBg, false)

	self.selectWeatherId = nil
end

function Rouge2_MapLayerRightView:onDestroyView()
	self._simageMap1:UnLoadImage()
	self._simageMap2:UnLoadImage()
	TaskDispatcher.cancelTask(self.refresh, self)
end

return Rouge2_MapLayerRightView
