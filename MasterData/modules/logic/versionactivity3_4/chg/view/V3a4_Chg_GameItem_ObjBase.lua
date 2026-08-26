-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_ObjBase.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_ObjBase", package.seeall)

local V3a4_Chg_GameItem_ObjBase = class("V3a4_Chg_GameItem_ObjBase", RougeSimpleItemBase)

function V3a4_Chg_GameItem_ObjBase:ctor(...)
	V3a4_Chg_GameItem_ObjBase.super.ctor(self, ...)
end

function V3a4_Chg_GameItem_ObjBase:_editableInitView()
	V3a4_Chg_GameItem_ObjBase.super._editableInitView(self)

	if self._Image_GroupTrans then
		local v2 = self:getSpacing()
		local w = v2.x + 20
		local h = v2.y + 17

		self:setWH(w, h, self._Image_GroupTrans)
	end
end

function V3a4_Chg_GameItem_ObjBase:getSpacing(...)
	local p = self:parent()

	return p:getSpacing(...)
end

function V3a4_Chg_GameItem_ObjBase:setNum(num)
	return
end

function V3a4_Chg_GameItem_ObjBase:setIcon(name, setNativeSize)
	if setNativeSize == nil then
		setNativeSize = true
	end

	if self._Image_PropGo and self._Image_Prop then
		if string.nilorempty(name) then
			gohelper.setActive(self._Image_PropGo, false)
		else
			gohelper.setActive(self._Image_PropGo, true)
			self:baseViewContainer():setSprite(self._Image_Prop, name, setNativeSize)
		end
	end
end

function V3a4_Chg_GameItem_ObjBase:setGroup(groupNum)
	local isShowGroup = groupNum > 0

	gohelper.setActive(self._Image_Group, isShowGroup)
end

function V3a4_Chg_GameItem_ObjBase:playDeltaNumAnim(deltaNum)
	return
end

function V3a4_Chg_GameItem_ObjBase:stopDeltaNumAnim()
	return
end

function V3a4_Chg_GameItem_ObjBase:playAnim(name, cb, cbObj)
	return
end

function V3a4_Chg_GameItem_ObjBase:playIdleAnim(cb, cbObj)
	return
end

function V3a4_Chg_GameItem_ObjBase:setInvoked(bInvoked)
	return
end

return V3a4_Chg_GameItem_ObjBase
