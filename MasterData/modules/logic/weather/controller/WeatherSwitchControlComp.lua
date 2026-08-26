-- chunkname: @modules/logic/weather/controller/WeatherSwitchControlComp.lua

module("modules.logic.weather.controller.WeatherSwitchControlComp", package.seeall)

local WeatherSwitchControlComp = class("WeatherSwitchControlComp", ListScrollCellExtend)

function WeatherSwitchControlComp:onInitView()
	self._btnup = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_up")
	self._goexpand = gohelper.findChild(self.viewGO, "#go_expand")
	self._gonumitem = gohelper.findChild(self.viewGO, "#go_expand/go_numitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_expand/#btn_close")
	self._btnmiddle = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_middle")
	self._middleicon = gohelper.findChildImage(self.viewGO, "#btn_middle/icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#btn_middle/icon/#txt_num")
	self._btndown = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_down")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeatherSwitchControlComp:addEvents()
	self._btnup:AddClickListener(self._btnupOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnmiddle:AddClickListener(self._btnmiddleOnClick, self)
	self._btndown:AddClickListener(self._btndownOnClick, self)
end

function WeatherSwitchControlComp:removeEvents()
	self._btnup:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnmiddle:RemoveClickListener()
	self._btndown:RemoveClickListener()
end

function WeatherSwitchControlComp:_btncloseOnClick()
	gohelper.setActive(self._goexpand, false)
end

function WeatherSwitchControlComp:_btnupOnClick()
	self._switchComp:switchPrevLightMode()
	self:_updateBtnStatus()
	self:_startDelayUpdateStatus()
end

function WeatherSwitchControlComp:_btnmiddleOnClick()
	self._showExpand = true

	gohelper.setActive(self._goexpand, true)

	local reportList = self._switchComp:getReportList()

	for i, v in ipairs(reportList) do
		if not self._itemList[i] then
			local go = gohelper.cloneInPlace(self._gonumitem, i)

			self:_onItemShow(go, v, i)
		else
			local item = self._itemList[i]

			gohelper.setActive(item and item.go, true)
		end
	end

	for i = #reportList + 1, #self._itemList do
		local item = self._itemList[i]

		gohelper.setActive(item and item.go, false)
	end

	self:_updateItemSelectStatus()
end

function WeatherSwitchControlComp:_onItemShow(obj, data, index)
	local txt = gohelper.findChildText(obj, "#txt_num")

	txt.text = index

	local selectGo = gohelper.findChild(obj, "select")
	local btn = gohelper.findChildButtonWithAudio(obj, "#btn_click")

	btn:AddClickListener(self._btnclickOnClick, self, index)

	self._itemList[index] = {
		go = obj,
		selectGo = selectGo,
		btn = btn
	}

	gohelper.setActive(obj, true)
	gohelper.setActive(selectGo, false)
	gohelper.setSiblingAfter(obj, self._gonumitem)
end

function WeatherSwitchControlComp:_btnclickOnClick(index)
	gohelper.setActive(self._goexpand, false)

	local reportIndex = self._switchComp:getReportIndex()

	if reportIndex == index then
		return
	end

	self._switchComp:switchReport(index)
end

function WeatherSwitchControlComp:_btndownOnClick()
	self._switchComp:switchNextLightMode()
	self:_updateBtnStatus()
	self:_startDelayUpdateStatus()
end

function WeatherSwitchControlComp:_updateBtnStatus()
	if not self._switchComp then
		return
	end

	local lightMode = self._switchComp:getLightMode()

	self._txtnum.text = self._switchComp:getReportIndex()
	self._btnup.button.interactable = lightMode ~= 1
	self._btndown.button.interactable = lightMode ~= 4

	UISpriteSetMgr.instance:setStoreGoodsSprite(self._middleicon, self._iconMap[lightMode])
	self:_updateItemSelectStatus()
end

function WeatherSwitchControlComp:_updateItemSelectStatus()
	local reportIndex = self._switchComp:getReportIndex()

	for i, v in ipairs(self._itemList) do
		gohelper.setActive(v.selectGo, i == reportIndex)
	end
end

function WeatherSwitchControlComp:_editableInitView()
	gohelper.setActive(self._goexpand, false)
	gohelper.setActive(self._gonumitem, false)
	gohelper.setActive(self._btnclose, false)

	self._itemList = self:getUserDataTb_()
	self._iconMap = {
		[WeatherEnum.LightModeDuring] = "store_weathericon_01",
		[WeatherEnum.LightModeOvercast] = "store_weathericon_03",
		[WeatherEnum.LightModeDusk] = "store_weathericon_02",
		[WeatherEnum.LightModeNight] = "store_weathericon_04"
	}
	self._cdTime = CommonConfig.instance:getConstNum(ConstEnum.MainSceneChangeCD) / 1000

	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouch, self)
end

function WeatherSwitchControlComp:_startDelayUpdateStatus()
	self._btnup.button.interactable = false
	self._btndown.button.interactable = false

	TaskDispatcher.cancelTask(self._delayUpdateStatus, self)
	TaskDispatcher.runDelay(self._delayUpdateStatus, self, self._cdTime)
end

function WeatherSwitchControlComp:_delayUpdateStatus()
	self:_updateBtnStatus()
end

function WeatherSwitchControlComp:_onTouch()
	if self._showExpand then
		self._showExpand = false

		return
	end

	gohelper.setActive(self._goexpand, false)
end

function WeatherSwitchControlComp:_editableAddEvents()
	return
end

function WeatherSwitchControlComp:_editableRemoveEvents()
	return
end

function WeatherSwitchControlComp:updateScene(id, controller)
	if self._switchComp then
		self._switchComp:removeReportChangeCallback()

		self._switchComp = nil
	end

	self._switchComp = controller:getSwitchComp(id)

	gohelper.setActive(self.viewGO, self._switchComp ~= nil)

	if not self._switchComp then
		return
	end

	self._switchComp:addReportChangeCallback(self._updateBtnStatus, self)
	self:_updateBtnStatus()
end

function WeatherSwitchControlComp:onDestroyView()
	self._switchComp = nil

	for i, v in ipairs(self._itemList) do
		v.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self._delayUpdateStatus, self)
end

return WeatherSwitchControlComp
