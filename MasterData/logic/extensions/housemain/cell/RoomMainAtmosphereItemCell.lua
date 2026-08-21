-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomMainAtmosphereItemCell.lua

module("logic.extensions.housemain.cell.RoomMainAtmosphereItemCell", package.seeall)

local M = class("RoomMainAtmosphereItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "icon")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "txtLv")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "txtNum")
end

function M:destroyUI()
	self.mainGO = nil
	self._imgIcon = nil
	self._txtName = nil
	self._txtLv = nil
	self._txtNum = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setTyp(typ)
	self._txtName.text = lang(HouseMainEnum.AtmosphereName[typ])

	HouseMainUtil.changAtmosphereIcon(self._imgIcon, typ)
end

function M:setLv(lv)
	self._txtLv.text = lv
end

function M:setValue(val)
	self._txtNum.text = val
end

return M
