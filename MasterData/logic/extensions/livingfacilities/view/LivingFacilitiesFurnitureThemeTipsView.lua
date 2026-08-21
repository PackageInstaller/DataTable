-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesFurnitureThemeTipsView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesFurnitureThemeTipsView", package.seeall)

local M = class("LivingFacilitiesFurnitureThemeTipsView", ViewComponent)

function M:buildUI()
	local registry = self._viewPresentor._viewElementsRegistry

	self._themeScrollGo = self:getGo("furniture_theme_detail_tips_1379064883")
	self._themeLoopList = LoopListHelper.New(self._themeScrollGo)

	self._themeLoopList:InitListView(0, self._updateThemeCell, self)

	self._closeBtn = self:getBtn("furniture_theme_detail_tips_1395247160")
end

function M:destroyUI()
	self._themeLoopList:Dispose()

	self._themeLoopList = nil
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function M:onEnter()
	self._showerList = {}

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	self._furnitureList = zoneMo:getCurrentZoneFurniture()
	self._themeList = zoneMo:getCurrentZoneFurnitureTheme()

	self._themeLoopList:SetListItemCount(#self._themeList, true)
end

function M:onExit()
	for i, shower in ipairs(self._showerList or {}) do
		shower:onExit()
	end

	self._themeLoopList:ClearCells()
end

function M:_onClickClose()
	self:close()
end

function M:_updateThemeCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._themeLoopList:NewListViewItem("theme_item")
	local themeInfo = self._themeList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LivingFacilitiesFurnitureThemeItemCell)

	shower:setCellData(themeInfo, curIndex, self._furnitureList)
	table.insert(self._showerList, shower)

	return item
end

return M
