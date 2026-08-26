-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawCheckObj.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawCheckObj", package.seeall)

local KaRongDrawCheckObj = class("KaRongDrawCheckObj", KaRongDrawBaseObj)

function KaRongDrawCheckObj:ctor(go)
	KaRongDrawCheckObj.super.ctor(self, go)

	self._gochecked = gohelper.findChild(self.go, "#go_checked")
	self._goflag = gohelper.findChild(self.go, "#go_flag")
end

function KaRongDrawCheckObj:onInit(mo)
	KaRongDrawCheckObj.super.onInit(self, mo)
	self:setCheckIconVisible(false)
	gohelper.setActive(self._goflag, mo.objType == KaRongDrawEnum.MazeObjType.End)
end

function KaRongDrawCheckObj:onEnter()
	KaRongDrawCheckObj.super.onEnter(self)
	self:setCheckIconVisible(true)
end

function KaRongDrawCheckObj:onExit()
	KaRongDrawCheckObj.super.onExit(self)
	self:setCheckIconVisible(false)
end

function KaRongDrawCheckObj:setCheckIconVisible(isVisible)
	gohelper.setActive(self._gochecked, isVisible)
end

function KaRongDrawCheckObj:_setIcon()
	local iconUrl = self:_getIconUrl()

	if not string.nilorempty(iconUrl) then
		if self.mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint and not self.isEnter then
			iconUrl = iconUrl .. "_gray"
		end

		UISpriteSetMgr.instance:setV3a0KaRongSprite(self._image, iconUrl, true)
	end
end

return KaRongDrawCheckObj
