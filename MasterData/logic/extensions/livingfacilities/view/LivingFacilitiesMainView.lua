-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesMainView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesMainView", package.seeall)

local M = class("LivingFacilitiesMainView", ViewComponent)

function M:buildUI()
	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._entryPanel = self:getGo("0&room_live_entry_panel_-70813481")
	self._entryPanelView = Astral.LuaComponentContainer.Add(self._entryPanel, LivingFacilitiesEntryPanelView)
	self._furniturePanel = self:getGo("3&room_live_furniture_panel_638923001")
	self._furniturePanelView = Astral.LuaComponentContainer.Add(self._furniturePanel, LivingFacilitiesFurniturePanelView)
	self._infoTips = self:getGo("room_live_entry_view_-1218967831")
	self._infoTipsView = Astral.LuaComponentContainer.Add(self._infoTips, LivingFacilitiesInfoTipsView)

	self._infoTipsView:setRegistry(self._registry)

	self._btnReturn = self:getBtn("2&title_view_-878360263")
	self._btnHome = self:getBtn("2&title_view_1398742689")
	self._btnClick = self:getBtn("1&empty_mask_tips_29887572")
	self._btnAtmos = self:getBtn("room_live_entry_view_-1089792011")
	self._atmosNum = self:getText("room_live_entry_view_-308255904")
	self._greenNum = self:getText("room_live_entry_view_207468559")
	self._specialGo = self:getGo("room_live_entry_view_910430124")
	self._specialIcon = self:getImage("room_live_entry_view_391275577")
	self._defaultGo = self:getGo("room_live_entry_view_703669263")
	self._editGo = self:getGo("room_live_entry_view_-2110697920")
	self._hintPanelView = Astral.LuaComponentContainer.Add(self._editGo, LivingFacilitiesHintPanelView)

	self._hintPanelView:setRegistry(self._registry)

	self._btnHideUI = self._registry:findUIElement("room_live_entry_view_-1624628372", UIComponentType.SpaceXToggle)
	self._txtName = self:getText("2&title_view_-788888785")
	self._txtLevel = goutil.findChildTextComponent(self._txtName.gameObject, "txtLevel")
end

function M:destroyUI()
	self._entryPanel = nil
	self._furniturePanel = nil
	self._infoTips = nil
	self._btnReturn = nil
	self._btnHome = nil
	self._btnClick = nil
	self._btnAtmos = nil
	self._btnHideUI = nil

	self._registry:cleanRegistry()

	self._registry = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnClick:AddClickListener(self._onClickClick, self)
	self._btnAtmos:AddClickListener(self._onClickAtmos, self)
	self._btnHideUI:AddListener(self._onClickBtnHideUI, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnAtmos:RemoveClickListener()
	self._btnHideUI:RemoveListener()
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_CLOTH_OPEN, self._openCloth, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_INFO_OPEN, self._openInfo, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshInfo, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVING_ZONE_NAME_CHANGE, self._refreshInfo, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_HIDE_ALL_UI, self._hideAllUI, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OP_VIEW_OPEN, self._editViewOpen, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_PAPER_CHANGE, self._refreshAtmosInfo, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self._refreshAtmosInfo, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_CLOTH_OPEN, self._openCloth, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_INFO_OPEN, self._openInfo, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshInfo, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVING_ZONE_NAME_CHANGE, self._refreshInfo, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_HIDE_ALL_UI, self._hideAllUI, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_OP_VIEW_OPEN, self._editViewOpen, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_PAPER_CHANGE, self._refreshAtmosInfo, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self._refreshAtmosInfo, self)
	end
end

function M:onEnter()
	goutil.setActive(self._infoTips, false)
	self._entryPanelView:onEnter()
	self._furniturePanelView:onEnter()
	self._hintPanelView:onEnter()
	self._infoTipsView:onEnter()
	self:_setEvent(true)
	self:_refreshInfo()
end

function M:onExit(closeReasonType)
	self:_setEvent(false)
	self._entryPanelView:onExit()
	self._furniturePanelView:onExit()
	self._hintPanelView:onExit()
	self._infoTipsView:onExit()

	if closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
	end
end

function M:_onClickReturn()
	if HouseFacade.instance:isEditingFurniture() then
		self:_exitEditFurniture()
	else
		self:back()
	end
end

function M:_exitEditFurniture()
	local canSave = HouseFurnitureModel.instance:canSaveFurniture()

	if canSave then
		local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_live_furniture_lang_4"))

		dialog:setConfirmListener(function()
			LivingFacilitiesFurnitureController.instance:saveFurnituresRequest()
			self:_closeCloth()
			HouseDispatcher:dispatchEvent(HouseEventType.LIVE_CLOTH_CLOSE)
		end, self)
		dialog:setCancelListener(function()
			self:_exitEditWithoutSave()
		end, self)
	else
		self:_exitEditWithoutSave()
	end
end

function M:_exitEditWithoutSave()
	self:_closeCloth()
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REVOKE_ALL)
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_CLOTH_CLOSE)
end

function M:_onClickHome()
	HouseMainFacade.instance:onClickHome()
end

function M:_onClickClick()
	goutil.setActive(self._infoTips, false)
end

function M:_onClickAtmos()
	if self._infoTips.activeSelf then
		goutil.setActive(self._infoTips, false)
	else
		self:_openInfo()
	end
end

function M:_openCloth()
	goutil.setActive(self._entryPanel, false)
	goutil.setActive(self._infoTips, false)
	goutil.setActive(self._furniturePanel, true)
	goutil.setActive(self._btnHideUI.gameObject, false)
	self._furniturePanelView:resetClickTab()
end

function M:_closeCloth()
	goutil.setActive(self._entryPanel, true)
	goutil.setActive(self._infoTips, false)
	goutil.setActive(self._furniturePanel, false)
	goutil.setActive(self._btnHideUI.gameObject, true)
end

function M:_openInfo()
	if HouseFacade.instance:isEditingFurniture() then
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REVOKE_ALL)
		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_CLOTH_CLOSE)
	end

	goutil.setActive(self._entryPanel, true)
	goutil.setActive(self._infoTips, true)
	goutil.setActive(self._furniturePanel, false)
end

function M:_refreshInfo(e, zoneId)
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo then
		self:_refreshAtmosInfo()

		if zoneMo:getType() ~= 0 then
			self._txtName.text = zoneMo:getName()
		else
			self._txtName.text = zoneMo:getDefaultName()
		end

		self._txtLevel.text = string.format("Lv.%s", zoneMo:getAtmosphereLevel())
	end
end

function M:_editViewOpen(e, isOpen)
	if not isOpen then
		self:_refreshAtmosInfo()
	end
end

function M:_refreshAtmosInfo()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if not zoneMo then
		return
	end

	local furnitureList = HouseFacade.instance:getCurrFurnitureDatas(zoneMo:getId()) or {}
	local funitureAtmos = 0
	local funitureGreen = 0
	local themeList = {}

	for i, furnitureData in ipairs(furnitureList) do
		local furnitureId = furnitureData.furnitureId
		local co = BackpackConfig.instance:getItemInfoByItemId(furnitureId)

		funitureAtmos = funitureAtmos + co.atmosphere

		local list = co.atmosphereSpecial or {}
		local atmosphereSpecialNum = 0

		if zoneMo:getType() > 2 and zoneMo:getType() == list[1] then
			atmosphereSpecialNum = list[2] or 0
		end

		funitureGreen = funitureGreen + atmosphereSpecialNum
		themeList[co.theme] = themeList[co.theme] or {}

		if not table.indexof(themeList[co.theme], co.group) then
			table.insert(themeList[co.theme], co.group)
		end
	end

	for theme, list in pairs(themeList) do
		local count = #list
		local themeMo = LivingFacilitiesFurniThemeModel.instance:getThemeMoById(theme)
		local atmos = themeMo:getEffectNumByCount(count)

		funitureAtmos = funitureAtmos + atmos
	end

	if funitureAtmos > zoneMo:getAtmosphere() then
		self._atmosNum.text = string.format("%d+%d", zoneMo:getAtmosphere(), funitureAtmos - zoneMo:getAtmosphere())
	elseif funitureAtmos < zoneMo:getAtmosphere() then
		self._atmosNum.text = string.format("%d-%d", zoneMo:getAtmosphere(), zoneMo:getAtmosphere() - funitureAtmos)
	else
		self._atmosNum.text = zoneMo:getAtmosphere()
	end

	if zoneMo:getTypeName() then
		goutil.setActive(self._specialGo, true)

		if funitureGreen > zoneMo:getAtmosphereSpecial() then
			self._greenNum.text = string.format("%d+%d", zoneMo:getAtmosphereSpecial(), funitureGreen - zoneMo:getAtmosphereSpecial())
		elseif funitureGreen < zoneMo:getAtmosphereSpecial() then
			self._greenNum.text = string.format("%d-%d", zoneMo:getAtmosphereSpecial(), zoneMo:getAtmosphereSpecial() - funitureGreen)
		else
			self._greenNum.text = zoneMo:getAtmosphereSpecial()
		end

		HouseMainUtil.changAtmosphereIcon(self._specialIcon, zoneMo:getAtmosType())
	else
		goutil.setActive(self._specialGo, false)
	end

	goutil.setActive(self._btnAtmos.gameObject, zoneMo:getType() ~= 0)
end

function M:_hideAllUI(e, isHide, isEdit)
	goutil.setActive(self._defaultGo, isHide)
	goutil.setActive(self._btnHideUI.gameObject, not HouseFacade.instance:isEditingFurniture() or not isHide and not isEdit)

	if self._btnHideUI.IsOn ~= isHide then
		self._btnHideUI.IsOn = isHide
	end

	goutil.setActive(self._editGo, not isHide and isEdit)
end

function M:_onClickBtnHideUI()
	LivingFacilitiesZoneController.instance:hideAllUI(self._btnHideUI.IsOn)
end

return M
