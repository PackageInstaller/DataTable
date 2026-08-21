-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/item/AirBuildingItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.item.AirBuildingItem", package.seeall)

local M = class("AirBuildingItem", UIReusableLuaBehavior)
local kEnableColor = "#FFFFFFFF"
local kDisableColor = "#FFFFFF66"

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgIcon")

	local goClick = goutil.findChild(self.mainGO, "btnClick")

	self._transform = self.mainGO.transform
	self._btnClick = Astral.ButtonAdapter.Get(goClick)
	self._handler = false
	self._buildingCO = false
	self._enable = false
end

function M:onDestroy()
	self:destroyUI()
end

function M:destroyUI()
	self._btnClick:RemoveClickListener()

	self._transform = nil
	self._btnClick = nil
	self._btnDrag = nil
	self._imgIcon = nil
	self._handler = false
	self._enable = false
end

function M:onEnter()
	local transform = self.mainGO.transform
end

function M:onExit()
	self._handler = false

	IconLoader.clearSprite(self._imgIcon)
end

function M:setBuildingCO(buildingCO)
	self._buildingCO = buildingCO

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, buildingCO.icon)
end

function M:setEnable(enable)
	self._enable = enable
end

function M:getBuildingId()
	return self._buildingCO.id
end

function M:setHandler(handler)
	self._handler = handler
end

function M:_onClickIcon()
	if not self:_checkEnable() then
		return
	end

	self._handler:onClickHeadItem(self)
end

function M:_checkEnable()
	if self._enable then
		return true
	end
end

return M
