-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsFurnitureSimpleInfoView.lua

module("logic.extensions.tooltips.component.ToolTipsFurnitureSimpleInfoView", package.seeall)

local M = class("ToolTipsFurnitureSimpleInfoView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtName = self:getText("furniture_info_tips_-1957443965")
	self._txtAtmosphereNameSp = self:getText("furniture_info_tips_-78061603")
	self._txtAtmosphereValSp = self:getText("furniture_info_tips_-1704158558")
	self._imgAtmosphereIconSp = self:getImage("furniture_info_tips_979133994")
	self._txtAtmosphereValNormal = self:getText("furniture_info_tips_-1819014703")
end

function M:destroyUI()
	self._txtName = nil
	self._txtAtmosphereNameSp = nil
	self._txtAtmosphereValSp = nil
	self._imgAtmosphereIconSp = nil
	self._txtAtmosphereValNormal = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	local info = self:getFirstParam()
	local itemId = info.itemId
	local furnitureData = FurnitureData.New({
		count = 1,
		itemId = itemId
	})

	self._txtName.text = furnitureData:getName()

	local spAtmosVal, spAtmosTyp = furnitureData:getCfgSpAtmosValAndTyp()
	local hasSpAtmosphere = spAtmosVal > 0

	if hasSpAtmosphere then
		self._txtAtmosphereNameSp.text = lang(HouseMainEnum.AtmosphereName[spAtmosTyp]) or ""
		self._txtAtmosphereValSp.text = spAtmosVal

		HouseMainUtil.changAtmosphereIcon(self._imgAtmosphereIconSp, spAtmosTyp)
	end

	goutil.setActive(self._txtAtmosphereNameSp.gameObject, hasSpAtmosphere)

	self._txtAtmosphereValNormal.text = furnitureData:getAtmosphere()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
end

return M
