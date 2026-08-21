-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesBasicAtmosFragmentView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesBasicAtmosFragmentView", package.seeall)

local M = class("LivingFacilitiesBasicAtmosFragmentView", StaticFragmentView)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._txtProgress = self._registry:getText("atmosphere_value_tips_-1409602014")
	self._fillProgress = self._registry:getImage("atmosphere_value_tips_-1388793171")
	self._txtLevel = self._registry:getText("atmosphere_value_tips_-1818721834")
	self._scrollGo = self._registry:getGo("atmosphere_value_tips_-446606271")
	self._loopList = LoopListHelper.New(self._scrollGo)

	self._loopList:InitListView(0, self._updateCell, self)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
	self._scrollGo = nil
	self._txtProgress = nil
	self._fillProgress = nil
	self._txtLevel = nil
	self._atmosList = nil
	self._currentLevel = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._atmosList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosphere)

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local totalAtmosphere = LivingFacilitiesZoneModel.instance:getNormalAtmosphereValue()

	self._currentLevel = LivingFacilitiesZoneModel.instance:getNormalAtmosphereLevel()
	self._txtLevel.text = self._currentLevel

	if self._currentLevel < #self._atmosList then
		local currentMaxAtmosNum = self._atmosList[self._currentLevel + 1].rankNum

		self._txtProgress.text = string.format("<color=#d1d1d1>%s</color>/%s", totalAtmosphere, currentMaxAtmosNum)
		self._fillProgress.fillAmount = math.min(1, totalAtmosphere / currentMaxAtmosNum)
	else
		self._txtProgress.text = string.format("<color=#d1d1d1>%s</color>/MAX", totalAtmosphere)
		self._fillProgress.fillAmount = 1
	end

	self._loopList:SetListItemCount(#self._atmosList, true)
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("atmosphere_item")
	local AtmosInfo = self._atmosList[curIndex]
	local txtAtmosTitle = goutil.findChildTextComponent(item, "Text")
	local txtAtmos = goutil.findChildTextComponent(item, "Text/txtNum1")
	local txtMoodTitle = goutil.findChildTextComponent(item, "Text (1)")
	local txtMood = goutil.findChildTextComponent(item, "Text (1)/txtNum2")
	local txtLevel = goutil.findChildTextComponent(item, "txtValue")

	txtAtmos.text = AtmosInfo.rankNum

	local val = AtmosInfo.moodRecover * 60

	val = LivingFacilitiesZoneController.instance:formatAtmosphereValue(val, 1)
	txtMood.text = string.format("+%s/h", val)
	txtLevel.text = AtmosInfo.level

	local normal = goutil.findChild(item, "normal")
	local select = goutil.findChild(item, "select")

	goutil.setActive(select, curIndex == self._currentLevel)
	goutil.setActive(normal, curIndex ~= self._currentLevel)

	local colorStr = curIndex == self._currentLevel and "#d1d1d1" or "#737373"

	txtAtmosTitle.color = parsecolor(colorStr)
	txtAtmos.color = parsecolor(colorStr)
	txtMoodTitle.color = parsecolor(colorStr)
	txtMood.color = parsecolor(colorStr)

	return item
end

return M
