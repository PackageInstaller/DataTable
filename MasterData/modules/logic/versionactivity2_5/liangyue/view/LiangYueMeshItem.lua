-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueMeshItem.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueMeshItem", package.seeall)

local LiangYueMeshItem = class("LiangYueMeshItem", LuaCompBase)

function LiangYueMeshItem:init(go)
	self._go = go
	self._rectTran = gohelper.findChildComponent(self._go, "", gohelper.Type_RectTransform)
	self._goEnableBg = gohelper.findChild(go, "lattice")
	self._imageEnableBg = gohelper.findChildImage(go, "lattice")
end

function LiangYueMeshItem:setActive(active)
	gohelper.setActive(self._goEnableBg, active)
end

function LiangYueMeshItem:setBgColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageEnableBg, color)
	ZProj.UGUIHelper.SetColorAlpha(self._imageEnableBg, LiangYueEnum.MeshAlpha)
end

function LiangYueMeshItem:setPos(x, y)
	recthelper.setAnchor(self._rectTran, x, y)
end

function LiangYueMeshItem:onDestroy()
	return
end

return LiangYueMeshItem
