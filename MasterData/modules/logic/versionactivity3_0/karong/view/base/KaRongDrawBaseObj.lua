-- chunkname: @modules/logic/versionactivity3_0/karong/view/base/KaRongDrawBaseObj.lua

module("modules.logic.versionactivity3_0.karong.view.base.KaRongDrawBaseObj", package.seeall)

local KaRongDrawBaseObj = class("KaRongDrawBaseObj", UserDataDispose)

function KaRongDrawBaseObj:ctor(go)
	self:__onInit()

	self.go = go
	self._image = gohelper.findChildImage(self.go, "#image_content")
end

function KaRongDrawBaseObj:onInit(mo)
	self.mo = mo
	self.isEnter = false

	gohelper.setActive(self.go, true)
	self:_setPosition()
	self:_setIcon()
end

function KaRongDrawBaseObj:onEnter()
	self.isEnter = true

	self:_setIcon()
end

function KaRongDrawBaseObj:onExit()
	self.isEnter = false

	self:_setIcon()
end

function KaRongDrawBaseObj:_setPosition()
	local anchorX, anchorY

	if self.mo.positionType == KaRongDrawEnum.PositionType.Point then
		anchorX, anchorY = KaRongDrawModel.instance:getObjectAnchor(self.mo.x, self.mo.y)
	else
		anchorX, anchorY = KaRongDrawModel.instance:getLineObjectAnchor(self.mo.x1, self.mo.y1, self.mo.x2, self.mo.y2)
	end

	recthelper.setAnchor(self.go.transform, anchorX, anchorY)
end

function KaRongDrawBaseObj:_setIcon()
	local iconUrl = self:_getIconUrl()

	if not string.nilorempty(iconUrl) then
		UISpriteSetMgr.instance:setV3a0KaRongSprite(self._image, iconUrl, true)
	end
end

function KaRongDrawBaseObj:_getIconUrl()
	if self.mo and self.mo.iconUrl then
		return self.mo.iconUrl
	end
end

function KaRongDrawBaseObj:destroy()
	gohelper.destroy(self.go)

	self.isEnter = false

	self:__onDispose()
end

return KaRongDrawBaseObj
