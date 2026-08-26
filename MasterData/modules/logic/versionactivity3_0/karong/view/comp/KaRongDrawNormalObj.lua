-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawNormalObj.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawNormalObj", package.seeall)

local KaRongDrawNormalObj = class("KaRongDrawNormalObj", KaRongDrawBaseObj)

function KaRongDrawNormalObj:ctor(go)
	KaRongDrawNormalObj.super.ctor(self, go)

	self._gochecked = gohelper.findChild(self.go, "#go_checked")

	gohelper.setActive(self._gochecked, false)
end

return KaRongDrawNormalObj
