-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_Obstacle.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_Obstacle", package.seeall)

local V3a4_Chg_GameItem_Obstacle = class("V3a4_Chg_GameItem_Obstacle", V3a4_Chg_GameItem_ObjBase)

function V3a4_Chg_GameItem_Obstacle:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameItem_Obstacle:addEvents()
	return
end

function V3a4_Chg_GameItem_Obstacle:removeEvents()
	return
end

function V3a4_Chg_GameItem_Obstacle:ctor(...)
	V3a4_Chg_GameItem_Obstacle.super.ctor(self, ...)
end

function V3a4_Chg_GameItem_Obstacle:_editableInitView()
	self._Image_Prop = gohelper.findChildImage(self.viewGO, "Image_Prop")
	self._Image_PropTrans = self._Image_Prop.transform
	self._Image_PropGo = self._Image_Prop.gameObject
	self._Image_Group = gohelper.findChild(self.viewGO, "Image_Group")
	self._Image_GroupTrans = self._Image_Group.transform

	V3a4_Chg_GameItem_Obstacle.super._editableInitView(self)
end

return V3a4_Chg_GameItem_Obstacle
