-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMainTotalAtmosFragmentView.lua

module("logic.extensions.housemain.view.RoomMainTotalAtmosFragmentView", package.seeall)

local M = class("RoomMainTotalAtmosFragmentView", StaticFragmentView)

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
	self:updateAtmosphereData()
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:updateAtmosphereData()
	local atmospheres = LivingFacilitiesZoneModel.instance:getAtmospheres()

	if not self._atmospheres then
		self._atmospheres = {}
	end

	for key, AtmosphereNO in ipairs(atmospheres or {}) do
		local typ = AtmosphereNO.atmosphereType
		local val = AtmosphereNO.value

		self._atmospheres[typ] = val
	end

	self:reflashAtmosphereShow()
end

function M:getAtmosphereData(typ)
	return self._atmospheres[typ] or 0
end

function M:getAtmosphereTotalVal()
	return self:getAtmosphereData(HouseExtension_pb.Atmosphere.NORMAL)
end

function M:reflashAtmosphereShow()
	local totalAtmosphere = self:getAtmosphereTotalVal()

	self._currentLevel = 1
	self._atmosList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosphere)

	for key, value in ipairs(self._atmosList or {}) do
		if totalAtmosphere >= value.rankNum then
			self._currentLevel = value.level
		else
			break
		end
	end

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

	val = self:_formatVal(val, 1)
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

function M:_formatVal(val, numDigits)
	local finalVal = val
	local _, _decimals = math.modf(val)

	if _decimals ~= 0 then
		numDigits = 10^numDigits
		finalVal = MathUtil.roundingBy456(val * numDigits)
		finalVal = finalVal ~= 0 and finalVal / numDigits or finalVal / numDigits
	end

	return finalVal
end

return M
