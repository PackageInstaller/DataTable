-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesInfoTipsView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesInfoTipsView", package.seeall)

local M = class("LivingFacilitiesInfoTipsView")
local kPosX1 = 49
local kPosX2 = 37
local kPosX3 = 183.5

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
end

function M:setRegistry(registry)
	self._registry = registry

	self:_buildUI()
end

function M:_buildUI()
	self._btnDetails = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_entry_view_957538912"))
	self._furnitureAllAtmosText = self._registry:findUIElement("room_live_entry_view_2108335959", UIComponentType.Text)
	self._furnitureAllGreenText = self._registry:findUIElement("room_live_entry_view_1254361363", UIComponentType.Text)
	self._themeAllAtmosText = self._registry:findUIElement("room_live_entry_view_-2051613857", UIComponentType.Text)
	self._allAtmosText = self._registry:findUIElement("room_live_entry_view_1148687588", UIComponentType.Text)
	self._allGreenText = self._registry:findUIElement("room_live_entry_view_-1175341121", UIComponentType.Text)
	self._furnitureScrollGo = self._registry:findUIElement("room_live_entry_view_-366730610")
	self._furnitureLoopList = LoopListHelper.New(self._furnitureScrollGo)

	self._furnitureLoopList:InitListView(0, self._updateFurnitureCell, self)

	self._themeScrollGo = self._registry:findUIElement("room_live_entry_view_361776113")
	self._themeLoopList = LoopListHelper.New(self._themeScrollGo)

	self._themeLoopList:InitListView(0, self._updateThemeCell, self)

	self._commonItem = self._registry:findUIElement("room_live_entry_view_115827563")
	self._specialIcon1 = self._registry:findUIElement("room_live_entry_view_-1119428714", UIComponentType.Image)
	self._specialText1 = self._registry:findUIElement("room_live_entry_view_-1610323266", UIComponentType.Text)
	self._specialIcon2 = self._registry:findUIElement("room_live_entry_view_2066050629", UIComponentType.Image)
	self._specialText2 = self._registry:findUIElement("room_live_entry_view_2006016371", UIComponentType.Text)
	self._specialGoList = {
		self._specialText2.gameObject,
		self._allGreenText.gameObject,
		self._furnitureAllGreenText.gameObject
	}
end

function M:_bindEvents()
	self._btnDetails:AddClickListener(self._clickDetails, self)
end

function M:_unbindEvents()
	self._btnDetails:RemoveClickListener()
end

function M:onEnter()
	self:_bindEvents()
	self:_setEvent(true)
	self:refreshView()
	self:_refreshInfo()
end

function M:onExit()
	self:_setEvent(false)
	self:_unbindEvents()
	self._furnitureLoopList:ClearCells()
	self._themeLoopList:ClearCells()
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self.refreshView, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_PAPER_CHANGE, self.refreshView, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self.refreshView, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self.refreshView, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_PAPER_CHANGE, self.refreshView, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self.refreshView, self)
	end
end

function M:refreshSpecialGo(status)
	for i, go in ipairs(self._specialGoList) do
		goutil.setActive(go, status)
	end
end

function M:refreshView()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	self._furnitureList = HouseFacade.instance:getCurrFurnitureDatas(zoneMo:getId()) or {}
	self._themeList = {}
	self._isSpecial = zoneMo:getTypeName() ~= false

	self:refreshSpecialGo(self._isSpecial)

	local funitureAtmos = 0
	local funitureGreen = 0
	local themeList = {}

	for i, furnitureData in ipairs(self._furnitureList) do
		local furnitureId = furnitureData.furnitureId
		local co = BackpackConfig.instance:getItemInfoByItemId(furnitureId)

		funitureAtmos = funitureAtmos + co.atmosphere

		local list = co.atmosphereSpecial or {}
		local atmosphereSpecialNum = 0

		if zoneMo:getType() > 2 and zoneMo:getType() == list[1] then
			atmosphereSpecialNum = list[2] or 0
		end

		funitureGreen = funitureGreen + atmosphereSpecialNum

		if co.theme > 0 then
			themeList[co.theme] = themeList[co.theme] or {}

			if not table.indexof(themeList[co.theme], co.group) then
				table.insert(themeList[co.theme], co.group)
			end
		end
	end

	self._furnitureAllAtmosText.text = funitureAtmos

	if self._isSpecial then
		self._furnitureAllGreenText.text = funitureGreen
	end

	local allAtmos = 0

	for theme, list in pairs(themeList) do
		local count = #list
		local themeMo = LivingFacilitiesFurniThemeModel.instance:getThemeMoById(theme)
		local atmos = themeMo:getEffectNumByCount(count)

		allAtmos = allAtmos + atmos

		local themeInfo = {
			themeMo = themeMo,
			name = themeMo:getName(),
			num = atmos,
			count = count,
			fillCount = themeMo:getFullCount()
		}

		table.insert(self._themeList, themeInfo)
	end

	self._themeAllAtmosText.text = allAtmos
	self._allAtmosText.text = zoneMo:getAtmosphere()

	if self._isSpecial then
		Astral.TransformUtil.SetLocalPosX(self._furnitureAllAtmosText.gameObject.transform, kPosX2)
		Astral.TransformUtil.SetLocalPosX(self._commonItem.gameObject.transform, kPosX1)

		self._allGreenText.text = zoneMo:getAtmosphereSpecial()
		self._specialText1.text = string.format("%s值", zoneMo:getTypeName())
		self._specialText2.text = string.format("%s值", zoneMo:getTypeName())

		HouseMainUtil.changAtmosphereIcon(self._specialIcon1, zoneMo:getAtmosType())
		HouseMainUtil.changAtmosphereIcon(self._specialIcon2, zoneMo:getAtmosType())
	else
		Astral.TransformUtil.SetLocalPosX(self._furnitureAllAtmosText.gameObject.transform, kPosX3)
		Astral.TransformUtil.SetLocalPosX(self._commonItem.gameObject.transform, kPosX3)
	end

	self._furnitureLoopList:SetListItemCount(#self._furnitureList, true)
	self._themeLoopList:SetListItemCount(#self._themeList, true)
	self._themeLoopList:RefreshAllShownItem()
	self._themeLoopList:MoveToItemIndex(0)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._furnitureLoopList:Dispose()

	self._furnitureLoopList = nil

	self._themeLoopList:Dispose()

	self._themeLoopList = nil
	self._btnDetails = nil
	self._furnitureAllAtmosText = nil
	self._furnitureAllGreenText = nil
	self._themeAllAtmosText = nil
	self._allAtmosText = nil
	self._allGreenText = nil
end

function M:_updateFurnitureCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._furnitureLoopList:NewListViewItem("txt_item")
	local furnitureInfo = self._furnitureList[curIndex]
	local furnitureId = furnitureInfo.furnitureId
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local txtFurnitureName = goutil.findChildTextComponent(item, "txtFurnitureName")
	local txtAtmosphere = goutil.findChildTextComponent(item, "txtAtmosphere")
	local txtGreenery = goutil.findChildTextComponent(item, "txtGreenery")
	local co = BackpackConfig.instance:getItemInfoByItemId(furnitureId)

	txtFurnitureName.text = co.name
	txtAtmosphere.text = co.atmosphere

	goutil.setActive(txtGreenery.gameObject, self._isSpecial)

	if self._isSpecial then
		local list = co.atmosphereSpecial or {}
		local atmosphereSpecialNum = 0

		if zoneMo:getType() > 2 and zoneMo:getType() == list[1] then
			atmosphereSpecialNum = list[2] or 0
		end

		txtGreenery.text = atmosphereSpecialNum

		Astral.TransformUtil.SetLocalPosX(txtAtmosphere.gameObject.transform, kPosX2)
	else
		Astral.TransformUtil.SetLocalPosX(txtAtmosphere.gameObject.transform, kPosX3)
	end

	return item
end

function M:_updateThemeCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._themeLoopList:NewListViewItem("txt_item")
	local themeInfo = self._themeList[curIndex]
	local txtThemeName = goutil.findChildTextComponent(item, "txtThemeName")
	local txtAtmosphere = goutil.findChildTextComponent(item, "txtAtmosphere")
	local txtKind = goutil.findChildTextComponent(item, "txtKind")

	txtThemeName.text = themeInfo.name

	local mo = themeInfo.themeMo
	local effectNum = mo:getEffectNumByCount(themeInfo.count)

	txtAtmosphere.text = effectNum
	txtKind.text = string.format("%d/%d", themeInfo.count, themeInfo.fillCount)

	return item
end

function M:_clickDetails()
	ViewMgr.instance:open(ViewName.LivingFacilitiesFurnitureThemeTips)
end

function M:_refreshInfo(e, zoneId)
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo then
		self._allAtmosText.text = zoneMo:getAtmosphere()
		self._allGreenText.text = zoneMo:getAtmosphereSpecial()
	end
end

return M
