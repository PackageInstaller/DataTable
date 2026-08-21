-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/RoomOrderIconItem.lua

module("logic.extensions.house.view.common.RoomOrderIconItem", package.seeall)

local M = class("RoomOrderIconItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:_buildUI()
	self._goNone = goutil.findChild(self._mainGO, "imgNone")
	self._goNormal = goutil.findChild(self._mainGO, "normal")
	self._imgIcon = goutil.findChildImageComponent(self._goNormal, "icon")
	self._goLock = goutil.findChild(self._mainGO, "lock")
	self._imgIcon2 = goutil.findChildImageComponent(self._goLock, "icon")
	self._goTxtRoot = goutil.findChild(self._mainGO, "imgDi")
	self._txtNum = goutil.findChildTextComponent(self._goTxtRoot, "txtNum")
	self._txtNum.text = ""
	self._txtName = goutil.findChildTextComponent(self._mainGO, "txtName")
	self._txtName.text = ""

	self:bindEvents()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:setNone(isNone)
	goutil.setActive(self._goNone, isNone)
	goutil.setActive(self._goNormal, not isNone)
	goutil.setActive(self._goTxtRoot, not isNone)
	goutil.setActive(self._txtName.gameObject, not isNone)
end

function M:setLock(lock)
	goutil.setActive(self._goNormal, not lock)
	goutil.setActive(self._goLock, lock)
end

function M:setIcon(iconType, iconName)
	if iconType and iconName then
		IconLoader.setSprite(self._imgIcon, iconType, iconName)
		IconLoader.setSprite(self._imgIcon2, iconType, iconName)
	end
end

function M:setNum(numStr)
	self._txtNum.text = numStr
end

function M:setName(nameStr)
	self._txtName.text = nameStr
end

function M:setNameColor(colorStr)
	if not string.nilorempty(colorStr) then
		self._txtName.color = parsecolor(colorStr)
	end
end

return M
